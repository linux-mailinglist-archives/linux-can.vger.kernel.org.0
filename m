Return-Path: <linux-can+bounces-8305-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PsVgLOEoUWrZAAMAu9opvQ
	(envelope-from <linux-can+bounces-8305-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 19:16:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE9273CF93
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 19:16:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EO654950;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8305-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8305-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5ABC30B94F3
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A472A1EEE6;
	Fri, 10 Jul 2026 17:02:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F28343C05B
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 17:02:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702962; cv=none; b=WP6AAM04E/rriYFEiDnpAZ2x1U8CMjihw7Mt+CKYAdBhdTv++39pq+DU9y7b0Ayfk4BINrJa6JAGplv+yMz5IM8zlQ4Pf7FSBOEJitykv22GEz40WvMeW2IGxZxZ1DBOEan99Qd3yXfrs0AlSqOQKKYr3taRhy8emk5VtqkQknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702962; c=relaxed/simple;
	bh=1az4nRUYuQnP55tAcSWqjuhl6ddxBg0GxpTfX1EBT2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ho7Vg5ODXk+E+M423S52jiv8umPdzgZvwLoi9kM+ttkGPZClVRIvpDkuL3OuwSakbsMCUeHqDd400GHbGyZsV2JajtkjkdgIcSWtBqAU/OVzkX3VOFxbOPA8ZKpU4jbAG+QkCxJOl2QtcMfED+4tJRc1WAQSKYQ7HydNKThj3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO654950; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681801F000E9;
	Fri, 10 Jul 2026 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702960;
	bh=NCxpo2nLjPAQUNBqXjTGYdB0iLbJRZlzTdM5/3U17XI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EO6549509jx4sWtdqxP7TCBtiYL28fuxb2klE5bAiRexCOUItU2sTXSqBgRGH5IDN
	 5JYUlHShCS7WcYeNtWBxdccQd2x0kgbWFnUGM6vZRhpVoLHf5zZXlwQBOaxIkSyW/z
	 4oLLs45mLUhfInpdomBUTt2ikR234/RYrj81Iudv4LFmNVUS1GOCZyzZqzXPlRf0SP
	 atiLPrMmuVNIoEDMM6R+0Y0xOeyapKpoP2GuLlOpDjvQ9+DMtdz6ePr/ZD8AwC21Pl
	 sM4TzpL/hDthJr1wOFlJpYUOmSesYxXrUyVtBMkdiwzAL19h9btk63bEjDOwO1+0Ry
	 /4cfRiAHYidhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] can: isotp: fix lock-free state transition in tx
 timer handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260710-isotp-fixes-v5-4-15174d82d6f1@hartkopp.net>
References: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
 <20260710-isotp-fixes-v5-4-15174d82d6f1@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:02:39 +0000
Message-Id: <20260710170240.681801F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8305-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DE9273CF93

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Missing READ_ONCE() on lockless state read allows compiler load =
tearing to defeat cmpxchg protection

Pre-existing issues:
- [High] TOCTOU vulnerability in RX handlers allows state machine corruptio=
n and out-of-bounds reads
- [High] Unsafe teardown order in error path releases state machine before =
canceling async timers
- [High] Premature state release causes misattribution of timeout errors to=
 concurrent transmissions
--

--- Patch [4]: [PATCH v5 4/4] can: isotp: fix lock-free state transition in=
 tx timer handler ---
commit 1142eb2123699c3ef59ba2ca431beca7fc493cd1
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix lock-free state transition in tx timer handler

