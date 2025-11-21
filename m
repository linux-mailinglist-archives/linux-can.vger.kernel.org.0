Return-Path: <linux-can+bounces-5585-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37609C7B8D9
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 20:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 087FE3562FE
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9AA302759;
	Fri, 21 Nov 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QmPJ/9em";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="alvPsuqT"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9022848AA
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753751; cv=pass; b=FtLv/6p1heTWGIrVvKs+BXERapBmpNQaqun7QbRJ9HnoxoCKm44VHO4xZNWSkHx/JZ3juRJhPQeVyniAEJvl1xYmZj4SgmzACbZdX3IhvYZIjW90ATkvwfXmNFtrHrWImWlipdqg7DLkTKDyBwhP0FG+P7AteWbFkrJG9sVSTa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753751; c=relaxed/simple;
	bh=vVkfFlF0mujiNYbZ4oOulmhmT9vFYQp2s4iC63qUcsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g03Oek5ZPNKMB0gRBoSqtTNyTfIB6pLuh4YDPTI3o+Cu9mEU59Kc+s4HUbjDk6E6MFY5x7CrgeegBvWyGQWncx07WkDjMAoLAjVx/MzGuanvDY4jvbGBYCaMUpc4sTEb6Pp5xf3o7Ex5RVErwb/FGHDwvzizouFBTGU2HwF5pCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QmPJ/9em; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=alvPsuqT; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763753730; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ormq22uCh9WT7VbPTJNI18Nk/XnFnejt+b7h/jA40Ngy0Krtq8wS5tTrhra3mUOND9
    +/CnQIpd/SqrszV12opRauuvcyldB9LJe1IwZ57VffKJrPwfVjOn3Vn495IVhO7FTxEY
    CJgOKfV/8ctknSsjk3SFaXbYem/GggJ3EBhhBGxCaNGnXyYad4sLDTckeM4/V75gMUc5
    gQGURSgn3Z/tKvbT9KutbPPZ0B/FJM9Y1iSD1a+pIo7tZSVxoqGFNy1DJ6P7MSHhRb2S
    7ANGGEiYGDN6U2o0Z7akD7a7e0b4/bfYaXuHV8XDdZ8ThLhzgvVKzLyTPGpii5GspNv4
    M3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753730;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+mG6k9h0phFqxAgEn/Vgfx7Bk4IQa5/gpF7Q14Vm94k=;
    b=h0P38Q2v7jnzS3P9so0jd+moEkoBHoEvlfx+uDXCh/0HL3+8O51OCTQhCDr5n3NOgc
    eFuV+230ueGuR6x7S5hCAdUOrsOmSVTjzMxG/w1qxPLLZDkT/Zh4tAOAqWchOERJo+dM
    R/lkgmQbWV3e6FHm0jh+NihoXpoUC0wnZXBmeKYMKv5ERAqdTyRHlDYrysmyCVkSOcDp
    vlilNYLYqx3Sb1sLTPjS1BVe64S6JtUx2pA7JJIXL24CYrbrMEbUNF26pnEeR8Q+2nQV
    1GwQKcqMdzEOCnHAgkpZRbjl88KQ7e5ElqrhdUo+JhvAmd6zLUd0YnXUSNyuuMIN91aU
    A/DA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763753730;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+mG6k9h0phFqxAgEn/Vgfx7Bk4IQa5/gpF7Q14Vm94k=;
    b=QmPJ/9emsBXmV6Uvxg2vQcdOywBcwz8/nwtecpusRHTu2o6TGZiJL2kfP+bl4PPyvE
    OHXyoFjhp98pfpmw6x3BTt+5MI+q2hL4ZGXiEJRSk6vaq5ErJvLdeLtgmQ8yTP1nvSX8
    MJZKDKZUt7e/r7JVkckE+YS5W6OUQqCPGirLti8HVNICANZ6eXq1aFc7gfxKhNJoKEYO
    nJUwBmx9NIXp6Ks97LB8K9SXH6Jox2f9bPEYo226CcO0VYMrIeguu+yYpkXric5Q+WdK
    x4RaLretefOrwUosX5l0K7Il/9Z+RExQllbpXp95gZH/rCVU/z9YdINaRJKvuBjSyUEU
    7iHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763753730;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=+mG6k9h0phFqxAgEn/Vgfx7Bk4IQa5/gpF7Q14Vm94k=;
    b=alvPsuqTS9QAg0y9rxhTaXyTRGUy9txgcsq5TFOM4IafoLXaJyBrJJMI+RDx9NT6cZ
    FfDhMGFVP3Yw9dkCjXAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ALJZUEnG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 20:35:30 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v5 15/17] can: add dummy_can driver
Date: Fri, 21 Nov 2025 20:35:11 +0100
Message-ID: <20251121193513.2097-16-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121193513.2097-1-socketcan@hartkopp.net>
References: <20251121193513.2097-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

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
@@ -122,10 +122,27 @@ config CAN_CAN327
 	  Please refer to the documentation for information on how to use it:
 	  Documentation/networking/device_drivers/can/can327.rst
 
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
 	depends on HAS_IOMEM
 	select CAN_RX_OFFLOAD
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 56138d8ddfd2..d7bc10a6b8ea 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -19,10 +19,11 @@ obj-$(CONFIG_CAN_AT91)		+= at91_can.o
 obj-$(CONFIG_CAN_BXCAN)		+= bxcan.o
 obj-$(CONFIG_CAN_CAN327)	+= can327.o
 obj-$(CONFIG_CAN_CC770)		+= cc770/
 obj-$(CONFIG_CAN_C_CAN)		+= c_can/
 obj-$(CONFIG_CAN_CTUCANFD)	+= ctucanfd/
+obj-$(CONFIG_CAN_DUMMY)		+= dummy_can.o
 obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan/
 obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
 obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
 obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
 obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd/
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
2.47.3


