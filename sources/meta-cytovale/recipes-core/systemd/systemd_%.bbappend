do_install_append() {
        # Create a symlink for the journal logs to nvm.  If NVM isn't mounted, this is simply dumped to RAM
        ln -s /mnt/nvm/log/journal ${D}/var/log/journal
}

CONFFILES_${PN} += "${D}/var/log/journal"