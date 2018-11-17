PROJECT_ROOT = File.dirname(__FILE__)
RUN_SCRIPT = File.join(PROJECT_ROOT, "scripts", "sync-oe-run")

# Defines for the cytovale image
CYTOVALE_PROJECT = "cytovale-build"
CYTOVALE_IMAGE = "angstrom-image-lxde"

def bitbake(project, image)
  sh "#{RUN_SCRIPT} #{project} bitbake #{image}"
end

task :cytovale_image do
  bitbake(CYTOVALE_PROJECT, CYTOVALE_IMAGE)
end

task :cytovale_release => [:cytovale_image] do

end
