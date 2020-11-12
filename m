Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834A82B0C3C
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgKLSFD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:05:03 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:59603 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgKLSFD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:05:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 9441FFFA8F
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IbbgHf2Cra5e for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:05:00 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 12/16] can: ems_usb: Fixed ems_usb_start_xmit for CAN FD
Date:   Thu, 12 Nov 2020 19:03:42 +0100
Message-Id: <20201112180346.29070-13-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Added code to let ems_usb_start_xmit handle CAN FD messages

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 143 ++++++++++++++++++++++++++--------
 1 file changed, 109 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 6d8f733c6c7f..76d25ab5804b 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -50,6 +50,7 @@ MODULE_LICENSE("GPL v2");
 #define CPC_CMD_TYPE_CAN_STATE     14  /* CAN state message */
 #define CPC_CMD_TYPE_EXT_CAN_FRAME 15  /* Extended CAN data frame */
 #define CPC_CMD_TYPE_EXT_RTR_FRAME 16  /* Extended CAN remote frame */
+#define CPC_CMD_TYPE_CANFD_FRAME   26  /* CAN FD frame */
 #define CPC_CMD_TYPE_CAN_EXIT      200 /* exit the CAN */
 
 #define CPC_CMD_TYPE_INQ_ERR_COUNTER 25 /* request the CAN error counters */
@@ -74,6 +75,7 @@ MODULE_LICENSE("GPL v2");
 /* Size of the "struct ems_cpc_msg" without the union */
 #define CPC_MSG_HEADER_LEN   11
 #define CPC_CAN_MSG_MIN_SIZE 5
+#define CPC_CANFD_MSG_MIN_SIZE 6
 
 /* Define these values to match your devices */
 #define USB_CPCUSB_VENDOR_ID 0x12D6
@@ -902,50 +904,123 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	struct ems_usb *dev = netdev_priv(netdev);
 	struct ems_tx_urb_context *context = NULL;
 	struct net_device_stats *stats = &netdev->stats;
-	struct can_frame *cf = (struct can_frame *)skb->data;
 	struct ems_cpc_msg *msg;
 	struct urb *urb;
-	u8 *buf;
+
 	int i, err;
