DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;tag=${CYM_APPLICATION_BRANCH};protocol=ssh"

S = "${WORKDIR}/git/cytovale_app"

inherit setuptools3

RDEPENDS_${PN} += "bash nvm-partition cym-webserver "

do_install_append () {
	install -d ${D}/home/root/cytovale-sw
	cp -r ${WORKDIR}/git/* ${D}/home/root/cytovale-sw
}

FILES_${PN} += "/home/root/cytovale-sw "
