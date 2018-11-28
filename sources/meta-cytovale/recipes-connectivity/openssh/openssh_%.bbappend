# Replace sshd_config with the local copy and install project's public keys
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://cytovale/sshd_config \
            file://cytovale/authorized_keys "

USER = "root"

do_install_append() {
	install -m 0644 ${WORKDIR}/cytovale/sshd_config ${D}${sysconfdir}/ssh/
        install -d ${D}/home/${USER}/.ssh/
        install -m 0755 ${WORKDIR}/cytovale/authorized_keys ${D}/home/${USER}/.ssh
}

FILES_${PN}-ssh += "/home/${USER}/.ssh/authorized_keys"
