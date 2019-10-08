Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67B8CCF4F1
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 10:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfJHIYM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 8 Oct 2019 04:24:12 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:53959 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfJHIYM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 04:24:12 -0400
X-ASG-Debug-ID: 1570523047-0a7ff54e97ad9f80001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b01.edpnet.be with ESMTP id 1ScmlRV4LVCNExtY; Tue, 08 Oct 2019 10:24:08 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id B91A8A472B3;
        Tue,  8 Oct 2019 10:24:07 +0200 (CEST)
Date:   Tue, 8 Oct 2019 10:24:04 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: Re: [PATCH v3 0/4] can: c_can/rx-offload
Message-ID: <20191008082404.GC20524@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH v3 0/4] can: c_can/rx-offload
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
References: <20191008075226.12544-1-mkl@pengutronix.de>
 <20191008080711.GA20524@x1.vandijck-laurijssen.be>
 <002eccee-3357-2ed8-5ba8-6f1a39b345bc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <002eccee-3357-2ed8-5ba8-6f1a39b345bc@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570523047
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 7193
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5528 1.0000 0.7500
X-Barracuda-Spam-Score: 1.25
X-Barracuda-Spam-Status: No, SCORE=1.25 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77211
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 08 okt 2019 10:13:37 +0200, Marc Kleine-Budde wrote:
> On 10/8/19 10:07 AM, Kurt Van Dijck wrote:
> > On di, 08 okt 2019 09:52:22 +0200, Marc Kleine-Budde wrote:
> >> Hello,
> >>
> >> taking up Kurt's work. I've cleaned up the rx-offload and c_can patches
> >> a bit. Untested as I don't have any hardware at hand.
> > 
> > I had created equivalent code (skb_queue in isr, skb_dequeue in napi
> > handler) running on a 4.9 kernel since some days now. I didn't observe
> > any problems yet.
> 
> This is based on the patches you send around.
> Anyways can you send me your currently working version?

I know. My first attempt was to backport rx-offload, but this was more
work than expected, so I created this patch, doing the skb_queue inside
c_can driver directly. I wrote that patch with the latest rx-offload.c
side-by-side.

I just wrote it this way quickly so I could go ahead and test the mower,
upgrading to a more recent kernel is scheduled within a few months or
so.

From ba7d83f7e8c6a70fc4593cd069b27d6bbe0c5b8e Mon Sep 17 00:00:00 2001
From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Date: Sat, 5 Oct 2019 22:43:53 +0200
Subject: [PATCH 22/23] c_can: use fifo

Avoid softirq latency by reading the CAN msgs in the irq handler,
and push the msgs in a FIFO.
The napi handler will empty the FIFO in softirq.

This commit also avoids missed CAN status interrupts,
INT_REG is only read once per interrupt.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c | 81 +++++++++++++++++++++++++++----------------
 drivers/net/can/c_can/c_can.h |  1 +
 2 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 033a376..3815226 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -98,6 +98,9 @@
 #define BTR_TSEG2_SHIFT		12
 #define BTR_TSEG2_MASK		(0x7 << BTR_TSEG2_SHIFT)
 
+/* interrupt register */
+#define INT_STS_PENDING		0x8000
+
 /* brp extension register */
 #define BRP_EXT_BRPE_MASK	0x0f
 #define BRP_EXT_BRPE_SHIFT	0
@@ -172,6 +175,7 @@
 
 /* napi related */
 #define C_CAN_NAPI_WEIGHT	C_CAN_MSG_OBJ_RX_NUM
+#define C_CAN_MAX_FIFO_LEN	(C_CAN_NAPI_WEIGHT*4)
 
 /* c_can lec values */
 enum c_can_lec_type {
@@ -385,7 +389,7 @@ static int c_can_handle_lost_msg_obj(struct net_device *dev,
 	frame->can_id |= CAN_ERR_CRTL;
 	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	netif_receive_skb(skb);
+	skb_queue_tail(&priv->skb_queue, skb);
 	return 1;
 }
 
@@ -437,7 +441,7 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
 	stats->rx_packets++;
 	stats->rx_bytes += frame->can_dlc;
 
-	netif_receive_skb(skb);
+	skb_queue_tail(&priv->skb_queue, skb);
 	return 0;
 }
 
