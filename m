Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B82122D7C
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 14:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfLQNxU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 08:53:20 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:55126 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbfLQNxU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 08:53:20 -0500
X-ASG-Debug-ID: 1576590794-0a88183884161a3b0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b03.edpnet.be with ESMTP id TPBYOFaYZckqgRzO for <linux-can@vger.kernel.org>; Tue, 17 Dec 2019 14:53:14 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 9EDB8BCDC0A;
        Tue, 17 Dec 2019 14:53:14 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 10/11] can: c_can: message object division not hardcoded
Date:   Tue, 17 Dec 2019 14:53:05 +0100
X-ASG-Orig-Subj: [PATCH 10/11] can: c_can: message object division not hardcoded
Message-Id: <1576590786-22075-3-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576590786-22075-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
 <1576590786-22075-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576590794
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 6815
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9964 1.0000 4.3013
X-Barracuda-Spam-Score: 4.30
X-Barracuda-Spam-Status: No, SCORE=4.30 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78717
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c | 57 ++++++++++++++++++++++++++++++-------------
 drivers/net/can/c_can/c_can.h | 36 +++++++++------------------
 2 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 848cc77..f4d373d 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -173,10 +173,6 @@
 /* Wait for ~1 sec for INIT bit */
 #define INIT_WAIT_MS		1000
 
