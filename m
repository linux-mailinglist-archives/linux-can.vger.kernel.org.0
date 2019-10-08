Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4827ECF454
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 09:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfJHHwe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 03:52:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52707 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfJHHwd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 03:52:33 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iHkIJ-0005p5-0e; Tue, 08 Oct 2019 09:52:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 4/4] can: c_can: use rx-offload in IRQ handler
Date:   Tue,  8 Oct 2019 09:52:26 +0200
Message-Id: <20191008075226.12544-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008075226.12544-1-mkl@pengutronix.de>
References: <20191008075226.12544-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

When the IRQ handler schedules a NAPI softirq to read all CAN msgs from
the CAN chip, that softirq may come way later due to scheduling and
cause hardware buffer overlows.

This is especially bizarre on an RT system where you can elevate the CAN
IRQ handler priority, but the actual reading is done in softirq, and
depends again on other softirq work. This makes it impossible to
rectify.

This commit moves all HW access into the irq handler, which will queue
using can_rx_offload.

Because the INT_REG is only read once per irq routine, the lost busoff
condition due to repetive reading is now gone too.

Cc: Joe Burmeister <joe.burmeister@devtank.co.uk>
Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 85 ++++++++++++++++++-----------------
 drivers/net/can/c_can/c_can.h |  4 +-
 2 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 537a2f1febdf..16d266b10305 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -97,6 +97,9 @@
 #define BTR_TSEG2_SHIFT		12
 #define BTR_TSEG2_MASK		(0x7 << BTR_TSEG2_SHIFT)
 
+/* interrupt register */
+#define INT_STS_PENDING		0x8000
+
 /* brp extension register */
 #define BRP_EXT_BRPE_MASK	0x0f
 #define BRP_EXT_BRPE_SHIFT	0
@@ -169,9 +172,6 @@
 /* Wait for ~1 sec for INIT bit */
 #define INIT_WAIT_MS		1000
 
-/* napi related */
-#define C_CAN_NAPI_WEIGHT	C_CAN_MSG_OBJ_RX_NUM
-
 /* c_can lec values */
 enum c_can_lec_type {
 	LEC_NO_ERROR = 0,
@@ -384,7 +384,7 @@ static int c_can_handle_lost_msg_obj(struct net_device *dev,
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	netif_receive_skb(skb);
+	can_rx_offload_receive_skb(&priv->offload, skb);
 	return 1;
 }
 
@@ -436,7 +436,7 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
 	stats->rx_packets++;
 	stats->rx_bytes += frame->can_dlc;
 
-	netif_receive_skb(skb);
+	can_rx_offload_receive_skb(&priv->offload, skb);
 	return 0;
 }
 
@@ -948,7 +948,7 @@ static int c_can_handle_state_change(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
+	can_rx_offload_receive_skb(&priv->offload, skb);
 
 	return 1;
 }
@@ -1018,21 +1018,32 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
+	can_rx_offload_receive_skb(&priv->offload, skb);
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
 
-	priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
-	/* Ack status on C_CAN. D_CAN is self clearing */
-	if (priv->type != BOSCH_D_CAN)
-		priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+	reg_int = priv->read_reg(priv, C_CAN_INT_REG);
+	if (!reg_int)
+		return IRQ_NONE;
+
+	/* Only read the status register if a status interrupt was pending */
+	if (reg_int & INT_STS_PENDING) {
+		priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
+		/* Ack status on C_CAN. D_CAN is self clearing */
+		if (priv->type != BOSCH_D_CAN)
+			priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+	} else {
+		/* no change detected ... */
+		curr = last;
+	}
 
 	/* handle state changes */
 	if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
@@ -1065,33 +1076,18 @@ static int c_can_poll(struct napi_struct *napi, int quota)
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
+	/* disable all IRQs if we are in bus off state */
+	if (priv->can.state == CAN_STATE_BUS_OFF)
+		c_can_irq_control(priv, false);
 
-	return work_done;
-}
+	if (work_done)
+		return IRQ_HANDLED;
 
-static irqreturn_t c_can_isr(int irq, void *dev_id)
-{
-	struct net_device *dev = (struct net_device *)dev_id;
-	struct c_can_priv *priv = netdev_priv(dev);
-
-	if (!priv->read_reg(priv, C_CAN_INT_REG))
-		return IRQ_NONE;
-
-	/* disable all interrupts and schedule the NAPI */
-	c_can_irq_control(priv, false);
-	napi_schedule(&priv->napi);
-
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static int c_can_open(struct net_device *dev)
@@ -1124,7 +1120,7 @@ static int c_can_open(struct net_device *dev)
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
-	napi_enable(&priv->napi);
+	can_rx_offload_enable(&priv->offload);
 	/* enable status change, error and module interrupts */
 	c_can_irq_control(priv, true);
 	netif_start_queue(dev);
@@ -1146,7 +1142,7 @@ static int c_can_close(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
+	can_rx_offload_disable(&priv->offload);
 	c_can_stop(dev);
 	free_irq(dev->irq, dev);
 	close_candev(dev);
@@ -1169,7 +1165,6 @@ struct net_device *alloc_c_can_dev(void)
 		return NULL;
 
 	priv = netdev_priv(dev);
-	netif_napi_add(dev, &priv->napi, c_can_poll, C_CAN_NAPI_WEIGHT);
 
 	priv->dev = dev;
 	priv->can.bittiming_const = &c_can_bittiming_const;
@@ -1261,9 +1256,6 @@ EXPORT_SYMBOL_GPL(c_can_power_up);
 
 void free_c_can_dev(struct net_device *dev)
 {
-	struct c_can_priv *priv = netdev_priv(dev);
-
-	netif_napi_del(&priv->napi);
 	free_candev(dev);
 }
 EXPORT_SYMBOL_GPL(free_c_can_dev);
@@ -1292,14 +1284,21 @@ int register_c_can_dev(struct net_device *dev)
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
 
@@ -1313,6 +1312,8 @@ void unregister_c_can_dev(struct net_device *dev)
 
 	unregister_candev(dev);
 
+	can_rx_offload_del(&priv->offload);
+
 	c_can_pm_runtime_disable(priv);
 }
 EXPORT_SYMBOL_GPL(unregister_c_can_dev);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8acdc7fa4792..770e944df84b 100644
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
@@ -194,7 +196,7 @@ struct c_can_raminit {
 /* c_can private data structure */
 struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
-	struct napi_struct napi;
+	struct can_rx_offload offload;
 	struct net_device *dev;
 	struct device *device;
 	atomic_t tx_active;
-- 
2.23.0

