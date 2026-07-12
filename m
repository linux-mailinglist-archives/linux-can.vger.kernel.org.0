Return-Path: <linux-can+bounces-8336-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fzigLHyOU2phbwMAu9opvQ
	(envelope-from <linux-can+bounces-8336-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 14:54:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F8744BE2
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 14:54:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cVXPc0Wm;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8336-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8336-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE11F300BCA9
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305123D2A1;
	Sun, 12 Jul 2026 12:54:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D540313293
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 12:54:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783860858; cv=none; b=RyqrTU8UImt1x+X5CJPx8OeLTSh19QWRVVbn9kEFv3z+2KSBqVCnfweOBfTzOQJ7XT3JwF49IDWDkWKfRmwiU8hYr4Yyn5zvMxpS2LLIAYjBkjcToWrr9khOaiT+auJGj1XoB+etQaFWyPF0K7N/vQJ58ZU0fRsa8JnH9yMnz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783860858; c=relaxed/simple;
	bh=JD5ce/UgtVO3cliiB9aqKhwRTyRV4GqtxiDecSUZzwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GDI6zwjcP2MuWo5l0WNhIyO/2IKBUtzpTjWWYDJyFlAHa/cWHgmbPHhhgWZ9p7tjVJC/CnwtZknmP22zv3PVFdbo3HXfJrJjLewUs2sNWGqRU38nLPfSCvZlGzomXxjglMKP8+yJzxixRaHAasHKygoI9VGIyMOY1CtrHU15kJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVXPc0Wm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5183B1F000E9;
	Sun, 12 Jul 2026 12:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783860856;
	bh=mvGDy2zOsEy155hJ7c08IH6Sgw3gAMIq+RFB/RL2SLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cVXPc0WmLI9fRg+QnXi6YvekQ0N9iTBp0QDqlJ7jA7s2HthUPWRcPbNJHpR/CweJd
	 caYrMOPvVoX93iQead1hiRUP60VjMIgog4fC2sRbAMAqWcuHrMF7R+mpkHpg8ypxsL
	 Gjz4G1Ia+s+ZOEBaiEN/9EJklfViaVrOXjwR9iiVv0tsXTlE8onIs2NOQI6gyVCO/j
	 kSU1fbkc8j1UWTC5J06zYEFwYss1IcL7Djj7hwJ7pn3QBYSUQjGDdRj1Pn3+wbAxYB
	 moYCwKvjYv5XNKR8LFCZKKborRpL3BhKJT2Cl3lwdrTKpXKidxIbPZ9ukxFmhDJixa
	 S7MP+2IjtjVXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] can: isotp: use unconditional synchronize_rcu()
 in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260712-isotp-fixes-v8-1-c39220a4e442@hartkopp.net>
References: <20260712-isotp-fixes-v8-0-c39220a4e442@hartkopp.net>
 <20260712-isotp-fixes-v8-1-c39220a4e442@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 12:54:15 +0000
Message-Id: <20260712125416.5183B1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8336-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B5F8744BE2

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Race condition between isotp_sendmsg() error paths and isotp_r=
cv_fc() allows leaking uninitialized kernel heap memory over the CAN bus.
- [High] CAN filter leak due to a race condition between socket release and=
 netdevice unregistration.
- [High] State Machine Leak and Cross-Interface Data Leakage on NETDEV_UNRE=
GISTER.
- [High] Lockless updates to the TX state machine in isotp_sendmsg() race w=
ith concurrent CAN frame reception.
- [Medium] Missing Error Handling in isotp_bind() ignores can_rx_register()=
 failures.
--

--- Patch [1]: [PATCH v8 1/4] can: isotp: use unconditional synchronize_rcu=
() in isotp_release() ---
commit 6e5426def22a6e6426722ba05c1e7413dd0ccd86
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

isotp_notify() unregisters the (RCU) CAN filters and clears so->bound
without waiting for a grace period. This commit updates isotp_release() to
unconditionally call synchronize_rcu() before cancelling timers, fixing a
race condition where NETDEV_UNREGISTER could lead to a use-after-free timer
callback on the freed socket.

