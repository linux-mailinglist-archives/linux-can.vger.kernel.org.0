Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902E532EBC8
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 14:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhCENCe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 08:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhCENCW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 08:02:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF8DC061756
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 05:02:20 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lIA5y-0006IF-Sc
        for linux-can@vger.kernel.org; Fri, 05 Mar 2021 14:02:18 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id EC98F5EE847
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 13:02:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5EF7C5EE82E;
        Fri,  5 Mar 2021 13:02:13 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f85fc245;
        Fri, 5 Mar 2021 13:02:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dario Binacchi <dariobin@libero.it>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6 01/12] can: c_can: convert block comments to network style comments
Date:   Fri,  5 Mar 2021 14:02:00 +0100
Message-Id: <20210305130211.2860914-2-mkl@pengutronix.de>
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

This patch converts all block comments to network subsystem style
block comments.

Link: https://lore.kernel.org/r/20210304154240.2747987-2-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c     | 52 ++++++++++---------------------
 drivers/net/can/c_can/c_can_pci.c |  3 +-
 2 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index ef474bae47a1..b55931806479 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -161,9 +161,7 @@
 
 #define IF_MCONT_TX		(IF_MCONT_TXIE | IF_MCONT_EOB)
 
-/*
- * Use IF1 for RX and IF2 for TX
- */
+/* Use IF1 for RX and IF2 for TX */
 #define IF_RX			0
 #define IF_TX			1
 
@@ -189,8 +187,7 @@ enum c_can_lec_type {
 	LEC_MASK = LEC_UNUSED,
 };
 
-/*
- * c_can error types:
+/* c_can error types:
  * Bus errors (BUS_OFF, ERROR_WARNING, ERROR_PASSIVE) are supported
  */
 enum c_can_bus_error_types {
@@ -280,8 +277,7 @@ static inline void c_can_object_put(struct net_device *dev, int iface,
 	c_can_obj_update(dev, iface, cmd | IF_COMM_WR, obj);
 }
 
-/*
- * Note: According to documentation clearing TXIE while MSGVAL is set
+/* Note: According to documentation clearing TXIE while MSGVAL is set
  * is not allowed, but works nicely on C/DCAN. And that lowers the I/O
  * load significantly.
  */
@@ -321,8 +317,7 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 	if (!rtr)
 		arb |= IF_ARB_TRANSMIT;
 
-	/*
-	 * If we change the DIR bit, we need to invalidate the buffer
+	/* If we change the DIR bit, we need to invalidate the buffer
 	 * first, i.e. clear the MSGVAL flag in the arbiter.
 	 */
 	if (rtr != (bool)test_bit(idx, &priv->tx_dir)) {
@@ -459,8 +454,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
-	/*
-	 * This is not a FIFO. C/D_CAN sends out the buffers
+	/* This is not a FIFO. C/D_CAN sends out the buffers
 	 * prioritized. The lowest buffer number wins.
 	 */
 	idx = fls(atomic_read(&priv->tx_active));
@@ -469,8 +463,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	/* If this is the last buffer, stop the xmit queue */
 	if (idx == C_CAN_MSG_OBJ_TX_NUM - 1)
 		netif_stop_queue(dev);
-	/*
-	 * Store the message in the interface so we can call
+	/* Store the message in the interface so we can call
 	 * can_put_echo_skb(). We must do this before we enable
 	 * transmit as we might race against do_tx().
 	 */
@@ -539,8 +532,7 @@ static int c_can_set_bittiming(struct net_device *dev)
 	return c_can_wait_for_ctrl_init(dev, priv, 0);
 }
 
-/*
- * Configure C_CAN message objects for Tx and Rx purposes:
+/* Configure C_CAN message objects for Tx and Rx purposes:
  * C_CAN provides a total of 32 message objects that can be configured
  * either for Tx or Rx purposes. Here the first 16 message objects are used as
  * a reception FIFO. The end of reception FIFO is signified by the EoB bit
@@ -584,8 +576,7 @@ static int c_can_software_reset(struct net_device *dev)
 	return 0;
 }
 
-/*
- * Configure C_CAN chip:
+/* Configure C_CAN chip:
  * - enable/disable auto-retransmission
  * - set operating mode
  * - configure message objects
@@ -751,8 +742,7 @@ static void c_can_do_tx(struct net_device *dev)
 	}
 }
 
-/*
- * If we have a gap in the pending bits, that means we either
+/* If we have a gap in the pending bits, that means we either
  * raced with the hardware or failed to readout all upper
  * objects in the last run due to quota limit.
  */
@@ -763,8 +753,7 @@ static u32 c_can_adjust_pending(u32 pend)
 	if (pend == RECEIVE_OBJECT_BITS)
 		return pend;
 
-	/*
-	 * If the last set bit is larger than the number of pending
+	/* If the last set bit is larger than the number of pending
 	 * bits we have a gap.
 	 */
 	weight = hweight32(pend);
@@ -774,8 +763,7 @@ static u32 c_can_adjust_pending(u32 pend)
 	if (lasts == weight)
 		return pend;
 
-	/*
-	 * Find the first set bit after the gap. We walk backwards
+	/* Find the first set bit after the gap. We walk backwards
 	 * from the last set bit.
 	 */
 	for (lasts--; pend & (1 << (lasts - 1)); lasts--);
@@ -815,8 +803,7 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 			continue;
 		}
 
