Return-Path: <linux-can+bounces-8251-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O307Bi4DUGp3rwIAu9opvQ
	(envelope-from <linux-can+bounces-8251-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:23:10 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92656735517
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:23:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="Sdo/KkBd";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8251-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8251-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08FE53037471
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42875347520;
	Thu,  9 Jul 2026 20:22:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5043A1696
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 20:22:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628573; cv=none; b=eD0SZwE8ilFbxfi/qCEb4hh38jc1rXNr/hPHxYlHp6v17sZbnqitN8hQMwqY7l9+/4CZC4uUQ+CKiKJQSq0C5sUpu4MMSRLKxYkpF9M9RNhCYpyqXiRHCjovdVVjAPZOk073iHL/IADoDToZXDyEub/V6+bxMWtTtT6czUA8lnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628573; c=relaxed/simple;
	bh=NaLu2bcKFax2q55qcoiSIhxlY7LIkmWJ2DtI+XiDPqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHMj0ZCPAPVcUtd5xdJSbujH0hUv3goLnPqt6nTzjig8yjmmOiCgu5cppqfio1nGYvQ934GfIPGxa/Aoq3nnFyUovb0ZAuEqOhNZdCgRvcEH5UZ729/zuPZof6pCXC28SdwJ3MKcbUiGtV2feLVKm3IYbgUocoqwE40ufnU43TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sdo/KkBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB026C2BCF7;
	Thu,  9 Jul 2026 20:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783628572;
	bh=NaLu2bcKFax2q55qcoiSIhxlY7LIkmWJ2DtI+XiDPqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Sdo/KkBdUFUfqtuoRD8pEkuVl3kz9g0fmZhnOyBEVbK79k3LYYWyGMZeMzl8PC6g7
	 p1beUB/7thSp6rPj/eQRbKY1q5Cg5mk7snKJ4WmVlNAk3nCpgIeoI45PRYAv57FvQy
	 Y0/1d49tQwQ/h4aObA5rIrqHTo7BxtIzhYv8B+pI/Q1tQ/kRR6eBVlinRXNBFSqLVh
	 /MOIrfAwLibcU9RJ+ew2ep3IOYUE4E/D3CyIY7Sl8R/gI0c4kVKzSobR03heLb3Izr
	 WLWlTRxqg1Aa0l/j5T1woiucG7zAjmcDsUFlYiGjkQ0AX89JMp3Ql9dHlI04/v4kf8
	 4SjwMcE2S9ULw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C936EC44507;
	Thu,  9 Jul 2026 20:22:52 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 09 Jul 2026 22:22:57 +0200
Subject: [PATCH v12 10/11] can: bcm: fix data race on rx_stamp/rx_ifindex
 in bcm_rx_handler()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-bcm_fixes-v12-10-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783628570; l=2506;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=w5zqfxihgc/yy09d86zBn5oM6DwZxtzW1xBRcXs3jsM=;
 b=9KBpqnJyrvJ0QHWbbotPBWBsIVdGolNT+7+mnk4j0BcRzHsCmcGlySAjtJjdeoDSOmVgqpqAJ
 c5elS/TXIHHAozbqgYbDhR4q/pgUKJgjf/1nujZ6lawkGbp9JYVh5Pc
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8251-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92656735517

From: Oliver Hartkopp <socketcan@hartkopp.net>

For an rx op subscribed on all interfaces (ifindex == 0), the same op
is registered once in the shared per-netns wildcard filter list, so
bcm_rx_handler() can run concurrently on different CPUs for frames
arriving on different net devices.

op->rx_stamp and op->rx_ifindex were written before bcm_rx_update_lock was
taken, allowing concurrent writers to race each other - including a torn
store of the 64-bit rx_stamp on 32-bit platforms.

Beyond a torn store bcm_send_to_user() must report the timestamp/ifindex
of the very same frame whose content it is delivering. So the assignment
is placed in the same unbroken bcm_rx_update_lock section as the content
comparison.

As a side effect, the RTR-request frame feature (which never reach
bcm_send_to_user()) no longer updates rx_stamp/rx_ifindex, since only
the notification path needs them.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index fbf1cbb7c99f..10a883b50fc6 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -777,15 +777,10 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	}
 
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
 
 	rtr_frame = op->flags & RX_RTR_FRAME;
 	if (rtr_frame) {
@@ -813,10 +808,18 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 		traffic_flags |= RX_LOCAL;
 		if (skb->sk == op->sk)
 			traffic_flags |= RX_OWN;
 	}
 
+	/* save rx timestamp and originator for recvfrom() under lock.
+	 * For an op subscribed on all interfaces (ifindex == 0)
+	 * bcm_rx_handler() can run concurrently on different CPUs so
+	 * the CAN content and the meta data must be bundled correctly.
+	 */
+	op->rx_stamp = skb->tstamp;
+	op->rx_ifindex = skb->dev->ifindex;
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe,
 				       traffic_flags);
 		goto rx_starttimer;

-- 
2.53.0



