DESCRIPTION = "Service scripts for CYM applications"
LICENSE = "MIT"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += "file://cym-application.service \
	    file://cym-browser.service \
	    file://cym-gui.service "

RDEPENDS_${PN} += "systemd "

do_install() {
	install -d ${D}${sysconfdir}/systemd/system
        install -m 0644 ${WORKDIR}/cym-application.service ${D}${sysconfdir}/systemd/system
	install -m 0644 ${WORKDIR}/cym-browser.service ${D}${sysconfdir}/systemd/system
	install -m 0644 ${WORKDIR}/cym-gui.service ${D}${sysconfdir}/systemd/system
}

CONFFILES_${PN} += "${sysconfdir}/systemd/system/cym-application.service \
		    ${sysconfdir}/systemd/system/cym-browser.service \
		    ${sysconfdir}/systemd/system/cym-gui.service "

