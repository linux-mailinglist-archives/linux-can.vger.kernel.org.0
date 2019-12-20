Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B812127896
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2019 10:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfLTJ4g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Dec 2019 04:56:36 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:59985 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLTJ4g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Dec 2019 04:56:36 -0500
X-ASG-Debug-ID: 1576835790-0a7b8d6ce17621c0002-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b02.edpnet.be with ESMTP id V0voCUuR7fd5ltUz; Fri, 20 Dec 2019 10:56:32 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 761CEBD9BFC;
        Fri, 20 Dec 2019 10:56:32 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 01/11] can: rx-offload: can_rx_offload_add_manual(): add new initialization function
Date:   Fri, 20 Dec 2019 10:55:17 +0100
X-ASG-Orig-Subj: [PATCH 01/11] can: rx-offload: can_rx_offload_add_manual(): add new initialization function
Message-Id: <1576835727-2956-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576835792
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2109
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5454 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78781
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a new initialization function:
can_rx_offload_add_manual()

It should be used to add support rx-offload to a driver, if the callback
mechanism should not be used. Use can_rx_offload_receive_skb() (added in
the next patch) to queue skbs into rx-offload.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
(cherry picked from commit 508e4fd43be32b400a62b009d567eaf07beb5f58)
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/rx-offload.c   | 11 +++++++++++
 include/linux/can/rx-offload.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index e832891..3b18026 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -351,6 +351,17 @@ int can_rx_offload_add_fifo(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_add_fifo);
 
+int can_rx_offload_add_manual(struct net_device *dev,
+			      struct can_rx_offload *offload,
+			      unsigned int weight)
+{
+	if (offload->mailbox_read)
+		return -EINVAL;
+
+	return can_rx_offload_init_queue(dev, offload, weight);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_add_manual);
+
 void can_rx_offload_enable(struct can_rx_offload *offload)
 {
 	napi_enable(&offload->napi);
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index 1b78a0c..f1b3808 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -35,6 +35,9 @@ int can_rx_offload_add_timestamp(struct net_device *dev,
 int can_rx_offload_add_fifo(struct net_device *dev,
 			    struct can_rx_offload *offload,
 			    unsigned int weight);
+int can_rx_offload_add_manual(struct net_device *dev,
+			      struct can_rx_offload *offload,
+			      unsigned int weight);
 int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
 					 u64 reg);
 int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload);
-- 
1.8.5.rc3

