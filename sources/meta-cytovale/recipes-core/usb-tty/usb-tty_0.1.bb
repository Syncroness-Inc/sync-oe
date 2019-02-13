DESCRIPTION = "Enumerate the ttyUSB devices consistently"
LICENSE = "MIT"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += "file://99-usb-serial.rules "

RDEPENDS_${PN} += "bash udev "

do_install() {
	install -d ${D}${sysconfdir}/udev/rules.d
        install -m 0644 ${WORKDIR}/99-usb-serial.rules ${D}${sysconfdir}/udev/rules.d
}

CONFFILES_${PN} += "${sysconfdir}/udev/rules.d/99-usb-serial.rules "

