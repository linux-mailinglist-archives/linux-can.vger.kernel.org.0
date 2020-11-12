Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D12B0C44
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKLSFy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:05:54 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:49526 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgKLSEy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:04:54 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 3441AFFA8C
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hIrENVxgPSU2 for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:04:52 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 10/16] can: ems_usb: Added receive routine for CAN FD messages
Date:   Thu, 12 Nov 2020 19:03:40 +0100
Message-Id: <20201112180346.29070-11-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Added ems_usb_rx_canfd_msg routine for CAN FD frame reception

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 44 +++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 96012052a375..8ada663350fa 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -40,6 +40,7 @@ MODULE_LICENSE("GPL v2");
 #define CPC_MSG_TYPE_OVERRUN         21 /* overrun events */
 #define CPC_MSG_TYPE_CAN_FRAME_ERROR 23 /* detected bus errors */
 #define CPC_MSG_TYPE_ERR_COUNTER     25 /* RX/TX error counter */
+#define CPC_MSG_TYPE_CANFD_FRAME     26 /* CAN FD frame */
 
 /* Messages from the PC to the CPC interface  */
 #define CPC_CMD_TYPE_CAN_FRAME     1   /* CAN data frame */
@@ -388,6 +389,45 @@ static void ems_usb_rx_can_msg(struct ems_usb *dev, struct ems_cpc_msg *msg)
 	netif_rx(skb);
 }
 
+static void ems_usb_rx_canfd_msg(struct ems_usb *dev, struct ems_cpc_msg *msg)
+{
+	struct cpc_canfd_msg *fd_msg = &msg->msg.canfd_msg;
+
+	/* Although the CPC_FDFLAG_NONCANFD_MSG flag
+	 * should not be set with a received message,
+	 * it seems better to have checked it anyway.
+	 */
+	if (!(fd_msg->flags & CPC_FDFLAG_NONCANFD_MSG)) {
+		/* CAN FD frame */
+		struct canfd_frame *cfd;
+		struct sk_buff *skb;
+		struct net_device_stats *stats = &dev->netdev->stats;
+
+		skb = alloc_canfd_skb(dev->netdev, &cfd);
+		if (!skb)
+			return;
+
+		cfd->can_id = le32_to_cpu(fd_msg->id);
+		cfd->len = fd_msg->length;
+
+		memcpy(cfd->data, fd_msg->msg, cfd->len);
+
+		cfd->flags = 0;
+		if (fd_msg->flags & CPC_FDFLAG_BRS)
+			cfd->flags |= CANFD_BRS;
+
+		if (fd_msg->flags & CPC_FDFLAG_ESI)
+			cfd->flags |= CANFD_ESI;
+
+		if (fd_msg->flags & CPC_FDFLAG_XTD)
+			cfd->can_id |= CAN_EFF_FLAG;
+
+		stats->rx_packets++;
+		stats->rx_bytes += cfd->len;
+		netif_rx(skb);
+	}
+}
+
 static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 {
 	struct can_frame *cf;
@@ -520,6 +560,10 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 			ems_usb_rx_can_msg(dev, msg);
 			break;
 
+		case CPC_MSG_TYPE_CANFD_FRAME:
+			ems_usb_rx_canfd_msg(dev, msg);
+			break;
+
 		case CPC_MSG_TYPE_CAN_FRAME_ERROR:
 			/* Process errorframe */
 			ems_usb_rx_err(dev, msg);
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
