SUMMARY = "Variscite MII tool"
DESCRIPTION = "A tool to read, write, and test MII interfaces on Variscite SOMs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=1232ac6a89eecd5b83db0b7f84f3c36b"

SRC_URI = "git://git@github.com/varigit/var-mii.git;protocol=ssh;branch=master"

PV = "1.0+git${SRCPV}"
SRCREV = "c9e7ffe6bff5074a47c4a5411692759441813d64"

S = "${WORKDIR}/git"

TARGET_CC_ARCH += "${LDFLAGS}"
