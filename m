Return-Path: <linux-can+bounces-8328-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5eCcB7E1UmqQNAMAu9opvQ
	(envelope-from <linux-can+bounces-8328-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:23:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D44D7417D5
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 14:23:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="OcfI/ZHg";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8328-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8328-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC6E8301052C
	for <lists+linux-can@lfdr.de>; Sat, 11 Jul 2026 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD86282F06;
	Sat, 11 Jul 2026 12:23:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44020233941
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 12:23:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772589; cv=none; b=lZxB19iR7dFEH5aHFroLLY18Qth/JY1GIFncjDtPZH1Jjy/jU3yMB3kaUXe/wKv+RFv4IXhDHpgDxHG/byFdA76ilkl5rs7w+J7qvoCX/UG+l9lOpbtkf5L6B5U3GX8A4qDgWR+8eVpiMcokkLtgnz7betHBIkE6RhjxqQqdYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772589; c=relaxed/simple;
	bh=nbtvISY1bZT0TTXXd6PFflzn5z6sCOrcZ/I7Wyt9/zE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p7IfCR2Qyv4HT+mnVgOSxbTv2TVN/MxwVKPU+QXoDoZNRhYgK4kIBfVSZfDRkYoKGQIn26W8TpWMZ4E0+IMNq6Jy81ffoYWv7eTrt/Wz5m0WtR7/5Xq0/uGXHslD1ozyFyg9zimF9mJsy3A7sS1RzC7XRVLbAIW0lvb9oNH6i4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcfI/ZHg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A301F000E9;
	Sat, 11 Jul 2026 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783772588;
	bh=8sa0L4Inlsln+f67aAVXY9EkkUQKgcqL7NKXeu3WBFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OcfI/ZHgGo3ljK5CVZqU3KfpqPO/8bK8w4ctQzKlGFJoeTNZpKIPt+rIaEWLQr9AB
	 F8YYEqd81luaW1F0/7MuuuzxkyZZi+Hezm1hqBkyaXk90All8aPnr/7TMNNcrDKJHM
	 7Vlb+3YpuEcgitxicyum/E755Zv0jZbV7CTP3j+Dr8inV9c0AeIi2uhnhBVMLiUmkg
	 UPjYh2PuHvyvYZlo0HKKOnbiyDF4EKvjTn/H5nEPAMY9gDWzFMi+HyEyln7F9nKy92
	 SpZGTdxZ58U7/OqVkT5RV78c8ieiQg66EMG6W1E9j+P2iSDCax2p/QueTYmLkGFnq5
	 v5bcBQ/lDs+Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] can: isotp: use unconditional synchronize_rcu()
 in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260711-isotp-fixes-v7-1-f03af24d8397@hartkopp.net>
References: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
 <20260711-isotp-fixes-v7-1-f03af24d8397@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 12:23:07 +0000
Message-Id: <20260711122307.B2A301F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8328-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,hartkopp.net:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 5D44D7417D5

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unconditional synchronize_rcu() in socket release path allows un=
privileged users to spam RCU grace periods.

Pre-existing issues:
- [Critical] Missing rtnl_lock() in isotp_bind() allows race with NETDEV_UN=
REGISTER, leading to leaked CAN RX filters and a use-after-free on the sock=
et.
--

--- Patch [1]: [PATCH v7 1/5] can: isotp: use unconditional synchronize_rcu=
() in isotp_release() ---
commit ab2ff810b0276df9b5c38648b4470daa9abe3c97
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

This commit addresses a use-after-free timer callback on a freed socket. It
makes isotp_release() unconditionally call synchronize_rcu() before cancell=
ing
timers, regardless of so->bound, to prevent races with NETDEV_UNREGISTER.

Fixes: 14a4696bc311 ("can: isotp: isotp_release(): omit unintended hrtimer =
restart on socket release")
Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.=
kernel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
[ ... ]
>  				dev_put(dev);
> -				synchronize_rcu();
>  			}
>  		}
>  	}
> =20
> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
> +	 * filters and cleared so->bound in isotp_notify() without waiting
> +	 * for in-flight isotp_rcv() callers to finish, so this call must not
> +	 * be skipped just because so->bound is already 0 here.
> +	 */
> +	synchronize_rcu();

[Severity: Medium]
Will this unconditional synchronize_rcu() allow unprivileged users to spam =
RCU
grace periods?

If an unprivileged user repeatedly creates and immediately closes unbound C=
AN
ISOTP sockets, it seems this path will be hit every time. While previously =
this
required a successful bind to a valid CAN interface, this patch makes the c=
all
unconditional, which might allow it to be triggered on any system with the =
CAN
ISOTP module available.

> +
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  	hrtimer_cancel(&so->rxtimer);

[Severity: Critical]
This is a pre-existing issue, but does isotp_bind() lack rtnl_lock()
protection?

Looking at isotp_bind(), it acquires lock_sock() but does not appear to acq=
uire
rtnl_lock(). Can this allow a race with device unregistration?

net/can/isotp.c:isotp_bind() {
    ...
	dev =3D dev_get_by_index(net, addr->can_ifindex);
	...
	if (isotp_register_rxid(so))
		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
				isotp_rcv, sk, "isotp", sk);
    ...
}

If an unprivileged user concurrently binds a CAN ISOTP socket to a virtual =
CAN
device while deleting the device, it seems this could race with the device
unregistration notifier in isotp_notify().

If the notifier runs before so->ifindex is set, it might fail to unregister=
 the
filters, allowing isotp_bind() to register the filters on the dying device.

When the socket is closed, isotp_release() handles it:

net/can/isotp.c:isotp_release() {
    ...
		dev =3D dev_get_by_index(net, so->ifindex);
		if (dev) {
			if (isotp_register_rxid(so))
				can_rx_unregister(net, dev, so->rxid,...);
    ...
}

If dev_get_by_index() fails because the device is now unlisted, it appears =
the
CAN RX filters are never unregistered, which could leave a dangling
struct receiver in the device's dev_rcv_lists.

If a delayed packet is processed before the device is freed, could isotp_rc=
v()
be invoked with the freed socket pointer, resulting in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-isotp-fixe=
s-v7-0-f03af24d8397@hartkopp.net?part=3D1

