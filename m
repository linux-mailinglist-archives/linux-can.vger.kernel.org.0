Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD4A26B1C8
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 00:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgIOWgP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 18:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgIOWfz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA91DC0611C2
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:41 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJY3-0002Tb-S4; Wed, 16 Sep 2020 00:35:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Tim Harvey <tharvey@gateworks.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 29/37] can: mcp251x: add support for half duplex controllers
Date:   Wed, 16 Sep 2020 00:35:19 +0200
Message-Id: <20200915223527.1417033-30-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
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

Some SPI host controllers do not support full-duplex SPI and are
marked as such via the SPI_CONTROLLER_HALF_DUPLEX controller flag.

For such controllers use half duplex transactions but retain full
duplex transactions for the controllers that can handle those.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Link: https://lore.kernel.org/r/1595516275-1179-1-git-send-email-tharvey@gateworks.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 3bf57bc9b3ff..22d814ae4edc 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -322,8 +322,12 @@ static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
 	priv->spi_tx_buf[0] = INSTRUCTION_READ;
 	priv->spi_tx_buf[1] = reg;
 
-	mcp251x_spi_trans(spi, 3);
-	val = priv->spi_rx_buf[2];
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+		spi_write_then_read(spi, priv->spi_tx_buf, 2, &val, 1);
+	} else {
+		mcp251x_spi_trans(spi, 3);
+		val = priv->spi_rx_buf[2];
+	}
 
 	return val;
 }
@@ -335,10 +339,18 @@ static void mcp251x_read_2regs(struct spi_device *spi, u8 reg, u8 *v1, u8 *v2)
 	priv->spi_tx_buf[0] = INSTRUCTION_READ;
 	priv->spi_tx_buf[1] = reg;
 
-	mcp251x_spi_trans(spi, 4);
+	if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+		u8 val[2] = { 0 };
 
-	*v1 = priv->spi_rx_buf[2];
-	*v2 = priv->spi_rx_buf[3];
+		spi_write_then_read(spi, priv->spi_tx_buf, 2, val, 2);
+		*v1 = val[0];
+		*v2 = val[1];
+	} else {
+		mcp251x_spi_trans(spi, 4);
+
+		*v1 = priv->spi_rx_buf[2];
+		*v2 = priv->spi_rx_buf[3];
+	}
 }
 
 static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
@@ -657,8 +669,16 @@ static void mcp251x_hw_rx_frame(struct spi_device *spi, u8 *buf,
 			buf[i] = mcp251x_read_reg(spi, RXBCTRL(buf_idx) + i);
 	} else {
 		priv->spi_tx_buf[RXBCTRL_OFF] = INSTRUCTION_READ_RXB(buf_idx);
-		mcp251x_spi_trans(spi, SPI_TRANSFER_BUF_LEN);
-		memcpy(buf, priv->spi_rx_buf, SPI_TRANSFER_BUF_LEN);
+		if (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+			spi_write_then_read(spi, priv->spi_tx_buf, 1,
+					    priv->spi_rx_buf,
+					    SPI_TRANSFER_BUF_LEN);
+			memcpy(buf + 1, priv->spi_rx_buf,
+			       SPI_TRANSFER_BUF_LEN - 1);
+		} else {
+			mcp251x_spi_trans(spi, SPI_TRANSFER_BUF_LEN);
+			memcpy(buf, priv->spi_rx_buf, SPI_TRANSFER_BUF_LEN);
+		}
 	}
 }
 
-- 
2.28.0

