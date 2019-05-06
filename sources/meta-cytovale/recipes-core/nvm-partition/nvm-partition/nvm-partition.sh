#!/bin/sh
#
# Initialize and mount the NVM partition

MOUNTPOINT="/mnt/nvm"
NODE="/dev/mmcblk0p3"

# Rotate the screen before anything else
echo 1 >> /sys/class/graphics/fb0/rotate

mkdir -p ${MOUNTPOINT}
umount ${MOUNTPOINT}
mount ${NODE} ${MOUNTPOINT}
if [ $? -eq 0 ]; then
	echo "Successfully mounted existing NVM Partition at ${MOUNTPOINT}"
else
	mkfs.ext4 -q ${NODE}
	if [ $? -ne 0 ]; then
		echo "Error occured when creating NVM partition"
	fi
	mount ${NODE} ${MOUNTPOINT}
	if [ $? -eq 0 ]; then
		echo "Successfully mounted new NVM Partition at ${MOUNTPOINT}"
	else
		echo "ERROR: Unable to mount NVM partition ${NODE} to ${MOUNTPOINT}"
	fi
fi

