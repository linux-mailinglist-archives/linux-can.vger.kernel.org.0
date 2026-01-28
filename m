Return-Path: <linux-can+bounces-6361-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O8gAhkkemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6361-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:58:33 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D6A361E
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63D0630EB2E2
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD74366DBA;
	Wed, 28 Jan 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ZAFxrjeR"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4789364037;
	Wed, 28 Jan 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611776; cv=none; b=OyF5swy/WyYi6ttb6yJBiTz80r5tfTZCqJlClhDBq7D/k87fQLhA38aTZoJUyjhbJuZ8qLLrcnN3G9AJ0AGLaBIxEMyIM6pbprAA0Pi7GmgNB0eUO74TjrhZY/6vlMqrdEIOOUigDPP29trVHHXhQqN0vUIh2VMxJj4POV+TrjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611776; c=relaxed/simple;
	bh=RPIVoAMFk1h/d/PLuQxfQAEVIXrFvOzekbjN8qv8GIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnObqCIdxG0rXiOw1Uz2n5BWhApt10tRyNZ7XfB3lRMOAUIw06Mn3ZYTUkfz7svlGYd4qWgjeXPVcSrr8xOzMnHR4/s4CSQeC/6THQDXhMOBvj0LAysyYnqbAYwrxTQ1xFpI/0zH9KT0+1ZR5aXKoCqLF3B9HBe4BEQtlv72V1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ZAFxrjeR reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1QCY1BbRz1FQVT;
	Wed, 28 Jan 2026 15:49:29 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4f1QCX4qYQz1DQsp;
	Wed, 28 Jan 2026 15:49:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769611769;
	bh=YKraLCfX9sUKTKhBlpVkse1ctK5HfkR4tSodMZ5Riww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZAFxrjeRg4sYST3Mt1pox64aOYlWH1zIU+vNxzVj4xJ+AtGvevLKGCtCuaAKOsayF
	 kR8ll8zAXzHuHaGLnejVFB97f86JmLgWS3olivA5evmupvDdIin+w40cOkwWD5Axv9
	 RgS+05fTuS0jIat7Dq+LL334B1L7Aig4joD4FLmlKHrVaylUzhqdKbQJ06n0uGXb+6
	 qxpr91UbrPFs7YODtMeACrcmudY/3fCBimWQqCZzFw4Ylxkm+qVJOBSLVfBwy49AoA
	 kuyRPkMBtiNhpao+KVR6yqhq2n2GiPrG1W7T9rGuyA0wGqJcBRi9nxRZJ7qFLIoUMN
	 XKVUL/lMEStTA==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>,
	Daniel Hellstrom <daniel@gaisler.com>
Subject: [PATCH v4 07/15] can: grcan: add FD capability detection and nominal bit-timing
Date: Wed, 28 Jan 2026 15:49:13 +0100
Message-ID: <20260128144921.5458-8-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
References: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6361-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gaisler.com:mid,gaisler.com:email]
X-Rspamd-Queue-Id: 735D6A361E
X-Rspamd-Action: no action

Add capability for the driver to detect CAN FD support
and adjust accordingly. Introduce structures and functions
for setting nominal bit-timing for standard CAN FD.
The `grcan_hwcap` structure defines hardware capabilities like
CAN FD support and baud-rate options. Additionally, improved
device tree compatibility by updating the `of_device_id` table
for better matching of GRCAN and GRCANFD devices. Also update
Kconfig to mention GRCANFD support.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/net/can/Kconfig |   6 +-
 drivers/net/can/grcan.c | 137 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 125 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index d43d56694667..96f61b40a898 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -133,10 +133,12 @@ config CAN_FLEXCAN
 	  Say Y here if you want to support for Freescale FlexCAN.

 config CAN_GRCAN
-	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
+	tristate "Aeroflex Gaisler GRCAN(FD) and GRHCAN CAN devices"
 	depends on OF && HAS_DMA && HAS_IOMEM
 	help
-	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRHCAN.
+	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRCANFD
+	  or GRHCAN.
+
 	  Note that the driver supports little endian, even though little
 	  endian syntheses of the cores would need some modifications on
 	  the hardware level to work.
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 4ed0fb1d70b7..a752aea51d96 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -33,6 +33,7 @@
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
@@ -51,7 +52,11 @@ struct grcan_registers {
 	u32 __reserved1[GRCAN_RESERVE_SIZE(0x08, 0x18)];
 	u32 smask;	/* 0x18 - CanMASK */
 	u32 scode;	/* 0x1c - CanCODE */
-	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x100)];
+	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x40)];
+	u32 nbtr;	/* 0x40 */
+	u32 fdbtr;	/* 0x44 */
+	u32 tdelay;	/* 0x48 */
+	u32 __reserved2_[GRCAN_RESERVE_SIZE(0x48, 0x100)];
 	u32 pimsr;	/* 0x100 */
 	u32 pimr;	/* 0x104 */
 	u32 pisr;	/* 0x108 */
