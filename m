Return-Path: <linux-can+bounces-8181-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id phHbMwpeT2o+fQIAu9opvQ
	(envelope-from <linux-can+bounces-8181-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 10:38:34 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 223F272E60C
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 10:38:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bXr0Viru;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8181-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8181-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0778730F4602
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611863F1AA8;
	Thu,  9 Jul 2026 08:31:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA413F5BEC
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 08:31:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585881; cv=none; b=SiU2AXfipeqYGc0LsSfKFqza7c8AeKjMUWWMzCInQOuTlbvNkEb7WN6w1hRAgahpsiKbvxC/AIjZYg3jL3HlCRU/W/NbEQ9M9XUfsNiUV+GMdvJY8HV7JWoDFnlhqqynsGgJfhTF2e2BKbknqqPb89xFzmlkDMtekh4gSBQCmRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585881; c=relaxed/simple;
	bh=hlz5WsWqttTCnDcQCmDctM9HWMV4ezazAvT3rLoXexk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z2vq1eVwr0aEdlHudwkZUnPFddeZ+FVRnCVVBUupB87csMLEZ2LNtw/ySKFK6fT08DPyeUGjYvXKoejWkgx+eSKHBaNLWy47prEf2D+VLvenQVvEtLteCnzio6hz4KIla+VPQcEcVAtKbMkJUcnBKzUnaMlwCRQd9GIKyG24RoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXr0Viru; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015901F00A3D;
	Thu,  9 Jul 2026 08:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783585879;
	bh=HCsyHlDrLa+cx5hNT3C9TK/NEAt8K7dwK8nvoIUBZ1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bXr0Viru8lWuRCtZsGNfZAaQcSWM6fLXzoinQK6oGAX6nhAhLDCRwm/V7micE5350
	 vrkapytK9QiwmvSuP6p1fOd123XnVPaeVTuG2bYrx7A61eSJSDSOD2GILwOd6YznAC
	 Gfvs/awmZZqJghk99RC9hrCwtzOSHYullHx1tyrEevQQhx+KYarY4PMULV8Gx+hE6x
	 snyy2upgJIsKgl/qfC8yBztS/LjSldD6rR6BCSk+fK7BeOuBNFEi5HrDeXbYJn0HPz
	 kuOkyIg6GAF12QuR5Fd9xv6gnrZ8Q7ykbPCNcQrOgNBfQ+S0C134tCrw/kv2VBkLR6
	 YcKef6oxvGjDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/10] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v9-4-6eebb78ccfb2@hartkopp.net>
References: <20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net>
 <20260709-bcm_fixes-v9-4-6eebb78ccfb2@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:31:18 +0000
Message-Id: <20260709083119.015901F00A3D@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8181-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:email,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 223F272E60C

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Lock dropping in bcm_rx_handler() allows frames_filtered to temp=
orarily exceed frames_abs, breaking the invariant and causing negative redu=
ction percentage calculations.

Pre-existing issues:
- [High] bcm_tx_setup modifies ktime_t timers, flags, and frames without ho=
lding bcm_tx_lock, allowing concurrent timers to read torn or corrupted dat=
a.
- [High] bcm_rx_handler races on op->rx_stamp and op->rx_ifindex updates ou=
tside bcm_rx_update_lock.
- [High] list_add() is used instead of list_add_rcu() when adding newly ini=
tialized bcm_op elements to the RCU-protected lists bo->tx_ops and bo->rx_o=
ps.
--

--- Patch [4]: [PATCH v9 04/10] can: bcm: fix CAN frame rx/tx statistics ---
commit fe57f26f76b6c7f7c4b5702be973bf0265c694f1
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

This commit fixes a KCSAN data race complaint in the broadcast manager
receive handler when two CAN frames are processed simultaneously. It
switches to atomic types for statistics and refactors overflow handling.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index af4bb4182bc29..1623a402600ce 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -229,10 +229,13 @@ static int bcm_proc_show(struct seq_file *m, void *=
v)
> =20
>  	list_for_each_entry_rcu(op, &bo->rx_ops, list) {

[Severity: High]
This isn't a bug introduced by this patch, but is it safe for bcm_rx_setup()
and bcm_tx_setup() to use list_add() when inserting new elements into these
lists?

Since bcm_proc_show() iterates over bo->rx_ops and bo->tx_ops using
list_for_each_entry_rcu(), using list_add() instead of list_add_rcu() during
insertion lacks the necessary memory barriers. Could this allow concurrent
RCU readers on weakly ordered architectures to observe uninitialized fields?

[ ... ]

> @@ -344,7 +366,7 @@ static void bcm_can_tx(struct bcm_op *op, struct canf=
d_frame *cf)
>  	spin_lock_bh(&op->bcm_tx_lock);
> =20
>  	if (!err)
> -		op->frames_abs++;
> +		bcm_update_tx_stats(op);
> =20
>  	op->currframe++;

[Severity: High]
This is a pre-existing issue, but does bcm_tx_setup() need to hold this same
bcm_tx_lock when modifying op->frames, op->flags, and the ktime_t timers?

When a user calls bcm_sendmsg() to update an existing TX op, these values a=
re
modified without the lock. If a concurrent timer fires bcm_tx_timeout_handl=
er()
or transmission occurs here via bcm_can_tx(), could it result in torn reads=
 of
64-bit ktime_t timers on 32-bit systems, or the transmission of partially
updated CAN frames?

[ ... ]

> @@ -748,16 +767,19 @@ static void bcm_rx_handler(struct sk_buff *skb, voi=
d *data)
>  	op->rx_stamp =3D skb->tstamp;
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This is a pre-existing issue, but can these unprotected assignments cause a
metadata race?

If a socket is subscribed to all interfaces (ifindex =3D=3D 0) and two fram=
es are
received simultaneously on different interfaces, couldn't different CPUs
concurrently overwrite op->rx_stamp and op->rx_ifindex outside of
bcm_rx_update_lock? This might result in corrupted stream metadata when the
frames are eventually sent to userspace.

> -	/* update statistics */
> -	op->frames_abs++;
> =20
> -	/* snapshot the flag under lock: op->flags/op->frames may be updated
> -	 * concurrently by bcm_rx_setup().
> +	/* snapshot RTR content under lock: op->flags/op->frames may be
> +	 * updated concurrently by bcm_rx_setup().
>  	 */
>  	spin_lock_bh(&op->bcm_rx_update_lock);
> +
> +	/* update statistics with lock analogue to bcm_rx_changed() callers */
> +	bcm_update_rx_stats(op);
> +
>  	rtr_frame =3D op->flags & RX_RTR_FRAME;
>  	if (rtr_frame)
>  		memcpy(&rtrframe, op->frames, op->cfsiz);
> +
>  	spin_unlock_bh(&op->bcm_rx_update_lock);

[Severity: Medium]
Can dropping the lock here allow frames_filtered to exceed frames_abs?

CPU 1 could increment frames_abs past the limit (LONG_MAX / 100) and reset
both counters to 0 inside bcm_update_rx_stats(), then drop the lock.

CPU 2 could then process a packet, acquire the lock, increment frames_abs to
1, and drop the lock.

Both CPUs would then proceed to their second lock section where
bcm_rx_changed() is called. Both would increment frames_filtered because
frames_abs is non-zero, leaving frames_filtered at 2 while frames_abs is 1.
Wouldn't this break the invariant and cause a negative reduction percentage=
 to
be displayed in procfs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v9-0-6eebb78ccfb2@hartkopp.net?part=3D4

