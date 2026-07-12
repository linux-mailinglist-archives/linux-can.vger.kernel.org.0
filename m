Return-Path: <linux-can+bounces-8344-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FMR8NpudU2pBcQMAu9opvQ
	(envelope-from <linux-can+bounces-8344-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 15:58:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C78D744EA6
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 15:58:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hlCqYbEc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8344-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8344-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56251300C90D
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80543ACA6A;
	Sun, 12 Jul 2026 13:58:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FEF2D8DA8
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 13:58:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783864718; cv=none; b=LQ5XGX7dHA+X2VQh/B2nrG0Kvr3P3oC/5KrfwNmiT/1VNMJqP0k2nxwLgTQjj+vzQCK+EJieCQQh2+RHKQROOdzzU8LcXGz+r9Jeqx+5q4JgLqbmMPjmzZR9QBHiIrfrctR2TcFPbmcHPiOvr/3eGUXCGynXJwIVKJqlEMYk70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783864718; c=relaxed/simple;
	bh=ud9m7RbJRFNGtUWRSYSVRBY3R1HH1vhnOJk4sTuUzNM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BqpspC0opMVRmS54RjHmT0bNX34Nhh++/jbXv4BQKQgMj5szTVvyUpBP9jImKzYDdwxIziSyZmqwbJGAgDiSYhbMmM2RvJTTwNJ0GrIHm9ZNrewDSOfGKeLsSXHgUtimf+LmDy1VQi2LLKGU1NRjM86Sa5tcFZ0o88yobA3DVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlCqYbEc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28FE1F000E9;
	Sun, 12 Jul 2026 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783864717;
	bh=1kGKkKuBkpVUJz962CbZimAexUhaxSJwwbu6Aq2usi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hlCqYbEcelvv6hKkl4nAjF8EgegrpAjaEMicpd5XYNOtMyKIBrnK8AQBQO+qz9jb+
	 NBaIM0erBduVnjzDHGdt+QErjh68Q9x/kRAk4EHgvb1E0VPVnCfitazfOQ8ECZ1uF2
	 rYGDeOrit1QX3SU3mwso4g4zTft+brBqexJCohIi2jYxLdLjFJ1HuSzHCtlaf4/ML5
	 /SpsYd2adE5TsnMQLppfknJ2hn6KqLHgh2M4hGf+0ObjnqKpFWraNbLEyrmfpd7BYc
	 yRwUDOkIQe/piW6chhKi04vjsw4yZK7qhE2GSxk90pMi6v/i7wHuvMaIx+RFFOJew9
	 NCAYvkztn02yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/4] can: isotp: fix race between RX/TX timers and
 frame reception
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260712-isotp-fixes-v9-3-137840d7f0f4@hartkopp.net>
References: <20260712-isotp-fixes-v9-0-137840d7f0f4@hartkopp.net>
 <20260712-isotp-fixes-v9-3-137840d7f0f4@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 13:58:36 +0000
Message-Id: <20260712135836.B28FE1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8344-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 3C78D744EA6

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The lock-free state claim mechanism in isotp_sendmsg() races w=
ith the generation bump, causing state clobbering that leads to concurrent =
buffer corruption and an Out-Of-Bounds (OOB) read leaking kernel memory to =
the CAN bus.
--

--- Patch [3]: [PATCH v9 3/4] can: isotp: fix race between RX/TX timers and=
 frame reception ---
commit b972a6bcac8d8b55930b5c1372f223dd7d9a46de
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix race between RX/TX timers and frame reception

This commit attempts to fix a race by introducing a generation counter
(tx_gen) to distinguish between old and new TX transfers. It also expands
rx_lock to cover the TX side for proper synchronization.

Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 44c044eb83e12..c4ca8a64e7ce1 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -870,22 +888,42 @@ static void isotp_rcv_echo(struct sk_buff *skb, voi=
d *data)
[ ... ]
> +	/* so->rx_lock stops a new claim from arming a timer of its own
> +	 * while we're still here, but not from the lock-free cmpxchg()
> +	 * claim itself: state alone can't tell our SENDING from a new
> +	 * transfer's, so also gate on gen.
> +	 */
> +	if (so->tx.state !=3D ISOTP_SENDING || READ_ONCE(so->tx_gen) !=3D gen)
> +		goto out_unlock;

[Severity: Critical]
Does the echo receiver similarly validate against a stale tx_gen if a new
transfer is blocked waiting for rx_lock?

If the generation hasn't been bumped yet, it appears this could process ech=
oes
for the wrong transfer and inadvertently clobber its state.

> @@ -980,6 +1050,24 @@ static int isotp_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  			goto err_event_drop;
>  	}
> =20
> +	/* new transfer: bump the generation (gen is used below and by
> +	 * isotp_tx_timeout()/isotp_rcv_echo()) and drain the old one -
> +	 * cancel its timers ourselves in case one is still concurrently
> +	 * completing it, and take so->rx_lock so no isotp_rcv_fc()/
> +	 * isotp_rcv_echo() call for it is still in flight. The bump and
> +	 * the so->cfecho reset happen in the same so->rx_lock section so
> +	 * isotp_rcv_echo() can never observe the new gen alongside the
> +	 * old, not-yet-cleared cfecho tag.
> +	 */
> +	spin_lock_bh(&so->rx_lock);
> +	gen =3D READ_ONCE(so->tx_gen) + 1;
> +	WRITE_ONCE(so->tx_gen, gen);

[Severity: Critical]
Because cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) happens before
this lock is acquired, is there a window where a new transfer has claimed t=
he
state but hasn't bumped tx_gen yet?

> @@ -1142,14 +1231,36 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
> =20
>  	return size;
> =20
> +err_out_drop:
> +	spin_lock_bh(&so->rx_lock);
> +	goto err_out_drop_locked;
>  err_event_drop:
[ ... ]
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

[Severity: Critical]
Can this lock-free claim in isotp_sendmsg() race with the generation bump a=
nd
cause state clobbering?

If Thread A is in err_event_drop() and holds rx_lock, and Thread C (a timeo=
ut
timer executing isotp_tx_timeout()) locklessly sets the state to ISOTP_IDLE:

Thread C (isotp_tx_timeout)
   cmpxchg(&so->tx.state, old_state, ISOTP_IDLE);

Then Thread B calls isotp_sendmsg(), sees ISOTP_IDLE, claims it to
ISOTP_SENDING locklessly, and blocks on rx_lock:

Thread B (isotp_sendmsg)
   cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING);
   ...
   spin_lock_bh(&so->rx_lock); // blocks

When Thread A resumes in err_out_drop_locked, it checks tx_gen. Since Thread
B is blocked, tx_gen hasn't been bumped yet. Will Thread A then incorrectly
pass the check and reset the state to ISOTP_IDLE?

Thread A (err_out_drop_locked)
   if (READ_ONCE(so->tx_gen) =3D=3D gen) {
       so->tx.state =3D ISOTP_IDLE;
   }

Once Thread A drops the lock, Thread B will bump tx_gen and start writing to
tx.buf. But because the state is now ISOTP_IDLE, Thread D could successfully
call isotp_sendmsg() and concurrently claim the socket.

Could this lead to Threads B and D concurrently modifying tx.idx in
isotp_fill_dataframe(), causing an out-of-bounds read that leaks adjacent
kernel memory over the CAN bus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-isotp-fixe=
s-v9-0-137840d7f0f4@hartkopp.net?part=3D3

