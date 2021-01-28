Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8685A307410
	for <lists+linux-can@lfdr.de>; Thu, 28 Jan 2021 11:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhA1Krs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 28 Jan 2021 05:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhA1Krf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Jan 2021 05:47:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829FAC061756
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 02:46:55 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l54pB-0000qt-U4
        for linux-can@vger.kernel.org; Thu, 28 Jan 2021 11:46:53 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E4F445D06CC
        for <linux-can@vger.kernel.org>; Thu, 28 Jan 2021 10:46:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5DAB65D06AB;
        Thu, 28 Jan 2021 10:46:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 11404362;
        Thu, 28 Jan 2021 10:46:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/8] can: mcp251xfd: mcp251xfd_probe(): remove known bad combinations from errata tabe
Date:   Thu, 28 Jan 2021 11:46:39 +0100
Message-Id: <20210128104644.2982125-4-mkl@pengutronix.de>
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

The published errata specify the maximum allowed SPI frequency to be
max 85% of (FSYSCLK/2). So there's no need to track known bad clock
settings in the driver. As the setup of known good values is a bit
tricky, keep them.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index c6ccd0054152..d51d11fd7064 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2945,18 +2945,15 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	 * Ensure that FSCK is less than or equal to 0.85 *
 	 * (FSYSCLK/2).
 	 *
-	 * Known good and bad combinations are:
+	 * Known good combinations are:
 	 *
-	 * MCP	ext-clk	SoC			SPI			SPI-clk		max-clk	parent-clk	Status	config
+	 * MCP	ext-clk	SoC			SPI			SPI-clk		max-clk	parent-clk	config
 	 *
-	 * 2518	20 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	 8333333 Hz	 83.33%	600000000 Hz	good	assigned-clocks = <&ccu CLK_SPIx>
-	 * 2518	20 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	 9375000 Hz	 93.75%	600000000 Hz	bad	assigned-clocks = <&ccu CLK_SPIx>
-	 * 2518	40 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	16666667 Hz	 83.33%	600000000 Hz	good	assigned-clocks = <&ccu CLK_SPIx>
-	 * 2518	40 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	18750000 Hz	 93.75%	600000000 Hz	bad	assigned-clocks = <&ccu CLK_SPIx>
-	 * 2517	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	good	default
-	 * 2518	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	good	default
-	 * 2517	20 MHz	fsl,imx8mm		fsl,imx51-ecspi		 8333333 Hz	 83.33%	 16666667 Hz	good	assigned-clocks = <&clk IMX8MM_CLK_ECSPIx_ROOT>
-	 * 2517	20 MHz	fsl,imx8mm		fsl,imx51-ecspi		 9523809 Hz	 95.34%	 28571429 Hz	bad	assigned-clocks = <&clk IMX8MM_CLK_ECSPIx_ROOT>
+	 * 2518	20 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	 8333333 Hz	 83.33%	600000000 Hz	assigned-clocks = <&ccu CLK_SPIx>
+	 * 2518	40 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	16666667 Hz	 83.33%	600000000 Hz	assigned-clocks = <&ccu CLK_SPIx>
+	 * 2517	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	default
+	 * 2518	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	default
+	 * 2517	20 MHz	fsl,imx8mm		fsl,imx51-ecspi		 8333333 Hz	 83.33%	 16666667 Hz	assigned-clocks = <&clk IMX8MM_CLK_ECSPIx_ROOT>
 	 *
 	 */
 	priv->spi_max_speed_hz_orig = spi->max_speed_hz;
-- 
2.29.2


