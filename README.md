# Cytovale CYM BSP

## Building the BSP

### Building with Docker Image

#### Download this repo

```
git clone --recursive -b rocko-cytovale git@github.com:Syncroness-Inc/sync-oe.git
```

#### Install Packages

```
sudo apt-get install rake
sudo snap install docker
```

#### Configure Docker

```
sudo groupadd docker 
sudo usermod -aG docker $USER
```

Log out and back in after this step

#### Build docker image

`rake docker_image`

#### Add Github SSH Keys

In order to access private github repos, you'll need to add an SSH key.  

Bring up a shell for the docker image by executing `./docker/sync-oe-shell`

Generate a new keypair by executing `ssh-keygen`. 

Get your public key by running `cat id_rsa.pub`

Add your public key to your [github account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)

Test your connection by executing `ssh -v git@github.com`

Exit the contaner by running `exit`

#### Build the release package

From the host OS command line, run

```
rake cytovale_release
```

### Building on host OS (Not Recommended)

#### Download this repo

```
git clone --recursive -b rocko git@github.com:Syncroness-Inc/sync-oe.git
```

#### Install Packages

```
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install g++-5-multilib
sudo apt-get install curl dosfstools gawk g++-multilib gcc-multilib lib32z1-dev libcrypto++9v5:i386 libcrypto++-dev:i386 liblzo2-dev:i386 lzop libsdl1.2-dev libstdc++-5-dev:i386 libusb-1.0-0:i386 libusb-1.0-0-dev:i386 uuid-dev:i386 texinfo chrpath
cd /usr/lib; sudo ln -s libcrypto++.so.9.0.0 libcryptopp.so.6
```

#### Setup Build

`BITBAKEDIR=./sources/bitbake source sources/openembedded-core/oe-init-build-env $PROJECT_NAME-build`

#### Configure Build

Modify the .conf files located at

`$PROJECT_NAME-build/conf/*.conf`

Look to your board manufacturer for a configuration for building a devboard image is generally a good starting point.


#### Build

Build the target machine by running the setup build step, then

`bitbake core-image-minimal`
or
`bitbake angstrom-lxde-image`

## Using the BSP

### Load Image via TFTP

#### Install a TFTP Server

*TODO: Describe how to do this in a VM*


#### Generate Install Media

##### Extract Installation Package

```
cd .../deploy/images/apalis-imx6
sudo tar xf Apalis-iMX6_LXDE-Image_VERSION_INFO.tar.bz2
cd Apalis-iMX6_LXDE-Image_VERSION_INFO
```

##### Generate Image Files

`./update.sh -o TFTP_SERVER_DIRECTORY`

##### Update the system image

Press any key during initial boot to bring up the uboot prompt

* Remove the SD Card
* Set Host IP
  * e.g. `setenv serverip 10.0.0.105`
* Set Client IP
  * TODO: DHCP?
  * e.g. `setenv ipaddr 10.0.0.33`
* Prepare Update
  * `run setupdate`
* Install Update
  * **Warning: This will obliterate any existing data**
  * `run update`

### Add SSH Key

#### Development

Add your public SSH key to the authorized_keys list by executing:

`cat ~/.ssh/id_rsa.pub >> .../sources/meta-cytovale/ecipes-connectivity/openssh/openssh/cytovale/authorized_keys`

## Design Description

