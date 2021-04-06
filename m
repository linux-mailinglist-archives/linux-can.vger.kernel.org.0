Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01B355185
	for <lists+linux-can@lfdr.de>; Tue,  6 Apr 2021 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbhDFLGc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Apr 2021 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241287AbhDFLGc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Apr 2021 07:06:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A5DC061756
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 04:06:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lTjXL-0007pl-2F
        for linux-can@vger.kernel.org; Tue, 06 Apr 2021 13:06:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A24726086CE
        for <linux-can@vger.kernel.org>; Tue,  6 Apr 2021 11:06:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 11D696086BA;
        Tue,  6 Apr 2021 11:06:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0731b4d7;
        Tue, 6 Apr 2021 11:06:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: [can-next-rfc 2/4] can: mcp251xfd: add BQL support
Date:   Tue,  6 Apr 2021 13:06:15 +0200
Message-Id: <20210406110617.1865592-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210406110617.1865592-1-mkl@pengutronix.de>
References: <20210406110617.1865592-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch re-adds BQL support to the driver. Support for
netdev_xmit_more() will be added in a separate patch series.

Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Kopp <thomas.kopp@microchip.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 142eb4506b55..970dc570e7a5 100644
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
@@ -1262,7 +1264,8 @@ mcp251xfd_handle_tefif_recover(const struct mcp251xfd_priv *priv, const u32 seq)
 
 static int
 mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
-			   const struct mcp251xfd_hw_tef_obj *hw_tef_obj)
+			   const struct mcp251xfd_hw_tef_obj *hw_tef_obj,
+			   unsigned int *frame_len_ptr)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
 	struct sk_buff *skb;
@@ -1288,8 +1291,8 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 		mcp251xfd_skb_set_timestamp(priv, skb, hw_tef_obj->ts);
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb(&priv->offload,
-					    tef_tail,
-					    hw_tef_obj->ts, NULL);
+					    tef_tail, hw_tef_obj->ts,
+					    frame_len_ptr);
 	stats->tx_packets++;
 	priv->tef->tail++;
 
@@ -1347,6 +1350,7 @@ mcp251xfd_tef_obj_read(const struct mcp251xfd_priv *priv,
 static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 {
 	struct mcp251xfd_hw_tef_obj hw_tef_obj[MCP251XFD_TX_OBJ_NUM_MAX];
+	unsigned int total_frame_len = 0;
 	u8 tef_tail, len, l;
 	int err, i;
 
@@ -1368,7 +1372,9 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 	}
 
 	for (i = 0; i < len; i++) {
-		err = mcp251xfd_handle_tefif_one(priv, &hw_tef_obj[i]);
+		unsigned int frame_len = 0;
+
+		err = mcp251xfd_handle_tefif_one(priv, &hw_tef_obj[i], &frame_len);
 		/* -EAGAIN means the Sequence Number in the TEF
 		 * doesn't match our tef_tail. This can happen if we
 		 * read the TEF objects too early. Leave loop let the
@@ -1378,6 +1384,8 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 			goto out_netif_wake_queue;
 		if (err)
 			return err;
+
+		total_frame_len += frame_len;
 	}
 
  out_netif_wake_queue:
@@ -1403,6 +1411,7 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 			return err;
 
 		tx_ring->tail += len;
+		netdev_completed_queue(priv->ndev, len, total_frame_len);
 
 		err = mcp251xfd_check_tef_tail(priv);
 		if (err)
@@ -2446,6 +2455,7 @@ static netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	struct mcp251xfd_priv *priv = netdev_priv(ndev);
 	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
 	struct mcp251xfd_tx_obj *tx_obj;
+	unsigned int frame_len;
 	u8 tx_head;
 	int err;
 
@@ -2464,7 +2474,10 @@ static netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	if (mcp251xfd_get_tx_free(tx_ring) == 0)
 		netif_stop_queue(ndev);
 
-	can_put_echo_skb(skb, ndev, tx_head, 0);
+	frame_len = can_skb_get_frame_len(skb);
+	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
+	if (!err)
+		netdev_sent_queue(priv->ndev, frame_len);
 
 	err = mcp251xfd_tx_obj_write(priv, tx_obj);
 	if (err)
-- 
2.30.2


