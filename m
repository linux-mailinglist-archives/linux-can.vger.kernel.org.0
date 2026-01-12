Return-Path: <linux-can+bounces-6110-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60855D13BFF
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 16:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECE583047914
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFFE35FF5D;
	Mon, 12 Jan 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JinrC2zI";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="33BjzlsB"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209835FF70;
	Mon, 12 Jan 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232045; cv=pass; b=Oyl4I4d2Pzm2cZBMVWQa3JM5JAFLrQltT9plgCjiVQMSkTXzQfUQBPiwiiV3rlICCP3xVQpFX7VtUzn05fOvfNxSYKtIM7uahl+wwMjqqApyOR8LfIA9u3XFnSmYR00gcl1Jsz+ysdjQZw3TwuLKY2M9SHDSZT3cgK+rz9MK+Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232045; c=relaxed/simple;
	bh=C7FvQg+AopZifk++L/E2B7u5t+pz1XdOsyeZnNX4SO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMGWjK+flBmwwo9C3h+RzUpPOKeechmL0Z0/lITuMRh35+NU7uYKhsw+Ukz3e5KRp9BBQtoP7Ii316/W4DWF8/BOG7Jpywep3qSThSnXUKsMofkYlvXtbMQ9IFQSM+ZGviZn2lxsap7QjwRe5dXQJomPBfSr3XkBkAhQRvx0miM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JinrC2zI; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=33BjzlsB; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768230593; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qeWZfCzJcD0iszE4j3rxD/o2IFJsNtOCFFnQaSXIrs0VIc663wsevD8UXa1h2rYnpz
    s+dzKTVnuVqFO4dZa6Symzf+6rgjuoahE47RCCFocktSQLy7g8Bfa/0pF79HCBXTBNTU
    rAKmhGMo3IKDWwunOrTGWtIfJrjz40/pI6IKID/PRdKPbqV7QGXt0XKaM8zqGO25mKet
    Corwyj4n6iYvTUUR1eGW2B7uN7HefbBdBf7SBjjXMmslsEZ+WbwXDkp+THicWisWpCb7
    9Dis/3uuKbLoZNzs8mPMvbE8XXf5/6uPJIW/rLjDmVNGp3U0I4V8zoM7w0dkOsXApBY3
    JSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768230593;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Zhd2KxCDT5ihiIhONZgPDInEUj+vwJojk/3QUJ2S0es=;
    b=PpqSutqmKB8Zi5W9bjz1aEP6iDcEb6wwVFqDIRPIlZ0h9nZNSQ8Uw13bi+O4PAG1Go
    jn55aT+ka2NtGl72/y56pO58DZz7Ilytf69HwoCwyHpJhV0WqeRliwevyhWVIi+iDOIo
    W5QrnZjtuN/0K2oMEKf7H2hQnd8BXI9R9hM79k5pD2edsTGkdAT2IkaVPvrdegEJYVrX
    YVvS80CxzUVc6aDQl4gwE0WWPUm7FMjy1qqZYP3Xl4/5wBlcuJQgmQgyqQnnjjokwkHV
    fL/lKVYNA5oqvJ10sf7DwSmccYV3UHo5sSenH5RF9toYEiZLg/zjlhw8yo3mhmgiGS9p
    hMSg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768230593;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Zhd2KxCDT5ihiIhONZgPDInEUj+vwJojk/3QUJ2S0es=;
    b=JinrC2zIwvuxRSTNjpWaPxT1LHkMkCMLSI55xoBZrAcC+DV3/6i3qVM8rUSNKSa0eV
    ceUeXMZrT7y5s5U78n4wXDy+/7u0JgZ5knHzqsDh87wgVYb1GgKxMeUiiAiorK81DHTx
    CWjNr5fR8e0eLRyVVPD/ITcH3UvwhPAH2a1aPUPZhJwVb7TRn8Us+BBrssqcWgtrMb52
    SHX4OKGlHZBlcnCEcSwPYnigcjhhahrh/mao+4aLMqWtg33aegltAxNjC9lKhMLD0TDg
    HaZwWuNJwUnpSJZdYaSwOEaNnYVoHeBiuy/5U3cJxa6wNo+72dE1ppVp+B0a4nvhLbDK
    iTBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768230593;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Zhd2KxCDT5ihiIhONZgPDInEUj+vwJojk/3QUJ2S0es=;
    b=33BjzlsBnFhk2vhnnnh4m1yZfmUh7Sx4lg6BS2emKua7FpcvVIOqVhmdndD/CiZqYP
    7HGVKseaNCRiVEnJ57Ag==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20CF9qgmD
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
Subject: [can-next 3/5] can: move frame length from private headroom to struct sk_buff
Date: Mon, 12 Jan 2026 16:09:06 +0100
Message-ID: <20260112150908.5815-4-socketcan@hartkopp.net>
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

