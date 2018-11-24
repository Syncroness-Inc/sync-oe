FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex_4.9-1.0.x.bbappend:"

LOCALVERSION = "-${TDX_VER_ITEM}"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=${SRCBRANCH} \
           file://defconfig"

SRCREV = "c260679475e51ceb4ee2f851a90cb757a5ef9f26"

LOCALVERSION = "-${TDX_VER_ITEM}"
