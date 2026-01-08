Return-Path: <linux-can+bounces-6043-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14722D04627
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 17:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99303308C056
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFD127AC28;
	Thu,  8 Jan 2026 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fc26pdJT";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F0vPw5qj"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A721A256E
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888473; cv=pass; b=emWN0roz1v+DGg444bgn4ZWua6vMcSEEeQq7DVNTzhqmJdyZfvWFKpj2ed4YpfNwG9Y8xLHOWu+xEATa54JmQATNGy/vM7LGDsq67q84FKBzaX14jNiVHsS6D44Af4Gbkl0Kg+mRQf5Zw9Llgx+iI4B0ZZae6P1zC5uxUt/bk+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888473; c=relaxed/simple;
	bh=+2Q6nKMVI0AlwdefhI5R1cJ9d9LjhFo3ywtAU88N8BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNlQe7n0H+Mp02Vpp0X4mHkOFQd2tg/2lQe0ZE6g2lfvo+aAey/GCJb9bxqoD7bTpGMpql65AnPWK9ldXoxWqMcnMwCQHBTibem66Q3btBh9L4B0YWPYNHAGj4vVmD5YunnhWROpGStYEO8RTJI3rss+pwS8y+unSkn7Jss9m3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fc26pdJT; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F0vPw5qj; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767888455; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ByPvzSwgKcnMBlIF9OvKL4fK+IJOZEwusYsgMhpau3x2XP3fypF1ulBo6y1B/EkzLw
    zqgTUFd7lVtZznybify1/3hYpmNKw0B5x+IX5QS2CFLhGBD5eUUaMS/3UOCw4YXYGkuR
    +engJfFeO2ITvbFIfkshT+KQjiaeEzpg1/r9KgxTf4lCjRYhUOxK7Mu1OZ0TNSDZ+LWZ
    /7CCi87tungSkyNQPrjjJkISWkz7mp73jEBud/mgg9zazsJ/1KoacN8eGn5pr5KhXpne
    nbLYvicRsVMB9dMxHbgD8yJG0ZzRKVdBeoDXGM2qwkFBjv8+uNW5SGCLQ31ZBVmjonQT
    S0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767888455;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=X1GEkADnt0U5UFC85GRFMRBSc/MNJykvoIdv43adZJw=;
    b=ckL9gOqiIBakTN0N6U5Dl9CYUUT0tho5yRYJvEK8CwvTG18HKnf64T6DDl9+sCPXeP
    R6jMmmF0hwycHpBtnztWZQLBm51z2rfIHPmfYxnh6l4jtoUancDcxwEt05nNMjVZdGtA
    5kVOgEPQbJkbXWDKjlTOtfClfjbGPBXyoWMfuiQnlRxwAG27o0WMoamZdgCcLmmcghTK
    9qgxLqLEHdUFVERaJFvFIcLBrghSj9qBiMFB+mN/OFlImkk/6vpSZPZOjjtvKgG4W79Y
    2znu1I1wvjB48bO3aYBsr0Ucv7pNu8N7ufJK87ebr+rF6u1VCVzlXbLUqiVU+uXA7s1j
    bsfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767888455;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=X1GEkADnt0U5UFC85GRFMRBSc/MNJykvoIdv43adZJw=;
    b=fc26pdJT3KMacUNRm1EeX7LWyLWzMzBGjbUoHoKu7SVN4aFneya8ALvZUM+GoP9FnY
    UcIMD9QyPV+17GpAh4xFmclftYAX3oyTxLF1KLYdCOduQDu3L85Q3uXcdmPb6071VdLS
    VzR5SiX+p2351dXPziifmk7+Hcah0Glo1blMi2qD1Y2vgLmi6ogyjJq7hZyhdLIRCo1v
    fgHG2Ls0m6HGo1e6kZv6i/HhEzsh5r1bBBK/RkY4P2u9UK/biqvNBOFoviszor5aMSxC
    m0WmSux362MJUgjJrUvlF3QnowOl6y6iAG92n3qUoyumbyH9JoHpL80wgKOEs6ej8mQG
    xaQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767888455;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=X1GEkADnt0U5UFC85GRFMRBSc/MNJykvoIdv43adZJw=;
    b=F0vPw5qjzlms3L9RCAL65eZtYqhPVM5Gv52MZvmjWTLPR1LPxo8RcOLRd7A23lW4iL
    EpgRCLYPH28eRC9E27Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b208G7YJrD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Jan 2026 17:07:34 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC can-next 5/5] can: gw: use new maxhops variable instead of re-using csum_start
