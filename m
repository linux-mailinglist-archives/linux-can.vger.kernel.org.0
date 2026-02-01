Return-Path: <linux-can+bounces-6447-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K9v4EUhkf2lNpgIAu9opvQ
	(envelope-from <linux-can+bounces-6447-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 15:33:44 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC42C6251
	for <lists+linux-can@lfdr.de>; Sun, 01 Feb 2026 15:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E2730053F0
	for <lists+linux-can@lfdr.de>; Sun,  1 Feb 2026 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E8534F263;
	Sun,  1 Feb 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klxm7e40"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B101D6AA;
	Sun,  1 Feb 2026 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769956421; cv=none; b=b9amyJFw0dtOcTwLYJSUXHOgwdZ2uQscVmW1jNpoK8/hL6S4Tbf3RBz9YknZoyZZ5+ao+O4hrBUXNlJ15WXGzC40+yEhQ7zXav5wEMBVTGytDUfKnN6k1SHSZg89C5QzBeJFPgo2g74XbtkxLbkKBNI8/gMnaBSmtuW71fh4wI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769956421; c=relaxed/simple;
	bh=JBFIByEVATCHIEF3t0UYW6l3zge4t/kRXZbMpYmFA+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oD3fIwPuYF+mqFa4b/t/XnPvfCTNcAnu3gRoEjrQdTorGx8dl3ZAidKCAmFNdbquHVrzPS85N0peu+oQ3yDW2mvx/Nhb4FI9N66JnufkF52iN6eEvS6dK2epMPG+gcShlaB8oEv5ai42UOEN6pt/fFdAfOmVmVDQr6EWdl9GHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klxm7e40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF628C19425;
	Sun,  1 Feb 2026 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769956420;
	bh=JBFIByEVATCHIEF3t0UYW6l3zge4t/kRXZbMpYmFA+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=klxm7e40fVYbi69rmhtS9lMAVZG+Meekg3ntDj+N8V6zWy2UxgZL/jjGNrg3NeWHs
	 3jVdTmsZ3JkO8zALhHYsj05aRwk9QVur3Cg8uUBxZMJTzmt95b7HA5+YZQjLmvRIlJ
	 5+f/6ADNIr6aWDZSBM5g7Qi34AThY5bKVEF1eeyrFgzVVmehpxzp84Zz/FifjQaQo/
	 BXqjtJi3Mbxas/7MRPBqCnasq5/zEor3W9KR0qzjQYf01Nc4c/AZf/Vohcty8wDyYo
	 1/FS0NCXJviVcoU8lHmxJ+ODWauqWFmsltrgQNy++49IIb0wjUDFfSCJcRI2OdBfpI
	 icoLBt/xJiApQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC84E65283;
	Sun,  1 Feb 2026 14:33:40 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sun, 01 Feb 2026 15:33:16 +0100
Subject: [PATCH net-next v8 1/6] can: use skb hash instead of private
 variable in headroom
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-can_skb_ext-v8-1-3635d790fe8b@hartkopp.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769956418; l=9579;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=zxcFoiKJF2100rOz6zKnSRW+KicEl2DYfMk7Y/gmvbI=;
 b=IbxUJQqwTw/zxIrW9+GY602gKJsLTikmrWFIwwIy8lYGXTt+7mW+ekiEgQYli73h1Qb5oiF0K
 mgt+YPgqIoLAmLHxiNiGyVGaw44LUggTYcDU6+gLAk2vcWdj5iz7i5o
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
	TAGGED_FROM(0.00)[bounces-6447-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 8EC42C6251
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

The can_skb_priv::skbcnt variable is used to identify CAN skbs in the RX
path analogue to the skb->hash.

As the skb hash is not filled in CAN skbs move the private skbcnt value to
skb->hash and set skb->sw_hash accordingly. The skb->hash is a value used
for RPS to identify skbs. Use it as intended.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c |  2 --
 include/linux/can/core.h  |  1 +
 include/linux/can/skb.h   |  2 --
 net/can/af_can.c          | 14 +++++++++++---
 net/can/bcm.c             |  2 --
 net/can/isotp.c           |  3 ---
 net/can/j1939/socket.c    |  1 -
 net/can/j1939/transport.c |  2 --
 net/can/raw.c             |  7 +++----
 9 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 3ebd4f779b9b..0da615afa04d 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -200,11 +200,10 @@ static void init_can_skb_reserve(struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->skbcnt = 0;
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
@@ -310,11 +309,10 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 
 	/* af_packet does not apply CAN skb specific settings */
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		/* init headroom */
 		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 		/* perform proper loopback on capable devices */
 		if (dev->flags & IFF_ECHO)
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 5fb8d0e3f9c1..3287232e3cad 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -56,8 +56,9 @@ extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      canid_t can_id, canid_t mask,
 			      void (*func)(struct sk_buff *, void *),
 			      void *data);
 
 extern int can_send(struct sk_buff *skb, int loop);
+void can_set_skb_uid(struct sk_buff *skb);
 void can_sock_destruct(struct sock *sk);
 
 #endif /* !_CAN_CORE_H */
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 1abc25a8d144..869ea574a40a 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -47,17 +47,15 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
  */
 
 /**
  * struct can_skb_priv - private additional data inside CAN sk_buffs
  * @ifindex:	ifindex of the first interface the CAN frame appeared on
- * @skbcnt:	atomic counter to have an unique id together with skb pointer
  * @frame_len:	length of CAN frame in data link layer
  * @cf:		align to the following CAN frame at skb->data
  */
 struct can_skb_priv {
 	int ifindex;
-	int skbcnt;
 	unsigned int frame_len;
 	struct can_frame cf[];
 };
 
 static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 770173d8db42..70659987ef4d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -639,10 +639,20 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 	}
 
 	return matches;
 }
 
