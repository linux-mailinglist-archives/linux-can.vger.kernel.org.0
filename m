Return-Path: <linux-can+bounces-6327-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC2eCPzWeWlI0AEAu9opvQ
	(envelope-from <linux-can+bounces-6327-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 10:29:32 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E99EC98
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 10:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74F833004C30
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FF0345751;
	Wed, 28 Jan 2026 09:29:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6262F5331
	for <linux-can@vger.kernel.org>; Wed, 28 Jan 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592570; cv=none; b=ppUGE7y7jNSckr5we/SIlzxdzX4LqG8RVjSbYg9vsl70LeEgBxzfYZJlkFk4NQdvfNIfwf6HDSqfOnd18GX7JxFI3FIndgtuzMJftRpQe1ELZQcp9068GKETuoC9RSMqoHyxQSw6aKXdDkTIx/ez65pgNnE4Jiu6vNjpmOLsms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592570; c=relaxed/simple;
	bh=sd5gSgwK6/ivRpS5ofCo9++roj+1pAvKR7eAiOrWsgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3gaIvXqu8Pdx2lj5RNv/NGnWtIFK4StJ14BIJs093WnPHFFxmuFTv2Ihjz22v7So+PUIetEAHTN9PwxTRrfl+HdTwqKwXsoa+BPgWBEUkh7PhYw/bG/1V5HQxfW54hwla1H2Gx2mv7Fcwelx1wOBJZjuXd1AWuDH0WfhwXgYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl1rN-0007xV-Mv; Wed, 28 Jan 2026 10:29:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl1rN-002tQG-1J;
	Wed, 28 Jan 2026 10:29:12 +0100
Received: from hardanger.blackshift.org (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 750BE4DA02E;
	Wed, 28 Jan 2026 09:29:12 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 28 Jan 2026 10:28:55 +0100
Subject: [PATCH can-next v2 3/6] can: move ifindex to CAN skb extensions
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-can-skb-ext-v2-3-fe64aa152c8a@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5905; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=+AObhdJZJ0TemPUqMAdgr2BqPWvBQHT3whbPf06BUaQ=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpedbg8A8LFQTHrG6TY6ZJKjNQcktuxuZyC2o/A
 eDPK8Nf0c+JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaXnW4AAKCRAMdGXf+ZCR
 nBcWB/9sjHeo9jnFB0cYod8SVhhihjwD5e7et6dmrSGr4ADMWjEXIahMZVAQ/Z0NJdz2jMiQkF4
 hrUAi9DkiOYJhTkZjv5cF1cmCJsP07Iu0zxJ5XFoLSzeQ7xdc45QsP/xpm/CdWe8C5EtCeWA9Fy
 7ZfWICP8pYuqtNwxL6saA8wSZqO/dVDphiA40kIzwGlrgySbokW+S3k2BLsmbMAE36T/pol7maR
 S2lfj2Y1MdEb1iJjMVq2WCu+5zAbsbzpz1zbcUpangrEKmT7PRlNvHBhZqTXVUYBuoQ8P50MIxk
 KxVa3a9qmXhcsNpgUtIGcJEUaqhTheaMvszgTXxPtiw/jPU9
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6327-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:mid]
X-Rspamd-Queue-Id: 8B4E99EC98
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

When routing CAN frames over different CAN interfaces the interface index
skb->iif is overwritten with every single hop. To prevent sending a CAN
frame back to its originating (first) incoming CAN interface another
ifindex variable is needed, which was stored in can_skb_priv::ifindex.

Move the can_skb_priv::ifindex content to can_skb_ext::can_iif.

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
@@ -223,7 +223,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 
 	skb->protocol = htons(ETH_P_CAN);
 	init_can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
@@ -255,7 +255,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 
 	skb->protocol = htons(ETH_P_CANFD);
 	init_can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
@@ -294,7 +294,7 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 
 	skb->protocol = htons(ETH_P_CANXL);
 	init_can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	*cxl = skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
 
@@ -344,8 +344,7 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 				return false;
 		}
 
-		can_skb_prv(skb)->ifindex = dev->ifindex;
-
+		csx->can_iif = dev->ifindex;
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 		/* perform proper loopback on capable devices */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 38452069dea8..f102d17e8619 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -323,7 +323,7 @@ static void bcm_can_tx(struct bcm_op *op)
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
@@ -1357,7 +1357,7 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 		return -ENODEV;
 	}
 
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 	err = can_send(skb, 1); /* send with loopback */
diff --git a/net/can/gw.c b/net/can/gw.c
index 8894ab5d2087..ad89a1913b34 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -505,7 +505,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 
 	/* is sending the skb back to the incoming interface not allowed? */
 	if (!(gwj->flags & CGW_FLAGS_CAN_IIF_TX_OK) &&
-	    can_skb_prv(skb)->ifindex == gwj->dst.dev->ifindex)
+	    csx->can_iif == gwj->dst.dev->ifindex)
 		return;
 
 	/* clone the given skb, which has not been done in can_rcv()
diff --git a/net/can/isotp.c b/net/can/isotp.c
index c4fb8afde165..01ceb3febbb7 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -237,7 +237,7 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	}
 
 	can_skb_reserve(nskb);
-	can_skb_prv(nskb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
@@ -794,7 +794,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
@@ -1030,7 +1030,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index fc28a7677369..f03bae79354e 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -904,7 +904,7 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = ndev->ifindex;
+	csx->can_iif = ndev->ifindex;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 0514f3504e39..96e02ad4a726 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -608,7 +608,7 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	csx->can_iif = priv->ndev->ifindex;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
@@ -1549,7 +1549,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	csx->can_iif = priv->ndev->ifindex;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
diff --git a/net/can/raw.c b/net/can/raw.c
index 03438e9bc535..7c89962ec913 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -965,7 +965,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	csx->can_iif = dev->ifindex;
 
 	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);

-- 
2.51.0


