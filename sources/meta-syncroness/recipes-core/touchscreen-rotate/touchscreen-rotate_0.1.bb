inherit systemd
SUMMARY = "Install a service to rotate a touchscreen"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "file://touchscreen-rotate.sh"
SRC_URI += "file://touchscreen-rotate.service"

S = "${WORKDIR}"

SYSTEMD_SERVICE_${PN} = "touchscreen-rotate.service"

do_install() {
	install -d ${D}/home/root
	echo "ORIENTATION='${TOUCHSCREEN_ORIENTATION}'" > ${WORKDIR}/tmp-rotate.sh
	echo "TOUCHPAD='${TOUCHPAD_NAME}'" >> ${WORKDIR}/tmp-rotate.sh
	echo "TOUCHSCREEN='${TOUCHSCREEN_NAME}'" >> ${WORKDIR}/tmp-rotate.sh
	cat ${WORKDIR}/touchscreen-rotate.sh >> ${WORKDIR}/tmp-rotate.sh
	install -m 0755 ${WORKDIR}/tmp-rotate.sh ${D}/home/root/touchscreen-rotate.sh

	install -d ${D}${sysconfdir}/systemd/system
	install -m 0644 ${WORKDIR}/touchscreen-rotate.service ${D}${sysconfdir}/systemd/system
}

#Pack the path
FILES_${PN} += "/home/root"
FILES_${PN} += "${sysconfdir}/systemd/system"

REQUIRED_DISTRO_FEATURES= "systemd"
