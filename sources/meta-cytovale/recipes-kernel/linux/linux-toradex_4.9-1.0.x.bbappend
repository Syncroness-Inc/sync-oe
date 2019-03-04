FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-4.9-1.0.x:"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=${SRCBRANCH} \
	   file://defconfig"

SRCREV = "9cb9ce2667c7c0c3ce819d495a274393389c0b78"
