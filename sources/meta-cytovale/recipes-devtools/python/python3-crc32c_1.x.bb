DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/PseudoDesign/crc32c.git;branch=master;protocol=ssh"
SRCREV = "8e8e6c6cb0cefa9b9c44f6507962a0d93c9dbeef"

export CRC32C_SW_MODE="force"

S = "${WORKDIR}/git"

inherit setuptools3

