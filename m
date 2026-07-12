Return-Path: <linux-can+bounces-8335-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pFmuKG2OU2pgbwMAu9opvQ
	(envelope-from <linux-can+bounces-8335-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 14:54:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F5744BDF
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 14:54:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MrhlxSvn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8335-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8335-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F123300B9F4
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2815A39D6CC;
	Sun, 12 Jul 2026 12:53:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6833313293
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 12:53:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783860831; cv=none; b=ObD5OC82qtCdujqdWwWr626KzMMtIwU/ZwARnOxpP+Hornkk0GXSs35ar6eojeO8IBLhZgWQSCBdWlkOXi2htUeasUez+LT0bbTT+rLcPwYeKlQE7AkC2yljS2X/9qGLPX2XQ9FB8mftg0mK0eLPhrwbvUVgclWO+3664iXDgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783860831; c=relaxed/simple;
	bh=g5GrOKsNpNAMINGb15qRxIrGL3tpgWL1E2v0aJqR8K4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YlW7e4dp5lYhwe4NzqodypOxsI6yV/OFG/wZmAzKUEXLscS3rhdaniFhjVOSQ2mbsG5Y5BRAVfUb3p8RvhZ/fGlfOf1RmTnAgbUf137nEBT4Zie0uTYM7mqIr4a6hm+AsyV9CL6ZUyDQntkVx047DNjlFj7v/bZJONXnRvn0KdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrhlxSvn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085D51F000E9;
	Sun, 12 Jul 2026 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783860829;
	bh=/vaqYfGWKUna/wH30WIs6dHZtMo1PEQxIWQYQZ/hpNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MrhlxSvneGyqZ6rsnY3pmSTtJ58vemJ13h2LNTKWapfOtTchiLFFm6WhKXWuJMSyp
	 6CI2Xc/3x5YKDnF69MIxcAHRd+mYGeO2L0ach5XJwXQR4zNF78tOZP2CbkY3P1YjnY
	 oRSYqsbasyCYoV8AH0DFK/aM2lpTWWnc/ty09o1LqdM64x7hIfdsdRHuc11ugcy0vJ
	 MPu3bQpiS4N9EmgUbk0lOdyHJPCZm8Z8oAFmpmoAiHM2rMUdX5pV3KBnagzEk/im9m
	 ORMurlmagBoaikosuDCzOHqgi88QITyieayklIuV53dk4fi9VH/vAGaOmHJQV9fUx4
	 06od0sX4UOKxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] can: isotp: fix race between RX/TX timers and
 frame reception
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260712-isotp-fixes-v8-3-c39220a4e442@hartkopp.net>
References: <20260712-isotp-fixes-v8-0-c39220a4e442@hartkopp.net>
 <20260712-isotp-fixes-v8-3-c39220a4e442@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 12:53:48 +0000
Message-Id: <20260712125349.085D51F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8335-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC6F5744BDF

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Error paths in `isotp_sendmsg()` unconditionally cancel hrtimers, =
which can inadvertently destroy the active timers of a newly started concur=
rent transfer.
- [High] A delayed local echo frame from a previous transfer can bypass the=
 `tx_gen` validation and corrupt a newly started transfer due to a TOCTOU r=
ace with `so->cfecho`.
- [High] The timeout handler incorrectly suppresses the socket timeout erro=
r (`ECOMM`) if a concurrent transfer claims the socket, causing the timed-o=
ut `sendmsg()` to silently drop data and falsely report success.

Pre-existing issues:
- [High] Concurrent `sendmsg` calls cause the active sender to hang waiting=
 for a new sender to finish, leading to hangs or cross-transfer status leak=
s.
--

--- Patch [3]: [PATCH v8 3/4] can: isotp: fix race between RX/TX timers and=
 frame reception ---
commit eb4cbaa1b7868a1c6cac62f072196eefb97302d2
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can: isotp: fix race between RX/TX timers and frame reception

