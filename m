Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992E530740E
	for <lists+linux-can@lfdr.de>; Thu, 28 Jan 2021 11:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhA1Krp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Jan 2021 05:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhA1Krg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jan 2021 05:47:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44064C0613ED
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 02:46:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l54pC-0000sp-PI
        for linux-can@vger.kernel.org; Thu, 28 Jan 2021 11:46:54 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6CB7C5D06DA
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 10:46:51 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E32CA5D06B3;
        Thu, 28 Jan 2021 10:46:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d82e6f5d;
        Thu, 28 Jan 2021 10:46:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/8] can: mcp251xfd: mcp251xfd_probe(): use dev_err_probe() to simplify error handling
Date:   Thu, 28 Jan 2021 11:46:44 +0100
Message-Id: <20210128104644.2982125-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128104644.2982125-1-mkl@pengutronix.de>
References: <20210128104644.2982125-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 28 ++++++++-----------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index da5e8e416440..3c5b92911d46 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2849,32 +2849,28 @@ static int mcp251xfd_probe(struct spi_device *spi)
 
 	rx_int = devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
 					 GPIOD_IN);
-	if (PTR_ERR(rx_int) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	else if (IS_ERR(rx_int))
-		return PTR_ERR(rx_int);
+	if (IS_ERR(rx_int))
+		return dev_err_probe(&spi->dev, PTR_ERR(rx_int),
+				     "Failed to get RX-INT!\n");
 
 	reg_vdd = devm_regulator_get_optional(&spi->dev, "vdd");
-	if (PTR_ERR(reg_vdd) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	else if (PTR_ERR(reg_vdd) == -ENODEV)
+	if (PTR_ERR(reg_vdd) == -ENODEV)
 		reg_vdd = NULL;
 	else if (IS_ERR(reg_vdd))
-		return PTR_ERR(reg_vdd);
+		return dev_err_probe(&spi->dev, PTR_ERR(reg_vdd),
+				     "Failed to get VDD regulator!\n");
 
 	reg_xceiver = devm_regulator_get_optional(&spi->dev, "xceiver");
-	if (PTR_ERR(reg_xceiver) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	else if (PTR_ERR(reg_xceiver) == -ENODEV)
+	if (PTR_ERR(reg_xceiver) == -ENODEV)
 		reg_xceiver = NULL;
 	else if (IS_ERR(reg_xceiver))
-		return PTR_ERR(reg_xceiver);
+		return dev_err_probe(&spi->dev, PTR_ERR(reg_xceiver),
+				     "Failed to get Transceiver regulator!\n");
 
 	clk = devm_clk_get(&spi->dev, NULL);
-	if (IS_ERR(clk)) {
-		dev_err(&spi->dev, "No Oscillator (clock) defined.\n");
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		dev_err_probe(&spi->dev, PTR_ERR(clk),
+			      "Failed to get Oscillator (clock)!\n");
 	freq = clk_get_rate(clk);
 
 	/* Sanity check */
-- 
2.29.2


