Return-Path: <linux-can+bounces-8327-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4dueEck0Ump5NAMAu9opvQ
	(envelope-from <linux-can+bounces-8327-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:19:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B57417CE
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EAklxaNt;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8327-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8327-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9948C300B9A0
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F368E3921E7;
	Sat, 11 Jul 2026 12:19:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49851E5B63
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 12:19:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772358; cv=none; b=DyzJHFd+gZO2EXRMo2pBpEsFAuIss1+NwZQQqr3OtcB2DkdVs5dtnx7YAHQNNQvl56xkazTgVt41pGjm8KzmoVo9tLPiT8klhzxhj/Nvg+ggQpFAQtunmZBcqjLSuttSNX+heV5WhlHiJc7poXuFMthuKWfp7+aRGY+ML+tbn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772358; c=relaxed/simple;
	bh=8sN/KX0aLWk5JT4ly5lxqVAABYJA1yTcvj7Z4XMdT9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozOnhGTNKip1IfKpwUjYG+ncQ6NI6C6vKSiGQhJYAzNYr/Wx9pzhM7G30kg/1oyJjMWvxS5l497NZenRSSFbqmjBmq1Sb7ZJ0+7mfIhCFXdMemSd4Kzd4Wpbu3BfAmSKl5mIX8d8yoOFIUIZ7wQjGoX1JwtolI0roEND2u8wwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAklxaNt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065961F000E9;
	Sat, 11 Jul 2026 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783772357;
	bh=j+opy3n4qLWMWglQSzgV+8wFQKXwtOaf12NRt58tT6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EAklxaNtE1iJWALZxuEoBWnV76NFvfjFrT980soiWFykcM8Us0D2BaalEclY4SIEn
	 JAVf/ILj1fSeKeLlqT+fvDFohBTXE/ZEysDp/XmgCBlB092jTksNUczzNO2ib7wtGY
	 UdFzvMzFHP2hjotb8gyC7CZhCEsPSWHUzKhPaik5u40z0tQKs2RuOPGRh/FwPvC9Gb
	 64ZMrsiY+RuPKJQ8ztadhXDk+SlAOLDCj/nV2sskpKa3Mj3IzAKYVhWzlghkcHpM8e
	 gqH97JxMuow/4hqI6QqagzclZ5W4rfAVKm3lpvHWH2bFaKWzK8scZXGZ04yZELZ2su
	 wLe3xoOPq46xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] can: isotp: fix lock-free state transition in tx
 timer handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260711-isotp-fixes-v7-4-f03af24d8397@hartkopp.net>
References: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
 <20260711-isotp-fixes-v7-4-f03af24d8397@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 12:19:16 +0000
Message-Id: <20260711121917.065961F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8327-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:email,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A94B57417CE

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Silent suppression of timeout errors in isotp_tx_timer_handler lea=
ds to false success reports.
- [High] isotp_sendmsg evaluates an uninitialized variable and unconditiona=
lly cancels the timers of an unrelated active transmission when interrupted=
 by a signal.
- [Medium] Time-of-Check to Time-of-Use race in isotp_tx_timer_handler fals=
ely taints new transfers with ECOMM.

Pre-existing issues:
- [High] Incomplete fix for lock-free state transitions leaves identical vu=
lnerable blind writes in isotp_rcv_echo, isotp_rcv_fc, and isotp_sendmsg.
--

--- Patch [4]: [PATCH v7 4/5] can: isotp: fix lock-free state transition in=
 tx timer handler ---
commit b88e08d8412be9198adca1f2fc2749aff27ff947
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix lock-free state transition in tx timer handler

Commit 051737439eae introduced a lock-free state machine check to
prevent race conditions between the TX timer and concurrent state
updates. However, the original patch missed replacing initial state
checks and left the late assignment of ISOTP_IDLE as a blind write.
Fix this by sampling the initial state and using cmpxchg() to
atomically move to ISOTP_IDLE, safely bailing out if the timeout is
stale.

Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index f05703ddd2eae..fdb2109d7c27e 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -942,20 +942,33 @@ static enum hrtimer_restart isotp_tx_timer_handler(=
struct hrtimer *hrtimer)
>  	struct isotp_sock *so =3D container_of(hrtimer, struct isotp_sock,
>  					     txtimer);
>  	struct sock *sk =3D &so->sk;
> +	u32 gen =3D READ_ONCE(so->tx_gen);
> +	u32 old_state =3D READ_ONCE(so->tx.state);
> =20
>  	/* don't handle timeouts in IDLE or SHUTDOWN state */
> -	if (so->tx.state =3D=3D ISOTP_IDLE || so->tx.state =3D=3D ISOTP_SHUTDOW=
N)
> +	if (old_state =3D=3D ISOTP_IDLE || old_state =3D=3D ISOTP_SHUTDOWN)
> +		return HRTIMER_NORESTART;
> +
> +	/* Only claim timeout if state is unchanged to avoid overwriting
> +	 * concurrent state updates from isotp_sendmsg/isotp_rcv_echo.
> +	 */
> +	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) !=3D old_state)
>  		return HRTIMER_NORESTART;

