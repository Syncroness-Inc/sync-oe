FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-4.9-1.0.x:"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=${SRCBRANCH} \
	   file://defconfig"

SRCREV = "dbf9ba6a1d201b3ffc6c66a66a63e1bba77cb70d"
