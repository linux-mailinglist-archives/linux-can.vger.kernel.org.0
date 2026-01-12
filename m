Return-Path: <linux-can+bounces-6109-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83639D13AEA
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 16:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CD1A30DCF8F
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A9C2E717B;
	Mon, 12 Jan 2026 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="da9I7iDn";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jZE9i/+8"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8172BD5BB;
	Mon, 12 Jan 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230961; cv=pass; b=Xek2S9h+DqGaP73TDIpZchGi3dCBmx349uI49bcKVOISsbxhtJEZdk2QUL3+BuNGbbPwLH+luC4nNMdR2z2LrWshAN2ptzSjkNii1Zl9Ehbi/lv8bCMuxcdE8HuInGvFiDlgjcVnKVJZ4KfeyalKR3j2Y6+19j87hNerpdpd79Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230961; c=relaxed/simple;
	bh=uJmtiOK8DFriHMZfSVTC12QDtuUM9eIDImgslCF02zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqiQFyzcTz9QviwtgVDcb8Q6hiVDJpmGNnrEwhy83jmEFX/8KhWEbx+rdxBdMo96m06fIsvWGX7t30fryEByUuCoGlFLrpzH8JmBYU9lKR3Zp9yfy3z8Lpfznjpgubdei2idHbXNJNQtLnHsZR/K96mLeWEixy5E0R/hdUU1B5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=da9I7iDn; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jZE9i/+8; arc=pass smtp.client-ip=81.169.146.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768230592; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hpv8LoxO4Tc6+6URh3rJu1iHxZJxZt3zNmoNIW+DljyRr+YiO8qKXXszZ9MIMNqGq8
    KrzPrBN/EWw+RqDvjEap38pQG+LFL55hnhM6s+1wn7H1xoZbMGpAT9EeR1AkcdVNep4D
    je2zLIDsR3ROOVyAJlVMObw5Oc6QYyJfBSqbf1hUDnN/XZqYxvs5xbvZa2pW9UZYh7TT
    5q2UO5W+52/u/DBDSiHXhsPdUB6MVjt3rT4incLb8PH8gB6faokSm/pxQ3nDYjkbA3gA
    lpUud8TibrUFE5XVh0H80BtZbYN4eDQ9BKEjvjnC86jpMxQjtJkU09Y5vT6Sk5S6goNo
    hxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768230592;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4MT8r210l9Jk8RJz3zpb115ZfaCRQOIoP0m64w1gI1o=;
    b=MkdznWDIxHkEChnk0CB5vH7tqDWTYWTxn51nTorEfXfihSJP9MjKSW2jaqctCTz/Lv
    LD9N0Q0tZ2yZy+MelHCyRMclrDzj32fyJzvkLB1xO95jg0K3eO6TvWux4E58/ZngfvvA
    xCYu7i0POMjHmi02iF/CIuBQSU8EVsB9gVJvmWG2WG7Mn/4QVT6CKj8jeUb+QXP2v47Y
    K0OvnuInMdTPX9i9M7QMwkmBRvwxwkMp886yXZeUjwnRaESzUzpV7t3jIlYv8F1JCk+6
    L0ZTqQFFnRdmQ0cBsSBSf0idjvycKDV2y6DCW5/jFcLWyWbxlZskbD0Vsvj6t4DxpjQy
    MZ/w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768230592;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4MT8r210l9Jk8RJz3zpb115ZfaCRQOIoP0m64w1gI1o=;
    b=da9I7iDnxer/39xna3duvfktsEu1zvmjnWlmvqKbrNkMdZbJZ0vttaStdfgCumgv72
    BKbRMdtuCzaV1b8jABAFThJacKgec2HSyOZi5rowWLhemAmr7UdEYoffqWqAH1kh9WOE
    tC2T1xWjjBfo6iC0LRhnDySzMQi/m66jcxcNAmXhGrwFkm4vUT5XwN51hiLG7rsJgSRx
    vjyE0aGQVwNE5ZZpGeGJ4qHQkj6DVohfNs4/ZwaF3ecrPhxcemOmRjzwwoYbQxVb/8YV
    vi7ItaPlxSgm00cYm64h9xfMEMe9E1nUmF3pnjGHB+BtVGCdr2j2lM1WbQ2+lKt0GWhz
    cZhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768230592;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4MT8r210l9Jk8RJz3zpb115ZfaCRQOIoP0m64w1gI1o=;
    b=jZE9i/+8E/rzEGewF5M1QkZAfrzDWzAB/2ubK/FNIqjcLQR59HO+dh0F3hlHkOPTfw
    Iczop0sEVPrGh5ckd5Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20CF9qgmC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Jan 2026 16:09:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next 2/5] can: move can_iif from private headroom to struct sk_buff
