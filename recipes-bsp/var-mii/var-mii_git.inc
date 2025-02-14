SUMMARY = "Variscite MII tool"
DESCRIPTION = "A tool to read, write, and test MII interfaces on Variscite SOMs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=1232ac6a89eecd5b83db0b7f84f3c36b"

SRC_URI = "git://github.com/varigit/var-mii;protocol=https;branch=master"

PV = "1.0+git${SRCPV}"
SRCREV = "3a40372691dcf51971e9188e1486e3a7a4e2a889"

S = "${WORKDIR}/git"

TARGET_CC_ARCH += "${LDFLAGS}"
