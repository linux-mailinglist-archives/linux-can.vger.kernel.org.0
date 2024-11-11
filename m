Return-Path: <linux-can+bounces-1964-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23699C464C
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 21:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D41F22AB4
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 20:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27A91AAE00;
	Mon, 11 Nov 2024 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiPudY6w"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF3D19E98C;
	Mon, 11 Nov 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355338; cv=none; b=Zqf9dwepH36AUlxgvIcKzpSs1fMgf/da8XGBkXeepnQZAtvLzodFLeGMIkCt60oGZ/MxCKWNg98iI3oNBayltEH/3TF+oeJvmtkt8phOZRyOdWIQPVaP2jXElhR1v3yMz2UEzYeUiZ1TLnpf6RrU3BPy5l0O7sjQbPTmqAMnALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355338; c=relaxed/simple;
	bh=4D1l85QyR8kvrkB8OqXUrzYaXOfIaLthk3noRlr99W4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uw8afTEapupwR/s6CI2U5eKnt6Txk+gkrvusc2VYIqWe1hxp1qkUPrnwL4Os7vmzew7x7mCNZ03c3JCJlmUTn1GjwTR5fB/pgneM3+w7iJA8VLyA8LoXABVDKP8TU1/wPEUnFHL478PHApjUITrX5/9VcTmQaY7PXUj+caxyf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiPudY6w; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720e94d36c8so5032677b3a.1;
        Mon, 11 Nov 2024 12:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731355336; x=1731960136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6PNgYUdUs3qyu6UP1eNtyS4o8p+uKeSrqTBe7HQrYKo=;
        b=IiPudY6w3/b/JSIP7sOIGkNPArRfyRNh2vIMjw1oeTlTZWtpVmVPNJc0Y7oTurV6DA
         TQxZXiR9Pvo+hhozQz0osvlbAIuyDmM87YFI2T7c5cQzBAflFIZ85bTbUMVU99RkF5gR
         1L2B38M34NyH/pHIBdOEZ+41b0yWqMts9kMecfnMngrjRMsAEE7SrDNwAn59sSwRiaW2
         YAzkJinB46Qu0wfPyKdo5jyKb7aDcKumdcuAZYXnDPu8XCMgihU5ExlKnXoiRdj5KnBn
         uXO/8ouFOa9TwGILbCm5H9kyYnUM1TLSAGsqaMbzw6m3QNivxR78FH0D2rjYj4n+3f2+
         fxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731355336; x=1731960136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PNgYUdUs3qyu6UP1eNtyS4o8p+uKeSrqTBe7HQrYKo=;
        b=xUuAHIKVGymipQuHwS2Ah/BXYH+g0Yf43Tydvx7nEXk4zUgsFsmnY/62nOaAnYf+VC
         8z3fVih+7W+A/4VTmurY+0w75fQWxdYVH89ITHj7eVAr2EPUHe9c4Lal0uwbTsai7UjQ
         5EgSMHhcycKmxLea+Okqh23Edvx3JNAQlZHLqOL0j2G0j7hL2BFfQ6HrHYn71wqY3uME
         pDcWu1eryX40FwE17rX/UAgETCy4lRxWmiHZlUN+fm2SUX7lWS2dWkEeEXCOT7DuoJsU
         cJKsEwEbxPCfN1KNyMkPxQztEjnRmkj2ETTucnFUKCEYB48jeufbp2sVa5NzKPBBPsGu
         Ir4g==
X-Forwarded-Encrypted: i=1; AJvYcCUuv1lyA+HmiQD3B1gP2ptIjMSu/4RELC3gbfT5v0rETGw9u8tcXH5T1+lvSSUAZQ/COiXJ63H8FuA=@vger.kernel.org, AJvYcCVsrjQHkuEI1PIKf5PO/qk3iBi8R5zkGfImQZJTspNdrj/c2nQcD0GjIV+4or+DZ5xIaTWSb+DmDkyk9eEbxjcAg7E=@vger.kernel.org, AJvYcCWW8PKzLjazQDwyDQfkhroZuq4IXR+YDbrDJ8zg4CpjdL2HGIl0gepVDiFITLWNzMa30YHl2qWkJxc9Zynr@vger.kernel.org
X-Gm-Message-State: AOJu0YyTkb1iwpWvOXuE04bmQC6T+k61HWIIDXWZ3Xhzl1wVESETJ/WI
	fQQGKi3vDuPg9+CZN1I6f82q0XTNR7WxYUh1JRk8cjEMeDXsffB35DOJhY/F
