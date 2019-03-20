inherit systemd
SUMMARY = "Mount mmcblk0p3 at /mnt/nvm"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "file://nvm-partition.sh"
SRC_URI += "file://nvm-partition.service"

S = "${WORKDIR}"

RDEPENDS_${PN} += "e2fsprogs " 

SYSTEMD_SERVICE_${PN} = "nvm-partition.service"

do_install() {
             install -d ${D}/home/root
             install -m 0755 ${WORKDIR}/nvm-partition.sh ${D}/home/root

             install -d ${D}${sysconfdir}/systemd/system
             install -m 0644 ${WORKDIR}/nvm-partition.service ${D}${sysconfdir}/systemd/system
}

#Pack the path
FILES_${PN} += "/home/root"
FILES_${PN} += "${sysconfdir}/systemd/system"

REQUIRED_DISTRO_FEATURES= "systemd"