Date: Mon, 12 Jan 2026 16:09:05 +0100
Message-ID: <20260112150908.5815-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112150908.5815-1-socketcan@hartkopp.net>
References: <20260112150908.5815-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

When routing CAN frames over different CAN interfaces the interface index
skb->iif is overwritten with every single hop. To prevent sending a CAN
frame back to its originating (first) incoming CAN interface another
ifindex variable is needed.

can_iif is the first variable moved into the formerly unused space in CAN
skbs (the inner protocol space for ethernet/IP encapsulation). To make
sure the CAN skb was not crafted e.g. by PF_PACKET including encapsulated
data the received CAN skb is checked for skb->encapsulation to be false.

Patch 2/5 to remove the private CAN bus skb headroom infrastructure.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c |  8 ++++----
 include/linux/can/skb.h   |  2 --
 include/linux/skbuff.h    | 23 +++++++++++++++++------
 net/can/af_can.c          | 21 ++++++++++++---------
 net/can/bcm.c             |  4 ++--
 net/can/gw.c              |  2 +-
 net/can/isotp.c           |  6 +++---
 net/can/j1939/socket.c    |  2 +-
 net/can/j1939/transport.c |  4 ++--
 net/can/raw.c             |  2 +-
 10 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 0da615afa04d..b54474687aaa 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -216,11 +216,11 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 		return NULL;
 	}
 
 	skb->protocol = htons(ETH_P_CAN);
 	init_can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	skb->can_iif = dev->ifindex;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
 }
@@ -239,11 +239,11 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 		return NULL;
 	}
 
 	skb->protocol = htons(ETH_P_CANFD);
 	init_can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	skb->can_iif = dev->ifindex;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
 	/* set CAN FD flag by default */
 	(*cfd)->flags = CANFD_FDF;
@@ -266,11 +266,11 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 	if (unlikely(!skb))
 		goto out_error;
 
 	skb->protocol = htons(ETH_P_CANXL);
 	init_can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	skb->can_iif = dev->ifindex;
 
 	*cxl = skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
 
 	/* set CAN XL flag and length information by default */
 	(*cxl)->flags = CANXL_XLF;
@@ -308,11 +308,11 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 		return false;
 
 	/* af_packet does not apply CAN skb specific settings */
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		/* init headroom */
-		can_skb_prv(skb)->ifindex = dev->ifindex;
+		skb->can_iif = dev->ifindex;
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 		/* perform proper loopback on capable devices */
 		if (dev->flags & IFF_ECHO)
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 869ea574a40a..679ea4c851ac 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -46,16 +46,14 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
  * skb_copy() needs to be used instead of skb_clone().
  */
 
 /**
  * struct can_skb_priv - private additional data inside CAN sk_buffs
- * @ifindex:	ifindex of the first interface the CAN frame appeared on
  * @frame_len:	length of CAN frame in data link layer
  * @cf:		align to the following CAN frame at skb->data
  */
 struct can_skb_priv {
-	int ifindex;
 	unsigned int frame_len;
 	struct can_frame cf[];
 };
 
 static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d..ab415de74466 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -861,10 +861,11 @@ enum skb_tstamp_type {
  *	@reserved_tailroom: (aka @mark) number of bytes of free space available
  *		at the tail of an sk_buff
  *	@vlan_all: vlan fields (proto & tci)
  *	@vlan_proto: vlan encapsulation protocol
  *	@vlan_tci: vlan tag control information
+ *	@can_iif: ifindex of the first interface the CAN frame appeared on
  *	@inner_protocol: Protocol (encapsulation)
  *	@inner_ipproto: (aka @inner_protocol) stores ipproto when
  *		skb->inner_protocol_type == ENCAP_TYPE_IPPROTO;
  *	@inner_transport_header: Inner transport layer header (encapsulation)
  *	@inner_network_header: Network layer header (encapsulation)
@@ -1067,17 +1068,27 @@ struct sk_buff {
 		__u32		mark;
 		__u32		reserved_tailroom;
 	};
 
 	union {
-		__be16		inner_protocol;
-		__u8		inner_ipproto;
-	};
+		/* inner protocol data for eth/ip encapsulation */
+		struct {
+			union {
+				__be16	inner_protocol;
+				__u8	inner_ipproto;
+			};
 
-	__u16			inner_transport_header;
-	__u16			inner_network_header;
-	__u16			inner_mac_header;
+			__u16	inner_transport_header;
+			__u16	inner_network_header;
+			__u16	inner_mac_header;
+		};
+
+		/* space for protocols without protocol/header encapsulation */
+		struct {
+			int	can_iif;
+		};
+	};
 
 	__be16			protocol;
 	__u16			transport_header;
 	__u16			network_header;
 	__u16			mac_header;
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 70659987ef4d..37be7e4921c8 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -685,13 +685,14 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 }
 
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_can_skb(skb))) {
-		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
-			     dev->type, skb->len);
+	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+		     !can_is_can_skb(skb) || skb->encapsulation)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d, encap %d\n",
+			     dev->type, skb->len, skb->encapsulation);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CAN_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
@@ -700,13 +701,14 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 }
 
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) {
-		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
-			     dev->type, skb->len);
+	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+		     !can_is_canfd_skb(skb) || skb->encapsulation)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d, encap %d\n",
+			     dev->type, skb->len, skb->encapsulation);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CANFD_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
@@ -715,13 +717,14 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 }
 
 static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canxl_skb(skb))) {
-		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
-			     dev->type, skb->len);
+	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+		     !can_is_canxl_skb(skb) || skb->encapsulation)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d, encap %d\n",
+			     dev->type, skb->len, skb->encapsulation);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CANXL_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 8ed60f18c2ea..a8867e7b77d2 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -313,11 +313,11 @@ static void bcm_can_tx(struct bcm_op *op)
 	skb = alloc_skb(op->cfsiz + sizeof(struct can_skb_priv), gfp_any());
 	if (!skb)
 		goto out;
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	skb->can_iif = dev->ifindex;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
 	/* send with loopback */
 	skb->dev = dev;
