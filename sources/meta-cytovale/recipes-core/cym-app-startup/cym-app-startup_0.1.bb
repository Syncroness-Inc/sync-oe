inherit systemd
SUMMARY = "Installs and starts the cym application service"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "file://cym-app-startup.sh"
SRC_URI += "file://cym-app-startup.service"

S = "${WORKDIR}"

SYSTEMD_SERVICE_${PN} = "cym-app-startup.service"

do_install() {
             install -d ${D}/home/root
             install -m 0755 ${WORKDIR}/cym-app-startup.sh ${D}/home/root

             install -d ${D}${sysconfdir}/systemd/system
             install -m 0644 ${WORKDIR}/cym-app-startup.service ${D}${sysconfdir}/systemd/system
}

#Pack the path
FILES_${PN} += "/home/root"
FILES_${PN} += "${sysconfdir}/systemd/system"

REQUIRED_DISTRO_FEATURES= "systemd"
