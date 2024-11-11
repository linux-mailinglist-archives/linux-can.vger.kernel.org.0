Return-Path: <linux-can+bounces-1965-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD0B9C47F6
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 22:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D01B31430
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 21:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2361C2307;
	Mon, 11 Nov 2024 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTixeR4o"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684C1C1F30;
	Mon, 11 Nov 2024 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359002; cv=none; b=OdJiK4OtKRnJ2kqjF2wuDSBzXJspwIFxEyNxo7X6lW/VB2ILSjibTEBsKp4CAFwHzgh8slrKMoyJULduoU74ztVxcb2QvwYaRidu7KJfrdrCaZ4xoE0aDBtS5NzCs1wLVJrnXliok3gLiAOD7y2c6rI9TZVJ6qDMOTj3DFpczh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359002; c=relaxed/simple;
	bh=GUOPboYTEIh6id7hupInI2i+gVO1pqfkEV6X5vI8B5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGH6hVDLMC9FInDPXjJtQHiaZuGlPi7lNzrvOhM2aRCOzzf+yYIg2+angZOP4+TfZ93YF+s18BarItflOUAhU+7eaGA90Vtccr/H/xUsDeUFogmp02iwwH3xoTgXpQ1HLA+yrjH4Oc55cosSEF3n5avwFVt/TIVviSRd3F/oYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTixeR4o; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso3956176a91.3;
        Mon, 11 Nov 2024 13:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731359000; x=1731963800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=azWUPzqegtxwsVeH4tA/deu682NaDN2sJPDW2kMEdrQ=;
        b=hTixeR4oagJYzE7a3jvRwEnuFNYhI2cHQTj/xQDEoW7oEqaflUnj1/uXaFNHnoUdt7
         Uz8d16EooApU2zRdDEbCuEbJqOZ//KZydkTWyk7PIwfbOWaYHlbwbG4w0Yg8KTHhKVTJ
         3imJI7R6vS1RO96jONy+ulLySFVHIlI55HJ21bpPqfSjF8RusfyEzLyKikwGwL7zip0v
         iFTTvkpjOoJp+jGAw6WS0UqWnUuc93wkeexoOw02oQ9z4loRC9HYbYO6wMjwww87/K1l
         Vr1Yh8mgL/ZfeBDEjnKN6jaYnquCf9ZUyEYtqIWKokZyPfaM2lwRGGp3cTQP0CSpmlde
         sRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731359000; x=1731963800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azWUPzqegtxwsVeH4tA/deu682NaDN2sJPDW2kMEdrQ=;
        b=f8lzz5emawSa9/Pac0f8AKvx3HmLS7Sp2BeyF5OZsMdiXm8aqcPrba7Iiwhci+EY/8
         PutwDtAbt/u6BhPlJo56zs87awPiK4FtSdy6tVvHc1WvrZ1YU6LI59itZZmYcr7eNOGp
         8gKsuyGbI7tR/4A4Q1CFWg2Kr3KlesEyymMA4hCJJsGiEJcDFX+tu+aaQ0wVNtJxDL5w
         m2CqhHrTcyoApT9lCI10xW4Y0WlQsU9Il69KcPd0djsiRZWsCbSUKNrs540cOObB9Inc
         KlK/dHX7/bawox7qOE9Y0qNeWeWedSEujo6tWPGpP5//viALRsBaG8RMGIxFTf8zDLYk
         KiEA==
X-Forwarded-Encrypted: i=1; AJvYcCUBV0J0xlwjCFpRajVRnkUG4MojG57ETHyRabS/NOnjYE9FngVnSGqDYGs38AjKZFas+lMiztGKVLY=@vger.kernel.org, AJvYcCUTry2bYP6o0sxhyn98dwjinFDNBo90NIQswolMSNwzRvv6zIh0/b9FXEQG7N9qbU25VtI6DwLax9emNMPr@vger.kernel.org
X-Gm-Message-State: AOJu0YzAK4BPjot9zp1frX97pGeIhVw/Fn5Pg2fYAf1Dr7M7KOIj3uj6
	gkZCA0HnWJjs4Z5mX4noZ/2VSIQPZJ8BOPUPPA6Q78yEOvJ2DVWRwZnpomPD
