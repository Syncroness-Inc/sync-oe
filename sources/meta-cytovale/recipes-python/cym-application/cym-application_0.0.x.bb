DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=setup;protocol=ssh"
SRCREV = "d0dd4bb3a87448fcde431b4e97b9e41751b9f388"

S = "${WORKDIR}/git/cytovale_app"

inherit setuptools3

do_install_append () {
	install -d ${D}${bindir}
	install -m 0755 console_app.py ${D}${bindir}
}