The CytoVale CYM is based on an [OpenEmbedded Core BSP provided by Toradex](https://developer.toradex.com/knowledge-base/board-support-package/openembedded-(core)).  

### Build Config

The build configuration is located in the `.../cytovale-build/conf` directory.  `bblayers.conf` lists the meta layers used for the BSP build.  `local.conf` includes variable definitions needed by the meta layers.

### Meta Layers

The following meta-layers are used when building the CytoVale CYM BSP.  They can be found in the `.../sources` directory. 

#### meta-angstrom

Toradex uses the [Angstrom Distrobution](https://github.com/Angstrom-distribution/meta-angstrom) as their baseline system image.  These recipes extend upon the barebones distribution generated by the OpenEmbedded layers.

#### meta-openembedded / openembedded-core

A collection of baseline layers for OpenEmbedded-based distributions.

#### meta-freescale / meta-freescale-3rdparty / meta-freescale-distro

These layers are maintained by Freescale, the manufacturer of the core SoC used in the CytoVale CYM.  The recipes include low-level platform init configurations, proprietary SoC driver binaries, and OpenEmbedded machine definitions for Freescale hardware.

#### meta-toradex-bsp-common / meta-toradex-demos / meta-toradex-nxp

These layers are maintained by Toradex, the manufacturer of the SOM used in the CytoVale CYM.  The recipes extend the `meta-freescale` layers to include platform-specific configurations and prepares the machine definitions for use with the `meta-angstrom` layer.

#### meta-lxde

This layer provides recipes for the LXDE desktop environment.

#### meta-browser

This layer provides recipes for the Chromium web browser.

#### meta-qt4 / meta-qt5 / meta-qt5-extra

These layers are required by the `meta-toradex-demos` layer.  QT binaries are not installed on the CytoVale CYM.

#### meta-syncroness

The `meta-sycroness` layer includes custom recipes developed within Syncroness used to implement reusable features on a BSP.

##### recipes-core

###### init-lowlevel

This recipe creates a systemd task to run a bash script early during the init process.

###### packagegroups

This inclues a list of common packages used by Syncroness developers.

###### touchscreen-rotate

This creates a systemd task to rotate the touch screen video.

#### meta-cytovale

The `meta-cytovale` layer includes custom recipes developed specifically for the Cytovale CYM.

##### recipes-angstrom

###### angstrom-version

This recipe extends the angstrom-version recipe and appends the CytoVale BSP and Application version information.

##### recipes-connectivity

###### openssh

This recipe extends the openssh recipe.  It adds the Syncroness/Cytovale developer SSH keys located in the `authorized_keys` file to the list of approved SSH connections, and configures sshd to disable password-based connections.

##### recipes-core

###### base-files

This recipe appends version information to the `/etc/issue` file.

###### chromium-kiosk

This recipe appends the LXDE recipe.  It modifies the `autostart` file to disable the traditional desktop environment and run Chromium in kiosk mode on startup.

###### cym-app-service

This recipe creates a systemd task to start the CYM application and webserver.  The systemd task includes an application watchdog, and will reboot the system if the application becomes unresponsive.

###### images

This recipe appends the `angstrom-lxde-image` recipe to include the Cytovale packagegroups in the installation.

###### init-ifupdown

This recipe configures the network interfaces for the CYM.  The on-board ethernet adapter (eth0) is configured with a static IP of `10.0.0.2`.  The USB/Ethernet adapter (eth1) is configured to request an IP address using DHCP.

If (eth1) requires a static IP, this recipe is the correct place to configure said IP.

###### init-lowlevel

This recipe appends the Syncroness-layer `init-lowlevel` recipe to run the CYM application's "init_lowlevel.sh" file on startup.

###### nvm-partition

This recipe creates a systemd task to initialize and mount the NVM partition.

###### packagegroups

This recipe is a list of all external packages required by the CYM system.

###### update-script

This recipe compiles and installs the `boot.scr` script.  This script is used to update the CYM BSP via uboot.

###### usb-tty

This recipe contains udev rules for the CYM's USB peripreals.  This results in the USB-TTY device nodes being mounted at a consistent location, such as `/dev/tty_pressure`.

##### recipes-devtools

This layer contains recipes for Python packages required by the CYM BSP.  Each Python package pulled from [PyPI](https://pypi.org) requires a unique OpenEmbedded recipe for installation.  These recipes simply point to the releavent PyPI package and uses existing OpenEmbedded tools to install them.

##### recipes-graphics

###### xf86-input-evdev

This recipe appends the [xorg driver](https://wiki.archlinux.org/index.php/Xorg) to rotate the touchscreen's touch data input.

##### recipes-kernel

This recipe changes the Linux source code repository to one controlled by Syncroness.  The baseline of this repository is the Linux kernel provided by Toradex

##### recipes-lxde

These recipes append LXDE to disable the mouse cursor.

##### recipes-python

This recipe installs the CYM Application using the tag provided in the `local.conf` file.