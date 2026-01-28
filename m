Return-Path: <linux-can+bounces-6329-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIeOFP3WeWlI0AEAu9opvQ
	(envelope-from <linux-can+bounces-6329-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 10:29:33 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C88909EC9F
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 10:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD9783013722
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ED6344DB6;
	Wed, 28 Jan 2026 09:29:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B4344DB3
	for <linux-can@vger.kernel.org>; Wed, 28 Jan 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592570; cv=none; b=h3e1GYVcxU28iWMmPCV6+hTP8c3znOuYyDc2HTMOlKwGpUgg+H7y6hnRcvok/CxmI8r2PVf+0gp0r7tz1LMQ87aKZAIol/nBS9bawxuAAWibIZ2iaFEFWro0L8LnOhqwykM70oFdJPT0D+m/HSZZA4KWnsUV9gbbBmnU6VOyzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592570; c=relaxed/simple;
	bh=MVGBS2HGkpqFld/gNx26JykaHXHQj0pXMnkLVFy1qT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKuTY/TqvAUcQEgc0qK5epaR2CG/UxNRq1AmXTRBFi1F5AFDBAWOt7rDa4ElfyUZ0uhj2Ngs3XzVD+iawqoLwDa0bpm5CqpzEMyzxwdPttXyULR82G7NoA6tKJQEztKvw3sg1gq5GIbnkosgj7bNeSLYPJJ7da8i0zq00PR+Y/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl1rN-0007xa-Mu; Wed, 28 Jan 2026 10:29:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl1rN-002tQK-1z;
	Wed, 28 Jan 2026 10:29:12 +0100
Received: from hardanger.blackshift.org (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 93FA84DA030;
	Wed, 28 Jan 2026 09:29:12 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 28 Jan 2026 10:28:57 +0100
Subject: [PATCH can-next v2 5/6] can: remove private CAN skb headroom
 infrastructure
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-can-skb-ext-v2-5-fe64aa152c8a@pengutronix.de>
References: <20260128-can-skb-ext-v2-0-fe64aa152c8a@pengutronix.de>
In-Reply-To: <20260128-can-skb-ext-v2-0-fe64aa152c8a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11487; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=NhDwP8zjUgjdSYsc+RdEt+DdCPnhXIqkUCmcZwvuwiw=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpedbk08R4cv7GQwnB0Ur1+rjSbop5n+wWR1bdn
 jY5GBpDVmCJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaXnW5AAKCRAMdGXf+ZCR
 nHG1B/9zcz1d548wDJQt0PpvGAhgXlmPoY7Fa6YC8X7OmBzUdqUPcjIUsKYv07qwr/7SRhzjYCB
 7vwqTRfuW6iDZTzjgVQxjnKfuVloSFKDxGGa87/MeLnl0n/WWRqivqCpD0WE9LmYMJ8VcOlzqrv
 w3R4E1ZKgD8ijuXWTGd55TkYVqPSgv2jXfmx9qoaNT/vr6q9IyaNBz/lzPbg1lVhk5GvvcmXj3Q
 xDz2jRhr3MUum3Ggikq8QiIkwXtAnqbkLsqOlLy52s26FjRC439pOa1wslptECe4+zx/TxvWxhW
 ddlRcEPJRD8AuFnCvPAkgWG+NC7quTmght396qOu+2GjQGpa
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-6329-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: C88909EC9F
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

This patch removes struct can_skb_priv which was stored at skb->head and
the can_skb_reserve() helper which was used to shift skb->head.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/skb.c | 31 +++++++++----------------------
 include/linux/can/skb.h   | 31 -------------------------------
 net/can/bcm.c             |  7 ++-----
 net/can/isotp.c           | 12 ++++--------
 net/can/j1939/socket.c    |  4 +---
 net/can/j1939/transport.c |  7 ++-----
 net/can/raw.c             |  4 +---
 7 files changed, 19 insertions(+), 77 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 408ee49abce1..95fcdc1026f8 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -206,16 +206,10 @@ void can_free_echo_skb(struct net_device *dev, unsigned int idx,
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
@@ -223,8 +217,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       sizeof(struct can_frame));
+	skb = netdev_alloc_skb(dev, sizeof(struct can_frame));
 	if (unlikely(!skb))
 		goto out_error_cc;
 
@@ -235,7 +228,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 	}
 
 	skb->protocol = htons(ETH_P_CAN);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	csx->can_iif = dev->ifindex;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
@@ -255,8 +248,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       sizeof(struct canfd_frame));
+	skb = netdev_alloc_skb(dev, sizeof(struct canfd_frame));
 	if (unlikely(!skb))
 		goto out_error_fd;
 
@@ -267,7 +259,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 	}
 
 	skb->protocol = htons(ETH_P_CANFD);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	csx->can_iif = dev->ifindex;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
@@ -294,8 +286,7 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 	if (data_len < CANXL_MIN_DLEN || data_len > CANXL_MAX_DLEN)
 		goto out_error_xl;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       CANXL_HDR_SIZE + data_len);
+	skb = netdev_alloc_skb(dev, CANXL_HDR_SIZE + data_len);
 	if (unlikely(!skb))
 		goto out_error_xl;
 
