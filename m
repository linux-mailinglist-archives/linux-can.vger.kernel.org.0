Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3400127894
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2019 10:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLTJ4g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Dec 2019 04:56:36 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:59996 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfLTJ4g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Dec 2019 04:56:36 -0500
X-ASG-Debug-ID: 1576835792-0a7b8d6cde763810001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b02.edpnet.be with ESMTP id hq2xgnZTIt3PaDid; Fri, 20 Dec 2019 10:56:32 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id AFC5BBD9C02;
        Fri, 20 Dec 2019 10:56:32 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/11] can: c_can: use rx-offload in IRQ handler
Date:   Fri, 20 Dec 2019 10:55:20 +0100
X-ASG-Orig-Subj: [PATCH 04/11] can: c_can: use rx-offload in IRQ handler
Message-Id: <1576835727-2956-5-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576835792
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 7005
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5970 1.0000 0.7500
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

When the IRQ handler schedules a NAPI softirq to read all CAN msgs from
the CAN chip, that softirq may come way later due to scheduling and
cause hardware buffer overlows.

This commit moves all HW access into the irq handler, which will queue
using can_rx_offload.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
(cherry picked from commit b5317b4595756198c846fad4b105aa13eac0137f)
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 75 ++++++++++++++++++-------------------------
 drivers/net/can/c_can/c_can.h |  5 +--
 2 files changed, 34 insertions(+), 46 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index c436868..0357ee8 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -173,9 +173,6 @@
 /* Wait for ~1 sec for INIT bit */
 #define INIT_WAIT_MS		1000
 
-/* napi related */
-#define C_CAN_NAPI_WEIGHT	C_CAN_MSG_OBJ_RX_NUM
-
 /* c_can lec values */
 enum c_can_lec_type {
 	LEC_NO_ERROR = 0,
@@ -388,7 +385,7 @@ static int c_can_handle_lost_msg_obj(struct net_device *dev,
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	netif_receive_skb(skb);
+	can_rx_offload_irq_receive_skb(&priv->offload, skb);
 	return 1;
 }
 
@@ -440,7 +437,7 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
 	stats->rx_packets++;
 	stats->rx_bytes += frame->can_dlc;
 
-	netif_receive_skb(skb);
+	can_rx_offload_irq_receive_skb(&priv->offload, skb);
 	return 0;
 }
 
@@ -987,7 +984,7 @@ static int c_can_handle_state_change(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
+	can_rx_offload_irq_receive_skb(&priv->offload, skb);
 
 	return 1;
 }
@@ -1057,19 +1054,26 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
+	can_rx_offload_irq_receive_skb(&priv->offload, skb);
 	return 1;
 }
 
