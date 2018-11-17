PROJECT_ROOT = File.dirname(__FILE__)
RUN_SCRIPT = File.join(PROJECT_ROOT, "scripts", "sync-oe-run")

# Defines for the cytovale image
CYTOVALE_PROJECT = "cytovale-build"
CYTOVALE_IMAGE = "angstrom-lxde-image"

def bitbake(project, image)
  cmd = "#{RUN_SCRIPT} #{project} \"bitbake #{image}\""
  sh "#{cmd}"
end

desc "Build the #{CYTOVALE_IMAGE} for the #{CYTOVALE_PROJECT} project"
task :cytovale_image do
  bitbake(CYTOVALE_PROJECT, CYTOVALE_IMAGE)
end

task :cytovale_release => [:cytovale_image] do

end
