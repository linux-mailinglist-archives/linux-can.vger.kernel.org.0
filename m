Return-Path: <linux-can+bounces-8272-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZTP1E1jBUGpX4gIAu9opvQ
	(envelope-from <linux-can+bounces-8272-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 11:54:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5EB7394A4
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 11:54:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=HIVrLe3a;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8272-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8272-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D530930395B3
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729B3F58CA;
	Fri, 10 Jul 2026 09:32:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735223F54C3
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 09:32:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675971; cv=none; b=eESfg/hDY3yLHKVF3vD7vDdcqbX89D3krR7Hz3qAvExWDBFZRTR+khaQZ+7AtMghhLs3PwNwHZL6XU3po1D6MaXp49xnuQo5+I+7aoFPYq1oItvhJXoUdG00j+EV5RBRNVbeGLlaJS8DtktVV4BLCpgY5MiC+VazB3FDnx99rdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675971; c=relaxed/simple;
	bh=IYf8Uug9yv3Ggo7jyUW3hQZUDvKQ+c6mK2ueL5jc6rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jm6Hmf/GkW6RCEsO61n7gNGd5PtOTnqCL9V9+lE7xTJ/M1cR7p31Io0E1fLT5bVY0dsHil01Z6gWUguuDfNBFxJch4HvnXWn05Mc3md52re2VR4FzOipMqJinMMlsS1CA95CtimrdwXSnS316FU8f54IRNbqbrrP/jbBeMuiXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIVrLe3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22B55C2BCF4;
	Fri, 10 Jul 2026 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783675971;
	bh=IYf8Uug9yv3Ggo7jyUW3hQZUDvKQ+c6mK2ueL5jc6rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HIVrLe3aCjN/IUSw7iKtKhwMUHNwgDrfF7JIP/y+94jmrpgMuX2P6rZZi0PVFt4li
	 H5lFZ4WBz4dFGe36iZvzflePtefkDOon9GINcIMGB8SN5MHbZ72WzFRpGJ6/+Z79At
	 7p9v6AhjQmb9b4ZBe9bR18mOe/vEpGr6CC4Gb0alsCGUrs479kasEINQfB0ARLe+MN
	 7L5RXI8D9wQFgoQnzQy3uC3MUFwwgBH+uqSQ5xvRbr+t3mAcr+Z/t4YYGT2ogFsVT8
	 ASjeX3v3/MVaPg3g4B1WVjgUn0IPZQR8VwWq6dRilRxjY4ReI4Mb2Nf63O21f8kxhA
	 fJ7fzfB939BnQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F6DC44507;
	Fri, 10 Jul 2026 09:32:51 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Fri, 10 Jul 2026 11:32:45 +0200
Subject: [PATCH 2/2] can: isotp: fix use-after-free race with concurrent
 NETDEV_UNREGISTER
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-isotp-fixes-v1-2-75a1d11d7df9@hartkopp.net>
References: <20260710-isotp-fixes-v1-0-75a1d11d7df9@hartkopp.net>
In-Reply-To: <20260710-isotp-fixes-v1-0-75a1d11d7df9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783675969; l=6661;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=oX14QXhaq5QLxkUtXOXynJx/mftbrg+b/2bmyGlYVzE=;
 b=tQmi/liEF47gVAMn6TmjyYt4TmejOka09r5NmajZwQZPtQzoMhfXH79kbEo+1Wj1OXHl/syk8
 4X9wmycPLE5BQzxfQkAvpHZxSubuxqS9Y1w4Ws1vhThF1MLTqeprOS+
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8272-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C5EB7394A4

From: Oliver Hartkopp <socketcan@hartkopp.net>

isotp_release() looked up the bound network device via dev_get_by_index()
using the stored ifindex. During device unregistration the device is
unlisted from the ifindex hash before the NETDEV_UNREGISTER notifier
chain runs, so a concurrent isotp_release() could find no device, skip
can_rx_unregister() entirely, and still proceed to free the socket.
Since isotp_release() had already removed itself from the isotp
notifier list at that point, isotp_notify() would never get a chance to
clean up either, leaving a stale CAN filter that keeps pointing at the
freed socket.

Fix this the same way raw.c already does: hold a tracked reference to
the bound net_device in the socket (so->dev/so->dev_tracker) from
bind() onward instead of re-resolving it from the ifindex, and
serialize bind()/release() with rtnl_lock() so that so->dev is always
consistent with what the NETDEV_UNREGISTER notifier sees. so->dev
stays valid regardless of ifindex-hash unlisting, and is only ever
cleared by whichever of isotp_release()/isotp_notify() gets there
first, so the filter is always removed exactly once.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-can/20260707101420.47F261F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 68 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index d30937345bcd..9db8f9f12a0d 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -150,10 +150,12 @@ struct tpcon {
 
 struct isotp_sock {
 	struct sock sk;
 	int bound;
 	int ifindex;
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
 	canid_t txid;
 	canid_t rxid;
 	ktime_t tx_gap;
 	ktime_t lastrxcf_tstamp;
 	struct hrtimer rxtimer, txtimer, txfrtimer;
@@ -1217,32 +1219,34 @@ static int isotp_release(struct socket *sock)
 		spin_lock(&isotp_notifier_lock);
 	}
 	list_del(&so->notifier);
 	spin_unlock(&isotp_notifier_lock);
 
+	rtnl_lock();
 	lock_sock(sk);
 
-	/* remove current filters & unregister */
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
-			}
-		}
+	/* remove current filters & unregister
+	 * tracked reference so->dev is taken at bind() time with rtnl_lock
+	 */
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
 	}
 
