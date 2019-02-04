do_install_append() {
        echo "VERSION=\"${DISTRO_VERSION}\"" >> ${D}${sysconfdir}/os-release
	echo "CYM_BSP_VERSION=\"${CYM_BSP_VERSION}\"" >> ${D}${sysconfdir}/os-release
        echo "CYM_BSP_BUILD_NUMBER=\"${CYM_BSP_BUILD_NUMBER}\"" >> ${D}${sysconfdir}/os-release
        echo "CYM_APPLICATION_VERSION=\"${CYM_APPLICATION_VERIONS}\"" >> ${D}${sysconfdir}/os-release
        echo "CYM_APPLICATION_BUILD_NUMBER=\"${CYM_APPLICATION_BUILD_NUMBER}\"" >> ${D}${sysconfdir}/os-release
}

