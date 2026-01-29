Return-Path: <linux-can+bounces-6405-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLKeDFuLe2mlFQIAu9opvQ
	(envelope-from <linux-can+bounces-6405-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 17:31:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A32B2352
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 17:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B1BD303AA89
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDAC3446B9;
	Thu, 29 Jan 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY75nCMz"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DE342C9E;
	Thu, 29 Jan 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704193; cv=none; b=UAwP2WmtlZOq9wNCb2HPqOjd+bZlOlvSM0u4Wt8MkyQpNREA0ngGqVLdeGh7PQUZ25PuLwcf6aFoJtcGGEhFSJWLT0f1pzyG/uAeyUg74DJIAMdH7wI6BxxDN/5lI8lIsxLmR5biB8V5FhdK2Qm5FOTTIRlE7pRndNyypEs0wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704193; c=relaxed/simple;
	bh=8C3pFfQZds1zC7hLKiwrfj9jKp4rBs+tzu7Qk4k0fFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4JUfISJsiZ/wjwwD4U3hXfvBuhCM1J9J8BxJcwzAUFJAP09T58WZFL9MportIS17KroDKUaEG+paqvZtCLH84t0d4ODyrI8hqqeYV56UcN5wgU+OlSuKag3IJ91hCwnm8DHH4wxXe/vKjsh6zMonNXHr3OmrUrtOR2aPlMezsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY75nCMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B50CC2BCB3;
	Thu, 29 Jan 2026 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704193;
	bh=8C3pFfQZds1zC7hLKiwrfj9jKp4rBs+tzu7Qk4k0fFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eY75nCMzfRNmaq6wL7ZRch3Qtmj2dmfYGkuQXBdk/Fg67Kt/rd1JzRgMhiaVXtatR
	 uMStxGPqDWoJQShp6AexkDYEbfP1ows67ecu6pQPjUt2tXYeGdGhuosf+eq2mLaQM3
	 uW+VLh1yQvXdHZh6VMnahEAEc0rwkzeVJ3cSZsAUQTna7cYwvT1NCqqllOAu7Gjqtn
	 +3XAqr3q0SwxHHWd4xC7OKFuNrlVeT5Kuz6sZwVsjvsZp3boUu6nf1tspfVBLz5QZg
	 GPU5akGOSfta4bnVt7X3e8++upg+XBzZiUcAjFxZYxv9/flpHgdFhuBOdyzdN8Du8U
	 MR6M4QlE/cJ+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A05D6B08C;
	Thu, 29 Jan 2026 16:29:53 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 29 Jan 2026 17:29:11 +0100
Subject: [PATCH net-next v5 5/6] can: remove private CAN skb headroom
 infrastructure
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-can_skb_ext-v5-5-21252fdc8900@hartkopp.net>
References: <20260129-can_skb_ext-v5-0-21252fdc8900@hartkopp.net>
In-Reply-To: <20260129-can_skb_ext-v5-0-21252fdc8900@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769704191; l=12880;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=Ksuovd6DQrwdcbCndfDw+oGa5/YFQ7f2lfWZ17wmJI8=;
 b=j1keo6PnrNVR87w3BNOFO/NrF5pka13HNX2Q7L0pQfkSnWB2Q4mXjz/j5NLZTgEr34xtMai2j
 h9qAq7E4q5DDFiIgfnletV7v2zt04BMcnY8Jy1d8WUoABW9UVnf8N90
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6405-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:replyto,hartkopp.net:email,hartkopp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 27A32B2352
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

This patch removes struct can_skb_priv which was stored at skb->head and
the can_skb_reserve() helper which was used to shift skb->head.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c | 31 +++++++++----------------------
 include/linux/can/skb.h   | 31 -------------------------------
 net/can/bcm.c             |  7 ++-----
 net/can/isotp.c           | 12 ++++--------
 net/can/j1939/socket.c    |  4 +---
 net/can/j1939/transport.c |  7 ++-----
 net/can/raw.c             |  5 ++---
 7 files changed, 20 insertions(+), 77 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 408ee49abce1..95fcdc1026f8 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -204,40 +204,33 @@ void can_free_echo_skb(struct net_device *dev, unsigned int idx,
 	}
 }
 EXPORT_SYMBOL_GPL(can_free_echo_skb);
 
 /* fill common values for CAN sk_buffs */