-		/*
-		 * This really should not happen, but this covers some
+		/* This really should not happen, but this covers some
 		 * odd HW behaviour. Do not remove that unless you
 		 * want to brick your machine.
 		 */
@@ -842,8 +829,7 @@ static inline u32 c_can_get_pending(struct c_can_priv *priv)
 	return pend;
 }
 
-/*
- * theory of operation:
+/* theory of operation:
  *
  * c_can core saves a received CAN message into the first free message
  * object it finds free (starting with the lowest). Bits NEWDAT and
@@ -860,8 +846,7 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 	struct c_can_priv *priv = netdev_priv(dev);
 	u32 pkts = 0, pend = 0, toread, n;
 
-	/*
-	 * It is faster to read only one 16bit register. This is only possible
+	/* It is faster to read only one 16bit register. This is only possible
 	 * for a maximum number of 16 objects.
 	 */
 	BUILD_BUG_ON_MSG(C_CAN_MSG_OBJ_RX_LAST > 16,
@@ -872,8 +857,7 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 			pend = c_can_get_pending(priv);
 			if (!pend)
 				break;
-			/*
-			 * If the pending field has a gap, handle the
+			/* If the pending field has a gap, handle the
 			 * bits above the gap first.
 			 */
 			toread = c_can_adjust_pending(pend);
@@ -991,8 +975,7 @@ static int c_can_handle_bus_err(struct net_device *dev,
 	struct can_frame *cf;
 	struct sk_buff *skb;
 
-	/*
-	 * early exit if no lec update or no error.
+	/* early exit if no lec update or no error.
 	 * no lec update means that no CAN bus event has been detected
 	 * since CPU wrote 0x7 value to status reg.
 	 */
@@ -1011,8 +994,7 @@ static int c_can_handle_bus_err(struct net_device *dev,
 	if (unlikely(!skb))
 		return 0;
 
-	/*
-	 * check for 'last error code' which tells us the
+	/* check for 'last error code' which tells us the
 	 * type of the last error to occur on the CAN bus
 	 */
 	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 406b4847e5dc..4a39b39db3b9 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -41,8 +41,7 @@ struct c_can_pci_data {
 	void (*init)(const struct c_can_priv *priv, bool enable);
 };
 
-/*
- * 16-bit c_can registers can be arranged differently in the memory
+/* 16-bit c_can registers can be arranged differently in the memory
  * architecture of different implementations. For example: 16-bit
  * registers can be aligned to a 16-bit boundary or 32-bit boundary etc.
  * Handle the same by providing a common read/write interface.
-- 
2.30.1


