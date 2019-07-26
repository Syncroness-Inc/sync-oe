SUMMARY = "django cors headers middleware plugin"
HOMEPAGE = "https://github.com/ottoyiu/django-cors-headers"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
DEPENDS = "${PYTHON_PN}-cython-native ${PYTHON_PN}"
SRC_URI[sha256sum] = "ebf3e2cf25aa6993b959a8e6a87828ebb3c8fe5bc3ec4a2d6e65f3b8d9b4212c"

PYPI_PACKAGE_EXT = "tar.gz"

PYPI_PACKAGE = "django-cors-headers"
inherit pypi

BBCLASSEXTEND = "native nativesdk"

inherit setuptools3

