# Replace use the network interfaces script with the one in .../files/cytovale/interfaces
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://cytovale/interfaces "

do_install_append() {
	install -m 0644 ${WORKDIR}/cytovale/interfaces ${D}${sysconfdir}/network/interfaces
}

CONFFILES_${PN} += "${sysconfdir}/network/interfaces"
