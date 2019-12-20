Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83812789C
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2019 10:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLTJ4i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Dec 2019 04:56:38 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:60011 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfLTJ4h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Dec 2019 04:56:37 -0500
X-ASG-Debug-ID: 1576835792-0a7b8d6cde763810002-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b02.edpnet.be with ESMTP id vjhlgNVBQEBnGaBk for <linux-can@vger.kernel.org>; Fri, 20 Dec 2019 10:56:33 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 21A20BD9C0C;
        Fri, 20 Dec 2019 10:56:33 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 09/11] can: c_can: runtime message object divisions
Date:   Fri, 20 Dec 2019 10:55:25 +0100
X-ASG-Orig-Subj: [PATCH 09/11] can: c_can: runtime message object divisions
Message-Id: <1576835727-2956-10-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576835793
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 10587
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3426
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78781
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This commit prepares for per-device message object assignment.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c          | 58 ++++++++++++++++++++++------------
 drivers/net/can/c_can/c_can.h          | 31 ++++++++----------
 drivers/net/can/c_can/c_can_pci.c      |  7 ++--
 drivers/net/can/c_can/c_can_platform.c |  4 +--
 4 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index cf2d47e..7dcf9bc 100644
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
@@ -213,6 +209,11 @@ enum c_can_bus_error_types {
 	.brp_inc = 1,
 };
 
+static const int c_can_obj_counts[] = {
+	[BOSCH_C_CAN] = 32,
+	[BOSCH_D_CAN] = 32, /* the IP supports 128, we support only 32 */
+};
+
 static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
 {
 	if (priv->device)
@@ -327,7 +328,7 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 	 * first, i.e. clear the MSGVAL flag in the arbiter.
 	 */
 	if (rtr != (bool)test_bit(idx, &priv->tx_dir)) {
-		u32 obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+		u32 obj = idx + priv->obj.send_frst;
 
 		c_can_inval_msg_object(dev, iface, obj);
 		change_bit(idx, &priv->tx_dir);
@@ -360,9 +361,10 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *dev,
 						       int iface)
 {
+	struct c_can_priv *priv = netdev_priv(dev);
 	int i;
 
-	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_MSG_RX_LOW_LAST; i++)
+	for (i = priv->obj.recv_frst; i <= priv->obj.recv_last; i++)
 		c_can_object_get(dev, iface, i, IF_COMM_CLR_NEWDAT);
 }
 
@@ -474,10 +476,10 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
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
@@ -559,17 +561,18 @@ static int c_can_set_bittiming(struct net_device *dev)
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
 
