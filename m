Return-Path: <linux-can+bounces-8338-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HSgGKtaPU2qhbwMAu9opvQ
	(envelope-from <linux-can+bounces-8338-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 15:00:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF8D744BF6
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 15:00:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UZb0mEO8;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8338-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8338-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24DB430028B0
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2E3A9616;
	Sun, 12 Jul 2026 13:00:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E423D2A1
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 13:00:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783861202; cv=none; b=ujnIhS4msZA//2H4aSyk0bcnsyMaLCZCtfNn0IZaCb9VXmLBlglNshpeVCJiRTj8AY77MjSrhjp1+NPFUXmNbhFJfaRoD79DJltEM36EXs2CEoOQWXAMiKONQydjs4d+9WLutFLYJaHdf4YiaPNVPCh+jEbQN36N1WcpsdXT4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783861202; c=relaxed/simple;
	bh=txGIww4JwZ3i0U3cA2+wh7ArONzbcH5OdXB0jYvITgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NRo7ceJQQfgb8JLWIJu+AJfBLu19MDuFd63JpTRBL93Y3ocuha7oAk+NIsL2D+m4UzRqKyKqtkZ6ZYKoB55efEYvIUgagWzrGOeKWtjPJIU2VjjBHfnKpeUnfjzo+xUsIlD15zASV2NFycpR3J/2+JOtwSwyPthjowQbaVSBN4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZb0mEO8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72EF1F000E9;
	Sun, 12 Jul 2026 12:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783861200;
	bh=WP/1+a78JJyGqG97iVn1yPeRJIoNxpTuAIGTbD+Pimk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UZb0mEO8VyGMKWbhlFDYgYq7maR4WwK4mXUhFWG78nhtcdlzkZdwu0wgjM++UIaoN
	 cB/4lPthC8VvV1LlUQ9WMHwKKqMSUJSx0GoQnPPotUMI2ChCzHv1u4Kz9BCnMwy05w
	 ul02u5Qs6n5HFUiUaEDD9G3+0+KGmSC/ZuFY9jsdy896qm5DSmz4VwZjRrF+L1JfqA
	 CDELFdnvJPEWJm8Q+d4yIMNhYWUa+5ivNycxhnymATrOQIUIgbQxqMrRVbH+7sq+cb
	 xgb4yJ8AfZSx1/z3my6QXty517VINnOlOufRjXOIpGN86uGXggZ+S4m61funW8AKMG
	 GXs1khxr+9vgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] can: isotp: fix use-after-free race with
 concurrent NETDEV_UNREGISTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260712-isotp-fixes-v8-2-c39220a4e442@hartkopp.net>
References: <20260712-isotp-fixes-v8-0-c39220a4e442@hartkopp.net>
 <20260712-isotp-fixes-v8-2-c39220a4e442@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 12:59:59 +0000
Message-Id: <20260712125959.B72EF1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8338-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EF8D744BF6

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A TOCTOU race condition in `isotp_sendmsg` allows concurrent m=
odification of socket options, leading to an SKB heap overflow and `skb_ove=
r_panic`.
- [High] The check in `isotp_bind()` to prevent rebinding during an active =
state machine does not fully prevent cross-interface packet injection from =
RCU-delayed softirqs.
--

--- Patch [2]: [PATCH v8 2/4] can: isotp: fix use-after-free race with conc=
urrent NETDEV_UNREGISTER ---
commit 508c0cfe152e6936d33176beb93ef03692ea4ea7
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER

This tracks the bound net_device with a reference instead of re-resolving
it from ifindex during isotp_release(). It also rejects isotp_bind() with
-EAGAIN if the state machines aren't idle yet, avoiding timers acting on a
newly bound interface.

Link: https://lore.kernel.org/linux-can/20260707101420.47F261F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index d30937345bcdc..44c044eb83e12 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -978,6 +980,14 @@ static int isotp_sendmsg(struct socket *sock, struct=
 msghdr *msg, size_t size)
>  			goto err_event_drop;
>  	}
> =20
> +	/* so->bound is only checked once above - a wakeup may have
> +	 * unbound/rebound the socket meanwhile, so re-validate it
> +	 */
> +	if (!so->bound) {
> +		err =3D -EADDRNOTAVAIL;
> +		goto err_out_drop;
> +	}

[Severity: Critical]
This is a pre-existing issue, but does a time-of-check to time-of-use race
still exist here if sock_alloc_send_skb() blocks later in isotp_sendmsg()?

If sock_alloc_send_skb(sk, so->ll.mtu) blocks during allocation, a concurre=
nt
NETDEV_UNREGISTER could trigger isotp_notify(), which acquires lock_sock()
and sets so->bound =3D 0.

Userspace could then call setsockopt(CAN_ISOTP_LL_OPTS), which passes its
!so->bound check and modifies so->ll.mtu and so->tx.ll_dl.

When isotp_sendmsg() resumes, it has a smaller SKB but could use the new
larger MTU, or isotp_fill_dataframe() could use the new so->tx.ll_dl to copy
too many bytes into the small SKB:

net/can/isotp.c:isotp_fill_dataframe() {
    ...
    for (i =3D 0; i < num; i++)
        cf->data[pcilen + i] =3D so->tx.buf[so->tx.idx++];
    ...
}

Could this lead to a heap out-of-bounds write overwriting skb_shared_info?

[ ... ]

> @@ -1317,6 +1327,17 @@ static int isotp_bind(struct socket *sock, struct =
sockaddr_unsized *uaddr, int l
>  		goto out;
>  	}
> =20
> +	/* A transmission or reception that outlived a previous binding
> +	 * (unbound by NETDEV_UNREGISTER) may still be draining; the FC/echo
> +	 * and RX watchdog timers bound how long this takes. Checked together
> +	 * with so->bound in the same lock_sock() section above, so there is
> +	 * no window in which a concurrent isotp_notify() could be missed.
> +	 */
> +	if (so->tx.state !=3D ISOTP_IDLE || so->rx.state !=3D ISOTP_IDLE) {
> +		err =3D -EAGAIN;
> +		goto out;
> +	}

[Severity: High]
This is a pre-existing issue, but does this state machine check fully preve=
nt
cross-interface packet injection from RCU-delayed softirqs?

If a packet arrives on an old device and is queued via can_rx_register()'s
softirq, and concurrently the device is unregistered (clearing so->bound),
userspace could call bind() for a new device.

Since isotp_rcv() hasn't acquired so->rx_lock to change the state yet, the
lockless check here passes and so->dev is updated. Could the delayed softirq
then acquire so->rx_lock, transition the state, and send a Flow Control fra=
me
using the newly bound so->ifindex?

Would isotp_rcv() need to verify that skb->dev matches the currently bound
so->dev after acquiring so->rx_lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-isotp-fixe=
s-v8-0-c39220a4e442@hartkopp.net?part=3D2

