Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 638C1F05AD
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 20:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390812AbfKETIp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 14:08:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46267 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390927AbfKETIp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 14:08:45 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iS4C3-0001dw-Ls; Tue, 05 Nov 2019 20:08:43 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     =?UTF-8?q?Timo=20Schl=C3=BC=C3=9Fler?= <schluessler@krause.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 2/4] can: mcp251x: add mcp251x_write_2regs() and make use of it
Date:   Tue,  5 Nov 2019 20:08:38 +0100
Message-Id: <20191105190840.20410-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191105190840.20410-1-mkl@pengutronix.de>
References: <20191105190840.20410-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Timo Schlüßler <schluessler@krause.de>

This patch introduces the function mcp251x_write_2regs() to write two
registers with one SPI transfer and converts the disabling of pending
interrupts in mcp251x_stop() to it.

Signed-off-by: Timo Schlüßler <schluessler@krause.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 8f39a7b707c1..d1240aeaa12c 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -362,6 +362,18 @@ static void mcp251x_write_reg(struct spi_device *spi, u8 reg, uint8_t val)
 	mcp251x_spi_trans(spi, 3);
 }
 
+static void mcp251x_write_2regs(struct spi_device *spi, u8 reg, u8 v1, u8 v2)
+{
+	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+
+	priv->spi_tx_buf[0] = INSTRUCTION_WRITE;
+	priv->spi_tx_buf[1] = reg;
+	priv->spi_tx_buf[2] = v1;
+	priv->spi_tx_buf[3] = v2;
+
+	mcp251x_spi_trans(spi, 4);
+}
+
 static void mcp251x_write_bits(struct spi_device *spi, u8 reg,
 			       u8 mask, uint8_t val)
 {
@@ -679,8 +691,7 @@ static int mcp251x_stop(struct net_device *net)
 	mutex_lock(&priv->mcp_lock);
 
 	/* Disable and clear pending interrupts */
-	mcp251x_write_reg(spi, CANINTE, 0x00);
-	mcp251x_write_reg(spi, CANINTF, 0x00);
+	mcp251x_write_2regs(spi, CANINTE, 0x00, 0x00);
 
 	mcp251x_write_reg(spi, TXBCTRL(0), 0);
 	mcp251x_clean(net);
-- 
2.24.0.rc1

