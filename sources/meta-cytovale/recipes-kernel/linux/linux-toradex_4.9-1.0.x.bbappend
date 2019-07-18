FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-4.9-1.0.x:"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=${SRCBRANCH} \
	   file://defconfig"

SRCREV = "d3b793552001189eb14a0d6808b32e30be744ee9"
