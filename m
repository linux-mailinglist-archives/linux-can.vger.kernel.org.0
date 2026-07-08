Return-Path: <linux-can+bounces-8122-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BVUmEuMaTmpzDQIAu9opvQ
	(envelope-from <linux-can+bounces-8122-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:39:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F74F723D3D
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 11:39:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n7XrEI5G;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8122-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8122-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAA2C30068CE
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AA01A5B9E;
	Wed,  8 Jul 2026 09:39:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93EA1991CB
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:39:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503583; cv=none; b=YlW3awSvWvhIYE+Om01oIg4rImNqeKGF8GRqnCKEb93IuBJo3d9TcD6TMVX/l4stp1SRDUGqrjgwQE4+m1j7OPYt4/1LsceRG76gAi65EmT87VP0NVmWG2hkaIEE1lung8rbVMSIyJX38p0TeilrjfwkP4zxu9/tjfDEYxmUtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503583; c=relaxed/simple;
	bh=/EvOZALmegcNwyTI1+9al7bbm0WszMsL6sV8ltv8xh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oIAJe6XVy5+j5xmRBp9yrZ04togzzH9bpiFmm7jlWY5dxByMrQ8TSspJWdBzcuzkd/sxE/qQfEcJK7cxbYb91JWnmhKhHAQbMbTw8CiZG85+l6jY0pCQlMqYPvdKH/X6UcthE7f/B5tWhCh6uSG7lZSpHX/gPpwHP6xc+xD4W8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7XrEI5G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D9C1F000E9;
	Wed,  8 Jul 2026 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503581;
	bh=CZaGdVDYvsnHICrv8n3kQ28Z2qwNT2cVM5kQN0+ve0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7XrEI5Ggzugs1sPzfv8i5Xx03/x86K5J2V3pQh6s/PKPNvA71or5vUMEwyb9f0n0
	 6C/zwSxZaRqjr1LUBfm98tQogZhF0o0mR1lIt3uJbA1rHB2lucbAbqhywkOgnpdDoH
	 nNuemYIvR88eDne+iudfhTKc6tNirdP52ZptcZb8RUzTlsPh3HErabk0Hg25w2UqDc
	 1DeCYEeIWSRSdY5qGSKAATUDtwzy+nLWBbwNzuBUOBV2T9aOp1Ji9gcxkRPcJ2h58S
	 3ZBydCYJ4mv80Z897IxQGwD99xXpK8RN+CsYeqz0wwBQRoUT5FnxgNGCBWdJ6YeNnw
	 0PwiTQWfycQLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260708-bcm_fixes-v6-4-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
 <20260708-bcm_fixes-v6-4-80710a2bc398@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:39:40 +0000
Message-Id: <20260708093941.33D9C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8122-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F74F723D3D

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The split of statistic updates across two separate spinlock crit=
ical sections in bcm_rx_handler allows frames_filtered to persistently exce=
ed frames_abs after a counter reset, breaking their invariant and causing n=
egative reduction percentages.

Pre-existing issues:
- [High] Concurrent, lockless updates to op->rx_stamp and op->rx_ifindex in=
 bcm_rx_handler() cause data races and potential torn writes.
--

--- Patch [4]: [PATCH v6 4/9] can: bcm: fix CAN frame rx/tx statistics ---
commit fb8c8dc88e31fc268389c46d858c779a051a866c
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs.

Use atomic operations with (signed) long data types to access the
statistics in the hot path to fix the KCSAN complaint.

Additionally simplify the update and check of statistics overflow by
using the atomic operations in a separate bcm_update_stats() function and
put this function under bcm_rx_update_lock to prevent races when resetting
the counters.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index af4bb4182bc29..340b7fc89744e 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -497,12 +510,9 @@ static void bcm_rx_changed(struct bcm_op *op, struct=
 canfd_frame *data)
>  {
>  	struct bcm_msg_head head;
> =20
> -	/* update statistics */
> -	op->frames_filtered++;
> -
> -	/* prevent statistics overflow */
> -	if (op->frames_filtered > ULONG_MAX/100)
> -		op->frames_filtered =3D op->frames_abs =3D 0;
> +	/* update statistics (frames_filtered <=3D frames_abs) */
> +	if (atomic_long_read(&op->frames_abs))
> +		atomic_long_inc(&op->frames_filtered);

[Severity: Medium]
With the statistic updates now split across two separate lock regions in
bcm_rx_handler(), is it possible for frames_filtered to exceed frames_abs?

If Thread A calls bcm_update_stats() in the first lock region and triggers
the counter reset, then releases the lock, could Thread B interleave and
increment frames_abs to 1 before Thread A reaches the second lock region?

When Thread A subsequently calls bcm_rx_changed() in the second lock region,
it would observe frames_abs =3D=3D 1 and increment frames_filtered (for the
frame that already caused the reset).

If Thread B then enters the second lock region and also increments
frames_filtered, wouldn't frames_filtered become larger than frames_abs?

When read by bcm_proc_show(), would this cause the reduction calculation
(100 - (frames_filtered * 100) / frames_abs) to yield a negative percentage?

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
This isn't a bug introduced by this patch, but since bcm_rx_handler() can be
executed concurrently on multiple CPUs for the same bcm_op, can these lockl=
ess
updates to op->rx_stamp (a 64-bit ktime_t) and op->rx_ifindex cause data ra=
ces?

If so, could this lead to torn writes on 32-bit platforms, causing corrupted
timestamps and interface indices to be sent to userspace?

> +
> +	/* update statistics with lock analogue to bcm_rx_changed() callers */
> +	bcm_update_stats(op);
> +
>  	rtr_frame =3D op->flags & RX_RTR_FRAME;
>  	if (rtr_frame)
>  		memcpy(&rtrframe, op->frames, op->cfsiz);
> +
>  	spin_unlock_bh(&op->bcm_rx_update_lock);
> =20
>  	if (rtr_frame) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v6-0-80710a2bc398@hartkopp.net?part=3D4

