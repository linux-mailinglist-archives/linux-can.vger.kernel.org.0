Return-Path: <linux-can+bounces-6406-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNkFAx2Le2mlFQIAu9opvQ
	(envelope-from <linux-can+bounces-6406-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 17:30:21 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B517B2309
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AF5B3002D0B
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B43446C5;
	Thu, 29 Jan 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruzqbPR2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1F3431FD;
	Thu, 29 Jan 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704193; cv=none; b=rcZYwwYjNXiU92Xc+TGkK3ClC54may0jlOI13sywmin20k+v+mOfqy/IFc6G5Uh/0KNmWMnMBXgtBBZce9tqyn0AkX90EQnQAbO6zLV0Q5b8q+J0ikXNEGZkCE6NE0s8reh0JSDYvuoIOoV2fa4E2JmxcvyrdY1Ytlt1mkQS71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704193; c=relaxed/simple;
	bh=XB+jd8Uo6NLUgRw5C8aaoynbPZS7lW1+y/w+eU8TFIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQznvXlXJA1TNRqawV37yia9L6+u8pDgAXwRLEAc1oBGvRShu+a5Hn7eyANInA/XGlvU2TzRFbUIkm8r2kWYIpCxg96eni4ZhPN1YDJIv5UlVq5H3ddcJJBEzc9+duEOVLT/BZrxDal/r8afVq4vZwGf74i2ULeOGhQ4WBgH30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruzqbPR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A6C1C2BCB6;
	Thu, 29 Jan 2026 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704193;
	bh=XB+jd8Uo6NLUgRw5C8aaoynbPZS7lW1+y/w+eU8TFIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ruzqbPR2HCB5MsHYQjgbewmOFki3DjwrYnTDAuf8NDKqx06V41gMeJkgaXSsWBePm
	 UYoA5aaHFPP6Vg1ROjFsQ7xuWAjGWmZKlGXFyWEJ0SoC4/UUpjh+BACuPPHoPmONWa
	 QDUoEzElyOKEfok7LqOdDMySB83I0kJoNWjKgECFVX1nLYRbClGSsgcNf5dOWmB/rt
	 rjZSe+eJFibTHNnfzPNUgVGa0uegB9Ic37gi6qmYEjpQJOrFALh0hvKkCR9hYW7QcT
	 55rS9Mce+30un0vcOijMPgR9NKv3taRrwfyJ42aoBA9TmoFBGl2F2BFCsG+qArNWKe
	 38xAk1wi0BNJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DF8D6B090;
	Thu, 29 Jan 2026 16:29:53 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 29 Jan 2026 17:29:12 +0100
Subject: [PATCH net-next v5 6/6] can: gw: use can_gw_hops instead of
 sk_buff::csum_start
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-can_skb_ext-v5-6-21252fdc8900@hartkopp.net>
References: <20260129-can_skb_ext-v5-0-21252fdc8900@hartkopp.net>
In-Reply-To: <20260129-can_skb_ext-v5-0-21252fdc8900@hartkopp.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769704191; l=3041;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=gROXgTeGMlp6WRxOyJYp7hVMhvC05JXB+XA+TTbQ+Io=;
 b=GPUDSVndBaWQf1DPe7inuD7pvK1ddvjciAHJWeBoHwy0ZLcd64v++ERpt3hEPo8zCCXlfoA8k
 FNeWwuRueXZA7KQ8XZyJ0IQaketNe2uX970c9ub0Yuk36NGHDEl4LKC
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6406-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:replyto,hartkopp.net:email,hartkopp.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B517B2309
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

As CAN skbs don't use IP checksums the skb->csum_start variable was used to
store the can-gw CAN frame time-to-live counter together with
skb->ip_summed set to CHECKSUM_UNNECESSARY.

Remove the 'hack' using the skb->csum_start variable and move the content
to can_skb_ext::can_gw_hops of the CAN skb extensions.

The module parameter 'max_hops' has been reduced to a single byte to fit
can_skb_ext::can_gw_hops as the maximum value to be stored is 6.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/gw.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 6f158abd61aa..d83fc8242e0b 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -69,12 +69,12 @@ MODULE_ALIAS(CAN_GW_NAME);
 
 #define CGW_MIN_HOPS 1
 #define CGW_MAX_HOPS 6
 #define CGW_DEFAULT_HOPS 1
 
-static unsigned int max_hops __read_mostly = CGW_DEFAULT_HOPS;
-module_param(max_hops, uint, 0444);
+static unsigned char max_hops __read_mostly = CGW_DEFAULT_HOPS;
+module_param(max_hops, byte, 0444);
 MODULE_PARM_DESC(max_hops,
 		 "maximum " CAN_GW_NAME " routing hops for CAN frames "
 		 "(valid values: " __stringify(CGW_MIN_HOPS) "-"
 		 __stringify(CGW_MAX_HOPS) " hops, "
 		 "default: " __stringify(CGW_DEFAULT_HOPS) ")");
@@ -478,23 +478,12 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		return;
 
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
+	if (csx->can_gw_hops >= max_hops) {
 		/* indicate deleted frames due to misconfiguration */
 		gwj->deleted_frames++;
 		return;
 	}
 
@@ -534,15 +523,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		gwj->dropped_frames++;
 		return;
 	}
 
 	/* put the incremented hop counter in the cloned skb */
-	cgw_hops(nskb) = cgw_hops(skb) + 1;
+	ncsx->can_gw_hops = csx->can_gw_hops + 1;
 
 	/* first processing of this CAN frame -> adjust to private hop limit */
-	if (gwj->limit_hops && cgw_hops(nskb) == 1)
-		cgw_hops(nskb) = max_hops - gwj->limit_hops + 1;
+	if (gwj->limit_hops && ncsx->can_gw_hops == 1)
+		ncsx->can_gw_hops = max_hops - gwj->limit_hops + 1;
 
 	nskb->dev = gwj->dst.dev;
 
 	/* pointer to modifiable CAN frame */
 	cf = (struct canfd_frame *)nskb->data;

-- 
2.51.0



