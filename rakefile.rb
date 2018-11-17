PROJECT_ROOT = File.dirname(__FILE__)
RUN_SCRIPT = File.join(PROJECT_ROOT, "scripts", "sync-oe-run")
RELEASE_FOLDER=File.join(PROJECT_ROOT, "release")

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

desc "Build the #{CYTOVALE_IMAGE} for the #{CYTOVALE_PROJECT} project"
task :cytovale_image do
  bitbake(CYTOVALE_PROJECT, CYTOVALE_IMAGE)
end

desc "Build a release package for the Cytovale project"
task :cytovale_release => [] do
  build_time = Time.now.strftime("%Y-%m-%d-%H-%M-%S")
  release_directory = File.join(RELEASE_FOLDER, CYTOVALE_PROJECT, CYTOVALE_IMAGE, build_time)
  write_host_info(release_directory)
  write_docker_image_info(release_directory)
  # TODO: This will probably be cytovale unique
  # write_release_image_info(release_directory, CYTOVALE_PROJECT, CYTOVALE_IMAGE)
end