X-Google-Smtp-Source: AGHT+IHdCqVWLkGl5q2t0kBjiLZFPcRABO8VcEpWuvXVm3f7nFYvbSdvQPrRLgF+UBkvXARtTbFsaQ==
X-Received: by 2002:a05:6a20:9150:b0:1d8:a322:6e with SMTP id adf61e73a8af0-1dc20633951mr20691993637.19.1731355335520;
        Mon, 11 Nov 2024 12:02:15 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f67c5dbsm8904450a12.86.2024.11.11.12.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:02:15 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET DRIVER),
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-can@vger.kernel.org (open list:MCAN MMIO DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-renesas-soc@vger.kernel.org (open list:RENESAS ETHERNET SWITCH DRIVER)
Subject: [PATCHv2 net-next] net: modernize ioremap in probe
Date: Mon, 11 Nov 2024 12:02:12 -0800
Message-ID: <20241111200212.5907-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I changed resource acquisition to be performed in a single step. Possible
because devm is used here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fixed compilation errors on PPC and reworded commit message
 drivers/net/can/m_can/m_can_platform.c        | 13 +++-------
 drivers/net/can/sja1000/sja1000_platform.c    | 15 +++--------
 drivers/net/dsa/hirschmann/hellcreek.c        | 18 +++----------
 drivers/net/ethernet/atheros/ag71xx.c         | 13 ++++------
 drivers/net/ethernet/broadcom/bcm63xx_enet.c  |  6 ++---
 drivers/net/ethernet/freescale/xgmac_mdio.c   | 16 ++++--------
 drivers/net/ethernet/marvell/mvmdio.c         | 12 +++------
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 14 ++++-------
 .../ethernet/microchip/lan966x/lan966x_main.c | 16 +++---------
 drivers/net/ethernet/renesas/rswitch.c        |  9 +------
 drivers/net/ethernet/renesas/rtsn.c           | 10 ++------
 drivers/net/ethernet/renesas/sh_eth.c         | 25 +++----------------
 drivers/net/mdio/mdio-bcm-unimac.c            | 11 +++-----
 drivers/net/mdio/mdio-ipq4019.c               |  7 ++----
 drivers/net/mdio/mdio-ipq8064.c               |  6 +----
 drivers/net/mdio/mdio-mux-bcm6368.c           | 11 +++-----
 drivers/net/mdio/mdio-octeon.c                | 25 +++----------------
 17 files changed, 52 insertions(+), 175 deletions(-)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index b832566efda0..dfc0d2834b50 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -79,7 +79,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
 {
 	struct m_can_classdev *mcan_class;
 	struct m_can_plat_priv *priv;
-	struct resource *res;
 	void __iomem *addr;
 	void __iomem *mram_addr;
 	struct phy *transceiver;
@@ -112,15 +111,9 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	}
 
 	/* message ram could be shared */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
-	if (!res) {
-		ret = -ENODEV;
-		goto probe_fail;
-	}
-
-	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!mram_addr) {
-		ret = -ENOMEM;
+	mram_addr = devm_platform_ioremap_resource_byname(pdev, "message_ram");
+	if (IS_ERR(mram_addr)) {
+		ret = PTR_ERR(mram_addr);
 		goto probe_fail;
 	}
 
diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index c42ebe9da55a..2d555f854008 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -230,18 +230,9 @@ static int sp_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res_mem)
-		return -ENODEV;
-
-	if (!devm_request_mem_region(&pdev->dev, res_mem->start,
-				     resource_size(res_mem), DRV_NAME))
-		return -EBUSY;
-
-	addr = devm_ioremap(&pdev->dev, res_mem->start,
-				    resource_size(res_mem));
-	if (!addr)
-		return -ENOMEM;
+	addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res_mem);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
 
 	if (of) {
 		irq = platform_get_irq(pdev, 0);
diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index 283ec5a6e23c..940c4fa6a924 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -1932,7 +1932,6 @@ static int hellcreek_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct hellcreek *hellcreek;
-	struct resource *res;
 	int ret, i;
 
 	hellcreek = devm_kzalloc(dev, sizeof(*hellcreek), GFP_KERNEL);
@@ -1982,23 +1981,12 @@ static int hellcreek_probe(struct platform_device *pdev)
 
 	hellcreek->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tsn");
-	if (!res) {
-		dev_err(dev, "No memory region provided!\n");
-		return -ENODEV;
-	}
-
-	hellcreek->base = devm_ioremap_resource(dev, res);
+	hellcreek->base = devm_platform_ioremap_resource_byname(pdev, "tsn");
 	if (IS_ERR(hellcreek->base))
 		return PTR_ERR(hellcreek->base);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ptp");
-	if (!res) {
-		dev_err(dev, "No PTP memory region provided!\n");
-		return -ENODEV;
-	}
-
-	hellcreek->ptp_base = devm_ioremap_resource(dev, res);
+	hellcreek->ptp_base =
+		devm_platform_ioremap_resource_byname(pdev, "ptp");
 	if (IS_ERR(hellcreek->ptp_base))
 		return PTR_ERR(hellcreek->ptp_base);
 
diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 3d4c3d8698e2..928d27b51b2a 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1798,15 +1798,16 @@ static int ag71xx_probe(struct platform_device *pdev)
 	if (!ndev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
 	dcfg = of_device_get_match_data(&pdev->dev);
 	if (!dcfg)
 		return -EINVAL;
 
 	ag = netdev_priv(ndev);
+
+	ag->mac_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(ag->mac_base))
+		return PTR_ERR(ag->mac_base);
+
 	ag->mac_idx = -1;
 	for (i = 0; i < ARRAY_SIZE(ar71xx_addr_ar7100); i++) {
 		if (ar71xx_addr_ar7100[i] == res->start)
@@ -1836,10 +1837,6 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(ag->mac_reset),
 				     "missing mac reset");
 
-	ag->mac_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(ag->mac_base))
-		return PTR_ERR(ag->mac_base);
-
 	/* ensure that HW is in manual polling mode before interrupts are
 	 * activated. Otherwise ag71xx_interrupt might call napi_schedule
 	 * before it is initialized by netif_napi_add.
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 65e3a0656a4c..420317abe3d2 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -2646,16 +2646,14 @@ static int bcm_enetsw_probe(struct platform_device *pdev)
 	struct bcm_enet_priv *priv;
 	struct net_device *dev;
 	struct bcm63xx_enetsw_platform_data *pd;
-	struct resource *res_mem;
 	int ret, irq_rx, irq_tx;
 
 	if (!bcm_enet_shared_base[0])
 		return -EPROBE_DEFER;
 
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq_rx = platform_get_irq(pdev, 0);
 	irq_tx = platform_get_irq(pdev, 1);
-	if (!res_mem || irq_rx < 0)
+	if (irq_rx < 0)
 		return -ENODEV;
 
 	dev = alloc_etherdev(sizeof(*priv));
@@ -2688,7 +2686,7 @@ static int bcm_enetsw_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
-	priv->base = devm_ioremap_resource(&pdev->dev, res_mem);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
 		goto out;
diff --git a/drivers/net/ethernet/freescale/xgmac_mdio.c b/drivers/net/ethernet/freescale/xgmac_mdio.c
index 65dc07d0df0f..dbd0a5df509e 100644
--- a/drivers/net/ethernet/freescale/xgmac_mdio.c
+++ b/drivers/net/ethernet/freescale/xgmac_mdio.c
@@ -381,16 +381,16 @@ static int xgmac_mdio_probe(struct platform_device *pdev)
 	 * subdevice areas. Therefore, MDIO cannot claim exclusive access to
 	 * this register area.
 	 */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "could not obtain address\n");
