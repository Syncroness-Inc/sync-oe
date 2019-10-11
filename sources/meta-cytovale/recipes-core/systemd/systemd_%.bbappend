do_install_append() {
        # Create a symlink for the journal logs to nvm.  If NVM isn't mounted, this is simply dumped to RAM
        rm -rf ${D}/var/log/journal
        ln -s /mnt/nvm/log/journal ${D}/var/log/journal
}

FILES_${PN} += "/var/log/journal"