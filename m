Return-Path: <linux-can+bounces-6450-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE28Il9kf2lNpgIAu9opvQ
	(envelope-from <linux-can+bounces-6450-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 15:34:07 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB117C6299
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 15:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DEA5300DE20
	for <lists+linux-can@lfdr.de>; Sun,  1 Feb 2026 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60665350D78;
	Sun,  1 Feb 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y68eKF18"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9893502AD;
	Sun,  1 Feb 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769956421; cv=none; b=sJYUoNCD1ImDcRZsDKewulnlQBzHSLyWktF4XQjIoHV9RgMYW40+9wUz7xVjoIZdPZG7NVHlB4L2k0Ik0tVpDPidcOsFuTjm9BdgDQ9TQ70VL6e/sjw9FZOpmNpo5lmsKK4RuzEd1FCTpJRGhpwatJP0/wXqypzU0AqqWmkGPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769956421; c=relaxed/simple;
	bh=lyzEVznbtpIc4UVQRkUE0nZSps9/YTLx7MjRLWe2ZhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GFBXmTXGcKNXT13v7BJesgG+6P/jmqWo7eN9na4IU9jXr6eM2wQcLTaW8AEkMiqmEuiqtulOeYJ8kQwxGTbeDEHp+FfIbmU6MbPUAy0Nz3pBkr0uFERq5s2yNfrCobfhHyG2dAaNfalTHJKD9tvFZ6hXEzyihIvVNq3uaU3dXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y68eKF18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E89C0C2BC86;
	Sun,  1 Feb 2026 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769956421;
	bh=lyzEVznbtpIc4UVQRkUE0nZSps9/YTLx7MjRLWe2ZhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y68eKF18xdgjzmdevKZQPMrfQUPM5QInUKfNVU7BznvS52qqmhUB9KtPwUpw7PUH/
	 mTI1fmOEqU/50OlWjy5lM4GPQ9bNjF4BL+g+qARNNtS5RIwZMva4636I+8VbxW1EkT
	 CJj+ZBaJXNHWCrzh9mI/LtNXkBqQScK+Njo5D/FL7MSz/XvTbniI4hoHFsFmXZpMT3
	 WJF5hczm1gl0vkGfI4oc9IKNe1CaYICbaYVenuhGQ5tignPlgRCWddfuQ00gaa2Wyd
	 XquqbyAUGdUgupTlUOkhcMDJw3rMEucSnOTsKWv3aFhZuar3d0Iw+REsiBUbLczsZI
	 612WNt6U8GK0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC6DE65284;
	Sun,  1 Feb 2026 14:33:40 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sun, 01 Feb 2026 15:33:18 +0100
Subject: [PATCH net-next v8 3/6] can: move ifindex to CAN skb extensions
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-can_skb_ext-v8-3-3635d790fe8b@hartkopp.net>
References: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
In-Reply-To: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769956418; l=7258;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=pX96OJdndwK9TETOfed20xPt7lGeKQ9Tj3FTVMKxLhk=;
 b=yYveMvnyEgVPcfQj/OhpC5+APHbC4S0cPtILO3NGfwofidqEIek1ypyE3F2KJ3b7xVrwyC0yj
 u+ksPI75CJ1DLh36F9R+qYe4JqVvzypF9C3KlrL+5X/Ur/MxQXDDmlZ
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
	TAGGED_FROM(0.00)[bounces-6450-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB117C6299
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
index c572745565f6..470255fe7367 100644
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
index 38452069dea8..f102d17e8619 100644
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
 	dev_put(dev);
 
diff --git a/net/can/gw.c b/net/can/gw.c
index 191afe3b673c..816154a978c1 100644
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
index 1346dac0f382..164c4fbf3e23 100644
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
 		netdev_put(dev, NULL);
 		return;
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* create consecutive frame */
@@ -1029,11 +1029,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		err = -ENOMEM;
 		goto err_out_drop;
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index b7fbc6512f16..cc698a6dc363 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -903,11 +903,11 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 		ret = -ENOMEM;
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
index 03fea5bf0f73..3456ef481799 100644
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
@@ -1558,11 +1558,11 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
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
index c63af48495b7..022154b0f6cc 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -964,11 +964,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		err = -ENOMEM;
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
2.51.0



