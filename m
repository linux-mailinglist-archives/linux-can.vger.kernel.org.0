Return-Path: <linux-can+bounces-5726-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F8C89A88
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 13:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CD16356B8F
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC89329E7D;
	Wed, 26 Nov 2025 12:01:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B44C326944
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158498; cv=none; b=Ol05YZpl5YkFFd5sEhGDXh5cYbt23j+O30HV0n8XlDbzu6nQiXRacs2gYJonxbsf7Ht/xu3MTk+joZ3q4kFBTj1U1c0stgYPwe4WE4bIdADWlX590FNnXP51aPBi/hAtZpV/dmTtDKqx+RfWhrk/Wz0vGPdtEvWE4XdsPK8twNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158498; c=relaxed/simple;
	bh=UCusrPBzAWg+6DuX8X0P/+5+ZCkC7nbsawyrVBflrhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZi5aLXOTNikYoD9CbAz+j7rfwBkl0R+rfN84EnWju07m5ESX6jqsoz1ofyznyMt1hkUIT9Jr+yNww1AHoMbQE0K6pYXJ/R2IaOCg29hIR5s+el9Dr8glZZHrenA91ihc1oXwiQIILhEaNlDt9D7OG2e48h+rQvRtpGx32rckSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECt-0004UT-ID; Wed, 26 Nov 2025 13:01:11 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECs-002bEk-2F;
	Wed, 26 Nov 2025 13:01:10 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 64B764A8A9A;
	Wed, 26 Nov 2025 12:01:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 15/27] can: add dummy_can driver
Date: Wed, 26 Nov 2025 12:57:04 +0100
Message-ID: <20251126120106.154635-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126120106.154635-1-mkl@pengutronix.de>
References: <20251126120106.154635-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

During the development of CAN XL, we found the need of creating a
dummy CAN XL driver in order to test the new netlink interface. While
this code was initially intended to be some throwaway, it received
some positive feedback.

Add the dummy_can driver. This driver acts similarly to the vcan
interface in the sense that it will echo back any packet it receives.
The difference is that it exposes a set on bittiming parameters as a
real device would and thus must be configured as if it was a real
physical interface.

The driver comes with a debug mode. If debug message are enabled (for
example by enabling CONFIG_CAN_DEBUG_DEVICES), it will print in the
kernel log all the bittiming values, similar to what a:

  ip --details link show can0

would do.

This driver is mostly intended for debugging and testing, but some
developers also may want to look at it as a simple reference
implementation.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20251126-canxl-v8-15-e7e3eb74f889@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig     |  17 +++
 drivers/net/can/Makefile    |   1 +
 drivers/net/can/dummy_can.c | 285 ++++++++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 drivers/net/can/dummy_can.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index d43d56694667..e15e320db476 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -124,6 +124,23 @@ config CAN_CAN327
 
 	  If this driver is built as a module, it will be called can327.
 
+config CAN_DUMMY
+	tristate "Dummy CAN"
+	help
+	  A dummy CAN module supporting Classical CAN, CAN FD and CAN XL. It
+	  exposes bittiming values which can be configured through the netlink
+	  interface.
+
+	  The module will simply echo any frame sent to it. If debug messages
+	  are activated, it prints all the CAN bittiming information in the
+	  kernel log. Aside from that it does nothing.
+
+	  This is convenient for testing the CAN netlink interface. Most of the
+	  users will never need this. If unsure, say NO.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called dummy-can.
+
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
 	depends on OF || COLDFIRE || COMPILE_TEST
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 56138d8ddfd2..d7bc10a6b8ea 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_CAN_CAN327)	+= can327.o
 obj-$(CONFIG_CAN_CC770)		+= cc770/
 obj-$(CONFIG_CAN_C_CAN)		+= c_can/
 obj-$(CONFIG_CAN_CTUCANFD)	+= ctucanfd/
+obj-$(CONFIG_CAN_DUMMY)		+= dummy_can.o
 obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan/
 obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
 obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
