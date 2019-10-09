Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D77D6D0BBE
	for <lists+linux-can@lfdr.de>; Wed,  9 Oct 2019 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfJIJsw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Oct 2019 05:48:52 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:34589 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbfJIJsw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Oct 2019 05:48:52 -0400
X-ASG-Debug-ID: 1570614526-0a7b8d13bf1a17d0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b02.edpnet.be with ESMTP id ZqZob6oo5oc6V8TO for <linux-can@vger.kernel.org>; Wed, 09 Oct 2019 11:48:46 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 70F24A4C924;
        Wed,  9 Oct 2019 11:48:44 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 1/3] can: rx-offload: add skb queue for use during ISR
Date:   Wed,  9 Oct 2019 11:48:33 +0200
X-ASG-Orig-Subj: [PATCH 1/3] can: rx-offload: add skb queue for use during ISR
Message-Id: <1570614515-14765-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <20191009074338.GA23530@x1.vandijck-laurijssen.be>
 <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570614526
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 3287
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7309 1.0000 1.6126
X-Barracuda-Spam-Score: 2.11
X-Barracuda-Spam-Status: No, SCORE=2.11 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77241
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
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
 drivers/net/can/rx-offload.c   | 45 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/can/rx-offload.h |  5 +++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 138b8b8..5613e7e 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -287,6 +287,51 @@ int can_rx_offload_receive_skb(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_receive_skb);
 
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
index c324233..6b0b73c 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -20,6 +20,7 @@ struct can_rx_offload {
 				     u32 *timestamp, unsigned int mb);
 
 	struct sk_buff_head skb_queue;
+	struct sk_buff_head irq_skb_queue;
 	u32 skb_queue_len_max;
 
 	unsigned int mb_first;
@@ -49,6 +50,10 @@ int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 			      struct sk_buff *skb);
 int can_rx_offload_receive_skb(struct can_rx_offload *offload,
 			       struct sk_buff *skb);
+void can_rx_offload_irq_start(struct can_rx_offload *offload);
+void can_rx_offload_irq_end(struct can_rx_offload *offload);
+int can_rx_offload_irq_receive_skb(struct can_rx_offload *offload,
+			       struct sk_buff *skb);
 void can_rx_offload_del(struct can_rx_offload *offload);
 void can_rx_offload_enable(struct can_rx_offload *offload);
 
-- 
1.8.5.rc3

