# Replace use the network interfaces script with the one in .../files/cytovale/interfaces
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://cytovale/interfaces "

do_install_append() {
	install -m 0644 ${WORKDIR}/cytovale/interfaces ${D}${sysconfdir}/network/interfaces
	echo "#!/bin/sh -e" > ${D}${sysconfdir}/rc.local
	echo "ifup eth0" >> ${D}${sysconfdir}/rc.local
	chmod +x ${D}${sysconfdir}/rc.local
}

CONFFILES_${PN} += "${sysconfdir}/network/interfaces \
		    		${sysconfdir}/rc.local "
