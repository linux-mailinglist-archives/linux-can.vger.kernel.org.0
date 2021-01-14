Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267992F64BF
	for <lists+linux-can@lfdr.de>; Thu, 14 Jan 2021 16:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbhANPfh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jan 2021 10:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbhANPfh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jan 2021 10:35:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8669C0613CF
        for <linux-can@vger.kernel.org>; Thu, 14 Jan 2021 07:34:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l04eF-0004YU-Dz
        for linux-can@vger.kernel.org; Thu, 14 Jan 2021 16:34:55 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1A1E75C3C7B
        for <linux-can@vger.kernel.org>; Thu, 14 Jan 2021 15:34:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 77B555C3C60;
        Thu, 14 Jan 2021 15:34:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bd238d09;
        Thu, 14 Jan 2021 15:34:49 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/6] can: mcp251xfd: add BQL support
Date:   Thu, 14 Jan 2021 16:34:48 +0100
Message-Id: <20210114153448.1506901-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114153448.1506901-1-mkl@pengutronix.de>
References: <20210114153448.1506901-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds BQL support to the driver. Support for netdev_xmit_more() will
be added in a separate patch series.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 9ffcfd64b904..580dcd2d7acc 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -335,6 +335,8 @@ static void mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	u8 len;
 	int i, j;
 
+	netdev_reset_queue(priv->ndev);
+
 	/* TEF */
 	tef_ring = priv->tef;
 	tef_ring->head = 0;
@@ -1249,7 +1251,8 @@ mcp251xfd_handle_tefif_recover(const struct mcp251xfd_priv *priv, const u32 seq)
 
 static int
 mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
-			   const struct mcp251xfd_hw_tef_obj *hw_tef_obj)
+			   const struct mcp251xfd_hw_tef_obj *hw_tef_obj,
+			   unsigned int *frame_len_ptr)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
 	u32 seq, seq_masked, tef_tail_masked;
@@ -1271,7 +1274,8 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb(&priv->offload,
 					    mcp251xfd_get_tef_tail(priv),
-					    hw_tef_obj->ts, NULL);
+					    hw_tef_obj->ts,
+					    frame_len_ptr);
 	stats->tx_packets++;
 	priv->tef->tail++;
 
@@ -1328,6 +1332,7 @@ mcp251xfd_tef_obj_read(const struct mcp251xfd_priv *priv,
 static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 {
 	struct mcp251xfd_hw_tef_obj hw_tef_obj[MCP251XFD_TX_OBJ_NUM_MAX];
+	unsigned int total_frame_len = 0;
 	u8 tef_tail, len, l;
 	int err, i;
 
@@ -1349,7 +1354,9 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 	}
 
 	for (i = 0; i < len; i++) {
-		err = mcp251xfd_handle_tefif_one(priv, &hw_tef_obj[i]);
+		unsigned int frame_len;
+
+		err = mcp251xfd_handle_tefif_one(priv, &hw_tef_obj[i], &frame_len);
 		/* -EAGAIN means the Sequence Number in the TEF
 		 * doesn't match our tef_tail. This can happen if we
 		 * read the TEF objects too early. Leave loop let the
@@ -1359,6 +1366,8 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 			goto out_netif_wake_queue;
 		if (err)
 			return err;
+
+		total_frame_len += frame_len;
 	}
 
  out_netif_wake_queue:
@@ -1389,6 +1398,7 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 			return err;
 
 		tx_ring->tail += len;
+		netdev_completed_queue(priv->ndev, len, total_frame_len);
 
 		err = mcp251xfd_check_tef_tail(priv);
 		if (err)
@@ -2432,6 +2442,7 @@ static netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	struct mcp251xfd_priv *priv = netdev_priv(ndev);
 	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
 	struct mcp251xfd_tx_obj *tx_obj;
+	unsigned int frame_len;
 	u8 tx_head;
 	int err;
 
@@ -2450,7 +2461,9 @@ static netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	if (mcp251xfd_get_tx_free(tx_ring) == 0)
 		netif_stop_queue(ndev);
 
-	can_put_echo_skb(skb, ndev, tx_head, 0);
+	frame_len = can_skb_get_frame_len(skb);
+	can_put_echo_skb(skb, ndev, tx_head, frame_len);
+	netdev_sent_queue(priv->ndev, frame_len);
 
 	err = mcp251xfd_tx_obj_write(priv, tx_obj);
 	if (err)
-- 
2.29.2


