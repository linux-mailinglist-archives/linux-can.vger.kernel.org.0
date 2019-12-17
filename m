Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68EF123030
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 16:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfLQPXe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 10:23:34 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:37257 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbfLQPXd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 10:23:33 -0500
X-ASG-Debug-ID: 1576596209-0a881838821627fb0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b03.edpnet.be with ESMTP id Rc493Dbqz2fPkE3e; Tue, 17 Dec 2019 16:23:29 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 2613FBCDEBB;
        Tue, 17 Dec 2019 16:23:29 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>,
        Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 11/11] can: c_can: increase RX queue, TX queue fixed to 8
Date:   Tue, 17 Dec 2019 16:23:26 +0100
X-ASG-Orig-Subj: [PATCH 11/11] can: c_can: increase RX queue, TX queue fixed to 8
Message-Id: <1576596206-27260-4-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
 <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576596209
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 5480
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7672 1.0000 1.9222
X-Barracuda-Spam-Score: 1.92
X-Barracuda-Spam-Status: No, SCORE=1.92 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78718
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>

Make number of D_CAN RX message objects bigger.
The 50/50 split make a too big send queue with a too small recv queue.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c | 57 ++++++++++++++++++++++++++++---------------
 drivers/net/can/c_can/c_can.h |  6 ++++-
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 189a8d7..3541935 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -214,6 +214,21 @@ enum c_can_bus_error_types {
 	[BOSCH_D_CAN] = 64, /* the IP supports 128, we support only 64 */
 };
 
+static inline int c_can_ffs64(u64 x)
+{
+	int b;
+
+	b = ffs(x);
+
+	if (!b) {
+		b = ffs(x >> 32);
+		if (b)
+			b += 32;
+	}
+
+	return b;
+}
+
 static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
 {
 	if (priv->device)
@@ -726,22 +741,23 @@ static void c_can_do_tx(struct net_device *dev)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
-	u32 idx, obj, pkts = 0, bytes = 0, pend, clr;
+	u32 idx, obj, pkts = 0, bytes = 0;
+	u64 pend, clr;
 	struct sk_buff *skb;
 	u8 len;
 
+	/* Mask interrupt pending bits */
+	pend = priv->read_reg32(priv, C_CAN_INTPND1_REG);
 	if (priv->type == BOSCH_D_CAN) {
-		pend = priv->read_reg32(priv, C_CAN_INTPND3_REG);
-	} else {
-		pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
+		pend |= (u64)priv->read_reg32(priv, C_CAN_INTPND3_REG) << 32;
 	}
-	clr = pend;
+	pend &= ~priv->obj.recv_mask;
+	clr = pend >> priv->obj.recv_count;
 
-	while ((idx = ffs(pend))) {
-		idx--;
-		pend &= ~(1 << idx);
-		obj = idx + priv->obj.send_frst;
+	while ((obj = c_can_ffs64(pend))) {
+		pend &= ~((u64)1 << (obj - 1));
 		c_can_inval_tx_object(dev, IF_RX, obj);
+		idx = obj - priv->obj.send_frst;
 		skb = __can_get_echo_skb(dev, idx, &len);
 		can_rx_offload_irq_receive_skb(&priv->offload, skb);
 		bytes += len;
@@ -766,9 +782,9 @@ static void c_can_do_tx(struct net_device *dev)
  * raced with the hardware or failed to readout all upper
  * objects in the last run due to quota limit.
  */
-static u32 c_can_adjust_pending(struct c_can_priv *priv, u32 pend)
+static u64 c_can_adjust_pending(struct c_can_priv *priv, u64 pend)
 {
-	u32 weight, lasts;
+	u64 weight, lasts;
 
 	if (pend == priv->obj.recv_mask)
 		return pend;
@@ -777,8 +793,8 @@ static u32 c_can_adjust_pending(struct c_can_priv *priv, u32 pend)
 	 * If the last set bit is larger than the number of pending
 	 * bits we have a gap.
 	 */
-	weight = hweight32(pend);
-	lasts = fls(pend);
+	weight = hweight64(pend);
+	lasts = fls64(pend);
 
 	/* If the bits are linear, nothing to do */
 	if (lasts == weight)
@@ -807,11 +823,11 @@ static inline void c_can_rx_finalize(struct net_device *dev,
 }
 
 static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
-			      u32 pend)
+			      u64 pend)
 {
 	u32 pkts = 0, ctrl, obj;
 
-	while ((obj = ffs(pend))) {
+	while ((obj = c_can_ffs64(pend))) {
 		pend &= ~BIT(obj - 1);
 
 		c_can_rx_object_get(dev, priv, obj);
@@ -843,12 +859,14 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 	return pkts;
 }
 
-static inline u32 c_can_get_pending(struct c_can_priv *priv)
+static inline u64 c_can_get_pending(struct c_can_priv *priv)
 {
-	u32 pend;
+	u64 pend;
 
 	if (priv->type == BOSCH_D_CAN) {
 		pend = priv->read_reg32(priv, C_CAN_NEWDAT1_REG);
+		pend |= (u64)priv->read_reg32(priv, C_CAN_NEWDAT3_REG) << 32;
+		pend &= priv->obj.recv_mask;
 	} else {
 		pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
 	}
@@ -871,7 +889,8 @@ static inline u32 c_can_get_pending(struct c_can_priv *priv)
 static int c_can_do_rx_poll(struct net_device *dev)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
-	u32 pkts = 0, pend = 0, toread, n;
+	u32 pkts = 0, n;
+	u64 pend = 0, toread;
 
 	for (;;) {
 		if (!pend) {
@@ -1205,7 +1224,7 @@ struct net_device *alloc_c_can_dev(int type, int object_count)
 
 	if (!object_count || object_count > c_can_obj_counts[type])
 		object_count = c_can_obj_counts[type];
-	send_object_count = object_count/2;
+	send_object_count = 8;
 
 	dev = alloc_candev(sizeof(struct c_can_priv), send_object_count);
 	if (!dev)
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 0a426d9..b3413a2 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -59,6 +59,8 @@ enum reg {
 	C_CAN_TXRQST2_REG,
 	C_CAN_NEWDAT1_REG,
 	C_CAN_NEWDAT2_REG,
+	C_CAN_NEWDAT3_REG,
+	C_CAN_NEWDAT4_REG,
 	C_CAN_INTPND1_REG,
 	C_CAN_INTPND2_REG,
 	C_CAN_INTPND3_REG,
@@ -122,6 +124,8 @@ enum reg {
 	[C_CAN_TXRQST2_REG]	= 0x8A,
 	[C_CAN_NEWDAT1_REG]	= 0x9C,
 	[C_CAN_NEWDAT2_REG]	= 0x9E,
+	[C_CAN_NEWDAT3_REG]	= 0xA0,
+	[C_CAN_NEWDAT4_REG]	= 0xA2,
 	[C_CAN_INTPND1_REG]	= 0xB0,
 	[C_CAN_INTPND2_REG]	= 0xB2,
 	[C_CAN_INTPND3_REG]	= 0xB4,
@@ -205,7 +209,7 @@ struct c_can_priv {
 	struct c_can_obj_def {
 		int count;
 		int recv_count;
-		u32 recv_mask;
+		u64 recv_mask;
 		int recv_frst;
 		int recv_last;
 		int send_count;
-- 
1.8.5.rc3