+void can_set_skb_uid(struct sk_buff *skb)
+{
+	/* create non-zero unique skb identifier together with *skb */
+	while (!(skb->hash))
+		skb->hash = atomic_inc_return(&skbcounter);
+
+	skb->sw_hash = 1;
+}
+EXPORT_SYMBOL(can_set_skb_uid);
+
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
 	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = dev_net(dev);
 	struct can_pkg_stats *pkg_stats = net->can.pkg_stats;
@@ -650,13 +660,11 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 
 	/* update statistics */
 	atomic_long_inc(&pkg_stats->rx_frames);
 	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
-	/* create non-zero unique skb identifier together with *skb */
-	while (!(can_skb_prv(skb)->skbcnt))
-		can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);
+	can_set_skb_uid(skb);
 
 	rcu_read_lock();
 
 	/* deliver the packet to sockets listening on all devices */
 	matches = can_rcv_filter(net->can.rx_alldev_list, skb);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 7eba8ae01a5b..8ed60f18c2ea 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -314,11 +314,10 @@ static void bcm_can_tx(struct bcm_op *op)
 	if (!skb)
 		goto out;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
 	/* send with loopback */
 	skb->dev = dev;
@@ -1342,11 +1341,10 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 		kfree_skb(skb);
 		return -ENODEV;
 	}
 
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 	err = can_send(skb, 1); /* send with loopback */
 	dev_put(dev);
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index ce588b85665a..4bb60b8f9b96 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -228,11 +228,10 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 		return 1;
 	}
 
 	can_skb_reserve(nskb);
 	can_skb_prv(nskb)->ifindex = dev->ifindex;
-	can_skb_prv(nskb)->skbcnt = 0;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
 	skb_put_zero(nskb, so->ll.mtu);
@@ -778,11 +777,10 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		return;
 	}
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* create consecutive frame */
@@ -1007,11 +1005,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index ff9c4fd7b433..1589e8ca634e 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -895,11 +895,10 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	if (!skb)
 		goto failure;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret < 0)
 		goto free_skb;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8656ab388c83..d5d3e5320f7a 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -599,11 +599,10 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 		return ERR_PTR(-ENOMEM);
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	/* skb->cb must be large enough to hold a j1939_sk_buff_cb structure */
 	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(*re_skcb));
@@ -1534,11 +1533,10 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 		return NULL;
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
 	session = j1939_session_new(priv, skb, size);
 	if (!session) {
diff --git a/net/can/raw.c b/net/can/raw.c
index 12293363413c..fb4f9c854df0 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -74,11 +74,11 @@ MODULE_ALIAS("can-proto-1");
  * storing the single filter in dfilter, to avoid using dynamic memory.
  */
 
 struct uniqframe {
 	const struct sk_buff *skb;
-	int skbcnt;
+	u32 hash;
 	unsigned int join_rx_count;
 };
 
 struct raw_sock {
 	struct sock sk;
@@ -162,21 +162,21 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 		}
 	}
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
-	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
+	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
 		if (!ro->join_filters)
 			return;
 
 		this_cpu_inc(ro->uniq->join_rx_count);
 		/* drop frame until all enabled filters matched */
 		if (this_cpu_ptr(ro->uniq)->join_rx_count < ro->count)
 			return;
 	} else {
 		this_cpu_ptr(ro->uniq)->skb = oskb;
-		this_cpu_ptr(ro->uniq)->skbcnt = can_skb_prv(oskb)->skbcnt;
+		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
 		if (ro->join_filters && ro->count > 1)
 			return;
 	}
@@ -956,11 +956,10 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!skb)
 		goto put_dev;
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;

-- 
2.51.0



