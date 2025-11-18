Return-Path: <linux-can+bounces-5481-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAA6C687D5
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 36A112A6E5
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5B31AF39;
	Tue, 18 Nov 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="PZ2XFL/R"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E3313554;
	Tue, 18 Nov 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457698; cv=none; b=SYSKFOhmBRjgpxCwuXKzQSh9tYnnivXhGMdg7RWWf1ZoY1vGmjLWzr5KdvllPE225+b4QXHl8kkZ6rYzcF8tLRovX7s7p62F+DNxaZeLFDke6TVB8hfz59Btcv0BUUiiqbNwoc3yYOvk0uKvL2tVY14HfRYrkDgjVnGOT4YIDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457698; c=relaxed/simple;
	bh=9yknJCGmDa/gqo7+F7dWEtolQI/BzuopsblUp3mm10k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrXVqhi/nHTGe5MSAdJHPsU/hCyY9m8OT+wuAveQrBEe15MRTV+znS2GOLEpcVgm2RtoqpjPBM9VllAbCd9vPfhPd8cq0KjkZTwml5sa/9sYFnWwBNbo0bv+B4BUUa6Z7WsHkem0BCAomgHcd+U44KdUdIzCbmSncx4WEkG5Y3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=PZ2XFL/R reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fHx2DGVz1DDXL;
	Tue, 18 Nov 2025 10:21:33 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fHw6v9Fz1DHc4;
	Tue, 18 Nov 2025 10:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457693;
	bh=AHCagI2CG98CSLtLVHmtrL6P3BHrqiUzhqquz9U5GsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PZ2XFL/RrdH/NKMAfAvER2xgsazC/luwpdxwxQs+BTtcLNBI9eMhgz/7akIQ9bIFn
	 imwSL4rMUNfPwi8MBaC1ffeswGWXpMsN8u231zS7sS3J7FnrNx+1IpUAY6s8Yx9PLU
	 w1lfY0QfB7YypBMnK74pZCp2x+BkRrgyv50YqQiojEpRLXRdQNqjmKu7Yzk0p6TmWy
	 yBY5PYfVaiCzNfqXM3ERs6qE5a7w1XNSB0JT9cvasuUsefk0T+bobAkUI5419PCt7E
	 mQUhOtXivuMTZaGUKlFvaSYraoN71q6K6vbkz9L91JTxsKnzMIPunT024PL6Day08Q
	 8Usosb4tUHdaA==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Daniel Hellstrom <daniel@gaisler.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH 05/10] can: grcan: add FD capability detection and nominal bit-timing
Date: Tue, 18 Nov 2025 10:21:10 +0100
Message-ID: <20251118092115.3455-6-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Hellstrom <daniel@gaisler.com>

Add capability for the driver to detect CAN FD support
and adjust accordingly. Introduce structures and functions
for setting nominal bit-timing for standard CAN and CAN FD.
The `grcan_hwcap` structure defines hardware capabilities like
CAN FD support and baud-rate options. Additionally, improved
device tree compatibility by updating the `of_device_id` table
for better matching of GRCAN and GRCANFD devices. Also update
Kconfig to mention GRCANFD support.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/net/can/Kconfig |   6 +-
 drivers/net/can/grcan.c | 189 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 176 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index d43d56694667..816b6e71a990 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -133,10 +133,12 @@ config CAN_FLEXCAN
 	  Say Y here if you want to support for Freescale FlexCAN.

 config CAN_GRCAN
