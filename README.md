### Setup Build

`BITBAKEDIR=./sources/bitbake source sources/openembedded-core/oe-init-build-env $PROJECT_NAME-build`

### Configure Build

Modify the .conf files located at

`$PROJECT_NAME-build/conf/*.conf`

Look to your board manufacturer for a configuration for building a devboard image is generally a good starting point.


### Build

Build the target machine by running the setup build step, then

`bitbake core-image-minimal`
or
`bitbake angstrom-lxde-image`