[Severity: Medium]
When the timer handler successfully releases the state machine to ISOTP_IDLE
here, doesn't it open a race window?

If a concurrent isotp_sendmsg() claims the state (ISOTP_SENDING), but hasn't
yet bumped so->tx_gen, the old generation matches the check below, and the =
new
transfer is falsely tainted with ECOMM.

> =20
>  	/* we did not get any flow control or echo frame in time */
> =20
> -	/* report 'communication error on send' */
> -	sk->sk_err =3D ECOMM;
> -	if (!sock_flag(sk, SOCK_DEAD))
> -		sk_error_report(sk);
> +	/* Once the cmpxchg() above released ISOTP_IDLE, a concurrent
> +	 * sendmsg() may already have claimed it for a new transfer
> +	 * (tx_gen changed); don't taint that new transfer with an error
> +	 * that belongs to the one that just timed out.
> +	 */
> +	if (READ_ONCE(so->tx_gen) =3D=3D gen) {
> +		/* report 'communication error on send' */
> +		sk->sk_err =3D ECOMM;
> +		if (!sock_flag(sk, SOCK_DEAD))
> +			sk_error_report(sk);
> +	}

[Severity: High]
If a concurrent isotp_sendmsg() immediately claims the socket and updates
tx_gen before this check, the ECOMM error is skipped entirely.=20

Does this mean the timeout error is silently suppressed, and an application
waiting for the transfer to finish is falsely notified of success (returning
byte size instead of error)?

> =20
> -	/* reset tx state */
> -	so->tx.state =3D ISOTP_IDLE;
>  	wake_up_interruptible(&so->wait);
> =20
>  	return HRTIMER_NORESTART;


[Severity: High]
This is a pre-existing issue, but do other paths still perform non-atomic
blind writes to ISOTP_IDLE?

For instance, in isotp_rcv_echo():

net/can/isotp.c:isotp_rcv_echo() {
    ...
	if (so->tx.state !=3D ISOTP_SENDING || READ_ONCE(so->tx_gen) !=3D gen)
		return;

	if (so->tx.idx >=3D so->tx.len) {
		/* we are done */
		so->tx.state =3D ISOTP_IDLE;
		wake_up_interruptible(&so->wait);
		return;
	}
    ...
}

If this thread is preempted or delayed immediately after checking tx_gen, a=
nd
the timer handler runs and releases the state so a new transfer can start,
could the delayed thread wake up and blindly force the new transfer's state
to ISOTP_IDLE?

A similar blind write to ISOTP_IDLE occurs in isotp_rcv_fc():

net/can/isotp.c:isotp_rcv_fc() {
    ...
	default:
		/* stop this tx job */
		so->tx.state =3D ISOTP_IDLE;
		wake_up_interruptible(&so->wait);
	}
    ...
}


[Severity: High]
Is there a problem with uninitialized variables and unconditional timer
cancellations in the error paths of isotp_sendmsg()?

net/can/isotp.c:isotp_sendmsg() {
    ...
		/* wait for complete transmission of current pdu */
		err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_IDLE=
);
		if (err)
			goto err_event_drop;
	}

	/* new transfer: bump generation and drop any echo tag left behind
	 * by a previously aborted transfer
	 */
	my_gen =3D so->tx_gen + 1;
    ...
err_event_drop:
	/* got signal: cancel timers before touching state, so a concurrent
	 * sendmsg() can't claim ISOTP_SENDING while a stale timer is armed
	 */
	hrtimer_cancel(&so->txfrtimer);
	hrtimer_cancel(&so->txtimer);
err_out_drop:
	/* drop this PDU and unlock a potential wait queue, but only if no
	 * concurrent sendmsg() has since claimed the socket for a new
	 * transfer while we were cancelling timers above
	 */
	if (READ_ONCE(so->tx_gen) =3D=3D my_gen) {
		so->cfecho =3D 0;
		so->tx.state =3D ISOTP_IDLE;
	}
    ...
}

If wait_event_interruptible() is interrupted by a signal, it jumps to
err_event_drop. At this point, my_gen is uninitialized. The code then evalu=
ates
if (READ_ONCE(so->tx_gen) =3D=3D my_gen), which compares against uninitiali=
zed
stack memory.

Furthermore, could calling hrtimer_cancel() unconditionally here cancel the
active timers of an unrelated, ongoing transmission that currently owns the
socket?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-isotp-fixe=
s-v7-0-f03af24d8397@hartkopp.net?part=3D4

