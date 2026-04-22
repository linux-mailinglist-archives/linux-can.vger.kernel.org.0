Return-Path: <linux-can+bounces-7391-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKIgOYuh6GkLNgIAu9opvQ
	(envelope-from <linux-can+bounces-7391-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 22 Apr 2026 12:23:07 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB9E444A51
	for <lists+linux-can@lfdr.de>; Wed, 22 Apr 2026 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03B823019134
	for <lists+linux-can@lfdr.de>; Wed, 22 Apr 2026 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795233CCFAA;
	Wed, 22 Apr 2026 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLUSUU6k"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E03C3456;
	Wed, 22 Apr 2026 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853365; cv=none; b=mMfmp8LUr0qH3dSm/dyAqfXZhKQ6QIC+Xz79ATXIGcqmQOv3NLa8/c6zHFRcmffCXPxcdVqYcRw2q6HcJuLUwBYJ1VcFuEb4k4oYzCIzVRvOv16kHeBgBdcAahP64UWsVFzJFr0Jj43TqBtu+hahG+Z/0FBHH7AXtaB2dloMp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853365; c=relaxed/simple;
	bh=VGtIPZdLeDbWdsWvGk95fCZ2dvyZXth3QyX7ohrz59M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=V/Bo/wKTa3fsjPk08L1aIo9VENk/pHF1Fd8D1RHGj1Ohs3rY+QdMZXdufPIRiBCLUKZjYymMVveblDzV1ARFxM14ltAN46lQvmxKPV82LXmhzchndK2rvZY/1MfMmmyEpV2Q64nEcIGLDiKavju45mTZr3iIrOWN5euJm2yqXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLUSUU6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C870CC19425;
	Wed, 22 Apr 2026 10:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776853365;
	bh=VGtIPZdLeDbWdsWvGk95fCZ2dvyZXth3QyX7ohrz59M=;
	h=From:To:Subject:Date:From;
	b=LLUSUU6k4T3kg6oTTM5TDWScPq73mhSgKaeYOGkjxlsP1h3LcC3ZvA+EXhAKa1Sjq
	 ko/5U3vymFl8AstrAvnAndCbolMthalXfPenXt5hPN6xPfKTreTuvGfCoNxOEhQAUn
	 WltsxkRD09nyU5xxmMOBChoi/Jq9hdRmNyFy4gDHAu/Dmbb06f/S568mWOnr9gchSY
	 i10juu857+ygvNtqDhgdNXuYOx8CVOCl6+F6+WCMQNZpQgUtyuveN73VY++8W1oyQ+
	 ikSSLEWMQrSny6Oqc3LRmEibKv3r2esF7rScw4miFVMFOl6GyVEIhibXvPCQ63SjPQ
	 qWum3eiiIN2Rw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] can: bcm: prevent thrtimer UAF in rx path by checking RX_NO_AUTOTIMER
Date: Wed, 22 Apr 2026 11:22:38 +0100
Message-ID: <20260422102239.948594-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7391-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AB9E444A51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
synchronize_rcu()") removed the synchronize_rcu() call from
bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
timers from being rearmed during deletion.  However, it only applied
this check to op->timer via bcm_rx_starttimer().

It missed the fact that op->thrtimer can also be rearmed by an
in-flight bcm_rx_handler() (which runs as an RCU reader) via
bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
bcm_remove_op() has already cancelled it, leading to a use-after-free
when the timer fires on the deferred-freed struct bcm_op.

Address the omission by checking the RX_NO_AUTOTIMER flag
in bcm_rx_update_and_send() before starting op->thrtimer, effectively
preventing it from being rearmed concurrently with teardown.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/can/bcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a55..67e5b3149a8f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -539,6 +539,12 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
 	if (hrtimer_active(&op->thrtimer))
 		return;
 
+	/* bcm_remove_op() may have cancelled thrtimer concurrently with this
+	 * RCU-protected handler; do not rearm it. Mirrors bcm_rx_starttimer().
+	 */
+	if (op->flags & RX_NO_AUTOTIMER)
+		return;
+
 	/* first reception with enabled throttling mode */
 	if (!op->kt_lastmsg)
 		goto rx_changed_settime;
-- 
2.54.0.rc1.555.g9c883467ad-goog


