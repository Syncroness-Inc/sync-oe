DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=setup;protocol=ssh"
SRCREV = "6a2dd18488e0a8980e1a3d1c532c50956bc2c1f6"

S = "${WORKDIR}/git/cytovale_app"

inherit setuptools3

do_install_append () {
	install -d ${D}${bindir}
	install -m 0755 console_app.py ${D}${bindir}
}
