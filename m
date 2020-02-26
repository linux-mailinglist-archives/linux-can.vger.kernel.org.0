Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B11E16FBAD
	for <lists+linux-can@lfdr.de>; Wed, 26 Feb 2020 11:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBZKKZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Feb 2020 05:10:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42815 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgBZKKY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2020 05:10:24 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1j6te3-0004EB-0u; Wed, 26 Feb 2020 11:10:23 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Tim Harvey <tharvey@gateworks.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] can: mcp251x: convert to half-duplex SPI
Date:   Wed, 26 Feb 2020 11:10:21 +0100
Message-Id: <20200226101021.2635356-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Tim Harvey <tharvey@gateworks.com>

Some SPI host controllers such as the Cavium Thunder do not support
full-duplex SPI. Using half-duplex transfers allows the driver to work
with those host controllers.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

what about setting up a proper half duplex transfer like this?

Marc

Changes since v1:
- use spi_sync_transfer instead of spi_write_then_read()

 drivers/net/can/spi/mcp251x.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index a3897baa359f..26b7e4cb51ed 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -317,13 +317,26 @@ static int mcp251x_spi_trans(struct spi_device *spi, int len)
 static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = priv->spi_tx_buf,
+			.len = 2,
+		}, {
+			.rx_buf = priv->spi_rx_buf,
+			.len = 1,
+		},
+	};
 	u8 val = 0;
+	int err;
 
 	priv->spi_tx_buf[0] = INSTRUCTION_READ;
 	priv->spi_tx_buf[1] = reg;
 
-	mcp251x_spi_trans(spi, 3);
-	val = priv->spi_rx_buf[2];
+	err = spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
+	if (err)
+		dev_err(&spi->dev, "spi transfer failed: ret = %d\n", err);
+
+	val = priv->spi_rx_buf[0];
 
 	return val;
 }
@@ -331,14 +344,26 @@ static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
 static void mcp251x_read_2regs(struct spi_device *spi, u8 reg, u8 *v1, u8 *v2)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = priv->spi_tx_buf,
+			.len = 2,
+		}, {
+			.rx_buf = priv->spi_rx_buf,
+			.len = 2,
+		},
+	};
+	int err;
 
 	priv->spi_tx_buf[0] = INSTRUCTION_READ;
 	priv->spi_tx_buf[1] = reg;
 
-	mcp251x_spi_trans(spi, 4);
+	err = spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
+	if (err)
+		dev_err(&spi->dev, "spi transfer failed: ret = %d\n", err);
 
-	*v1 = priv->spi_rx_buf[2];
-	*v2 = priv->spi_rx_buf[3];
+	*v1 = priv->spi_rx_buf[0];
+	*v2 = priv->spi_rx_buf[1];
 }
 
 static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
-- 
2.25.0

