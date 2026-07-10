Return-Path: <linux-can+bounces-8315-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kHTOFEBcUWpWDAMAu9opvQ
	(envelope-from <linux-can+bounces-8315-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:55:28 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4970373E808
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:55:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="SX9gdo/Z";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8315-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8315-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 758F730072B9
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 20:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE8035C1A6;
	Fri, 10 Jul 2026 20:55:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78C380FCA
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 20:55:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716923; cv=none; b=mPQ9uE70cZklvLekZPvADRVIdGG1o8ttjgMMO1YdUAdOVENOWZTArrqf2ZU70NL7bYEKpQf+OEw1joCcQiw2tHDTHrWPOA5Rbz1Y6B0zDJEoMVit+iKbS8nHNgCdeptNdKW+NP5oZxr2Gis6GBZZ6glGQgCbdI2/2Pqf7gJQfmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716923; c=relaxed/simple;
	bh=0izXoFkWZtpm0zIDKGeczAQS/7YnGQ5aN9v3ZSaVRd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sj0InOJVXLrS6HFMgNMw/A+++pkz+bvbV+DGpuMuzQMdV6G80U3+3hjAWpEF3rGJAH1FyaIgLAnTEauxxWgo0dNGrr4kFHojpaSOdq2QgqZ39kF+/FyjLPoSlDXfo7vIpzCJ0UXzIf8h7sDNmi7B0N7bGZfcq3VQkBJRKKJrSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX9gdo/Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0A71F000E9;
	Fri, 10 Jul 2026 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783716921;
	bh=lElJtwKWGeNm7GcY4ZNpmEt2iHjdyLpjfhw+XB8vbTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SX9gdo/Z2LgN3pUeLPV2tk4E0RD3KJ61S0Se09xtZjVYiTNoSTBxmFOw41WIaoXK3
	 ONJBBk0Gr0AK0aBs6Ip7MT1VJNEwrlxYsu2L6JvbiC5y504Z1s6GOw1G2+vpwMmCIz
	 8uzprJw0EhIE5Nlzu7yJXeSWY4g+mLXl0SCrilZ8bHlH37lZdWVpml8ClA7THCk0xy
	 OuKFC8F9qTFsGKcmpIAv3i+SBzp0nkyycarjpgzieNuXe61adrvg7bHFXCAyz+gnsp
	 RB5r5RkuP0xo0qW6sBGRp/Rpb2bqrkePRoUS1ocV6q9T3nP0JyNRI8hkcdyEQuXKU7
	 HUtUHg++LPgig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] can: isotp: fix race between RX/TX timers and
 frame reception
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260710-isotp-fixes-v6-3-a13c2539093d@hartkopp.net>
References: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
 <20260710-isotp-fixes-v6-3-a13c2539093d@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 20:55:20 +0000
Message-Id: <20260710205521.6D0A71F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8315-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto];
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
X-Rspamd-Queue-Id: 4970373E808

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Moving `so->tx.state =3D ISOTP_IDLE` after `hrtimer_cancel()` in t=
he `err_event_drop` path introduces a race condition with softirq receive h=
andlers, leading to stray timers that can corrupt subsequent transmissions.
- [High] The delayed `so->tx.state =3D ISOTP_IDLE` assignment in the error =
path unconditionally clobbers the state, which can corrupt a new, concurren=
tly running transfer.
- [High] The newly added TX state checks after `hrtimer_cancel()` in `isotp=
_rcv_fc()` and `isotp_rcv_echo()` are vulnerable to an ABA race condition, =
allowing stale frames to corrupt new transfers.

Pre-existing issues:
- [High] Missing cleanup of `so->cfecho` in `isotp_sendmsg()` error paths a=
llows stale local echoes to corrupt subsequent transfers.
--

--- Patch [3]: [PATCH v6 3/5] can: isotp: fix race between RX/TX timers and=
 frame reception ---
commit 4f481801d9d9059ae72ceaf6467d32f307eddbb5
Author: Oliver Hartkopp <socketcan@hartkopp.net>
can: isotp: fix race between RX/TX timers and frame reception

