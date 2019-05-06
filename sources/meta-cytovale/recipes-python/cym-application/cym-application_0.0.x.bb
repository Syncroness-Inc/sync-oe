DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=tc5_staging;protocol=ssh"

SRCREV = "71e552a73f5ca3774266aad3211dfa7c63b9033b"

S = "${WORKDIR}/git/cytovale_app"

inherit setuptools3

RDEPENDS_${PN} += "bash cym-webserver nvm-partition cym-app-startup"

do_install_append () {
	install -d ${D}/home/root/cytovale-sw
	cp -r ${WORKDIR}/git/* ${D}/home/root/cytovale-sw
}

FILES_${PN} += "/home/root/cytovale-sw "
