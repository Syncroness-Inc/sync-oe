#!/bin/bash

# Install the packages required to build the system image 

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

dpkg --add-architecture i386
apt-get update
apt-get install g++-5-multilib
apt-get install curl dosfstools gawk g++-multilib gcc-multilib lib32z1-dev libcrypto++9v5:i386 libcrypto++-dev:i386 liblzo2-dev:i386 lzop libsdl1.2-dev libstdc++-5-dev:i386 libusb-1.0-0:i386 libusb-1.0-0-dev:i386 uuid-dev:i386 texinfo chrpath
cd /usr/lib; ln -s libcrypto++.so.9.0.0 libcryptopp.so.6

