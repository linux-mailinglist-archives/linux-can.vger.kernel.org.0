Return-Path: <linux-can+bounces-8261-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GUjzOTYIUGqxsAIAu9opvQ
	(envelope-from <linux-can+bounces-8261-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:44:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F359735842
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:44:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VbiNYCK4;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8261-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8261-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B54D305046F
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 20:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EB3367B69;
	Thu,  9 Jul 2026 20:40:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E23CEB8B
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 20:40:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629623; cv=none; b=g0W8BcuSMr6PUNIm43fMQGQ9wUXqnLLbDbPnthx6jC+AlocToRuC75r5lRFhwAEpHuuyWcn+iPqCU8xaakhZl0/HAu9+JSV0ucUGwypAfKmcalz4MLuCqQJ5fEXWwaTRkYGv2MrP5cXi3M/ojbQov0OcjhWOiC9QjoD+i/5APFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629623; c=relaxed/simple;
	bh=0/s0IR1yuBHxqPOU6UBuSaQNGPzSQXzbdhCnMx9oDa4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dp53uhViVPiQbU46fFKnzbrE7oaozzWS2UB4WMr0k1tAwZkK4SuTu3Am+gADjvexWZRbCvbc41KC1EIX8yRVVEbG2hz6SRo06RC5JzpWHZUAiVjCAfvt4HJiS1QoDaHGtFDfpgmSwXNsdgL6QUl573H2J6LWaijZmHnFO4X0dzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbiNYCK4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93D91F000E9;
	Thu,  9 Jul 2026 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783629622;
	bh=z858BxyFQLkzy24W1jE6Q4PT4NbXsNGST3S2I7b1TvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbiNYCK4rQIVGyy6HY+rmqfmJhFF0mLiw/rucOTX0fmhZfoMmwsELXCnd2hIEw5ZJ
	 5lApDxuir8MP+PG2eyGCQshKVwOxfNZp6npHV2R6Rb0GrPdomldnpj9cayYLbapXiJ
	 27TQjoObzXBmKl+XeGqvvSoZCZbZ/ZU0ukHyPtD9PEIQd6AVqtxGHuUKMAAo8gVg6N
	 qn6mDr/G5FPx5yZKojf/F73Hvk7DZVfNxJ70D+Ib8W7h2/nIBJsdeUQxau7+BKZ00x
	 ac3Ep94Rm95W0+RKLfzdET66Sdp7zp2Axdc/Uxh13qU2spmcMG7vLJrHjqFLYv8x6q
	 uWPJ9iYvj420g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/11] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260709-bcm_fixes-v12-1-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
 <20260709-bcm_fixes-v12-1-61c06291bf1c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:40:21 +0000
Message-Id: <20260709204021.D93D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8261-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F359735842

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] In-place modification of `op->frames` via `memcpy_from_msg()` =
causes data races and heap Out-Of-Bounds reads
- [High] `bcm_rx_setup` and `bcm_tx_setup` add elements to RCU-protected li=
sts using `list_add` instead of `list_add_rcu`
- [High] `bcm_proc_show` iterates over the RCU-protected list `bo->tx_ops` =
using `list_for_each_entry` instead of `list_for_each_entry_rcu`
--

--- Patch [1]: [PATCH v12 01/11] can: bcm: defer rx_op deallocation to work=
queue to fix thrtimer UAF ---
commit 49ab02a8012b5c460ed2235ffc2a8c72c64c1653
Author: Lee Jones <lee@kernel.org>
Subject: can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
synchronize_rcu()") replaced synchronize_rcu() in bcm_delete_rx_op()
with call_rcu() and introduced the RX_NO_AUTOTIMER flag.

However, this flag check was omitted for thrtimer in the packet rx
fast-path. During BCM RX operation teardown, a concurrent RCU reader
can race and re-arm thrtimer via bcm_rx_update_and_send() after
call_rcu() has been scheduled. Once the RCU grace period elapses,
bcm_op is freed and the subsequently firing thrtimer dereferences
the deallocated op.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..bdf53241bd7b3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1060,6 +1081,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;
> =20
>  		/* initialize uninitialized (kzalloc) structure */

[Severity: Critical]
This is a pre-existing issue, but does bcm_tx_setup() allow invalid frames
to be sent?

If a user creates an active TX operation with a timer, and then updates it
by calling sendmsg() with a frame length greater than 64:

bcm_tx_setup()
  err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
  if (op->flags & CAN_FD_FRAME) {
      if (cf->len > 64)
          err =3D -EINVAL;

Because memcpy_from_msg() modifies op->frames before validation,
the corrupted frame remains on error and bcm_tx_setup() returns -EINVAL.

However, the timer continues running and transmits the corrupted frame
via bcm_tx_timeout_handler().  Since can_send() and drivers blindly trust
cf->len, could CAN drivers read past the 72-byte SKB buffer into adjacent
heap memory?

[Severity: High]
This isn't a bug introduced by this patch, but are we using the correct
list insertion function here?

bcm_tx_setup() inserts new elements into bo->tx_ops using list_add()
instead of list_add_rcu(). Because list_add() lacks smp_store_release()
barriers, can a concurrent RCU reader like bcm_proc_show() read the list
pointer before the CPU writes the kzalloc initialization, leading to a
wild pointer dereference?

> @@ -1221,6 +1243,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;
> =20

[Severity: Critical]
This is a pre-existing issue, but does bcm_rx_setup() suffer from a similar
data race as bcm_tx_setup()?

bcm_rx_setup() also modifies op->frames directly:

bcm_rx_setup()
  err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);

Can this be modified concurrently with bcm_rx_handler() without
synchronization?

[Severity: High]
This isn't a bug introduced by this patch, but does bcm_rx_setup() also ins=
ert
new elements into bo->rx_ops using list_add() without RCU barriers,
similar to bcm_tx_setup()?

[Severity: High]
This is a pre-existing issue, but does bcm_proc_show() safely traverse
the RCU list?

bcm_proc_show() iterates over the RCU-protected list bo->tx_ops:

bcm_proc_show()
  list_for_each_entry(op, &bo->tx_ops, list) {

Since list_for_each_entry() lacks the READ_ONCE() wrapper for fetching
pos->next, if bcm_delete_tx_op() deletes an element concurrently, could the
compiler reload the list pointer unpredictably and violate RCU safety
guarantees?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v12-0-61c06291bf1c@hartkopp.net?part=3D1

