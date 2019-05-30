inherit systemd
SUMMARY = "Installs and starts the cym application service"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI+= "file://cym-app.service"

S = "${WORKDIR}"

python () {
    if d.getVar("RUN_CYM_ON_STARTUP", True):
        d.setVar("SYSTEMD_SERVICE_cym-app-service", "cym-app.service")
}


do_install() {
             install -d ${D}${sysconfdir}/systemd/system
             install -m 0644 ${WORKDIR}/cym-app.service ${D}${sysconfdir}/systemd/system
}

#Pack the path
FILES_${PN} += "${sysconfdir}/systemd/system"

REQUIRED_DISTRO_FEATURES= "systemd"