-static void init_can_skb_reserve(struct sk_buff *skb)
+static void init_can_skb(struct sk_buff *skb)
 {
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-	skb_reset_mac_header(skb);
-	skb_reset_network_header(skb);
-	skb_reset_transport_header(skb);
-
-	can_skb_reserve(skb);
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       sizeof(struct can_frame));
+	skb = netdev_alloc_skb(dev, sizeof(struct can_frame));
 	if (unlikely(!skb))
 		goto out_error_cc;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto out_error_cc;
 	}
 
 	skb->protocol = htons(ETH_P_CAN);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	csx->can_iif = dev->ifindex;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
@@ -253,23 +246,22 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 				struct canfd_frame **cfd)
 {
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       sizeof(struct canfd_frame));
+	skb = netdev_alloc_skb(dev, sizeof(struct canfd_frame));
 	if (unlikely(!skb))
 		goto out_error_fd;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto out_error_fd;
 	}
 
 	skb->protocol = htons(ETH_P_CANFD);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	csx->can_iif = dev->ifindex;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
 	/* set CAN FD flag by default */
@@ -292,23 +284,22 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 	struct can_skb_ext *csx;
 
 	if (data_len < CANXL_MIN_DLEN || data_len > CANXL_MAX_DLEN)
 		goto out_error_xl;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       CANXL_HDR_SIZE + data_len);
+	skb = netdev_alloc_skb(dev, CANXL_HDR_SIZE + data_len);
 	if (unlikely(!skb))
 		goto out_error_xl;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto out_error_xl;
 	}
 
 	skb->protocol = htons(ETH_P_CANXL);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	csx->can_iif = dev->ifindex;
 
 	*cxl = skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
 
 	/* set CAN XL flag and length information by default */
@@ -338,18 +329,14 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 	return skb;
 }
 EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 
 /* Check for outgoing skbs that have not been created by the CAN subsystem */
-static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
+static bool can_skb_init_valid(struct net_device *dev, struct sk_buff *skb)
 {
 	struct can_skb_ext *csx = can_skb_ext_find(skb);
 
-	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
-	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
-		return false;
-
 	/* af_packet does not apply CAN skb specific settings */
 	if (skb->ip_summed == CHECKSUM_NONE || !csx) {
 		/* init CAN skb content */
 		if (!csx) {
 			csx = can_skb_ext_add(skb);
@@ -403,11 +390,11 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 
 	default:
 		goto inval_skb;
 	}
 
-	if (!can_skb_headroom_valid(dev, skb))
+	if (!can_skb_init_valid(dev, skb))
 		goto inval_skb;
 
 	return false;
 
 inval_skb:
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 68c0f24e6914..a70a02967071 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -36,41 +36,10 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 				unsigned int data_len);
 struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 				  struct can_frame **cf);
 bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
 
-/*
- * The struct can_skb_priv is used to transport additional information along
- * with the stored struct can(fd)_frame that can not be contained in existing
- * struct sk_buff elements.
- * N.B. that this information must not be modified in cloned CAN sk_buffs.
- * To modify the CAN frame content or the struct can_skb_priv content
- * skb_copy() needs to be used instead of skb_clone().
- */
-
-/**
- * struct can_skb_priv - private additional data inside CAN sk_buffs
- * @ifindex:	ifindex of the first interface the CAN frame appeared on
- * @frame_len:	length of CAN frame in data link layer
- * @cf:		align to the following CAN frame at skb->data
- */
-struct can_skb_priv {
-	int ifindex;
-	unsigned int frame_len;
-	struct can_frame cf[];
-};
-
-static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
-{
-	return (struct can_skb_priv *)(skb->head);
-}
-
-static inline void can_skb_reserve(struct sk_buff *skb)
-{
-	skb_reserve(skb, sizeof(struct can_skb_priv));
-}
-
 static inline struct can_skb_ext *can_skb_ext_add(struct sk_buff *skb)
 {
 	struct can_skb_ext *csx = skb_ext_add(skb, SKB_EXT_CAN);
 
 	/* skb_ext_add() returns uninitialized space */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index f102d17e8619..b7324e9c955b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -310,21 +310,20 @@ static void bcm_can_tx(struct bcm_op *op)
 	if (!dev) {
 		/* RFC: should this bcm_op remove itself here? */
 		return;
 	}
 
-	skb = alloc_skb(op->cfsiz + sizeof(struct can_skb_priv), gfp_any());
+	skb = alloc_skb(op->cfsiz, gfp_any());
 	if (!skb)
 		goto out;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto out;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
 	/* send with loopback */
@@ -1331,22 +1330,20 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 
 	/* we need a real device to send frames */
 	if (!ifindex)
 		return -ENODEV;
 
-	skb = alloc_skb(cfsiz + sizeof(struct can_skb_priv), GFP_KERNEL);
+	skb = alloc_skb(cfsiz, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		return -ENOMEM;
 	}
 
-	can_skb_reserve(skb);
-
 	err = memcpy_from_msg(skb_put(skb, cfsiz), msg, cfsiz);
 	if (err < 0) {
 		kfree_skb(skb);
 		return err;
 	}
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 4a6ce6836b24..736078357b5c 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -218,11 +218,11 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	struct can_skb_ext *csx;
 	struct canfd_frame *ncf;
 	struct isotp_sock *so = isotp_sk(sk);
 	int can_send_ret;
 
-	nskb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), gfp_any());
+	nskb = alloc_skb(so->ll.mtu, gfp_any());
 	if (!nskb)
 		return 1;
 
 	csx = can_skb_ext_add(nskb);
 	if (!csx) {
@@ -234,13 +234,11 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	if (!dev) {
 		kfree_skb(nskb);
 		return 1;
 	}
 
-	can_skb_reserve(nskb);
 	csx->can_iif = dev->ifindex;
-
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
 	skb_put_zero(nskb, so->ll.mtu);
 
@@ -778,11 +776,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 
 	dev = dev_get_by_index(sock_net(sk), so->ifindex);
 	if (!dev)
 		return;
 
-	skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	skb = alloc_skb(so->ll.mtu, GFP_ATOMIC);
 	if (!skb) {
 		dev_put(dev);
 		return;
 	}
 
@@ -791,11 +789,10 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		kfree_skb(skb);
 		netdev_put(dev, NULL);
 		return;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
@@ -1013,12 +1010,12 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!dev) {
 		err = -ENXIO;
 		goto err_out_drop;
 	}
 
