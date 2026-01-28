Return-Path: <linux-can+bounces-6373-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPgKM5J7emka7AEAu9opvQ
	(envelope-from <linux-can+bounces-6373-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 22:11:46 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF8EA8FA4
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 22:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 550CC30160DC
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DCA377579;
	Wed, 28 Jan 2026 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1Cyt9Up"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A537755F;
	Wed, 28 Jan 2026 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634699; cv=none; b=WAtMIbMFXHkOlS+B/hlrw23Ri21KO44PWanEU4Jyg5YN+oWYlFgQtpBt8JnJVK8KddpPLwOQgZWHzkBBdMmtOtS4bTMcbBPZIKJCP7dFvK3NGzDAXgeDgIS8p7tU1krfdaK5jjlUX2DilGgltvkf2NGSwduc0R9FYZIwJEnSNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634699; c=relaxed/simple;
	bh=l3GnXPC6m6nWYQ0+YglJD51Wy1yJ1dvR6NVpyqcJK/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ia/0cOIilL6+MQU29SOtAj+kHglkx2NKz9qfZ+XMwE5UG+H521JdeLjWrI7t81L5RCtHV+cT9sUPoRyDBZp4oFN1AjBDBHfjAlHXEW33Z6IaLo0B7ohvTeKErdUlxlnyVkRS1f5Q/rukJ9mMNWmQrhS9A13NlyTaSWrcDiQRNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1Cyt9Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B698AC2BC86;
	Wed, 28 Jan 2026 21:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769634699;
	bh=l3GnXPC6m6nWYQ0+YglJD51Wy1yJ1dvR6NVpyqcJK/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X1Cyt9UpxrieNdRA8eXRktAK6DFH10VOtYECew2r7TBufjYpAdgNS4shNC93PfgZT
	 GOFwE+1o0U5wkzHQTMbVGrk40KnDWf21Bicy5+Z8kM081OVQDZETR3f4BB/qB5nlRi
	 J9aTiUHgF0deLUo2rq0sxsleAVuXlWT5bWGNWtTtDoshUw1BRZha0EJdoBr9E9OJj5
	 dLceOVEkqFP3b9Hugc+EteB4sr3+1PXSzTLwTVHabZSOEG41rsq9zZH4vNNv9P7d8u
	 MAdiH2yW8lVBou+5pOGA+VWAUrKV8NJfeHhVSGU4nmVCvmq0ZyfdIjd/YbansE5VbQ
	 Xo9jkFiyBub9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEAFD46C01;
	Wed, 28 Jan 2026 21:11:39 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 28 Jan 2026 22:10:54 +0100
Subject: [PATCH net-next V3 4/7] can: move ifindex to CAN skb extensions
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-can_skb_ext-v1-4-71b8bcbfd8cf@hartkopp.net>
References: <20260128-can_skb_ext-v1-0-71b8bcbfd8cf@hartkopp.net>
In-Reply-To: <20260128-can_skb_ext-v1-0-71b8bcbfd8cf@hartkopp.net>
To: netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769634697; l=7651;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=w7cNs9hzEmtG/DQ1HzTz0gP8+VwWwUZ2QFgTD5JIB9g=;
 b=FBoR1URBHABnEswDcz8G7yq7SnEuLWDD6qwdqw9+kt3slHZ0YDOw8dnZ5oLjqCTV9spPRk+hF
 90MxmTEGnvHA38mNG1sWuOViafjWSKiR/9m5ryVBE/MNCjXPfqXH+GZ
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6373-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,hartkopp.net:replyto,hartkopp.net:email,hartkopp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FF8EA8FA4
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

When routing CAN frames over different CAN interfaces the interface index
skb->iif is overwritten with every single hop. To prevent sending a CAN
frame back to its originating (first) incoming CAN interface another
ifindex variable is needed, which was stored in can_skb_priv::ifindex.

Move the can_skb_priv::ifindex content to can_skb_ext::can_iif.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c | 9 ++++-----
 net/can/bcm.c             | 4 ++--
 net/can/gw.c              | 2 +-
 net/can/isotp.c           | 6 +++---
 net/can/j1939/socket.c    | 2 +-
 net/can/j1939/transport.c | 4 ++--
 net/can/raw.c             | 2 +-
 7 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index c572745565f6d0ff25729039220614ecb117e2b3..470255fe7367b6ff038e45255abc3ea9eed88704 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -221,11 +221,11 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 		goto out_error_cc;
 	}
 
 	skb->protocol = htons(ETH_P_CAN);
 	init_can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
 
