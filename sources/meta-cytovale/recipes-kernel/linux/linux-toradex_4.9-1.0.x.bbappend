FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-4.9-1.0.x:"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=${SRCBRANCH} \
	   file://defconfig"

SRCREV = "452c4547fc107a0e5a73bad3add9ec65ee83daa1"