+	so->ifindex = 0;
+	so->bound = 0;
+	so->dev = NULL;
+
+	rtnl_unlock();
+
 	/* Always wait for a grace period before touching the timers below.
 	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
 	 * filters and cleared so->bound in isotp_notify() without waiting
 	 * for in-flight isotp_rcv() callers to finish, so this call must not
 	 * be skipped just because so->bound is already 0 here.
@@ -1251,13 +1255,10 @@ static int isotp_release(struct socket *sock)
 
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->rxtimer);
 
-	so->ifindex = 0;
-	so->bound = 0;
-
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
@@ -1308,10 +1309,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	}
 
 	if (!addr->can_ifindex)
 		return -ENODEV;
 
+	rtnl_lock();
 	lock_sock(sk);
 
 	if (so->bound) {
 		err = -EINVAL;
 		goto out;
@@ -1327,18 +1329,16 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	if (!dev) {
 		err = -ENODEV;
 		goto out;
 	}
 	if (dev->type != ARPHRD_CAN) {
-		dev_put(dev);
 		err = -ENODEV;
-		goto out;
+		goto out_put_dev;
 	}
 	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
-		dev_put(dev);
 		err = -EINVAL;
-		goto out;
+		goto out_put_dev;
 	}
 	if (!(dev->flags & IFF_UP))
 		notify_enetdown = 1;
 
 	ifindex = dev->ifindex;
@@ -1352,20 +1352,29 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 
 	/* register for echo skb's */
 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
 			isotp_rcv_echo, sk, "isotpe", sk);
 
-	dev_put(dev);
-
 	/* switch to new settings */
 	so->ifindex = ifindex;
 	so->rxid = rx_id;
 	so->txid = tx_id;
 	so->bound = 1;
 
+	/* bind() ok -> hold a reference for so->dev so that isotp_release()
+	 * can safely reach the device later, even if a concurrent
+	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
+	 */
+	so->dev = dev;
+	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);
+
+out_put_dev:
+	/* remove potential reference from dev_get_by_index() */
+	dev_put(dev);
 out:
 	release_sock(sk);
+	rtnl_unlock();
 
 	if (notify_enetdown) {
 		sk->sk_err = ENETDOWN;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
@@ -1564,11 +1573,11 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 	struct sock *sk = &so->sk;
 
 	if (!net_eq(dev_net(dev), sock_net(sk)))
 		return;
 
-	if (so->ifindex != dev->ifindex)
+	if (so->dev != dev)
 		return;
 
 	switch (msg) {
 	case NETDEV_UNREGISTER:
 		lock_sock(sk);
@@ -1580,14 +1589,16 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 						  isotp_rcv, sk);
 
 			can_rx_unregister(dev_net(dev), dev, so->txid,
 					  SINGLE_MASK(so->txid),
 					  isotp_rcv_echo, sk);
+			netdev_put(so->dev, &so->dev_tracker);
 		}
 
 		so->ifindex = 0;
 		so->bound  = 0;
+		so->dev = NULL;
 		release_sock(sk);
 
 		sk->sk_err = ENODEV;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
@@ -1643,10 +1654,11 @@ static int isotp_init(struct sock *sk)
 {
 	struct isotp_sock *so = isotp_sk(sk);
 
 	so->ifindex = 0;
 	so->bound = 0;
+	so->dev = NULL;
 
 	so->opt.flags = CAN_ISOTP_DEFAULT_FLAGS;
 	so->opt.ext_address = CAN_ISOTP_DEFAULT_EXT_ADDRESS;
 	so->opt.rx_ext_address = CAN_ISOTP_DEFAULT_EXT_ADDRESS;
 	so->opt.rxpad_content = CAN_ISOTP_DEFAULT_PAD_CONTENT;

-- 
2.53.0



