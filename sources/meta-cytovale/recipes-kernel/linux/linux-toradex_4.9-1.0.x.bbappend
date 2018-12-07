FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex_4.9-1.0.x.bbappend:"

LOCALVERSION = "-${TDX_VER_ITEM}"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=${SRCBRANCH} \
           file://defconfig"

SRCREV = "098224fecebf278d154c35ab8f3c4430ab17d5c0"

LOCALVERSION = "-${TDX_VER_ITEM}"