Link: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
>  						  SINGLE_MASK(so->txid),
>  						  isotp_rcv_echo, sk);
>  				dev_put(dev);
> -				synchronize_rcu();
>  			}
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but does a race condition exist between socket
release and netdevice unregistration that can leak filters?

If isotp_release() runs during the window where unregister_netdevice_many()
has unlisted the device from the IDR but before notifiers are invoked:

net/can/isotp.c:isotp_release() {
    ...
    list_del(&so->notifier);
    ...
    dev =3D dev_get_by_index(net, so->ifindex);
    ...
}

Because the socket is unlinked from the notifier list, the notifier won't
clean it up. However, dev_get_by_index() returns NULL since the device is
unlisted, causing isotp_release() to silently skip calling
can_rx_unregister() and permanently leak the receiver memory.

> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
> +	 * filters and cleared so->bound in isotp_notify() without waiting
> +	 * for in-flight isotp_rcv() callers to finish, so this call must not
> +	 * be skipped just because so->bound is already 0 here.
> +	 */
> +	synchronize_rcu();
> +
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  	hrtimer_cancel(&so->rxtimer);

[Severity: High]
This isn't a bug introduced by this patch, but does the NETDEV_UNREGISTER
handler fail to stop active state machines?

When the unregister event is handled:

net/can/isotp.c:isotp_notify() {
    ...
    case NETDEV_UNREGISTER:
        lock_sock(sk);
        /* remove current filters & unregister */
    ...
}

The code clears so->bound and so->ifindex but omits explicitly aborting
active state machines (so->tx.state) or cancelling tx timers. If a thread
is blocked in isotp_sendmsg(), it remains hung until a timer expires.

Additionally, if userspace calls bind() on a new interface, the state isn't
reset, and when the active timer fires, it could transmit remaining frames
of the old PDU out of the newly bound network interface.

[Severity: Medium]
This is a pre-existing issue, but does isotp_bind() ignore filter
registration failures?

net/can/isotp.c:isotp_bind() {
    ...
    if (isotp_register_rxid(so))
        can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
                        isotp_rcv, sk, "isotp", sk);
    ...
}

If can_rx_register() fails with -ENOMEM, isotp_bind() ignores the return
value, sets so->bound =3D 1, and returns 0. The socket then silently fails =
to
receive or echo frames, and later isotp_release() will trigger a warning
splat when attempting to unregister the missing filter.

[Severity: High]
This isn't a bug introduced by this patch, but is there a race with
concurrent CAN frame reception when updating the state locklessly?

net/can/isotp.c:isotp_sendmsg() {
    ...
    so->tx.state =3D ISOTP_WAIT_FIRST_FC;
    ...
}

If a spoofed or leftover Flow Control frame is received concurrently on
another CPU:

net/can/isotp.c:isotp_rcv_fc() {
    ...
    if (so->tx.state !=3D ISOTP_WAIT_FC &&
        so->tx.state !=3D ISOTP_WAIT_FIRST_FC)
    ...
}

The softirq path can see ISOTP_WAIT_FIRST_FC and immediately transition to
ISOTP_SENDING, transmitting a Consecutive Frame before isotp_sendmsg() has
sent the First Frame, scrambling the protocol state.

[Severity: Critical]
This is a pre-existing issue, but can the signal error path in
isotp_sendmsg() leak uninitialized kernel memory?

If isotp_sendmsg() is interrupted by a signal, it sets the state to idle:

net/can/isotp.c:isotp_sendmsg() {
    ...
    so->tx.state =3D ISOTP_IDLE;
    hrtimer_cancel(&so->txfrtimer);
    ...
}

If a concurrent isotp_rcv_fc() already passed the state check, and
userspace immediately calls sendmsg() again with a large size:

net/can/isotp.c:isotp_sendmsg() {
    ...
    u8 *newbuf =3D kmalloc(max_pdu_size, GFP_KERNEL);
    ...
}

The delayed isotp_rcv_fc() could resume, transition the state, and transmit
the newly allocated, uninitialized so->tx.buf over the CAN bus before the
data has been copied from userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-isotp-fixe=
s-v8-0-c39220a4e442@hartkopp.net?part=3D1