This patch fixes a race condition between hrtimer execution and frame
reception by checking the state after hrtimer_cancel(). It also reorders
timer cancellation and state reset in isotp_sendmsg()'s error path to
prevent concurrent sendmsg calls from corrupting state.

Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 44c044eb83e12..5ef2a610fc172 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
[ ... ]
> @@ -378,6 +378,15 @@ static int isotp_rcv_fc(struct isotp_sock *so, struc=
t canfd_frame *cf, int ae)
> =20
>  	hrtimer_cancel(&so->txtimer);
> =20
> +	/* isotp_tx_timer_handler() may have raced us for so->tx.state while
> +	 * hrtimer_cancel() above waited for it to finish, already reporting
> +	 * the tx error and resetting the state; don't resume a tx job that
> +	 * has already been given up on.
> +	 */
> +	if (so->tx.state !=3D ISOTP_WAIT_FC &&
> +	    so->tx.state !=3D ISOTP_WAIT_FIRST_FC)
> +		return 1;
> +

[Severity: High]
Is this lockless state check vulnerable to an ABA transition?

While hrtimer_cancel() spins waiting for a timer handler, the timer handler
could reset the state to ISOTP_IDLE. If a concurrent isotp_sendmsg() from
another thread starts a new transfer during this window, it could locklessly
transition the state back to the exact same expected state
(e.g., ISOTP_WAIT_FIRST_FC).

When hrtimer_cancel() returns, this check would pass because the state
matches, but it would be evaluating a different transfer. Could this allow a
stale Flow Control frame to corrupt the new transfer?

[ ... ]
> @@ -881,6 +898,14 @@ static void isotp_rcv_echo(struct sk_buff *skb, void=
 *data)
>  	/* local echo skb with consecutive frame has been consumed */
>  	so->cfecho =3D 0;
> =20
> +	/* isotp_tx_timer_handler() may have raced us for so->tx.state while
> +	 * hrtimer_cancel() above waited for it to finish, already reporting
> +	 * the tx error and resetting the state; don't resume a tx job that
> +	 * has already been given up on.
> +	 */
> +	if (so->tx.state !=3D ISOTP_SENDING)
> +		return;
> +

[Severity: High]
Could the same ABA race happen here?

If a timer resets the state to ISOTP_IDLE while hrtimer_cancel() waits,
and a concurrent isotp_sendmsg() starts a new transfer and sets the state to
ISOTP_SENDING, this check would pass for the new transfer.

Would this allow a stale local echo to erroneously resume the newly started
transfer?

[ ... ]
> @@ -1143,8 +1168,7 @@ static int isotp_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  	return size;
> =20
>  err_event_drop:
> -	/* got signal: force tx state machine to be idle */
> -	so->tx.state =3D ISOTP_IDLE;
> +	/* got signal: force tx state machine to be ISOTP_IDLE */
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  err_out_drop:

[Severity: High]
Does delaying the state reset to after hrtimer_cancel() create a window
where concurrent RX softirqs can observe an active state?

If isotp_sendmsg() is interrupted by a signal, it now calls
hrtimer_cancel() while so->tx.state is still visibly active
(e.g., ISOTP_SENDING). If a CAN receive handler (like isotp_rcv_echo())
executes concurrently in softirq context, it locklessly checks
so->tx.state, sees it is active, and can re-arm the transmission timers.

When this error path completes, it sets the state to ISOTP_IDLE, leaving
the newly armed timers active. When a subsequent sendmsg() begins, could
these stray timers fire unexpectedly and corrupt the new transfer's
sequence?

[Severity: High]
Does the delayed assignment of ISOTP_IDLE in err_out_drop clobber
concurrently claimed state?

While hrtimer_cancel() waits for a timer handler to finish (which resets
the state to ISOTP_IDLE), a concurrent thread could call isotp_sendmsg(),
successfully claim the ISOTP_IDLE state, and begin a new transfer.

When the original thread finishes hrtimer_cancel(), it unconditionally
executes so->tx.state =3D ISOTP_IDLE (located under err_out_drop:). Could
this abruptly clobber the new transfer's state and expose its buffer to
concurrent overwrites?

[Severity: High]
This is a pre-existing issue, but does the error path fail to clean up
so->cfecho?

If a transmission is aborted via a signal, the state is forced to
ISOTP_IDLE but so->cfecho is not cleared and continues to hold the local
echo tag of the aborted frame.

When a subsequent sendmsg() sets the state to ISOTP_SENDING and begins
preparing the buffer, a stale echo could arrive. If isotp_rcv_echo() sees
a matching so->cfecho and an active ISOTP_SENDING state, could it process
the echo and initiate a transmission containing uninitialized heap data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v6-0-a13c2539093d@hartkopp.net?part=3D3

