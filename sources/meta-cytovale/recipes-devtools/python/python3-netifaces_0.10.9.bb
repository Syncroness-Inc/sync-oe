SUMMARY = "netifaces lib for python"
HOMEPAGE = "https://github.com/al45tair/netifaces"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
DEPENDS = "${PYTHON_PN}-cython-native ${PYTHON_PN}"
SRC_URI[sha256sum] = "2dee9ffdd16292878336a58d04a20f0ffe95555465fee7c9bd23b3490ef2abf3"

PYPI_PACKAGE_EXT = "tar.gz"

PYPI_PACKAGE = "netifaces"
inherit pypi

BBCLASSEXTEND = "native nativesdk"

inherit setuptools3