-		return -EINVAL;
-	}
 
 	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(struct mdio_fsl_priv));
 	if (!bus)
 		return -ENOMEM;
 
+	priv = bus->priv;
+	priv->mdio_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(priv->mdio_base))
+		return PTR_ERR(priv->mdio_base);
+
 	bus->name = "Freescale XGMAC MDIO Bus";
 	bus->read = xgmac_mdio_read_c22;
 	bus->write = xgmac_mdio_write_c22;
@@ -399,12 +399,6 @@ static int xgmac_mdio_probe(struct platform_device *pdev)
 	bus->parent = &pdev->dev;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%pa", &res->start);
 
-	priv = bus->priv;
-	priv->mdio_base = devm_ioremap(&pdev->dev, res->start,
-				       resource_size(res));
-	if (!priv->mdio_base)
-		return -ENOMEM;
-
 	/* For both ACPI and DT cases, endianness of MDIO controller
 	 * needs to be specified using "little-endian" property.
 	 */
diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 3f4447e68888..ad1dddfa6ea8 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -291,12 +291,6 @@ static int orion_mdio_probe(struct platform_device *pdev)
 
 	type = (uintptr_t)device_get_match_data(&pdev->dev);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		dev_err(&pdev->dev, "No SMI register address given\n");
-		return -ENODEV;
-	}
-
 	bus = devm_mdiobus_alloc_size(&pdev->dev,
 				      sizeof(struct orion_mdio_dev));
 	if (!bus)
