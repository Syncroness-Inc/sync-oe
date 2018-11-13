#!/usr/bin/env python3
#------------------------------------------------------------------------------
# Setup script for building Crc32C exstension
#
# Can be compiled by executing:
#  python setup.py build_ext --inplace
#------------------------------------------------------------------------------
from setuptools import setup
from setuptools import Extension

crc32c = Extension(
    'crc32c',
    sources=['Crc32c.c', 'wrapper.c'],
)

setup(
    name = 'crc32c',
    version = '1.0',
    description = 'CRC32C implementation',
    ext_modules = [crc32c],

)
