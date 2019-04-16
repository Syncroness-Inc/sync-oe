DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=hflip;protocol=ssh"

SRCREV = "e3f1af7bc19ac95fd94f973b628cccef6864fc0a"

S = "${WORKDIR}/git/cytovale_app"

inherit setuptools3

RDEPENDS_${PN} += "bash cym-webserver nvm-partition cym-app-startup"

do_install_append () {
	install -d ${D}/home/root/cytovale-sw
	cp -r ${WORKDIR}/git/* ${D}/home/root/cytovale-sw
}

FILES_${PN} += "/home/root/cytovale-sw "
