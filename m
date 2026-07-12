Return-Path: <linux-can+bounces-8334-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G4Q9FZCLU2oQbwMAu9opvQ
	(envelope-from <linux-can+bounces-8334-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 14:41:52 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF059744AFB
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 14:41:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=URuVPNgz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8334-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8334-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3BFF3016EC5
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818923A9616;
	Sun, 12 Jul 2026 12:41:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6039A7F6
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 12:41:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783860104; cv=none; b=qV/fxxOzPMqOsWjLpf1eS0gvHnKhuOZNZTUh4kna833XsTk+T1IuuB8jkepnzrEcSaw3TIqSIhUij1H+Hdmxcq1DTt9zDuUyFZQPeQuXK6KCdVu5tyboHysNJzbonNpYouGC3rOmDtM+7/RcKBRlyor8XT/7ReMB0MwHMBs71mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783860104; c=relaxed/simple;
	bh=VlveytbLa1sMCvfJ0NGWhxhPhJbfP/f8WNxwrBT31+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fcD0zJvalbx5BJs6gZdoJH0F2sguftATmIax2TL8xrjYMLEpdSXMn0b1LWSRkZM9RjmlgFxLpNAUnFOY0SlKAnrlewRwsDfMkMA7EGlsWKSHdJdLvNfR+8K/FHsjVSJodicXQO6rBh8IDB7hXDgJKdNYnFauDEols0Hk/WX87tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URuVPNgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26D3CC2BCFA;
	Sun, 12 Jul 2026 12:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783860104;
	bh=VlveytbLa1sMCvfJ0NGWhxhPhJbfP/f8WNxwrBT31+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=URuVPNgzLFmwSuxI5izYIX3D0lGEStvvqYd6WwPV9ChMS2mo49xH8tXTNS/aHVkGe
	 2WUPYR/z//e1wGC3g+HJn23emMD3fwzuMWZf7vj2guMsKqiC+vt0SLgvwoZ52m+93f
	 VlFvUW3WnBWNQO2m3eoRb5GpIb6OkkciDh38OctK9nlHR1ssgjFRGBtNMy6fORRZNQ
	 ACdXyMiqHh5TlOsuLycTfq+yT2l0egakXppPTm1B90K2I3uXm+pGxX7JDVBRxXU8Ah
	 bV7oBzfXgLTVkcHO6OzD/qO4NbfMoQQowVwm/9zR5sHcCtvRWZst18P2L6r4g9eqvn
	 3fIKLTumT6sfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14310C44509;
	Sun, 12 Jul 2026 12:41:44 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sun, 12 Jul 2026 14:41:40 +0200
Subject: [PATCH v8 4/4] can: isotp: fix state machine corruption on signal
 interruption
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-isotp-fixes-v8-4-c39220a4e442@hartkopp.net>
References: <20260712-isotp-fixes-v8-0-c39220a4e442@hartkopp.net>
In-Reply-To: <20260712-isotp-fixes-v8-0-c39220a4e442@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783860102; l=1269;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=XSRkoBUk+2QvpNVjZ/XeJuW0hbx2JW2ivpkcA6L2LZs=;
 b=gYFH/yFAiZXy/4p8ay46IQEqtKQPJy91R4Wc2Xp9MbHotVZ7+3bNjEyEBecxRTfg2SY64rNoJ
 +s+NDhnN5s4BwsmC9GboembKalz45NrGNVJ2J0rpTgx8mBvsXoLoVOv
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8334-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF059744AFB

From: Oliver Hartkopp <socketcan@hartkopp.net>

If a thread blocked in isotp_sendmsg() waiting for a previous transfer
to finish is interrupted by a signal, jumping to the cleanup labels
incorrectly cancels active timers and forces 'so->tx.state' back to
ISOTP_IDLE. Since this thread never owned the active transmission, it
abruptly aborts another thread's legitimate transfer, so return the
interruption error directly.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index c5b44d298618..ceb590ae058e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1045,11 +1045,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 		if (err)
-			goto err_event_drop;
+			return err;
 	}
 
 	/* new transfer: bump the generation (gen is used below and by
 	 * isotp_tx_timeout()/isotp_rcv_echo()) and drain the old one -
 	 * cancel its timers ourselves in case one is still concurrently

-- 
2.53.0



