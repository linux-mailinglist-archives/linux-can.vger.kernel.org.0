Return-Path: <linux-can+bounces-6045-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 718F6D04C1F
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 18:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0E135715D6
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD276223DE7;
	Thu,  8 Jan 2026 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="G8mIaMpX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="O54W51XR"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BCD23F424
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888477; cv=pass; b=G98gy/SxdiBfB5CG8EBGRORlXJsVyvpk8DXt+VqliLiUYJgyR/aQVSNUodW2fmN5m6gzIMpla52j3P9drmGnF2FHBQP52JkP43UdX3iILSis/QzCVTrzp1kwMcUir5jLWybM4StT+3Y3C7ibS2XlLgT+7rb2kQ5nMEWP7vRgfSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888477; c=relaxed/simple;
	bh=Qzys3wwlvEeoja1jADGIEbuagJ/pHS0P1gbiYsGNMjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+MyHPW+FISN5u6d5yBD+vEAdd9RVxQpac4BhJ4AOlu3CDM9KMaJFYFWtYpwQ755n4E67VosSaNjgEKtwTOcqFnwsPk5Olr8oAjfugdcuotgqHTILtrYqJ5XPQl6GZ+9Gt8AUX8YzprO30SVXtx8jVSxkycOQwLTsVNhlT5KQA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=G8mIaMpX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=O54W51XR; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767888454; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lsDL8UNqZcRvivPuk/zfHj0WoLlY9K0HkTUwaiNsfI1Xduvx1UexNOvqp0w6uHrjPr
    MN9C9yB69+BBtxcb6kMJ9OmJoxZXe0HYmFNnTUsypmWp8gtfyIWCF6llG4xK03okw6+7
    5VAxbFvda4s3h8a7lx2y+aPSt5zKPNK3XghR1R8Ze31WTZQ5MDKqzkN8jvlbsRj/jPdi
    W7IkoV2lEwwqu8lIPPaeyWofHQR5iCC7ZZDqdoDNs4PLotUoDC9hTzNcMrlj8cI3tEyx
    uRWMFPAqUIGDULBTryUHOxiFW8eLlNCSrI7NUq2X9Bqoepy3o9EMhy+sK4q68kxmqeSs
    EoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767888454;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=stnoAQvmg0aplgHTEMvNQPL6of3M0h6zgZcXkDz6yys=;
    b=Mh2PQ1DuXd3NmbIYFkGNzEJwzXiOi0lf94XxsVMU4iiNK/q5MuqBGzXiPtULjQfEL0
    Ipg7M6ct/q9fotbzbc+JsVn4ApmZ8uPuDHLkGAnMncxKrqzSYGbvPSXEqMrCGsdvigq2
    rtbxOiPooO4XgNufTVG6qH6IVORG5ocrZKux83dkIjwX/csUdfufvz334PpsZ88sArSZ
    o7cCZcD2Vjfa1TGzCMGHWPNbErqwY4Q4KMEOiGommFGjZ0gDhgZHoGhONBDAf4JV5PL5
    HNM7+dpHF7u8fGg+v6WE2GA5szl1hvfLqkIJEBrjMoSFjBzHIiNeS/zqQ98+CdieXtWu
    mtmw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767888454;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=stnoAQvmg0aplgHTEMvNQPL6of3M0h6zgZcXkDz6yys=;
    b=G8mIaMpXYbFD+kUJnheNORy5atae+TBc+mPM764F99QVkN+bHOR4meO2b2Z9ioFId/
    CDiPyNfTCpcF5buZjFo7JBaZjneAyXMx2P3SmwjSKnsVCN7JIO0Y9v/KEMjbotlYh3/g
    inWRUH1/nYAjoJzf61MdmHJQLYLHFJPTFniHSfTsCPRha5dI7ZhVeqSNaWBJB+JngkNO
    npTo+8DxKJIsmEUfDyBqd4bRFWa0iPNBXLdZebwUysA/MYxlXeXw5LSJNZ6U3qEPPPAI
    69Q1d9HJqmHyLyar44w+u+SOUmKjWTSXwpTc8rbtxQfQaI7Nl918Gzb17o0wUkbJo48H
    WbNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767888454;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=stnoAQvmg0aplgHTEMvNQPL6of3M0h6zgZcXkDz6yys=;
    b=O54W51XR7rmXzwTdmc2QB6b4ehuW0XBID8mV4jhduV3wDRcCuukoZ3jTP0Qq9ybou+
    2l88XX3HZFK9sI8J9nDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b208G7YJrB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Jan 2026 17:07:34 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC can-next 3/5] can: move frame length from private headroom to struct sk_buff
Date: Thu,  8 Jan 2026 17:07:14 +0100
Message-ID: <20260108160716.101883-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108160716.101883-1-socketcan@hartkopp.net>
References: <20260108160716.101883-1-socketcan@hartkopp.net>
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
index 4fd5815f601c..2034d51f6225 100644
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
@@ -1082,10 +1083,11 @@ struct sk_buff {
 			__u16	inner_mac_header;
 		};
 		/* protocols without encapsulation */
 		struct {
 			int	can_iif;
+			__u16	can_framelen;
 		};
 	};
 
 	__be16			protocol;
 	__u16			transport_header;
-- 
2.47.3


