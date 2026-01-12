Return-Path: <linux-can+bounces-6107-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0C8D13A5A
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 16:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A863304BA06
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 15:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE12DF6F8;
	Mon, 12 Jan 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="paYRtOVP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="7JUoacrb"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AF2E11BC;
	Mon, 12 Jan 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230626; cv=pass; b=HwpF+YyWg8blCCjGaArM1ePOaM0mQOKkrO9ecgVClSiHa9hCcrAkF9if9H/pDbiqb4ZGeRRDR0ho27rKPCvlL6zbi8dht1rBmLPZDyA5sVIZ4sld/DW+cntoDijBleCy42iq5bIV1wGuSBuI65IK9kLsQCGh0qoHuecNI6XppaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230626; c=relaxed/simple;
	bh=p3XQ3+DKWGSsBOeM8FJLeKqU/tDMNkZ5U21WP7yhRDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsR+qi7BlgE9ncDCEPBlhI0yoNIc+Xx6D19kCVV0I+GthcM/9ngb47RyDn32bJ41D5ZOANGUQ+acAtCV7kdAqiaj0+gCnCAeOwzrRG2Xh8ED5ZRB4J+6RVC7sTjAS/ybbyNXs/x7Z9uv9huo5sS8Yc7boUoa/xwFJcQfGqejMRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=paYRtOVP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=7JUoacrb; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1768230593; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RQz60J2lBrDaggmKIJbHTMQmJMGWpgHLBQ4EVe8TZviAJQ6NoaTyBYCs0Um3Ajlrnd
    /p9uAWpnpDsWJ9iBYegE2A2VlNAQ8iSlAN3csb+wKfhdd7ytAaQGhPdi49jrwzJRqTKU
    qdvghY+n0S3beT/vVFHncPgPPd0V290hgJuutKKuQb60GgQN2u39C9lCcAeYvvxpRKpv
    bZIcfLRpMXWuwoZ2FIH4aHJbVrBaOg+M7SD9XSGzn3hJQ6vEhRiOwqCuR5+DXAOAa9vi
    erMepXmJkvWDP8EXQM4IJhhhiHR1sKvnhBW7UG1TrfkdzmVIXwchtIqvj7Tu924Yil+2
    Wt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768230593;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YT3BIH0lFVW+T6GCaLaBngWwyqlCLb3Ckieh5B/h9IQ=;
    b=JSfLWp7yvHPojU1lJqyXRhLLutSkk9EyaZRtPgntHsfgezZ1OFzUyJQ5TJuueBEYpr
    YCzPeb7///bWCs9QCPVTl/75z3GPEN7WCFPQBWFQK6nHCIFQTpgeFa41oIfYmQkAWJtD
    frK34XGFZcx0TLJ6WuHVRCqZoITIHc26kwck69A3XJfu8+Y++5cjhoKprs098ZIHNBsv
    egzUlUtPzdXLVCltB8Uv5mIxljcO8Oe5IbTLeuS/LZP/SUpCkazf0Vav1WsBjB09Redx
    2zBQgMndQmaMbJVfN1CeQ1NPwnJIrxVMxWLd6DvlJoJBRrJ0dU+ctej88OJdzudoiuaw
    3h6g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768230593;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YT3BIH0lFVW+T6GCaLaBngWwyqlCLb3Ckieh5B/h9IQ=;
    b=paYRtOVPmxo5i1M0YNe8b2ANfB06GJeIDHGxvqw4ZsAeA9T2bGMgPXxJ3RA2HgSNNH
    3y8A9oD805uwVoW9Ss61Dm8G5T4F6qrpofZVdb6bD/yB/jOK8MgurXTtmuMUBtygcXgM
    s22sCi0VrfNf/83fRFG8yxwNtTATS/JyeM8SRRND3/HJDhk0bly8n8icVQ32jCJRwPJw
    tj/shWgMyiHeoyCL9SkhovkgW/NMILwDq1uxZsjDOb59+g0Fa0KY8WUBGO7/u8LPFwu7
    tGLoUym4gfGlEZp8sKt+/rphoGM6ps9N0grcWhFHKtFPa3CkkoEuTWsrjspCeY/XigJq
    4osg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768230593;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YT3BIH0lFVW+T6GCaLaBngWwyqlCLb3Ckieh5B/h9IQ=;
    b=7JUoacrbNhzrOQ3Q9W2PmpWeedBEkCGYhute1opxCQg51STyqfN0+aUIz/oz/AgGHh
    xZcDXxfbW7ja2GERZFCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20CF9rgmG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Jan 2026 16:09:53 +0100 (CET)
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
Subject: [can-next 5/5] can: gw: use new can_gw_hops variable instead of re-using csum_start
Date: Mon, 12 Jan 2026 16:09:08 +0100
Message-ID: <20260112150908.5815-6-socketcan@hartkopp.net>
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

As CAN skbs don't use IP checksums the skb->csum_start variable was used
to store the can-gw CAN frame time-to-live counter together with
skb->ip_summed set to CHECKSUM_UNNECESSARY.

As we still have 16 bit left in the inner protocol space for ethernet/IP
encapsulation the time-to-live counter is moved there to remove the 'hack'
using the skb->csum_start variable.

Patch 5/5 to remove the private CAN bus skb headroom infrastructure.

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