This commit introduces so->rx_lock to protect the TX state machine against
concurrent hrtimer execution and frame reception. It also adds a tx_gen
generation counter to safely distinguish between old and new TX transfers
when cancelling timers or processing echo frames locklessly.

Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 44c044eb83e12..c5b44d298618b 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
[ ... ]
> @@ -870,22 +888,42 @@ static void isotp_rcv_echo(struct sk_buff *skb, voi=
d *data)
>  	struct sock *sk =3D (struct sock *)data;
>  	struct isotp_sock *so =3D isotp_sk(sk);
>  	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> +	u32 gen;
> =20
>  	/* only handle my own local echo CF/SF skb's (no FF!) */
> -	if (skb->sk !=3D sk || so->cfecho !=3D *(u32 *)cf->data)
> +	if (skb->sk !=3D sk)
>  		return;
> =20
> +	/* unlike isotp_rcv_fc()/isotp_rcv_cf(), not already under so->rx_lock
> +	 * (no isotp_rcv() caller here), so take it ourselves
> +	 */
> +	spin_lock(&so->rx_lock);
> +
> +	/* so->cfecho may since belong to a new transfer; recheck under lock */
> +	if (so->cfecho !=3D *(u32 *)cf->data)
> +		goto out_unlock;
> +
> +	gen =3D READ_ONCE(so->tx_gen);

[Severity: High]
Can a delayed echo frame from a previous transfer bypass the validation and
corrupt a newly started transfer here?

If transfer 1 times out, it leaves its echo tag in so->cfecho.
If transfer 2 then claims the socket, it locklessly increments so->tx_gen
in isotp_sendmsg() before acquiring so->rx_lock to clear so->cfecho.

If a delayed echo for transfer 1 arrives in that small window, isotp_rcv_ec=
ho()
will acquire so->rx_lock, match the old so->cfecho (which hasn't been clear=
ed
yet), and read the new so->tx_gen.

Does this allow the stale echo to pass the generation check below and disru=
pt
the protocol state machine of the new transfer?

> =20
>  	/* cancel local echo timeout */
> -	hrtimer_cancel(&so->txtimer);
> +	hrtimer_cancel(&so->echotimer);
> =20
>  	/* local echo skb with consecutive frame has been consumed */
>  	so->cfecho =3D 0;
> =20
> +	/* so->rx_lock stops a new claim from arming a timer of its own
> +	 * while we're still here, but not from the lock-free cmpxchg()
> +	 * claim itself: state alone can't tell our SENDING from a new
> +	 * transfer's, so also gate on gen.
> +	 */
> +	if (so->tx.state !=3D ISOTP_SENDING || READ_ONCE(so->tx_gen) !=3D gen)
> +		goto out_unlock;
[ ... ]
> -static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtim=
er)
> +/* shared by so->txtimer's and so->echotimer's callbacks. Both timers get
> + * cancelled under so->rx_lock elsewhere, so this must stay lock-free to
> + * avoid deadlocking with that; uses so->tx_gen instead to avoid tainting
> + * a new transfer with an error from the one that just timed out.
> + */
> +static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
>  {
> -	struct isotp_sock *so =3D container_of(hrtimer, struct isotp_sock,
> -					     txtimer);
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
> +	/* only claim the timeout if the state is still unchanged */
> +	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) !=3D old_state)
>  		return HRTIMER_NORESTART;
> =20
>  	/* we did not get any flow control or echo frame in time */
> =20
> -	/* report 'communication error on send' */
> -	sk->sk_err =3D ECOMM;
> -	if (!sock_flag(sk, SOCK_DEAD))
> -		sk_error_report(sk);
> +	if (READ_ONCE(so->tx_gen) =3D=3D gen) {
> +		/* report 'communication error on send' */
> +		sk->sk_err =3D ECOMM;
> +		if (!sock_flag(sk, SOCK_DEAD))
> +			sk_error_report(sk);
> +	}

[Severity: High]
Does this suppress the socket timeout error if a concurrent transfer claims
the socket right after the state transitions to ISOTP_IDLE?

