FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:var-som = " \
	file://main.conf \
	file://audio.conf \
	file://bluetooth \
	file://obexd \
	file://obexd.conf \
	file://obex.service \
	file://bluetooth.service \
"

# Required by obexd
RDEPENDS:${PN}:append:var-som:libc-glibc = " glibc-gconv-utf-16"

DEPENDS:append:var-som = "${@bb.utils.contains('DISTRO_FEATURES','systemd','',' update-rc.d-native',d)}"

do_install:append:var-som() {
	install -d ${D}${sysconfdir}/bluetooth
	install -d ${D}${sysconfdir}/dbus-1/system.d
	install -d ${D}${sysconfdir}/profile.d
	install -m 0644 ${UNPACKDIR}/audio.conf ${D}/${sysconfdir}/bluetooth
	install -m 0644 ${UNPACKDIR}/main.conf ${D}/${sysconfdir}/bluetooth
	install -m 0644 ${UNPACKDIR}/obexd.conf ${D}${sysconfdir}/dbus-1/system.d

	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		install -d ${D}${systemd_unitdir}/system
		install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
		install -m 0644 ${UNPACKDIR}/obex.service ${D}${systemd_unitdir}/system
		install -m 0644 ${UNPACKDIR}/bluetooth.service ${D}${systemd_unitdir}/system

		ln -sf ${systemd_unitdir}/system/obex.service \
			${D}${sysconfdir}/systemd/system/multi-user.target.wants/obex.service

	else
		install -m 0755 ${UNPACKDIR}/obexd ${D}${sysconfdir}/init.d
		install -m 0755 ${UNPACKDIR}/bluetooth ${D}${sysconfdir}/init.d
		update-rc.d -r ${D} bluetooth defaults
		update-rc.d -r ${D} obexd defaults
	fi
}
