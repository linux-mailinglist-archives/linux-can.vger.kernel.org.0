Return-Path: <linux-can+bounces-2317-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826039E2F92
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 00:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C48E164A86
	for <lists+linux-can@lfdr.de>; Tue,  3 Dec 2024 23:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913220899C;
	Tue,  3 Dec 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcQxqBma"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595391FA167;
	Tue,  3 Dec 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267622; cv=none; b=t5akf8wiAilhyTOXpG+6eVryd+8ouxrUaLKd9Jotb4cc+ago+DoKIlsXfqs8dcseIqnpnI/SxjDNbt7gpO9NY1xtfvfwOvNCwZeNXoRVX6vBaLNXQNi01bYL4S5AK1MK3hgdSi7TpR/n+u9jUxnmogUtEIdejNxLh59Fco6Kf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267622; c=relaxed/simple;
	bh=CQTV6hANlHbmQV0FushAnt10SYzeIj1tcBidV6jAct8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3ZJjrKAMZbxBEma8mvNz8BRVKE5dQaoJUzVEU29KBv5wIG+VmQQuE3emimQzwY989eRIwv93h/sW3XP1iHy3vlvxa9kf3yelgvsAec6/RNDr6fgT5PwZFuDn9GerOWIMBga+lPzDIOtVtwHg0oMKMilMjoohoQ4onHPIs13bcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcQxqBma; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fccc26ad01so2719875a12.2;
        Tue, 03 Dec 2024 15:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733267620; x=1733872420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/qHYHD0j6f2gQG6GHH9ozFcbBg8+qzdyitn+gpcUTU=;
        b=hcQxqBmaP6fxPLPUnNSkxPOmyIb4qw8Zm+AGK2N+lBPa4y/0K3wg/O2TAPha0Tu1jC
         LRRjgBSXjykSW6jX8McSSkSTbrbOevANgZEPuAUYiKB+LTsoXLoiTDJhChPpiJh6gQxz
         jPuOwIZGurmXORkJxmyHKoIkAC27B8CEHvbYeSN0Jg9r+RJVlqHHytambnW+5Ve0fKj0
         7888apdm0f/G02OY9bIdAJC0n4McD0ttWw9rqoG68V3rtNfgJ0UPwgkhcKyf1H+9xGx2
         YR2TxdUTGa9ea5g0Z4LUHzzQl/2OsJYMpdp/K4lgP6SgPS5AjIjhGfwNmNJhfm8dOvba
         Gnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733267620; x=1733872420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/qHYHD0j6f2gQG6GHH9ozFcbBg8+qzdyitn+gpcUTU=;
        b=aekcd4ZJbpHfq6NuELpUUx9fxhgTcUmvRUCtKnysa96fdr4EdGYV5uncTaugcUCg2L
         NXLIVhnKM/Ff+a8pmp9AdGHJ7+1Nbt04MKp6ZwArcaNBcjQglJ1Dv7I9CpRnLtcMqJvR
         bDSZT3mia6fZNYb7oF9YN9JhBxuVuFoP6qdxzspIcdtvSrecIDkHR1pZwEgRKkMW/xVW
         lU5V+18vnMHD3p3XuBu/n3g9Z1H1W8Y9YIlzITwlmg/vsOzideUMg3u6fz38ZXHTH7fI
         P7ja2mMTHlh0zO4xiFRPAj0s7PzMv1uG5k6u5ONjPmYo7Ri+dtAWq8GWXtmFccfgEWzC
         lySg==
X-Forwarded-Encrypted: i=1; AJvYcCUAdBgBP6pepVvjCkojqWXczVpZZl5ZGvt8zMslSz3H0fLPhAuMgtgSBepJbq2vT7suxyA+PnC6Sjvh+qzY@vger.kernel.org, AJvYcCXWNWkQiFvEemrn1Sdvf+52DnIBbgQ7jGzPFq2ygyGrrILcyW43m0ik6wdIu78w8VmsEsnVvDsSgzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZckPqVvGI7Sf912Gi1kuVmj8g7SJ9o5D9OyJuQTxNArFbsOb
	eKX8rt4hVKvwu5C15WAoy1zEB9rDyxjC4K1KfM7emzE7veXz4xCBRFOTg7Tw1Cs=
X-Gm-Gg: ASbGncvY52UklX9QZa4KTecksejJrE5oZ8hJtEhbtpvqcfYeZan7XGr9k53c4rZ6TWG
	BP3TfXKO2/S7ddMzgyTYZa/8j859vfcfNJMHnGAmYmCxvznYqL/qGLCdkWzDX4ZX/eBm7z6YCO3
	B7px9XEuwW17kX6gXCs86zHuH6NzRAU/Fimsj6190VNzOnsPKW2rWVwzrurTGkyBn2DA5TJzC+x
	DvMo0Oa9CQlnG3Ohw1TcFuUgw==
