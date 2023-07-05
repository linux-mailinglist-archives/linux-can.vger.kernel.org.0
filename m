Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D12C74812A
	for <lists+linux-can@lfdr.de>; Wed,  5 Jul 2023 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjGEJk3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jul 2023 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGEJkW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jul 2023 05:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6902E1709
        for <linux-can@vger.kernel.org>; Wed,  5 Jul 2023 02:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3F32614CB
        for <linux-can@vger.kernel.org>; Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65EE4C433C9;
        Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688550020;
        bh=pHZwoukeseLnd7KjTeWUU7WWN25Kbw4DvCdVI4DL6ZM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=s74awQ4Wz2GYGP2YZuVOYjOF5NNXTCnKxZrgtlCBEtlIwWUCoGySmL1GbVw7GC+JT
         hM9KjJI+CHdy9hNjBLnvZ2Qe2x2A+p6uwvOdGC1WqW3aIjBntYbXBoXy6Oay9j0Fp/
         3OfG3F3r59yWD47lbfF+lBvLCPC5FkSGtnOt0bhXJWXr+siu1nSP9bKFK/Mn+WJO2K
         LmWhyJg69yTog3e+DUNcMxvqy6kakUAlWL7mdjh5GVyy4uah7rPIvvM4XepoKEuEJZ
         SYGX4HQ5DqSfrk7xragKERnX4tQixNzcVtLc1jasafiHwxWNspzGzsS8oOiN8vt9rs
         tFv61mt6/8K1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB3C001DD;
        Wed,  5 Jul 2023 09:40:20 +0000 (UTC)
From:   Marc Kleine-Budde via B4 Relay 
        <devnull+mkl.pengutronix.de@kernel.org>
Date:   Wed, 05 Jul 2023 11:39:52 +0200
Subject: [PATCH 1/6] can: rx-offload: rename rx_offload_get_echo_skb() ->
 can_rx_offload_get_echo_skb_queue_timestamp()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230705-gs_usb-rx-offload-v1-1-8e7e46e40137@pengutronix.de>
References: <20230705-gs_usb-rx-offload-v1-0-8e7e46e40137@pengutronix.de>
In-Reply-To: <20230705-gs_usb-rx-offload-v1-0-8e7e46e40137@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5545; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=LABeQbOpQx+4KthwqZl1txlbMnRewkJuXQfeMNf1dbQ=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBkpTpy82CUJlTNzgzBjxJcF5LLc0elBhaRctFuK
 AXexKit49iJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZKU6cgAKCRC+UBxKKooE
 6KdjB/4/u5v46YNkbcBrGNAqiLexx2HQRZL4wfN/APj7HH0DYujHJ/H52A4lOTioUmq60QXJaeJ
 MpN/iOlSRONJVM16sidPdbfmewrQI3u3qWnWLumy0BNcuVfauSjyOlW3T7ct9InNOePWMTw/FLU
 a72tgzqNrcI8hZ/aNfKUKqGoYE+EMaq9a+jD+BVyTn6Qu8TrwaiSsEzpEM7aOuhBICgOKKmJ2Rl
 zV/O6yBbYVSR1v8BOe5kfzzEgz+M4VjfLaJwqMKdClThxUHnfFEcpQ4GAxxPzUHPmbQ66oIVXay
 I/V94Gf+12dLp57b8qY1tUCj9D1IXjN0get5un024/t3XHj9
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-Endpoint-Received: by B4 Relay for mkl@pengutronix.de/default with auth_id=52
X-Original-From: Marc Kleine-Budde <mkl@pengutronix.de>
Reply-To: <mkl@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

Rename the rx_offload_get_echo_skb() function to
can_rx_offload_get_echo_skb_queue_timestamp(), since it inserts the
echo skb into the rx-offload queue sorted by timestamp.

This is a preparation for adding
can_rx_offload_get_echo_skb_queue_tail(), which adds the echo skb to
the end of the queue. This is intended for devices that do not support
timestamps.

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
index c5af92bcc9c9..5aa71854a708 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1013,10 +1013,10 @@ static void m_can_tx_update_stats(struct m_can_classdev *cdev,
 
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
index 54284661992e..1a48d4717e7c 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -748,8 +748,8 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
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

