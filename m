Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0291AC493C
	for <lists+linux-can@lfdr.de>; Wed,  2 Oct 2019 10:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfJBIMt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Oct 2019 04:12:49 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:47551 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJBIMs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Oct 2019 04:12:48 -0400
X-ASG-Debug-ID: 1570003965-0a88186e21448dff0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b03.edpnet.be with ESMTP id NNEAKmA1HEtrM8Wr; Wed, 02 Oct 2019 10:12:45 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 90DD9A236C4;
        Wed,  2 Oct 2019 10:12:44 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: [PATCH 3/3] net can c_can: use rx-offload in irq handler
Date:   Wed,  2 Oct 2019 10:12:36 +0200
X-ASG-Orig-Subj: [PATCH 3/3] net can c_can: use rx-offload in irq handler
Message-Id: <1570003956-15727-4-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1570003956-15727-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1570003956-15727-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1570003965
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 7947
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9962 1.0000 4.2989
X-Barracuda-Spam-Score: 4.80
X-Barracuda-Spam-Status: No, SCORE=4.80 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77027
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When the irq handler schedules a napi softirq to read all CAN msgs
from the CAN chip, that softirq may come way later due to scheduling
and cause hardware buffer overlows.
This is especially bizarre on an RT system where you can elevate the
CAN irq handler priority, but the actual reading is done in softirq,
and depends again on other softirq work. This makes it impossible to
rectify.
This commit moves all HW access inside the irq handler, which will
queue using can_rx_offload.
Because the INT_REG is only read once per irq routine,
the lost busoff condition due to repetive reading is now gone too.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
CC: Wolfgang Grandegger <wg@grandegger.com>
CC: Joe Burmeister <joe.burmeister@devtank.co.uk>
---
 drivers/net/can/c_can/c_can.c          | 79 ++++++++++++++++------------------
 drivers/net/can/c_can/c_can.h          |  2 +-
 drivers/net/can/c_can/c_can_pci.c      |  1 +
 drivers/net/can/c_can/c_can_platform.c |  1 +
 4 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 5cfaab1..07bf279 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -41,6 +41,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/led.h>
+#include <linux/can/rx-offload.h>
 
 #include "c_can.h"
 
@@ -98,6 +99,9 @@
 #define BTR_TSEG2_SHIFT		12
 #define BTR_TSEG2_MASK		(0x7 << BTR_TSEG2_SHIFT)
 
+/* interrupt register */
+#define INT_STS_PENDING		0x8000
+
 /* brp extension register */
 #define BRP_EXT_BRPE_MASK	0x0f
 #define BRP_EXT_BRPE_SHIFT	0
@@ -170,9 +174,6 @@
 /* Wait for ~1 sec for INIT bit */
 #define INIT_WAIT_MS		1000
 
-/* napi related */
-#define C_CAN_NAPI_WEIGHT	C_CAN_MSG_OBJ_RX_NUM
-
 /* c_can lec values */
 enum c_can_lec_type {
 	LEC_NO_ERROR = 0,
@@ -385,7 +386,7 @@ static int c_can_handle_lost_msg_obj(struct net_device *dev,
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	netif_receive_skb(skb);
+	can_rx_offload_receive_skb(&priv->offload, skb);
 	return 1;
 }
 
@@ -437,7 +438,7 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
 	stats->rx_packets++;
 	stats->rx_bytes += frame->can_dlc;
 
-	netif_receive_skb(skb);
+	can_rx_offload_receive_skb(&priv->offload, skb);
 	return 0;
 }
 
@@ -984,7 +985,7 @@ static int c_can_handle_state_change(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
+	can_rx_offload_receive_skb(&priv->offload, skb);
 
 	return 1;
 }
@@ -1054,21 +1055,31 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
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
+	struct net_device *dev = (struct net_device *)dev_id;
 	struct c_can_priv *priv = netdev_priv(dev);
 	u16 curr, last = priv->last_status;
 	int work_done = 0;
+	int intreg;
 
-	priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
-	/* Ack status on C_CAN. D_CAN is self clearing */
-	if (priv->type != BOSCH_D_CAN)
-		priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+	intreg = priv->read_reg(priv, C_CAN_INT_REG);
+	if (!intreg)
+		return IRQ_NONE;
+
+	/* Only read the status register if a status interrupt was pending */
+	if (intreg & INT_STS_PENDING) {
+		priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
+		/* Ack status on C_CAN. D_CAN is self clearing */
+		if (priv->type != BOSCH_D_CAN)
+			priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+	} else
+		/* no change detected ... */
+		curr = last;
 
 	/* handle state changes */
 	if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
@@ -1107,35 +1118,17 @@ static int c_can_poll(struct napi_struct *napi, int quota)
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
 
 	return work_done;
 }
 
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
-}
-
 static int c_can_open(struct net_device *dev)
 {
 	int err;
@@ -1159,6 +1152,13 @@ static int c_can_open(struct net_device *dev)
 		goto exit_irq_fail;
 	}
 
+	/* initialize rx-offload */
+	err = can_rx_offload_add_fifo(dev, &priv->offload,
+					      C_CAN_MSG_OBJ_RX_NUM*2);
+	if (err)
+		goto exit_irq_fail;
+
+
 	/* start the c_can controller */
 	err = c_can_start(dev);
 	if (err)
@@ -1166,7 +1166,7 @@ static int c_can_open(struct net_device *dev)
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
-	napi_enable(&priv->napi);
+	can_rx_offload_enable(&priv->offload);
 	/* enable status change, error and module interrupts */
 	c_can_irq_control(priv, true);
 	netif_start_queue(dev);
@@ -1188,9 +1188,10 @@ static int c_can_close(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
+	can_rx_offload_disable(&priv->offload);
 	c_can_stop(dev);
 	free_irq(dev->irq, dev);
+	can_rx_offload_del(&priv->offload);
 	close_candev(dev);
 
 	c_can_reset_ram(priv, false);
@@ -1211,7 +1212,6 @@ struct net_device *alloc_c_can_dev(void)
 		return NULL;
 
 	priv = netdev_priv(dev);
-	netif_napi_add(dev, &priv->napi, c_can_poll, C_CAN_NAPI_WEIGHT);
 
 	priv->dev = dev;
 	priv->can.bittiming_const = &c_can_bittiming_const;
@@ -1303,9 +1303,6 @@ int c_can_power_up(struct net_device *dev)
 
 void free_c_can_dev(struct net_device *dev)
 {
-	struct c_can_priv *priv = netdev_priv(dev);
-
-	netif_napi_del(&priv->napi);
 	free_candev(dev);
 }
 EXPORT_SYMBOL_GPL(free_c_can_dev);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8acdc7f..2b0135a 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -194,7 +194,7 @@ struct c_can_raminit {
 /* c_can private data structure */
 struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
-	struct napi_struct napi;
+	struct can_rx_offload offload;
 	struct net_device *dev;
 	struct device *device;
 	atomic_t tx_active;
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 406b484..898456f 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 
 #include <linux/can/dev.h>
+#include <linux/can/rx-offload.h>
 
 #include "c_can.h"
 
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index b5145a7..3b1f0a3 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -36,6 +36,7 @@
 #include <linux/regmap.h>
 
 #include <linux/can/dev.h>
+#include <linux/can/rx-offload.h>
 
 #include "c_can.h"
 
-- 
1.8.5.rc3