X-Google-Smtp-Source: AGHT+IGVMfcDPVtWE3Ol2IqAdbZCOhbiWV6BNBpPBbkgI1j/gpvuoNPAyftsebem+CUwNuUv3WH6aA==
X-Received: by 2002:a05:6a20:7f87:b0:1e0:d1db:4d8a with SMTP id adf61e73a8af0-1e1653b7c2bmr6353852637.10.1733267620336;
        Tue, 03 Dec 2024 15:13:40 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c30e43csm10132776a12.39.2024.12.03.15.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:13:39 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	maxime.chevallier@bootlin.com,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-can@vger.kernel.org (open list:CAN NETWORK DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: simplify resource acquisition + ioremap
Date: Tue,  3 Dec 2024 15:13:37 -0800
Message-ID: <20241203231337.182391-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get resource + request_mem_region + ioremap can all be done by a single
function.

Replace them with devm_platform_get_and_ioremap_resource or\
devm_platform_ioremap_resource where res is not used.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/can/sja1000/sja1000_platform.c | 15 ++--------
 drivers/net/ethernet/freescale/fman/fman.c | 35 +++++-----------------
 drivers/net/ethernet/lantiq_etop.c         | 25 ++--------------
 drivers/net/mdio/mdio-octeon.c             | 25 +++-------------
 4 files changed, 17 insertions(+), 83 deletions(-)

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
diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index fb416d60dcd7..11887458f050 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2690,13 +2690,12 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 {
 	struct fman *fman;
 	struct device_node *fm_node, *muram_node;
+	void __iomem *base_addr;
 	struct resource *res;
 	u32 val, range[2];
 	int err, irq;
 	struct clk *clk;
 	u32 clk_rate;
-	phys_addr_t phys_base_addr;
-	resource_size_t mem_size;
 
 	fman = kzalloc(sizeof(*fman), GFP_KERNEL);
 	if (!fman)
@@ -2724,18 +2723,6 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		goto fman_node_put;
 	fman->dts_params.err_irq = err;
 
-	/* Get the FM address */
-	res = platform_get_resource(of_dev, IORESOURCE_MEM, 0);
-	if (!res) {
-		err = -EINVAL;
-		dev_err(&of_dev->dev, "%s: Can't get FMan memory resource\n",
-			__func__);
-		goto fman_node_put;
-	}
-
-	phys_base_addr = res->start;
-	mem_size = resource_size(res);
-
 	clk = of_clk_get(fm_node, 0);
 	if (IS_ERR(clk)) {
 		err = PTR_ERR(clk);
@@ -2803,24 +2790,16 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		}
 	}
 
-	fman->dts_params.res =
-		devm_request_mem_region(&of_dev->dev, phys_base_addr,
-					mem_size, "fman");
-	if (!fman->dts_params.res) {
-		err = -EBUSY;
-		dev_err(&of_dev->dev, "%s: request_mem_region() failed\n",
-			__func__);
-		goto fman_free;
-	}
-
-	fman->dts_params.base_addr =
-		devm_ioremap(&of_dev->dev, phys_base_addr, mem_size);
-	if (!fman->dts_params.base_addr) {
-		err = -ENOMEM;
+	base_addr = devm_platform_get_and_ioremap_resource(of_dev, 0, &res);
+	if (IS_ERR(base_addr)) {
+		err = PTR_ERR(base_addr);
 		dev_err(&of_dev->dev, "%s: devm_ioremap() failed\n", __func__);
 		goto fman_free;
 	}
 
+	fman->dts_params.base_addr = base_addr;
+	fman->dts_params.res = res;
+
 	fman->dev = &of_dev->dev;
 
 	err = of_platform_populate(fm_node, NULL, NULL, &of_dev->dev);
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 660dff5426e7..83ce3bfefa5c 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -90,7 +90,6 @@ struct ltq_etop_priv {
 	struct net_device *netdev;
 	struct platform_device *pdev;
 	struct ltq_eth_data *pldata;
-	struct resource *res;
 
 	struct mii_bus *mii_bus;
 
@@ -643,31 +642,14 @@ ltq_etop_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct ltq_etop_priv *priv;
-	struct resource *res;
 	int err;
 	int i;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get etop resource\n");
-		err = -ENOENT;
-		goto err_out;
-	}
-
-	res = devm_request_mem_region(&pdev->dev, res->start,
-				      resource_size(res), dev_name(&pdev->dev));
-	if (!res) {
-		dev_err(&pdev->dev, "failed to request etop resource\n");
-		err = -EBUSY;
-		goto err_out;
-	}
-
-	ltq_etop_membase = devm_ioremap(&pdev->dev, res->start,
-					resource_size(res));
-	if (!ltq_etop_membase) {
+	ltq_etop_membase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ltq_etop_membase)) {
 		dev_err(&pdev->dev, "failed to remap etop engine %d\n",
 			pdev->id);
-		err = -ENOMEM;
+		err = PTR_ERR(ltq_etop_membase);
 		goto err_out;
 	}
 
@@ -679,7 +661,6 @@ ltq_etop_probe(struct platform_device *pdev)
 	dev->netdev_ops = &ltq_eth_netdev_ops;
 	dev->ethtool_ops = &ltq_etop_ethtool_ops;
 	priv = netdev_priv(dev);
-	priv->res = res;
 	priv->pdev = pdev;
 	priv->pldata = dev_get_platdata(&pdev->dev);
 	priv->netdev = dev;
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


