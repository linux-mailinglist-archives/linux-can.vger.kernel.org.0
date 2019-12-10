Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3884118521
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2019 11:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfLJKbf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Dec 2019 05:31:35 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33563 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfLJKbe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2019 05:31:34 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iecnk-0002ox-5B; Tue, 10 Dec 2019 11:31:32 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3] can: ensure an initialized headroom in outgoing CAN sk_buffs
Date:   Tue, 10 Dec 2019 11:31:30 +0100
Message-Id: <20191210103130.11201-1-mkl@pengutronix.de>
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

KMSAN sysbot detected a read access to an untinitialized value in the
headroom of an outgoing CAN related sk_buff. When using CAN sockets this
area is filled appropriately - but when using a packet socket this
initialization is missing.

The problematic read access occurs in the CAN receive path which can
only be triggered when the sk_buff is sent through a (virtual) CAN
interface. So we check in the sending path whether we need to perform
the missing initializations.

Fixes: d3b58c47d330d ("can: replace timestamp as unique skb attribute")
Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v2:
- move can_skb_headroom_valid() to header file and make it inline again
  to fix compilation if CAN_DEV is not enabled.

 include/linux/can/dev.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9b3c720a31b1..5e3d45525bd3 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -18,6 +18,7 @@
 #include <linux/can/error.h>
 #include <linux/can/led.h>
 #include <linux/can/netlink.h>
+#include <linux/can/skb.h>
 #include <linux/netdevice.h>
 
 /*
@@ -91,6 +92,36 @@ struct can_priv {
 #define get_can_dlc(i)		(min_t(__u8, (i), CAN_MAX_DLC))
 #define get_canfd_dlc(i)	(min_t(__u8, (i), CANFD_MAX_DLC))
 
+/* Check for outgoing skbs that have not been created by the CAN subsystem */
+static inline bool can_skb_headroom_valid(struct net_device *dev,
+					  struct sk_buff *skb)
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
+
 /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
 static inline bool can_dropped_invalid_skb(struct net_device *dev,
 					  struct sk_buff *skb)
@@ -108,6 +139,9 @@ static inline bool can_dropped_invalid_skb(struct net_device *dev,
 	} else
 		goto inval_skb;
 
+	if (!can_skb_headroom_valid(dev, skb))
+		goto inval_skb;
+
 	return false;
 
 inval_skb:
-- 
2.24.0

