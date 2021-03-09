Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003023330C8
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 22:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhCIVTf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 16:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhCIVTM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 16:19:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22D2C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 13:19:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJjl0-0000o0-Eu
        for linux-can@vger.kernel.org; Tue, 09 Mar 2021 22:19:10 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7309B5F20E1
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 21:19:09 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E8A595F20DD;
        Tue,  9 Mar 2021 21:19:08 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a9ed8f42;
        Tue, 9 Mar 2021 21:19:08 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next] can: dev: always create TX echo skb
Date:   Tue,  9 Mar 2021 22:19:04 +0100
Message-Id: <20210309211904.3348700-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

So far the creation of the TX echo skb was optional and can be
controlled by the local sender of a CAN frame.

It turns out that the TX echo CAN skb can be piggybacked to carry
information in the driver from the TX- to the TX-complete handler.

Several drivers already use the return value of
can_get_echo_skb() (which is the length of the data field in the CAN
frame) for their number of transferred bytes statistics. The
statistics are not working if CAN echo skbs are disabled.

Another use case is to calculate and set the CAN frame length on the
wire, which is needed for BQL support in both the TX and TX-completion
handler.

For now in can_put_echo_skb(), which is called from the TX handler,
the skb carrying the CAN frame is discarded if no TX echo is
requested, leading to the above illustrated problems.

This patch changes the can_put_echo_skb() function, so that the echo
skb is always generated. If the sender requests no echo, the echo skb
is consumed in __can_get_echo_skb() without being passed into the RX
handler of the networking stack, but the CAN data length and CAN frame
length information is properly returned.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/skb.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 6a64fe410987..22b0472a5fad 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -45,7 +45,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	BUG_ON(idx >= priv->echo_skb_max);
 
 	/* check flag whether this packet has to be looped back */
-	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK ||
+	if (!(dev->flags & IFF_ECHO) ||
 	    (skb->protocol != htons(ETH_P_CAN) &&
 	     skb->protocol != htons(ETH_P_CANFD))) {
 		kfree_skb(skb);
@@ -58,7 +58,6 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 			return -ENOMEM;
 
 		/* make settings for echo to reduce code in irq context */
-		skb->pkt_type = PACKET_BROADCAST;
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		skb->dev = dev;
 
@@ -111,6 +110,13 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
 
 		priv->echo_skb[idx] = NULL;
 
+		if (skb->pkt_type == PACKET_LOOPBACK) {
+			skb->pkt_type = PACKET_BROADCAST;
+		} else {
+			dev_consume_skb_any(skb);
+			return NULL;
+		}
+
 		return skb;
 	}
 
-- 
2.30.1


