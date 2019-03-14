SUMMARY = "Installs and starts the cym webserver service"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "file://cym-webserver.sh"
SRC_URI += "file://cym-webserver.service"

S = "${WORKDIR}"

SYSTEMD_SERVICE_${PN} = "cym-webserver.service"

do_install() {
             install -d ${D}/home/root
             install -m 0755 ${WORKDIR}/cym-webserver.sh ${D}/home/root

             install -d ${D}{systemd_system_unitdir}
             install -m 0644 ${WORKDIR}/cym-webserver.service ${D}{systemd_system_unitdir}
}

#Pack the path
FILES_${PN} += "/home/root"
FILES_${PN} += "${systemd_system_unitdir}"

REQUIRED_DISTRO_FEATURES= "systemd"
