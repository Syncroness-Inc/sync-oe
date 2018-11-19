## Building with Docker Image

### Download this repo

```
git clone --recursive -b rocko git@github.com:Syncroness-Inc/sync-oe.git
```

### Install Packages

```
sudo apt-get install rake
sudo snap install docker
```

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
