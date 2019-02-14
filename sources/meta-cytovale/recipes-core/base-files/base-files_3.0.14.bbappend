FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BASEFILESISSUEINSTALL = "do_install_cytovale_cym"

SRC_URI += "file://cytovale/issue \
	    file://cytovale/issue.net "

do_install_append () {
    echo ${MACHINE} > ${D}${sysconfdir}/hostname

    install -m 644 ${WORKDIR}/cytovale/issue*  ${D}${sysconfdir}
    if [ -n "${DISTRO_NAME}" ]; then
        echo -n "${DISTRO_NAME} " >> ${D}${sysconfdir}/issue
        echo -n "${DISTRO_NAME} " >> ${D}${sysconfdir}/issue.net
        if [ -n "${DISTRO_VERSION}" ]; then
            echo -n "${DISTRO_VERSION} " >> ${D}${sysconfdir}/issue
            echo -e "${DISTRO_VERSION} \n" >> ${D}${sysconfdir}/issue.net
        fi
        echo "- Kernel \r" >> ${D}${sysconfdir}/issue
        echo >> ${D}${sysconfdir}/issue
    fi
    echo "Version: ${CYM_BSP_VERSION} Build: ${CYM_BSP_BUILD_NUMBER}" >> ${D}${sysconfdir}/issue
    echo "Version: ${CYM_BSP_VERSION} Build: ${CYM_BSP_BUILD_NUMBER}" >> ${D}${sysconfdir}/issue.net
    echo "Application Version: ${CYM_APPLICATION_VERSION}" >> ${D}${sysconfdir}/issue
    echo "Application Version: ${CYM_APPLICATION_VERSION}" >> ${D}${sysconfdir}/issue.net

}