@@ -1340,11 +1340,11 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 	if (!dev) {
 		kfree_skb(skb);
 		return -ENODEV;
 	}
 
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	skb->can_iif = dev->ifindex;
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 	err = can_send(skb, 1); /* send with loopback */
 	dev_put(dev);
 
diff --git a/net/can/gw.c b/net/can/gw.c
index 55eccb1c7620..74d771a3540c 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -497,11 +497,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		return;
 	}
 
 	/* is sending the skb back to the incoming interface not allowed? */
 	if (!(gwj->flags & CGW_FLAGS_CAN_IIF_TX_OK) &&
-	    can_skb_prv(skb)->ifindex == gwj->dst.dev->ifindex)
+	    skb->can_iif == gwj->dst.dev->ifindex)
 		return;
 
 	/* clone the given skb, which has not been done in can_rcv()
 	 *
 	 * When there is at least one modification function activated,
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 4bb60b8f9b96..e7623e5736ca 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -227,11 +227,11 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 		kfree_skb(nskb);
 		return 1;
 	}
 
 	can_skb_reserve(nskb);
-	can_skb_prv(nskb)->ifindex = dev->ifindex;
+	nskb->can_iif = dev->ifindex;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
 	ncf = (struct canfd_frame *)nskb->data;
 	skb_put_zero(nskb, so->ll.mtu);
@@ -776,11 +776,11 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		dev_put(dev);
 		return;
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	skb->can_iif = dev->ifindex;
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* create consecutive frame */
@@ -1004,11 +1004,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		dev_put(dev);
 		goto err_out_drop;
 	}
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	skb->can_iif = dev->ifindex;
 
 	so->tx.len = size;
 	so->tx.idx = 0;
 
 	cf = (struct canfd_frame *)skb->data;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 1589e8ca634e..d2642d86b4a9 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -894,11 +894,11 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 				  msg->msg_flags & MSG_DONTWAIT, &ret);
 	if (!skb)
 		goto failure;
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = ndev->ifindex;
+	skb->can_iif = ndev->ifindex;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (ret < 0)
 		goto free_skb;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index d4be13422f50..8a767b75194f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -598,11 +598,11 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 	if (unlikely(!skb))
 		return ERR_PTR(-ENOMEM);
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	skb->can_iif = priv->ndev->ifindex;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	/* skb->cb must be large enough to hold a j1939_sk_buff_cb structure */
 	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(*re_skcb));
@@ -1532,11 +1532,11 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	if (unlikely(!skb))
 		return NULL;
 
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
+	skb->can_iif = priv->ndev->ifindex;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
 	session = j1939_session_new(priv, skb, size);
 	if (!session) {
diff --git a/net/can/raw.c b/net/can/raw.c
index d276eb92ea81..21432e5567fa 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -953,11 +953,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		goto put_dev;
 
 	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
+	skb->can_iif = dev->ifindex;
 
 	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
 		goto free_skb;
-- 
2.47.3


