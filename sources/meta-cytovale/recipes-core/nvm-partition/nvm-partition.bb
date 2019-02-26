SUMMARY = "Map the NVM partition for the Cytovale CYM"
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
LICENSE = "CLOSED"

SRC_URI = "file://nvm_partition "

RDEPENDS_${PN} += "e2fsprogs " 

do_install() {
	install -d ${D}${sysconfdir}/init.d/
	install ${WORKDIR}/nvm_partition ${D}${sysconfdir}/init.d/
}

CONFFILES_${PN} += "${sysconfdir}/init.d/nvm_partition "
