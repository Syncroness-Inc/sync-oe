do_install_append() {
    rm "${D}${sysconfdir}/init-lowlevel.sh"
    ln -s /home/root/cytovale-sw/scripts/init-lowlevel.sh "${D}${sysconfdir}/init-lowlevel.sh"
}
