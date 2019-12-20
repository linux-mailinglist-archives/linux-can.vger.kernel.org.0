Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9063412789B
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2019 10:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLTJ4i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Dec 2019 04:56:38 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:52119 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfLTJ4h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Dec 2019 04:56:37 -0500
X-ASG-Debug-ID: 1576835792-0a7ff5137d1f74be0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b01.edpnet.be with ESMTP id TWKjUAqBY08agnr3 for <linux-can@vger.kernel.org>; Fri, 20 Dec 2019 10:56:32 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 8B1A9BD9BFE;
        Fri, 20 Dec 2019 10:56:32 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 02/11] can: rx-offload: add skb queue for use during ISR
Date:   Fri, 20 Dec 2019 10:55:18 +0100
X-ASG-Orig-Subj: [PATCH 02/11] can: rx-offload: add skb queue for use during ISR
Message-Id: <1576835727-2956-3-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576835792
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 5311
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8052 1.0000 2.2708
X-Barracuda-Spam-Score: 2.27
X-Barracuda-Spam-Status: No, SCORE=2.27 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78781
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When using rx-offload in manual mode, each skb requires a lock
on the skb_queue.
This commit avoids this by adding an unlocked skb queue
that is appended at once at the end of the ISR.
Having 1 lock at the end of the ISR should be ok
as the HW is empty, not about to overlow.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/rx-offload.c   | 74 ++++++++++++++++++++++++++++++------------
 include/linux/can/rx-offload.h |  5 +++
 2 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 3b18026..cf60896 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -174,10 +174,9 @@ static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
 int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 					 u64 pending)
 {
-	struct sk_buff_head skb_queue;
 	unsigned int i;
 
-	__skb_queue_head_init(&skb_queue);
+	can_rx_offload_irq_start(offload);
 
 	for (i = offload->mb_first;
 	     can_rx_offload_le(offload, i, offload->mb_last);
@@ -191,26 +190,13 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 		if (IS_ERR_OR_NULL(skb))
 			continue;
 
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
 
@@ -219,6 +205,7 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 	struct sk_buff *skb;
 	int received = 0;
 
+	can_rx_offload_irq_start(offload);
 	while (1) {
 		skb = can_rx_offload_offload_one(offload, 0);
 		if (IS_ERR(skb))
@@ -227,11 +214,11 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 			break;
 
 		skb_queue_tail(&offload->skb_queue, skb);
+		__skb_queue_tail(&offload->irq_skb_queue, skb);
 		received++;
 	}
 
-	if (received)
-		can_rx_offload_schedule(offload);
+	can_rx_offload_irq_end(offload);
 
 	return received;
 }
@@ -301,6 +288,51 @@ int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_queue_tail);
 
+void can_rx_offload_irq_start(struct can_rx_offload *offload)
+{
+	__skb_queue_head_init(&offload->irq_skb_queue);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_irq_start);
+
+int can_rx_offload_irq_receive_skb(struct can_rx_offload *offload,
+			       struct sk_buff *skb)
+{
+	struct net_device_stats *stats = &offload->dev->stats;
+
+	if (skb_queue_len(&offload->skb_queue) +
+			skb_queue_len(&offload->irq_skb_queue)
+			>= offload->skb_queue_len_max) {
+		kfree_skb(skb);
+		stats->rx_errors++;
+		stats->rx_fifo_errors++;
+		return -ENOMEM;
+	}
+	__skb_queue_tail(&offload->irq_skb_queue, skb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_receive_skb);
+
+
+void can_rx_offload_irq_end(struct can_rx_offload *offload)
+{
+	int queue_len;
+	unsigned long flags;
+
+	if (skb_queue_empty(&offload->irq_skb_queue))
+		return;
+	spin_lock_irqsave(&offload->skb_queue.lock, flags);
+	skb_queue_splice_tail(&offload->irq_skb_queue, &offload->skb_queue);
+	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+
+	queue_len = skb_queue_len(&offload->skb_queue);
+	if (queue_len > offload->skb_queue_len_max / 8)
+		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
+			   __func__, queue_len);
+
+	can_rx_offload_schedule(offload);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_irq_end);
+
 static int can_rx_offload_init_queue(struct net_device *dev,
 				     struct can_rx_offload *offload,
 				     unsigned int weight)
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index f1b3808..f83f53e 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -20,6 +20,7 @@ struct can_rx_offload {
 					bool drop);
 
 	struct sk_buff_head skb_queue;
+	struct sk_buff_head irq_skb_queue;
 	u32 skb_queue_len_max;
 
 	unsigned int mb_first;
@@ -47,6 +48,10 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
 					 unsigned int idx, u32 timestamp);
 int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb);
+void can_rx_offload_irq_start(struct can_rx_offload *offload);
+void can_rx_offload_irq_end(struct can_rx_offload *offload);
+int can_rx_offload_irq_receive_skb(struct can_rx_offload *offload,
+			       struct sk_buff *skb);
 void can_rx_offload_del(struct can_rx_offload *offload);
 void can_rx_offload_enable(struct can_rx_offload *offload);
 
-- 
1.8.5.rc3