Commit 051737439eae ("can: isotp: fix race between isotp_sendsmg() and
isotp_release()") introduced a lock-free state machine check
to prevent race conditions between the TX timer and concurrent state
updates. However, the original patch missed replacing the initial
state checks and left the late assignment of ISOTP_IDLE as a blind,
non-atomic write.

Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c0edbd35516cc..e49a58e188e6b 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -922,9 +922,16 @@ static enum hrtimer_restart isotp_tx_timer_handler(s=
truct hrtimer *hrtimer)
>  	struct isotp_sock *so =3D container_of(hrtimer, struct isotp_sock,
>  					     txtimer);
>  	struct sock *sk =3D &so->sk;
> +	u32 old_state =3D so->tx.state;

[Severity: Medium]
Could this lockless state read be subject to compiler load tearing without a
READ_ONCE()?

If the compiler decides to reload so->tx.state directly into the cmpxchg
macro arguments under register pressure, and the state changes concurrently
(e.g., to ISOTP_SENDING), wouldn't the reloaded value cause cmpxchg to comp=
are
the new state against itself?

Could this blind success erroneously abort the new transmission?

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

[Severity: High]
This isn't a bug introduced by this patch, but does releasing the state
machine ownership here cause misattribution of timeout errors to concurrent
transmissions?

Since the state is transitioned to ISOTP_IDLE before setting sk->sk_err and
calling wake_up_interruptible(), could a concurrent sender claim ISOTP_SEND=
ING
in this window?

If so, when the wait queue is woken, the original timed-out thread might wa=
ke
up, see the state is no longer ISOTP_IDLE, and go back to sleep.

Could the new sender later complete successfully but read the stale
sk->sk_err =3D ECOMM left by the timer, consuming the error, while the orig=
inal
thread eventually wakes up and incorrectly reads success?

>  		return HRTIMER_NORESTART;
> =20
>  	/* we did not get any flow control or echo frame in time */
> @@ -934,8 +941,6 @@ static enum hrtimer_restart isotp_tx_timer_handler(st=
ruct hrtimer *hrtimer)
>  	if (!sock_flag(sk, SOCK_DEAD))
>  		sk_error_report(sk);
> =20
> -	/* reset tx state */
> -	so->tx.state =3D ISOTP_IDLE;
>  	wake_up_interruptible(&so->wait);
> =20
>  	return HRTIMER_NORESTART;

[Severity: High]
This is a pre-existing issue, but while reviewing the state machine changes,
is there a TOCTOU vulnerability in the RX handlers?

Looking at isotp_rcv_fc() in net/can/isotp.c:

    if (so->tx.state !=3D ISOTP_WAIT_FC && ...)
        return 0;
    hrtimer_cancel(&so->txtimer);
    // ... blindly proceeds to send

The state is checked before the blocking hrtimer_cancel() and never
re-verified.

If a concurrent timeout aborts the transmission (setting state to ISOTP_IDL=
E)
while the RX thread is blocked in hrtimer_cancel(), and a new thread enters
isotp_sendmsg(), claims ISOTP_SENDING, and begins mutating so->tx.buf, what
happens when hrtimer_cancel() unblocks?

Would the RX handler blindly assume its earlier state check is still valid,
overwrite the state, and call isotp_send_cframe(), reading from the new
thread's partially initialized buffer?

A similar pattern appears in isotp_rcv_echo():

    if (skb->sk !=3D sk || so->cfecho !=3D *(u32 *)cf->data)
        return;
    hrtimer_cancel(&so->txtimer);
    // ... checks state but cfecho check was bypassed

The cfecho validation occurs before hrtimer_cancel(), allowing a concurrent
new transmission to slip past the check.

[Severity: High]
This is a pre-existing issue, but does isotp_sendmsg() have an unsafe
teardown order in its error path?

Looking at err_event_drop in isotp_sendmsg():

    err_event_drop:
        /* got signal: force tx state machine to be idle */
        so->tx.state =3D ISOTP_IDLE;
        hrtimer_cancel(&so->txfrtimer);
        hrtimer_cancel(&so->txtimer);

If isotp_sendmsg() is interrupted by a signal, it sets so->tx.state =3D
ISOTP_IDLE before canceling the asynchronous timers.

Could a concurrent thread immediately enter isotp_sendmsg(), claim the stat=
e,
and start configuring so->tx?

If so, could the original thread's un-canceled txfrtimer then fire, see the
new thread's ISOTP_SENDING state, and prematurely call isotp_send_cframe() =
on
the new thread's incomplete buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v5-0-15174d82d6f1@hartkopp.net?part=3D4

