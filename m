Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF42294896
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2019 17:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfHSPiX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Aug 2019 11:38:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57913 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSPiX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2019 11:38:23 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hzjjh-0007p0-Lb; Mon, 19 Aug 2019 17:38:21 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/9] can: mcp251x: convert block comments to network style comments
Date:   Mon, 19 Aug 2019 17:38:10 +0200
Message-Id: <20190819153818.29293-2-mkl@pengutronix.de>
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

This patch converts all block comments to network subsystem style block
comments.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 44e99e3d7134..e59b10525f46 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*
- * CAN bus driver for Microchip 251x/25625 CAN Controller with SPI Interface
+/* CAN bus driver for Microchip 251x/25625 CAN Controller with SPI Interface
  *
  * MCP2510 support and bug fixes by Christian Pellegrin
  * <chripell@evolware.org>
@@ -191,8 +190,7 @@
 #define SET_BYTE(val, byte)			\
 	(((val) & 0xff) << ((byte) * 8))
 
-/*
- * Buffer size required for the largest SPI transfer (i.e., reading a
+/* Buffer size required for the largest SPI transfer (i.e., reading a
  * frame)
  */
 #define CAN_FRAME_MAX_DATA_LEN	8
@@ -282,8 +280,7 @@ static void mcp251x_clean(struct net_device *net)
 	priv->tx_len = 0;
 }
 
-/*
- * Note about handling of error return of mcp251x_spi_trans: accessing
+/* Note about handling of error return of mcp251x_spi_trans: accessing
  * registers via SPI is not really different conceptually than using
  * normal I/O assembler instructions, although it's much more
  * complicated from a practical POV. So it's not advisable to always
@@ -1098,8 +1095,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	if (mcp251x_enable_dma) {
 		spi->dev.coherent_dma_mask = ~0;
 
-		/*
-		 * Minimum coherent DMA allocation is PAGE_SIZE, so allocate
+		/* Minimum coherent DMA allocation is PAGE_SIZE, so allocate
 		 * that much and share it between Tx and Rx DMA buffers.
 		 */
 		priv->spi_tx_buf = dmam_alloc_coherent(&spi->dev,
@@ -1193,8 +1189,7 @@ static int __maybe_unused mcp251x_can_suspend(struct device *dev)
 
 	priv->force_quit = 1;
 	disable_irq(spi->irq);
-	/*
-	 * Note: at this point neither IST nor workqueues are running.
+	/* Note: at this point neither IST nor workqueues are running.
 	 * open/stop cannot be called anyway so locking is not needed
 	 */
 	if (netif_running(net)) {
-- 
2.23.0.rc1