@@ -203,6 +208,39 @@ struct grcan_registers {
 #error "Invalid default buffer size"
 #endif

+#define GRCANFD_NBTR_SCALER     GENMASK(23, 16)
+#define GRCANFD_NBTR_PS1        GENMASK(17, 10)
+#define GRCANFD_NBTR_PS2        GENMASK(9, 5)
+#define GRCANFD_NBTR_SJW        GENMASK(4, 0)
+#define GRCANFD_NBTR_TIMING						\
+	(GRCANFD_NBTR_SCALER | GRCANFD_NBTR_PS1 | GRCANFD_NBTR_PS2 |	\
+	 GRCANFD_NBTR_SJW)
+
+#define GRCANFD_FDBTR_SCALER 0x00ff0000
+#define GRCANFD_FDBTR_PS1 0x00003c00
+#define GRCANFD_FDBTR_PS2 0x000001e0
+#define GRCANFD_FDBTR_SJW 0x0000000f
+#define GRCANFD_FDBTR_TIMING						\
+	(GRCANFD_FDBTR_SCALER | GRCANFD_FDBTR_PS1 | GRCANFD_FDBTR_PS2 |	\
+	 GRCANFD_FDBTR_SJW)
+
+#define GRCANFD_FDBTR_SCALER_BIT 16
+#define GRCANFD_FDBTR_PS1_BIT 10
+#define GRCANFD_FDBTR_PS2_BIT 5
+#define GRCANFD_FDBTR_SJW_BIT 0
+
+/* Hardware capabilities */
+struct grcan_hwcap {
+	/* CAN-FD capable, indicates GRCANFD IP.
+	 * The GRCANFD has different baud-rate registers and extended DMA
+	 * format to also describe FD-frames.
+	 */
+	const struct can_bittiming_const *bt_const;
+	int (*set_bittiming)(struct net_device *dev);
+	bool txbug_possible;
+	bool fd;
+};
+
 struct grcan_dma_buffer {
 	size_t size;
 	void *buf;
@@ -245,6 +283,7 @@ struct grcan_priv {
 	struct napi_struct napi;

 	struct grcan_registers __iomem *regs;	/* ioremap'ed registers */
+	const struct grcan_hwcap *hwcap;
 	struct grcan_device_config config;
 	struct grcan_dma dma;

@@ -393,6 +432,19 @@ static const struct can_bittiming_const grcan_bittiming_const = {
 	.brp_inc	= 1,
 };

+/* GRCANFD nominal boundaries for baud-rate parameters */
+static const struct can_bittiming_const grcanfd_bittiming_const = {
+	.name		= DRV_NAME,
+	.tseg1_min	= 2,
+	.tseg1_max	= 63,
+	.tseg2_min	= 2,
+	.tseg2_max	= 16,
+	.sjw_max	= 16,
+	.brp_min	= 1,
+	.brp_max	= 256,
+	.brp_inc	= 1,
+};
+
 static int grcan_set_bittiming(struct net_device *dev)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
@@ -421,6 +473,32 @@ static int grcan_set_bittiming(struct net_device *dev)
 	return 0;
 }

+static int grcanfd_set_bittiming(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs;
+	int sjw, ps1, ps2, scaler;
+	struct can_bittiming *bt;
+	u32 timing = 0;
+
+	regs = priv->regs;
+	bt = &priv->can.bittiming;
+
+	sjw = bt->sjw;
+	ps1 = (bt->prop_seg + bt->phase_seg1);
+	ps2 = bt->phase_seg2;
+	scaler = bt->brp - 1;
+
+	timing |= FIELD_PREP(GRCANFD_NBTR_SJW, sjw);
+	timing |= FIELD_PREP(GRCANFD_NBTR_PS1, ps1);
+	timing |= FIELD_PREP(GRCANFD_NBTR_PS2, ps2);
+	timing |= FIELD_PREP(GRCANFD_NBTR_SCALER, scaler);
+	netdev_dbg(dev, "setting timing=0x%x\n", timing);
+	grcan_write_bits(&regs->nbtr, timing, GRCANFD_NBTR_TIMING);
+
+	return 0;
+}
+
 static int grcan_get_berr_counter(const struct net_device *dev,
 				  struct can_berr_counter *bec)
 {
@@ -1545,7 +1623,8 @@ static const struct ethtool_ops grcan_ethtool_ops = {

 static int grcan_setup_netdev(struct platform_device *ofdev,
 			      void __iomem *base,
-			      int irq, u32 ambafreq, bool txbug)
+			      int irq, u32 ambafreq, bool txbug,
+			      const struct grcan_hwcap *hwcap)
 {
 	struct net_device *dev;
 	struct grcan_priv *priv;
@@ -1568,14 +1647,14 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	priv->dev = dev;
 	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
-	priv->can.bittiming_const = &grcan_bittiming_const;
-	priv->can.do_set_bittiming = grcan_set_bittiming;
+	priv->can.bittiming_const = hwcap->bt_const;
 	priv->can.do_set_mode = grcan_set_mode;
 	priv->can.do_get_berr_counter = grcan_get_berr_counter;
 	priv->can.clock.freq = ambafreq;
 	priv->can.ctrlmode_supported =
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
 	priv->need_txbug_workaround = txbug;
+	priv->hwcap = hwcap;

 	/* Discover if triple sampling is supported by hardware */
 	regs = priv->regs;
@@ -1620,22 +1699,29 @@ static int grcan_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct device_node *sysid_parent;
+	const struct grcan_hwcap *hwcap;
 	struct clk *clk;
 	u32 sysid, ambafreq;
 	int irq, err;
 	void __iomem *base;
 	bool txbug = true;

+	hwcap = device_get_match_data(&ofdev->dev);
+
 	/* Compare GRLIB version number with the first that does not
 	 * have the tx bug (see start_xmit)
 	 */
-	sysid_parent = of_find_node_by_path("/ambapp0");
-	if (sysid_parent) {
-		err = of_property_read_u32(sysid_parent, "systemid", &sysid);
-		if (!err && ((sysid & GRLIB_VERSION_MASK) >=
-			     GRCAN_TXBUG_SAFE_GRLIB_VERSION))
-			txbug = false;
-		of_node_put(sysid_parent);
+	if (!hwcap->txbug_possible) {
+		txbug = false;
+	} else {
+		sysid_parent = of_find_node_by_path("/ambapp0");
+		if (sysid_parent) {
+			err = of_property_read_u32(sysid_parent, "systemid", &sysid);
+			if (!err && ((sysid & GRLIB_VERSION_MASK) >=
+				     GRCAN_TXBUG_SAFE_GRLIB_VERSION))
+				txbug = false;
+			of_node_put(sysid_parent);
+		}
 	}

 	err = of_property_read_u32(np, "freq", &ambafreq);
@@ -1670,7 +1756,7 @@ static int grcan_probe(struct platform_device *ofdev)

 	grcan_sanitize_module_config(ofdev);

-	err = grcan_setup_netdev(ofdev, base, irq, ambafreq, txbug);
+	err = grcan_setup_netdev(ofdev, base, irq, ambafreq, txbug, hwcap);
 	if (err)
 		goto exit_dispose_irq;

@@ -1697,11 +1783,30 @@ static void grcan_remove(struct platform_device *ofdev)
 	free_candev(dev);
 }

+static const struct grcan_hwcap grcan_hwcap = {
+	.fd = false,
+	.txbug_possible = true,
+	.bt_const = &grcan_bittiming_const,
+	.set_bittiming = grcan_set_bittiming,
+};
+
+static const struct grcan_hwcap grcanfd_hwcap = {
+	.fd = true,
+	.txbug_possible = false,
+	.bt_const = &grcanfd_bittiming_const,
+	.set_bittiming = grcanfd_set_bittiming,
+};
+
 static const struct of_device_id grcan_match[] = {
-	{.name = "GAISLER_GRCAN"},
-	{.name = "01_03d"},
-	{.name = "GAISLER_GRHCAN"},
-	{.name = "01_034"},
+	{.name = "GAISLER_GRCAN", .data = &grcan_hwcap},
+	{.name = "01_03d", .data = &grcan_hwcap},
+	{.name = "GAISLER_GRHCAN", .data = &grcan_hwcap},
+	{.name = "01_034", .data = &grcan_hwcap},
+	{.compatible = "gaisler,grcan", .data = &grcan_hwcap},
+	/* GRCANFD */
+	{.compatible = "gaisler,grcanfd", .data = &grcanfd_hwcap},
+	{.name = "GAISLER_GRCANFD", .data = &grcanfd_hwcap},
+	{.name = "01_0b5", .data = &grcanfd_hwcap},
 	{},
 };

--
2.51.0


