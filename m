Return-Path: <linux-can+bounces-6383-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LXVK0GRemmz7wEAu9opvQ
	(envelope-from <linux-can+bounces-6383-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 23:44:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B7CA9BA7
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 23:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09A4E301F7A4
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 22:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8A0345CBD;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvmpDeV/"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A251344DAB;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640239; cv=none; b=e9Idq2MwqrBgiQfzvKt4+pq1CcdUWp3NRl3SP2dL3F5jEylyCwFL/rUDxzCaahbkrbm7NfSmW554JBnZwofz6Xl1bk7a5O+IVJQ8AFx9RIXvju4vdby2/zaFaDMEnxib26b4t1rNfRII2+yfkc+nQODnYJRaTtlHxvFq3M1ziB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640239; c=relaxed/simple;
	bh=7913iJ5l9AMSH0DtXDAUX5kkFenQlA6HEGMT0UknlLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bb7NFtVfbQnsS/tI1zaTVgBKxGp+Ln5ytUYbrKMCKfeuC7hIKEa7DkHpQn1/ETvyLSQNfkZOFFzCLFSZvvfXK3/jYKqNqoWN5ex1C29bnXwFzjL0MPFPmjc/AsY7A5/21iLdSyTgjZTCyyTtrB0mmmIHXEtMMBT8d4f1UWx+JZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvmpDeV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F3DAC2BC9E;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769640239;
	bh=7913iJ5l9AMSH0DtXDAUX5kkFenQlA6HEGMT0UknlLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rvmpDeV/NYHY/mewXJtop2MYlrwVUAx6UKZWOLOm/hTOAwoDFITusBj8aek3WAPTj
	 GruG4VgWhV1a9WeCk7xikzt9bZD0DQCQW/9NSnHtJQ5Pu4KWxC/72DtOE1PUp5iZwT
	 xjc5KETRUNKR1KQfS3OknzslcCXpTDrHmQQpSjJCwIGFwOFApRGhgxV7INBqJBt4PM
	 OPke8d/1N0PY8ut1GAdSSuSDQ/F6Yo8lehN9pTLHnk4ry+UwYUlhpeo6gJ8PdWX3Ky
	 VHVcJ0jYi12rhnN4G6/5vCPPFR3KbYfwOGO/ogXyvjnDdQKpSsVACUITmxnC60wCj5
	 qhADyAs+ZQHrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E1ED46C01;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 28 Jan 2026 23:43:44 +0100
Subject: [PATCH net-next V4 5/6] can: remove private CAN skb headroom
 infrastructure
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-can_skb_ext-v1-5-330f60fd5d7e@hartkopp.net>
References: <20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net>
In-Reply-To: <20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net>
To: netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769640237; l=13254;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=PSRI0Rj/4R9Aej+UyPjFmtC36Hu3Bketv8mA1bFUywA=;
 b=ThT/vBAiRRUvE0CrV2aPGYmLUBNAAYD9y6++l0776zdWW3CPlsdRYuJlTf8ikUG5mgV3zO3Xs
 eYpTYP8VYcIDN/g88nwZO924j4THDBySw+gUjf4yA9Gw5QkLQo8AAgC
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-6383-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Queue-Id: 43B7CA9BA7
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
index 408ee49abce145f49c7837ff30809bc3e42f8ab5..95fcdc1026f808656551c0253faafafd1018f48c 100644
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
index 68c0f24e69149707e38d657e821d6cbe129f7d1d..a70a0296707115c71e2f228d434cf4d76ffa9c06 100644
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
index f102d17e86190b7a46f806870991136c0b416b0d..b7324e9c955b7f03a8f032676bbd89aa8e06bded 100644
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
index 01ceb3febbb757d2d727d90f987b9c47dd45973d..434986cc8fe55e206325da4aa25bef4f5a12e6c7 100644
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
 		dev_put(dev);
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
 		dev_put(dev);
 		goto err_out_drop;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index f03bae79354e1cc7fa8655d92fe9f5b9db2d65bb..10014d95c31960cb535d88d50ca22483da2415e5 100644
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
index 96e02ad4a726fbc947cbae55687c0d6aa613d50e..e63cf79af1c4294407f602369e83ec2278a5707b 100644
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
index 7c89962ec913396e7948c0f6d2ad80c8f66a8985..d33ce436018ff3586b572242674d4d31b940c95c 100644
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
2.47.3