@@ -306,7 +297,7 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 	}
 
 	skb->protocol = htons(ETH_P_CANXL);
-	init_can_skb_reserve(skb);
+	init_can_skb(skb);
 	csx->can_iif = dev->ifindex;
 
 	*cxl = skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
@@ -340,14 +331,10 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
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
@@ -405,7 +392,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 		goto inval_skb;
 	}
 
-	if (!can_skb_headroom_valid(dev, skb))
+	if (!can_skb_init_valid(dev, skb))
 		goto inval_skb;
 
 	return false;
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index aeb08f47de48..cacbbb185bb9 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -38,37 +38,6 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev,
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
 	return skb_ext_add(skb, SKB_EXT_CAN);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index f102d17e8619..b7324e9c955b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -312,7 +312,7 @@ static void bcm_can_tx(struct bcm_op *op)
 		return;
 	}
 
-	skb = alloc_skb(op->cfsiz + sizeof(struct can_skb_priv), gfp_any());
+	skb = alloc_skb(op->cfsiz, gfp_any());
 	if (!skb)
 		goto out;
 
@@ -322,7 +322,6 @@ static void bcm_can_tx(struct bcm_op *op)
 		goto out;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	skb_put_data(skb, cf, op->cfsiz);
@@ -1333,7 +1332,7 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 	if (!ifindex)
 		return -ENODEV;
 
-	skb = alloc_skb(cfsiz + sizeof(struct can_skb_priv), GFP_KERNEL);
+	skb = alloc_skb(cfsiz, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
@@ -1343,8 +1342,6 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 		return -ENOMEM;
 	}
 
-	can_skb_reserve(skb);
-
 	err = memcpy_from_msg(skb_put(skb, cfsiz), msg, cfsiz);
 	if (err < 0) {
 		kfree_skb(skb);
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 01ceb3febbb7..434986cc8fe5 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -220,7 +220,7 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	struct isotp_sock *so = isotp_sk(sk);
 	int can_send_ret;
 
-	nskb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), gfp_any());
+	nskb = alloc_skb(so->ll.mtu, gfp_any());
 	if (!nskb)
 		return 1;
 
@@ -236,9 +236,7 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 		return 1;
 	}
 
-	can_skb_reserve(nskb);
 	csx->can_iif = dev->ifindex;
-
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
@@ -780,7 +778,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	if (!dev)
 		return;
 
-	skb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	skb = alloc_skb(so->ll.mtu, GFP_ATOMIC);
 	if (!skb) {
 		dev_put(dev);
 		return;
@@ -793,7 +791,6 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		return;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	cf = (struct canfd_frame *)skb->data;
@@ -1015,8 +1012,8 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
-	skb = sock_alloc_send_skb(sk, so->ll.mtu + sizeof(struct can_skb_priv),
-				  msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = sock_alloc_send_skb(sk, so->ll.mtu, msg->msg_flags & MSG_DONTWAIT,
+				  &err);
 	if (!skb) {
 		dev_put(dev);
 		goto err_out_drop;
@@ -1029,7 +1026,6 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	so->tx.len = size;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index f03bae79354e..10014d95c319 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -891,8 +891,7 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	skb = sock_alloc_send_skb(sk,
 				  size +
 				  sizeof(struct can_frame) -
-				  sizeof(((struct can_frame *)NULL)->data) +
-				  sizeof(struct can_skb_priv),
+				  sizeof(((struct can_frame *)NULL)->data),
 				  msg->msg_flags & MSG_DONTWAIT, &ret);
 	if (!skb)
 		goto failure;
@@ -903,7 +902,6 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 		goto failure;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = ndev->ifindex;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 96e02ad4a726..e63cf79af1c4 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -595,8 +595,7 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 	struct can_skb_ext *csx;
 	struct j1939_sk_buff_cb *skcb;
 
-	skb = alloc_skb(sizeof(struct can_frame) + sizeof(struct can_skb_priv),
-			GFP_ATOMIC);
+	skb = alloc_skb(sizeof(struct can_frame), GFP_ATOMIC);
 	if (unlikely(!skb))
 		return ERR_PTR(-ENOMEM);
 
@@ -607,7 +606,6 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 	}
 
 	skb->dev = priv->ndev;
-	can_skb_reserve(skb);
 	csx->can_iif = priv->ndev->ifindex;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
@@ -1537,7 +1535,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	struct j1939_sk_buff_cb *skcb;
 	struct j1939_session *session;
 
-	skb = alloc_skb(size + sizeof(struct can_skb_priv), GFP_ATOMIC);
+	skb = alloc_skb(size, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -1548,7 +1546,6 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	}
 
 	skb->dev = priv->ndev;
-	can_skb_reserve(skb);
 	csx->can_iif = priv->ndev->ifindex;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
diff --git a/net/can/raw.c b/net/can/raw.c
index 7c89962ec913..d200b6f66fb9 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -953,8 +953,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto put_dev;
 	}
 
-	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
-				  msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = sock_alloc_send_skb(sk, size, msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		goto put_dev;
 
@@ -964,7 +963,6 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto put_dev;
 	}
 
-	can_skb_reserve(skb);
 	csx->can_iif = dev->ifindex;
 
 	/* fill the skb before testing for valid CAN frames */

-- 
2.51.0


