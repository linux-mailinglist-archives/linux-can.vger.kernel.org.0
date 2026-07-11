Return-Path: <linux-can+bounces-8329-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R+bJOtk1UmqSNAMAu9opvQ
	(envelope-from <linux-can+bounces-8329-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:23:53 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 430197417DC
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:23:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="eogiO/cr";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8329-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8329-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04F77301186A
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926463A5E7B;
	Sat, 11 Jul 2026 12:23:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6E233941
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 12:23:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772631; cv=none; b=ZpXIWiX7Vce/7emY7UX1Ta18BUxUEQxJhmO4rTxT3TPgPsD79yx5VDGaJAd0WvVvSNdkgTfq4cRXRpZnRq+pGMhqa858AVxOCqUEm8jWdfH3SGNWzhBROi1V09GXyzM0Q/5+cDySNLNXGOCpNGuq8j0sBGKHerAKZ6NOGpPFfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772631; c=relaxed/simple;
	bh=C5jR8WSRAJ1jzcKy4aEwFzZcqTAYngrzTs8vzI4KaYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qkBBx8enosuNTsJvpcAuvuuXdbrwobA/D6HFGtzYPTBQSXPP0zqjcWF5oGKvXZtdP23Bj5GxbQWoVrgRW2cpJvXfbSmxbEf9ofw5s0KcEgzt8woWe/ou/rmFWPPL78232+ACx2BZ8dqHNRb+h18llFP+bRmqZdUnx1M8t/jvY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eogiO/cr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935511F000E9;
	Sat, 11 Jul 2026 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783772629;
	bh=3IY8WBEx+qXtxc7mvshIGBwwSLcJm9rQ17nX3bIj648=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eogiO/cr8NGAsfdJvAXy1HZl74hFG/FjsbMwwbBiRmuOOYWTpZmnds69rAUBrxTN+
	 fQQEaXJFlFSg5M8j0FPMJv+rDxcRJ4ZB2bD/vF/yR8iyUDBqYn/+1wFYjVobYks+We
	 CqegYa9f3TeCEJi9jArJFAVfqd4c8kFq+/v5MTAX15zxKtk+qpkx5s9eVIkMbtkPzq
	 lWeZKTTDeMaMnRaLiPqfnQgb/VbBTkQX+l2AamK92ZtZSmI7qvI32u/p4ak6lJTkrS
	 vrNhuMlwY7vVmPoHhkddFz0ngMiblewPE0G2IpBCefQBX3sq/knDFBm0cvAVY+8/2x
	 ABDmi9n0x1OnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] can: isotp: fix race between RX/TX timers and
 frame reception
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260711-isotp-fixes-v7-3-f03af24d8397@hartkopp.net>
References: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
 <20260711-isotp-fixes-v7-3-f03af24d8397@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 12:23:49 +0000
Message-Id: <20260711122349.935511F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8329-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hartkopp.net:email,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 430197417DC

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Time-of-check to time-of-use (TOCTOU) race in `err_out_drop` corru=
pts the state of concurrent transfers.
- [High] Reordering timer cancellation before state reset allows RX handler=
s to re-arm stale timers on an idle socket.
- [High] Missing memory barrier in `err_out_drop` allows store reordering, =
causing data corruption.
- [High] Suppressing the timeout error in the TX timer handler causes false=
 success and indefinite blocking.

Pre-existing issues:
- [High] `hrtimer_cancel()` calls in RX paths race with concurrent `sendmsg=
()`, permanently hanging new transfers.
- [High] `isotp_rcv_echo()` unconditionally clears `cfecho` before generati=
on validation, corrupting new transfers.
--

--- Patch [3]: [PATCH v7 3/5] can: isotp: fix race between RX/TX timers and=
 frame reception ---
commit c41687d56855df1b5e33cb5d7468ecf5646f96cd
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix race between RX/TX timers and frame reception

