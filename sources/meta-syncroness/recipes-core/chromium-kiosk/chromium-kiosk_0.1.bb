DESCRIPTION = "Chromium Kiosk startup script LXDE"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://autostart"

RDEPENDS_${PN} += "packagegroup-lxde-base chromium-x11"

do_install() {
	install -d ${D}${sysconfdir}/xdg/lxsession/LXDE
        install -m 0644 ${WORKDIR}/autostart ${D}${sysconfdir}/xdg/lxsession/LXDE
}

FILES_${PN} += "${sysconfdir}/xdg/lxsession/LXDE"
