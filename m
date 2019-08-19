Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 770859489D
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2019 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHSPi1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Aug 2019 11:38:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60925 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSPi1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2019 11:38:27 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hzjjl-0007p0-IZ; Mon, 19 Aug 2019 17:38:25 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru,
        Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 9/9] can: mcp251x: remove custom DMA mapped buffer
Date:   Mon, 19 Aug 2019 17:38:18 +0200
Message-Id: <20190819153818.29293-10-mkl@pengutronix.de>
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

There is no need to duplicate what SPI core already does, i.e. mapping buffers
for DMA capable transfers. This patch removes all related pices of code.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 58 ++++++-----------------------------
 1 file changed, 10 insertions(+), 48 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 0cdb88a9525f..78d44801a0b5 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -47,7 +47,6 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
 #include <linux/freezer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -202,10 +201,6 @@
 
 #define DEVICE_NAME "mcp251x"
 
-static int mcp251x_enable_dma; /* Enable SPI DMA. Default: 0 (Off) */
-module_param(mcp251x_enable_dma, int, 0444);
-MODULE_PARM_DESC(mcp251x_enable_dma, "Enable SPI DMA. Default: 0 (Off)");
-
 static const struct can_bittiming_const mcp251x_bittiming_const = {
 	.name = DEVICE_NAME,
 	.tseg1_min = 3,
@@ -234,8 +229,6 @@ struct mcp251x_priv {
 
 	u8 *spi_tx_buf;
 	u8 *spi_rx_buf;
-	dma_addr_t spi_tx_dma;
-	dma_addr_t spi_rx_dma;
 
 	struct sk_buff *tx_skb;
 	int tx_len;
@@ -304,13 +297,6 @@ static int mcp251x_spi_trans(struct spi_device *spi, int len)
 	int ret;
 
 	spi_message_init(&m);
-
-	if (mcp251x_enable_dma) {
-		t.tx_dma = priv->spi_tx_dma;
-		t.rx_dma = priv->spi_rx_dma;
-		m.is_dma_mapped = 1;
-	}
-
 	spi_message_add_tail(&t, &m);
 
 	ret = spi_sync(spi, &m);
@@ -1101,42 +1087,18 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	priv->spi = spi;
 	mutex_init(&priv->mcp_lock);
 
-	/* If requested, allocate DMA buffers */
-	if (mcp251x_enable_dma) {
-		spi->dev.coherent_dma_mask = ~0;
-
-		/* Minimum coherent DMA allocation is PAGE_SIZE, so allocate
-		 * that much and share it between Tx and Rx DMA buffers.
-		 */
-		priv->spi_tx_buf = dmam_alloc_coherent(&spi->dev,
-						       PAGE_SIZE,
-						       &priv->spi_tx_dma,
-						       GFP_DMA);
-
-		if (priv->spi_tx_buf) {
-			priv->spi_rx_buf = (priv->spi_tx_buf + (PAGE_SIZE / 2));
-			priv->spi_rx_dma = (dma_addr_t)(priv->spi_tx_dma +
-							(PAGE_SIZE / 2));
-		} else {
-			/* Fall back to non-DMA */
-			mcp251x_enable_dma = 0;
-		}
+	priv->spi_tx_buf = devm_kzalloc(&spi->dev, SPI_TRANSFER_BUF_LEN,
+					GFP_KERNEL);
+	if (!priv->spi_tx_buf) {
+		ret = -ENOMEM;
+		goto error_probe;
 	}
 
-	/* Allocate non-DMA buffers */
-	if (!mcp251x_enable_dma) {
-		priv->spi_tx_buf = devm_kzalloc(&spi->dev, SPI_TRANSFER_BUF_LEN,
-						GFP_KERNEL);
-		if (!priv->spi_tx_buf) {
-			ret = -ENOMEM;
-			goto error_probe;
-		}
-		priv->spi_rx_buf = devm_kzalloc(&spi->dev, SPI_TRANSFER_BUF_LEN,
-						GFP_KERNEL);
-		if (!priv->spi_rx_buf) {
-			ret = -ENOMEM;
-			goto error_probe;
-		}
+	priv->spi_rx_buf = devm_kzalloc(&spi->dev, SPI_TRANSFER_BUF_LEN,
+					GFP_KERNEL);
+	if (!priv->spi_rx_buf) {
+		ret = -ENOMEM;
+		goto error_probe;
 	}
 
 	SET_NETDEV_DEV(net, &spi->dev);
-- 
2.23.0.rc1

