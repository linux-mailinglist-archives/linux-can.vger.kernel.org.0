Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FE02A9A7E
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKFRLW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:22 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:58324 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgKFRLW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 8A0C0FFA5A
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ioUSa1HzLatF for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:04:34 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 10/17] can: ems_usb: Added receive routine for CAN FD messages and its call in ems_usb_read_bulk_callback
Date:   Fri,  6 Nov 2020 18:01:59 +0100
Message-Id: <20201106170206.32162-11-uttenthaler@ems-wuensche.com>
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
 drivers/net/can/usb/ems_usb.c | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index d6b52b265536..a4d9a1b2d2f0 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -389,6 +389,47 @@ static void ems_usb_rx_can_msg(struct ems_usb *dev, struct ems_cpc_msg *msg)
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
+		int i;
+		struct net_device_stats *stats = &dev->netdev->stats;
+
+		skb = alloc_canfd_skb(dev->netdev, &cfd);
+		if (!skb)
+			return;
+
+		cfd->can_id = le32_to_cpu(fd_msg->id);
+		cfd->len = fd_msg->length;
+
+		for (i = 0; i < cfd->len; i++)
+			cfd->data[i] = fd_msg->msg[i];
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
@@ -513,6 +554,10 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
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
