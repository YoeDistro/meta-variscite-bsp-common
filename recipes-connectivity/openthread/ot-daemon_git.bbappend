FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit cmake

LIC_FILES_CHKSUM = "file://LICENSE;md5=543b6fe90ec5901a683320a36390c65f \
                    file://third_party/mbedtls/repo/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57 \
                    "

# Apply patch files for openthread from Linux_SD-UART-BT-IW612-18.99.2.p19.10-18.99.2.p19.10-MXM5X18398.p7-GPL/OT-Tools_LNX_6_1_1-IMX8/otpatches-052-0f7e849
SRC_URI = "\
    gitsm://github.com/openthread/openthread.git;branch=main;protocol=https \
    file://0001-coex-buff-issue-fix.patch \
    file://0002-csl-debug_prints.patch \
    file://0003-set-vsc-ir-eui64.patch \
    file://0004-set-vsc-txpwr-limit.patch \
    file://0005-host-spi-clear-tx-buffer.patch \
    file://0006-ot-daemon-release-resources.patch \
    file://0008-add-mfg-cmd-for-pfw.patch \
    file://0011-get-vsc-txpwr-limit.patch \
    file://0012-vsc-for-otbr.patch \
    file://0013-cca-configuration.patch \
    file://0015-get-vsc-fwversion.patch \
    file://0016-lnt-fix-read-settings.patch \
    file://0017-lnt-buffer-handle-when-recover.patch \
    file://0019-remove-toggle-reset-pin.patch \
    file://0020-lnt-fix-spi-latency.patch \
    file://0023-csl-ahead-time.patch \
    file://0024-spi-new-design.patch \
    file://0025-spi-default-packet-size.patch \
    file://0026-128-sed.patch \
    file://0029-fix-get-txpwrlimit-ret.patch \
    file://0030-range-check-for-rf-test-mode.patch \
    file://0032-cca3-configuration.patch \
    file://0033-remove-duplicate-error-msg.patch \
    file://0034-set-default-txpower-on-reset.patch \
    file://0035-set-ch-on-ed-scan-with-param.patch \
    file://0036-set-default-rssi-on-reset-for-host.patch \
    file://0040-radio-spinel-stream-raw-retry-mechanism.patch \
    file://0042-ir-oob-threshold.patch \
    file://0045-disable-channel-monitor-feature.patch \
    file://0047-host-dualpan-feature-integration.patch \
    file://0049-add-ircfg-get-command-in-host.patch \
    file://0051-csl-ch-switch-performance-improvement.patch \
"

# Variscite patch to make reset gpio optional
SRC_URI += "\
    file://0001-ot-daemon-spi_interface-make-reset-device-and-line-o.patch \
"

# Align with SD-WLAN-UART-BT-Zigbee-IW612-LNX_6_6_23-IMX8-18.99.3.p10.1-18.99.3.p10.1-MM6X18437.P21-GPL/RN00104.pdf
SRCREV = "0f7e8491e2c2445331d5febcbe3a24c0c1d4e1e3"

# ot-daemon_%.bbappend

# Align with SD-WLAN-UART-BT-IW612-LNX_6_6_23-IMX8-18.99.3.p10.1-18.99.3.p10.1-MM6X18437.P21-GPL/OT-Tools_LNX_6_6_23-IMX8/otpatches-052-0f7e849/iw612_ot_src_rev_opts_patches.inc
EXTRA_OECMAKE:append = " \
    -DOT_SLAAC=ON \
    -DOT_ANYCAST_LOCATOR=ON \
    -DOT_BORDER_AGENT=ON \
    -DOT_BORDER_AGENT_ID=ON \
    -DOT_BORDER_ROUTER=ON \
    -DOT_CHANNEL_MANAGER=ON \
    -DOT_CHANNEL_MONITOR=ON \
    -DOT_COAP=ON \
    -DOT_COAPS=ON \
    -DOT_COAP_BLOCK=ON \
    -DOT_COAP_OBSERVE=ON \
    -DOT_COMMISSIONER=ON \
    -DOT_COMPILE_WARNING_AS_ERROR=ON \
    -DOT_COVERAGE=ON \
    -DOT_DATASET_UPDATER=ON \
    -DOT_DHCP6_CLIENT=ON \
    -DOT_DHCP6_SERVER=ON \
    -DOT_DIAGNOSTIC=ON \
    -DOT_DNSSD_SERVER=ON \
    -DOT_DNS_CLIENT=ON \
    -DOT_ECDSA=ON \
    -DOT_HISTORY_TRACKER=ON \
    -DOT_IP6_FRAGM=ON \
    -DOT_JAM_DETECTION=ON \
    -DOT_JOINER=ON \
    -DOT_LOG_LEVEL_DYNAMIC=ON \
    -DOT_MAC_FILTER=ON \
    -DOT_NEIGHBOR_DISCOVERY_AGENT=ON \
    -DOT_NETDATA_PUBLISHER=ON \
    -DOT_NETDIAG_CLIENT=ON \
    -DOT_PING_SENDER=ON \
    -DOT_RCP_RESTORATION_MAX_COUNT=2 \
    -DOT_REFERENCE_DEVICE=ON \
    -DOT_SERVICE=ON \
    -DOT_SNTP_CLIENT=ON \
    -DOT_SRP_CLIENT=ON \
    -DOT_SRP_SERVER=ON \
    -DOT_UPTIME=ON \
    -DOT_TCP=OFF \
    -DOT_LOG_OUTPUT=PLATFORM_DEFINED \
    -DOT_POSIX_MAX_POWER_TABLE=ON \
    -DOT_PLATFORM=posix \
    -DCMAKE_BUILD_TYPE=Release \
    -DOT_COVERAGE=0 \
    -DOT_COMPILE_WARNING_AS_ERROR=0 \
    -DOT_DAEMON=1 \
    -DOT_POSIX_CONFIG_RCP_BUS=SPI \
    -DOT_BACKBONE_ROUTER=1 \
    -DOT_FULL_LOGS=1 \
    -DOT_DUA=1 \
    -DOT_LINK_METRICS_INITIATOR=1 \
    -DOT_LINK_METRICS_SUBJECT=1 \
    -DOT_MLR=1 \
    -DOT_RCP_RESTORATION_MAX_COUNT=5 \
    -DOT_TCP=OFF \
    -DOT_THREAD_VERSION=1.3 \
    -DOT_CHANNEL_MONITOR=0 \
"
