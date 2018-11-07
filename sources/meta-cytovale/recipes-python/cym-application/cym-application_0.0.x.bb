DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=master;protocol=ssh"
SRCREV = "fd327689ce1ca7ba6c58169066999e903d6db5c2"

S = "${WORKDIR}/git/cytovale_app"

#TODO: Create a setup file
inherit setuptools

do_install_append () {
	install -d ${D}${bindir}
	install -m 0755 console_app.py ${D}${bindir}
}