X-Google-Smtp-Source: AGHT+IF9mm136ZfH42Wc8PlDV1uhfJ4fHvtgeZ2Mx3K3btkIep/FS55/7z34rbpqTLR4aKZtBg7HUg==
X-Received: by 2002:a17:90b:5310:b0:2d3:cd27:c480 with SMTP id 98e67ed59e1d1-2e9b1787df7mr18324281a91.33.1731358999801;
        Mon, 11 Nov 2024 13:03:19 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fe8eb7sm9157309a91.50.2024.11.11.13.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:03:19 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Byungho An <bh74.an@samsung.com>,
	Kevin Brace <kevinbrace@bracecomputerlab.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Michal Simek <michal.simek@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Zhao Qiang <qiang.zhao@nxp.com>,
	linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC FS_ENET DRIVER)
Subject: [PATCHv2 net-next] net: use pdev instead of OF funcs
Date: Mon, 11 Nov 2024 13:03:16 -0800
Message-ID: <20241111210316.15357-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

np here is the node coming from platform_device. No children are used.

I changed irq_of_parse_and_map to platform_get_irq to pass it directly.

I changed of_address_to_resource to platform_get_resource for the same
reason.

It ends up being the same.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fixed compilation errors. Also removed non devm transformations.
 Those will be handled separately. Also reworded description.
 drivers/net/can/grcan.c                          |  2 +-
 drivers/net/can/mscan/mpc5xxx_can.c              |  2 +-
 drivers/net/dsa/bcm_sf2.c                        |  4 ++--
 drivers/net/ethernet/allwinner/sun4i-emac.c      |  2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c     |  6 +++---
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c |  2 +-
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c |  2 +-
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c |  2 +-
 drivers/net/ethernet/freescale/ucc_geth.c        | 12 ++++++------
 drivers/net/ethernet/marvell/mvneta.c            |  2 +-
 drivers/net/ethernet/moxa/moxart_ether.c         |  5 ++---
 .../net/ethernet/samsung/sxgbe/sxgbe_platform.c  |  8 ++++----
 drivers/net/ethernet/via/via-rhine.c             |  2 +-
 drivers/net/ethernet/via/via-velocity.c          |  2 +-
 drivers/net/ethernet/xilinx/ll_temac_mdio.c      |  6 +++---
 drivers/net/mdio/mdio-mux-mmioreg.c              | 16 +++++++++-------
 drivers/net/wan/fsl_ucc_hdlc.c                   | 10 +++++-----
 17 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index cdf0ec9fa7f3..0a2cc0ba219f 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1673,7 +1673,7 @@ static int grcan_probe(struct platform_device *ofdev)
 		goto exit_error;
 	}
 
