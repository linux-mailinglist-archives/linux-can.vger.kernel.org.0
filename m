Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AEB2A9A84
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgKFRLY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:24 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:46289 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgKFRLW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id CF4ECFFAB3
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5yoVa7fYIWiB for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:05:10 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 13/17] can: ems_usb: Rearrange code in ems_usb_start_xmit to check with can_is_canfd_skb for CAN FD frames.
Date:   Fri,  6 Nov 2020 18:02:02 +0100
Message-Id: <20201106170206.32162-14-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 87 +++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index c464d644c833..c3159ffaa4fa 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -899,64 +899,71 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	struct ems_usb *dev = netdev_priv(netdev);
 	struct ems_tx_urb_context *context = NULL;
 	struct net_device_stats *stats = &netdev->stats;
-	struct can_frame *cf = (struct can_frame *)skb->data;
 	struct ems_cpc_msg *msg;
 	struct urb *urb;
 	int i, err;
+	u8 dlc;
 
 	u8 *buf;
 	size_t buf_size;
 	size_t buf_len = CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_is_canfd_skb(skb)) {
+		// Placeholder for next patch
 		return NETDEV_TX_OK;
+	} else {
+		struct can_frame *cf = (struct can_frame *)skb->data;
 
-	buf_size = CPC_HEADER_SIZE +
-		   CPC_MSG_HEADER_LEN +
-		   sizeof(struct cpc_can_msg);
+		if (can_dropped_invalid_skb(netdev, skb))
+			return NETDEV_TX_OK;
 
-	/* Create an URB, and a buffer for it
-	 * and copy the data to the URB
-	 */
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
-	if (!urb)
-		goto nomem;
-
-	buf = usb_alloc_coherent(dev->udev,
-				 buf_size,
-				 GFP_ATOMIC,
-				 &urb->transfer_dma);
-	if (!buf) {
-		netdev_err(netdev, "No memory left for USB buffer\n");
-		usb_free_urb(urb);
-		goto nomem;
-	}
-	// Clear first 4 bytes
-	*(u32 *)buf = 0;
+		buf_size = CPC_HEADER_SIZE +
+			   CPC_MSG_HEADER_LEN +
+			   sizeof(struct cpc_can_msg);
 
-	msg = (struct ems_cpc_msg *)&buf[CPC_HEADER_SIZE];
+		/* Create an URB, and a buffer for it
+		 * and copy the data to the URB
+		 */
+		urb = usb_alloc_urb(0, GFP_ATOMIC);
+		if (!urb)
+			goto nomem;
+
+		buf = usb_alloc_coherent(dev->udev,
+					 buf_size,
+					 GFP_ATOMIC,
+					 &urb->transfer_dma);
+		if (!buf) {
+			netdev_err(netdev, "No memory left for USB buffer\n");
+			usb_free_urb(urb);
+			goto nomem;
+		}
+		// Clear first 4 bytes
+		*(u32 *)buf = 0;
 
-	msg->msg.can_msg.id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
-	msg->msg.can_msg.length = cf->can_dlc;
+		msg = (struct ems_cpc_msg *)&buf[CPC_HEADER_SIZE];
 
-	if (cf->can_id & CAN_RTR_FLAG) {
-		msg->type = cf->can_id & CAN_EFF_FLAG ?
-			CPC_CMD_TYPE_EXT_RTR_FRAME : CPC_CMD_TYPE_RTR_FRAME;
+		msg->msg.can_msg.id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
+		dlc = cf->can_dlc;
+		msg->msg.can_msg.length = dlc;
 
-		msg->length = CPC_CAN_MSG_MIN_SIZE;
-	} else {
-		msg->type = cf->can_id & CAN_EFF_FLAG ?
-			CPC_CMD_TYPE_EXT_CAN_FRAME : CPC_CMD_TYPE_CAN_FRAME;
+		if (cf->can_id & CAN_RTR_FLAG) {
+			msg->type = cf->can_id & CAN_EFF_FLAG ?
+				CPC_CMD_TYPE_EXT_RTR_FRAME : CPC_CMD_TYPE_RTR_FRAME;
 
-		for (i = 0; i < cf->can_dlc; i++)
-			msg->msg.can_msg.msg[i] = cf->data[i];
+			msg->length = CPC_CAN_MSG_MIN_SIZE;
+		} else {
+			msg->type = cf->can_id & CAN_EFF_FLAG ?
+				CPC_CMD_TYPE_EXT_CAN_FRAME : CPC_CMD_TYPE_CAN_FRAME;
 
-		msg->length = CPC_CAN_MSG_MIN_SIZE + cf->can_dlc;
-	}
+			for (i = 0; i < cf->can_dlc; i++)
+				msg->msg.can_msg.msg[i] = cf->data[i];
 
-	// Send only significant bytes of buffer
-	buf_len += msg->length;
+			msg->length = CPC_CAN_MSG_MIN_SIZE + cf->can_dlc;
+		}
 
+		// Send only significant bytes of buffer
+		buf_len += msg->length;
+	}
 	for (i = 0; i < MAX_TX_URBS; i++) {
 		if (dev->tx_contexts[i].echo_index == MAX_TX_URBS) {
 			context = &dev->tx_contexts[i];
@@ -978,7 +985,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 
 	context->dev = dev;
 	context->echo_index = i;
-	context->dlc = cf->can_dlc;
+	context->dlc = dlc;
 
 	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
 			  buf_len, ems_usb_write_bulk_callback, context);
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