-	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
+	tristate "Aeroflex Gaisler GRCAN, GRCANFD and GRHCAN CAN devices"
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
index 538a9b4f82ab..b9b0dd7d53f6 100644
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
@@ -50,7 +51,11 @@ struct grcan_registers {
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
@@ -212,6 +217,67 @@ struct grcan_registers {
 #error "Invalid default buffer size"
 #endif

+#define GRCANFD_NOMCONF_SJW_MIN	1
+#define GRCANFD_NOMCONF_SJW_MAX	16
+#define GRCANFD_NOMCONF_PS1_MIN	2
+#define GRCANFD_NOMCONF_PS1_MAX	63
+#define GRCANFD_NOMCONF_PS2_MIN	2
+#define GRCANFD_NOMCONF_PS2_MAX	16
+#define GRCANFD_NOMCONF_SCALER_MIN	0
+#define GRCANFD_NOMCONF_SCALER_MAX	255
+#define GRCANFD_NOMCONF_SCALER_INC	1
+
+#define GRCANFD_NBTR_SCALER 0x00ff0000
+#define GRCANFD_NBTR_PS1 0x0000fc00
+#define GRCANFD_NBTR_PS2 0x000003e0
+#define GRCANFD_NBTR_SJW 0x0000001f
+#define GRCANFD_NBTR_TIMING						\
+	(GRCANFD_NBTR_SCALER | GRCANFD_NBTR_PS1 | GRCANFD_NBTR_PS2 |	\
+	 GRCANFD_NBTR_SJW)
+
+#define GRCANFD_NBTR_SCALER_BIT 16
+#define GRCANFD_NBTR_PS1_BIT 10
+#define GRCANFD_NBTR_PS2_BIT 5
+#define GRCANFD_NBTR_SJW_BIT 0
+
+#define GRCANFD_FDCONF_SJW_MIN	1
+#define GRCANFD_FDCONF_SJW_MAX	8
+#define GRCANFD_FDCONF_PS1_MIN	1
+#define GRCANFD_FDCONF_PS1_MAX	15
+#define GRCANFD_FDCONF_PS2_MIN	2
+#define GRCANFD_FDCONF_PS2_MAX	8
+#define GRCANFD_FDCONF_SCALER_MIN	0
+#define GRCANFD_FDCONF_SCALER_MAX	255
+#define GRCANFD_FDCONF_SCALER_INC	1
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
+	bool fd;
+	bool txbug_possible;
+	const struct can_bittiming_const *bt_const;
+	int (*set_bittiming)(struct net_device *dev);
+};
+
+static const struct grcan_hwcap grcan_hwcap;
+static const struct of_device_id grcan_match[];
+
 struct grcan_dma_buffer {
 	size_t size;
 	void *buf;
@@ -304,6 +370,8 @@ struct grcan_priv {
 	 */
 	bool resetting;
 	bool closing;
+
+	const struct grcan_hwcap *hwcap;
 };

 /* Wait time for a short wait for ongoing to clear */
@@ -402,6 +470,19 @@ static const struct can_bittiming_const grcan_bittiming_const = {
 	.brp_inc	= GRCAN_CONF_SCALER_INC,
 };

+/* GRCANFD nominal boundaries for baud-rate parameters */
+static const struct can_bittiming_const grcanfd_bittiming_const = {
+	.name		= DRV_NAME,
+	.tseg1_min	= GRCANFD_NOMCONF_PS1_MIN,
+	.tseg1_max	= GRCANFD_NOMCONF_PS1_MAX,
+	.tseg2_min	= GRCANFD_NOMCONF_PS2_MIN,
+	.tseg2_max	= GRCANFD_NOMCONF_PS2_MAX,
+	.sjw_max	= GRCANFD_NOMCONF_SJW_MAX,
+	.brp_min	= GRCANFD_NOMCONF_SCALER_MIN + 1,
+	.brp_max	= GRCANFD_NOMCONF_SCALER_MAX + 1,
+	.brp_inc	= GRCANFD_NOMCONF_SCALER_INC,
+};
+
 static int grcan_set_bittiming(struct net_device *dev)
 {
 	struct grcan_priv *priv = netdev_priv(dev);
@@ -439,12 +520,55 @@ static int grcan_set_bittiming(struct net_device *dev)
 	timing |= (ps1 << GRCAN_CONF_PS1_BIT) & GRCAN_CONF_PS1;
 	timing |= (ps2 << GRCAN_CONF_PS2_BIT) & GRCAN_CONF_PS2;
 	timing |= (scaler << GRCAN_CONF_SCALER_BIT) & GRCAN_CONF_SCALER;
-	netdev_info(dev, "setting timing=0x%x\n", timing);
+	netdev_dbg(dev, "setting timing=0x%x\n", timing);
 	grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);

 	return 0;
 }

+static int grcanfd_set_bittiming(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	struct can_bittiming *bt = &priv->can.bittiming;
+	const char *msg;
+	u32 timing = 0;
+	int sjw, ps1, ps2, scaler;
+
+	/* Should never happen - function will not be called when
+	 * device is up
+	 */
+	if (grcan_read_bits(&regs->ctrl, GRCAN_CTRL_ENABLE))
+		return -EBUSY;
+
+	sjw = bt->sjw;
+	ps1 = (bt->prop_seg + bt->phase_seg1); /* tseg1 */
+	ps2 = bt->phase_seg2;
+	scaler = (bt->brp - 1);
+	netdev_dbg(dev, "Request for SJW=%d, PS1=%d, PS2=%d, SCALER=%d",
+		   sjw, ps1, ps2, scaler);
+	if (sjw > min(ps1, ps2)) {
+		msg = "SJW <= MIN(PS1,PS2) must hold: PS1=%d, PS2=%d, SJW=%d\n";
+		netdev_err(dev, msg, ps1, ps2, sjw);
+		return -EINVAL;
+	}
+	if (ps2 < sjw) {
+		netdev_err(dev, "PS2 >= SJW must hold: PS2=%d, SJW=%d\n",
+			   ps2, sjw);
+		return -EINVAL;
+	}
+
+	timing |= (sjw << GRCANFD_NBTR_SJW_BIT) & GRCANFD_NBTR_SJW;
+	timing |= (ps1 << GRCANFD_NBTR_PS1_BIT) & GRCANFD_NBTR_PS1;
+	timing |= (ps2 << GRCANFD_NBTR_PS2_BIT) & GRCANFD_NBTR_PS2;
+	timing |= (scaler << GRCANFD_NBTR_SCALER_BIT) &
+		  GRCANFD_NBTR_SCALER;
+	netdev_info(dev, "setting timing=0x%x\n", timing);
+	grcan_write_bits(&regs->nbtr, timing, GRCANFD_NBTR_TIMING);
+
+	return 0;
+}
+
 static int grcan_get_berr_counter(const struct net_device *dev,
 				  struct can_berr_counter *bec)
 {
@@ -1569,7 +1693,8 @@ static const struct ethtool_ops grcan_ethtool_ops = {

 static int grcan_setup_netdev(struct platform_device *ofdev,
 			      void __iomem *base,
-			      int irq, u32 ambafreq, bool txbug)
+			      int irq, u32 ambafreq, bool txbug,
+			      const struct grcan_hwcap *hwcap)
 {
 	struct net_device *dev;
 	struct grcan_priv *priv;
@@ -1592,14 +1717,15 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	priv->dev = dev;
 	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
-	priv->can.bittiming_const = &grcan_bittiming_const;
-	priv->can.do_set_bittiming = grcan_set_bittiming;
+	priv->can.bittiming_const = hwcap->bt_const;
+	priv->can.do_set_bittiming = hwcap->set_bittiming;
 	priv->can.do_set_mode = grcan_set_mode;
 	priv->can.do_get_berr_counter = grcan_get_berr_counter;
 	priv->can.clock.freq = ambafreq;
 	priv->can.ctrlmode_supported =
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
 	priv->need_txbug_workaround = txbug;
+	priv->hwcap = hwcap;

 	/* Discover if triple sampling is supported by hardware */
 	regs = priv->regs;
@@ -1644,22 +1770,32 @@ static int grcan_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct device_node *sysid_parent;
+	const struct of_device_id *of_id;
+	const struct grcan_hwcap *hwcap = &grcan_hwcap;
 	struct clk *clk;
 	u32 sysid, ambafreq;
 	int irq, err;
 	void __iomem *base;
 	bool txbug = true;

+	of_id = of_match_device(grcan_match, &ofdev->dev);
+	if (of_id && of_id->data)
+		hwcap = (struct grcan_hwcap *)of_id->data;
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
@@ -1695,7 +1831,7 @@ static int grcan_probe(struct platform_device *ofdev)

 	grcan_sanitize_module_config(ofdev);

-	err = grcan_setup_netdev(ofdev, base, irq, ambafreq, txbug);
+	err = grcan_setup_netdev(ofdev, base, irq, ambafreq, txbug, hwcap);
 	if (err)
 		goto exit_dispose_irq;

@@ -1722,11 +1858,30 @@ static void grcan_remove(struct platform_device *ofdev)
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
+	{.name = "01_0B5", .data = &grcanfd_hwcap},
 	{},
 };

--
2.51.0


