Return-Path: <linux-can+bounces-5164-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3744BD2BE8
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FE764E8CFF
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0121F2045B5;
	Mon, 13 Oct 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQuhbp/D"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD654C9D;
	Mon, 13 Oct 2025 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354108; cv=none; b=Xs2JXi5f6NDaEcAbl9F8mqq4cCPr+EtyRe46NXClaZCfmWR5ETK35E2DVRujoJtOdUcasRwDzw5mfAK4Jj0SlADbduTiFlSBadTqO4feuVlUZRJAlAbbsOXrDkk2zvcMtZ4mhdcE4wkWhq1evMaGsYYF9rV+TA58RSknl6S1/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354108; c=relaxed/simple;
	bh=DT7jGZEeCK9VufDkT+F7qsemNaLdrV4vBPXdJTV39xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HSZWo/VZ5DZ9metXuAYIH1C7NItlf7CJ1jhfcuCrR0tRmfF15QyHLlcsdjwUMeo0lI4Tbc1FWVUIOstZg+73lHqGwj9zI5qcP09Aq/dTV4Lk2By+VXqZtdxDPw9H/mqufw9TWwm1/SGp4o4b2z+KV8PyAnNr6OewgNY6+lphNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQuhbp/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CA2C4CEE7;
	Mon, 13 Oct 2025 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760354107;
	bh=DT7jGZEeCK9VufDkT+F7qsemNaLdrV4vBPXdJTV39xs=;
	h=From:Date:Subject:To:Cc:From;
	b=ZQuhbp/D1NV7c/95P4elkV+4nJmoyRAn9CYTzO48wdmAhF7yhURRqXy6nY6kK+AYS
	 YpzR6dOzQEGmQVJcfqeee2ahox6H0J/c32k9F66k2QfMIPceg63BOrCslqhBuMrU2b
	 elY6NJ6/3dw7g7XMGNVTEifX6yTXxnxbTJ5VU+94UnYBugTBCIIdYlXR7fboludox7
	 HApCKVyokG1PYMR5pg532iUvLoZY+LVoODzJHtN5iKXvIIS06fB7ZguBxFj1ZL6atN
	 pCKXBjwLq5CuhOFS45f4qVlZ1g0Ol/Ac8cvXKWei/64DLneJxe8jhj7tROrT9O4bki
	 QRTa50etW+4fg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 13 Oct 2025 20:14:45 +0900
Subject: [PATCH] can: add dummy_can driver
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-dummy_can-v1-1-f9724eb90db4@kernel.org>
X-B4-Tracking: v=1; b=H4sIACXf7GgC/02O2w6CMAxAf4Xs2ZpuIMh+xRAyRtFFNnRcgiH8u
 xNM9PG0PSddWE/eUM9ktDBPk+lN5wLwQ8T0TbkrgakDM4HixJHHUI/WvkqtHIhc5YgiQ6UaFu4
 fnhozb61LsbOn5xiSwz78FWW09zAGT7abCEKw3NelHUYgJJ1orBqiSk6c/b+zyQkXIv9YcwuOh
 ta4O1Q6TVA1HNMs/kqV6kO7s9YMMprSIz+D15wV6/oGg3OBhvoAAAA=
X-Change-ID: 20251013-dummy_can-29a900270aaf
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12878; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=DT7jGZEeCK9VufDkT+F7qsemNaLdrV4vBPXdJTV39xs=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlv7hufrjtx4q1jYvnv6baCCeaGoia1NRv2Tip4OnmJb
 q/f87pTHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYyNZ+R4XFTxaqjMgEZFYln
 V79PielMMe2Kdt0ZfPDEMQ9t2x3Jsxn+1yXNnp/gXnlmvfnCCvF9inHeD4qf/Yp82GBS2SminOT
 NCwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

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
---
Initially, I did not intend this to be merged. Oliver suggested that
this may still be mainlined under a different name (e.g. can_nltest):

  https://lore.kernel.org/linux-can/ea52eb8f-c59d-445a-bf4d-26f2772f7426@hartkopp.net/

Looking at what the net tree did, I saw the drivers/net/dummy.c driver
and decided to mimic this as much as feasible.

Despite not being convinced by my own driver at the beginning, over
time, I tend to find this more useful than initially anticipated. So
after a bit of clean-up, I am resubmitting, this time to make it
mainstream. I will let you guys decide if you want to merge this.

Meanwhile, please use this for your CAN XL testing!
---
Changelog:

  RFC -> v1:

    - This was initially part of the CAN XL RFC. Cherry-pick it and
      make it a stand-alone patch.

    - Renamed from dummyxl to dummy_can.

    - Add PMW.

    - The driver is now silent by default. Enable debug mode to show
      all the bittimming information.

    - Any frames it receives are now looped-back.

    - Miscellaneous changes in the code (add PMW, refactor…)

    - Add a proper Kconfig entry.

  Link: https://lore.kernel.org/linux-can/20241110155902.72807-30-mailhol.vincent@wanadoo.fr/
---
 drivers/net/can/Kconfig     |  17 +++
 drivers/net/can/Makefile    |   1 +
 drivers/net/can/dummy_can.c | 276 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+)

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
index 000000000000..b876017b2867
--- /dev/null
+++ b/drivers/net/can/dummy_can.c
@@ -0,0 +1,276 @@
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
+static int dummy_can_netdev_open(struct net_device *dev)
+{
+	struct dummy_can *priv = netdev_priv(dev);
+	struct can_priv *can_priv = &priv->can;
+	int ret;
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
+		CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TMS |
+		CAN_CTRLMODE_XL_ERR_SIGNAL;
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

---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20251013-dummy_can-29a900270aaf
prerequisite-change-id: 20251003-remove-can_change_mtu-e0ec4c0bfeeb:v1
prerequisite-patch-id: 6b3294205bd76b38257516c63b7001ab242c9b62
prerequisite-change-id: 20241229-canxl-netlink-bc640af10673:v1
prerequisite-patch-id: 6b3294205bd76b38257516c63b7001ab242c9b62
prerequisite-patch-id: 1547fd7ea8f1937f0491cfc0996b09890f850991
prerequisite-patch-id: 1dae270b0454352e46b927f71d1b47ff2bf7a49e
prerequisite-patch-id: e4d43de873dfdefc023a0b86e397b37ea2b9e9a3
prerequisite-patch-id: 4f3db477ff411effe70075c59ae6eac04fc65600
prerequisite-patch-id: 148dbfce9d3bb09537087ee93e60bb7819bdadee
prerequisite-patch-id: 7996539e26d449e8db260425c7287b4dce8cdf35
prerequisite-patch-id: 42215044df6a63fff07c7a7d771d7dc375cc8b0e
prerequisite-patch-id: 36cfa71d4cc0fffe97e47ce825e537b910617f34
prerequisite-patch-id: 84ee5e4f937f8e4cd97833d601affea78fe55914

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


