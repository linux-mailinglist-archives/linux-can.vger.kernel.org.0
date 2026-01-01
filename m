Return-Path: <linux-can+bounces-5985-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FCFCED4F3
	for <lists+linux-can@lfdr.de>; Thu, 01 Jan 2026 20:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76F203004F60
	for <lists+linux-can@lfdr.de>; Thu,  1 Jan 2026 19:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DF41A0728;
	Thu,  1 Jan 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mzdBaA9d";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fBq2B/+e"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E052C1786
	for <linux-can@vger.kernel.org>; Thu,  1 Jan 2026 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767295015; cv=pass; b=gcozbofBDAb5U8HkRPgPQhAIyQL9BKhhE4zLKkKogfNYWzIHSIrNYelxDEOKrUvRf5fzNayhKnVTUO00n4sEo/CiGtrCjLCkBsiVAQVkF94VmOUSkI4Bpn7HN6CKzMBELcUH5l6Lhr5DYlYCwnjnm6gHIgm6TSn84RLjksW4tqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767295015; c=relaxed/simple;
	bh=ckE7pi4553M3RcMvlFhBo91VpWPgn9yJnCZ/kuCBjio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUkmXWfsYqA93cuAIdcmJIGarZFmqHWCb74V+nTtILPbr6kYlxva9rta5pHA/2//AU0dkagGmBbFp+eje01rlKYowk6rP5FuMJ6daf2z5KbqeOAZCCum+3NOiPvAmTIjIgc/lFrGp1I665GKiHXUjy2SdTzSheQfXIwVjw8FsjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mzdBaA9d; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fBq2B/+e; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767294828; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cfbqigAfxdV2C2s5D5RvgrX2bz9qIdNxFTlfOXQMyyZfAtqjlsx8iL/FuqTQq8mNlx
    s3olkPZRp/rcW2zQ5LyCjDA3510hwhmSXPnQGLIeeGrRxLQnaRhVY0AUwjvG2V9bUhMp
    vggPJyKeORsTzHjSbSLYTxFW7MVBqPPlwkfTTEfP4hzvR0gkHUhOHzSTV4ItcMi1wD0Y
    zMpuZ7LD0LH1N83cRo6yDh5BE3watdg67w4eZMv8XNZxyIuI60/b+0QtSQADQ057XuXD
    yvcdZIl2nc5Z9ZDrnQkTNFDYAObgfR7eTm8S4NNYJYW8R8Wrc+IFuRE8NLIhk3emLfaI
    8y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767294828;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WYiGgE/oQpKdXrpEQellrHB05EryjB/wTQnScKf2SFw=;
    b=anuujjI2v6vRPzUOob4s0/9D9ve6FTDBVM8qRwZ8pALYFMBE5Qte0S8kEK4PahmjoR
    J/bUBX81TT9W/6CAEoJKxf9ur55UrEaH3SvNicdjJn6wZrVgPeFbOpbZQUMYqtUPLT/H
    luSb+hkvISg6OuDV+RNnXA1sKAL+QlDdZUyiq6YXxZaA1oUQ6JUAzHxeWP226CsD8A2F
    U/TCa0eVE+ZDMLaLEU9/LzPgj9BL8JnH5Idj3qafmYoo54vknO0hgTabtOjZuJ7830Zs
    TnE0RsA2P0NFRYWcyEqMEg/jrDJ8lwWiVL3SZL2auJM39sH9kSiChMVCn90Icm7KN3sr
    KvWg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767294828;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WYiGgE/oQpKdXrpEQellrHB05EryjB/wTQnScKf2SFw=;
    b=mzdBaA9dJFdExJ0Fmxy6uessx0ubwGRsD31dCLoQH9ErCUyC1k9Vxh0Tx7HV2ywMqi
    4gXX21j+39bMwqynT8QqZR6Etc8SLfVoXKSD+WmpbYVpWlKFC8+YbSLDx4m1dQnpsKwx
    3FASfgRdM8IsIf2lKUH26OVV2RRL0B/9UJ6ERWVxxpN0c8XthJV1ZaiadFT25JsUGFaK
    RjS4QE0DnaQ7fQaCEro8Qe0E8oOzALvZg4XnvkoPm/jRaekySxs+QWRm78eWMXERWhW/
    tjph9QPUlIGp8zICIXliSX6Kxcz9Q99CtsyuvFAda2t8b+bhkWWGc56iwYtDVNeOshcN
    5vJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767294828;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WYiGgE/oQpKdXrpEQellrHB05EryjB/wTQnScKf2SFw=;
    b=fBq2B/+eu4k6EN4JdJ9f0nOVo2dALZPrZLydEPx+veTptl1np+9OTlrI84ZAKmAl8Z
    O/6BX8ZVTPgKN2Uf0KAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b201JDle43
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 1 Jan 2026 20:13:47 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 3/3] can: raw: instantly reject disabled CAN frames
Date: Thu,  1 Jan 2026 20:13:30 +0100
Message-ID: <20260101191330.1836-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260101191330.1836-1-socketcan@hartkopp.net>
References: <20260101191330.1836-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

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
---
 net/can/raw.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index f36a83d3447c..aa6e8b19be22 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -48,11 +48,11 @@
 #include <linux/socket.h>
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
 #include <linux/can/core.h>
-#include <linux/can/dev.h> /* for can_is_canxl_dev_mtu() */
+#include <linux/can/can-ml.h> /* for can_cap_enabled() */
 #include <linux/can/skb.h>
 #include <linux/can/raw.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -890,24 +890,25 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
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
 }
 
@@ -942,10 +943,14 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	dev = dev_get_by_index(sock_net(sk), ifindex);
 	if (!dev)
 		return -ENXIO;
 
+	/* no sending on a CAN device in read-only mode */
+	if (can_cap_enabled(dev, CAN_CAP_RO))
+		return -EACCES;
+
 	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		goto put_dev;
 
@@ -959,11 +964,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto free_skb;
 
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
+	txmtu = raw_check_txframe(ro, skb, dev);
 	if (!txmtu)
 		goto free_skb;
 
 	/* only CANXL: clear/forward/set VCID value */
 	if (txmtu == CANXL_MTU)
-- 
2.47.3


