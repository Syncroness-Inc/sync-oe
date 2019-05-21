inherit systemd
SUMMARY = "Install a service to run an early hardware init script"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI = "file://${PN}.sh"
SRC_URI += "file://${PN}.service"

S = "${WORKDIR}"

SYSTEMD_SERVICE_${PN} = "${PN}.service"

LOWLEVEL_INIT_SCRIPT = "/etc/${PN}.sh"
LOWLEVEL_INIT_LOCATION ?= "/etc/${PN}.sh"

# Install the 'envsubst' package
DEPENDS = "gettext-native"

do_configure() {
	# Update the "LOWLEVEL_INIT_LOCATION" variable in the service script
	envsubst < "${WORKDIR}/${PN}.service" > "${WORKDIR}/${PN}.service.tmp"
	mv "${WORKDIR}/${PN}.service.tmp" "${WORKDIR}/${PN}.service"
}

do_install() {
	# Install the service description
	install -d "${D}${sysconfdir}/systemd/system"
	install -m 0644 "${WORKDIR}/${PN}.service" "${D}${sysconfdir}/systemd/system"

	# Install the default init script, if needed
	if [ "$LOWLEVEL_INIT_SCRIPT" == "$LOWLEVEL_INIT_LOCATION" ]; then
		install -m 0755 "${WORKDIR}/${PN}.sh" "${D}${sysconfdir}/"
	fi
}

#Pack the path
FILES_${PN} += "/home/root"
FILES_${PN} += "${sysconfdir}/systemd/system"

REQUIRED_DISTRO_FEATURES= "systemd"
