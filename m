Return-Path: <linux-can+bounces-6201-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0ACD38EA7
	for <lists+linux-can@lfdr.de>; Sat, 17 Jan 2026 14:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BA37300724A
	for <lists+linux-can@lfdr.de>; Sat, 17 Jan 2026 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3792314A95;
	Sat, 17 Jan 2026 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="m7DAGjaJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZLN1ArDF"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68A79DA;
	Sat, 17 Jan 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768656594; cv=pass; b=pNdjJAXnawhSGRIg5NUIks3ltE9SThmG9xPEr7qMitegBrA33Ijy3hzjSaRodjF4az0B+Q5D2mi0a89TR1nioaKnn17elzpO/VZizou32ryqtQqNNYhcrziCmMAG+MhdklQDfYc6fKqiXjWkPS2JmRRc+WTVvj0m7b9n5ICF1hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768656594; c=relaxed/simple;
	bh=XfpGglqFZShKHPV4fhf+9Sg74WWdw6lUrr4R9/S1FUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgAgjtNFUOPn9qEQ55AJh9cPTf/kUVLcza1fpDq8Mg8rkbqFqOOapYR6vewLQx9sCOYWcvGrZbpQOae6etRtW9Ri6pnhninz3sL27xE3ru9yZjpFmEV3C5tkT37jymdiWPMKTGOndTRcLYgV5/yAxsS1yBo50NgdOoDGO5lgOyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=m7DAGjaJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZLN1ArDF; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768656567; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M2rhKPpgIq7Ba48oC7Lcfd6nad6yVaY6Cts6lwnmZc0si9dARi/rqJMESjoxX3vBF2
    5ViVDesSwgkjJGZ20ljgV+oZnn3lTUQPJ8hr4hk0s3Z+fOaH1MzhvO7sTN4QAyYfYjpo
    AYkSCXxBui5bSkq/xX6gnupXsk4JlFR1d8bJmJjsso9H33gjKslvaapsiw4BKchyNLmU
    ftuYkcaEIrw3Pux2OgiFAqJGhpJ0hGjP/STm1qcBkf6bSdkS43xqnU0TCs1hrtJps+vj
    AUYLjnUsrO8MpuXw9Q+EpV3TK0LXL5cD3sgrxHpmJDk+YzwFhFilSug8K8F3zbbCA80+
    AJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768656567;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=A7cLmL5WVyszq6qmRvsRf/Tb3sZ7sHOEHKVrFBKKrWY=;
    b=LPJ2pztJzHxUssoc8DV1p9zIFjAz6AjNYbiwwsa/kyjj2WSohNDcIPwEaWlnEgG9Nd
    ofuoxGxGAndx6gCw858C3odietg9xQp5bTkwT4viic0tb4lzkvAEILRekpEp2V78NnLH
    I43P5HKIgt+VVkBqKQX0+n8Ni/YhJRSxw52psdrbBgbpsI0ynluHdNVnI3dWjwze6SSL
    lW/BcIo56areoiLcK0DcYiuOASW4q35RVF/Rbe9w3r7OFGKscsbdJZli5cXie94hf5Qc
    8X81ErJ3TMrrXyFEHTXVGbRpjBC8+SuSaDEbPeKYW5BAesHOJGf0hUbx4QV8H/pbn634
    r/bA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768656567;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=A7cLmL5WVyszq6qmRvsRf/Tb3sZ7sHOEHKVrFBKKrWY=;
    b=m7DAGjaJJJKsmjWOwnp7xRw3j/SxogfidqoMVtHsFGkgPRFHKiWqjhj6KAWe649dar
    qscVTOgXVUYsv84gb9Acl+TWDUR6cz5eqANrbBRnCrew76sFSWaiqyRgGi7R2iFsDOCW
    vkZZuKK7tIDrK0FjayON2eAIgI41aZB5qdWpsAzMUu0a+Ivg9xQRU5upo8eawPhwTWYD
    gv0KlAlVKaytknIlqFVuZidOS6Zs8TeTz5aSp1d2rd/nZigyUm4axERoL0qrVGWQIEuP
    UZJ0KACnPw6vJX6IEhEhH+t1ZRJ0qN3RR/txiXyeiBAtu08w7tr5XIR2buijy9lJxBw9
    YCAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768656567;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=A7cLmL5WVyszq6qmRvsRf/Tb3sZ7sHOEHKVrFBKKrWY=;
    b=ZLN1ArDF4PRpYikXDeY+fy/FjlL2KRT8veui6xM1IVeceqqLNg7xzW6MnBOLGYNS27
    mqjOZd81q8iEL+fUNyBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20HDTRGS1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 17 Jan 2026 14:29:27 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	davem@davemloft.net,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [can-next v2 3/5] can: move frame length from private headroom to struct sk_buff
Date: Sat, 17 Jan 2026 14:28:22 +0100
Message-ID: <20260117132824.3649-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117132824.3649-1-socketcan@hartkopp.net>
References: <20260117132824.3649-1-socketcan@hartkopp.net>
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

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
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


