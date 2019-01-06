LOCALVERSION = "-${TDX_VER_ITEM}"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=${SRCBRANCH} \
          file://defconfig "

SRCREV = "dbf9ba6a1d201b3ffc6c66a66a63e1bba77cb70d"

LOCALVERSION = "-${TDX_VER_ITEM}"

KERNEL_DEFCONFIG_apalis-imx6 ?= "arch/arm/apalis_imx6_defconfig"
