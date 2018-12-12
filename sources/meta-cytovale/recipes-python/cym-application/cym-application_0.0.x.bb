DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=master;protocol=ssh"
SRCREV = "9e84734f7e418efdf59facdf8c33c1d5eba86548"

S = "${WORKDIR}/git/cytovale_app"

inherit setuptools3

do_install_append () {
	install -d ${D}${bindir}
	install -m 0755 motion_demo.py ${D}${bindir}
}
