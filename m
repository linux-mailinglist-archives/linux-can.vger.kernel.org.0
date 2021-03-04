Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6D532D758
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 17:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhCDQEh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Mar 2021 11:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbhCDQES (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Mar 2021 11:04:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71CCC061763
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 08:03:37 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHqRs-0006FG-8E
        for linux-can@vger.kernel.org; Thu, 04 Mar 2021 17:03:36 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6ABA25EDDD3
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 16:03:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2039F5EDDB5;
        Thu,  4 Mar 2021 16:03:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id eabeb442;
        Thu, 4 Mar 2021 16:03:29 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [can-next 6/6] can: mcp251xfd: add HW timestamp to RX, TX and error CAN frames
Date:   Thu,  4 Mar 2021 17:03:28 +0100
Message-Id: <20210304160328.2752293-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304160328.2752293-1-mkl@pengutronix.de>
References: <20210304160328.2752293-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch uses the previously added mcp251xfd_skb_set_timestamp()
function to convert the timestamp done by the CAN controller into a
proper skb hw timestamp.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 965f8d82b8a1..24b91a6f380b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1268,7 +1268,8 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 			   unsigned int *frame_len_ptr)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
-	u32 seq, seq_masked, tef_tail_masked;
+	struct sk_buff *skb;
+	u32 seq, seq_masked, tef_tail_masked, tef_tail;
 
 	seq = FIELD_GET(MCP251XFD_OBJ_FLAGS_SEQ_MCP2518FD_MASK,
 			hw_tef_obj->flags);
@@ -1284,9 +1285,12 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	if (seq_masked != tef_tail_masked)
 		return mcp251xfd_handle_tefif_recover(priv, seq);
 
+	tef_tail = mcp251xfd_get_tef_tail(priv);
+	skb = priv->can.echo_skb[tef_tail];
+	mcp251xfd_skb_set_timestamp(priv, skb, hw_tef_obj->ts);
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb(&priv->offload,
-					    mcp251xfd_get_tef_tail(priv),
+					    tef_tail,
 					    hw_tef_obj->ts,
 					    frame_len_ptr);
 	stats->tx_packets++;
@@ -1452,7 +1456,7 @@ mcp251xfd_rx_ring_update(const struct mcp251xfd_priv *priv,
 }
 
 static void
-mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
+mcp251xfd_hw_rx_obj_to_skb(struct mcp251xfd_priv *priv,
 			   const struct mcp251xfd_hw_rx_obj_canfd *hw_rx_obj,
 			   struct sk_buff *skb)
 {
@@ -1495,6 +1499,8 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 
 	if (!(hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_RTR))
 		memcpy(cfd->data, hw_rx_obj->data, cfd->len);
+
+	mcp251xfd_skb_set_timestamp(priv, skb, hw_rx_obj->ts);
 }
 
 static int
@@ -1608,16 +1614,21 @@ static int mcp251xfd_handle_rxif(struct mcp251xfd_priv *priv)
 }
 
 static struct sk_buff *
-mcp251xfd_alloc_can_err_skb(const struct mcp251xfd_priv *priv,
+mcp251xfd_alloc_can_err_skb(struct mcp251xfd_priv *priv,
 			    struct can_frame **cf, u32 *timestamp)
 {
+	struct sk_buff *skb;
 	int err;
 
 	err = mcp251xfd_get_timestamp(priv, timestamp);
 	if (err)
 		return NULL;
 
-	return alloc_can_err_skb(priv->ndev, cf);
+	skb = alloc_can_err_skb(priv->ndev, cf);
+	if (skb)
+		mcp251xfd_skb_set_timestamp(priv, skb, *timestamp);
+
+	return skb;
 }
 
 static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
@@ -1769,6 +1780,7 @@ static int mcp251xfd_handle_ivmif(struct mcp251xfd_priv *priv)
 	if (!cf)
 		return 0;
 
+	mcp251xfd_skb_set_timestamp(priv, skb, timestamp);
 	err = can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
 	if (err)
 		stats->rx_fifo_errors++;
-- 
2.30.1


