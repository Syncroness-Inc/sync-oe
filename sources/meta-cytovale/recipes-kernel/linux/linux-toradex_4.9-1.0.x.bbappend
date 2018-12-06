FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex_4.9-1.0.x.bbappend:"

LOCALVERSION = "-${TDX_VER_ITEM}"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=${SRCBRANCH} \
           file://defconfig"

SRCREV = "c5f05bd68e1ad99d43e2a7a7123e0f994ed17f56"

LOCALVERSION = "-${TDX_VER_ITEM}"
