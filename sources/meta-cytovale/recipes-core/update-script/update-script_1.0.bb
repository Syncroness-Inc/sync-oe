SUMMARY = "Installs the update boot script onto the root filesystem"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "file://update.cmd"

S = "${WORKDIR}"

DEPENDS = "u-boot-mkimage-native"

do_compile() {
	mkimage -C none -A arm -T script -d ${WORKDIR}/update.cmd ${WORKDIR}/boot.scr
}

do_install() {
        install -d ${D}/boot
        install -m 0755 ${WORKDIR}/boot.scr ${D}/boot/boot.scr
}

#Pack the path
FILES_${PN} += "/boot"
