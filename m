Return-Path: <linux-can+bounces-5011-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5D1B9F1E6
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776C6326304
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207983019BB;
	Thu, 25 Sep 2025 12:14:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C742FFFBC
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802446; cv=none; b=cj9EBX0Okyeex4AUNGKDIZsJxsaJTT8JLxmsqFqV67WNrGcY9U3tNSF6DMpNWQd1tj6Fr4EybmCPHn62BHPeHFYX/YZBzrFIq8JigDRNzZ1aion5MPeMlI/sDuMVhDoVyhdzhhl0sadTODmpqh71f95qf2CHPC1qSj46wh0+wqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802446; c=relaxed/simple;
	bh=mXR2/lLk1fN04LxFhL0kc6sgrTlJVDYCLSN7FHfUkyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6bvrgnC97ePNLlhdjcw3pM0eYYc0yGnLKkHF+qMeBQcuUB1e6JoS4ORXuophWKwsQeSNW0zGAbwaSUTHox1ZpCin6qaFDjImxv8ovgCdy1HlPo0b1fALuM9I8fO7KTljVgesQotAmKj5cbMRiyYtkvBdct+lXEKr5qd6eENjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqz-0000Vn-2S; Thu, 25 Sep 2025 14:13:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqt-000PvV-2S;
	Thu, 25 Sep 2025 14:13:35 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7BC66479976;
	Thu, 25 Sep 2025 12:13:35 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/48] can: rcar_can: Add helper variable dev to rcar_can_probe()
Date: Thu, 25 Sep 2025 14:07:47 +0200
Message-ID: <20250925121332.848157-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

rcar_can_probe() has many users of "pdev->dev".  Introduce a shorthand
to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/baf34c8bef5625ae73c830dbb3c617eb8f7adddd.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 5b0b495d127c..57030992141c 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -738,6 +738,7 @@ static const char * const clock_names[] = {
 
 static int rcar_can_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct rcar_can_priv *priv;
 	struct net_device *ndev;
 	void __iomem *addr;
@@ -745,7 +746,7 @@ static int rcar_can_probe(struct platform_device *pdev)
 	int err = -ENODEV;
 	int irq;
 
-	of_property_read_u32(pdev->dev.of_node, "renesas,can-clock-select",
+	of_property_read_u32(dev->of_node, "renesas,can-clock-select",
 			     &clock_select);
 
 	irq = platform_get_irq(pdev, 0);
@@ -762,30 +763,29 @@ static int rcar_can_probe(struct platform_device *pdev)
 
 	ndev = alloc_candev(sizeof(struct rcar_can_priv), RCAR_CAN_FIFO_DEPTH);
 	if (!ndev) {
-		dev_err(&pdev->dev, "alloc_candev() failed\n");
+		dev_err(dev, "alloc_candev() failed\n");
 		err = -ENOMEM;
 		goto fail;
 	}
 
 	priv = netdev_priv(ndev);
 
-	priv->clk = devm_clk_get(&pdev->dev, "clkp1");
+	priv->clk = devm_clk_get(dev, "clkp1");
 	if (IS_ERR(priv->clk)) {
 		err = PTR_ERR(priv->clk);
-		dev_err(&pdev->dev, "cannot get peripheral clock, error %d\n",
-			err);
+		dev_err(dev, "cannot get peripheral clock, error %d\n", err);
 		goto fail_clk;
 	}
 
 	if (!(BIT(clock_select) & RCAR_SUPPORTED_CLOCKS)) {
 		err = -EINVAL;
-		dev_err(&pdev->dev, "invalid CAN clock selected\n");
+		dev_err(dev, "invalid CAN clock selected\n");
 		goto fail_clk;
 	}
-	priv->can_clk = devm_clk_get(&pdev->dev, clock_names[clock_select]);
+	priv->can_clk = devm_clk_get(dev, clock_names[clock_select]);
 	if (IS_ERR(priv->can_clk)) {
 		err = PTR_ERR(priv->can_clk);
-		dev_err(&pdev->dev, "cannot get CAN clock, error %d\n", err);
+		dev_err(dev, "cannot get CAN clock, error %d\n", err);
 		goto fail_clk;
 	}
 
@@ -802,18 +802,17 @@ static int rcar_can_probe(struct platform_device *pdev)
 	priv->can.do_get_berr_counter = rcar_can_get_berr_counter;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
 	platform_set_drvdata(pdev, ndev);
-	SET_NETDEV_DEV(ndev, &pdev->dev);
+	SET_NETDEV_DEV(ndev, dev);
 
 	netif_napi_add_weight(ndev, &priv->napi, rcar_can_rx_poll,
 			      RCAR_CAN_NAPI_WEIGHT);
 	err = register_candev(ndev);
 	if (err) {
-		dev_err(&pdev->dev, "register_candev() failed, error %d\n",
-			err);
+		dev_err(dev, "register_candev() failed, error %d\n", err);
 		goto fail_candev;
 	}
 
-	dev_info(&pdev->dev, "device registered (IRQ%d)\n", ndev->irq);
+	dev_info(dev, "device registered (IRQ%d)\n", ndev->irq);
 
 	return 0;
 fail_candev:
-- 
2.51.0


