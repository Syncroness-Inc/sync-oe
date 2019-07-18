DESCRIPTION = "Cytovale Cytometry Module Application Software"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/syncroness-inc/cytovale-sw.git;branch=${CYM_APPLICATION_BRANCH};tag=${CYM_APPLICATION_VERSION};protocol=ssh \
		   file://purge_old_results"

S = "${WORKDIR}/git/cytovale_app"

inherit setuptools3

RDEPENDS_${PN} += "bash nvm-partition cym-app-service cronie"

do_install_append () {
	install -d ${D}/home/root/cytovale-sw
	cp -r ${WORKDIR}/git/* ${D}/home/root/cytovale-sw

	# Install our cron job to purge old results
	install -d ${D}/etc/cron.daily/
	install -m 644 ${WORKDIR}/purge_old_results ${D}/etc/cron.daily/.
}

FILES_${PN} += "/home/root/cytovale-sw /etc/cron.daily"
