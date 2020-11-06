Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0C32A9A7D
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgKFRLW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:22 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:58812 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgKFRLV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:21 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 17397FFA8F
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KQHI-OP_uCoS for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:04:48 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 14/17] can: ems_usb: Added code to handle CAN FD frames in ems_usb_start_xmit
Date:   Fri,  6 Nov 2020 18:02:03 +0100
Message-Id: <20201106170206.32162-15-uttenthaler@ems-wuensche.com>
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
 drivers/net/can/usb/ems_usb.c | 61 ++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index c3159ffaa4fa..c36f02eeec85 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -73,8 +73,9 @@ MODULE_LICENSE("GPL v2");
 #define CPC_OVR_HW 0x80
 
 /* Size of the "struct ems_cpc_msg" without the union */
-#define CPC_MSG_HEADER_LEN   11
-#define CPC_CAN_MSG_MIN_SIZE 5
+#define CPC_MSG_HEADER_LEN     11
+#define CPC_CAN_MSG_MIN_SIZE    5
+#define CPC_CANFD_MSG_MIN_SIZE  6
 
 /* Define these values to match your devices */
 #define USB_CPCUSB_VENDOR_ID 0x12D6
@@ -909,8 +910,60 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	size_t buf_len = CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN;
 
 	if (can_is_canfd_skb(skb)) {
-		// Placeholder for next patch
-		return NETDEV_TX_OK;
+		struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+		struct cpc_canfd_msg *fd_msg;
+
+		if (can_dropped_invalid_skb(netdev, skb))
+			return NETDEV_TX_OK;
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
+		// Clear first 4 bytes
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
+
+		if (cfd->can_id & CAN_EFF_FLAG)
+			fd_msg->flags |= CPC_FDFLAG_XTD;
+
+		if (cfd->flags & CANFD_BRS)
+			fd_msg->flags |= CPC_FDFLAG_BRS;
+
+		if (cfd->flags & CANFD_ESI)
+			fd_msg->flags |= CPC_FDFLAG_ESI;
+
+		for (i = 0; i < cfd->len; i++)
+			fd_msg->msg[i] = cfd->data[i];
+
+		msg->length = CPC_CANFD_MSG_MIN_SIZE + cfd->len;
+		// Send only significant bytes of buffer
+		buf_len += msg->length;
 	} else {
 		struct can_frame *cf = (struct can_frame *)skb->data;
 
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
