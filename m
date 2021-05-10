Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DB3796F3
	for <lists+linux-can@lfdr.de>; Mon, 10 May 2021 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhEJSV4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 May 2021 14:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhEJSV4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 May 2021 14:21:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC27C061574
        for <linux-can@vger.kernel.org>; Mon, 10 May 2021 11:20:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lgAWP-0002z9-RP
        for linux-can@vger.kernel.org; Mon, 10 May 2021 20:20:49 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 13F32621A3C
        for <linux-can@vger.kernel.org>; Mon, 10 May 2021 18:20:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C40FB621A39;
        Mon, 10 May 2021 18:20:48 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7b6f4c68;
        Mon, 10 May 2021 18:20:48 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH] can: raw: fix TX CAN frames show up as RX'ed ones
Date:   Mon, 10 May 2021 20:20:39 +0200
Message-Id: <20210510182038.1528631-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fixes: e940e0895a82 ("can: skb: can_skb_set_owner(): fix ref counting if socket was closed before setting skb ownership")
Reported-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hey Torin,

this is only compile time tested. Please give it a try.

regards,
Marc

 drivers/net/can/dev/skb.c |  2 ++
 include/linux/can/skb.h   | 14 +++++++++++---
 net/can/raw.c             |  2 +-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 61660248c69e..9644c0d85bb6 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -200,6 +200,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 	can_skb_prv(skb)->skbcnt = 0;
+	can_skb_prv(skb)->flags = 0;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
@@ -231,6 +232,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 	can_skb_prv(skb)->skbcnt = 0;
+	can_skb_prv(skb)->flags = 0;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index d311bc369a39..24a3e682b4a2 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -51,6 +51,7 @@ struct can_skb_priv {
 	int ifindex;
 	int skbcnt;
 	unsigned int frame_len;
+	unsigned int flags;
 	struct can_frame cf[];
 };
 
@@ -71,9 +72,16 @@ static inline void can_skb_set_owner(struct sk_buff *skb, struct sock *sk)
 	 * after the last TX skb has been freed). So only increase
 	 * socket refcount if the refcount is > 0.
 	 */
-	if (sk && refcount_inc_not_zero(&sk->sk_refcnt)) {
-		skb->destructor = sock_efree;
-		skb->sk = sk;
+	if (sk) {
+		struct can_skb_priv *skb_priv;
+
+		skb_priv = can_skb_prv(skb);
+		skb_priv->flags = MSG_DONTROUTE;
+
+		if (refcount_inc_not_zero(&sk->sk_refcnt)) {
+			skb->destructor = sock_efree;
+			skb->sk = sk;
+		}
 	}
 }
 
diff --git a/net/can/raw.c b/net/can/raw.c
index 139d9471ddcf..9bedd0672fae 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -169,7 +169,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	/* add CAN specific message flags for raw_recvmsg() */
 	pflags = raw_flags(skb);
 	*pflags = 0;
-	if (oskb->sk)
+	if (can_skb_prv(oskb)->flags == MSG_DONTROUTE)
 		*pflags |= MSG_DONTROUTE;
 	if (oskb->sk == sk)
 		*pflags |= MSG_CONFIRM;
-- 
2.30.2


