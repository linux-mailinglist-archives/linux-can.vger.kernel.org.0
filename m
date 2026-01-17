Return-Path: <linux-can+bounces-6204-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70AD38EAE
	for <lists+linux-can@lfdr.de>; Sat, 17 Jan 2026 14:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65A113021043
	for <lists+linux-can@lfdr.de>; Sat, 17 Jan 2026 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4CE33554F;
	Sat, 17 Jan 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="m6cvS+au";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nFAdLJh1"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7052D0614;
	Sat, 17 Jan 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768656595; cv=pass; b=UuleFzbTdN593yFS2cYsFMc5SIiSQSTz+qJF3jIvuB8lvudJwHVLIjL3IYQ0HHcyXRWRz+C0PnbrXmuOi4wQdKzmMeStwthImLovvgbKkxBpYh1ldGmT9httGLaKKCa2jS33RBjaPHTF8wmFbaOB6cV71a/3KlZWfpPQw4GWcrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768656595; c=relaxed/simple;
	bh=j5LnZHJqzn59f5ssSyn37GvKubD9opdZW3paViaoxic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRB3F5QrxpwlPrX8S5YFVwfSlQ2MYVEhGmnEG4UaSR/u0JFZGliIt7coZq9yphtyL8jwhqyzZjVEvYwYTaE4ht/bID/3zGIQX/7jUNJQiwY8QRwGKzTKd+pSVdbSTl4Yjk2hpxh2fOfxHWzDErZjGIaI7/mWNz68Xp9oiBfXi9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=m6cvS+au; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nFAdLJh1; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768656568; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kDclKEWWq+yBnxawFZ7ozCFfmMDWLxD0vh+XVFkY//eKDOYY5pWOmTzpxmV0Q6Q4Vd
    AojDnU126G4FFbG7j2krNVy2AD5rdty3XdEQxKEWOSh1sq02Fpix8XFQaD3MWHpEhy1Q
    77iiQqKoN7RJEkH3sxWus+N2p2rO4/HMEazRYiG+Y+4gd5PmBdi2O1i69SqksjnVsqWC
    fuAeTXGvQ7BDeqinIi0j+J5ugKselQS8WkTbaEFr1k4OJiXhUJXgZC8i4+Dk8UZOsfu7
    iGyuXtdsfIE3KvVJX2MuIu6J+OOhlLeBLCIdzRLOy2hrZ6gkkCNZ2o6ZG1eXiTlngQI+
    dIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768656568;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=grU7/Ynih7m5OCWlyqR8U54sP2/RCj9vW3X/wj9NnxE=;
    b=aNnyxrQT7vEwTWrNUQ5DN63WBGSnsN8efwnlGSzCtyMHOcdtmivVRH/7rLp4PHExxq
    HG3cEp3oYBbYx99+pgf47TYy7C0psry9rpeIz1EpcXOIVUcUUikoHU+ifG+r3KiNInj6
    NEnUz/FgtRdyNJXye0WtFvbWX2YBgEzuAnRIyChJ6UVKoSHAEhB9QEcs6lwqnRMdgYpa
    ynjoM8YlhqZqG89ktY2aUe41plOiNrTdUhmVSNAyBfaXNtHDjt94NlFzhtYD9L4v0D0p
    HUJ2CBHbxiFbV4eIZtP7NIfAbBnEVxGK+ze6Nqup3Z4vuxgfCUaSlGN9p9NtTxW3RpoY
    YOIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768656568;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=grU7/Ynih7m5OCWlyqR8U54sP2/RCj9vW3X/wj9NnxE=;
    b=m6cvS+aurC3sPNZKPogvGmrAVDPcNW1jCEbcLdbAe02FTJMjfYFIjO4hLcsUFWOSkj
    IsPoZeP4ii1HnDOtfmQUDJZz2wcOKzSsERIlXLeqPP/Wu8aN70A+hiuyrkFzlefqMarN
    QUVangmaSE9B18o0sea9Xd/r1wSRhAcGh25YLvB/0qzDbbb5DQghkxTVcuBGdRar6fa8
    wg6qMPJHnXenGnj8/KlDn2VeEoZIlgKkHx3uP/h3wEP5wgulT7xU9/a1L4/9In/xa5iC
    H2DRtY8ANnH8wF2gUjFBjCP+QJ7geeMW7h0mhHgXpH9m+h1qaYEdKNoxBWsrJA69tVrL
    HxCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768656568;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=grU7/Ynih7m5OCWlyqR8U54sP2/RCj9vW3X/wj9NnxE=;
    b=nFAdLJh1jP1o/EypZ3vAKVePVpfZ0zppxdXBZG/tuemE27LkOvA10VnpH7SYfTagxI
    spfES7nn9EnQ5tjGmpDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20HDTSGS3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 17 Jan 2026 14:29:28 +0100 (CET)
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
Subject: [can-next v2 5/5] can: gw: use new can_gw_hops variable instead of re-using csum_start
Date: Sat, 17 Jan 2026 14:28:24 +0100
Message-ID: <20260117132824.3649-6-socketcan@hartkopp.net>
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

As CAN skbs don't use IP checksums the skb->csum_start variable was used
to store the can-gw CAN frame time-to-live counter together with
skb->ip_summed set to CHECKSUM_UNNECESSARY.

As we still have 16 bit left in the inner protocol space for ethernet/IP
encapsulation the time-to-live counter is moved there to remove the 'hack'
using the skb->csum_start variable. This patch solves the problem that the
CAN information was scattered in different places in the skb.

Patch 5/5 to remove the private CAN bus skb headroom infrastructure.

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/skbuff.h |  2 ++
 net/can/gw.c           | 23 ++++++-----------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index eccd0b3898a0..7ef0b8e24a30 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -863,10 +863,11 @@ enum skb_tstamp_type {
  *	@vlan_all: vlan fields (proto & tci)
  *	@vlan_proto: vlan encapsulation protocol
  *	@vlan_tci: vlan tag control information
  *	@can_iif: ifindex of the first interface the CAN frame appeared on
  *	@can_framelen: cached echo CAN frame length for bql
+ *	@can_gw_hops: can-gw CAN frame time-to-live counter
  *	@inner_protocol: Protocol (encapsulation)
  *	@inner_ipproto: (aka @inner_protocol) stores ipproto when
  *		skb->inner_protocol_type == ENCAP_TYPE_IPPROTO;
  *	@inner_transport_header: Inner transport layer header (encapsulation)
  *	@inner_network_header: Network layer header (encapsulation)
@@ -1085,10 +1086,11 @@ struct sk_buff {
 
 		/* space for protocols without protocol/header encapsulation */
 		struct {
 			int	can_iif;
 			__u16	can_framelen;
+			__u16	can_gw_hops;
 		};
 	};
 
 	__be16			protocol;
 	__u16			transport_header;
diff --git a/net/can/gw.c b/net/can/gw.c
index 74d771a3540c..fca0566963a2 100644
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
+	if (skb->can_gw_hops >= max_hops) {
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
+	nskb->can_gw_hops = skb->can_gw_hops + 1;
 
 	/* first processing of this CAN frame -> adjust to private hop limit */
-	if (gwj->limit_hops && cgw_hops(nskb) == 1)
-		cgw_hops(nskb) = max_hops - gwj->limit_hops + 1;
+	if (gwj->limit_hops && nskb->can_gw_hops == 1)
+		nskb->can_gw_hops = max_hops - gwj->limit_hops + 1;
 
 	nskb->dev = gwj->dst.dev;
 
 	/* pointer to modifiable CAN frame */
 	cf = (struct canfd_frame *)nskb->data;
-- 
2.47.3


