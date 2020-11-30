Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C102C836A
	for <lists+linux-can@lfdr.de>; Mon, 30 Nov 2020 12:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgK3Lng (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Nov 2020 06:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgK3Lng (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Nov 2020 06:43:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C807C0613D2
        for <linux-can@vger.kernel.org>; Mon, 30 Nov 2020 03:42:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kjha2-0004Xs-R4
        for linux-can@vger.kernel.org; Mon, 30 Nov 2020 12:42:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id ED8B759F82B
        for <linux-can@vger.kernel.org>; Mon, 30 Nov 2020 11:42:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BE99C59F828;
        Mon, 30 Nov 2020 11:42:53 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d8f7d990;
        Mon, 30 Nov 2020 11:42:53 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Dan Murphy <dmurphy@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net] can: m_can: tcan4x5x_can_probe(): fix error path: remove erroneous clk_disable_unprepare()
Date:   Mon, 30 Nov 2020 12:42:52 +0100
Message-Id: <20201130114252.215334-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The clocks mcan_class->cclk and mcan_class->hclk are not prepared by any call
during tcan4x5x_can_probe(), so remove erroneous clk_disable_unprepare() on
them.

Fixes: 5443c226ba91 ("can: tcan4x5x: Add tcan4x5x driver to the kernel")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index e5d7d85e0b6d..7347ab39c5b6 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -489,18 +489,18 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	spi->bits_per_word = 32;
 	ret = spi_setup(spi);
 	if (ret)
-		goto out_clk;
+		goto out_m_can_class_free_dev;
 
 	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
 					&spi->dev, &tcan4x5x_regmap);
 	if (IS_ERR(priv->regmap)) {
 		ret = PTR_ERR(priv->regmap);
-		goto out_clk;
+		goto out_m_can_class_free_dev;
 	}
 
 	ret = tcan4x5x_power_enable(priv->power, 1);
 	if (ret)
-		goto out_clk;
+		goto out_m_can_class_free_dev;
 
 	ret = tcan4x5x_parse_config(mcan_class);
 	if (ret)
@@ -519,11 +519,6 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 out_power:
 	tcan4x5x_power_enable(priv->power, 0);
-out_clk:
-	if (!IS_ERR(mcan_class->cclk)) {
-		clk_disable_unprepare(mcan_class->cclk);
-		clk_disable_unprepare(mcan_class->hclk);
-	}
  out_m_can_class_free_dev:
 	m_can_class_free_dev(mcan_class->net);
 	dev_err(&spi->dev, "Probe failed, err=%d\n", ret);
-- 
2.29.2


