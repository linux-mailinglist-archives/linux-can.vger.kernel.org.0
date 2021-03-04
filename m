Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9511D32D6F6
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 16:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhCDPoV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Mar 2021 10:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbhCDPoF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Mar 2021 10:44:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4D2C0613D9
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 07:42:51 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHq7l-0003dg-NH
        for linux-can@vger.kernel.org; Thu, 04 Mar 2021 16:42:49 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6DC9A5EDD40
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 15:42:46 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 847B85EDD1E;
        Thu,  4 Mar 2021 15:42:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 54e719e5;
        Thu, 4 Mar 2021 15:42:42 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dario Binacchi <dariobin@libero.it>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v5 11/11] can: c_can: prepare to up the message objects number
Date:   Thu,  4 Mar 2021 16:42:40 +0100
Message-Id: <20210304154240.2747987-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304154240.2747987-1-mkl@pengutronix.de>
References: <20210304154240.2747987-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Dario Binacchi <dariobin@libero.it>

As pointed by commit c0a9f4d396c9 ("can: c_can: Reduce register
access") the "driver casts the 16 message objects in stone, which is
completely braindead as contemporary hardware has up to 128 message
objects".

The patch prepares the module to extend the number of message objects
beyond the 32 currently managed. This was achieved by transforming the
constants used to manage RX/TX messages into variables without
changing the driver policy.

Link: https://lore.kernel.org/r/20210302215435.18286-6-dariobin@libero.it
Signed-off-by: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c          | 73 ++++++++++++++++----------
 drivers/net/can/c_can/c_can.h          | 28 +++++-----
 drivers/net/can/c_can/c_can_pci.c      |  6 ++-
 drivers/net/can/c_can/c_can_platform.c |  6 ++-
 4 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 4bb8a7bcac50..9c1aa33fa256 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -170,9 +170,6 @@
 /* Wait for ~1 sec for INIT bit */
 #define INIT_WAIT_MS		1000
 
-/* napi related */
-#define C_CAN_NAPI_WEIGHT	C_CAN_MSG_OBJ_RX_NUM
-
 /* c_can lec values */
 enum c_can_lec_type {
 	LEC_NO_ERROR = 0,
@@ -318,7 +315,7 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 	 * first, i.e. clear the MSGVAL flag in the arbiter.
 	 */
 	if (rtr != (bool)test_bit(idx, &priv->tx_dir)) {
-		u32 obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+		u32 obj = idx + priv->msg_obj_tx_first;
 
 		c_can_inval_msg_object(dev, iface, obj);
 		change_bit(idx, &priv->tx_dir);
@@ -455,10 +452,10 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	 * prioritized. The lowest buffer number wins.
 	 */
 	idx = fls(atomic_read(&priv->tx_active));
-	obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+	obj = idx + priv->msg_obj_tx_first;
 
 	/* If this is the last buffer, stop the xmit queue */
-	if (idx == C_CAN_MSG_OBJ_TX_NUM - 1)
+	if (idx == priv->msg_obj_tx_num - 1)
 		netif_stop_queue(dev);
 	/* Store the message in the interface so we can call
 	 * can_put_echo_skb(). We must do this before we enable
@@ -469,7 +466,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	can_put_echo_skb(skb, dev, idx, 0);
 
 	/* Update the active bits */
-	atomic_add((1 << idx), &priv->tx_active);
+	atomic_add(BIT(idx), &priv->tx_active);
 	/* Start transmission */
 	c_can_object_put(dev, IF_TX, obj, IF_COMM_TX);
 
@@ -539,17 +536,18 @@ static int c_can_set_bittiming(struct net_device *dev)
  */
 static void c_can_configure_msg_objects(struct net_device *dev)
 {
+	struct c_can_priv *priv = netdev_priv(dev);
 	int i;
 
 	/* first invalidate all message objects */
-	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_NO_OF_OBJECTS; i++)
+	for (i = priv->msg_obj_rx_first; i <= priv->msg_obj_num; i++)
 		c_can_inval_msg_object(dev, IF_RX, i);
 
 	/* setup receive message objects */
-	for (i = C_CAN_MSG_OBJ_RX_FIRST; i < C_CAN_MSG_OBJ_RX_LAST; i++)
+	for (i = priv->msg_obj_rx_first; i < priv->msg_obj_rx_last; i++)
 		c_can_setup_receive_object(dev, IF_RX, i, 0, 0, IF_MCONT_RCV);
 
-	c_can_setup_receive_object(dev, IF_RX, C_CAN_MSG_OBJ_RX_LAST, 0, 0,
+	c_can_setup_receive_object(dev, IF_RX, priv->msg_obj_rx_last, 0, 0,
 				   IF_MCONT_RCV_EOB);
 }
 
@@ -714,13 +712,16 @@ static void c_can_do_tx(struct net_device *dev)
 	struct net_device_stats *stats = &dev->stats;
 	u32 idx, obj, pkts = 0, bytes = 0, pend, clr;
 
-	pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
+	if (priv->msg_obj_tx_last > 32)
+		pend = priv->read_reg32(priv, C_CAN_INTPND3_REG);
+	else
+		pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
 	clr = pend;
 
 	while ((idx = ffs(pend))) {
 		idx--;
-		pend &= ~(1 << idx);
-		obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+		pend &= ~BIT(idx);
+		obj = idx + priv->msg_obj_tx_first;
 
 		/* We use IF_RX interface instead of IF_TX because we
 		 * are called from c_can_poll(), which runs inside
@@ -735,7 +736,7 @@ static void c_can_do_tx(struct net_device *dev)
 	/* Clear the bits in the tx_active mask */
 	atomic_sub(clr, &priv->tx_active);
 
-	if (clr & (1 << (C_CAN_MSG_OBJ_TX_NUM - 1)))
+	if (clr & BIT(priv->msg_obj_tx_num - 1))
 		netif_wake_queue(dev);
 
 	if (pkts) {
@@ -749,11 +750,11 @@ static void c_can_do_tx(struct net_device *dev)
  * raced with the hardware or failed to readout all upper
  * objects in the last run due to quota limit.
  */
-static u32 c_can_adjust_pending(u32 pend)
+static u32 c_can_adjust_pending(u32 pend, u32 rx_mask)
 {
 	u32 weight, lasts;
 
-	if (pend == RECEIVE_OBJECT_BITS)
+	if (pend == rx_mask)
 		return pend;
 
 	/* If the last set bit is larger than the number of pending
@@ -769,10 +770,10 @@ static u32 c_can_adjust_pending(u32 pend)
 	/* Find the first set bit after the gap. We walk backwards
 	 * from the last set bit.
 	 */
-	for (lasts--; pend & (1 << (lasts - 1)); lasts--)
+	for (lasts--; pend & BIT(lasts - 1); lasts--)
 		;
 
-	return pend & ~((1 << lasts) - 1);
+	return pend & ~GENMASK(lasts - 1, 0);
 }
 
 static inline void c_can_rx_object_get(struct net_device *dev,
@@ -828,7 +829,12 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 
 static inline u32 c_can_get_pending(struct c_can_priv *priv)
 {
-	u32 pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
+	u32 pend;
+
+	if (priv->msg_obj_rx_last > 16)
+		pend = priv->read_reg32(priv, C_CAN_NEWDAT1_REG);
+	else
+		pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
 
 	return pend;
 }
@@ -849,12 +855,6 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 	struct c_can_priv *priv = netdev_priv(dev);
 	u32 pkts = 0, pend = 0, toread, n;
 
-	/* It is faster to read only one 16bit register. This is only possible
-	 * for a maximum number of 16 objects.
-	 */
-	BUILD_BUG_ON_MSG(C_CAN_MSG_OBJ_RX_LAST > 16,
-			 "Implementation does not support more message objects than 16");
-
 	while (quota > 0) {
 		if (!pend) {
 			pend = c_can_get_pending(priv);
@@ -863,7 +863,8 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 			/* If the pending field has a gap, handle the
 			 * bits above the gap first.
 			 */
-			toread = c_can_adjust_pending(pend);
+			toread = c_can_adjust_pending(pend,
+						      priv->msg_obj_rx_mask);
 		} else {
 			toread = pend;
 		}
@@ -1193,17 +1194,31 @@ static int c_can_close(struct net_device *dev)
 	return 0;
 }
 
-struct net_device *alloc_c_can_dev(void)
+struct net_device *alloc_c_can_dev(int msg_obj_num)
 {
 	struct net_device *dev;
 	struct c_can_priv *priv;
+	int msg_obj_tx_num = msg_obj_num / 2;
 
-	dev = alloc_candev(sizeof(struct c_can_priv), C_CAN_MSG_OBJ_TX_NUM);
+	dev = alloc_candev(struct_size(priv, dlc, msg_obj_tx_num),
+			   msg_obj_tx_num);
 	if (!dev)
 		return NULL;
 
 	priv = netdev_priv(dev);
-	netif_napi_add(dev, &priv->napi, c_can_poll, C_CAN_NAPI_WEIGHT);
+	priv->msg_obj_num = msg_obj_num;
+	priv->msg_obj_rx_num = msg_obj_num - msg_obj_tx_num;
+	priv->msg_obj_rx_first = 1;
+	priv->msg_obj_rx_last =
+		priv->msg_obj_rx_first + priv->msg_obj_rx_num - 1;
+	priv->msg_obj_rx_mask = GENMASK(priv->msg_obj_rx_num - 1, 0);
+
+	priv->msg_obj_tx_num = msg_obj_tx_num;
+	priv->msg_obj_tx_first = priv->msg_obj_rx_last + 1;
+	priv->msg_obj_tx_last =
+		priv->msg_obj_tx_first + priv->msg_obj_tx_num - 1;
+
+	netif_napi_add(dev, &priv->napi, c_can_poll, priv->msg_obj_rx_num);
 
 	priv->dev = dev;
 	priv->can.bittiming_const = &c_can_bittiming_const;
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 7a7d3fb4b1c3..8acedd9e63a7 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -22,19 +22,6 @@
 #ifndef C_CAN_H
 #define C_CAN_H
 
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
-
-#define RECEIVE_OBJECT_BITS	0x0000ffff
-
 enum reg {
 	C_CAN_CTRL_REG = 0,
 	C_CAN_CTRL_EX_REG,
@@ -72,6 +59,7 @@ enum reg {
 	C_CAN_NEWDAT2_REG,
 	C_CAN_INTPND1_REG,
 	C_CAN_INTPND2_REG,
+	C_CAN_INTPND3_REG,
 	C_CAN_MSGVAL1_REG,
 	C_CAN_MSGVAL2_REG,
 	C_CAN_FUNCTION_REG,
@@ -133,6 +121,7 @@ static const u16 __maybe_unused reg_map_d_can[] = {
 	[C_CAN_NEWDAT2_REG]	= 0x9E,
 	[C_CAN_INTPND1_REG]	= 0xB0,
 	[C_CAN_INTPND2_REG]	= 0xB2,
+	[C_CAN_INTPND3_REG]	= 0xB4,
 	[C_CAN_MSGVAL1_REG]	= 0xC4,
 	[C_CAN_MSGVAL2_REG]	= 0xC6,
 	[C_CAN_IF1_COMREQ_REG]	= 0x100,
@@ -172,6 +161,7 @@ struct raminit_bits {
 
 struct c_can_driver_data {
 	enum c_can_dev_id id;
+	unsigned int msg_obj_num;
 
 	/* RAMINIT register description. Optional. */
 	const struct raminit_bits *raminit_bits; /* Array of START/DONE bit positions */
@@ -193,6 +183,14 @@ struct c_can_priv {
 	struct napi_struct napi;
 	struct net_device *dev;
 	struct device *device;
+	unsigned int msg_obj_num;
+	unsigned int msg_obj_rx_num;
+	unsigned int msg_obj_tx_num;
+	unsigned int msg_obj_rx_first;
+	unsigned int msg_obj_rx_last;
+	unsigned int msg_obj_tx_first;
+	unsigned int msg_obj_tx_last;
+	u32 msg_obj_rx_mask;
 	atomic_t tx_active;
 	atomic_t sie_pending;
 	unsigned long tx_dir;
@@ -209,10 +207,10 @@ struct c_can_priv {
 	void (*raminit)(const struct c_can_priv *priv, bool enable);
 	u32 comm_rcv_high;
 	u32 rxmasked;
-	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
+	u32 dlc[];
 };
 
-struct net_device *alloc_c_can_dev(void);
+struct net_device *alloc_c_can_dev(int msg_obj_num);
 void free_c_can_dev(struct net_device *dev);
 int register_c_can_dev(struct net_device *dev);
 void unregister_c_can_dev(struct net_device *dev);
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index ad5683cdf1b8..cb9baa7b8247 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -31,6 +31,8 @@ enum c_can_pci_reg_align {
 struct c_can_pci_data {
 	/* Specify if is C_CAN or D_CAN */
 	enum c_can_dev_id type;
+	/* Number of message objects */
+	unsigned int msg_obj_num;
 	/* Set the register alignment in the memory */
 	enum c_can_pci_reg_align reg_align;
 	/* Set the frequency */
@@ -147,7 +149,7 @@ static int c_can_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* allocate the c_can device */
-	dev = alloc_c_can_dev();
+	dev = alloc_c_can_dev(c_can_pci_data->msg_obj_num);
 	if (!dev) {
 		ret = -ENOMEM;
 		goto out_iounmap;
@@ -251,6 +253,7 @@ static void c_can_pci_remove(struct pci_dev *pdev)
 
 static const struct c_can_pci_data c_can_sta2x11 = {
 	.type = BOSCH_C_CAN,
+	.msg_obj_num = 32,
 	.reg_align = C_CAN_REG_ALIGN_32,
 	.freq = 52000000, /* 52 Mhz */
 	.bar = 0,
@@ -258,6 +261,7 @@ static const struct c_can_pci_data c_can_sta2x11 = {
 
 static const struct c_can_pci_data c_can_pch = {
 	.type = BOSCH_C_CAN,
+	.msg_obj_num = 32,
 	.reg_align = C_CAN_REG_32,
 	.freq = 50000000, /* 50 MHz */
 	.init = c_can_pci_reset_pch,
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 05f425ceb53a..87a145b67a2f 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -192,10 +192,12 @@ static void c_can_hw_raminit(const struct c_can_priv *priv, bool enable)
 
 static const struct c_can_driver_data c_can_drvdata = {
 	.id = BOSCH_C_CAN,
+	.msg_obj_num = 32,
 };
 
 static const struct c_can_driver_data d_can_drvdata = {
 	.id = BOSCH_D_CAN,
+	.msg_obj_num = 32,
 };
 
 static const struct raminit_bits dra7_raminit_bits[] = {
@@ -205,6 +207,7 @@ static const struct raminit_bits dra7_raminit_bits[] = {
 
 static const struct c_can_driver_data dra7_dcan_drvdata = {
 	.id = BOSCH_D_CAN,
+	.msg_obj_num = 64,
 	.raminit_num = ARRAY_SIZE(dra7_raminit_bits),
 	.raminit_bits = dra7_raminit_bits,
 	.raminit_pulse = true,
@@ -217,6 +220,7 @@ static const struct raminit_bits am3352_raminit_bits[] = {
 
 static const struct c_can_driver_data am3352_dcan_drvdata = {
 	.id = BOSCH_D_CAN,
+	.msg_obj_num = 64,
 	.raminit_num = ARRAY_SIZE(am3352_raminit_bits),
 	.raminit_bits = am3352_raminit_bits,
 };
@@ -293,7 +297,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	}
 
 	/* allocate the c_can device */
-	dev = alloc_c_can_dev();
+	dev = alloc_c_can_dev(drvdata->msg_obj_num);
 	if (!dev) {
 		ret = -ENOMEM;
 		goto exit;
-- 
2.30.1


