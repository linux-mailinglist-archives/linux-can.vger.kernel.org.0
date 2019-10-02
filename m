Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEFBC493A
	for <lists+linux-can@lfdr.de>; Wed,  2 Oct 2019 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfJBIMq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Oct 2019 04:12:46 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:42490 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJBIMq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Oct 2019 04:12:46 -0400
X-ASG-Debug-ID: 1570003964-0a7b8d53bff23830001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b02.edpnet.be with ESMTP id zyQcO9SD5FR3AkID for <linux-can@vger.kernel.org>; Wed, 02 Oct 2019 10:12:44 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 785CBA236C0;
        Wed,  2 Oct 2019 10:12:43 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 1/3] can-rx-offload: merge initializer
Date:   Wed,  2 Oct 2019 10:12:34 +0200
X-ASG-Orig-Subj: [PATCH 1/3] can-rx-offload: merge initializer
Message-Id: <1570003956-15727-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1570003956-15727-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1570003956-15727-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1570003964
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2216
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9989 1.0000 4.3304
X-Barracuda-Spam-Score: 4.33
X-Barracuda-Spam-Status: No, SCORE=4.33 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77027
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

There is no reason to not test for the mailbox_read callback presence
in can_rx_offload_add_timestamp. When adding that test, it can as well
call can_rx_offload_add_fifo.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/rx-offload.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index a8acb2a..4796887 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -261,8 +261,18 @@ int can_rx_offload_queue_tail(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_queue_tail);
 
-static int can_rx_offload_init_queue(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
+static int can_rx_offload_irq_inval(struct can_rx_offload *offload)
 {
+	netdev_err_once(offload->dev, "%s called\n",
+				   __func__);
+	return 0;
+}
+
+int can_rx_offload_add_fifo(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
+{
+	if (!offload->mailbox_read)
+		return -EINVAL;
+
 	offload->dev = dev;
 
 	/* Limit queue len to 4x the weight (rounted to next power of two) */
@@ -278,6 +288,7 @@ static int can_rx_offload_init_queue(struct net_device *dev, struct can_rx_offlo
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(can_rx_offload_add_fifo);
 
 int can_rx_offload_add_timestamp(struct net_device *dev, struct can_rx_offload *offload)
 {
@@ -295,19 +306,10 @@ int can_rx_offload_add_timestamp(struct net_device *dev, struct can_rx_offload *
 		weight = offload->mb_first - offload->mb_last;
 	}
 
-	return can_rx_offload_init_queue(dev, offload, weight);
+	return can_rx_offload_add_fifo(dev, offload, weight);
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_add_timestamp);
 
-int can_rx_offload_add_fifo(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
-{
-	if (!offload->mailbox_read)
-		return -EINVAL;
-
-	return can_rx_offload_init_queue(dev, offload, weight);
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_add_fifo);
-
 void can_rx_offload_enable(struct can_rx_offload *offload)
 {
 	can_rx_offload_reset(offload);
-- 
1.8.5.rc3

