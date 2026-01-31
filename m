Return-Path: <linux-can+bounces-6436-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJwKLNcCfmmVUwIAu9opvQ
	(envelope-from <linux-can+bounces-6436-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 14:25:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB3C1E90
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 14:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4AA330137A4
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6D352F9F;
	Sat, 31 Jan 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo7mAC7r"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C475352C2E;
	Sat, 31 Jan 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769865915; cv=none; b=f5NIhicSZNjVM0kfHtmJDSt5ESKWuYL/89wPLt/wZipdPJD07TQuXfWpl42IefFD4WJtmhrWliHOBRUE9uHpQXRwK0cF2yplErGl2Sz3UaC1Yj/OI3EArZqECxwVOgI0mHBzRelAmZMKYD2qX6toCPTDFaV19IJStntGxULaUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769865915; c=relaxed/simple;
	bh=zf3WXPVkSFDzLsDWT4dV9ZRA9kjiomjTQb6KZWd1ANQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsbz63kKH53JOOu7K2rXLg6gloDYEWgWs43AcH0PxQ5z6LcX4w9X7tguvIaGqvlKEi3uEPEwy6ytRjXNQgmDHmd4w5mAy9V+XQJItaWCx2gUCQfy+Qxof/t6Z65jMZb1ITIt9/R0KCURaxEM6omrgjJUHhNU0nc5RUbVHOTUI2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo7mAC7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBF41C2BCB7;
	Sat, 31 Jan 2026 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769865915;
	bh=zf3WXPVkSFDzLsDWT4dV9ZRA9kjiomjTQb6KZWd1ANQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uo7mAC7rKB9ndz3MUF197/lQHeInV1b0l1JIzFjQavkHqtTd8sjYSn1qAJvnmCnVQ
	 l9OQWVmTplvRPDnA/UavpWUbmnC/tJcfhf+GO7QgEZRlI+IkK/sMeXWpblH8mTeMz4
	 Idg4y1N8lb1oFncgYdwvGLklqSPstUGOdaFt2Lsh0Uo2EFBLn2yDpeVWSU4W39UnQe
	 Wau+ALYHom5zXqfxyKQEUzmq7skYxEWtmW2EUssNSrHyZ5bFtZ7l218TmGhTReYbsv
	 KxKN8ParUc4XRcdDx848Xt7PwGH1RDgemvA3gM5OUEkkMI9JecOoikB1HsXTyZwOYx
	 nq9fREd8NXTiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D8D79771;
	Sat, 31 Jan 2026 13:25:14 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sat, 31 Jan 2026 14:25:11 +0100
Subject: [PATCH net-next v7 6/6] can: gw: use can_gw_hops instead of
 sk_buff::csum_start
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260131-can_skb_ext-v7-6-dd0f8f84a83d@hartkopp.net>
References: <20260131-can_skb_ext-v7-0-dd0f8f84a83d@hartkopp.net>
In-Reply-To: <20260131-can_skb_ext-v7-0-dd0f8f84a83d@hartkopp.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769865912; l=3632;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=ov/1Nd5fmtdN4DViiwCnK/2y+He9qcgNw2oZkmdY3H8=;
 b=qCf8F5KQ+Ulb1P9YvkvH+SJ+7YVcT+z3gd+i0t9ZNQP2anpAKs7qNUyG1aQPujgkg0+ViP6cd
 NssymmS2ga0Bq43rJeoVo6OtG11jJsf5N23iqvTsD8yZt+lc9LHJCXS
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6436-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:replyto,hartkopp.net:email,hartkopp.net:mid]
X-Rspamd-Queue-Id: 22BB3C1E90
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
 drivers/net/can/vxcan.c |  2 +-
 net/can/gw.c            | 23 ++++++-----------------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 53d7d9046f85..60e5dad0694d 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -76,11 +76,11 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
 		kfree_skb(oskb);
 		goto out_unlock;
 	}
 
 	/* reset CAN GW hop counter */
-	skb->csum_start = 0;
+	csx->can_gw_hops = 0;
 	skb->pkt_type   = PACKET_BROADCAST;
 	skb->dev        = peer;
 	skb->ip_summed  = CHECKSUM_UNNECESSARY;
 
 	len = can_skb_get_data_len(skb);
diff --git a/net/can/gw.c b/net/can/gw.c
index 816154a978c1..61a1e6b1b83f 100644
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



