# Replace sshd_config with the local copy
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://cytovale/sshd_config"

do_install_append() {
	install -m 0644 ${WORKDIR}/cytovale/sshd_config ${D}${sysconfdir}/ssh/
}
