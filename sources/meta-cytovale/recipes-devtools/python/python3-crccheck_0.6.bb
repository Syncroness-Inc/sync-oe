SUMMARY = "crc32c lib for python"
HOMEPAGE = "https://github.com/ICRAR/crc32c"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
DEPENDS = "${PYTHON_PN}-cython-native ${PYTHON_PN}"
SRC_URI[sha256sum] = "5686a4e5c3a2949597316c067c49c21e06051d13de9521434480cfa24dad7e32"

PYPI_PACKAGE_EXT = "zip"

PYPI_PACKAGE = "crccheck"
inherit pypi

BBCLASSEXTEND = "native nativesdk"

inherit setuptools3

