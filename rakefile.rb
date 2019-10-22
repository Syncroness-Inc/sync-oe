CYM_BSP_VERSION = "0.2.2-dev"
PROJECT_ROOT = File.dirname(__FILE__)
RUN_SCRIPT = File.join(PROJECT_ROOT, "scripts", "sync-oe-run")
RELEASE_FOLDER=File.join(PROJECT_ROOT, "release")
LOCAL_CONF=File.join(PROJECT_ROOT, "cytovale-build", "conf", "local.conf")

DOCKER_EXECUTE_SCRIPT = File.join(PROJECT_ROOT, "docker", "sync-oe-execute")
# Defines for the cytovale image
CYTOVALE_PROJECT = "cytovale-build"
CYTOVALE_IMAGE = "angstrom-lxde-image"

def bitbake(project, image)
  cmd = "#{RUN_SCRIPT} #{project} \"bitbake #{image}\""
  sh "#{cmd}"
end

def write_host_info(release_directory)
  FileUtils.mkdir_p(release_directory)
  host_info_file = File.join(release_directory, "host_info")
  open(host_info_file, 'w') { |file| 
    file.write("*** Host OS Information ***\n\n")
    file.write(`lsb_release -a` + "\n")
    file.write("*** Docker Information ***\n\n")
    file.write(`docker version`)
  }
end

def write_docker_image_info(release_directory)
  FileUtils.mkdir_p(release_directory)
  info_file = File.join(release_directory, "docker_image_info")
  open(info_file, 'w') { |file|
    file.write("*** Docker Image OS Info ***\n\n")
    file.write(`#{DOCKER_EXECUTE_SCRIPT} "cat /etc/*release"` + "\n")
    file.write("*** Packages ***\n\n")
    file.write(`#{DOCKER_EXECUTE_SCRIPT} "apt list --installed"`)
  }
  image_file = File.join(release_directory, "sync_oe.img")
  `docker save sync-oe -o #{image_file}`
end

desc "Build the sync-oe docker image"
task :docker_image do
  Dir.chdir("docker") do
    sh "rake image"
  end
end

task :cytovale_clean => [:docker_image] do
  bitbake(CYTOVALE_PROJECT, "-c cleanall #{CYTOVALE_IMAGE}")
end

desc "Build the #{CYTOVALE_IMAGE} for the #{CYTOVALE_PROJECT} project"
task :cytovale_image => [:docker_image] do
  if File.file?("#{CYTOVALE_PROJECT}/.build_num")
    build_num = File.read("#{CYTOVALE_PROJECT}/.build_num").to_i + 1
  else
    build_num = 0
  end
  `echo #{build_num} > #{CYTOVALE_PROJECT}/.build_num`
  `echo 'CYM_BSP_BUILD_NUMBER = "#{build_num}"' > #{CYTOVALE_PROJECT}/.extras.conf`
  `echo 'CYM_BSP_VERSION = "#{CYM_BSP_VERSION}"' >> #{CYTOVALE_PROJECT}/.extras.conf`
  bitbake(CYTOVALE_PROJECT, "--postread=.extras.conf #{CYTOVALE_IMAGE}")
end

desc "Build a release package for the Cytovale project"
task :cytovale_release => [:cytovale_image] do
  build_time = Time.now.strftime("%Y-%m-%d-%H-%M-%S")
  build_date_str = Time.now.getutc.strftime("%Y%m%d")
  release_directory = File.join(RELEASE_FOLDER, CYTOVALE_PROJECT, CYTOVALE_IMAGE, CYM_BSP_VERSION, build_time)
  deploy_dir = File.join(PROJECT_ROOT, "deploy", "images", "apalis-imx6")

  build_info_directory = File.join(release_directory, "build_info")
  write_host_info(build_info_directory)
  write_docker_image_info(build_info_directory)
  
  # Copy and parse the licenses manifest
  licenses_manifest = File.join(PROJECT_ROOT, "deploy", "licenses", "apalis_imx6", "Apalis-iMX6_LXDE-Image", "license.manifest")
  licenses_list  = File.join(build_info_directory, "licenses.txt")
  license_parsing_script = File.join(PROJECT_ROOT, "scripts", "license_manifest_parser.py")
  FileUtils.cp(licenses_manifest, build_info_directory)
  `python3 "#{license_parsing_script}" "#{licenses_manifest}" "#{licenses_list}"`

  # Get our Linux binaries
  linux_directory =  File.join(release_directory, "linux")
  FileUtils.mkdir_p(linux_directory)
  linux_image = File.join(deploy_dir, "zImage")
  dtb_file = File.join(deploy_dir, "zImage-imx6q-apalis-eval.dtb")
  FileUtils.cp(linux_image, linux_directory)
  FileUtils.cp(dtb_file, linux_directory)

  # Get our Rootfs and the package manifest
  rootfs_directory = File.join(release_directory, "rootfs")
  FileUtils.mkdir_p(rootfs_directory)
  rootfs_tarball = File.join(deploy_dir, "LXDE-Image-apalis-imx6.tar.xz")
  rootfs_manifest = File.join(deploy_dir, "LXDE-Image-apalis-imx6.manifest")
  FileUtils.cp(rootfs_tarball, rootfs_directory)
  FileUtils.cp(rootfs_manifest, rootfs_directory)

  # Create the install package zip file by running the update.sh script
  release_tag = "Apalis-iMX6_LXDE-Image_2.8"
  working_dir = File.join(release_directory, ".tmp/deploy")
  update_zip = File.join(release_directory, "cym-bsp-install-package-#{CYM_BSP_VERSION}.zip")
  release_tarball = File.join(deploy_dir, "#{release_tag}b4-#{build_date_str}.tar.bz2")
  update_binaries_dir = File.join(working_dir, "tftpboot")
  update_script_dir = File.join(working_dir, release_tag+".4")

  mkdir_p working_dir
  mkdir_p update_binaries_dir
  begin
    puts "root permission is required to properly set the file permissions on the release tarball"
    `sudo tar xf "#{release_tarball}" -C "#{working_dir}"`
    `(cd "#{update_script_dir}" && ./update.sh -o '#{update_binaries_dir}')`
    `(cd "#{working_dir}"; zip -r "#{update_zip}" tftpboot)`
  ensure
    # remove the working directory
    puts "root permission is required to remove the working directory"
    `sudo rm -r "#{working_dir}"`
  end

end