@@ -742,7 +745,7 @@ static void c_can_do_tx(struct net_device *dev)
 	while ((idx = ffs(pend))) {
 		idx--;
 		pend &= ~(1 << idx);
-		obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+		obj = idx + priv->obj.send_frst;
 		c_can_inval_tx_object(dev, IF_RX, obj);
 		skb = __can_get_echo_skb(dev, idx, &len);
 		can_rx_offload_irq_receive_skb(&priv->offload, skb);
@@ -753,7 +756,7 @@ static void c_can_do_tx(struct net_device *dev)
 	/* Clear the bits in the tx_active mask */
 	atomic_sub(clr, &priv->tx_active);
 
-	if (clr & (1 << (C_CAN_MSG_OBJ_TX_NUM - 1)))
+	if (clr & (1 << (priv->obj.send_count - 1)))
 		netif_wake_queue(dev);
 
 	if (pkts) {
@@ -768,11 +771,11 @@ static void c_can_do_tx(struct net_device *dev)
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
@@ -874,7 +877,7 @@ static int c_can_do_rx_poll(struct net_device *dev)
 	 * It is faster to read only one 16bit register. This is only possible
 	 * for a maximum number of 16 objects.
 	 */
-	BUILD_BUG_ON_MSG(C_CAN_MSG_OBJ_RX_LAST > 16,
+	WARN_ONCE(priv->obj.recv_last > 16,
 			"Implementation does not support more message objects than 16");
 
 	for (;;) {
@@ -886,7 +889,7 @@ static int c_can_do_rx_poll(struct net_device *dev)
 			 * If the pending field has a gap, handle the
 			 * bits above the gap first.
 			 */
-			toread = c_can_adjust_pending(pend);
+			toread = c_can_adjust_pending(priv, pend);
 		} else {
 			toread = pend;
 		}
@@ -1201,12 +1204,17 @@ static int c_can_close(struct net_device *dev)
 	return 0;
 }
 
-struct net_device *alloc_c_can_dev(void)
+struct net_device *alloc_c_can_dev(int type, int object_count)
 {
 	struct net_device *dev;
 	struct c_can_priv *priv;
+	int send_object_count;
+
+	if (!object_count || object_count > c_can_obj_counts[type])
+		object_count = c_can_obj_counts[type];
+	send_object_count = object_count/2;
 
-	dev = alloc_candev(sizeof(struct c_can_priv), C_CAN_MSG_OBJ_TX_NUM);
+	dev = alloc_candev(sizeof(struct c_can_priv), send_object_count);
 	if (!dev)
 		return NULL;
 
@@ -1220,6 +1228,16 @@ struct net_device *alloc_c_can_dev(void)
 					CAN_CTRLMODE_LISTENONLY |
 					CAN_CTRLMODE_BERR_REPORTING;
 
+	priv->type = type;
+	priv->obj.count = object_count;
+	priv->obj.send_count = send_object_count;
+	priv->obj.recv_count = object_count - send_object_count;
+	priv->obj.recv_frst = 1;
+	priv->obj.recv_last = priv->obj.recv_frst + priv->obj.recv_count - 1;
+	priv->obj.send_frst = priv->obj.recv_last + 1;
+	priv->obj.send_last = priv->obj.send_frst + priv->obj.send_count - 1;
+	priv->obj.recv_mask = (1ULL << priv->obj.recv_count) - 1;
+
 	return dev;
 }
 EXPORT_SYMBOL_GPL(alloc_c_can_dev);
@@ -1331,7 +1349,7 @@ int register_c_can_dev(struct net_device *dev)
 	dev->netdev_ops = &c_can_netdev_ops;
 
 	err = can_rx_offload_add_manual(dev, &priv->offload,
-					C_CAN_OFFLOAD_WEIGHT);
+			priv->obj.recv_count*2 + priv->obj.send_count + 16);
 	if (err)
 		goto register_exit_runtime_disable;
 
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8387b3f..70e3dc5 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -24,23 +24,6 @@
 
 #include <linux/can/rx-offload.h>
 
-/* message object split */
-#define C_CAN_NO_OF_OBJECTS	32
-#define C_CAN_MSG_OBJ_RX_NUM	16
-#define C_CAN_MSG_OBJ_TX_NUM	16
-
-#define C_CAN_MSG_OBJ_RX_FIRST	1
-#define C_CAN_MSG_OBJ_RX_LAST	(C_CAN_MSG_OBJ_RX_FIRST + \
-				C_CAN_MSG_OBJ_RX_NUM - 1)
-
-#define C_CAN_MSG_OBJ_TX_FIRST	(C_CAN_MSG_OBJ_RX_LAST + 1)
-#define C_CAN_MSG_OBJ_TX_LAST	(C_CAN_MSG_OBJ_TX_FIRST + \
-				C_CAN_MSG_OBJ_TX_NUM - 1)
-
-#define C_CAN_MSG_OBJ_RX_SPLIT	9
-#define C_CAN_MSG_RX_LOW_LAST	(C_CAN_MSG_OBJ_RX_SPLIT - 1)
-#define RECEIVE_OBJECT_BITS	0x0000ffff
-
 enum reg {
 	C_CAN_CTRL_REG = 0,
 	C_CAN_CTRL_EX_REG,
@@ -177,6 +160,7 @@ struct raminit_bits {
 
 struct c_can_driver_data {
 	enum c_can_dev_id id;
+	int object_count;
 
 	/* RAMINIT register description. Optional. */
 	const struct raminit_bits *raminit_bits; /* Array of START/DONE bit positions */
@@ -213,9 +197,20 @@ struct c_can_priv {
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
 
-struct net_device *alloc_c_can_dev(void);
+struct net_device *alloc_c_can_dev(int type, int object_count);
 void free_c_can_dev(struct net_device *dev);
 int register_c_can_dev(struct net_device *dev);
 void unregister_c_can_dev(struct net_device *dev);
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 406b484..c960309 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -31,6 +31,8 @@ enum c_can_pci_reg_align {
 struct c_can_pci_data {
 	/* Specify if is C_CAN or D_CAN */
 	enum c_can_dev_id type;
+	/* number of usable message objects */
+	int object_count;
 	/* Set the register alignment in the memory */
 	enum c_can_pci_reg_align reg_align;
 	/* Set the frequency */
@@ -149,7 +151,8 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* allocate the c_can device */
-	dev = alloc_c_can_dev();
+	dev = alloc_c_can_dev(c_can_pci_data->type,
+			c_can_pci_data->object_count);
 	if (!dev) {
 		ret = -ENOMEM;
 		goto out_iounmap;
@@ -184,8 +187,6 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 		goto out_free_c_can;
 	}
 
-	priv->type = c_can_pci_data->type;
-
 	/* Configure access to registers */
 	switch (c_can_pci_data->reg_align) {
 	case C_CAN_REG_ALIGN_32:
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 05f425c..57fea84 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -217,6 +217,7 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 
 static const struct c_can_driver_data am3352_dcan_drvdata = {
 	.id = BOSCH_D_CAN,
+	.object_count = 64,
 	.raminit_num = ARRAY_SIZE(am3352_raminit_bits),
 	.raminit_bits = am3352_raminit_bits,
 };
@@ -293,7 +294,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	}
 
 	/* allocate the c_can device */
-	dev = alloc_c_can_dev();
+	dev = alloc_c_can_dev(drvdata->id, drvdata->object_count);
 	if (!dev) {
 		ret = -ENOMEM;
 		goto exit;
@@ -381,7 +382,6 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	priv->device = &pdev->dev;
 	priv->can.clock.freq = clk_get_rate(clk);
 	priv->priv = clk;
-	priv->type = drvdata->id;
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
-- 
1.8.5.rc3