-	size_t size = CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN
-			+ sizeof(struct cpc_can_msg);
+	u8 dlc;
+
+	u8 *buf;
+	size_t buf_size;
+	size_t buf_len = CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN;
 
 	if (can_dropped_invalid_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
-	/* create a URB, and a buffer for it, and copy the data to the URB */
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
-	if (!urb)
-		goto nomem;
-
-	buf = usb_alloc_coherent(dev->udev,
-				 size,
-				 GFP_ATOMIC,
-				 &urb->transfer_dma);
-	if (!buf) {
-		netdev_err(netdev, "No memory left for USB buffer\n");
-		usb_free_urb(urb);
-		goto nomem;
-	}
+	if (can_is_canfd_skb(skb)) {
+		struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+		struct cpc_canfd_msg *fd_msg;
+
+		buf_size = CPC_HEADER_SIZE +
+			   CPC_MSG_HEADER_LEN +
+			   sizeof(struct cpc_canfd_msg);
+
+		/* Create an URB and a buffer big enough for
+		 * all message lengths, copy the data to the URB
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
+		/* Clear first 4 bytes */
+		*(u32 *)buf = 0;
+
+		msg = (struct ems_cpc_msg *)&buf[CPC_HEADER_SIZE];
+		fd_msg = &msg->msg.canfd_msg;
+
+		msg->type = CPC_CMD_TYPE_CANFD_FRAME;
+
+		fd_msg->id = cpu_to_le32(cfd->can_id & CAN_ERR_MASK);
+		dlc = cfd->len;
+		fd_msg->length = dlc;
+		fd_msg->flags = 0;
 
-	msg = (struct ems_cpc_msg *)&buf[CPC_HEADER_SIZE];
+		if (cfd->can_id & CAN_EFF_FLAG)
+			fd_msg->flags |= CPC_FDFLAG_XTD;
 
-	msg->msg.can_msg.id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
-	msg->msg.can_msg.length = cf->can_dlc;
+		if (cfd->flags & CANFD_BRS)
+			fd_msg->flags |= CPC_FDFLAG_BRS;
 
-	if (cf->can_id & CAN_RTR_FLAG) {
-		msg->type = cf->can_id & CAN_EFF_FLAG ?
-			CPC_CMD_TYPE_EXT_RTR_FRAME : CPC_CMD_TYPE_RTR_FRAME;
+		if (cfd->flags & CANFD_ESI)
+			fd_msg->flags |= CPC_FDFLAG_ESI;
 
-		msg->length = CPC_CAN_MSG_MIN_SIZE;
+		memcpy(fd_msg->msg, cfd->data, dlc);
+
+		msg->length = CPC_CANFD_MSG_MIN_SIZE + dlc;
+		/* Send only significant bytes of buffer */
+		buf_len += msg->length;
 	} else {
-		msg->type = cf->can_id & CAN_EFF_FLAG ?
-			CPC_CMD_TYPE_EXT_CAN_FRAME : CPC_CMD_TYPE_CAN_FRAME;
+		struct can_frame *cf = (struct can_frame *)skb->data;
+		struct cpc_can_msg *can_msg;
 
-		for (i = 0; i < cf->can_dlc; i++)
-			msg->msg.can_msg.msg[i] = cf->data[i];
+		buf_size = CPC_HEADER_SIZE +
+			   CPC_MSG_HEADER_LEN +
+			   sizeof(struct cpc_can_msg);
+
+		/* Create an URB and a buffer big enough for
+		 * all message lengths, copy the data to the URB
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
+		/* Clear first 4 bytes */
+		*(u32 *)buf = 0;
+
+		msg = (struct ems_cpc_msg *)&buf[CPC_HEADER_SIZE];
+		can_msg = &msg->msg.can_msg;
+
+		can_msg->id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
+		dlc = cf->can_dlc;
+		can_msg->length = dlc;
+
+		if (cf->can_id & CAN_RTR_FLAG) {
+			msg->type = cf->can_id & CAN_EFF_FLAG ?
+				CPC_CMD_TYPE_EXT_RTR_FRAME :
+				CPC_CMD_TYPE_RTR_FRAME;
+
+			msg->length = CPC_CAN_MSG_MIN_SIZE;
+		} else {
+			msg->type = cf->can_id & CAN_EFF_FLAG ?
+				CPC_CMD_TYPE_EXT_CAN_FRAME :
+				CPC_CMD_TYPE_CAN_FRAME;
+
+			for (i = 0; i < dlc; i++)
+				can_msg->msg[i] = cf->data[i];
+
+			msg->length = CPC_CAN_MSG_MIN_SIZE + dlc;
+		}
 
-		msg->length = CPC_CAN_MSG_MIN_SIZE + cf->can_dlc;
+		/* Send only significant bytes of buffer */
+		buf_len += msg->length;
 	}
 
 	for (i = 0; i < MAX_TX_URBS; i++) {
@@ -959,7 +1034,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	 * allowed (MAX_TX_URBS).
 	 */
 	if (!context) {
-		usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);
+		usb_free_coherent(dev->udev, buf_size, buf, urb->transfer_dma);
 		usb_free_urb(urb);
 
 		netdev_warn(netdev, "couldn't find free context\n");
@@ -969,10 +1044,10 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 
 	context->dev = dev;
 	context->echo_index = i;
-	context->dlc = cf->can_dlc;
+	context->dlc = dlc;
 
 	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
-			  size, ems_usb_write_bulk_callback, context);
+			  buf_len, ems_usb_write_bulk_callback, context);
 	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 	usb_anchor_urb(urb, &dev->tx_submitted);
 
@@ -985,7 +1060,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 		can_free_echo_skb(netdev, context->echo_index);
 
 		usb_unanchor_urb(urb);
-		usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);
+		usb_free_coherent(dev->udev, buf_size, buf, urb->transfer_dma);
 		dev_kfree_skb(skb);
 
 		atomic_dec(&dev->active_tx_urbs);
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
