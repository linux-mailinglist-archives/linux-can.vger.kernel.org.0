Return-Path: <linux-can+bounces-8350-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cjtIMPHYU2ojfgMAu9opvQ
	(envelope-from <linux-can+bounces-8350-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 20:12:01 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8F7459B4
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 20:12:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k3EsnmSN;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8350-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8350-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCD1F3002327
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 18:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0763655EA;
	Sun, 12 Jul 2026 18:11:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D61D361DA6
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 18:11:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783879917; cv=none; b=pr3waknh3jfs4JeHFIN+FN7hM64quoRm8nbVcQ5biw62ycVgRpldgIwoShBl0duRXJXUGf04vaw6zVeGV/XBF4TFGsg5DnY+UUFxtA6Ji4I6haRFAKMAykvXdcAXdZSFG1QF4KqMqkhVVzWHmHnHr5hpXJGSllw0P5shBUY2WDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783879917; c=relaxed/simple;
	bh=4Y4EibDK1qsSr6lcsQvLXkNMiMwGaH4vtl9Tj6NGOOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DTLR5vZRDQUlTuVYrMrhIeb8O08FbYGckXpZrrhBu7Vhig/hKmd2DpwkVAICPmZzQyaDjJYRPYJtgfuqw8w39FxvuCtFdrY1ZoMoysk0WV3m+FViEeBfAW5aYV0cnUashVQZgaeDuBMr9KEL/MVfbu4zlczq0VMHCxsczl/hhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3EsnmSN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42EA1F000E9;
	Sun, 12 Jul 2026 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783879916;
	bh=S2N0cJJ7pIB2VSOxPtH1VYxNAb1yUB3MGQHwCxHYRVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3EsnmSNtrRRkGSCAVSIR1vYx8ASjuybk7IxgDeqsUqMOfdEbPxMdq1qVgBzTbbgo
	 TxoP1ypYtpiOGe/PWts1f39x+V5tc9zfBVza+L05Ucel/UhpsOuVw7qXt+E/cOY7XK
	 BLr+ADtSD46NYEeAHSTkEBsHoCkSVSeEwYIkRTiSOxSB81axpcWLBa2XtUHsSZBtAP
	 S9zujKU4Iy4KSOegT+r5yWwuc909Qac8atXOxnHx9dJr/jDMAotdUosG0aUHSdHo90
	 Gv+5r4azdwMOgwUU05GQz/vt1IotiAiT+K4Xqx+jaEk+IsyX2IJB8S+8vls5AQ0Deq
	 VfgA/OP9v7mww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/3] can: isotp: serialize TX state transitions
 under so->rx_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260712-isotp-fixes-v10-3-793a1b1ce17f@hartkopp.net>
References: <20260712-isotp-fixes-v10-0-793a1b1ce17f@hartkopp.net>
 <20260712-isotp-fixes-v10-3-793a1b1ce17f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 18:11:55 +0000
Message-Id: <20260712181155.B42EA1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8350-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64C8F7459B4

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockless state transition in the timeout handler creates a race co=
ndition that causes timeout errors to be silently dropped or misattributed,=
 leading sendmsg() to erroneously return success for timed-out transfers.
--

--- Patch [3]: [PATCH v10 3/3] can: isotp: serialize TX state transitions u=
nder so->rx_lock ---
commit e21ce85bab56b1b57ffd11ce2b23b760bfb72c21
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: serialize TX state transitions under so->rx_lock

This commit serializes CAN ISOTP TX state transitions and timer cancellatio=
ns
under so->rx_lock to prevent concurrent modifications. It also changes the
timeout handlers to locklessly cancel transfers by checking and updating
so->tx_gen and so->tx.state.

Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 44c044eb83e12..54becaf6898f1 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
[ ... ]
> @@ -893,53 +927,83 @@ static void isotp_rcv_echo(struct sk_buff *skb, voi=
d *data)
[ ... ]
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
Does this lockless state transition create a race window where timeout
errors are lost?

By setting so->tx.state to ISOTP_IDLE before setting sk->sk_err =3D ECOMM,
a thread waiting in isotp_sendmsg() for wait_tx_done might wake up, observe
ISOTP_IDLE, and read sock_error() before the error is set, falsely returning
success.

Additionally, could another concurrent sendmsg() see the IDLE state,
claim the socket, and increment tx_gen before the error is set?

If this happens, the check if (READ_ONCE(so->tx_gen) =3D=3D gen) will fail,
and the error will never be reported to the original waiting thread.

[ ... ]
> @@ -960,13 +1024,24 @@ static int isotp_sendmsg(struct socket *sock, stru=
ct msghdr *msg, size_t size)
[ ... ]
> +	/* new transfer: bump so->tx_gen and drain the old one's timers,
> +	 * still under the so->rx_lock we just claimed the socket with
> +	 */
> +	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
> +	WRITE_ONCE(so->tx_gen, READ_ONCE(so->tx_gen) + 1);
> +	hrtimer_cancel(&so->txtimer);
> +	hrtimer_cancel(&so->echotimer);

[Severity: High]
When this tx_gen increment occurs concurrently with isotp_tx_timeout()
after the timeout has already transitioned the state to ISOTP_IDLE, doesn't=
 it
cause the timeout handler to suppress the error for the previous transfer?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-isotp-fixe=
s-v10-0-793a1b1ce17f@hartkopp.net?part=3D3

