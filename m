Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F976117121
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 17:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLIQGD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 11:06:03 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37481 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIQGD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 11:06:03 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ieLXs-0008Vc-MX; Mon, 09 Dec 2019 17:06:00 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] can: ensure an initialized headroom in outgoing CAN sk_buffs
Date:   Mon,  9 Dec 2019 17:05:59 +0100
Message-Id: <20191209160559.2710-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

KMSAN sysbot detected a read access to an untinitialized value in the headroom
of an outgoing CAN related sk_buff. When using CAN sockets this area is filled
appropriately - but when using a packet socket this initialization is missing.

The problematic read access occurs in the CAN receive path which can only be
triggered when the sk_buff is sent through a (virtual) CAN interface. So we
check in the sending path whether we need to perform the missing
initializations.

Fixes: d3b58c47d330d ("can: replace timestamp as unique skb attribute")
Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v1
- rename to can_skb_headroom_valid()
- reverse logic
- move to dev.c

 drivers/net/can/dev.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/can/dev.h |  5 +++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 6ee06a49fb4c..14f1d9ee28a5 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -403,6 +403,36 @@ void can_change_state(struct net_device *dev, struct can_frame *cf,
 }
 EXPORT_SYMBOL_GPL(can_change_state);
 
+/* Check for outgoing skbs that have not been created by the CAN subsystem */
+bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
+{
+	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
+	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
+		return false;
+
+	/* af_packet does not apply CAN skb specific settings */
+	if (skb->ip_summed == CHECKSUM_NONE) {
+		/* init headroom */
+		can_skb_prv(skb)->ifindex = dev->ifindex;
+		can_skb_prv(skb)->skbcnt = 0;
+
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		/* preform proper loopback on capable devices */
+		if (dev->flags & IFF_ECHO)
+			skb->pkt_type = PACKET_LOOPBACK;
+		else
+			skb->pkt_type = PACKET_HOST;
+
+		skb_reset_mac_header(skb);
+		skb_reset_network_header(skb);
+		skb_reset_transport_header(skb);
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(can_skb_headroom_valid);
+
 /* Local echo of CAN messages
  *
  * CAN network devices *should* support a local echo functionality
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9b3c720a31b1..ca087894458b 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -91,6 +91,8 @@ struct can_priv {
 #define get_can_dlc(i)		(min_t(__u8, (i), CAN_MAX_DLC))
 #define get_canfd_dlc(i)	(min_t(__u8, (i), CANFD_MAX_DLC))
 
+bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb);
+
 /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
 static inline bool can_dropped_invalid_skb(struct net_device *dev,
 					  struct sk_buff *skb)
@@ -108,6 +110,9 @@ static inline bool can_dropped_invalid_skb(struct net_device *dev,
 	} else
 		goto inval_skb;
 
+	if (!can_skb_headroom_valid(dev, skb))
+		goto inval_skb;
+
 	return false;
 
 inval_skb:
-- 
2.24.0

