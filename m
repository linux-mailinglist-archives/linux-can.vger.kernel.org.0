Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029E758062
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjGRPGH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 11:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjGRPGG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 11:06:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A633E56
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 08:06:05 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLmH5-0003aE-Fe
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 17:06:03 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 993921F4367
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 15:06:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E15CA1F435B;
        Tue, 18 Jul 2023 15:06:01 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8ffdffff;
        Tue, 18 Jul 2023 15:06:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 17:05:48 +0200
Subject: [PATCH v2 1/3] can: rx-offload: rename rx_offload_get_echo_skb()
 -> can_rx_offload_get_echo_skb_queue_timestamp()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-gs_usb-rx-offload-v2-1-716e542d14d5@pengutronix.de>
References: <20230718-gs_usb-rx-offload-v2-0-716e542d14d5@pengutronix.de>
In-Reply-To: <20230718-gs_usb-rx-offload-v2-0-716e542d14d5@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5545; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=9GmvKX5y5wrpybhwwMWGo9gxVtZQga1BhgbPge2s6nk=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktqpSUQzRtlz7wVifnlCnrUhFeU80/9F1eblLy
 xrclKakGMCJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLaqUgAKCRC+UBxKKooE
 6EtvB/sFg8ZlmFJ4S/x9UyzLglwzzq9huKwN65WY+Y8g/1G7bkmhU1Tc5WF0EsZyFO4sZ+pyFfa
 PZRW6zEBValIGlMxhSDC6963k8b83WvA17PbaQtohhEzNd3puygt7pROaFQRZb/RpgqyK9HJaGx
 Ep0v9BOuGUhNkVEG8QwHeguwEOM5fjFvuhMeWyHaJR/NFq78Ue18RC0mdttUpSfxXuB/44w943z
 9ywcr1xvcJw29PUECWSvEVxPKTcE5dbG1mZy/5aim9IUTLbeULOnfHX1ZmKubZoV0INlq8gF7Ca
 /4EJTPS7VgsDlTB0FcF/No4CWABC9B/fexf7LwBf76TsUc6T
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 13fd84b2e2dd..e46f5e8fc4e8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1017,10 +1017,10 @@ static void m_can_tx_update_stats(struct m_can_classdev *cdev,
 
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


