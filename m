Return-Path: <linux-can+bounces-6048-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBCCD04F37
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 18:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23159322D17C
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4162D77F1;
	Thu,  8 Jan 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nH8Q0Laf";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="9ig+AE1Y"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B11F4C8E
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889915; cv=pass; b=ARExD5/topCD/t5TZBuPr8fMyOgH4DSPGkacEuuchMUHbxL5uQoOoSwag4oByzf1JcW5NJ8xWKecC+arien6OoRubsP+TPIbJWNKnzmdlRRki8DbVtdlUKTp9W8aNzxAgWvFG30hD8HSXyt5Bx/tLhAcZaAHcZWNHdqmpVy2hwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889915; c=relaxed/simple;
	bh=GM50XlaomfrTJpO5ZczsUsTQPkWPHrEqTeVx9r8JCI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qn88aUpwtapY2PjTT1EyUb+LibncPh4JM8FsrY2cN403l347vHZNfjaxCtcVAU4uj7d1cCWmOUV5P08+Kt4n5vVp/PCPz35zCqhknR+PQqSbWsfrnZy0mghFGV3f7yKJNpbrP1iBkcoxOGSzyQru8ZEmDka1mPPnSze/3I1hihU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nH8Q0Laf; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=9ig+AE1Y; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767888454; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y3EdWgmJRk1M6zZQw7Sfur6zRIN/IaqNS6QwdvrzJqCnznzKH78R3HFFSPfNvMYL1N
    O0DZRklVxFkQcch3oaN1gVh+4GRtS4ogx4Wa8r+FX0ZrG99l1go22oDv+3XvqUaM+K1C
    exaqR2yxE2zn/vjrcK6QGL9XLCT6YzREinwQqxk5u58CmZblOLVNKsQz7xl6HElAUCfM
    bHkBJbH61DoJh1JizDQlLl0gTIIlUJnhrrvkv+jtE/7aO4PCweeiVUdLbV2EWcuVzDwg
    98EMrhZ0DmIV5PI0heSVsbyPsZaBkgqbumiEza522skUYjY14P210rXQ2bdZbEWjcb6u
    +8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767888454;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ID5O4vM4CMCIFR3sDsgOTEzKYORtSKhTrrFXDjQCyi4=;
    b=aQ6Qjj2NXPFPr7zVmVmRPlf9gAmCdhfZsGKo/L+FM6fKznM3L0LFBF3zmF1uBOTQzB
    VPmevrvTG5S5mKwESvxu8JTbVlLcuw2GyWGhdttpsf8/9Mi6oqZGzpGhMnvDOIbrQ7s0
    1nZp2dgY6RsSPuw6Uoh0nJxGds9biiAfH5CS2hjPtjZDKmFMlvHqOBxGt9YNmz1zrwQx
    HGO/d3tnjYZRuyaWaWR3HuikJW2hCiCrF0uHJAUeI74qlImbXMdVe9KiiBuRbam9xD4B
    wD1RYJE87Zcu/iwbO0rvgC/izieFS/3qALlR5GLw6V5yhANZXnPiF5FTEHS5co7I5r/m
    Uqlg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767888454;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ID5O4vM4CMCIFR3sDsgOTEzKYORtSKhTrrFXDjQCyi4=;
    b=nH8Q0Laf8Wj4PIogkrjD6Mr5xjrBzRoRgIy2GNWzvh+FYxRQV860liBuWFpYLPQ43Q
    CGfUsWzQwWBjUVadHWNuhuKHCffv+IBsPH4LBvEOOiH38/oF3W7O/qOgZlbw446LoDRI
    46L7E1038/yQGIgkYUznWw8c4gZuebj7JuI7LKHFwmu8unwwUl2i7oZnWe1fozWUPGUU
    8DNz8N4qGQtbiWS6qyWQ0SVCrQJD+bSBrpkxefCPwnB10xrOGX48TugLRxFNOk7s6hGD
    YnghwyI6Ad2uo0rDFFU2KpTckFd0ubCIRXMe+4evE2Evt8uQ9u4oRjjAjskwWcLR/3Pj
    qhbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767888454;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ID5O4vM4CMCIFR3sDsgOTEzKYORtSKhTrrFXDjQCyi4=;
    b=9ig+AE1YsE5OB9I0hKhqCsm2C6m2SOqnJpo5StUCquZZnlwb6C26Kfv2dd24GW/gKq
    /PpFgBXpIMXPviZ8I5Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b208G7YJr9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Jan 2026 17:07:34 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC can-next 1/5] can: use skb hash instead of private variable in headroom
Date: Thu,  8 Jan 2026 17:07:12 +0100
Message-ID: <20260108160716.101883-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

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
index 5fb8d0e3f9c1..5c382ed61755 100644
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
index 613a911dda10..d4be13422f50 100644
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
index be1ef7cf4204..6accae6c0070 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -74,11 +74,11 @@ MODULE_ALIAS("can-proto-1");
  * storing the single filter in dfilter, to avoid using dynamic memory.
  */
 
 struct uniqframe {
 	const struct sk_buff *skb;
-	int skbcnt;
+	__u32 hash;
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
@@ -987,11 +987,10 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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


