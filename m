Return-Path: <linux-can+bounces-8313-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KmfyEIVZUWrICwMAu9opvQ
	(envelope-from <linux-can+bounces-8313-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:43:49 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EECB73E742
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:43:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=lcFhkcPz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8313-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8313-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 865D83026AB4
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 20:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BC239A802;
	Fri, 10 Jul 2026 20:43:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0D3A48F7
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 20:42:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716180; cv=none; b=Qc9VvZER8loIcmWKmUnPjANH1acgs4B9rJMUUnPV/eHrUCYTiknUZ6xFnrxaLd2/jif3+GK7MwQRtURNJl8/cowCNX6MPgoDQpU2JXkX6iYpDv96wakl2gSRffTJ6gqnjcYdfrZqse06kJDprC2p0i71DURruw6Hr+hZmRp4tIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716180; c=relaxed/simple;
	bh=Kalz9pXa0QtJuuj8v4WqlY+mwIqCwhw1HbHXpWY5m5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jGFsDX9d30KdcnvOoCij6+gbOabmPk94UIDrAVOdfLf4Wwq9FHevccujyO3jXsyPCjqEeWhpCX9I4chHMkk/6BcMQ2tTsZ9LWwmvaQvMbMLjfSUg5L0L13Jo4BIfMMpJXH3k+7FgjEaAqQXPH6pPgOB/0cEgwilW3gAGGgWF1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcFhkcPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28077C2BCF6;
	Fri, 10 Jul 2026 20:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783716179;
	bh=Kalz9pXa0QtJuuj8v4WqlY+mwIqCwhw1HbHXpWY5m5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lcFhkcPz83+b6vbXkPB3F6ua9i06pB5jxUueJ7r6v6r4iaftCD8mTo1uH4soFwSJN
	 UD2cblbG6+uB8XXe3MpPDfKX+wluNmqyx1kJJd9r6zWuhUMHzhz4yOwET2Ufo7rJ3b
	 GC2jxmm2WPGQL+NGOSpaRaomJ2aGgHV7EzRuEpymoHsG9j7G/bi/Xm+gnDA5GYg+0b
	 5KDpjGFOud70SePZnCwAYNSok0Mbn42MfW16lzQOMtfMwjhewsuj/od9iPGnCKqlQ2
	 llSOlKHuI6j49jKI+i9t7/YYUlPraoSfR9mNhtyRungAe9bSQzEy1rzli0tRxKLwTU
	 7TCK4aIAGCOwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AF4C44501;
	Fri, 10 Jul 2026 20:42:59 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Fri, 10 Jul 2026 22:42:56 +0200
Subject: [PATCH v6 5/5] can: isotp: fix state machine corruption on signal
 interruption
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-isotp-fixes-v6-5-a13c2539093d@hartkopp.net>
References: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
In-Reply-To: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783716177; l=1200;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=2p7JZxAX2B/fsKZ/6/57Zl/38OVNATxgSBd43fNwAeE=;
 b=40+9Cshq2CIqBDmoXMPR0YAjTdoXcT2EUg9gERHLmmj0WPKXcYmAx7JLa5EdJtYFeVIG1FxRK
 lR3hj89F9nBB5T6YwzfKDWAkt57d3/10zCFVrl5lRsAAAlQh3zwhBI2
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
	TAGGED_FROM(0.00)[bounces-8313-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EECB73E742

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
index 0826ae837246..b8562f8c6de0 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1005,11 +1005,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 		if (err)
-			goto err_event_drop;
+			return err;
 	}
 
 	/* so->bound is only checked once above - a wakeup may have
 	 * unbound/rebound the socket meanwhile, so re-validate it
 	 */

-- 
2.53.0



