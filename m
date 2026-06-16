Return-Path: <linux-can+bounces-7861-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I23FAF9EMWrgfgUAu9opvQ
	(envelope-from <linux-can+bounces-7861-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 14:41:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF46A68F709
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 14:41:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j7k+NpMb;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7861-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7861-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9BD9302C844
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B42366806;
	Tue, 16 Jun 2026 12:39:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8AD36655D
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 12:39:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613562; cv=none; b=lUsR40/PPRg9Y14oEExr2brP7LC8R6H/l1i1dt/vZu5irQLZHs9fEmrhQqPyTpu3XEvtAsvu8kaG5NnP0D5bbw1vLK1W27P+i7b5Dqh7Iupe3xzM/18uuhSdVqpiXYGhvP1km0juV8q+GbNcOko4JNUKGmUMAsvUXCmSXb+XGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613562; c=relaxed/simple;
	bh=BL12yBXBr3TLioZUY4WZcarXDT2SWGCLP/PU35haRmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCO7T070izufD8+3B1s5tympybuvaovxJv9VyyB9Pcz0FxQsgEZ/fpBErTn5Rskzu1+20+ag9zCJefXCHmJ8nKc8+H0neHpvuMO5zB6pnyvvv7YvEYKAdVS+bhlMvom3++RXrQgVlOkRQp5731z8rGFPqk/M7Df3x1KX9e3oD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7k+NpMb; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49222fb062bso34972315e9.1
        for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781613559; x=1782218359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fw2ieZrkwQqUXQY8qPjjxbk4M7EAM2dJsK9vZRK+Hb0=;
        b=j7k+NpMbEOO0fQTCvbXdbs4NmVeWgr8oZ+MtriFXCzmaaJwhchiNTvG62HJTNIa/PK
         YMw8tVtPZ2YuOzkESUZ3gnQm76jFZakbMB8hJKmUy+NwKkWYYZUvvrrmov9Oxp3u7Xve
         5JuonpnESzmg1uWv5QlBzRThF1Zrg2ZyCY2u29McjGCXhxT1hFx8wa9RoVr5TUH8H7wp
         nmSR+xQ4ieYsethP/KmCAD/xxsFZtjxrH7jxP0r80stweIoANPFpFT9/mVL4GzJTrt1m
         jAjWBKQGTsUDp5lWAbP0wkcOuaWHwZy8BjhWkXY7qvdfPgHQiUubQG45VXL6DjN4H+bm
         BfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613559; x=1782218359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw2ieZrkwQqUXQY8qPjjxbk4M7EAM2dJsK9vZRK+Hb0=;
        b=g1WnJdCJGYLRuLfXRjwtowGp9l90aOD5mAz43n0aPBXogxRAHNv9y7pXiSj7vq4igy
         UbXp7vlsF8VWaOszio7nIE+LH56MgkA3EN9W7Wry4ftQc16/08K3Vay1+ADJRfzl4qbl
         MecbNivOfRBwYHjvyg3xVS4MrW+vFRIy4D1s3Bg/UMOXiuwLvCNp3p3317YIzB3ef7Hh
         Yp0vaI/0YQfb7zKTy7t1iUXo7NSm3TsRGmK770sG1IngDcdNWHcjTrIijUG2msGthZ62
         neoaA2/244VZQkanzlXLvWPSAm4kyCQ5iQUHiWsXsopWYo3sXxagagzIgc3SUE7UZPtV
         r9PQ==
X-Gm-Message-State: AOJu0Yx542s2aaQd8P0U8J7TCLiAjovUvw2FOTjaR/jl2NfgJC7Lc/qB
	bAi9yX6qvCT/cLxI3NpH5AAIR/F7TKeyB5DBpi/6qp7SFCx6gQfELpkZgB/5FFnC
X-Gm-Gg: Acq92OF7zv/GbDUBml1ExtoHFYBlU2Ibc+QMN3zlaBEDnvepDYP899Kl2gIx9/K8Y38
	dVKBcwaO/rRt/Iqo23aEzy3Q8KlkNv+FI2tIHQ+aUSw1zzdZ3ckRyfke7mrHtt8O++EyuFgoQIG
	CwSXzg9I0x7+LJPjc/ynAV3uganoGjbC6l6COv0+YW17VkD5Zij4N7u9ayNxEAycoIgWvwTnGfL
	2Rvar7lMQboccmZcqoorzFnuRsmH/h1OsF7J6YbUWZJS56omGJ5PXk0iO8P3cYA7QEfICG3EHSZ
	91OU1HD+u7Vs95oPTJmYURSq3wbyGNpBQKy5OEmRmZ+u+MS0XQN+fUV6K6rocHtRunLmwagl+aG
	SugXMTvKQy+6KPOro2fN2z9q4iIqkYtVn6CLvh3hd3uibnwpxxe1ThqSHFE5pGBUE0Pli4irI5d
	16a6IxuNtabxB1Zzc9M+EUF9qtS4KtyLzxOh4xhcEJbfG2P3yF3uDuycNFNu2aGNt8sqkDrn84x
	HKo1d1uPEKVkD9mWvRi
X-Received: by 2002:a05:600c:8b64:b0:490:e243:4806 with SMTP id 5b1f17b1804b1-4922ff7b8b5mr56395995e9.9.1781613558588;
        Tue, 16 Jun 2026 05:39:18 -0700 (PDT)
Received: from valmpani.fritz.box (cgn-195-14-216-63.nc.de. [195.14.216.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4f8d7sm61567325e9.5.2026.06.16.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:39:18 -0700 (PDT)
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: isotp: hold a reference to the bound netdevice
Date: Tue, 16 Jun 2026 14:39:04 +0200
Message-ID: <20260616123915.674534-1-vasilisalmpanis@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7861-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[vasilisalmpanis@gmail.com,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasilisalmpanis@gmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF46A68F709

isotp_release() looked up the bound netdevice with
dev_get_by_index(so->ifindex) and only unregistered the socket's CAN
receivers if that lookup succeeded. This is unreliable while the device
is going away: unregister_netdevice_many() removes the device from the
ifindex hash before the NETDEV_UNREGISTER notifier is fired, with a
synchronize_net() in between.

A close() that runs in that window first removes the socket from
isotp_notifier_list, so the pending notifier no longer sees it, and then
gets NULL back from dev_get_by_index() and skips the unregister. The two
struct receiver entries that were allocated by can_rx_register() in
isotp_bind() (the rx filter and the tx echo filter) are then never freed
and leak once the device is destroyed.

Fix it the same way can-raw already does: keep a tracked reference to the
bound device in so->dev and unregister through it, and take rtnl_lock()
in isotp_bind() and isotp_release() to serialise against the
NETDEV_UNREGISTER notifier. The dev_get_by_index() lookup in the release
path is dropped.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Reported-by: syzbot+24201717ed2da31b8fae@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=58676a0f698531996a42612c552e894a55b9732b
Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
---
 net/can/isotp.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index c48b4a818297..308d18040b6d 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -69,6 +69,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/isotp.h>
 #include <linux/slab.h>
+#include <linux/rtnetlink.h>
 #include <net/can.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
@@ -152,6 +153,8 @@ struct isotp_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
 	canid_t txid;
 	canid_t rxid;
 	ktime_t tx_gap;
@@ -1219,27 +1222,22 @@ static int isotp_release(struct socket *sock)
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
+	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
-	if (so->bound) {
-		if (so->ifindex) {
-			struct net_device *dev;
-
-			dev = dev_get_by_index(net, so->ifindex);
-			if (dev) {
-				if (isotp_register_rxid(so))
-					can_rx_unregister(net, dev, so->rxid,
-							  SINGLE_MASK(so->rxid),
-							  isotp_rcv, sk);
-
-				can_rx_unregister(net, dev, so->txid,
-						  SINGLE_MASK(so->txid),
-						  isotp_rcv_echo, sk);
-				dev_put(dev);
-				synchronize_rcu();
-			}
-		}
+	if (so->bound && so->dev) {
+		if (isotp_register_rxid(so))
+			can_rx_unregister(net, so->dev, so->rxid,
+					  SINGLE_MASK(so->rxid),
+					  isotp_rcv, sk);
+
+		can_rx_unregister(net, so->dev, so->txid,
+				  SINGLE_MASK(so->txid),
+				  isotp_rcv_echo, sk);
+		netdev_put(so->dev, &so->dev_tracker);
+		so->dev = NULL;
+		synchronize_rcu();
 	}
 
 	hrtimer_cancel(&so->txfrtimer);
@@ -1253,6 +1251,7 @@ static int isotp_release(struct socket *sock)
 	sock->sk = NULL;
 
 	release_sock(sk);
+	rtnl_unlock();
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
@@ -1303,6 +1302,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
+	rtnl_lock();
 	lock_sock(sk);
 
 	if (so->bound) {
@@ -1347,16 +1347,20 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
 			isotp_rcv_echo, sk, "isotpe", sk);
 
-	dev_put(dev);
-
 	/* switch to new settings */
 	so->ifindex = ifindex;
 	so->rxid = rx_id;
 	so->txid = tx_id;
 	so->bound = 1;
 
+	so->dev = dev;
+	netdev_hold(dev, &so->dev_tracker, GFP_KERNEL);
+
+	dev_put(dev);
+
 out:
 	release_sock(sk);
+	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
@@ -1559,7 +1563,7 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (so->ifindex != dev->ifindex)
+	if (so->dev != dev)
 		return;
 
 	switch (msg) {
@@ -1575,10 +1579,12 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 			can_rx_unregister(dev_net(dev), dev, so->txid,
 					  SINGLE_MASK(so->txid),
 					  isotp_rcv_echo, sk);
+			netdev_put(dev, &so->dev_tracker);
 		}
 
 		so->ifindex = 0;
 		so->bound  = 0;
+		so->dev = NULL;
 		release_sock(sk);
 
 		sk->sk_err = ENODEV;
-- 
2.47.3


