DESCRIPTION = "Chromium Kiosk startup script LXDE"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"


SRC_URI += "file://cytovale/autostart"

RDEPENDS_${PN} += "chromium-x11"

do_install_append() {
	install -d ${D}${sysconfdir}/xdg/lxsession/LXDE
        install -m 0644 ${WORKDIR}/cytovale/autostart ${D}${sysconfdir}/xdg/lxsession/LXDE
}

FILES_${PN} += "${sysconfdir}/xdg/lxsession/LXDE"