-	skb = sock_alloc_send_skb(sk, so->ll.mtu + sizeof(struct can_skb_priv),
-				  msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = sock_alloc_send_skb(sk, so->ll.mtu, msg->msg_flags & MSG_DONTWAIT,
+				  &err);
 	if (!skb) {
 		dev_put(dev);
 		goto err_out_drop;
 	}
 
@@ -1027,11 +1024,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		kfree_skb(skb);
 		netdev_put(dev, NULL);
 		goto err_out_drop;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index f03bae79354e..10014d95c319 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -889,23 +889,21 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	int ret;
 
 	skb = sock_alloc_send_skb(sk,
 				  size +
 				  sizeof(struct can_frame) -
-				  sizeof(((struct can_frame *)NULL)->data) +
-				  sizeof(struct can_skb_priv),
+				  sizeof(((struct can_frame *)NULL)->data),
 				  msg->msg_flags & MSG_DONTWAIT, &ret);
 	if (!skb)
 		goto failure;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto failure;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = ndev->ifindex;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret < 0)
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 96e02ad4a726..e63cf79af1c4 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -593,23 +593,21 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 {
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 	struct j1939_sk_buff_cb *skcb;
 
-	skb = alloc_skb(sizeof(struct can_frame) + sizeof(struct can_skb_priv),
-			GFP_ATOMIC);
+	skb = alloc_skb(sizeof(struct can_frame), GFP_ATOMIC);
 	if (unlikely(!skb))
 		return ERR_PTR(-ENOMEM);
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	skb->dev = priv->ndev;
-	can_skb_reserve(skb);
 	csx->can_iif = priv->ndev->ifindex;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	/* skb->cb must be large enough to hold a j1939_sk_buff_cb structure */
@@ -1535,22 +1533,21 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 	struct j1939_sk_buff_cb *skcb;
 	struct j1939_session *session;
 
-	skb = alloc_skb(size + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	skb = alloc_skb(size, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		return NULL;
 	}
 
 	skb->dev = priv->ndev;
-	can_skb_reserve(skb);
 	csx->can_iif = priv->ndev->ifindex;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
 	session = j1939_session_new(priv, skb, size);
diff --git a/net/can/raw.c b/net/can/raw.c
index 7c89962ec913..d33ce436018f 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -951,22 +951,21 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (can_cap_enabled(dev, CAN_CAP_RO)) {
 		err = -EACCES;
 		goto put_dev;
 	}
 
-	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
-				  msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = sock_alloc_send_skb(sk, size, msg->msg_flags & MSG_DONTWAIT,
+				  &err);
 	if (!skb)
 		goto put_dev;
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
 		kfree_skb(skb);
 		goto put_dev;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)

-- 
2.51.0



