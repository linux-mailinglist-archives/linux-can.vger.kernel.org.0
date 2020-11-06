Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECC2A9A80
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgKFRLX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:23 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:44769 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgKFRLW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id C98F7FF97E
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2oo2p2OE0jRN for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:04:17 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 08/17] can: ems_usb: Modified ems_usb_read_bulk_callback to be able to handle also CPC-USB/FD
Date:   Fri,  6 Nov 2020 18:01:57 +0100
Message-Id: <20201106170206.32162-9-uttenthaler@ems-wuensche.com>
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
 drivers/net/can/usb/ems_usb.c | 83 ++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index c664af4499a1..6a9ea6a4e687 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -460,6 +460,7 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 	struct ems_usb *dev = urb->context;
 	struct net_device *netdev;
 	int retval;
+	u32 length, start;
 
 	netdev = dev->netdev;
 
@@ -478,50 +479,50 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 		goto resubmit_urb;
 	}
 
-	if (urb->actual_length > CPC_HEADER_SIZE) {
+	length = urb->actual_length;
+	start = CPC_HEADER_SIZE;
+
+	while (length >= CPC_MSG_HEADER_LEN) {
 		struct ems_cpc_msg *msg;
 		u8 *ibuf = urb->transfer_buffer;
-		u8 msg_count, start;
-
-		msg_count = ibuf[0] & ~0x80;
-
-		start = CPC_HEADER_SIZE;
-
-		while (msg_count) {
-			msg = (struct ems_cpc_msg *)&ibuf[start];
-
-			switch (msg->type) {
-			case CPC_MSG_TYPE_CAN_STATE:
-				/* Process CAN state changes */
-				ems_usb_rx_err(dev, msg);
-				break;
-
-			case CPC_MSG_TYPE_CAN_FRAME:
-			case CPC_MSG_TYPE_EXT_CAN_FRAME:
-			case CPC_MSG_TYPE_RTR_FRAME:
-			case CPC_MSG_TYPE_EXT_RTR_FRAME:
-				ems_usb_rx_can_msg(dev, msg);
-				break;
-
-			case CPC_MSG_TYPE_CAN_FRAME_ERROR:
-				/* Process errorframe */
-				ems_usb_rx_err(dev, msg);
-				break;
-
-			case CPC_MSG_TYPE_OVERRUN:
-				/* Message lost while receiving */
-				ems_usb_rx_err(dev, msg);
-				break;
-			}
-
-			start += CPC_MSG_HEADER_LEN + msg->length;
-			msg_count--;
-
-			if (start > urb->transfer_buffer_length) {
-				netdev_err(netdev, "format error\n");
-				break;
-			}
+		u32 read_count;
+
+		msg = (struct ems_cpc_msg *)&ibuf[start];
+
+		switch (msg->type) {
+		case CPC_MSG_TYPE_CAN_STATE:
+			/* Process CAN state changes */
+			ems_usb_rx_err(dev, msg);
+			break;
+
+		case CPC_MSG_TYPE_CAN_FRAME:
+		case CPC_MSG_TYPE_EXT_CAN_FRAME:
+		case CPC_MSG_TYPE_RTR_FRAME:
+		case CPC_MSG_TYPE_EXT_RTR_FRAME:
+			ems_usb_rx_can_msg(dev, msg);
+			break;
+
+		case CPC_MSG_TYPE_CAN_FRAME_ERROR:
+			/* Process errorframe */
+			ems_usb_rx_err(dev, msg);
+			break;
+
+		case CPC_MSG_TYPE_OVERRUN:
+			/* Message lost while receiving */
+			ems_usb_rx_err(dev, msg);
+			break;
 		}
+
+		read_count = CPC_MSG_HEADER_LEN + msg->length;
+		start += read_count;
+
+		if (start > urb->transfer_buffer_length) {
+			netdev_err(netdev, "format error\n");
+			break;
+		}
+
+		if (read_count <= length)
+			length -= read_count;
 	}
 
 resubmit_urb:
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
