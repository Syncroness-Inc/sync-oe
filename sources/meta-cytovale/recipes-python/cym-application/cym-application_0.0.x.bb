DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=master;protocol=ssh"
SRCREV = "5568d4ab1fa8be290e82f605a11d6c205f87be24"

S = "${WORKDIR}/git/cytovale_app"

inherit setuptools3

do_install_append () {
	install -d ${D}${bindir}
	install -m 0755 tc2_console.py ${D}/home/root
	install -m 0755 tc0_console.py ${D}/home/root
}