Date: Thu,  8 Jan 2026 17:07:16 +0100
Message-ID: <20260108160716.101883-5-socketcan@hartkopp.net>
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
 include/linux/skbuff.h |  2 ++
 net/can/gw.c           | 23 ++++++-----------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2034d51f6225..f09ce43cc05f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -863,10 +863,11 @@ enum skb_tstamp_type {
  *	@vlan_all: vlan fields (proto & tci)
  *	@vlan_proto: vlan encapsulation protocol
  *	@vlan_tci: vlan tag control information
  *	@can_iif: ifindex of the first interface the CAN frame appeared on
  *	@can_framelen: cached echo CAN frame length for bql
+ *	@can_gw_maxhops: can-gw CAN frame time-to-live counter
  *	@inner_protocol: Protocol (encapsulation)
  *	@inner_ipproto: (aka @inner_protocol) stores ipproto when
  *		skb->inner_protocol_type == ENCAP_TYPE_IPPROTO;
  *	@inner_transport_header: Inner transport layer header (encapsulation)
  *	@inner_network_header: Network layer header (encapsulation)
@@ -1084,10 +1085,11 @@ struct sk_buff {
 		};
 		/* protocols without encapsulation */
 		struct {
 			int	can_iif;
 			__u16	can_framelen;
+			__u16	can_gw_maxhops;
 		};
 	};
 
 	__be16			protocol;
 	__u16			transport_header;
diff --git a/net/can/gw.c b/net/can/gw.c
index 74d771a3540c..c7811b9c8e5a 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -68,12 +68,12 @@ MODULE_ALIAS(CAN_GW_NAME);
 
 #define CGW_MIN_HOPS 1
 #define CGW_MAX_HOPS 6
 #define CGW_DEFAULT_HOPS 1
 
-static unsigned int max_hops __read_mostly = CGW_DEFAULT_HOPS;
-module_param(max_hops, uint, 0444);
+static unsigned short max_hops __read_mostly = CGW_DEFAULT_HOPS;
+module_param(max_hops, ushort, 0444);
 MODULE_PARM_DESC(max_hops,
 		 "maximum " CAN_GW_NAME " routing hops for CAN frames "
 		 "(valid values: " __stringify(CGW_MIN_HOPS) "-"
 		 __stringify(CGW_MAX_HOPS) " hops, "
 		 "default: " __stringify(CGW_DEFAULT_HOPS) ")");
@@ -472,23 +472,12 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	}
 
 	/* Do not handle CAN frames routed more than 'max_hops' times.
 	 * In general we should never catch this delimiter which is intended
 	 * to cover a misconfiguration protection (e.g. circular CAN routes).
-	 *
-	 * The Controller Area Network controllers only accept CAN frames with
-	 * correct CRCs - which are not visible in the controller registers.
-	 * According to skbuff.h documentation the csum_start element for IP
-	 * checksums is undefined/unused when ip_summed == CHECKSUM_UNNECESSARY.
-	 * Only CAN skbs can be processed here which already have this property.
 	 */
-
-#define cgw_hops(skb) ((skb)->csum_start)
-
-	BUG_ON(skb->ip_summed != CHECKSUM_UNNECESSARY);
-
-	if (cgw_hops(skb) >= max_hops) {
+	if (skb->can_gw_maxhops >= max_hops) {
 		/* indicate deleted frames due to misconfiguration */
 		gwj->deleted_frames++;
 		return;
 	}
 
@@ -517,15 +506,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		gwj->dropped_frames++;
 		return;
 	}
 
 	/* put the incremented hop counter in the cloned skb */
-	cgw_hops(nskb) = cgw_hops(skb) + 1;
+	nskb->can_gw_maxhops = skb->can_gw_maxhops + 1;
 
 	/* first processing of this CAN frame -> adjust to private hop limit */
-	if (gwj->limit_hops && cgw_hops(nskb) == 1)
-		cgw_hops(nskb) = max_hops - gwj->limit_hops + 1;
+	if (gwj->limit_hops && nskb->can_gw_maxhops == 1)
+		nskb->can_gw_maxhops = max_hops - gwj->limit_hops + 1;
 
 	nskb->dev = gwj->dst.dev;
 
 	/* pointer to modifiable CAN frame */
 	cf = (struct canfd_frame *)nskb->data;
-- 
2.47.3


