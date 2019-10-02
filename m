Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D30BC493B
	for <lists+linux-can@lfdr.de>; Wed,  2 Oct 2019 10:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfJBIMs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Oct 2019 04:12:48 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:42500 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfJBIMs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Oct 2019 04:12:48 -0400
X-ASG-Debug-ID: 1570003964-0a7b8d53bff23830002-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b02.edpnet.be with ESMTP id 2yxTBx5hk3sIxqtC for <linux-can@vger.kernel.org>; Wed, 02 Oct 2019 10:12:45 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 81AA1A236C2;
        Wed,  2 Oct 2019 10:12:44 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 2/3] can-rx-offload: add can_rx_offload_receive_skb
Date:   Wed,  2 Oct 2019 10:12:35 +0200
X-ASG-Orig-Subj: [PATCH 2/3] can-rx-offload: add can_rx_offload_receive_skb
Message-Id: <1570003956-15727-3-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1570003956-15727-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1570003956-15727-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1570003965
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2664
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5334 1.0000 0.7500
X-Barracuda-Spam-Score: 1.25
X-Barracuda-Spam-Status: No, SCORE=1.25 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77027
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The can-rx-offload provides a mechanism to rapidly get CAN msgs out of
the CAN chip, and queue them a bit before the napi will process them in
softirq.
The current can-rx-offload only supports a callback that reads the CAN frame
from the chip with only a mailbox index.
This commit provides a netif_receive_skb alike function that uses
the can-rx-offload queueing without callback.
This makes transition easier, especially when more context info is
required which makes the callback method harder.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/rx-offload.c   | 24 ++++++++++++++++++++----
 include/linux/can/rx-offload.h |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 4796887..f45b0b6 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -261,17 +261,33 @@ int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_queue_tail);
 
-static int can_rx_offload_irq_inval(struct can_rx_offload *offload)
+int can_rx_offload_receive_skb(struct can_rx_offload *offload,
+		struct sk_buff *skb)
 {
-	netdev_err_once(offload->dev, "%s called\n",
-				   __func__);
+	int ret;
+	struct net_device_stats *stats = &offload->dev->stats;
+
+	ret = can_rx_offload_queue_tail(offload, skb);
+	if (ret < 0) {
+		kfree_skb(skb);
+		stats->rx_errors++;
+		stats->rx_fifo_errors++;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_receive_skb);
+
+static unsigned int  can_rx_offload_mb_read_inval(struct can_rx_offload *offload,
+		struct can_frame *cf, u32 *timestamp, unsigned int mb)
+{
+	netdev_err_once(offload->dev, "%s called\n", __func__);
 	return 0;
 }
 
 int can_rx_offload_add_fifo(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
 {
 	if (!offload->mailbox_read)
-		return -EINVAL;
+		offload->mailbox_read = can_rx_offload_mb_read_inval;
 
 	offload->dev = dev;
 
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index 9daa111..3c09c56 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -43,6 +43,8 @@ int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 void can_rx_offload_del(struct can_rx_offload *offload);
 void can_rx_offload_enable(struct can_rx_offload *offload);
 
+int can_rx_offload_receive_skb(struct can_rx_offload *offload, struct sk_buff *skb);
+
 static inline void can_rx_offload_schedule(struct can_rx_offload *offload)
 {
 	napi_schedule(&offload->napi);
-- 
1.8.5.rc3