Once cmpxchg() sets so->tx.state to ISOTP_IDLE, a concurrent thread calling
isotp_sendmsg() can immediately claim the state and increment so->tx_gen.

If that happens before the READ_ONCE(so->tx_gen) =3D=3D gen check, the error
reporting is skipped. Does this cause the original timed-out isotp_sendmsg()
call to falsely report success to userspace instead of returning an error?

> =20
> -	/* reset tx state */
> -	so->tx.state =3D ISOTP_IDLE;
>  	wake_up_interruptible(&so->wait);
> =20
>  	return HRTIMER_NORESTART;
>  }
[ ... ]
> @@ -1120,13 +1207,10 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
>  		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
>  			       __func__, ERR_PTR(err));
> =20
> +		spin_lock_bh(&so->rx_lock);
>  		/* no transmission -> no timeout monitoring */
> -		hrtimer_cancel(&so->txtimer);
> -
> -		/* reset consecutive frame echo tag */
> -		so->cfecho =3D 0;
> -
> -		goto err_out_drop;
> +		hrtimer_cancel(tx_hrt);

[Severity: High]
Can this unconditionally cancel the timer of a newly started concurrent
transfer?

If can_send() fails, this path cancels tx_hrt before verifying ownership
via tx_gen. If a concurrent sendmsg() has already claimed the socket and
started its own timers, will this cancel the new transfer's timers and
cause it to hang indefinitely without timeout monitoring?

> +		goto err_out_drop_locked;
>  	}
> =20
>  	if (wait_tx_done) {
> @@ -1142,14 +1226,28 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
> =20
>  	return size;

[Severity: High]
This isn't a bug introduced by this patch, but does the wait condition here
handle concurrent senders correctly?

When using CAN_ISOTP_WAIT_TX_DONE, isotp_sendmsg() waits on:
    wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_IDLE);

If transfer 1's transmission completes (setting ISOTP_IDLE and waking waite=
rs),
but transfer 2 concurrently claims ISOTP_SENDING before transfer 1 wakes up,
transfer 1 will evaluate so->tx.state =3D=3D ISOTP_IDLE as false.

Will transfer 1 then go back to sleep, incorrectly hanging while waiting on
transfer 2's completion?

> =20
> +err_out_drop:
> +	spin_lock_bh(&so->rx_lock);
> +	goto err_out_drop_locked;
>  err_event_drop:
> -	/* got signal: force tx state machine to be idle */
> -	so->tx.state =3D ISOTP_IDLE;
> +	/* got signal: cancel timers under so->rx_lock, held through
> +	 * err_out_drop_locked below, so a concurrent claim's own drain
> +	 * step can't proceed until we're done
> +	 */
> +	spin_lock_bh(&so->rx_lock);
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
> -err_out_drop:
> -	/* drop this PDU and unlock a potential wait queue */
> -	so->tx.state =3D ISOTP_IDLE;
> +	hrtimer_cancel(&so->echotimer);

[Severity: High]
Similar to the can_send() error path above, this unconditionally cancels
all TX timers without checking if the socket is still owned by the current
transfer's generation.

If a timeout already occurred and a new transfer is active, will cancelling
these timers destroy the active timers of the new transfer?

> +err_out_drop_locked:
> +	/* so->rx_lock stops a new claim from cancelling anything of its own
> +	 * while we're still here, but not from the lock-free cmpxchg()
> +	 * claim itself; only drop our own PDU if that hasn't happened
> +	 */
> +	if (READ_ONCE(so->tx_gen) =3D=3D gen) {
> +		so->cfecho =3D 0;
> +		so->tx.state =3D ISOTP_IDLE;
> +	}
> +	spin_unlock_bh(&so->rx_lock);
>  	wake_up_interruptible(&so->wait);
> =20
>  	return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-isotp-fixe=
s-v8-0-c39220a4e442@hartkopp.net?part=3D3

