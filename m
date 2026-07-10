Return-Path: <linux-can+bounces-8316-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lOeHMxtdUWq+DAMAu9opvQ
	(envelope-from <linux-can+bounces-8316-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:59:07 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D308D73E8AB
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 22:59:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Vmz3lwp8;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8316-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8316-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B6693026162
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 20:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A13AFCEF;
	Fri, 10 Jul 2026 20:56:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B938E8CC
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 20:56:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716991; cv=none; b=Qv//A6llZAX2UUVfEzWIXQcS8fWiRvfZOjzv7zdTUT0PssjIXCQuC1LTpMcH81XaFXQtEnj2MvTz83HYxIcoU4Ds35tr4HBvzkeGl+3/LuFPGejmckXxXGnK5PPTyfFObtSkEndqwi9hNAIsuGaWjIaEQ4mLo+ZA1FS6boM7k8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716991; c=relaxed/simple;
	bh=1YBUpqZlPgR3N+aeiOnankvzMiyF0QJfoZS7qvxsLxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eD9LkboK23Aymk0kibEbXuIR6JtMksHy86PO7nAIpP12fL2Jpd5d1Hposy08gf+DmtlUlIjAHxCZcy5mdmY1ggofRUoZcCVZfFwdM2fGaIJWTesOqZT4UZNuuG+9VJdKAHpZ0dELUEep1MsHcC402JhwGLnmyweBHDMAjqpwaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmz3lwp8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4511F000E9;
	Fri, 10 Jul 2026 20:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783716990;
	bh=4Rz650+tHfQG2ZZaSL3vRfgnX46l/H2Pv6IZCnpYj1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vmz3lwp8kV8RbQBKp0ilrTX9ETlFHjs23V4Inxdc1LWQBfLaRa49mLp38BttH7Xxr
	 I8+bu9/X3eyr7Un2BaP1xM/TYjGAwgkW8AtjhqCNsnI7g6/nBA5ZqPKyzgyoueRCUi
	 z3WkeKY8RWRaZJ3EITZ2LDb77LJ8WJAg5LC39KiYH2h/dWchD4ai643rHGAkTzjIPn
	 dP8NSE3gDHfFw2p/pD/uIN0ix+cJ6WUhoLekDsF+qN1j9WQZcv8J+NxHdhNG8fp+Sz
	 BSRiADCps+2r+Tz0mvkU7cvrQBJQDEahaM6NP2aHXEivPUyc22mhXkjKJr9tg/b6YJ
	 A2HPojBP2MiJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] can: isotp: fix use-after-free race with
 concurrent NETDEV_UNREGISTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260710-isotp-fixes-v6-2-a13c2539093d@hartkopp.net>
References: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
 <20260710-isotp-fixes-v6-2-a13c2539093d@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 20:56:29 +0000
Message-Id: <20260710205629.EE4511F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8316-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:email,smtp.kernel.org:mid,sashiko.dev:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D308D73E8AB

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The wait loop error path in `isotp_sendmsg()` resets the transmiss=
ion state machine despite not owning it, which can silently corrupt another=
 thread's active transmission and lead to an information leak.
--

--- Patch [2]: [PATCH v6 2/5] can: isotp: fix use-after-free race with conc=
urrent NETDEV_UNREGISTER ---
commit 1c03594f024dd1735bb9c085227d4a04352dcd2f
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER

This commit fixes a race condition during device unregistration by holding a
tracked reference to the bound net_device and serializing bind and release
with rtnl_lock().

Link: https://lore.kernel.org/linux-can/20260707101420.47F261F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -978,6 +980,14 @@ static int isotp_sendmsg(struct socket *sock, struct=
 msghdr *msg, size_t size)
>  			goto err_event_drop;

[Severity: High]
This is a pre-existing issue, but does this error path corrupt the state
machine for another thread?

If Thread A acquires the state (so->tx.state =3D ISOTP_SENDING) and starts
transmission, and Thread B calls isotp_sendmsg(), Thread B will fail the
cmpxchg() and block in wait_event_interruptible().

If Thread B receives a signal, it jumps to err_event_drop and forces=20
so->tx.state =3D ISOTP_IDLE, even though Thread A still owns the active=20
transmission.

Could Thread C then call isotp_sendmsg(), acquire the now-IDLE state
machine, and begin setting up a new transmission? If a delayed flow
control frame for Thread A's transmission arrives, it seems the state
machine could mistakenly transmit consecutive frames containing the newly
allocated, uninitialized memory from Thread C onto the CAN bus.

>  	}
> =20
> +	/* so->bound is only checked once above - a wakeup may have
> +	 * unbound/rebound the socket meanwhile, so re-validate it
> +	 */
> +	if (!so->bound) {
> +		err =3D -EADDRNOTAVAIL;
> +		goto err_out_drop;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v6-0-a13c2539093d@hartkopp.net?part=3D2

