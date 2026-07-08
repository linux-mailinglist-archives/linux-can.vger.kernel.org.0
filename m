Return-Path: <linux-can+bounces-8159-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SJ23Ll2LTmqDPAIAu9opvQ
	(envelope-from <linux-can+bounces-8159-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:39:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1FB7294AF
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 19:39:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="AbZ/8hCx";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8159-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8159-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6DF33002517
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 17:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3B35959;
	Wed,  8 Jul 2026 17:39:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE149550B
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 17:39:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532376; cv=none; b=ndMhaJ/zj/JUIMBhWyTyY/sqHfXF0YN7zi9Y8shxvUjyISApMlZVWwxVJ83ZSQ7AuHVWdoJCkQEPqba7SvGisi06gnhtS/wm4GdACNrZ+uY2zo5Yd33JjXQS5YejFjp5mvqHYHjpq+ZWUxJe/EMGz2kY7bKQvF1+Eae8iyLhdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532376; c=relaxed/simple;
	bh=CEJTuNLyw4hA9jLpz04VpC90Bvr+vOKz4m9ZP/2JRZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oLhbCYajlnsRLIKYpHsmRKO00WWW5qDxYg1e+2yQAexkOw2tNO9yHsGYKMHsLMnlPEuFDzqwuZKKPhgtyZ4fAViT0ITiWdtA/v62u/Nsi/M4bfVhlXrzr3UtSERp+dfvoq5qNWWOX3ny+j1gVbCdFRLTFbm2ssKGF17Gi16HtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbZ/8hCx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D021F000E9;
	Wed,  8 Jul 2026 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532375;
	bh=5g0Itg4BlN41/8O5cza7n8naD24+LMm9yXAFe8RoWMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AbZ/8hCx7DMFtuMR6+RFDTO0pwUTc30HXne9U4VfZt1xK701LqHy/WGtHH1O6dOeC
	 Y2V+FEUs3DqIEG22075LwFiDO4RB2HfbaooXg2JKGKtXNjul0cWtDpVyc6jDorp05P
	 ikDpcQvq+mPAlHqp30rVniumLTIOjbBKwROLbBCjXSuU7v4YqPsh4wq/kjUl0GZWTM
	 TDJ5Yl3T2PBvm4iMyOwBxaL3tWbcJ7eIzGhyftJjTLZ3hOjL7bQ6g39d44yv4LWrca
	 a+ugVvU/2AeuctWdBqwH8kYTZMYjRkcqqOXjZXL+ibxNZKH0B6LB8AVaxAJiNrgBwA
	 SMbDxNzhNF0Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/10] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260708-bcm_fixes-v8-4-8c2f5f3bc212@hartkopp.net>
References: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
 <20260708-bcm_fixes-v8-4-8c2f5f3bc212@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:39:34 +0000
Message-Id: <20260708173935.10D021F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8159-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:email,vger.kernel.org:from_smtp,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD1FB7294AF

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] `bcm_update_stats()` can be executed concurrently from different=
 lock domains, contradicting the commit's claim of preventing races during =
counter reset.
- [Medium] TX operations incorrectly inherit the RX-specific statistics cap=
, causing premature zeroing of the TX frame counter.

Pre-existing issues:
- [High] Unprotected modifications of `op->rx_stamp` and `op->rx_ifindex` i=
n `bcm_rx_handler()` lead to data races and torn writes of 64-bit metadata.
--

--- Patch [4]: [PATCH v8 04/10] can: bcm: fix CAN frame rx/tx statistics ---
commit 7e13c48f66a83858015c68aa3f0ac7aba6688936
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs. Use atomic operations with (signed) long data types to acce=
ss
the statistics in the hot path. Additionally simplify the update and check =
of
statistics overflow by using the atomic operations in a separate
bcm_update_stats() function and put this function under bcm_rx_update_lock
to prevent races when resetting the counters.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index af4bb4182bc29..340b7fc89744e 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -344,7 +357,7 @@ static void bcm_can_tx(struct bcm_op *op, struct canf=
d_frame *cf)
>  	spin_lock_bh(&op->bcm_tx_lock);
> =20
>  	if (!err)
> -		op->frames_abs++;
> +		bcm_update_stats(op);

[Severity: Medium]
Does this inadvertently inherit the RX-specific limit for the TX path?

TX operations don't use frames_filtered or calculate a reduction percentage,
so the LONG_MAX / 100 limit enforced inside bcm_update_stats() seems logica=
lly
unnecessary here. On 32-bit systems, does this artificially cap the TX sent
counter to 21.4 million frames before abruptly resetting to zero, whereas
prior to this patch it safely counted up to ULONG_MAX?

[Severity: Medium]
The commit message mentions putting bcm_update_stats() under
bcm_rx_update_lock to prevent races when resetting the counters. However,
is it possible for bcm_update_stats() to be called concurrently from
different lock domains?

If an RX operation is configured with RX_RTR_FRAME, it can receive multiple
RTR frames concurrently. bcm_rx_handler() calls bcm_update_stats() while
holding bcm_rx_update_lock. It then invokes bcm_can_tx() to send the reply,
which calls bcm_update_stats() right here while holding a DIFFERENT lock,
bcm_tx_lock:

bcm_rx_handler()
    spin_lock_bh(&op->bcm_rx_update_lock);
    bcm_update_stats(op);
    spin_unlock_bh(&op->bcm_rx_update_lock);
    ...
    bcm_can_tx()
        spin_lock_bh(&op->bcm_tx_lock);
        bcm_update_stats(op);

Could this allow the reset logic inside bcm_update_stats() to run
concurrently across two CPUs, leading to an inconsistent counter reset?

[ ... ]

> @@ -748,16 +758,19 @@ static void bcm_rx_handler(struct sk_buff *skb, voi=
d *data)
>  	op->rx_stamp =3D skb->tstamp;
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;
> -	/* update statistics */
> -	op->frames_abs++;
> =20
> -	/* snapshot the flag under lock: op->flags/op->frames may be updated
> -	 * concurrently by bcm_rx_setup().
> +	/* snapshot RTR content under lock: op->flags/op->frames may be
> +	 * updated concurrently by bcm_rx_setup().
>  	 */
>  	spin_lock_bh(&op->bcm_rx_update_lock);

[Severity: High]
This isn't a bug introduced by this patch, but while fixing the KCSAN data
race in bcm_rx_handler(), are op->rx_stamp and op->rx_ifindex still
vulnerable to concurrent torn writes?

These fields are written without any lock protection just before
bcm_rx_update_lock is acquired. If multiple CAN frames for the same RX
operation are received simultaneously on different CPUs, could the 64-bit
ktime_t timestamp tear on 32-bit systems? This might result in a wildly
incorrect timestamp value being passed to userspace via bcm_send_to_user()
along with misattributed network interfaces in the metadata.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v8-0-8c2f5f3bc212@hartkopp.net?part=3D4

