Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80786C2E4E
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2019 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbfJAHk4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Oct 2019 03:40:56 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:36236 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733093AbfJAHk4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Oct 2019 03:40:56 -0400
X-ASG-Debug-ID: 1569915652-0a88186e2143b4010001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b03.edpnet.be with ESMTP id c15b3wdBQFUBVLFC; Tue, 01 Oct 2019 09:40:52 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id D1199A1D9CF;
        Tue,  1 Oct 2019 09:40:51 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     dev.kurt@vandijck-laurijssen.be, jhofstee@victronenergy.com
Subject: [PATCH 2/3] net can c_can: replace napi-hanlder with irqthread
Date:   Tue,  1 Oct 2019 09:40:37 +0200
X-ASG-Orig-Subj: [PATCH 2/3] net can c_can: replace napi-hanlder with irqthread
Message-Id: <1569915638-4605-3-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1569915638-4605-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1569915638-4605-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1569915652
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 4341
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8967 1.0000 3.1903
X-Barracuda-Spam-Score: 3.19
X-Barracuda-Spam-Status: No, SCORE=3.19 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76991
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The napi-handler defers c_can reception to softirq, but it is hard to
control the RT priority of the CAN recv end inside a softirq.
Using an irqthread allows precise control of it's RT priority.
Having the quota still around in the IRQ thread allows to restrict
the work_done per cycle.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c | 31 ++++++++++---------------------
 drivers/net/can/c_can/c_can.h |  1 -
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index b8e395a3..95de8e9 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -172,9 +172,6 @@
 /* Wait for ~1 sec for INIT bit */
 #define INIT_WAIT_MS		1000
 
-/* napi related */
-#define C_CAN_NAPI_WEIGHT	C_CAN_MSG_OBJ_RX_NUM
-
 /* c_can lec values */
 enum c_can_lec_type {
 	LEC_NO_ERROR = 0,
@@ -1025,9 +1022,9 @@ static int c_can_handle_bus_err(struct net_device *dev,
 	return 1;
 }
 
-static int c_can_poll(struct napi_struct *napi, int quota)
+static irqreturn_t c_can_thrd(int irq, void *dev_id)
 {
-	struct net_device *dev = napi->dev;
+	struct net_device *dev = (struct net_device *)dev_id;
 	struct c_can_priv *priv = netdev_priv(dev);
 	u16 curr, last = priv->last_status;
 	int work_done = 0;
@@ -1073,18 +1070,15 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 	work_done += c_can_handle_bus_err(dev, curr & LEC_MASK);
 
 	/* Handle Tx/Rx events. We do this unconditionally */
-	work_done += c_can_do_rx_poll(dev, (quota - work_done));
+	work_done += c_can_do_rx_poll(dev, C_CAN_MSG_OBJ_RX_NUM);
 	c_can_do_tx(dev);
 
 end:
-	if (work_done < quota) {
-		napi_complete_done(napi, work_done);
-		/* enable all IRQs if we are not in bus off state */
-		if (priv->can.state != CAN_STATE_BUS_OFF)
-			c_can_irq_control(priv, true);
-	}
+	/* enable all IRQs if we are not in bus off state */
+	if (priv->can.state != CAN_STATE_BUS_OFF)
+		c_can_irq_control(priv, true);
 
-	return work_done;
+	return work_done ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static irqreturn_t c_can_isr(int irq, void *dev_id)
@@ -1103,9 +1097,8 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
 
 	/* disable all interrupts and schedule the NAPI */
 	c_can_irq_control(priv, false);
-	napi_schedule(&priv->napi);
 
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
 }
 
 static int c_can_open(struct net_device *dev)
@@ -1124,8 +1117,8 @@ static int c_can_open(struct net_device *dev)
 	}
 
 	/* register interrupt handler */
-	err = request_irq(dev->irq, &c_can_isr, IRQF_SHARED, dev->name,
-				dev);
+	err = request_threaded_irq(dev->irq, &c_can_isr, c_can_thrd,
+			IRQF_SHARED, dev->name, dev);
 	if (err < 0) {
 		netdev_err(dev, "failed to request interrupt\n");
 		goto exit_irq_fail;
@@ -1138,7 +1131,6 @@ static int c_can_open(struct net_device *dev)
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
-	napi_enable(&priv->napi);
 	/* enable status change, error and module interrupts */
 	c_can_irq_control(priv, true);
 	netif_start_queue(dev);
@@ -1160,7 +1152,6 @@ static int c_can_close(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
 	c_can_stop(dev);
 	free_irq(dev->irq, dev);
 	close_candev(dev);
@@ -1183,7 +1174,6 @@ struct net_device *alloc_c_can_dev(void)
 		return NULL;
 
 	priv = netdev_priv(dev);
-	netif_napi_add(dev, &priv->napi, c_can_poll, C_CAN_NAPI_WEIGHT);
 
 	priv->dev = dev;
 	priv->can.bittiming_const = &c_can_bittiming_const;
@@ -1277,7 +1267,6 @@ void free_c_can_dev(struct net_device *dev)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	netif_napi_del(&priv->napi);
 	free_candev(dev);
 }
 EXPORT_SYMBOL_GPL(free_c_can_dev);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index d5567a7..9a8864f 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -194,7 +194,6 @@ struct c_can_raminit {
 /* c_can private data structure */
 struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
-	struct napi_struct napi;
 	struct net_device *dev;
 	struct device *device;
 	atomic_t tx_active;
-- 
1.8.5.rc3