-static int c_can_poll(struct napi_struct *napi, int quota)
+static irqreturn_t c_can_isr(int irq, void *dev_id)
 {
-	struct net_device *dev = napi->dev;
+	struct net_device *dev = dev_id;
 	struct c_can_priv *priv = netdev_priv(dev);
 	u16 curr, last = priv->last_status;
 	int work_done = 0;
+	int reg_int;
+
+	reg_int = priv->read_reg(priv, C_CAN_INT_REG);
+	if (!reg_int)
+		return IRQ_NONE;
+
+	can_rx_offload_irq_start(&priv->offload);
 
 	/* Only read the status register if a status interrupt was pending */
-	if (atomic_xchg(&priv->sie_pending, 0)) {
+	if (reg_int & INT_STS_PENDING) {
 		priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
 		/* Ack status on C_CAN. D_CAN is self clearing */
 		if (priv->type != BOSCH_D_CAN)
@@ -1116,37 +1120,15 @@ static int c_can_poll(struct napi_struct *napi, int quota)
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
-
-	return work_done;
-}
+	can_rx_offload_irq_end(&priv->offload);
 
-static irqreturn_t c_can_isr(int irq, void *dev_id)
-{
-	struct net_device *dev = (struct net_device *)dev_id;
-	struct c_can_priv *priv = netdev_priv(dev);
-	int reg_int;
-
-	reg_int = priv->read_reg(priv, C_CAN_INT_REG);
-	if (!reg_int)
-		return IRQ_NONE;
-
-	/* save for later use */
-	if (reg_int & INT_STS_PENDING)
-		atomic_set(&priv->sie_pending, 1);
-
-	/* disable all interrupts and schedule the NAPI */
-	c_can_irq_control(priv, false);
-	napi_schedule(&priv->napi);
+	/* disable all IRQs if we are in bus off state */
+	if (priv->can.state == CAN_STATE_BUS_OFF)
+		c_can_irq_control(priv, false);
 
 	return IRQ_HANDLED;
 }
@@ -1181,7 +1163,7 @@ static int c_can_open(struct net_device *dev)
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
-	napi_enable(&priv->napi);
+	can_rx_offload_enable(&priv->offload);
 	/* enable status change, error and module interrupts */
 	c_can_irq_control(priv, true);
 	netif_start_queue(dev);
@@ -1203,7 +1185,7 @@ static int c_can_close(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
+	can_rx_offload_disable(&priv->offload);
 	c_can_stop(dev);
 	free_irq(dev->irq, dev);
 	close_candev(dev);
@@ -1226,7 +1208,6 @@ struct net_device *alloc_c_can_dev(void)
 		return NULL;
 
 	priv = netdev_priv(dev);
-	netif_napi_add(dev, &priv->napi, c_can_poll, C_CAN_NAPI_WEIGHT);
 
 	priv->dev = dev;
 	priv->can.bittiming_const = &c_can_bittiming_const;
@@ -1318,9 +1299,6 @@ int c_can_power_up(struct net_device *dev)
 
 void free_c_can_dev(struct net_device *dev)
 {
-	struct c_can_priv *priv = netdev_priv(dev);
-
-	netif_napi_del(&priv->napi);
 	free_candev(dev);
 }
 EXPORT_SYMBOL_GPL(free_c_can_dev);
@@ -1349,14 +1327,21 @@ int register_c_can_dev(struct net_device *dev)
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &c_can_netdev_ops;
 
-	err = register_candev(dev);
+	err = can_rx_offload_add_manual(dev, &priv->offload,
+					C_CAN_MSG_OBJ_RX_NUM);
 	if (err)
 		goto register_exit_runtime_disable;
 
+	err = register_candev(dev);
+	if (err)
+		goto register_exit_offload_del;
+
 	devm_can_led_init(dev);
 
 	return 0;
 
+ register_exit_offload_del:
+	can_rx_offload_del(&priv->offload);
  register_exit_runtime_disable:
 	c_can_pm_runtime_disable(priv);
 
@@ -1370,6 +1355,8 @@ void unregister_c_can_dev(struct net_device *dev)
 
 	unregister_candev(dev);
 
+	can_rx_offload_del(&priv->offload);
+
 	c_can_pm_runtime_disable(priv);
 }
 EXPORT_SYMBOL_GPL(unregister_c_can_dev);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index d5567a7..770e944 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -22,6 +22,8 @@
 #ifndef C_CAN_H
 #define C_CAN_H
 
+#include <linux/can/rx-offload.h>
+
 /* message object split */
 #define C_CAN_NO_OF_OBJECTS	32
 #define C_CAN_MSG_OBJ_RX_NUM	16
@@ -194,11 +196,10 @@ struct c_can_raminit {
 /* c_can private data structure */
 struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
-	struct napi_struct napi;
+	struct can_rx_offload offload;
 	struct net_device *dev;
 	struct device *device;
 	atomic_t tx_active;
-	atomic_t sie_pending;
 	unsigned long tx_dir;
 	int last_status;
 	u16 (*read_reg) (const struct c_can_priv *priv, enum reg index);
-- 
1.8.5.rc3

