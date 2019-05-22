do_install_append() {
    ln -s /home/root/cytovale-sw/scripts/init-lowlevel.sh "${D}${sysconfdir}/"
}

FILES_${PN} += "/${sysconfdir}"