-	irq = irq_of_parse_and_map(np, GRCAN_IRQIX_IRQ);
+	irq = platform_get_irq(ofdev, GRCAN_IRQIX_IRQ);
 	if (!irq) {
 		dev_err(&ofdev->dev, "no irq found\n");
 		err = -ENODEV;
diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 0080c39ee182..252ad40bdb97 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -300,7 +300,7 @@ static int mpc5xxx_can_probe(struct platform_device *ofdev)
 	if (!base)
 		return dev_err_probe(&ofdev->dev, err, "couldn't ioremap\n");
 
-	irq = irq_of_parse_and_map(np, 0);
+	irq = platform_get_irq(ofdev, 0);
 	if (!irq) {
 		dev_err(&ofdev->dev, "no irq found\n");
 		err = -ENODEV;
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 43bde1f583ff..9229582efd05 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1443,8 +1443,8 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 		of_node_put(ports);
 	}
 
-	priv->irq0 = irq_of_parse_and_map(dn, 0);
-	priv->irq1 = irq_of_parse_and_map(dn, 1);
+	priv->irq0 = platform_get_irq(pdev, 0);
+	priv->irq1 = platform_get_irq(pdev, 1);
 
 	base = &priv->core;
 	for (i = 0; i < BCM_SF2_REGS_NUM; i++) {
diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 2f516b950f4e..18df8d1d93fd 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -995,7 +995,7 @@ static int emac_probe(struct platform_device *pdev)
 
 	/* fill in parameters for net-dev structure */
 	ndev->base_addr = (unsigned long)db->membase;
-	ndev->irq = irq_of_parse_and_map(np, 0);
+	ndev->irq = platform_get_irq(pdev, 0);
 	if (ndev->irq == -ENXIO) {
 		netdev_err(ndev, "No irq resource\n");
 		ret = ndev->irq;
diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
index 6b47a2196a46..67e65a63a36f 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -839,7 +839,7 @@ static int mpc52xx_fec_probe(struct platform_device *op)
 	ndev->netdev_ops	= &mpc52xx_fec_netdev_ops;
 	ndev->ethtool_ops	= &mpc52xx_fec_ethtool_ops;
 	ndev->watchdog_timeo	= FEC_WATCHDOG_TIMEOUT;
-	ndev->base_addr		= mem.start;
+	ndev->base_addr		= mem->start;
 	SET_NETDEV_DEV(ndev, &op->dev);
 
 	spin_lock_init(&priv->lock);
@@ -859,9 +859,9 @@ static int mpc52xx_fec_probe(struct platform_device *op)
 
 	/* Get the IRQ we need one by one */
 		/* Control */
-	ndev->irq = irq_of_parse_and_map(np, 0);
+	ndev->irq = platform_get_irq(op, 0);
 
-		/* RX */
+	/* RX */
 	priv->r_irq = bcom_get_task_irq(priv->rx_dmatsk);
 
 		/* TX */
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
index be63293511d9..8bed0ea11dd1 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
@@ -83,7 +83,7 @@ static int do_pd_setup(struct fs_enet_private *fep)
 	struct fs_platform_info *fpi = fep->fpi;
 	int ret = -EINVAL;
 
-	fep->interrupt = irq_of_parse_and_map(ofdev->dev.of_node, 0);
+	fep->interrupt = platform_get_irq(ofdev, 0);
 	if (!fep->interrupt)
 		goto out;
 
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index f2ecd20027cf..8dbd624b87ac 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -88,7 +88,7 @@ static int do_pd_setup(struct fs_enet_private *fep)
 {
 	struct platform_device *ofdev = to_platform_device(fep->dev);
 
-	fep->interrupt = irq_of_parse_and_map(ofdev->dev.of_node, 0);
+	fep->interrupt = platform_get_irq(ofdev, 0);
 	if (!fep->interrupt)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index 6c97191649de..53d67fb08bad 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -87,7 +87,7 @@ static int do_pd_setup(struct fs_enet_private *fep)
 {
 	struct platform_device *ofdev = to_platform_device(fep->dev);
 
-	fep->interrupt = irq_of_parse_and_map(ofdev->dev.of_node, 0);
+	fep->interrupt = platform_get_irq(ofdev, 0);
 	if (!fep->interrupt)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 30453a20e467..f05b2b6857f6 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3563,7 +3563,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	struct net_device *dev = NULL;
 	struct ucc_geth_private *ugeth = NULL;
 	struct ucc_geth_info *ug_info;
-	struct resource res;
+	struct resource *res;
 	int err, ucc_num, max_speed = 0;
 	const unsigned int *prop;
 	phy_interface_t phy_interface;
@@ -3608,12 +3608,12 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	if (err)
 		return err;
 
-	err = of_address_to_resource(np, 0, &res);
-	if (err)
-		return err;
+	res = platform_get_resource(ofdev, 0, IORESOURCE_MEM);
+	if (!res)
+		return -ENODEV;
 
-	ug_info->uf_info.regs = res.start;
-	ug_info->uf_info.irq = irq_of_parse_and_map(np, 0);
+	ug_info->uf_info.regs = res->start;
+	ug_info->uf_info.irq = platform_get_irq(ofdev, 0);
 
 	ug_info->phy_node = of_parse_phandle(np, "phy-handle", 0);
 	if (!ug_info->phy_node && of_phy_is_fixed_link(np)) {
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 7bb781fb93b5..6039b7794b15 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5511,7 +5511,7 @@ static int mvneta_probe(struct platform_device *pdev)
 		pp->neta_ac5 = true;
 	}
 
-	dev->irq = irq_of_parse_and_map(dn, 0);
+	dev->irq = platform_get_irq(pdev, 0);
 	if (dev->irq == 0)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index 8bd60168624a..d931d439f139 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -454,7 +454,6 @@ static const struct net_device_ops moxart_netdev_ops = {
 static int moxart_mac_probe(struct platform_device *pdev)
 {
 	struct device *p_dev = &pdev->dev;
-	struct device_node *node = p_dev->of_node;
 	struct net_device *ndev;
 	struct moxart_mac_priv_t *priv;
 	struct resource *res;
@@ -465,9 +464,9 @@ static int moxart_mac_probe(struct platform_device *pdev)
 	if (!ndev)
 		return -ENOMEM;
 
-	irq = irq_of_parse_and_map(node, 0);
+	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		netdev_err(ndev, "irq_of_parse_and_map failed\n");
+		netdev_err(ndev, "platform_get_irq failed\n");
 		ret = -EINVAL;
 		goto irq_map_fail;
 	}
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
index 2eccc7617507..4118e35b99e5 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
@@ -111,7 +111,7 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
 	}
 
 	/* Get the SXGBE common INT information */
-	priv->irq  = irq_of_parse_and_map(node, 0);
+	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq <= 0) {
 		dev_err(dev, "sxgbe common irq parsing failed\n");
 		goto err_drv_remove;
@@ -122,7 +122,7 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
 
 	/* Get the TX/RX IRQ numbers */
 	for (i = 0, chan = 1; i < SXGBE_TX_QUEUES; i++) {
-		priv->txq[i]->irq_no = irq_of_parse_and_map(node, chan++);
+		priv->txq[i]->irq_no = platform_get_irq(pdev, chan++);
 		if (priv->txq[i]->irq_no <= 0) {
 			dev_err(dev, "sxgbe tx irq parsing failed\n");
 			goto err_tx_irq_unmap;
@@ -130,14 +130,14 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < SXGBE_RX_QUEUES; i++) {
-		priv->rxq[i]->irq_no = irq_of_parse_and_map(node, chan++);
+		priv->rxq[i]->irq_no = platform_get_irq(pdev, chan++);
 		if (priv->rxq[i]->irq_no <= 0) {
 			dev_err(dev, "sxgbe rx irq parsing failed\n");
 			goto err_rx_irq_unmap;
 		}
 	}
 
-	priv->lpi_irq = irq_of_parse_and_map(node, chan);
+	priv->lpi_irq = platform_get_irq(pdev, chan);
 	if (priv->lpi_irq <= 0) {
 		dev_err(dev, "sxgbe lpi irq parsing failed\n");
 		goto err_rx_irq_unmap;
diff --git a/drivers/net/ethernet/via/via-rhine.c b/drivers/net/ethernet/via/via-rhine.c
index 894911f3d560..f079242c33e2 100644
--- a/drivers/net/ethernet/via/via-rhine.c
+++ b/drivers/net/ethernet/via/via-rhine.c
@@ -1127,7 +1127,7 @@ static int rhine_init_one_platform(struct platform_device *pdev)
 	if (IS_ERR(ioaddr))
 		return PTR_ERR(ioaddr);
 
-	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	irq = platform_get_irq(pdev, 0);
 	if (!irq)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/via/via-velocity.c b/drivers/net/ethernet/via/via-velocity.c
index 72271a51d0e7..e92cc8122c1e 100644
--- a/drivers/net/ethernet/via/via-velocity.c
+++ b/drivers/net/ethernet/via/via-velocity.c
@@ -2950,7 +2950,7 @@ static int velocity_platform_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	irq = platform_get_irq(pdev, 0);
 	if (!irq)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/xilinx/ll_temac_mdio.c b/drivers/net/ethernet/xilinx/ll_temac_mdio.c
index 07a9fb49eda1..4bc5d47ecb7e 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_mdio.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_mdio.c
@@ -69,7 +69,7 @@ int temac_mdio_setup(struct temac_local *lp, struct platform_device *pdev)
 	u32 bus_hz;
 	int clk_div;
 	int rc;
-	struct resource res;
+	struct resource *res;
 
 	/* Get MDIO bus frequency (if specified) */
 	bus_hz = 0;
@@ -98,9 +98,9 @@ int temac_mdio_setup(struct temac_local *lp, struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (np) {
-		of_address_to_resource(np, 0, &res);
+		res = platform_get_resource(pdev, 0, IORESOURCE_MEM);
 		snprintf(bus->id, MII_BUS_ID_SIZE, "%.8llx",
-			 (unsigned long long)res.start);
+			 (unsigned long long)res->start);
 	} else if (pdata) {
 		snprintf(bus->id, MII_BUS_ID_SIZE, "%.8llx",
 			 pdata->mdio_bus_id);
diff --git a/drivers/net/mdio/mdio-mux-mmioreg.c b/drivers/net/mdio/mdio-mux-mmioreg.c
index 9c4b1efd0d53..b5a65a1ab406 100644
--- a/drivers/net/mdio/mdio-mux-mmioreg.c
+++ b/drivers/net/mdio/mdio-mux-mmioreg.c
@@ -98,7 +98,7 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mdio_mux_mmioreg_state *s;
-	struct resource res;
+	struct resource *res;
 	const __be32 *iprop;
 	int len, ret;
 
@@ -108,13 +108,15 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
 	if (!s)
 		return -ENOMEM;
 
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "could not obtain memory map for node %pOF\n", np);
-	s->phys = res.start;
+	res = platform_get_resource(pdev, 0, IORESOURCE_MEM);
+	if (!res) {
+		dev_err(&pdev->dev,
+			"could not obtain memory map for node %pOF\n", np);
+		return -ENODEV;
+	}
+	s->phys = res->start;
 
-	s->iosize = resource_size(&res);
+	s->iosize = resource_size(res);
 	if (s->iosize != sizeof(uint8_t) &&
 	    s->iosize != sizeof(uint16_t) &&
 	    s->iosize != sizeof(uint32_t))
diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index f999798a5612..414a9d22da5e 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1118,7 +1118,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	struct ucc_hdlc_private *uhdlc_priv = NULL;
 	struct ucc_tdm_info *ut_info;
 	struct ucc_tdm *utdm = NULL;
-	struct resource res;
+	struct resource *res;
 	struct net_device *dev;
 	hdlc_device *hdlc;
 	int ucc_num;
@@ -1170,12 +1170,12 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret)
+	res = platform_get_resource(pdev, 0, IORESOURCE_MEM);
+	if (!res)
 		return -EINVAL;
 
-	ut_info->uf_info.regs = res.start;
-	ut_info->uf_info.irq = irq_of_parse_and_map(np, 0);
+	ut_info->uf_info.regs = res->start;
+	ut_info->uf_info.irq = platform_get_irq(pdev, 0);
 
 	uhdlc_priv = kzalloc(sizeof(*uhdlc_priv), GFP_KERNEL);
 	if (!uhdlc_priv)
-- 
2.47.0


