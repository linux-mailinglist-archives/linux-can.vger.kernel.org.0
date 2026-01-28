Return-Path: <linux-can+bounces-6379-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O1KAjaRemmz7wEAu9opvQ
	(envelope-from <linux-can+bounces-6379-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 23:44:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C3BA9B6D
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 23:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB7363007B0B
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 22:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320AF344D97;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSE4jVrs"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05633B97F;
	Wed, 28 Jan 2026 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640239; cv=none; b=AxuR3SRqCWGvDlz8Bhm1+oNM7djHvF/BzUnt1vkBqBgiJdpPAJYk+Q5U5q5KfR3sfyU80cdN8I4qcuvItvqDzO8UqP+u1LoAlurl39U3qWsDB0STU1Kjo5FrWIA/2CNsMtmcoyh1ZG8rjWH+Fu+tU3hwGuLJksq1fRVmWpVx13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640239; c=relaxed/simple;
	bh=A8Y95cIZzFvWVjH45Sxd0GExqdcv5RCCwYFa4OLk9gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AIPzkPJZKQ6Juoid+slty1um1RkHnH4a16J3b2hxix4ORJk+OmVGYX0REKI6NBuen86et485lw5xHBqHGyU67gC6fc8x5RNELRm0B8iK7AjeV1+MYtT/L2oUcfi29QmakbXmyzJmBIi/uNMEaUe+0ZDO2HEdHa1HbnWZUM7M/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSE4jVrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB935C116C6;
	Wed, 28 Jan 2026 22:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769640238;
	bh=A8Y95cIZzFvWVjH45Sxd0GExqdcv5RCCwYFa4OLk9gs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WSE4jVrsYb9qm4TzE9DpPJmfELHQFIArQjZotCy4JW6eQ6QiOTAf2vqIAP+cOR7rY
	 gTMIbAxLZld+dwlv/GLB1696NsBNCpDsioi+ztb/fQqiDNEKR5GdOw+U/CNvXG8fC2
	 X0tVt7J9STTZS1ztTRAdcPSzE3C/zLoGlR/WHJCOd5CoqHVprGNu29IoB6x07Gh6ba
	 UR7x2wd2aQac38E92DuIGobYldFInIioSmofbgQh9hiy9AZKgLOG6KF6H+mTubwnR+
	 EhVZgtlmy6na2oJbaevCMq1fDr2KF5VLB9/uPTT0SOKfOHpIkPesFI1dicNTlRJdUq
	 mamMk2vWJWz7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4CBD46C0B;
	Wed, 28 Jan 2026 22:43:58 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 28 Jan 2026 23:43:40 +0100
Subject: [PATCH net-next V4 1/6] can: use skb hash instead of private
 variable in headroom
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-can_skb_ext-v1-1-330f60fd5d7e@hartkopp.net>
References: <20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net>
In-Reply-To: <20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net>
To: netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769640237; l=10090;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=E4e8dOL3zmqPc+BMmBQud5fi2OKVGv6tcA1PZWmJZSo=;
 b=CE02XMXI5Lep7VKlv9aTDfuMcXIVBCmxi1FmJ4PGoOoLyHTvKx+lg6nPfHC685lsUECsaLM6M
 /qVHZUexaWXCzt+HcgG+CgGtSut1rJW5v1LWxCHU1dqJhbuBlodTfDm
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-6379-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Queue-Id: 34C3BA9B6D
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
index 3ebd4f779b9bdf9d0ce1d1b22b3ccdea2c8e841b..0da615afa04de7c3df16c189ef8c7c1664d1a681 100644
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
index 5fb8d0e3f9c1d027a2d5cd7c4eec7f2fa0340ed4..5c382ed6175578b0bea0ca172f41ce7e48da0442 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -56,8 +56,9 @@ extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      canid_t can_id, canid_t mask,
 			      void (*func)(struct sk_buff *, void *),
 			      void *data);
 
 extern int can_send(struct sk_buff *skb, int loop);
+extern void can_set_skb_uid(struct sk_buff *skb);
 void can_sock_destruct(struct sock *sk);
 
 #endif /* !_CAN_CORE_H */
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 1abc25a8d144e891c9a54cb8171ec44b25b83602..869ea574a40a194b27081ae5eeed701f91ec69c4 100644
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
index 770173d8db42813d5c085248d1bcf5fbe717955b..70659987ef4d27fc25aaecf01302306d3f7494d0 100644
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
index 7eba8ae01a5b1bb06fb745b6e656fa23b3935fd6..8ed60f18c2eaff7053cb2c76e5e4cf1124dd3ac5 100644
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
index ce588b85665a05a28aa499e72ce5db32ecb66126..4bb60b8f9b96188a328e77be2fdefcb879da1089 100644
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
index ff9c4fd7b4337a0ba8fa6846be4a9da35c232049..1589e8ca634ecc2b59eb0c2a1e48f546fafccbe0 100644
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
index 8656ab388c83e68b7f779b7bc0ac97a8d0d009e5..d5d3e5320f7ac5fb247756f6413ab448c75447f6 100644
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
index 12293363413ce6906b068e45d000d188836f6a91..fb4f9c854df04d90ed6bd4601c616ac39bb85ad9 100644
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
2.47.3



