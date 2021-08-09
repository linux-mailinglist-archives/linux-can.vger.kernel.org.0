Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8688A3E4154
	for <lists+linux-can@lfdr.de>; Mon,  9 Aug 2021 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhHIIGe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Aug 2021 04:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhHIIGd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Aug 2021 04:06:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE8BC0613CF
        for <linux-can@vger.kernel.org>; Mon,  9 Aug 2021 01:06:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mD0IW-00063m-Ch
        for linux-can@vger.kernel.org; Mon, 09 Aug 2021 10:06:12 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 981DD663100
        for <linux-can@vger.kernel.org>; Mon,  9 Aug 2021 08:06:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 07E616630FD;
        Mon,  9 Aug 2021 08:06:10 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2170b2cf;
        Mon, 9 Aug 2021 08:06:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dariobin@libero.it>
Subject: [PATCH] can: c_can: rename IF_RX -> IF_NAPI
Date:   Mon,  9 Aug 2021 10:06:08 +0200
Message-Id: <20210809080608.171545-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The C_CAN/D_CAN cores implement 2 interfaces to manage the message
objects. To avoid concurrency and the need for locking one interface
is used in the TX path (IF_TX). While the other one, named IF_RX is
used from NAPI context only. As this interface is not only used to
manage RX, but also TX message objects, this patch renames IF_RX to
IF_NAPI.

Cc: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hey Dario,

as promised a patch to rename IF_RX -> IF_NAPI.

In my current patch stack, I've added this patch before your FIFO
changes (and updated your patch accordingly), to avoid changing the
newly added IF_RX in your patch to IF_NAPI in the next patch.

regards,
Marc

 drivers/net/can/c_can/c_can_main.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index e65bd7a9cf1d..a3c2d9ec90f9 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -161,7 +161,7 @@
 #define IF_MCONT_TX		(IF_MCONT_TXIE | IF_MCONT_EOB)
 
 /* Use IF1 for RX and IF2 for TX */
-#define IF_RX			0
+#define IF_NAPI			0
 #define IF_TX			1
 
 /* minimum timeout for checking BUSY status */
@@ -529,13 +529,13 @@ static void c_can_configure_msg_objects(struct net_device *dev)
 
 	/* first invalidate all message objects */
 	for (i = priv->msg_obj_rx_first; i <= priv->msg_obj_num; i++)
-		c_can_inval_msg_object(dev, IF_RX, i);
+		c_can_inval_msg_object(dev, IF_NAPI, i);
 
 	/* setup receive message objects */
 	for (i = priv->msg_obj_rx_first; i < priv->msg_obj_rx_last; i++)
-		c_can_setup_receive_object(dev, IF_RX, i, 0, 0, IF_MCONT_RCV);
+		c_can_setup_receive_object(dev, IF_NAPI, i, 0, 0, IF_MCONT_RCV);
 
-	c_can_setup_receive_object(dev, IF_RX, priv->msg_obj_rx_last, 0, 0,
+	c_can_setup_receive_object(dev, IF_NAPI, priv->msg_obj_rx_last, 0, 0,
 				   IF_MCONT_RCV_EOB);
 }
 
@@ -710,11 +710,11 @@ static void c_can_do_tx(struct net_device *dev)
 		pend &= ~BIT(idx);
 		obj = idx + priv->msg_obj_tx_first;
 
-		/* We use IF_RX interface instead of IF_TX because we
+		/* We use IF_NAPI interface instead of IF_TX because we
 		 * are called from c_can_poll(), which runs inside
 		 * NAPI. We are not transmitting.
 		 */
-		c_can_inval_tx_object(dev, IF_RX, obj);
+		c_can_inval_tx_object(dev, IF_NAPI, obj);
 		can_get_echo_skb(dev, idx, NULL);
 		bytes += priv->dlc[idx];
 		pkts++;
@@ -766,14 +766,14 @@ static u32 c_can_adjust_pending(u32 pend, u32 rx_mask)
 static inline void c_can_rx_object_get(struct net_device *dev,
 				       struct c_can_priv *priv, u32 obj)
 {
-	c_can_object_get(dev, IF_RX, obj, priv->comm_rcv_high);
+	c_can_object_get(dev, IF_NAPI, obj, priv->comm_rcv_high);
 }
 
 static inline void c_can_rx_finalize(struct net_device *dev,
 				     struct c_can_priv *priv, u32 obj)
 {
 	if (priv->type != BOSCH_D_CAN)
-		c_can_object_get(dev, IF_RX, obj, IF_COMM_CLR_NEWDAT);
+		c_can_object_get(dev, IF_NAPI, obj, IF_COMM_CLR_NEWDAT);
 }
 
 static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
@@ -785,10 +785,12 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 		pend &= ~BIT(obj - 1);
 
 		c_can_rx_object_get(dev, priv, obj);
-		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
+		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_NAPI));
 
 		if (ctrl & IF_MCONT_MSGLST) {
-			int n = c_can_handle_lost_msg_obj(dev, IF_RX, obj, ctrl);
+			int n;
+
+			n = c_can_handle_lost_msg_obj(dev, IF_NAPI, obj, ctrl);
 
 			pkts += n;
 			quota -= n;
@@ -803,7 +805,7 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 			continue;
 
 		/* read the data from the message object */
-		c_can_read_msg_object(dev, IF_RX, ctrl);
+		c_can_read_msg_object(dev, IF_NAPI, ctrl);
 
 		c_can_rx_finalize(dev, priv, obj);
 
-- 
2.30.2


