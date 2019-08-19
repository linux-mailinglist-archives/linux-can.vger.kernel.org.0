Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB394899
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2019 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHSPiZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Aug 2019 11:38:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57545 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfHSPiZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2019 11:38:25 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hzjjj-0007p0-3t; Mon, 19 Aug 2019 17:38:23 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/9] can: mcp251x: use u8 instead of uint8_t
Date:   Mon, 19 Aug 2019 17:38:14 +0200
Message-Id: <20190819153818.29293-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819153818.29293-1-mkl@pengutronix.de>
References: <20190819153818.29293-1-mkl@pengutronix.de>
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

This patch changes all the uint8_t in the arguments in several function
to u8.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index d4ae47a0a850..44b57187a6f3 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -319,7 +319,7 @@ static int mcp251x_spi_trans(struct spi_device *spi, int len)
 	return ret;
 }
 
-static u8 mcp251x_read_reg(struct spi_device *spi, uint8_t reg)
+static u8 mcp251x_read_reg(struct spi_device *spi, u8 reg)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
 	u8 val = 0;
@@ -333,8 +333,7 @@ static u8 mcp251x_read_reg(struct spi_device *spi, uint8_t reg)
 	return val;
 }
 
-static void mcp251x_read_2regs(struct spi_device *spi, uint8_t reg,
-		uint8_t *v1, uint8_t *v2)
+static void mcp251x_read_2regs(struct spi_device *spi, u8 reg, u8 *v1, u8 *v2)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
 
@@ -347,7 +346,7 @@ static void mcp251x_read_2regs(struct spi_device *spi, uint8_t reg,
 	*v2 = priv->spi_rx_buf[3];
 }
 
-static void mcp251x_write_reg(struct spi_device *spi, u8 reg, uint8_t val)
+static void mcp251x_write_reg(struct spi_device *spi, u8 reg, u8 val)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
 
@@ -359,7 +358,7 @@ static void mcp251x_write_reg(struct spi_device *spi, u8 reg, uint8_t val)
 }
 
 static void mcp251x_write_bits(struct spi_device *spi, u8 reg,
-			       u8 mask, uint8_t val)
+			       u8 mask, u8 val)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
 
-- 
2.23.0.rc1

