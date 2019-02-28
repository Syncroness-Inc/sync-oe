FILESEXTRAPATHS_prepend := "${THISDIR}/linux-toradex-4.9-1.0.x:"

SRC_URI = "git://github.com/Syncroness-Inc/linux-toradex-imx.git;protocol=git;branch=gpt \
	   file://defconfig"

SRCREV = "ce8cbe9502e897409c53cefee7c7161b7aee6621"