-/* Weight for rx-offload (napi) */
-#define C_CAN_OFFLOAD_WEIGHT	(C_CAN_MSG_OBJ_RX_NUM *2 \
-		+ C_CAN_MSG_OBJ_TX_NUM +16)
-
 /* c_can lec values */
 enum c_can_lec_type {
 	LEC_NO_ERROR = 0,
@@ -213,6 +209,29 @@ enum c_can_bus_error_types {
 	.brp_inc = 1,
 };
 
+static const struct c_can_obj_def c_can_obj_defs[] = {
+	[BOSCH_C_CAN] = {
+		.count = 32,
+		.recv_count = 16,
+		.recv_mask = 0x0000ffffUL,
+		.recv_frst = 1,
+		.recv_last = 16,
+		.send_count = 16,
+		.send_frst = 17,
+		.send_last = 32,
+	},
+	[BOSCH_D_CAN] = {
+		.count = 64,
+		.recv_count = 32,
+		.recv_mask = 0xffffffffUL,
+		.recv_frst = 1,
+		.recv_last = 32,
+		.send_count = 32,
+		.send_frst = 33,
+		.send_frst = 64,
+	},
+};
+
 static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
 {
 	if (priv->device)
@@ -327,7 +346,7 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 	 * first, i.e. clear the MSGVAL flag in the arbiter.
 	 */
 	if (rtr != (bool)test_bit(idx, &priv->tx_dir)) {
-		u32 obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+		u32 obj = idx + priv->obj.send_frst;
 
 		c_can_inval_msg_object(dev, iface, obj);
 		change_bit(idx, &priv->tx_dir);
@@ -465,10 +484,10 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	 * prioritized. The lowest buffer number wins.
 	 */
 	idx = fls(atomic_read(&priv->tx_active));
-	obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+	obj = idx + priv->obj.send_frst;
 
 	/* If this is the last buffer, stop the xmit queue */
-	if (idx == C_CAN_MSG_OBJ_TX_NUM - 1)
+	if (idx == priv->obj.send_count - 1)
 		netif_stop_queue(dev);
 	/*
 	 * Store the message in the interface so we can call
@@ -550,17 +569,18 @@ static int c_can_set_bittiming(struct net_device *dev)
  */
 static void c_can_configure_msg_objects(struct net_device *dev)
 {
+	struct c_can_priv *priv = netdev_priv(dev);
 	int i;
 
 	/* first invalidate all message objects */
-	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_NO_OF_OBJECTS; i++)
+	for (i = priv->obj.recv_frst; i <= priv->obj.count; i++)
 		c_can_inval_msg_object(dev, IF_RX, i);
 
 	/* setup receive message objects */
-	for (i = C_CAN_MSG_OBJ_RX_FIRST; i < C_CAN_MSG_OBJ_RX_LAST; i++)
+	for (i = priv->obj.recv_frst; i < priv->obj.recv_last; i++)
 		c_can_setup_receive_object(dev, IF_RX, i, 0, 0, IF_MCONT_RCV);
 
-	c_can_setup_receive_object(dev, IF_RX, C_CAN_MSG_OBJ_RX_LAST, 0, 0,
+	c_can_setup_receive_object(dev, IF_RX, priv->obj.recv_last, 0, 0,
 				   IF_MCONT_RCV_EOB);
 }
 
@@ -738,7 +758,7 @@ static void c_can_do_tx(struct net_device *dev)
 	while ((idx = ffs(pend))) {
 		idx--;
 		pend &= ~(1 << idx);
-		obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+		obj = idx + priv->obj.send_frst;
 		c_can_inval_tx_object(dev, IF_RX, obj);
 		skb = __can_get_echo_skb(dev, idx, &len);
 		can_rx_offload_irq_receive_skb(&priv->offload, skb);
@@ -749,7 +769,7 @@ static void c_can_do_tx(struct net_device *dev)
 	/* Clear the bits in the tx_active mask */
 	atomic_sub(clr, &priv->tx_active);
 
-	if (clr & (1 << (C_CAN_MSG_OBJ_TX_NUM - 1)))
+	if (clr & (1 << (priv->obj.send.count - 1)))
 		netif_wake_queue(dev);
 
 	if (pkts) {
@@ -764,11 +784,11 @@ static void c_can_do_tx(struct net_device *dev)
  * raced with the hardware or failed to readout all upper
  * objects in the last run due to quota limit.
  */
-static u32 c_can_adjust_pending(u32 pend)
+static u32 c_can_adjust_pending(struct c_can_priv *priv, u32 pend)
 {
 	u32 weight, lasts;
 
-	if (pend == RECEIVE_OBJECT_BITS)
+	if (pend == priv->obj.recv_mask)
 		return pend;
 
 	/*
@@ -880,7 +900,7 @@ static int c_can_do_rx_poll(struct net_device *dev)
 			 * If the pending field has a gap, handle the
 			 * bits above the gap first.
 			 */
-			toread = c_can_adjust_pending(pend);
+			toread = c_can_adjust_pending(priv, pend);
 		} else {
 			toread = pend;
 		}
@@ -1200,7 +1220,7 @@ struct net_device *alloc_c_can_dev(void)
 	struct net_device *dev;
 	struct c_can_priv *priv;
 
-	dev = alloc_candev(sizeof(struct c_can_priv), C_CAN_MSG_OBJ_TX_NUM);
+	dev = alloc_candev(sizeof(struct c_can_priv), C_CAN_MAX_TX_OBJ);
 	if (!dev)
 		return NULL;
 
@@ -1319,13 +1339,16 @@ int register_c_can_dev(struct net_device *dev)
 	 */
 	pinctrl_pm_select_sleep_state(dev->dev.parent);
 
+	/* copy object definitions for this type */
+	priv->obj = c_can_obj_defs[priv->type];
+
 	c_can_pm_runtime_enable(priv);
 
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &c_can_netdev_ops;
 
 	err = can_rx_offload_add_manual(dev, &priv->offload,
-					C_CAN_OFFLOAD_WEIGHT);
+			priv->obj.recv_count*2 + priv->obj.send.count + 16);
 	if (err)
 		goto register_exit_runtime_disable;
 
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 24128e7..d317b4d 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -24,30 +24,7 @@
 
 #include <linux/can/rx-offload.h>
 
-/* message object split */
-
-#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
-#define C_CAN_NO_OF_OBJECTS	64
-#else
-#define C_CAN_NO_OF_OBJECTS	32
-#endif
-
-#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS >> 1)
-#define C_CAN_MSG_OBJ_RX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_TX_NUM)
-
-#define C_CAN_MSG_OBJ_RX_FIRST	1
-#define C_CAN_MSG_OBJ_RX_LAST	(C_CAN_MSG_OBJ_RX_FIRST + \
-				C_CAN_MSG_OBJ_RX_NUM - 1)
-
-#define C_CAN_MSG_OBJ_TX_FIRST	(C_CAN_MSG_OBJ_RX_LAST + 1)
-#define C_CAN_MSG_OBJ_TX_LAST	(C_CAN_MSG_OBJ_TX_FIRST + \
-				C_CAN_MSG_OBJ_TX_NUM - 1)
-
-#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
-#define RECEIVE_OBJECT_BITS	0xffffffff
-#else
-#define RECEIVE_OBJECT_BITS	0x0000ffff
-#endif
+#define C_CAN_MAX_TX_OBJ	32
 
 enum reg {
 	C_CAN_CTRL_REG = 0,
@@ -225,6 +202,17 @@ struct c_can_priv {
 	void (*raminit) (const struct c_can_priv *priv, bool enable);
 	u32 comm_rcv_high;
 	u32 rxmasked;
+	/* message object configuration */
+	struct c_can_obj_def {
+		int count;
+		int recv_count;
+		u32 recv_mask;
+		int recv_frst;
+		int recv_last;
+		int send_count;
+		int send_frst;
+		int send_last;
+	} obj;
 };
 
 struct net_device *alloc_c_can_dev(void);
-- 
1.8.5.rc3

