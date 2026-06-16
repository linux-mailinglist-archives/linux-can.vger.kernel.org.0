Return-Path: <linux-can+bounces-7862-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f2+kMoBIMWpLgAUAu9opvQ
	(envelope-from <linux-can+bounces-7862-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 14:58:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1EB68FAEA
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 14:58:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YIDGgevN;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7862-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7862-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 210CC30841F3
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A731714A;
	Tue, 16 Jun 2026 12:53:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA763655F0
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 12:53:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614432; cv=none; b=LKusDg2MT1thRhuNuccfC/uhHJ1gYdXO9RxiXRp3IWMiOSA0rDsz6IIctAxsYpDsFT7SG/oD3rPndDjPq2KhMIzU3PqU4zQabZAZLikPHhQ9dUVV9LOudqY24v461PasEoqDC5TRcfw51CffO2i2ti576Eodt1pnOrsglY+QjYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614432; c=relaxed/simple;
	bh=2FD/sgYyK1LZoC9asKyncvbydIJw3ndVYFZrcPGooTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MCmDYFh82kP/4ULVf9DMUlXrq3khoaMP7c8QEimzVdXxEc5J8JpYGXbvT/lM22qiStv8V3Q9icXfAJjFp0+EBJqd+XOu3cVG4ZYL/KsQ+wq4u51dvxLnueYJAAofI/R5D/FRFKwR0hFewip8hLU8BdOl42J/KifjFpDL5XsCP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIDGgevN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A371F000E9;
	Tue, 16 Jun 2026 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781614431;
	bh=VYEfjcKDs4k2/M1nlp+p0gN4kczMZo1ufWi4/BHDONk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YIDGgevNZOI/X09BF1+/zETtn+29hqLk/lHxZ3i0R1ReXqq7RxI7lTHkUCGbmKYdU
	 cXRC+8hd6n/ZlRnW4YRJuvLrwcMZNpkhF7BtBxKlG1FMC5SftYlse9rldxWszArbwd
	 V+kVi2bKK4YDBTzwPWRmBPxJ8mDom0kj/1Sos29wKa+0RhO0y+dLUUt8pwW2hhwqL6
	 Go7nx1SBVIrn741AqeJdmqE9MS6oYzAekjGZMF0D3FNKKlHJyvPkgAzM1M6tHJWg0y
	 Gwjt9xhqqCSp4UbcZNepLhegDx44lW/ImP3kUbrtY1uoK1JlXl6+Vz0PZzuLmPQQnR
	 M20C1FhaOia8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: isotp: hold a reference to the bound netdevice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasileios Almpanis" <vasilisalmpanis@gmail.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260616123915.674534-1-vasilisalmpanis@gmail.com>
References: <20260616123915.674534-1-vasilisalmpanis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 12:53:50 +0000
Message-Id: <20260616125350.B7A371F000E9@smtp.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vasilisalmpanis@gmail.com,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7862-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E1EB68FAEA

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Calling synchronize_rcu() while holding rtnl_lock() introduces sev=
ere latency spikes and potential denial of service system-wide.

Pre-existing issues:
- [Critical] Skipping synchronize_rcu() in isotp_release() when the socket =
is unbound leads to a use-after-free of the socket structure by re-armed hr=
timers.
--

commit da93bcd8877d85ffe0b043e3045c3374b10e38e5
Author: Vasileios Almpanis <vasilisalmpanis@gmail.com>

can: isotp: hold a reference to the bound netdevice
   =20
isotp_release() looked up the bound netdevice with
dev_get_by_index(so->ifindex) and only unregistered the socket's CAN
receivers if that lookup succeeded. This is unreliable while the device
is going away.

Cc: stable@vger.kernel.org
Closes: https://syzkaller.appspot.com/bug?id=3D58676a0f698531996a42612c552e=
894a55b9732b

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..308d18040b6db 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1219,27 +1222,22 @@ static int isotp_release(struct socket *sock)
>  	list_del(&so->notifier);
>  	spin_unlock(&isotp_notifier_lock);
> =20
> +	rtnl_lock();
>  	lock_sock(sk);
> =20
>  	/* remove current filters & unregister */
> -	if (so->bound) {
[ ... ]
> +	if (so->bound && so->dev) {
> +		if (isotp_register_rxid(so))
> +			can_rx_unregister(net, so->dev, so->rxid,
> +					  SINGLE_MASK(so->rxid),
> +					  isotp_rcv, sk);
> +
> +		can_rx_unregister(net, so->dev, so->txid,
> +				  SINGLE_MASK(so->txid),
> +				  isotp_rcv_echo, sk);
> +		netdev_put(so->dev, &so->dev_tracker);
> +		so->dev =3D NULL;
> +		synchronize_rcu();

[Severity: High]
Does holding rtnl_lock() in isotp_release() (net/can/isotp.c) across
synchronize_rcu() cause severe latency spikes and potential denial of
service system-wide?

synchronize_rcu() blocks until all currently active RCU read-side critical
sections across the system finish, which stalls all other network
configuration operations while rtnl_lock() is held.

[Severity: Critical]
This is a pre-existing issue, but skipping synchronize_rcu() when the socket
is already unbound (e.g., by NETDEV_UNREGISTER where isotp_notify() sets
so->bound =3D 0) appears to allow a use-after-free.

If synchronize_rcu() is bypassed, isotp_release() proceeds to cancel the
socket's hrtimers and drop the user reference without waiting for concurrent
receive operations to complete.

Could a concurrent CAN receive operation like isotp_rcv_ff() or
isotp_rcv_echo() executing within an RCU read-side critical section
unconditionally re-arm the hrtimer after isotp_release() has cancelled it,
leading to a use-after-free when the timer later fires on the freed socket
memory?

>  	}
> =20
>  	hrtimer_cancel(&so->txfrtimer);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616123915.6745=
34-1-vasilisalmpanis@gmail.com?part=3D1