@@ -319,10 +313,10 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	bus->parent = &pdev->dev;
 
 	dev = bus->priv;
-	dev->regs = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (!dev->regs) {
+	dev->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
+	if (IS_ERR(dev->regs)) {
 		dev_err(&pdev->dev, "Unable to remap SMI register\n");
-		return -ENODEV;
+		return PTR_ERR(dev->regs);
 	}
 
 	init_waitqueue_head(&dev->smi_busy_wait);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 571631a30320..faf853edc0db 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7425,21 +7425,17 @@ static int mvpp2_init(struct platform_device *pdev, struct mvpp2 *priv)
 static int mvpp2_get_sram(struct platform_device *pdev,
 			  struct mvpp2 *priv)
 {
-	struct resource *res;
 	void __iomem *base;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	if (!res) {
+	base = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(base)) {
 		if (has_acpi_companion(&pdev->dev))
 			dev_warn(&pdev->dev, "ACPI is too old, Flow control not supported\n");
 		else
-			dev_warn(&pdev->dev, "DT is too old, Flow control not supported\n");
-		return 0;
-	}
-
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
+			dev_warn(&pdev->dev,
+				 "DT is too old, Flow control not supported\n");
 		return PTR_ERR(base);
+	}
 
 	priv->cm3_base = base;
 	return 0;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 3234a960fcc3..375e9a68b9a9 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -77,20 +77,12 @@ static int lan966x_create_targets(struct platform_device *pdev,
 	 * this.
 	 */
 	for (idx = 0; idx < IO_RANGES; idx++) {
-		iores[idx] = platform_get_resource(pdev, IORESOURCE_MEM,
-						   idx);
-		if (!iores[idx]) {
-			dev_err(&pdev->dev, "Invalid resource\n");
-			return -EINVAL;
-		}
-
-		begin[idx] = devm_ioremap(&pdev->dev,
-					  iores[idx]->start,
-					  resource_size(iores[idx]));
-		if (!begin[idx]) {
+		begin[idx] = devm_platform_get_and_ioremap_resource(
+			pdev, idx, &iores[idx]);
+		if (IS_ERR(begin[idx])) {
 			dev_err(&pdev->dev, "Unable to get registers: %s\n",
 				iores[idx]->name);
-			return -ENOMEM;
+			return PTR_ERR(begin[idx]);
 		}
 	}
 
diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 8d18dae4d8fb..8ef52fc46a01 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -2046,15 +2046,8 @@ static int renesas_eth_sw_probe(struct platform_device *pdev)
 {
 	const struct soc_device_attribute *attr;
 	struct rswitch_private *priv;
-	struct resource *res;
 	int ret;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "secure_base");
-	if (!res) {
-		dev_err(&pdev->dev, "invalid resource\n");
-		return -EINVAL;
-	}
-
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -2074,7 +2067,7 @@ static int renesas_eth_sw_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 	priv->pdev = pdev;
-	priv->addr = devm_ioremap_resource(&pdev->dev, res);
+	priv->addr = devm_platform_ioremap_resource_byname(pdev, "secure_base");
 	if (IS_ERR(priv->addr))
 		return PTR_ERR(priv->addr);
 
diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
index 6b3f7fca8d15..bfe08facc707 100644
--- a/drivers/net/ethernet/renesas/rtsn.c
+++ b/drivers/net/ethernet/renesas/rtsn.c
@@ -1297,14 +1297,8 @@ static int rtsn_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &rtsn_netdev_ops;
 	ndev->ethtool_ops = &rtsn_ethtool_ops;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gptp");
-	if (!res) {
-		dev_err(&pdev->dev, "Can't find gptp resource\n");
-		ret = -EINVAL;
-		goto error_free;
-	}
-
-	priv->ptp_priv->addr = devm_ioremap_resource(&pdev->dev, res);
+	priv->ptp_priv->addr =
+		devm_platform_ioremap_resource_byname(pdev, "gptp");
 	if (IS_ERR(priv->ptp_priv->addr)) {
 		ret = PTR_ERR(priv->ptp_priv->addr);
 		goto error_free;
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index d072f394eecb..07d1f1504a97 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3351,31 +3351,12 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 
 	if (mdp->cd->tsu) {
 		int port = pdev->id < 0 ? 0 : pdev->id % 2;
-		struct resource *rtsu;
 
-		rtsu = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		if (!rtsu) {
-			dev_err(&pdev->dev, "no TSU resource\n");
-			ret = -ENODEV;
-			goto out_release;
-		}
-		/* We can only request the  TSU region  for the first port
-		 * of the two  sharing this TSU for the probe to succeed...
-		 */
-		if (port == 0 &&
-		    !devm_request_mem_region(&pdev->dev, rtsu->start,
-					     resource_size(rtsu),
-					     dev_name(&pdev->dev))) {
-			dev_err(&pdev->dev, "can't request TSU resource.\n");
-			ret = -EBUSY;
-			goto out_release;
-		}
 		/* ioremap the TSU registers */
-		mdp->tsu_addr = devm_ioremap(&pdev->dev, rtsu->start,
-					     resource_size(rtsu));
-		if (!mdp->tsu_addr) {
+		mdp->tsu_addr = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(mdp->tsu_addr)) {
 			dev_err(&pdev->dev, "TSU region ioremap() failed.\n");
-			ret = -ENOMEM;
+			ret = PTR_ERR(mdp->tsu_addr);
 			goto out_release;
 		}
 		mdp->port = port;
diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 074d96328f41..9796294d465a 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -239,7 +239,6 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 	struct unimac_mdio_priv *priv;
 	struct device_node *np;
 	struct mii_bus *bus;
-	struct resource *r;
 	int ret;
 
 	np = pdev->dev.of_node;
@@ -248,17 +247,13 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r)
-		return -EINVAL;
-
 	/* Just ioremap, as this MDIO block is usually integrated into an
 	 * Ethernet MAC controller register range
 	 */
-	priv->base = devm_ioremap(&pdev->dev, r->start, resource_size(r));
-	if (!priv->base) {
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base)) {
 		dev_err(&pdev->dev, "failed to remap register\n");
-		return -ENOMEM;
+		return PTR_ERR(priv->base);
 	}
 
 	if (of_property_read_u32(np, "clock-frequency", &priv->clk_freq))
diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index dd3ed2d6430b..725e5c13d212 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -256,7 +256,7 @@ static int ipq_mdio_reset(struct mii_bus *bus)
 	/* To indicate CMN_PLL that ethernet_ldo has been ready if platform resource 1
 	 * is specified in the device tree.
 	 */
-	if (priv->eth_ldo_rdy) {
+	if (!IS_ERR(priv->eth_ldo_rdy)) {
 		val = readl(priv->eth_ldo_rdy);
 		val |= BIT(0);
 		writel(val, priv->eth_ldo_rdy);
@@ -327,7 +327,6 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 {
 	struct ipq4019_mdio_data *priv;
 	struct mii_bus *bus;
-	struct resource *res;
 	int ret;
 
 	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*priv));
@@ -351,9 +350,7 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 
 	/* The platform resource is provided on the chipset IPQ5018 */
 	/* This resource is optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res)
-		priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
+	priv->eth_ldo_rdy = devm_platform_ioremap_resource(pdev, 1);
 
 	bus->name = "ipq4019_mdio";
 	bus->read = ipq4019_mdio_read_c22;
diff --git a/drivers/net/mdio/mdio-ipq8064.c b/drivers/net/mdio/mdio-ipq8064.c
index 6253a9ab8b69..716b22e9b93c 100644
--- a/drivers/net/mdio/mdio-ipq8064.c
+++ b/drivers/net/mdio/mdio-ipq8064.c
@@ -111,15 +111,11 @@ ipq8064_mdio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ipq8064_mdio *priv;
-	struct resource res;
 	struct mii_bus *bus;
 	void __iomem *base;
 	int ret;
 
-	if (of_address_to_resource(np, 0, &res))
-		return -ENOMEM;
-
-	base = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (!base)
 		return -ENOMEM;
 
diff --git a/drivers/net/mdio/mdio-mux-bcm6368.c b/drivers/net/mdio/mdio-mux-bcm6368.c
index 476f8b72d020..fa369ff7d45c 100644
--- a/drivers/net/mdio/mdio-mux-bcm6368.c
+++ b/drivers/net/mdio/mdio-mux-bcm6368.c
@@ -90,7 +90,6 @@ static int bcm6368_mdiomux_probe(struct platform_device *pdev)
 {
 	struct bcm6368_mdiomux_desc *md;
 	struct mii_bus *bus;
-	struct resource *res;
 	int rc;
 
 	md = devm_kzalloc(&pdev->dev, sizeof(*md), GFP_KERNEL);
@@ -98,18 +97,14 @@ static int bcm6368_mdiomux_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	md->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
 	/*
 	 * Just ioremap, as this MDIO block is usually integrated into an
 	 * Ethernet MAC controller register range
 	 */
-	md->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!md->base) {
+	md->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(md->base)) {
 		dev_err(&pdev->dev, "failed to ioremap register\n");
-		return -ENOMEM;
+		return PTR_ERR(md->base);
 	}
 
 	md->mii_bus = devm_mdiobus_alloc(&pdev->dev);
diff --git a/drivers/net/mdio/mdio-octeon.c b/drivers/net/mdio/mdio-octeon.c
index 2beb83154d39..cb53dccbde1a 100644
--- a/drivers/net/mdio/mdio-octeon.c
+++ b/drivers/net/mdio/mdio-octeon.c
@@ -17,37 +17,20 @@ static int octeon_mdiobus_probe(struct platform_device *pdev)
 {
 	struct cavium_mdiobus *bus;
 	struct mii_bus *mii_bus;
-	struct resource *res_mem;
-	resource_size_t mdio_phys;
-	resource_size_t regsize;
 	union cvmx_smix_en smi_en;
-	int err = -ENOENT;
+	int err;
 
 	mii_bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*bus));
 	if (!mii_bus)
 		return -ENOMEM;
 
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res_mem == NULL) {
-		dev_err(&pdev->dev, "found no memory resource\n");
-		return -ENXIO;
-	}
-
 	bus = mii_bus->priv;
 	bus->mii_bus = mii_bus;
-	mdio_phys = res_mem->start;
-	regsize = resource_size(res_mem);
 
-	if (!devm_request_mem_region(&pdev->dev, mdio_phys, regsize,
-				     res_mem->name)) {
-		dev_err(&pdev->dev, "request_mem_region failed\n");
-		return -ENXIO;
-	}
-
-	bus->register_base = devm_ioremap(&pdev->dev, mdio_phys, regsize);
-	if (!bus->register_base) {
+	bus->register_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(bus->register_base)) {
 		dev_err(&pdev->dev, "dev_ioremap failed\n");
-		return -ENOMEM;
+		return PTR_ERR(bus->register_base);
 	}
 
 	smi_en.u64 = 0;
-- 
2.47.0


