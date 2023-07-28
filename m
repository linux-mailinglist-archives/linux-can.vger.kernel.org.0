Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20C9766617
	for <lists+linux-can@lfdr.de>; Fri, 28 Jul 2023 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjG1IAI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 28 Jul 2023 04:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbjG1H7i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jul 2023 03:59:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E403C03
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 00:59:05 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qPIMx-0008O7-7q
        for linux-can@vger.kernel.org; Fri, 28 Jul 2023 09:58:39 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DA7261FD2A9
        for <linux-can@vger.kernel.org>; Fri, 28 Jul 2023 07:56:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9D3031FD20A;
        Fri, 28 Jul 2023 07:56:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 34e91248;
        Fri, 28 Jul 2023 07:56:17 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 19/21] can: rx-offload: rename rx_offload_get_echo_skb() -> can_rx_offload_get_echo_skb_queue_timestamp()
Date:   Fri, 28 Jul 2023 09:56:12 +0200
Message-Id: <20230728075614.1014117-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728075614.1014117-1-mkl@pengutronix.de>
References: <20230728075614.1014117-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Rename the rx_offload_get_echo_skb() function to
can_rx_offload_get_echo_skb_queue_timestamp(), since it inserts the
echo skb into the rx-offload queue sorted by timestamp.

This is a preparation for adding
can_rx_offload_get_echo_skb_queue_tail(), which adds the echo skb to
the end of the queue. This is intended for devices that do not support
timestamps.

Link: https://lore.kernel.org/all/20230718-gs_usb-rx-offload-v2-1-716e542d14d5@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/rx-offload.c              | 9 +++++----
 drivers/net/can/flexcan/flexcan-core.c        | 4 ++--
 drivers/net/can/m_can/m_can.c                 | 8 ++++----
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 6 +++---
 drivers/net/can/ti_hecc.c                     | 4 ++--
 include/linux/can/rx-offload.h                | 6 +++---
 6 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 161e45a7e8c1..6e87ad908346 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -240,9 +240,10 @@ int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_queue_timestamp);
 
-unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
-					 unsigned int idx, u32 timestamp,
-					 unsigned int *frame_len_ptr)
+unsigned int
+can_rx_offload_get_echo_skb_queue_timestamp(struct can_rx_offload *offload,
+					    unsigned int idx, u32 timestamp,
+					    unsigned int *frame_len_ptr)
 {
 	struct net_device *dev = offload->dev;
 	struct net_device_stats *stats = &dev->stats;
@@ -262,7 +263,7 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
 
 	return len;
 }
-EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb);
+EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_timestamp);
 
 int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb)
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ff0fc18baf13..48273d51f271 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1097,8 +1097,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 		handled = IRQ_HANDLED;
 		stats->tx_bytes +=
-			can_rx_offload_get_echo_skb(&priv->offload, 0,
-						    reg_ctrl << 16, NULL);
+			can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload, 0,
+								    reg_ctrl << 16, NULL);
 		stats->tx_packets++;
 
 		/* after sending a RTR frame MB is in RX mode */
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a6263a617ac9..d204703521d2 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1016,10 +1016,10 @@ static void m_can_tx_update_stats(struct m_can_classdev *cdev,
 
 	if (cdev->is_peripheral)
 		stats->tx_bytes +=
-			can_rx_offload_get_echo_skb(&cdev->offload,
-						    msg_mark,
-						    timestamp,
-						    NULL);
+			can_rx_offload_get_echo_skb_queue_timestamp(&cdev->offload,
+								    msg_mark,
+								    timestamp,
+								    NULL);
 	else
 		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, NULL);
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index 237617b0c125..e5bd57b65aaf 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -111,9 +111,9 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	if (skb)
 		mcp251xfd_skb_set_timestamp(priv, skb, hw_tef_obj->ts);
 	stats->tx_bytes +=
-		can_rx_offload_get_echo_skb(&priv->offload,
-					    tef_tail, hw_tef_obj->ts,
-					    frame_len_ptr);
+		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
+							    tef_tail, hw_tef_obj->ts,
+							    frame_len_ptr);
 	stats->tx_packets++;
 	priv->tef->tail++;
 
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index a8243acde92d..5aab440074c6 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -747,8 +747,8 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 			spin_unlock_irqrestore(&priv->mbx_lock, flags);
 			stamp = hecc_read_stamp(priv, mbxno);
 			stats->tx_bytes +=
-				can_rx_offload_get_echo_skb(&priv->offload,
-							    mbxno, stamp, NULL);
+				can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
+									    mbxno, stamp, NULL);
 			stats->tx_packets++;
 			--priv->tx_tail;
 		}
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index c205c51d79c9..e3b4199732c6 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -44,9 +44,9 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload);
 int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
 				   struct sk_buff *skb, u32 timestamp);
-unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
-					 unsigned int idx, u32 timestamp,
-					 unsigned int *frame_len_ptr);
+unsigned int can_rx_offload_get_echo_skb_queue_timestamp(struct can_rx_offload *offload,
+							 unsigned int idx, u32 timestamp,
+							 unsigned int *frame_len_ptr);
 int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb);
 void can_rx_offload_irq_finish(struct can_rx_offload *offload);
-- 
2.40.1


