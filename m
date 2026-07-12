Return-Path: <linux-can+bounces-8340-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qSJfMCmaU2qucAMAu9opvQ
	(envelope-from <linux-can+bounces-8340-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 15:44:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BAC744D61
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 15:44:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="l/6PY8z0";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8340-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8340-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43D0130094F9
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775043A0E99;
	Sun, 12 Jul 2026 13:44:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468337475B
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 13:44:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863847; cv=none; b=MCWglpc8s0NtnrvRkUc0iUdR3bFTevm3dlBvAOby2DwZui+eIqx5v797pEw6EatLmzW5JUCEb2XIj8v9ONUpjhIGoibGB4XpFs6+JyKpu8ItCG+4+OfgOh+1Bu1Ds0cnSgEe19sqNSx8asOnCok1BtSWeDaLsHj7lz5elssQ2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863847; c=relaxed/simple;
	bh=biod0OVlTx/fjaWC0HtwR9/fMc8WRBWVtIAgX2owies=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I154Cl+tDkEZZ79DaYBorGGaSW5wAUrGvB63oaNMGgDSt9fNe8frGSQ+q4TF6Tt8OfQY0nndDVUG7vs/eVV/06DZI5tpZRSrkBJGZCUmR3cmNR5DWzmbZshLxwnWkPsZSInA15vovsSkMT8ilsOlxcbP8nhtZVtHt0k7ROkr9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/6PY8z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 223D2C2BCF6;
	Sun, 12 Jul 2026 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783863847;
	bh=biod0OVlTx/fjaWC0HtwR9/fMc8WRBWVtIAgX2owies=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l/6PY8z02wNHPAlS7lUeGXqALD1Gbq1UM+vAxDn95S7G6whu/qP6EE0N3EvJrHodh
	 ARG9p6ytUL+hRdr3sF4HsXw2M3KujcIcNurOlIo40/9hx+ZbMyihjfINkg9MoPAWw+
	 liv4CqMFMKKNwmm90Fw6aDyaqlCm81LkQYBNOUr4PJt1htc0ZwC8Ezbg+xMGBoWq0P
	 FVLSDMl26YdriXXfN+nCxcb9Xj8sHZYa/2zKn9wRFnz08hlGWcfkVjUeeyuNKrbqHN
	 yeG5GCw/hLSPex4YPQm9QGO3cypotxey5OfcdAVe987MCy3M+EnIaeFrm+FmFrykZq
	 0adohsQl/K66A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB8FC43458;
	Sun, 12 Jul 2026 13:44:07 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sun, 12 Jul 2026 15:44:08 +0200
Subject: [PATCH v9 4/4] can: isotp: fix state machine corruption on signal
 interruption
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-isotp-fixes-v9-4-137840d7f0f4@hartkopp.net>
References: <20260712-isotp-fixes-v9-0-137840d7f0f4@hartkopp.net>
In-Reply-To: <20260712-isotp-fixes-v9-0-137840d7f0f4@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783863845; l=1269;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=pr0FYrc5dBkkqbDmu8I+qeB4zl8MV6JSiRwmhz8cpRM=;
 b=F80SS06/98NmLno1nmfJXjWljKnI0nwa72BG8TZHWoGLtoW6HIu0L2lVNeQb3gQSzZjPAxK5u
 G+PmtB4mG7/B/tDCSIdxJm7xyJXEAyuGMHp1t88digrc7nBklDCW/6q
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8340-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36BAC744D61

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
index c4ca8a64e7ce..56618ea1dae4 100644
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



