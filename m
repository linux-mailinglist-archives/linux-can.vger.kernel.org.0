Return-Path: <linux-can+bounces-8043-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Th1bOcLSTGpWqQEAu9opvQ
	(envelope-from <linux-can+bounces-8043-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:19:46 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DF671A3ED
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:19:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=am8tLYIR;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8043-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8043-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A5A73122A54
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294213DA5DA;
	Tue,  7 Jul 2026 10:14:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F133DA7DD
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 10:14:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419262; cv=none; b=lIpaqNDSby5MJcAJvnA7Ebti0gpJFnB8AQr8jxkKcnEScgKPQOw41U1dTgRbNG9PdkW0onA+y/36nYpP2WQKUeZ7qKgoNU23AyJ9480VMiLTp6fQ/2qPbIeNmaguu7O8pjuEgxqk0c9GXcdJd0w9nHEF2ImYeRne1Z0c0+jsRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419262; c=relaxed/simple;
	bh=TBY/EQjj4zzuCqeEAWAPvJPomMlXSs6AIHUWV7Yt0x0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aiG2TYfMOik2g7MKXitb3/gZB4/sQRF0nthXPYRx/9W2qHnYfqEZY/0ZX8aITu/NXePYIpdaZh8U2eaE38PoqpolsA1bvsVjHD5JYKyod3ftFiRqN0iUdStfxraIRRy/2O5SyvL1ATJo2JOla9eW1EEEHlMPYssMB5c72kEb+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am8tLYIR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F261F000E9;
	Tue,  7 Jul 2026 10:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419260;
	bh=hoXwavVAbHtmVMmdLfm2WlaHYwkGfCMMskzTZB5GBI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=am8tLYIRJeFV0Yujq00RupjuufiE2SGFhO049vgjBg4mZRtlZ2MKDG5wpszUmDwnA
	 Q8UnZpP6xHx7GkGAWLG1X2kyZupl3z3cEgjrN+PlZnDGZOO4bKBPpo4vYrkJn3siAy
	 ky6s13y4K1n5EK4U9Nd9PvgPkVji1Gyba2aPsMyCX3UI2X6RHQZizuKEDWESxbW2jK
	 UR42NNRThsgNxyjjH4N+7ZAk1cWOUCmeeGVTXTPbW/cHnAo12C0zALRqEBRz1nK52h
	 fXneiLaFSkR6YoRsTIpHstJtk0MZpIJUQxvXd8f87WF0xt0PS2yrxr8Pkad9dKXc9s
	 mg4hY654R0ksA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: isotp: use unconditional synchronize_rcu() in
 isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260707094716.63578-1-socketcan@hartkopp.net>
References: <20260707094716.63578-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:14:19 +0000
Message-Id: <20260707101420.47F261F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8043-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19DF671A3ED

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Skipped CAN filter unregistration during concurrent device rem=
oval leads to Use-After-Free and memory leak.
--

--- Patch [1]: [PATCH v2] can: isotp: use unconditional synchronize_rcu() i=
n isotp_release() ---
commit 0af34892c79e9f6de424253e9d5e275db6cb6280
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

This commit addresses a race condition in the timer callback of isotp
sockets. It enforces an unconditional synchronize_rcu() in isotp_release()
before cancelling timers to avoid issues during concurrent
NETDEV_UNREGISTER notifications.

Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.=
kernel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1227,14 +1227,20 @@ static int isotp_release(struct socket *sock)
>  	/* remove current filters & unregister */
>  	if (so->bound) {
>  		if (so->ifindex) {
>  			struct net_device *dev;
> =20
>  			dev =3D dev_get_by_index(net, so->ifindex);
>  			if (dev) {
>  				if (isotp_register_rxid(so))
>  					can_rx_unregister(net, dev, so->rxid,
>  							  SINGLE_MASK(so->rxid),
>  							  isotp_rcv, sk);

[Severity: Critical]
This is a pre-existing issue, but could this dev_get_by_index() call return
NULL if a device unregistration is running concurrently?

If unregister_netdevice_many() unlists the device before the
NETDEV_UNREGISTER notifier executes, and isotp_release() is called at the
same time, it removes the socket from the isotp notifier list.

When it calls dev_get_by_index() here, it will return NULL because the
device is unlisted. The if (dev) condition fails and we skip calling
can_rx_unregister().

The NETDEV_UNREGISTER notifier will miss this socket because it was already
removed from the notifier list.

Since the socket is freed at the end of this function, does this leave an
active CAN filter pointing to a freed socket? Any delayed or looped-back
CAN frames processed during device teardown could invoke isotp_rcv() on
this freed socket, causing a use-after-free and a memory leak.

> =20
>  				can_rx_unregister(net, dev, so->txid,
>  						  SINGLE_MASK(so->txid),
>  						  isotp_rcv_echo, sk);
>  				dev_put(dev);
> -				synchronize_rcu();
>  			}
>  		}
>  	}
> =20
> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707094716.6357=
8-1-socketcan@hartkopp.net?part=3D1

