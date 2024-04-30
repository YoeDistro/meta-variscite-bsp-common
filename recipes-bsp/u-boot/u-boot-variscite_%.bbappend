FILESEXTRAPATHS:prepend := "${THISDIR}/u-boot-splash:"
SRC_URI:append = " \ 
	file://splash.bmp \
"

RPROVIDES:${PN}-splash += "u-boot-splash"
PACKAGE_BEFORE_PN += " ${PN}-splash"
FILES:${PN}-splash = "/boot/splash.bmp"

do_install:append () {
	install -d ${D}/boot
	install -m 644 ${WORKDIR}/splash.bmp ${D}/boot/splash.bmp
}