The can_skb_priv::frame_len variable is used to cache a previous
calculated CAN frame length to be passed to BQL queueing disciplines.

To maintain a compilable migration step the frame_len value in struct
can_skb_priv is only renamed but not removed.

Patch 3/5 to remove the private CAN bus skb headroom infrastructure.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/skb.c | 8 +++-----
 include/linux/can/skb.h   | 3 +--
 include/linux/skbuff.h    | 2 ++
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index b54474687aaa..ffd71ad0252a 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -72,11 +72,11 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		/* make settings for echo to reduce code in irq context */
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		skb->dev = dev;
 
 		/* save frame_len to reuse it when transmission is completed */
-		can_skb_prv(skb)->frame_len = frame_len;
+		skb->can_framelen = frame_len;
 
 		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
 		skb_tx_timestamp(skb);
@@ -109,20 +109,19 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx,
 	if (priv->echo_skb[idx]) {
 		/* Using "struct canfd_frame::len" for the frame
 		 * length is supported on both CAN and CANFD frames.
 		 */
 		struct sk_buff *skb = priv->echo_skb[idx];
-		struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
 
 		if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)
 			skb_tstamp_tx(skb, skb_hwtstamps(skb));
 
 		/* get the real payload length for netdev statistics */
 		*len_ptr = can_skb_get_data_len(skb);
 
 		if (frame_len_ptr)
-			*frame_len_ptr = can_skb_priv->frame_len;
+			*frame_len_ptr = skb->can_framelen;
 
 		priv->echo_skb[idx] = NULL;
 
 		if (skb->pkt_type == PACKET_LOOPBACK) {
 			skb->pkt_type = PACKET_BROADCAST;
@@ -178,14 +177,13 @@ void can_free_echo_skb(struct net_device *dev, unsigned int idx,
 		return;
 	}
 
 	if (priv->echo_skb[idx]) {
 		struct sk_buff *skb = priv->echo_skb[idx];
-		struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
 
 		if (frame_len_ptr)
-			*frame_len_ptr = can_skb_priv->frame_len;
+			*frame_len_ptr = skb->can_framelen;
 
 		dev_kfree_skb_any(skb);
 		priv->echo_skb[idx] = NULL;
 	}
 }
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 679ea4c851ac..eba9557e2c1e 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -46,15 +46,14 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
  * skb_copy() needs to be used instead of skb_clone().
  */
 
 /**
  * struct can_skb_priv - private additional data inside CAN sk_buffs
- * @frame_len:	length of CAN frame in data link layer
  * @cf:		align to the following CAN frame at skb->data
  */
 struct can_skb_priv {
-	unsigned int frame_len;
+	unsigned int frame_len_to_be_removed;
 	struct can_frame cf[];
 };
 
 static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
 {
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ab415de74466..eccd0b3898a0 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -862,10 +862,11 @@ enum skb_tstamp_type {
  *		at the tail of an sk_buff
  *	@vlan_all: vlan fields (proto & tci)
  *	@vlan_proto: vlan encapsulation protocol
  *	@vlan_tci: vlan tag control information
  *	@can_iif: ifindex of the first interface the CAN frame appeared on
+ *	@can_framelen: cached echo CAN frame length for bql
  *	@inner_protocol: Protocol (encapsulation)
  *	@inner_ipproto: (aka @inner_protocol) stores ipproto when
  *		skb->inner_protocol_type == ENCAP_TYPE_IPPROTO;
  *	@inner_transport_header: Inner transport layer header (encapsulation)
  *	@inner_network_header: Network layer header (encapsulation)
@@ -1083,10 +1084,11 @@ struct sk_buff {
 		};
 
 		/* space for protocols without protocol/header encapsulation */
 		struct {
 			int	can_iif;
+			__u16	can_framelen;
 		};
 	};
 
 	__be16			protocol;
 	__u16			transport_header;
-- 
2.47.3


