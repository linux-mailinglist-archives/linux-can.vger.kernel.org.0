Return-Path: <linux-can+bounces-6157-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D26D23589
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 10:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F41D3019366
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5310346E7F;
	Thu, 15 Jan 2026 09:06:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C458B3446C5
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467981; cv=none; b=NQmsKAW3YR5MBIPdQdZer3OBjYcbuw6HWKeQIn/NdxWiySQuBY/eVKdG9/rZW+qVtFuYvkjyzHEAxfyTESzYZsaQaFiamChJWUYQbOtFd0LK8KDYGwKZaff0ZWqzHYCxh3xlUZHM7Qm93BfOgvH4DsSFxdf7Mi/wuCH7rjxoOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467981; c=relaxed/simple;
	bh=XpfMMqiUjmyjUct3zQs5JsxI8qo/lV2QZCgAdAvRuVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hK5PmbL1BsMXzjBQ1Hp9KC4xwzS2mV+lZnrLY2wX631xETl8rk0z9a2HAofsDijhjKptjG69CXqJo4cAp3k9bwsAp0xNnjpsLZ1lDV9pECHxpsKTSDEu08NbzZODQBZeWYFGHV9MAd0BrK+QyZ4jPquUtElNKTbpPaUD4scQbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJIv-0004cY-6v; Thu, 15 Jan 2026 10:06:09 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJIv-000jGU-22;
	Thu, 15 Jan 2026 10:06:08 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9A26F4CD6B2;
	Thu, 15 Jan 2026 09:06:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH net 3/4] can: raw: instantly reject disabled CAN frames
Date: Thu, 15 Jan 2026 09:57:10 +0100
Message-ID: <20260115090603.1124860-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115090603.1124860-1-mkl@pengutronix.de>
References: <20260115090603.1124860-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

For real CAN interfaces the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL control
modes indicate whether an interface can handle those CAN FD/XL frames.

In the case a CAN XL interface is configured in CANXL-only mode with
disabled error-signalling neither CAN CC nor CAN FD frames can be sent.

The checks are now performed on CAN_RAW sockets to give an instant feedback
to the user when writing unsupported CAN frames to the interface or when
the CAN interface is in read-only mode.

Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260109144135.8495-4-socketcan@hartkopp.net
[mkl: fix dev reference leak]
Link: https://lore.kernel.org/all/0636c732-2e71-4633-8005-dfa85e1da445@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index f36a83d3447c..12293363413c 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -49,8 +49,8 @@
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
-#include <linux/can/dev.h> /* for can_is_canxl_dev_mtu() */
 #include <linux/can/skb.h>
 #include <linux/can/raw.h>
 #include <net/sock.h>
@@ -892,20 +892,21 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 	}
 }
 
-static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
+static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
+				      struct net_device *dev)
 {
-	/* Classical CAN -> no checks for flags and device capabilities */
-	if (can_is_can_skb(skb))
+	/* Classical CAN */
+	if (can_is_can_skb(skb) && can_cap_enabled(dev, CAN_CAP_CC))
 		return CAN_MTU;
 
-	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
+	/* CAN FD */
 	if (ro->fd_frames && can_is_canfd_skb(skb) &&
-	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
+	    can_cap_enabled(dev, CAN_CAP_FD))
 		return CANFD_MTU;
 
-	/* CAN XL -> needs to be enabled and a CAN XL device */
+	/* CAN XL */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    can_is_canxl_dev_mtu(mtu))
+	    can_cap_enabled(dev, CAN_CAP_XL))
 		return CANXL_MTU;
 
 	return 0;
@@ -944,6 +945,12 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!dev)
 		return -ENXIO;
 
+	/* no sending on a CAN device in read-only mode */
+	if (can_cap_enabled(dev, CAN_CAP_RO)) {
+		err = -EACCES;
+		goto put_dev;
+	}
+
 	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
@@ -961,7 +968,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
+	txmtu = raw_check_txframe(ro, skb, dev);
 	if (!txmtu)
 		goto free_skb;
 
-- 
2.51.0


