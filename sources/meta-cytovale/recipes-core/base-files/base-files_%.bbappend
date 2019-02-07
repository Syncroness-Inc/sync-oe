FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/cytovale:"

BASEFILESISSUEINSTALL = "do_install_cytovale_cym"

do_install_cytovale_cym () {
    echo ${MACHINE} > ${D}${sysconfdir}/hostname

    install -m 644 ${WORKDIR}/cytovale/issue*  ${D}${sysconfdir}
        if [ -n "${DISTRO_NAME}" ]; then
        echo -n "${DISTRO_NAME} " >> ${D}${sysconfdir}/cytovale/issue
        echo -n "${DISTRO_NAME} " >> ${D}${sysconfdir}/cytovale/issue.net
        if [ -n "${DISTRO_VERSION}" ]; then
            echo -n "${DISTRO_VERSION} " >> ${D}${sysconfdir}/cytovale/issue
            echo -e "${DISTRO_VERSION} \n" >> ${D}${sysconfdir}/cytovale/issue.net
        fi
        echo "- Kernel \r" >> ${D}${sysconfdir}/issue
        echo >> ${D}${sysconfdir}/issue
    fi
}