@@ -739,6 +743,7 @@ static void c_can_do_tx(struct net_device *dev)
 		pend &= ~(1 << idx);
 		obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
 		c_can_inval_tx_object(dev, IF_RX, obj);
+		/* TODO: fix echo skb */
 		can_get_echo_skb(dev, idx);
 		bytes += priv->dlc[idx];
 		pkts++;
@@ -984,7 +989,7 @@ static int c_can_handle_state_change(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
+	skb_queue_tail(&priv->skb_queue, skb);
 
 	return 1;
 }
@@ -1054,7 +1059,7 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
+	skb_queue_tail(&priv->skb_queue, skb);
 	return 1;
 }
 
@@ -1062,13 +1067,45 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
 	struct c_can_priv *priv = netdev_priv(dev);
+	struct sk_buff *skb;
+	int work_done;
+
+	for (; work_done < quota; ++work_done) {
+		skb = skb_dequeue(&priv->skb_queue);
+		if (!skb)
+			break;
+		netif_receive_skb(skb);
+	}
+	if (work_done < quota) {
+		napi_complete(napi);
+
+		/* don't hang if there are already more msgs received */
+		if (!skb_queue_empty(&priv->skb_queue))
+			napi_reschedule(napi);
+	}
+	return work_done;
+}
+
+static irqreturn_t c_can_isr(int irq, void *dev_id)
+{
+	struct net_device *dev = (struct net_device *)dev_id;
+	struct c_can_priv *priv = netdev_priv(dev);
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
+	if (intreg & INT_STS_PENDING) {
+		priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
+		/* Ack status on C_CAN. D_CAN is self clearing */
+		if (priv->type != BOSCH_D_CAN)
+			priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
+	} else
+		/* no change */
+		curr = last;
 
 	/* handle state changes */
 	if ((curr & STATUS_EWARN) && (!(last & STATUS_EWARN))) {
@@ -1107,32 +1144,15 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 	work_done += c_can_handle_bus_err(dev, curr & LEC_MASK);
 
 	/* Handle Tx/Rx events. We do this unconditionally */
-	work_done += c_can_do_rx_poll(dev, (quota - work_done));
+	work_done += c_can_do_rx_poll(dev, C_CAN_MAX_FIFO_LEN);
 	c_can_do_tx(dev);
 
 end:
-	if (work_done < quota) {
-		napi_complete(napi);
-		/* enable all IRQs if we are not in bus off state */
-		if (priv->can.state != CAN_STATE_BUS_OFF)
-			c_can_irq_control(priv, true);
-	}
-
-	return work_done;
-}
-
-static irqreturn_t c_can_isr(int irq, void *dev_id)
-{
-	struct net_device *dev = (struct net_device *)dev_id;
-	struct c_can_priv *priv = netdev_priv(dev);
+	/* disable all IRQs if we are in bus off state */
+	if (priv->can.state == CAN_STATE_BUS_OFF)
+		c_can_irq_control(priv, false);
 
-	if (!priv->read_reg(priv, C_CAN_INT_REG))
-		return IRQ_NONE;
-
-	/* disable all interrupts and schedule the NAPI */
-	c_can_irq_control(priv, false);
 	napi_schedule(&priv->napi);
-
 	return IRQ_HANDLED;
 }
 
@@ -1151,6 +1171,8 @@ static int c_can_open(struct net_device *dev)
 		goto exit_open_fail;
 	}
 
+	/* init fifo */
+	skb_queue_head_init(&priv->skb_queue);
 	/* register interrupt handler */
 	err = request_irq(dev->irq, &c_can_isr, IRQF_SHARED, dev->name,
 				dev);
@@ -1191,6 +1213,7 @@ static int c_can_close(struct net_device *dev)
 	napi_disable(&priv->napi);
 	c_can_stop(dev);
 	free_irq(dev->irq, dev);
+	skb_queue_purge(&priv->skb_queue);
 	close_candev(dev);
 
 	c_can_reset_ram(priv, false);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8acdc7f..a23a843d 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -195,6 +195,7 @@ struct c_can_raminit {
 struct c_can_priv {
 	struct can_priv can;	/* must be the first member */
 	struct napi_struct napi;
+	struct sk_buff_head skb_queue;
 	struct net_device *dev;
 	struct device *device;
 	atomic_t tx_active;
-- 
1.8.5.rc3

