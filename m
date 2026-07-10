Return-Path: <linux-can+bounces-8311-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IsxjLnxZUWrDCwMAu9opvQ
	(envelope-from <linux-can+bounces-8311-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:43:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 106EE73E738
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:43:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="BO5G/AK6";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8311-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8311-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 188AD3024A5C
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 20:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF13A8384;
	Fri, 10 Jul 2026 20:43:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C33A4F3E
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 20:42:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716179; cv=none; b=m7l/9jLEpaeeP1c+rGIZqAtiGV5krZRE1IubJOoL5E6UE/UZJSVUVHcOw85RwqFPDGUKfSgRrl+1Z4qSKRXK2pZUuX7yKuL7WbtDb8eS8iayBXA3a85o6XafFEl+yTXCkxEsV1Sn0oHB5gzJ4YSMMaY2q2aLIy2Z0JoH1ujs6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716179; c=relaxed/simple;
	bh=XGiPER2Umev2wJgbvTsma9jz2xwUtDDRV+vxr5SmCr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trk2QoLZhS4BextbCMkErwWovVw3otXuIZOYV2LK26tNqBL9benoAAQgx2fh1YR+mdYK6apsa7k2uTMlKuKsgj3I+ZUaxpbR/2C05mJV8MDAKvtcO+cMctBGBD9WnJscUDjxlsu0r4VlIj29IFQMD/OUr7NdArzrS7ypdazxYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO5G/AK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ED04C2BCF7;
	Fri, 10 Jul 2026 20:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783716179;
	bh=XGiPER2Umev2wJgbvTsma9jz2xwUtDDRV+vxr5SmCr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BO5G/AK6/9bt5nMFDYyq99Vz21OLzn1TU7A1UzH6D46/7N37mg6Fqa4kJXnVfH/gL
	 iW4NDP1mJTkBqhPABADg1nEoKnj10MqVLxwsyEZImxbUk/nAVm1+h1SVLnuOjzKaig
	 rAWN63RO4pxZUWKgXQOKVC50bh3qbVIsopNBLjL2tYVOTXFkjS9xd7euLpeayM3HME
	 HyWMAxTeE6QaWV12aEz855kx0BgizI1oE365xo53+MqLLbgORPZNvic0xhHWFS5AW7
	 TMlXL+AeV5/n8wrnKu4rF41sO/e8ZN8JV5p1LhM57BrLEhqh1Su49nXmUvyhEoNZwd
	 3ZbQ/th1tT5MA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08081C44509;
	Fri, 10 Jul 2026 20:42:59 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Fri, 10 Jul 2026 22:42:55 +0200
Subject: [PATCH v6 4/5] can: isotp: fix lock-free state transition in tx
 timer handler
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-isotp-fixes-v6-4-a13c2539093d@hartkopp.net>
References: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
In-Reply-To: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783716177; l=2313;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=Ot90eZUGABfjvSV1dl43SSv1YaX2fwm0Xj0TMEFLGYc=;
 b=XGi8HEO0LvZSMkq2w7ZvCY1sTbkOPFfseJm14MUIdAV5SCmV9Ny3YL3P30z89ufiBPZnE9lRb
 VlIKF159zdlDyKA/AGyGYbsHv7VPYaMCm5OQjPZMNW+PDcoZjw+22GC
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
	TAGGED_FROM(0.00)[bounces-8311-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:replyto,hartkopp.net:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 106EE73E738

From: Oliver Hartkopp <socketcan@hartkopp.net>

Commit 051737439eae ("can: isotp: fix race between isotp_sendsmg() and
isotp_release()") introduced a lock-free state machine check
to prevent race conditions between the TX timer and concurrent state
updates. However, the original patch missed replacing the initial
state checks and left the late assignment of ISOTP_IDLE as a blind,
non-atomic write.

Fix this by properly sampling the initial state into 'old_state' and using
cmpxchg() to atomically move the state to ISOTP_IDLE. If the state changed
concurrently (e.g., due to an incoming echo or a new sendmsg), the timeout
is stale and we bail out safely without corrupting the state machine.

Fixes: 43a08c3bdac4cb ("can: isotp: isotp_sendmsg(): fix TX buffer concurrent access in isotp_sendmsg()")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 5ef2a610fc17..0826ae837246 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -937,24 +937,29 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     txtimer);
 	struct sock *sk = &so->sk;
+	u32 old_state = READ_ONCE(so->tx.state);
 
 	/* don't handle timeouts in IDLE or SHUTDOWN state */
-	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
+	if (old_state == ISOTP_IDLE || old_state == ISOTP_SHUTDOWN)
+		return HRTIMER_NORESTART;
+
+	/* Only claim timeout if state is unchanged to avoid overwriting
+	 * concurrent state updates from isotp_sendmsg/isotp_rcv_echo.
+	 */
+	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) != old_state)
 		return HRTIMER_NORESTART;
 
 	/* we did not get any flow control or echo frame in time */
 
 	/* report 'communication error on send' */
 	sk->sk_err = ECOMM;
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk_error_report(sk);
 
-	/* reset tx state */
-	so->tx.state = ISOTP_IDLE;
 	wake_up_interruptible(&so->wait);
 
 	return HRTIMER_NORESTART;
 }
 

-- 
2.53.0