@@ -253,11 +253,11 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 		goto out_error_fd;
 	}
 
 	skb->protocol = htons(ETH_P_CANFD);
 	init_can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
 	/* set CAN FD flag by default */
 	(*cfd)->flags = CANFD_FDF;
@@ -292,11 +292,11 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 		goto out_error_xl;
 	}
 
 	skb->protocol = htons(ETH_P_CANXL);
 	init_can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	*cxl = skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
 
 	/* set CAN XL flag and length information by default */
 	(*cxl)->flags = CANXL_XLF;
@@ -342,12 +342,11 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 			csx = can_skb_ext_add(skb);
 			if (!csx)
 				return false;
 		}
 
-		can_skb_prv(skb)->ifindex = dev->ifindex;
-
+		csx->can_iif = dev->ifindex;
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 		/* perform proper loopback on capable devices */
 		if (dev->flags & IFF_ECHO)
 			skb->pkt_type = PACKET_LOOPBACK;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index aee2f0f779746f14dc368857435e7aabdb837afc..d5d1fa71c3f213ef0f5add958db78371b63a2d63 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -321,11 +321,11 @@ static void bcm_can_tx(struct bcm_op *op)
 		kfree_skb(skb);
 		goto out;
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
 	/* send with loopback */
 	skb->dev = dev;
@@ -1355,11 +1355,11 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 	if (!dev) {
 		kfree_skb(skb);
 		return -ENODEV;
 	}
 
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 	err = can_send(skb, 1); /* send with loopback */
 	netdev_put(dev);
 
diff --git a/net/can/gw.c b/net/can/gw.c
index 8894ab5d2087c759135ec21644dcbe31a9e5162f..ad89a1913b3422f77fdf91b5552380282b2db09a 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -503,11 +503,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		return;
 	}
 
 	/* is sending the skb back to the incoming interface not allowed? */
 	if (!(gwj->flags & CGW_FLAGS_CAN_IIF_TX_OK) &&
-	    can_skb_prv(skb)->ifindex == gwj->dst.dev->ifindex)
+	    csx->can_iif == gwj->dst.dev->ifindex)
 		return;
 
 	/* clone the given skb, which has not been done in can_rcv()
 	 *
 	 * When there is at least one modification function activated,
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 38e82e17008189db3ed3d22087199f0abbaaaef2..7219cc1949ff8cb8389103901c731b6dd66a68be 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -235,11 +235,11 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 		kfree_skb(nskb);
 		return 1;
 	}
 
 	can_skb_reserve(nskb);
-	can_skb_prv(nskb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
 	skb_put_zero(nskb, so->ll.mtu);
@@ -792,11 +792,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		netdev_put(dev);
 		return;
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* create consecutive frame */
@@ -1028,11 +1028,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		netdev_put(dev);
 		goto err_out_drop;
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 3a2288f91b6e8fcffd588c397fa2632140f314d8..da981e8880237307211c5410b85e8a7d800e6367 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -902,11 +902,11 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 		kfree_skb(skb);
 		goto failure;
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = ndev->ifindex;
+	csx->can_iif = ndev->ifindex;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret < 0)
 		goto free_skb;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 0514f3504e39927f7950cfad33a20d6536bca797..96e02ad4a726fbc947cbae55687c0d6aa613d50e 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -606,11 +606,11 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 		return ERR_PTR(-ENOMEM);
 	}
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	csx->can_iif = priv->ndev->ifindex;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	/* skb->cb must be large enough to hold a j1939_sk_buff_cb structure */
 	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(*re_skcb));
@@ -1547,11 +1547,11 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 		return NULL;
 	}
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	csx->can_iif = priv->ndev->ifindex;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
 	session = j1939_session_new(priv, skb, size);
 	if (!session) {
diff --git a/net/can/raw.c b/net/can/raw.c
index ff254c2ba9b68fe6b0662725b61fcac2f49c6be2..a990f39b9e272333d81f01db87cb016e60304c50 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -963,11 +963,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		kfree_skb(skb);
 		goto put_dev;
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;

-- 
2.47.3



