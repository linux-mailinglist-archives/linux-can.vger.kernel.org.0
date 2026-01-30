Return-Path: <linux-can+bounces-6410-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EjOCfBufGk/MgIAu9opvQ
	(envelope-from <linux-can+bounces-6410-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 09:42:24 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8363B888F
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 09:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3262230158BC
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE133EB0E;
	Fri, 30 Jan 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1NwDjgB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA123126B4;
	Fri, 30 Jan 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762538; cv=none; b=hffguozj5hJ3Wu3GvaSzKbaHM2QIAXyBpw3Z2BuznAcoL6guynnb1VcqIWzBGykIgg+AStuLwPWo/KYqpBK4A0LLRjjNP35Fn3LPeKvlg0n5dTU/vROMdDRk+P+1LHbTNMeoQZrbx/s5UgEJJZKi6q//U1honO2RtK3urjNbJa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762538; c=relaxed/simple;
	bh=Zr207pLpoOl8Efcuhmt4eGa2fB+p37mmTKkFlqtp/zU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OcLf/adGRo6c6FGrAy96C9gyctdRgYfejOXRwB5+KP75H6YAbLs/7ZDwnv0E6xEUq5cVxjDmB21G8imEJKouypOpclL0KDL/c+OLiFfOB7m84V3A4dBkFJbfKoP9/jqZpAvxwj2HbMtfQZPehUQqtBW1UY9dkyhfWKVcGn4eDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1NwDjgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8DB0C116D0;
	Fri, 30 Jan 2026 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769762537;
	bh=Zr207pLpoOl8Efcuhmt4eGa2fB+p37mmTKkFlqtp/zU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s1NwDjgB/lfO2lXirELKWxhAgWi9Exs31V8+b35xIxynyTqknUxneEEEWdYzcuM4V
	 W6nZc8ZyRS0+CAyqL6lEP+QOOpbjpH/nh1hvwOva/vyRFFvVjmQQsejAK1fF/vaj4L
	 Nf7+jsRJOlkMU9jWJrcaoupwPVo8ESyNfx1bVaHNFXCcz7Q8+DU9XZ9vcVkVgHkJ6h
	 i/kZwfNquow19zHuMUvx+cAw3KRnA6mp+GrYDA8ViIAs+7GNcTuAPlgdcP8DOiMFwC
	 sEq5KA+wRKGT1WbVa2IXSCLSzLCY0zOEz7N7exqFe6Ujcb+b67oI8JwEOL89jeHcv6
	 NK8Ozdvo6BXZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE913D49C80;
	Fri, 30 Jan 2026 08:42:17 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Fri, 30 Jan 2026 09:41:57 +0100
Subject: [PATCH net-next v6 3/6] can: move ifindex to CAN skb extensions
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-can_skb_ext-v6-3-8fceafab7f26@hartkopp.net>
References: <20260130-can_skb_ext-v6-0-8fceafab7f26@hartkopp.net>
In-Reply-To: <20260130-can_skb_ext-v6-0-8fceafab7f26@hartkopp.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769762535; l=7268;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=bcCoI+Uop6YGtSYl6caeeERcJlCjQpj1nFnUHuTQg+c=;
 b=NLLdWsjv98hYpy2cOmUcnkutloCHA5E6Q/duf5o+7DjULJ1udWW/hi0wgs3dreIZX6mjkZmKX
 U4UkxX4/XxvDRW3fvObPOUWM2Jza3S+mwgizthEY3FmDVmK/LentmI1
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
	TAGGED_FROM(0.00)[bounces-6410-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8363B888F
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
index 66df208f52a0..6f158abd61aa 100644
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
index 94103fe654ff..4a6ce6836b24 100644
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
@@ -1028,11 +1028,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		netdev_put(dev, NULL);
 		goto err_out_drop;
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index fc28a7677369..f03bae79354e 100644
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
index 0514f3504e39..96e02ad4a726 100644
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
index 03438e9bc535..7c89962ec913 100644
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
2.51.0