new file mode 100644
index 000000000000..41953655e3d3
--- /dev/null
+++ b/drivers/net/can/dummy_can.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2025 Vincent Mailhol <mailhol@kernel.org> */
+
+#include <linux/array_size.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/units.h>
+#include <linux/string_choices.h>
+
+#include <linux/can.h>
+#include <linux/can/bittiming.h>
+#include <linux/can/dev.h>
+#include <linux/can/skb.h>
+
+struct dummy_can {
+	struct can_priv can;
+	struct net_device *dev;
+};
+
+static struct dummy_can *dummy_can;
+
+static const struct can_bittiming_const dummy_can_bittiming_const = {
+	.name = "dummy_can CC",
+	.tseg1_min = 2,
+	.tseg1_max = 256,
+	.tseg2_min = 2,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1
+};
+
+static const struct can_bittiming_const dummy_can_fd_databittiming_const = {
+	.name = "dummy_can FD",
+	.tseg1_min = 2,
+	.tseg1_max = 256,
+	.tseg2_min = 2,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1
+};
+
+static const struct can_tdc_const dummy_can_fd_tdc_const = {
+	.tdcv_min = 0,
+	.tdcv_max = 0, /* Manual mode not supported. */
+	.tdco_min = 0,
+	.tdco_max = 127,
+	.tdcf_min = 0,
+	.tdcf_max = 127
+};
+
+static const struct can_bittiming_const dummy_can_xl_databittiming_const = {
+	.name = "dummy_can XL",
+	.tseg1_min = 2,
+	.tseg1_max = 256,
+	.tseg2_min = 2,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1
+};
+
+static const struct can_tdc_const dummy_can_xl_tdc_const = {
+	.tdcv_min = 0,
+	.tdcv_max = 0, /* Manual mode not supported. */
+	.tdco_min = 0,
+	.tdco_max = 127,
+	.tdcf_min = 0,
+	.tdcf_max = 127
+};
+
+static const struct can_pwm_const dummy_can_pwm_const = {
+	.pwms_min = 1,
+	.pwms_max = 8,
+	.pwml_min = 2,
+	.pwml_max = 24,
+	.pwmo_min = 0,
+	.pwmo_max = 16,
+};
+
+static void dummy_can_print_bittiming(struct net_device *dev,
+				      struct can_bittiming *bt)
+{
+	netdev_dbg(dev, "\tbitrate: %u\n", bt->bitrate);
+	netdev_dbg(dev, "\tsample_point: %u\n", bt->sample_point);
+	netdev_dbg(dev, "\ttq: %u\n", bt->tq);
+	netdev_dbg(dev, "\tprop_seg: %u\n", bt->prop_seg);
+	netdev_dbg(dev, "\tphase_seg1: %u\n", bt->phase_seg1);
+	netdev_dbg(dev, "\tphase_seg2: %u\n", bt->phase_seg2);
+	netdev_dbg(dev, "\tsjw: %u\n", bt->sjw);
+	netdev_dbg(dev, "\tbrp: %u\n", bt->brp);
+}
+
+static void dummy_can_print_tdc(struct net_device *dev, struct can_tdc *tdc)
+{
+	netdev_dbg(dev, "\t\ttdcv: %u\n", tdc->tdcv);
+	netdev_dbg(dev, "\t\ttdco: %u\n", tdc->tdco);
+	netdev_dbg(dev, "\t\ttdcf: %u\n", tdc->tdcf);
+}
+
+static void dummy_can_print_pwm(struct net_device *dev, struct can_pwm *pwm,
+				struct can_bittiming *dbt)
+{
+	netdev_dbg(dev, "\t\tpwms: %u\n", pwm->pwms);
+	netdev_dbg(dev, "\t\tpwml: %u\n", pwm->pwml);
+	netdev_dbg(dev, "\t\tpwmo: %u\n", pwm->pwmo);
+}
+
+static void dummy_can_print_ctrlmode(struct net_device *dev)
+{
+	struct dummy_can *priv = netdev_priv(dev);
+	struct can_priv *can_priv = &priv->can;
+	unsigned long supported = can_priv->ctrlmode_supported;
+	u32 enabled = can_priv->ctrlmode;
+
+	netdev_dbg(dev, "Control modes:\n");
+	netdev_dbg(dev, "\tsupported: 0x%08x\n", (u32)supported);
+	netdev_dbg(dev, "\tenabled: 0x%08x\n", enabled);
+
+	if (supported) {
+		int idx;
+
+		netdev_dbg(dev, "\tlist:");
+		for_each_set_bit(idx, &supported, BITS_PER_TYPE(u32))
+			netdev_dbg(dev, "\t\t%s: %s\n",
+				   can_get_ctrlmode_str(BIT(idx)),
+				   enabled & BIT(idx) ? "on" : "off");
+	}
+}
+
+static void dummy_can_print_bittiming_info(struct net_device *dev)
+{
+	struct dummy_can *priv = netdev_priv(dev);
+	struct can_priv *can_priv = &priv->can;
+
+	netdev_dbg(dev, "Clock frequency: %u\n", can_priv->clock.freq);
+	netdev_dbg(dev, "Maximum bitrate: %u\n", can_priv->bitrate_max);
+	netdev_dbg(dev, "MTU: %u\n", dev->mtu);
+	netdev_dbg(dev, "\n");
+
+	dummy_can_print_ctrlmode(dev);
+	netdev_dbg(dev, "\n");
+
+	netdev_dbg(dev, "Classical CAN nominal bittiming:\n");
+	dummy_can_print_bittiming(dev, &can_priv->bittiming);
+	netdev_dbg(dev, "\n");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_FD) {
+		netdev_dbg(dev, "CAN FD databittiming:\n");
+		dummy_can_print_bittiming(dev, &can_priv->fd.data_bittiming);
+		if (can_fd_tdc_is_enabled(can_priv)) {
+			netdev_dbg(dev, "\tCAN FD TDC:\n");
+			dummy_can_print_tdc(dev, &can_priv->fd.tdc);
+		}
+	}
+	netdev_dbg(dev, "\n");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_XL) {
+		netdev_dbg(dev, "CAN XL databittiming:\n");
+		dummy_can_print_bittiming(dev, &can_priv->xl.data_bittiming);
+		if (can_xl_tdc_is_enabled(can_priv)) {
+			netdev_dbg(dev, "\tCAN XL TDC:\n");
+			dummy_can_print_tdc(dev, &can_priv->xl.tdc);
+		}
+		if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TMS) {
+			netdev_dbg(dev, "\tCAN XL PWM:\n");
+			dummy_can_print_pwm(dev, &can_priv->xl.pwm,
+					    &can_priv->xl.data_bittiming);
+		}
+	}
+	netdev_dbg(dev, "\n");
+}
+
+static int dummy_can_netdev_open(struct net_device *dev)
+{
+	int ret;
+	struct can_priv *priv = netdev_priv(dev);
+
+	dummy_can_print_bittiming_info(dev);
+	netdev_dbg(dev, "error-signalling is %s\n",
+		   str_enabled_disabled(!can_dev_in_xl_only_mode(priv)));
+
+	ret = open_candev(dev);
+	if (ret)
+		return ret;
+	netif_start_queue(dev);
+	netdev_dbg(dev, "dummy-can is up\n");
+
+	return 0;
+}
+
+static int dummy_can_netdev_close(struct net_device *dev)
+{
+	netif_stop_queue(dev);
+	close_candev(dev);
+	netdev_dbg(dev, "dummy-can is down\n");
+
+	return 0;
+}
+
+static netdev_tx_t dummy_can_start_xmit(struct sk_buff *skb,
+					struct net_device *dev)
+{
+	if (can_dev_dropped_skb(dev, skb))
+		return NETDEV_TX_OK;
+
+	can_put_echo_skb(skb, dev, 0, 0);
+	dev->stats.tx_packets++;
+	dev->stats.tx_bytes += can_get_echo_skb(dev, 0, NULL);
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops dummy_can_netdev_ops = {
+	.ndo_open = dummy_can_netdev_open,
+	.ndo_stop = dummy_can_netdev_close,
+	.ndo_start_xmit = dummy_can_start_xmit,
+};
+
+static const struct ethtool_ops dummy_can_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
+static int __init dummy_can_init(void)
+{
+	struct net_device *dev;
+	struct dummy_can *priv;
+	int ret;
+
+	dev = alloc_candev(sizeof(*priv), 1);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->netdev_ops = &dummy_can_netdev_ops;
+	dev->ethtool_ops = &dummy_can_ethtool_ops;
+	priv = netdev_priv(dev);
+	priv->can.bittiming_const = &dummy_can_bittiming_const;
+	priv->can.bitrate_max = 20 * MEGA /* BPS */;
+	priv->can.clock.freq = 160 * MEGA /* Hz */;
+	priv->can.fd.data_bittiming_const = &dummy_can_fd_databittiming_const;
+	priv->can.fd.tdc_const = &dummy_can_fd_tdc_const;
+	priv->can.xl.data_bittiming_const = &dummy_can_xl_databittiming_const;
+	priv->can.xl.tdc_const = &dummy_can_xl_tdc_const;
+	priv->can.xl.pwm_const = &dummy_can_pwm_const;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+		CAN_CTRLMODE_FD | CAN_CTRLMODE_TDC_AUTO |
+		CAN_CTRLMODE_RESTRICTED | CAN_CTRLMODE_XL |
+		CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TMS;
+	priv->dev = dev;
+
+	ret = register_candev(priv->dev);
+	if (ret) {
+		free_candev(priv->dev);
+		return ret;
+	}
+
+	dummy_can = priv;
+	netdev_dbg(dev, "dummy-can ready\n");
+
+	return 0;
+}
+
+static void __exit dummy_can_exit(void)
+{
+	struct net_device *dev = dummy_can->dev;
+
+	netdev_dbg(dev, "dummy-can bye bye\n");
+	unregister_candev(dev);
+	free_candev(dev);
+}
+
+module_init(dummy_can_init);
+module_exit(dummy_can_exit);
+
+MODULE_DESCRIPTION("A dummy CAN driver, mainly to test the netlink interface");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Vincent Mailhol <mailhol@kernel.org>");
-- 
2.51.0


