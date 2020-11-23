Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14012C03F1
	for <lists+linux-can@lfdr.de>; Mon, 23 Nov 2020 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgKWLQi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 Nov 2020 06:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgKWLQh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 Nov 2020 06:16:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8980FC061A4E
        for <linux-can@vger.kernel.org>; Mon, 23 Nov 2020 03:16:37 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kh9pi-0006oB-Cx; Mon, 23 Nov 2020 12:16:34 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 1/2] can: mcp251xfd: mcp25xxfd_ring_alloc(): add define instead open coding the maximum number of RX objects
Date:   Mon, 23 Nov 2020 12:16:30 +0100
Message-Id: <20201123111631.3816024-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123111631.3816024-1-mkl@pengutronix.de>
References: <20201123111631.3816024-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch add a define for the maximum number of RX objects instead of open
coding it.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 3 ++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3297eb7ecc9c..aab972ad10dd 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -416,7 +416,8 @@ static int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 		int rx_obj_num;
 
 		rx_obj_num = ram_free / rx_obj_size;
-		rx_obj_num = min(1 << (fls(rx_obj_num) - 1), 32);
+		rx_obj_num = min(1 << (fls(rx_obj_num) - 1),
+				 MCP251XFD_RX_OBJ_NUM_MAX);
 
 		rx_ring = kzalloc(sizeof(*rx_ring) + rx_obj_size * rx_obj_num,
 				  GFP_KERNEL);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index fa1246e39980..c20c97d01072 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -368,6 +368,7 @@
  * FIFO setup: tef: 8*12 bytes = 96 bytes, tx: 8*16 bytes = 128 bytes
  * FIFO setup: tef: 4*12 bytes = 48 bytes, tx: 4*72 bytes = 288 bytes
  */
+#define MCP251XFD_RX_OBJ_NUM_MAX 32
 #define MCP251XFD_TX_OBJ_NUM_CAN 8
 #define MCP251XFD_TX_OBJ_NUM_CANFD 4
 
-- 
2.29.2

