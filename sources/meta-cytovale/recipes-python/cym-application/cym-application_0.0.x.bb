DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=setup;protocol=ssh"
SRCREV = "8357a4bf27054ac27f3c0ebd2ad7590ec0add208"

S = "${WORKDIR}/git/cytovale_app"

#TODO: Create a setup file
inherit setuptools

do_install_append () {
	install -d ${D}${bindir}
	install -m 0755 console_app.py ${D}${bindir}
}
