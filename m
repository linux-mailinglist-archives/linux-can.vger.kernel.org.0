Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2371334E503
	for <lists+linux-can@lfdr.de>; Tue, 30 Mar 2021 12:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhC3KDM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Mar 2021 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhC3KCw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Mar 2021 06:02:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C63DC061574
        for <linux-can@vger.kernel.org>; Tue, 30 Mar 2021 03:02:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lRBD0-0001W9-L8
        for linux-can@vger.kernel.org; Tue, 30 Mar 2021 12:02:50 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id AFA2E603CAF
        for <linux-can@vger.kernel.org>; Tue, 30 Mar 2021 10:02:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5A7B4603CAB;
        Tue, 30 Mar 2021 10:02:49 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 02e1d26f;
        Tue, 30 Mar 2021 10:02:48 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH] can: mcp251x: fix support for half duplex SPI host controllers
Date:   Tue, 30 Mar 2021 12:02:46 +0200
Message-Id: <20210330100246.1074375-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Some SPI host controllers do not support full-duplex SPI transfers.

The function mcp251x_spi_trans() does a full duplex transfer. It is
used in several places in the driver, where a TX half duplex transfer
is sufficient.

To fix support for half duplex SPI host controllers, this patch
introduces a new function mcp251x_spi_write() and changes all callers
that do a TX half duplex transfer to use mcp251x_spi_write().

Fixes: e0e25001d088 ("can: mcp251x: add support for half duplex controllers")
Cc: Tim Harvey <tharvey@gateworks.com>
Reported-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 80ab1593ca31..492f1bcb0516 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -314,6 +314,18 @@ static int mcp251x_spi_trans(struct spi_device *spi, int len)
 	return ret;
 }
 
+static int mcp251x_spi_write(struct spi_device *spi, int len)
+{
+	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+	int ret;
+
+	ret = spi_write(spi, priv->spi_tx_buf, len);
+	if (ret)
+		dev_err(&spi->dev, "spi write failed: ret = %d\n", ret);
+
+	return ret;
+}
+
 static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
@@ -361,7 +373,7 @@ static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
 	priv->spi_tx_buf[1] = reg;
 	priv->spi_tx_buf[2] = val;
 
-	mcp251x_spi_trans(spi, 3);
+	mcp251x_spi_write(spi, 3);
 }
 
 static void mcp251x_write_2regs(struct spi_device *spi, u8 reg, u8 v1, u8 v2)
@@ -373,7 +385,7 @@ static void mcp251x_write_2regs(struct spi_device *spi, u8 reg, u8 v1, u8 v2)
 	priv->spi_tx_buf[2] = v1;
 	priv->spi_tx_buf[3] = v2;
 
-	mcp251x_spi_trans(spi, 4);
+	mcp251x_spi_write(spi, 4);
 }
 
 static void mcp251x_write_bits(struct spi_device *spi, u8 reg,
@@ -386,7 +398,7 @@ static void mcp251x_write_bits(struct spi_device *spi, u8 reg,
 	priv->spi_tx_buf[2] = mask;
 	priv->spi_tx_buf[3] = val;
 
-	mcp251x_spi_trans(spi, 4);
+	mcp251x_spi_write(spi, 4);
 }
 
 static u8 mcp251x_read_stat(struct spi_device *spi)
@@ -618,7 +630,7 @@ static void mcp251x_hw_tx_frame(struct spi_device *spi, u8 *buf,
 					  buf[i]);
 	} else {
 		memcpy(priv->spi_tx_buf, buf, TXBDAT_OFF + len);
-		mcp251x_spi_trans(spi, TXBDAT_OFF + len);
+		mcp251x_spi_write(spi, TXBDAT_OFF + len);
 	}
 }
 
@@ -650,7 +662,7 @@ static void mcp251x_hw_tx(struct spi_device *spi, struct can_frame *frame,
 
 	/* use INSTRUCTION_RTS, to avoid "repeated frame problem" */
 	priv->spi_tx_buf[0] = INSTRUCTION_RTS(1 << tx_buf_idx);
-	mcp251x_spi_trans(priv->spi, 1);
+	mcp251x_spi_write(priv->spi, 1);
 }
 
 static void mcp251x_hw_rx_frame(struct spi_device *spi, u8 *buf,
@@ -888,7 +900,7 @@ static int mcp251x_hw_reset(struct spi_device *spi)
 	mdelay(MCP251X_OST_DELAY_MS);
 
 	priv->spi_tx_buf[0] = INSTRUCTION_RESET;
-	ret = mcp251x_spi_trans(spi, 1);
+	ret = mcp251x_spi_write(spi, 1);
 	if (ret)
 		return ret;
 
-- 
2.30.2


