Return-Path: <linux-can+bounces-8314-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3uhvGLtbUWo+DAMAu9opvQ
	(envelope-from <linux-can+bounces-8314-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:53:15 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A245573E7DF
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:53:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M5MM1lT3;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8314-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8314-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B683002F9A
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B26385D61;
	Fri, 10 Jul 2026 20:52:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C067380FCA
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 20:52:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716774; cv=none; b=lbQ5jdjZn2gnsBzPU5B8Kks9k6twOvPhrts9dWqothr5uR7aRwnc+ZUWP8DVoiQECMfVo5AQDh8jyc4KpFfnIqhEKi6GjpTS2QlEkO1j+poyzcaztIzPhbMf97CamLv+zAvNy9MXKU/xhFY1R5HYaAGTXghS2pK4gxC0T98uYvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716774; c=relaxed/simple;
	bh=C3bY4eiMPOmE6/iWHDshA2cSQhwUbGAca7AQnVWLy5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/SROeZQMKYzFqv8uviI8rd18OJI8OwduaKLAdyAaKtcxGGlDvwTpXB9/rBw2UlEOSEH37F50poJsoin5aoulKcIlksfnnQno67KvXOkBU61aXFpuyfxtjRKdsbCiigCcn1lcoqzEg8Hrp9HzKuYr8WL73q0n3pVCu8QPLIXHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5MM1lT3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B0C1F000E9;
	Fri, 10 Jul 2026 20:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783716772;
	bh=HbUlGyZ1LIqVWtDvJ6yhcPMdRhAqAPUIQKeaCkbi1Ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M5MM1lT3Kbz0xMPAwQoMqxwhessz2rY+5wKxYxA/I+7ds85I6NWavNt/Td1i6Z5Jg
	 D1o2W/g45KmjWLD0/x/nuTvw7YOHOf4CBx7EzUDn1VF92SvCQEo80x7xLxG7rBEKfN
	 EYvZFluDXr9TMOVe/b1wYo8EhEycKcyZKr45iPaQfYPmiF0AwmS2Aom9zSz4tta0wj
	 Jp+UfHmQhuwfTnu5KKUFS0LE5oZ7nNemlYxd504XXYmzsB0YWf+j951TEvoR4wDPen
	 weQSLBFF3QlWR4d3Bw310BvtZ94MaBPt5NBO4CrUN7BIA+tidnoXC3ZDVI6P6nEeUi
	 2bYX8HhxFkR2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] can: isotp: fix state machine corruption on
 signal interruption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260710-isotp-fixes-v6-5-a13c2539093d@hartkopp.net>
References: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
 <20260710-isotp-fixes-v6-5-a13c2539093d@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 20:52:52 +0000
Message-Id: <20260710205252.92B0C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8314-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,hartkopp.net:email,vger.kernel.org:from_smtp,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A245573E7DF

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Signal interruption of a transmission (e.g., during CAN_ISOTP_WAIT=
_TX_DONE) or a TX timeout aborts an active transmission by forcing state to=
 ISOTP_IDLE but fails to clear `so->cfecho`. This exposes a race condition =
with delayed local loopback echoes that can leak uninitialized kernel heap =
memory or corrupt subsequent transmissions.
--

--- Patch [5]: [PATCH v6 5/5] can: isotp: fix state machine corruption on s=
ignal interruption ---
commit 0fb83cf387b5c9feb7682bf6c41fda7dbcb7b3d2
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix state machine corruption on signal interruption

If a thread blocked in isotp_sendmsg() waiting for a previous transfer
to finish is interrupted by a signal, jumping to the cleanup labels
incorrectly cancels active timers and forces 'so->tx.state' back to
ISOTP_IDLE. Since this thread never owned the active transmission, it
abruptly aborts another thread's legitimate transfer, so return the
interruption error directly.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 0826ae8372467..b8562f8c6de04 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1007,7 +1007,7 @@ static int isotp_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  		/* wait for complete transmission of current pdu */
>  		err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_I=
DLE);
>  		if (err)
> -			goto err_event_drop;
> +			return err;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does resetting the state to=
=20
ISOTP_IDLE without clearing so->cfecho expose a race condition with delayed=
=20
local loopback echoes?

For example, if a transmission is interrupted during CAN_ISOTP_WAIT_TX_DONE=
,=20
the wait loop is aborted and the state is reset:

net/can/isotp.c:isotp_sendmsg() {
    ...
err_event_drop:
	/* got signal: force tx state machine to be ISOTP_IDLE */
	hrtimer_cancel(&so->txfrtimer);
	hrtimer_cancel(&so->txtimer);
err_out_drop:
	/* drop this PDU and unlock a potential wait queue */
	so->tx.state =3D ISOTP_IDLE;
	wake_up_interruptible(&so->wait);

	return err;
}

Similarly, a TX timeout resets the state without clearing so->cfecho:

net/can/isotp.c:isotp_tx_timer_handler() {
    ...
	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) !=3D old_state)
		return HRTIMER_NORESTART;

	/* we did not get any flow control or echo frame in time */
    ...
}

If a user starts a new transmission with a payload larger than so->tx.bufle=
n,
the kernel sets so->tx.state to ISOTP_SENDING and allocates a new uninitial=
ized
buffer.=20

If a delayed loopback echo from the aborted transmission arrives at this ti=
me,=20
could it be erroneously processed by the echo handler?

net/can/isotp.c:isotp_rcv_echo() {
    ...
	/* local echo skb with consecutive frame has been consumed */
	so->cfecho =3D 0;

	/* isotp_tx_timer_handler() may have raced us for so->tx.state while
	 * hrtimer_cancel() above waited for it to finish, already reporting
	 * the tx error and resetting the state; don't resume a tx job that
	 * has already been given up on.
	 */
	if (so->tx.state !=3D ISOTP_SENDING)
		return;

	if (so->tx.idx >=3D so->tx.len) {
		/* we are done */
    ...
}

Because so->cfecho still matches and so->tx.state is now ISOTP_SENDING, cou=
ld
this result in transmitting uninitialized kernel heap memory over the CAN b=
us
by continuing transmission using the old so->tx.idx and so->tx.len but the =
new
uninitialized so->tx.buf?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v6-0-a13c2539093d@hartkopp.net?part=3D5

