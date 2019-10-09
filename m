Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED673D0BBC
	for <lists+linux-can@lfdr.de>; Wed,  9 Oct 2019 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfJIJsx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Oct 2019 05:48:53 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:34611 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbfJIJsw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Oct 2019 05:48:52 -0400
X-ASG-Debug-ID: 1570614526-0a7b8d13bf1a17d0002-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b02.edpnet.be with ESMTP id Y6CHBhVeQFVe2wjJ for <linux-can@vger.kernel.org>; Wed, 09 Oct 2019 11:48:48 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 5513DA4C926;
        Wed,  9 Oct 2019 11:48:48 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 2/3] can: c_can: use can_rx_offload_irq_xxx
Date:   Wed,  9 Oct 2019 11:48:34 +0200
X-ASG-Orig-Subj: [PATCH 2/3] can: c_can: use can_rx_offload_irq_xxx
Message-Id: <1570614515-14765-3-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <20191009074338.GA23530@x1.vandijck-laurijssen.be>
 <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570614528
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 4243
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9445 1.0000 3.7105
X-Barracuda-Spam-Score: 3.71
X-Barracuda-Spam-Status: No, SCORE=3.71 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77241
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c | 12 ++++++++----
 drivers/net/can/rx-offload.c  | 30 ++++++++----------------------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 16d266b..8f68d51 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -384,7 +384,7 @@ static int c_can_handle_lost_msg_obj(struct net_device *dev,
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	can_rx_offload_receive_skb(&priv->offload, skb);
+	can_rx_offload_irq_receive_skb(&priv->offload, skb);
 	return 1;
 }
 
@@ -436,7 +436,7 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
 	stats->rx_packets++;
 	stats->rx_bytes += frame->can_dlc;
 
-	can_rx_offload_receive_skb(&priv->offload, skb);
+	can_rx_offload_irq_receive_skb(&priv->offload, skb);
 	return 0;
 }
 
@@ -948,7 +948,7 @@ static int c_can_handle_state_change(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	can_rx_offload_receive_skb(&priv->offload, skb);
+	can_rx_offload_irq_receive_skb(&priv->offload, skb);
 
 	return 1;
 }
@@ -1018,7 +1018,7 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	can_rx_offload_receive_skb(&priv->offload, skb);
+	can_rx_offload_irq_receive_skb(&priv->offload, skb);
 	return 1;
 }
 
@@ -1034,6 +1034,8 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
 	if (!reg_int)
 		return IRQ_NONE;
 
+	can_rx_offload_irq_start(&priv->offload);
+
 	/* Only read the status register if a status interrupt was pending */
 	if (reg_int & INT_STS_PENDING) {
 		priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
@@ -1080,6 +1082,8 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
 	c_can_do_tx(dev);
 
 end:
+	can_rx_offload_irq_end(&priv->offload);
+
 	/* disable all IRQs if we are in bus off state */
 	if (priv->can.state == CAN_STATE_BUS_OFF)
 		c_can_irq_control(priv, false);
diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 5613e7e..334e59c 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -153,10 +153,9 @@ static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
 int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 					 u64 pending)
 {
-	struct sk_buff_head skb_queue;
 	unsigned int i;
 
-	__skb_queue_head_init(&skb_queue);
+	can_rx_offload_irq_start(offload);
 
 	for (i = offload->mb_first;
 	     can_rx_offload_le(offload, i, offload->mb_last);
@@ -170,26 +169,13 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 		if (!skb)
 			break;
 
-		__skb_queue_add_sort(&skb_queue, skb, can_rx_offload_compare);
+		__skb_queue_add_sort(&offload->irq_skb_queue, skb,
+				can_rx_offload_compare);
 	}
 
-	if (!skb_queue_empty(&skb_queue)) {
-		unsigned long flags;
-		u32 queue_len;
+	can_rx_offload_irq_end(offload);
 
-		spin_lock_irqsave(&offload->skb_queue.lock, flags);
-		skb_queue_splice_tail(&skb_queue, &offload->skb_queue);
-		spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
-
-		queue_len = skb_queue_len(&offload->skb_queue);
-		if (queue_len > offload->skb_queue_len_max / 8)
-			netdev_dbg(offload->dev, "%s: queue_len=%d\n",
-				   __func__, queue_len);
-
-		can_rx_offload_schedule(offload);
-	}
-
-	return skb_queue_len(&skb_queue);
+	return skb_queue_len(&offload->irq_skb_queue);
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_timestamp);
 
@@ -198,13 +184,13 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 	struct sk_buff *skb;
 	int received = 0;
 
+	can_rx_offload_irq_start(offload);
 	while ((skb = can_rx_offload_offload_one(offload, 0))) {
-		skb_queue_tail(&offload->skb_queue, skb);
+		__skb_queue_tail(&offload->irq_skb_queue, skb);
 		received++;
 	}
 
-	if (received)
-		can_rx_offload_schedule(offload);
+	can_rx_offload_irq_end(offload);
 
 	return received;
 }
-- 
1.8.5.rc3

