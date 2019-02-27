FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-4.9-1.0.x:"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=${SRCBRANCH} \
	   file://defconfig"

SRCREV = "77a8f770e3fcd63e15a1a42dcb11cf52bcab1f99"
