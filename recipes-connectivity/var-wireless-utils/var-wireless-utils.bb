DESCRIPTION = "Variscite startup scripts for use with Variscite wireless modules"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

DEPENDS += "${@bb.utils.contains('DISTRO_FEATURES','systemd','','update-rc.d-native',d)}"

SRC_URI = " \
	file://variscite-wifi \
	file://variscite-wifi.service \
	file://variscite-bt \
	file://variscite-bt.service \
	file://variscite-ot \
	file://variscite-ot-client \
	file://variscite-ot-server \
	file://variscite-ot.service \
	file://variscite-wireless \
"

FILES:${PN} = " \ 
	${sysconfdir}/wifi/*  \
	${sysconfdir}/bluetooth/*  \
	${sysconfdir}/openthread/*  \
	${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${systemd_unitdir}/system/* ${sysconfdir}/systemd/system/multi-user.target.wants/*', \
			'${sysconfdir}/init.d ${sysconfdir}/rcS.d ${sysconfdir}/rc2.d ${sysconfdir}/rc3.d ${sysconfdir}/rc4.d ${sysconfdir}/rc5.d', d)} \
"

RDEPENDS:${PN} = "base-files"

S = "${WORKDIR}"

do_install() {
	install -d ${D}${sysconfdir}/wifi
	install -m 0755 ${WORKDIR}/variscite-wifi ${D}/${sysconfdir}/wifi
	install -m 0644 ${WORKDIR}/variscite-wireless ${D}/${sysconfdir}/wifi

	install -d ${D}${sysconfdir}/bluetooth
	install -m 0755 ${WORKDIR}/variscite-bt ${D}/${sysconfdir}/bluetooth

	install -d ${D}${sysconfdir}/openthread
	install -m 0755 ${WORKDIR}/variscite-ot ${D}/${sysconfdir}/openthread
	install -m 0755 ${WORKDIR}/variscite-ot-server ${D}/${sysconfdir}/openthread
	install -m 0755 ${WORKDIR}/variscite-ot-client ${D}/${sysconfdir}/openthread

	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		install -d ${D}${systemd_unitdir}/system
		install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants
		install -m 0644 ${WORKDIR}/variscite-wifi.service ${D}/${systemd_unitdir}/system
		install -m 0644 ${WORKDIR}/variscite-bt.service ${D}/${systemd_unitdir}/system
		install -m 0644 ${WORKDIR}/variscite-ot.service ${D}/${systemd_unitdir}/system
 
		ln -sf ${systemd_unitdir}/system/variscite-wifi.service \
			${D}${sysconfdir}/systemd/system/multi-user.target.wants/variscite-wifi.service
		ln -sf ${systemd_unitdir}/system/variscite-bt.service \
			${D}${sysconfdir}/systemd/system/multi-user.target.wants/variscite-bt.service
		ln -sf ${systemd_unitdir}/system/variscite-ot.service \
			${D}${sysconfdir}/systemd/system/multi-user.target.wants/variscite-ot.service
		if ${@bb.utils.contains('PREFERRED_CONNECTIVITY_MANAGER','systemd-networkd','true','false',d)}; then
			ln -sf ${systemd_unitdir}/system/wpa_supplicant@.service \
				${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service
		fi
	else
		install -d ${D}${sysconfdir}/init.d
		ln -s ${sysconfdir}/wifi/variscite-wifi ${D}${sysconfdir}/init.d/variscite-wifi
		update-rc.d -r ${D} variscite-wifi start 5 S .

		ln -s ${sysconfdir}/bluetooth/variscite-bt ${D}${sysconfdir}/init.d/variscite-bt
		update-rc.d -r ${D} variscite-bt start 99 2 3 4 5 .

		ln -s ${sysconfdir}/openthread/variscite-ot ${D}${sysconfdir}/init.d/variscite-ot
		update-rc.d -r ${D} variscite-ot start 100 2 3 4 5 .
	fi
}
