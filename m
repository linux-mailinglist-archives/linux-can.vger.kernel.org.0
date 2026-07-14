Return-Path: <linux-can+bounces-8416-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qgwgHc8kVmrEzwAAu9opvQ
	(envelope-from <linux-can+bounces-8416-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:00:15 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CAD754319
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 14:00:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="i/QvmgIJ";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8416-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8416-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4496A3050A5D
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7C3909A3;
	Tue, 14 Jul 2026 11:51:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196ED381B02
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:51:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029867; cv=none; b=OUGFGrXDmrj/43SOpLgFRd5hEuSEJFwyrm81m6o1NkBJ2p6D8irKSN1eDHrxm2wkVyGZ3u+ymnsxOSTFlggwm1fyzOZVaRvUjnp5jzt0uWIjtNL0P/ypJgqEvUjuLJRz7xAHiy3HNbzHj9A99zhjnR/D1ZPm/dHlml4mGU3rEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029867; c=relaxed/simple;
	bh=40eTf30ZNBZfv9xeIsawtlYbB0ZRwfcF+x62VfZuj3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j9DixrFbMR3cAE40Yeqr0ccSbFxA2C1sOpTcGjBGr+WsOWmy01AMpVM8axA27GBUCGGX4T1Pu97hI4Hu6pmp3tD6rsbAWNpu27UgwVoR5XHq1jYEFiT1WrMOpQKw0jmAK+ld8qugtp8PPegerF7wlTYWAfr2v9ZNjeVC12YBl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/QvmgIJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF9B1F000E9;
	Tue, 14 Jul 2026 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784029865;
	bh=yM0xBBtcvlMXp8BqmkwVqVr/MetbJcvIQylrz8dcrh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i/QvmgIJVayn83SFuCw95qEk7DqFXRajmnlPO62kd7yI4MZ45JBSXBFiQHc7JS/GX
	 Lbt67LJyy4AgcZ6ngM+SQkx54IuYKe8oVLOwD6yHLfzENij5b36VbhbMACJrEC6CPB
	 Sfqpdy4R2rK/jXqkt+xTkYr7TFbAcZP6m/74nF0rqUv2Fscc+kOiPxGUgr+GbuMOhT
	 W7d6PErD/bJDX9OEkQypLEPYlPRrxBFH7IxktWmEPGsTj3S4FmGwTmgMKSwnBXuvK4
	 Jg+H/0mxXi9dAUAu37QmTAYa+KtbZ6vNQ8m4KjPFXaqck5S8AN1kTM+VRsTKBKmXjg
	 BG113DlW+N6tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/11] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260714-bcm_fixes-v14-2-867a4be60a61@hartkopp.net>
References: <20260714-bcm_fixes-v14-0-867a4be60a61@hartkopp.net>
 <20260714-bcm_fixes-v14-2-867a4be60a61@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:51:04 +0000
Message-Id: <20260714115105.5AF9B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8416-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,hartkopp.net:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04CAD754319

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race when updating CAN frames locklessly allows transmission =
of torn or partially updated frames and incorrect RX filtering.
--

--- Patch [2]: [PATCH v14 02/11] can: bcm: fix lockless bound/ifindex race =
and silent RX_SETUP failure ---
commit 23919fa17f26320455e758411c450420d522db0a
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes a race condition where bcm_sendmsg() reads bo->ifindex
and checks bo->bound locklessly while concurrent updates modify them,
preventing inconsistent socket bindings. It also ensures bcm_rx_setup()
returns an error when a requested device is concurrently removed instead of
silently failing.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1436,20 +1463,21 @@ static int bcm_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  			struct net_device *dev;
> =20
>  			dev =3D dev_get_by_index(sock_net(sk), ifindex);
> -			if (!dev)
> -				return -ENODEV;
> +			if (!dev) {
> +				ret =3D -ENODEV;
> +				goto out_release;
> +			}
> =20
>  			if (dev->type !=3D ARPHRD_CAN) {
>  				dev_put(dev);
> -				return -ENODEV;
> +				ret =3D -ENODEV;
> +				goto out_release;
>  			}
> =20
>  			dev_put(dev);
>  		}
>  	}
> =20
> -	lock_sock(sk);
> -
>  	switch (msg_head.opcode) {
> =20
>  	case TX_SETUP:
[Severity: High]
This isn't a bug introduced by this patch, but is there a data race when
updating CAN frames locklessly?

Looking at bcm_tx_setup(), it writes directly to op->frames using data from
userspace without holding any lock to synchronize with the timer:

net/can/bcm.c:bcm_tx_setup() {
    ...
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Could the timer function bcm_can_tx() locklessly read op->frames and
transmit torn data if it races with bcm_tx_setup()?

net/can/bcm.c:bcm_can_tx() {
    ...
    skb_put_data(skb, cf, op->cfsiz);
    ...
}

Similarly, bcm_rx_setup() updates RX filters locklessly:

net/can/bcm.c:bcm_rx_setup() {
    ...
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
    ...
}

Does this allow the RX softirq handler to evaluate incoming CAN frames agai=
nst
partially written filters in bcm_rx_handler()?

net/can/bcm.c:bcm_rx_handler() {
    ...
    if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D
    ...
}

Since memcpy_from_msg() can sleep on page faults, the data might be in a
partially written state for an extended period. Is it possible to copy the
data to a temporary buffer first, and then update op->frames under the
appropriate spinlocks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v14-0-867a4be60a61@hartkopp.net?part=3D2

