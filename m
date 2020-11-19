Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484D72B8DFB
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 09:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgKSIw7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 03:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKSIw7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2020 03:52:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DF4C0617A7
        for <linux-can@vger.kernel.org>; Thu, 19 Nov 2020 00:52:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kffgX-0004Tk-1e; Thu, 19 Nov 2020 09:52:57 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, kernel@pengutronix.de,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/5] can: flexcan: flexcan_rx_offload_setup(): factor out mailbox and rx-offload setup into separate function
Date:   Thu, 19 Nov 2020 09:52:49 +0100
Message-Id: <20201119085251.2949181-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119085251.2949181-1-mkl@pengutronix.de>
References: <20201119085251.2949181-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In an upcoming patch the order of operations in flexcan_open() are changed.
Introduce convenience function to make that patch simpler.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 74 ++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 52ce26edfb0f..cbce8a3d090c 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1383,6 +1383,47 @@ static void flexcan_ram_init(struct net_device *dev)
 	priv->write(reg_ctrl2, &regs->ctrl2);
 }
 
+static int flexcan_rx_offload_setup(struct net_device *dev)
+{
+	struct flexcan_priv *priv = netdev_priv(dev);
+	int err;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+		priv->mb_size = sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
+	else
+		priv->mb_size = sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
+	priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
+			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
+		priv->tx_mb_reserved =
+			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP);
+	else
+		priv->tx_mb_reserved =
+			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_OFF_FIFO);
+	priv->tx_mb_idx = priv->mb_count - 1;
+	priv->tx_mb = flexcan_get_mb(priv, priv->tx_mb_idx);
+	priv->tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+
+	priv->offload.mailbox_read = flexcan_mailbox_read;
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+		priv->offload.mb_first = FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST;
+		priv->offload.mb_last = priv->mb_count - 2;
+
+		priv->rx_mask = GENMASK_ULL(priv->offload.mb_last,
+					    priv->offload.mb_first);
+		err = can_rx_offload_add_timestamp(dev, &priv->offload);
+	} else {
+		priv->rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
+			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
+		err = can_rx_offload_add_fifo(dev, &priv->offload,
+					      FLEXCAN_NAPI_WEIGHT);
+	}
+
+	return err;
+}
+
 static void flexcan_chip_interrupts_enable(const struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
@@ -1710,38 +1751,7 @@ static int flexcan_open(struct net_device *dev)
 	if (err)
 		goto out_transceiver_disable;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
-		priv->mb_size = sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
-	else
-		priv->mb_size = sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
-	priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
-			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
-
-	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
-		priv->tx_mb_reserved =
-			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP);
-	else
-		priv->tx_mb_reserved =
-			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_OFF_FIFO);
-	priv->tx_mb_idx = priv->mb_count - 1;
-	priv->tx_mb = flexcan_get_mb(priv, priv->tx_mb_idx);
-	priv->tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
-
-	priv->offload.mailbox_read = flexcan_mailbox_read;
-
-	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
-		priv->offload.mb_first = FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST;
-		priv->offload.mb_last = priv->mb_count - 2;
-
-		priv->rx_mask = GENMASK_ULL(priv->offload.mb_last,
-					    priv->offload.mb_first);
-		err = can_rx_offload_add_timestamp(dev, &priv->offload);
-	} else {
-		priv->rx_mask = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
-			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
-		err = can_rx_offload_add_fifo(dev, &priv->offload,
-					      FLEXCAN_NAPI_WEIGHT);
-	}
+	err = flexcan_rx_offload_setup(dev);
 	if (err)
 		goto out_free_irq;
 
-- 
2.29.2

