Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE2C2A9A7B
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgKFRLV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:21 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:53061 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgKFRLU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 3717CFFA88
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.902
X-Spam-Level: 
X-Spam-Status: No, score=-1.902 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001]
        autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sTICFZToVOvr for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:05:09 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 12/17] can: ems_usb: In ems_usb_start_xmit send only bytes with valid content to interface and not the complete buffer. Set first four bytes of buffer to 0. Wrapped long lines.
Date:   Fri,  6 Nov 2020 18:02:01 +0100
Message-Id: <20201106170206.32162-13-uttenthaler@ems-wuensche.com>
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
 drivers/net/can/usb/ems_usb.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index b51a5eb65946..c464d644c833 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -902,25 +902,37 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	struct ems_cpc_msg *msg;
 	struct urb *urb;
-	u8 *buf;
 	int i, err;
-	size_t size = CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN
-			+ sizeof(struct cpc_can_msg);
+
+	u8 *buf;
+	size_t buf_size;
+	size_t buf_len = CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN;
 
 	if (can_dropped_invalid_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
-	/* create a URB, and a buffer for it, and copy the data to the URB */
+	buf_size = CPC_HEADER_SIZE +
+		   CPC_MSG_HEADER_LEN +
+		   sizeof(struct cpc_can_msg);
+
+	/* Create an URB, and a buffer for it
+	 * and copy the data to the URB
+	 */
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb)
 		goto nomem;
 
-	buf = usb_alloc_coherent(dev->udev, size, GFP_ATOMIC, &urb->transfer_dma);
+	buf = usb_alloc_coherent(dev->udev,
+				 buf_size,
+				 GFP_ATOMIC,
+				 &urb->transfer_dma);
 	if (!buf) {
 		netdev_err(netdev, "No memory left for USB buffer\n");
 		usb_free_urb(urb);
 		goto nomem;
 	}
+	// Clear first 4 bytes
+	*(u32 *)buf = 0;
 
 	msg = (struct ems_cpc_msg *)&buf[CPC_HEADER_SIZE];
 
@@ -942,6 +954,9 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 		msg->length = CPC_CAN_MSG_MIN_SIZE + cf->can_dlc;
 	}
 
+	// Send only significant bytes of buffer
+	buf_len += msg->length;
+
 	for (i = 0; i < MAX_TX_URBS; i++) {
 		if (dev->tx_contexts[i].echo_index == MAX_TX_URBS) {
 			context = &dev->tx_contexts[i];
@@ -953,7 +968,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	 * allowed (MAX_TX_URBS).
 	 */
 	if (!context) {
-		usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);
+		usb_free_coherent(dev->udev, buf_size, buf, urb->transfer_dma);
 		usb_free_urb(urb);
 
 		netdev_warn(netdev, "couldn't find free context\n");
@@ -966,7 +981,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	context->dlc = cf->can_dlc;
 
 	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
-			  size, ems_usb_write_bulk_callback, context);
+			  buf_len, ems_usb_write_bulk_callback, context);
 	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 	usb_anchor_urb(urb, &dev->tx_submitted);
 
@@ -979,7 +994,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
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
