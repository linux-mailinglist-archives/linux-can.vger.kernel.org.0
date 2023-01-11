Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D615B66661E
	for <lists+linux-can@lfdr.de>; Wed, 11 Jan 2023 23:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjAKWWG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Jan 2023 17:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjAKWWC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2023 17:22:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E143E43
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2023 14:22:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pFjTr-0003yp-Jx
        for linux-can@vger.kernel.org; Wed, 11 Jan 2023 23:21:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BE53A154C8F
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2023 22:20:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 55EDF154C4C;
        Wed, 11 Jan 2023 22:20:45 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 62ca2ade;
        Wed, 11 Jan 2023 22:20:44 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
        kernel@pengutroniux.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/5] can: mcp251xfd: implement workaround for double-RX erratum
Date:   Wed, 11 Jan 2023 23:20:42 +0100
Message-Id: <20230111222042.1139027-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111222042.1139027-1-mkl@pengutronix.de>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    |  1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c  | 26 ++++++++++++++++---
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  3 +++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index cbfba958e3b5..f90a83390db2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -196,6 +196,7 @@ mcp251xfd_ring_init_rx(struct mcp251xfd_priv *priv, u16 *base, u8 *fifo_nr)
 	int i, j;
 
 	mcp251xfd_for_each_rx_ring(priv, rx_ring, i) {
+		rx_ring->last_valid = timecounter_read(&priv->tc);
 		rx_ring->head = 0;
 		rx_ring->tail = 0;
 		rx_ring->base = *base;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index 811c4487c6fe..b9c4f7148b53 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
@@ -175,8 +175,6 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 
 	if (!(hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_RTR))
 		memcpy(cfd->data, hw_rx_obj->data, cfd->len);
-
-	mcp251xfd_skb_set_timestamp_from_tbc(priv, skb, hw_rx_obj->ts);
 }
 
 static int
@@ -187,8 +185,21 @@ mcp251xfd_handle_rxif_one(struct mcp251xfd_priv *priv,
 	struct net_device_stats *stats = &priv->ndev->stats;
 	struct sk_buff *skb;
 	struct canfd_frame *cfd;
+	u64 timestamp;
 	int err;
 
+	timestamp = timecounter_cyc2time(&priv->tc, hw_rx_obj->ts);
+	if (timestamp <= ring->last_valid ) {
+		netdev_dbg(priv->ndev, "%s: last_valid=0x%016llx ts=0x%016llx d=0x%016llx data=%*ph - Dropping\n", __func__,
+			   ring->last_valid, timestamp,
+			   timestamp - ring->last_valid,
+			   8, hw_rx_obj->data);
+		stats->rx_fifo_errors++;
+
+		return -EBADMSG;
+	}
+	ring->last_valid = timestamp;
+
 	if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_FDF)
 		skb = alloc_canfd_skb(priv->ndev, &cfd);
 	else
@@ -199,6 +210,7 @@ mcp251xfd_handle_rxif_one(struct mcp251xfd_priv *priv,
 		return 0;
 	}
 
+	mcp251xfd_skb_set_timestamp(skb, timestamp);
 	mcp251xfd_hw_rx_obj_to_skb(priv, hw_rx_obj, skb);
 	err = can_rx_offload_queue_timestamp(&priv->offload, skb, hw_rx_obj->ts);
 	if (err)
@@ -281,7 +293,15 @@ mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 			err = mcp251xfd_handle_rxif_one(priv, ring,
 							(void *)hw_rx_obj +
 							i * ring->obj_size);
-			if (err)
+			/* -EBADMSG means we're affected by an
+			 * erratum, i.e. that timestamp in the RX
+			 * object is older that the last valid
+			 * received CAN frame. Don't process any
+			 * further.
+			 */
+			if (err == -EBADMSG)
+				return mcp251xfd_handle_rxif_ring_uinc(priv, ring, i);
+			else if (err)
 				return err;
 		}
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 11f6e1c6fc60..d973a89cf7f8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -546,6 +546,9 @@ struct mcp251xfd_rx_ring {
 	unsigned int head;
 	unsigned int tail;
 
+	/* timestamp of the last valid received CAN frame */
+	u64 last_valid;
+
 	u16 base;
 	u8 nr;
 	u8 fifo_nr;
-- 
2.39.0


