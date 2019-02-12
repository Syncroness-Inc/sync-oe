# Building the BSP

## Building with Docker Image

### Download this repo

```
git clone --recursive -b rocko-cytovale git@github.com:Syncroness-Inc/sync-oe.git
```

### Install Packages

```
sudo apt-get install rake
sudo snap install docker
```

### Configure Docker

```
sudo groupadd docker 
sudo usermod -aG docker $USER
```

Log out and back in after this step

### Build docker image

`rake docker_image`

### Add Github SSH Keys

In order to access private github repos, you'll need to add an SSH key.  

Bring up a shell for the docker image by executing `./docker/sync-oe-shell`

Generate a new keypair by executing `ssh-keygen`. 

Get your public key by running `cat id_rsa.pub`

Add your public key to your [github account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)

Test your connection by executing `ssh -v git@github.com`

### Build the release package

```
rake cytovale_release
```

## Building on host OS (Not Recommended)

### Download this repo

```
git clone --recursive -b rocko git@github.com:Syncroness-Inc/sync-oe.git
```

### Install Packages

```
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install g++-5-multilib
sudo apt-get install curl dosfstools gawk g++-multilib gcc-multilib lib32z1-dev libcrypto++9v5:i386 libcrypto++-dev:i386 liblzo2-dev:i386 lzop libsdl1.2-dev libstdc++-5-dev:i386 libusb-1.0-0:i386 libusb-1.0-0-dev:i386 uuid-dev:i386 texinfo chrpath
cd /usr/lib; sudo ln -s libcrypto++.so.9.0.0 libcryptopp.so.6
```

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

# Using the BSP

## Load Image via TFTP

### Install a TFTP Server

*TODO: Describe how to do this in a VM*


### Generate Install Media

#### Extract Installation Package

```
cd .../deploy/images/apalis-imx6
sudo tar xf Apalis-iMX6_LXDE-Image_VERSION_INFO.tar.bz2
cd Apalis-iMX6_LXDE-Image_VERSION_INFO
```

#### Generate Image Files

`./update.sh -o TFTP_SERVER_DIRECTORY`

#### Update the system image

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

## Add SSH Key

### Development

Add your public SSH key to the authorized_keys list by executing:

`cat ~/.ssh/id_rsa.pub >> .../sources/meta-cytovale/ecipes-connectivity/openssh/openssh/cytovale/authorized_keys`

### Production

TBD
