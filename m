Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3389594897
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2019 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHSPiY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Aug 2019 11:38:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41609 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSPiX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2019 11:38:23 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hzjji-0007p0-Dq; Mon, 19 Aug 2019 17:38:22 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/9] can: mcp251x: avoid long lines
Date:   Mon, 19 Aug 2019 17:38:12 +0200
Message-Id: <20190819153818.29293-4-mkl@pengutronix.de>
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

This patch fixes long lines in the driver.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 3ec0907a0ee7..0fd559510d75 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -806,7 +806,8 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 			 * (The MCP2515/25625 does this automatically.)
 			 */
 			if (mcp251x_is_2510(spi))
-				mcp251x_write_bits(spi, CANINTF, CANINTF_RX0IF, 0x00);
+				mcp251x_write_bits(spi, CANINTF,
+						   CANINTF_RX0IF, 0x00);
 		}
 
 		/* receive buffer 1 */
@@ -1133,7 +1134,8 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	ret = mcp251x_hw_probe(spi);
 	if (ret) {
 		if (ret == -ENODEV)
-			dev_err(&spi->dev, "Cannot initialize MCP%x. Wrong wiring?\n", priv->model);
+			dev_err(&spi->dev, "Cannot initialize MCP%x. Wrong wiring?\n",
+				priv->model);
 		goto error_probe;
 	}
 
-- 
2.23.0.rc1

