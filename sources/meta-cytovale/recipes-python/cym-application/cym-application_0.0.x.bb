DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=master;protocol=ssh"
SRCREV = "4864f202f7c98a7a045f45069281ce942186eed6"

S = "${WORKDIR}/git/cytovale_app"

inherit setuptools3

do_install_append () {
	install -d ${D}${bindir}
	install -m 0755 console_app.py ${D}${bindir}
}
