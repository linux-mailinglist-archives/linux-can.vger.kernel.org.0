Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF12B5032
	for <lists+linux-can@lfdr.de>; Mon, 16 Nov 2020 19:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgKPSuE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Nov 2020 13:50:04 -0500
Received: from pd9568d8c.dip0.t-ipconnect.de ([217.86.141.140]:49651 "EHLO
        remote.esd.eu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727701AbgKPSuD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Nov 2020 13:50:03 -0500
Received: from esd-s7 ([10.0.0.77]:56812 helo=esd-s7.esd)
        by remote.esd.eu with esmtp (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <stefan.maetje@esd.eu>)
        id 1kejUM-00080c-2x; Mon, 16 Nov 2020 19:44:30 +0100
Received: from esd-s9.esd.local (unknown [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTP id D99877C1633;
        Mon, 16 Nov 2020 19:44:30 +0100 (CET)
Received: by esd-s9.esd.local (Postfix, from userid 2044)
        id CC34BE00E3; Mon, 16 Nov 2020 19:44:30 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     socketcan@hartkopp.net, linux-can@vger.kernel.org
Cc:     mkl@pengutronix.de, mailhol.vincent@wanadoo.fr,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Subject: [PATCH 1/1] can: drivers: add len8_dlc support for esd_usb2 CAN adapter
Date:   Mon, 16 Nov 2020 19:44:30 +0100
Message-Id: <20201116184430.25462-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20201116184430.25462-1-stefan.maetje@esd.eu>
References: <20201116184430.25462-1-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stefan Mätje <Stefan.Maetje@esd.eu>

Support the Classical CAN raw DLC functionality to send and receive DLC values
from 9 .. 15 for the Classical CAN capable CAN network driver esd_usb that
supports the esd CAN-USB/2 and CAN-USB/Micro devices:

- esd_usb2

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Tested-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/net/can/usb/esd_usb2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index 3643a8ee03cf..cf89387de166 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -183,7 +183,7 @@ struct esd_usb2_net_priv;
 struct esd_tx_urb_context {
 	struct esd_usb2_net_priv *priv;
 	u32 echo_index;
-	int dlc;
+	int len;	/* CAN payload length */
 };
 
 struct esd_usb2 {
@@ -321,7 +321,7 @@ static void esd_usb2_rx_can_msg(struct esd_usb2_net_priv *priv,
 		}
 
 		cf->can_id = id & ESD_IDMASK;
-		cf->len = can_cc_dlc2len(msg->msg.rx.dlc & ~ESD_RTR);
+		can_frame_set_cc_len(cf, msg->msg.rx.dlc & ~ESD_RTR, priv->can.ctrlmode);
 
 		if (id & ESD_EXTID)
 			cf->can_id |= CAN_EFF_FLAG;
@@ -355,7 +355,7 @@ static void esd_usb2_tx_done_msg(struct esd_usb2_net_priv *priv,
 
 	if (!msg->msg.txdone.status) {
 		stats->tx_packets++;
-		stats->tx_bytes += context->dlc;
+		stats->tx_bytes += context->len;
 		can_get_echo_skb(netdev, context->echo_index);
 	} else {
 		stats->tx_errors++;
@@ -737,7 +737,7 @@ static netdev_tx_t esd_usb2_start_xmit(struct sk_buff *skb,
 	msg->msg.hdr.len = 3; /* minimal length */
 	msg->msg.hdr.cmd = CMD_CAN_TX;
 	msg->msg.tx.net = priv->index;
-	msg->msg.tx.dlc = cf->len;
+	msg->msg.tx.dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
 	msg->msg.tx.id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
 
 	if (cf->can_id & CAN_RTR_FLAG)
@@ -769,7 +769,7 @@ static netdev_tx_t esd_usb2_start_xmit(struct sk_buff *skb,
 
 	context->priv = priv;
 	context->echo_index = i;
-	context->dlc = cf->len;
+	context->len = cf->len;
 
 	/* hnd must not be 0 - MSB is stripped in txdone handling */
 	msg->msg.tx.hnd = 0x80000000 | i; /* returned in TX done message */
@@ -988,7 +988,7 @@ static int esd_usb2_probe_one_net(struct usb_interface *intf, int index)
 	priv->index = index;
 
 	priv->can.state = CAN_STATE_STOPPED;
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_CC_LEN8_DLC;
 
 	if (le16_to_cpu(dev->udev->descriptor.idProduct) ==
 	    USB_CANUSBM_PRODUCT_ID)
-- 
2.25.1

