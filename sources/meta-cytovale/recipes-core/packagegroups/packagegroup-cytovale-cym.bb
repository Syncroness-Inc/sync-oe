SUMMARY = "Packages required to run the Cytovale Cytometry Module"
PR = "r1"

inherit packagegroup

RDEPENDS_${PN} = " cym-application \
                   python3 \
                   python3-pyyaml \
                   python3-pyserial \
                   python3-pycrc \
                   python3-python-statemachine \
                   python3-smbus2 \
                   python3-modbus-tk \
                   python3-numpy \
		   python3-matplotlib \
                   python3-django \
                   python3-console-menu \
                   python3-opencv \
                   python3-cobs \
                   python3-crc8 \
                   python3-crccheck \
                   python3-six \
                   python3-spidev \
		   usb-tty \
                   openssh \
                   nano \
                   vim \
                   init-ifupdown \
"
