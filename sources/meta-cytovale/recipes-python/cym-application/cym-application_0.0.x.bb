DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=gui-integration-april;protocol=ssh"

SRCREV = "2a64993c60bc9d8a6924bf64c57f445df3f902b6"

S = "${WORKDIR}/git/cytovale_app"

inherit setuptools3

RDEPENDS_${PN} += "bash cym-webserver nvm-partition cym-app-startup"

do_install_append () {
	install -d ${D}/home/root/cytovale-sw
	cp -r ${WORKDIR}/git/* ${D}/home/root/cytovale-sw
}

FILES_${PN} += "/home/root/cytovale-sw "