This commit addresses a race where hrtimer_cancel() waits for a concurrent
timer handler to finish, potentially allowing the handler to reset the state
machine. It introduces a generation counter to disambiguate new transfers
from aborted ones.

Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 44c044eb83e12..f05703ddd2eae 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
[ ... ]
> @@ -371,6 +372,7 @@ static void isotp_send_cframe(struct isotp_sock *so);
>  static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, i=
nt ae)
>  {
>  	struct sock *sk =3D &so->sk;
> +	u32 gen =3D READ_ONCE(so->tx_gen);
> =20
>  	if (so->tx.state !=3D ISOTP_WAIT_FC &&
>  	    so->tx.state !=3D ISOTP_WAIT_FIRST_FC)
> @@ -378,6 +380,15 @@ static int isotp_rcv_fc(struct isotp_sock *so, struc=
t canfd_frame *cf, int ae)
> =20
>  	hrtimer_cancel(&so->txtimer);
> =20

[Severity: High]
This is a pre-existing issue, but could canceling the timer before validati=
ng
the generation counter create a race that permanently hangs new transfers?

If the TX timer concurrently times out, the handler resets the state to
ISOTP_IDLE. A concurrent sendmsg() could then immediately claim the socket,
increment tx_gen, and arm txtimer for a new transfer.

When hrtimer_cancel() resumes from blocking in isotp_rcv_fc(), wouldn't it
inadvertently cancel the newly armed timer? Even though the subsequent tx_g=
en
check aborts processing the stale frame, the new transfer is left without a
watchdog timer and could hang permanently if a frame is dropped.

This exact same race appears to exist in isotp_rcv_echo() as well.

> +	/* hrtimer_cancel() may have let isotp_tx_timer_handler() give up on
> +	 * this job (state changed) or a new sendmsg() claim and reach the
> +	 * same state again (tx_gen changed) - either way this FC is stale.
> +	 */
> +	if ((so->tx.state !=3D ISOTP_WAIT_FC &&
> +	     so->tx.state !=3D ISOTP_WAIT_FIRST_FC) ||
> +	    READ_ONCE(so->tx_gen) !=3D gen)
> +		return 1;
> +
[ ... ]
> @@ -870,6 +889,7 @@ static void isotp_rcv_echo(struct sk_buff *skb, void =
*data)
>  	struct sock *sk =3D (struct sock *)data;
>  	struct isotp_sock *so =3D isotp_sk(sk);
>  	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> +	u32 gen =3D READ_ONCE(so->tx_gen);
> =20
>  	/* only handle my own local echo CF/SF skb's (no FF!) */
>  	if (skb->sk !=3D sk || so->cfecho !=3D *(u32 *)cf->data)
> @@ -881,6 +901,14 @@ static void isotp_rcv_echo(struct sk_buff *skb, void=
 *data)
>  	/* local echo skb with consecutive frame has been consumed */
>  	so->cfecho =3D 0;
> =20

[Severity: High]
This is a pre-existing issue, but does unconditionally clearing the echo tag
here corrupt concurrent new transfers?

Since the cleanup happens before the tx_gen check, if a new transfer starts
while hrtimer_cancel() is blocking, the new transfer will set its own cfecho
tag. Won't this delayed store to cfecho overwrite the new transfer's tag,
causing its future echo frames to be dropped and the transfer to hang?

> +	/* hrtimer_cancel() may have let isotp_tx_timer_handler() give up
> +	 * on this job (state changed) or a new sendmsg() claim and reach
> +	 * ISOTP_SENDING again (tx_gen changed) - either way this echo is
> +	 * stale.
> +	 */
> +	if (so->tx.state !=3D ISOTP_SENDING || READ_ONCE(so->tx_gen) !=3D gen)
> +		return;
> +
[ ... ]
> @@ -1143,13 +1179,20 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
>  	return size;
> =20
>  err_event_drop:
> -	/* got signal: force tx state machine to be idle */
> -	so->tx.state =3D ISOTP_IDLE;
> +	/* got signal: cancel timers before touching state, so a concurrent
> +	 * sendmsg() can't claim ISOTP_SENDING while a stale timer is armed
> +	 */
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);

[Severity: High]
By reordering the timer cancellation before the state reset, is there a risk
that RX handlers could re-arm stale timers?

While spinning here to cancel timers, the socket is left in an active state
(like ISOTP_SENDING). A concurrent RX handler, such as isotp_rcv_echo(), co=
uld
pass its state checks and arm a timer (txfrtimer or txtimer) after we have
already finished canceling them here.

When the state is subsequently forced to ISOTP_IDLE below, it leaves an arm=
ed
timer on an idle socket. If a new sendmsg() then claims the socket, could
this stale timer fire and overwrite the new transfer's timeout or falsely a=
bort
it?

>  err_out_drop:
> -	/* drop this PDU and unlock a potential wait queue */
> -	so->tx.state =3D ISOTP_IDLE;
> +	/* drop this PDU and unlock a potential wait queue, but only if no
> +	 * concurrent sendmsg() has since claimed the socket for a new
> +	 * transfer while we were cancelling timers above
> +	 */
> +	if (READ_ONCE(so->tx_gen) =3D=3D my_gen) {
> +		so->cfecho =3D 0;
> +		so->tx.state =3D ISOTP_IDLE;
> +	}

[Severity: High]
Could this non-atomic check create a TOCTOU (time-of-check to time-of-use)
race that corrupts concurrent transfers?

If err_event_drop cancels timers, a concurrent RX handler could have already
set the state to ISOTP_IDLE. A concurrent sendmsg() could then claim the
socket and set the state to ISOTP_SENDING.

If this thread evaluates READ_ONCE(so->tx_gen) =3D=3D my_gen just before th=
e new
transfer bumps the generation, it will then execute so->tx.state =3D ISOTP_=
IDLE.
Won't this unconditionally corrupt the new transfer's lockless state machin=
e?

[Severity: High]
Is a memory barrier missing here when releasing the state machine?

Since there is no smp_store_release(), the compiler or CPU might reorder
the stores to cfecho and tx.state. If ISOTP_IDLE becomes visible first, a
concurrent sendmsg() could claim the socket and set a new cfecho tag.

Wouldn't the delayed store to so->cfecho =3D 0 then erroneously clear the t=
ag
for the new transfer, causing it to drop its own echoes and hang?

>  	wake_up_interruptible(&so->wait);
> =20
>  	return err;

Looking at isotp_tx_timer_handler() in the same file:

	if (READ_ONCE(so->tx_gen) =3D=3D gen) {
		/* report 'communication error on send' */
		sk->sk_err =3D ECOMM;
		if (!sock_flag(sk, SOCK_DEAD))
			sk_error_report(sk);
	}

[Severity: High]
Will suppressing the timeout error here cause the original waiting thread to
block indefinitely?

If a new transfer claims the socket (tx_gen !=3D gen), the error is skipped,
but the original sendmsg() thread waiting in wait_tx_done is still woken up.
Because it checks so->tx.state =3D=3D ISOTP_IDLE (which is false, since the=
 new
transfer set it to ISOTP_SENDING), it goes back to sleep, effectively waiti=
ng
for an unrelated transfer to finish.

When it finally wakes up, sock_error() will return 0 because the error was
suppressed, masking the timeout failure as a successful transmission.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-isotp-fixe=
s-v7-0-f03af24d8397@hartkopp.net?part=3D3

