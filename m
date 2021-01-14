Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36712F5BDA
	for <lists+linux-can@lfdr.de>; Thu, 14 Jan 2021 08:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbhANH6I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jan 2021 02:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbhANH6C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jan 2021 02:58:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3B4C061386
        for <linux-can@vger.kernel.org>; Wed, 13 Jan 2021 23:56:39 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kzxUk-0007Ta-Fa
        for linux-can@vger.kernel.org; Thu, 14 Jan 2021 08:56:38 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 962035C367F
        for <linux-can@vger.kernel.org>; Thu, 14 Jan 2021 07:56:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id AB5B15C3627;
        Thu, 14 Jan 2021 07:56:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 71f01cab;
        Thu, 14 Jan 2021 07:56:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [net-next 15/17] can: dev: can_rx_offload_get_echo_skb(): extend to return can frame length
Date:   Thu, 14 Jan 2021 08:56:15 +0100
Message-Id: <20210114075617.1402597-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114075617.1402597-1-mkl@pengutronix.de>
References: <20210114075617.1402597-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In order to implement byte queue limits (bql) in CAN drivers, the length of the
CAN frame needs to be passed into the networking stack after queueing and after
transmission completion.

To avoid to calculate this length twice, extend can_rx_offload_get_echo_skb()
to return that value. Convert all users of this function, too.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/r/20210111141930.693847-15-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/rx-offload.c               | 5 +++--
 drivers/net/can/flexcan.c                      | 5 +++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
 drivers/net/can/ti_hecc.c                      | 2 +-
 include/linux/can/rx-offload.h                 | 3 ++-
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 6a26b5282df1..ab2c1543786c 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -263,7 +263,8 @@ int can_rx_offload_queue_sorted(struct can_rx_offload *offload,
 EXPORT_SYMBOL_GPL(can_rx_offload_queue_sorted);
 
 unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
-					 unsigned int idx, u32 timestamp)
+					 unsigned int idx, u32 timestamp,
+					 unsigned int *frame_len_ptr)
 {
 	struct net_device *dev = offload->dev;
 	struct net_device_stats *stats = &dev->stats;
@@ -271,7 +272,7 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
 	u8 len;
 	int err;
 
-	skb = __can_get_echo_skb(dev, idx, &len, NULL);
+	skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
 	if (!skb)
 		return 0;
 
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 202d08f8e1a4..5d9157c655e9 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1122,8 +1122,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		u32 reg_ctrl = priv->read(&priv->tx_mb->can_ctrl);
 
 		handled = IRQ_HANDLED;
-		stats->tx_bytes += can_rx_offload_get_echo_skb(&priv->offload,
-							       0, reg_ctrl << 16);
+		stats->tx_bytes +=
+			can_rx_offload_get_echo_skb(&priv->offload, 0,
+						    reg_ctrl << 16, NULL);
 		stats->tx_packets++;
 		can_led_event(dev, CAN_LED_EVENT_TX);
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 95bba456a4cd..63bbe0930e53 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1271,7 +1271,7 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb(&priv->offload,
 					    mcp251xfd_get_tef_tail(priv),
-					    hw_tef_obj->ts);
+					    hw_tef_obj->ts, NULL);
 	stats->tx_packets++;
 	priv->tef->tail++;
 
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 485c19bc98c2..73245d8836a9 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -757,7 +757,7 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 			stamp = hecc_read_stamp(priv, mbxno);
 			stats->tx_bytes +=
 				can_rx_offload_get_echo_skb(&priv->offload,
-							    mbxno, stamp);
+							    mbxno, stamp, NULL);
 			stats->tx_packets++;
 			can_led_event(ndev, CAN_LED_EVENT_TX);
 			--priv->tx_tail;
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index f1b38088b765..40882df7105e 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -44,7 +44,8 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload);
 int can_rx_offload_queue_sorted(struct can_rx_offload *offload,
 				struct sk_buff *skb, u32 timestamp);
 unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
-					 unsigned int idx, u32 timestamp);
+					 unsigned int idx, u32 timestamp,
+					 unsigned int *frame_len_ptr);
 int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb);
 void can_rx_offload_del(struct can_rx_offload *offload);
-- 
2.29.2


