Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD263B4421
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFYNNZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 09:13:25 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:34386 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231524AbhFYNNZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 25 Jun 2021 09:13:25 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 52ABF5FFBE;
        Fri, 25 Jun 2021 15:10:29 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/5] can: peak_usb: PCAN-USB: add support of loopback and one-short mode
Date:   Fri, 25 Jun 2021 15:09:28 +0200
Message-Id: <20210625130931.27438-3-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625130931.27438-1-s.grosjean@peak-system.com>
References: <20210625130931.27438-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The CAN - USB PCAN-USB interface is able to generate one-shot frames as
well as loopback frames that it transmits starting from version 4.1 of its
firmware.

This patch allows to add these one-shot and loopback functions to the
driver when the embedded firmware allows it.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 50 +++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 9f3e16684e28..4c86cf58eac3 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -73,6 +73,10 @@
 #define PCAN_USB_STATUSLEN_RTR		(1 << 4)
 #define PCAN_USB_STATUSLEN_DLC		(0xf)
 
+/* PCAN-USB 4.1 CAN Id tx extended flags */
+#define PCAN_USB_TX_SRR			0x01	/* SJA1000 SRR command */
+#define PCAN_USB_TX_AT			0x02	/* SJA1000 AT command */
+
 /* PCAN-USB error flags */
 #define PCAN_USB_ERROR_TXFULL		0x01
 #define PCAN_USB_ERROR_RXQOVR		0x02
@@ -705,6 +709,7 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	struct skb_shared_hwtstamps *hwts;
+	u32 can_id_flags;
 
 	skb = alloc_can_skb(mc->netdev, &cf);
 	if (!skb)
@@ -714,13 +719,15 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 		if ((mc->ptr + 4) > mc->end)
 			goto decode_failed;
 
-		cf->can_id = get_unaligned_le32(mc->ptr) >> 3 | CAN_EFF_FLAG;
+		can_id_flags = get_unaligned_le32(mc->ptr);
+		cf->can_id = can_id_flags >> 3 | CAN_EFF_FLAG;
 		mc->ptr += 4;
 	} else {
 		if ((mc->ptr + 2) > mc->end)
 			goto decode_failed;
 
-		cf->can_id = get_unaligned_le16(mc->ptr) >> 5;
+		can_id_flags = get_unaligned_le16(mc->ptr);
+		cf->can_id = can_id_flags >> 5;
 		mc->ptr += 2;
 	}
 
@@ -743,6 +750,10 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 
 		memcpy(cf->data, mc->ptr, cf->len);
 		mc->ptr += rec_len;
+
+		/* Ignore next byte (client private id) if SRR bit is set */
+		if (can_id_flags & PCAN_USB_TX_SRR)
+			mc->ptr++;
 	}
 
 	/* convert timestamp into kernel time */
@@ -820,6 +831,7 @@ static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb,
 	struct net_device *netdev = dev->netdev;
 	struct net_device_stats *stats = &netdev->stats;
 	struct can_frame *cf = (struct can_frame *)skb->data;
+	u32 can_id_flags = cf->can_id & CAN_ERR_MASK;
 	u8 *pc;
 
 	obuf[0] = 2;
@@ -838,12 +850,28 @@ static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb,
 		*pc |= PCAN_USB_STATUSLEN_EXT_ID;
 		pc++;
 
-		put_unaligned_le32((cf->can_id & CAN_ERR_MASK) << 3, pc);
+		can_id_flags <<= 3;
+
+		if (dev->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+			can_id_flags |= PCAN_USB_TX_SRR;
+
+		if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+			can_id_flags |= PCAN_USB_TX_AT;
+
+		put_unaligned_le32(can_id_flags, pc);
 		pc += 4;
 	} else {
 		pc++;
 
-		put_unaligned_le16((cf->can_id & CAN_ERR_MASK) << 5, pc);
+		can_id_flags <<= 5;
+
+		if (dev->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+			can_id_flags |= PCAN_USB_TX_SRR;
+
+		if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+			can_id_flags |= PCAN_USB_TX_AT;
+
+		put_unaligned_le16(can_id_flags, pc);
 		pc += 2;
 	}
 
@@ -853,6 +881,10 @@ static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb,
 		pc += cf->len;
 	}
 
+	/* SRR bit needs a writer id (useless here) */
+	if (can_id_flags & PCAN_USB_TX_SRR)
+		*pc++ = 0x80;
+
 	obuf[(*size)-1] = (u8)(stats->tx_packets & 0xff);
 
 	return 0;
@@ -927,6 +959,16 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 		return err;
 	}
 
+	/* Since rev 4.1, PCAN-USB is able to make single-shot as well as
+	 * looped back frames.
+	 */
+	if (dev->device_rev >= 41) {
+		struct can_priv *priv = netdev_priv(dev->netdev);
+
+		priv->ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT |
+					    CAN_CTRLMODE_LOOPBACK;
+	}
+
 	dev_info(dev->netdev->dev.parent,
 		 "PEAK-System %s adapter hwrev %u serial %08X (%u channel)\n",
 		 pcan_usb.name, dev->device_rev, serial_number,
-- 
2.25.1

