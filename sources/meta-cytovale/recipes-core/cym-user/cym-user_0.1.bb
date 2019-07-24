SUMMARY = "Add the user account for the cym user"
LICENSE = "CLOSED"
PR = "r1"

SRC_URI = ""

S = "${WORKDIR}"

inherit useradd

USERADD_PACKAGES = "${PN}"
USERADD_PARAM_${PN} = "-u 1200 -d /home/cym-user -m -s /bin/bash cym-user"

GROUPADD_PARAM_${PN} = "-g 880 group1"

do_install () {
    install -d -m 755 ${D}/home/cym-user

    chown -R cym-user ${D}/home/cym-user
}

FILES_${PN} = "/home/cym-user"