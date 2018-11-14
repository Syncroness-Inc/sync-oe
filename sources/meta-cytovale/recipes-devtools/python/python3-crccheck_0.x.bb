DESCRIPTION = "Cytovale Cytometry Module Application Software"
LICENSE = "CLOSED"

SRC_URI = "git://git@github.com/PseudoDesign/crc32c.git;branch=master;protocol=ssh"
SRCREV = "6a48e44ef9c35d56203b1ace855ae2767d8eeafc"

export CRC32C_SW_MODE="force"

S = "${WORKDIR}/git"

inherit setuptools3

