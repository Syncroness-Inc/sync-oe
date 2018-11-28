FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex_4.9-1.0.x.bbappend:"

LOCALVERSION = "-${TDX_VER_ITEM}"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=${SRCBRANCH} \
           file://defconfig"

SRCREV = "806144f1b6e9bf073584af9fb314e75ed88b9b2b"

LOCALVERSION = "-${TDX_VER_ITEM}"
