Return-Path: <linux-can+bounces-6085-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6901BD0AB53
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 15:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 645DB3038398
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857723612DD;
	Fri,  9 Jan 2026 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RkfJCns+";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mK9sfvWd"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883073612D9
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969758; cv=pass; b=FP31QU2E+XyYteDEGwcBprFtaJr6ScVRjOhBBFe8jObdVbHIo0MpSkZuKtKdNxVnyCAYb0TGMejR5Qe3oFxyScSjlVQhOTp6U5Z0PPwiuM80zSU5CoctKgRBo/J3b2suxfaF+tNX8M2/jLwPWQ4+/Hv6bs6Bpy2mRuXiTmFrxiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969758; c=relaxed/simple;
	bh=VDmaDNu5WKgTBwanP6f9C6Kij24rac0XFCh9r8aOxq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUfNw/8H+N0s5POkqyUPmsdY4otkxFZ2nDub4H7ffv2afBTNFKGeO9DPYL+m4F0xm872aXSEarAFt7xvb/91Vlr/WCcjRi/di8NNoN0UpaOr6spYQcLbm/pIsnqDxC4toz7UNf7o6WfQjaAP9h+81GxIkDKg1fVBZr//njC9+bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RkfJCns+; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mK9sfvWd; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767969736; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=V3iYTnwo10qX7+YhzFo5W/Yk8qee4OAk01KhH0Ug/LHCm7+7n+kfxWFJU50/Fil9CI
    9sXkb/Gp+PcAdQiyQ0s58RJOpLjsyXuPWcfqPMXaWnkegXbQKyExJWZBO9H37RsWq20H
    aauCY8nfWEkgkXFwoUbHUAO8FETjDMVQLxxq0dFNNweYJ8wEaUGckemlmaOMYeXETYOG
    UMsNz1myQkNP2kZ1nnlOV2A6U7PKHOItsMwrq0lKFTU0X/q96a4bv/GBjf20rhuF2pOj
    G0FgjiWt8Ps8My3ruhvr3Q7u9T16ISOX2ulRKsnISwHz7kA0Rp5zNJwCOKTjTkalZ4xt
    9CFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767969736;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=30F6CoOcSt51MSgSeQh71a+8tYaoatMWTVVBBObrhII=;
    b=cxC1CGXn/LZoFFV2T+F7WhPhFz9D4T3ZxHf1DednwNOz3eh0YUborQ+35RouwUut1d
    Ti2y6rLGzhymRd/bvQvQb7/gURUF8wZbJR04WvdW57pPI5PwbA6LcXQY9+N4LrC5mon0
    8y4hIoUnH9gDLwkJ/YBznFESQX6L5BGwsHUhmtJjIbzJZcodSqRVtnOofNxqLnD6JSYT
    sIecNHCvbKo7OyAkcH6zcM2G0w5wJmKsKAQpinPV0gj62C6EUtVwjy5xLKT2JQJLgkHy
    vhiV33+IFTvNWCdXxQvCyxcd2InsegQdHBPi1s6gqYxJ4qOxT16OGVrdlhf4AzSew7PC
    4NoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767969736;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=30F6CoOcSt51MSgSeQh71a+8tYaoatMWTVVBBObrhII=;
    b=RkfJCns+hEYB95nIIySAhNGzCnN6oUoU/L3oRxRu3fMKTdpdhG0OxQH3Msg2A41pZj
    kolGFwBJk6gCxkph/szWxMAxFuT8cU7RyFqrNDx2PE0SgcsJ55IkW6VOkr2hrvjpZPB4
    0AsP8dt6K3CKFVgBGYljRRkfJfoBSWss7oFaia1gmmstGNBvoaNyml2556UTU9zTbuJM
    NCgYcwAHH7DHBjrAae3aq1Xp2Cirmxqj+gQ4usBx8jQjPScYhEWNx7YZT67Uylowbxb5
    AbI4+a4zlRC0IX2QtVq/z7SD74syw10Ax/oA0aOJpHfn2ILD5y6ZSYBDZyuPh1nvozVH
    kf9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767969736;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=30F6CoOcSt51MSgSeQh71a+8tYaoatMWTVVBBObrhII=;
    b=mK9sfvWdgfJhvjcNJTpMbcSC2XkDToVI0bLcFB5RoOEQrA1uBDH5zKj5bLSXkNtcgF
    cIQ2PCfCWqtxB12GvbAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b209EgGPL9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Jan 2026 15:42:16 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 3/3] can: raw: instantly reject disabled CAN frames
Date: Fri,  9 Jan 2026 15:41:35 +0100
Message-ID: <20260109144135.8495-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109144135.8495-1-socketcan@hartkopp.net>
References: <20260109144135.8495-1-socketcan@hartkopp.net>
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
index f36a83d3447c..d66036da6753 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -47,12 +47,12 @@
 #include <linux/netdevice.h>
 #include <linux/socket.h>
 #include <linux/if_arp.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/core.h>
-#include <linux/can/dev.h> /* for can_is_canxl_dev_mtu() */
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


