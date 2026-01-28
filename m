Return-Path: <linux-can+bounces-6384-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAv4AUORemmz7wEAu9opvQ
	(envelope-from <linux-can+bounces-6384-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 23:44:19 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8A7A9BAE
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 23:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DF5730205C1
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 22:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72173345CC0;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VknzMKbN"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AF3451D9;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640239; cv=none; b=OYREgHbGXHBiTP7clgpQQsX17+36GTpieLk3gfKcmQTpEzLfUKn/MTQyTMH+jjFaQH6NIFUc7BCw1Fs8GfBtLa5KVgCAze0uu2IsE2/LRefrdQSZHQwO1We9iRJJ28pROukhlZzJk9xR22aqGf7cgP5yUlm4v9W3Z/TpWiCtGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640239; c=relaxed/simple;
	bh=/Q2rO//nNvQwbQGtThXRokVEEWYfBatKLnNyBVLMKUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKp8yUNO15IY49cyIOKLqiDLbC3BCkExliMwLGhDIImqb/KeJxjPCQkZpIBGg0SSRAB+GgNi2caANo+7Xj50jKJSg3GrkIfmt6XUzeagVZacFLrj3jLx8b8oBuuoVaqPyoV6TM1lPPG1PAZp3uhbESOjdVUsTRp2beefm6asUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VknzMKbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D2B7C116C6;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769640239;
	bh=/Q2rO//nNvQwbQGtThXRokVEEWYfBatKLnNyBVLMKUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VknzMKbNJVH4B3/f+RR+4M0d4Kvoi7/frG0HYC6H+zBlVM/Zbjhcv84Z0QBobHSV9
	 KCUobZ11LqsVRpY0x2aTboqn9PLPAEtnrn/ssof49etdx0GWaRFv+0NxWiQK2FPviW
	 P79ErtWVTInnobM/A/bTH6QzcBW2dVNgD0UX6QDq2YFwdfzkHUhlXpj147J9anwfkR
	 cxf5T6tGVWT0+4yStQpY7BMuSeG26+1cZV1ZE+6AwfD2bJsfQymnKzQyqab/jO+4SN
	 2BDvTLJoB9sgGEUovfBwtfDoRE1BzD/Chl/vEiIUqFl6w3rqyxtf8JXoEvqHWeP3NZ
	 dlHP6x6NNoGwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A24D46C15;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 28 Jan 2026 23:43:45 +0100
Subject: [PATCH net-next V4 6/6] can: gw: use can_gw_hops instead of
 sk_buff::csum_start
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-can_skb_ext-v1-6-330f60fd5d7e@hartkopp.net>
References: <20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net>
In-Reply-To: <20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net>
To: netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769640237; l=3097;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=G0PyhBZW9Q7e9z6lpqwdaRFJ89PaevlNpycS/X4tDSQ=;
 b=A2LHfZ/twwOLoG9zvSpDVG4Nf1OOUccXkBBbGeOr0K8+3e2LTmf29u/Wg5JwWGwH8mNBNmtIL
 LUQQxW4kmbQBBwHgwZ82K03Sx5GbFX+zA0ia3vUP8zzEX5DnIcKAJJ7
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-6384-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Queue-Id: BC8A7A9BAE
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
index ad89a1913b3422f77fdf91b5552380282b2db09a..2c134c9e5159d659b83881c51b3814debbc5f9c8 100644
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
 
@@ -530,15 +519,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
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
2.47.3



