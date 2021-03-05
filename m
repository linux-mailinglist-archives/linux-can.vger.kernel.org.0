Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7132EBCD
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCENCg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 08:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhCENCZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 08:02:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B1C061760
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 05:02:24 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lIA63-0006ST-IJ
        for linux-can@vger.kernel.org; Fri, 05 Mar 2021 14:02:23 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 330DD5EE86E
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 13:02:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 458F35EE846;
        Fri,  5 Mar 2021 13:02:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2aaf3cf3;
        Fri, 5 Mar 2021 13:02:13 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dario Binacchi <dariobin@libero.it>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6 12/12] can: c_can: add support to 64 message objects
Date:   Fri,  5 Mar 2021 14:02:11 +0100
Message-Id: <20210305130211.2860914-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305130211.2860914-1-mkl@pengutronix.de>
References: <20210305130211.2860914-1-mkl@pengutronix.de>
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

D_CAN controller supports 16, 32, 64 or 128 message objects, comparing
to 32 on C_CAN. AM335x/AM437x Sitara processors and DRA7 SOC all
instantiate a D_CAN controller with 64 message objects, as described
in the "DCAN features" subsection of the CAN chapter of their
technical reference manuals.

The driver policy has been kept unchanged, and as in the previous
version, the first half of the message objects is used for reception
and the second for transmission.

The I/O load is increased only in the case of 64 message objects,
keeping it unchanged in the case of 32. Two 32-bit read accesses are
in fact required, which however remained at 16-bit for configurations
with 32 message objects.

Link: https://lore.kernel.org/r/20210302215435.18286-7-dariobin@libero.it
Signed-off-by: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c          | 27 ++++++++++++++------------
 drivers/net/can/c_can/c_can.h          |  5 +++--
 drivers/net/can/c_can/c_can_pci.c      |  6 +++++-
 drivers/net/can/c_can/c_can_platform.c |  6 +++++-
 4 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 2e856c2947ea..9c1aa33fa256 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -466,7 +466,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	can_put_echo_skb(skb, dev, idx, 0);
 
 	/* Update the active bits */
-	atomic_add((1 << idx), &priv->tx_active);
+	atomic_add(BIT(idx), &priv->tx_active);
 	/* Start transmission */
 	c_can_object_put(dev, IF_TX, obj, IF_COMM_TX);
 
@@ -712,12 +712,15 @@ static void c_can_do_tx(struct net_device *dev)
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
+		pend &= ~BIT(idx);
 		obj = idx + priv->msg_obj_tx_first;
 
 		/* We use IF_RX interface instead of IF_TX because we
@@ -733,7 +736,7 @@ static void c_can_do_tx(struct net_device *dev)
 	/* Clear the bits in the tx_active mask */
 	atomic_sub(clr, &priv->tx_active);
 
-	if (clr & (1 << (priv->msg_obj_tx_num - 1)))
+	if (clr & BIT(priv->msg_obj_tx_num - 1))
 		netif_wake_queue(dev);
 
 	if (pkts) {
@@ -767,10 +770,10 @@ static u32 c_can_adjust_pending(u32 pend, u32 rx_mask)
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
@@ -826,7 +829,12 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 
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
@@ -847,11 +855,6 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 	struct c_can_priv *priv = netdev_priv(dev);
 	u32 pkts = 0, pend = 0, toread, n;
 
-	/* It is faster to read only one 16bit register. This is only possible
-	 * for a maximum number of 16 objects.
-	 */
-	WARN_ON(priv->msg_obj_rx_last > 16);
-
 	while (quota > 0) {
 		if (!pend) {
 			pend = c_can_get_pending(priv);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index ee703b7ed42d..8acedd9e63a7 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -22,8 +22,6 @@
 #ifndef C_CAN_H
 #define C_CAN_H
 
-#define C_CAN_NO_OF_OBJECTS	32
-
 enum reg {
 	C_CAN_CTRL_REG = 0,
 	C_CAN_CTRL_EX_REG,
@@ -61,6 +59,7 @@ enum reg {
 	C_CAN_NEWDAT2_REG,
 	C_CAN_INTPND1_REG,
 	C_CAN_INTPND2_REG,
+	C_CAN_INTPND3_REG,
 	C_CAN_MSGVAL1_REG,
 	C_CAN_MSGVAL2_REG,
 	C_CAN_FUNCTION_REG,
@@ -122,6 +121,7 @@ static const u16 __maybe_unused reg_map_d_can[] = {
 	[C_CAN_NEWDAT2_REG]	= 0x9E,
 	[C_CAN_INTPND1_REG]	= 0xB0,
 	[C_CAN_INTPND2_REG]	= 0xB2,
+	[C_CAN_INTPND3_REG]	= 0xB4,
 	[C_CAN_MSGVAL1_REG]	= 0xC4,
 	[C_CAN_MSGVAL2_REG]	= 0xC6,
 	[C_CAN_IF1_COMREQ_REG]	= 0x100,
@@ -161,6 +161,7 @@ struct raminit_bits {
 
 struct c_can_driver_data {
 	enum c_can_dev_id id;
+	unsigned int msg_obj_num;
 
 	/* RAMINIT register description. Optional. */
 	const struct raminit_bits *raminit_bits; /* Array of START/DONE bit positions */
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 911d97b4ba9c..cb9baa7b8247 100644
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
-	dev = alloc_c_can_dev(C_CAN_NO_OF_OBJECTS);
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
index a5b9b1a93702..87a145b67a2f 100644
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
-	dev = alloc_c_can_dev(C_CAN_NO_OF_OBJECTS);
+	dev = alloc_c_can_dev(drvdata->msg_obj_num);
 	if (!dev) {
 		ret = -ENOMEM;
 		goto exit;
-- 
2.30.1


