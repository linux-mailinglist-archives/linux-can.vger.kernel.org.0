Return-Path: <linux-can+bounces-7833-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V6fJG8HtK2qkHwQAu9opvQ
	(envelope-from <linux-can+bounces-7833-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:30:09 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C132D678FB7
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 13:30:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ehmxitFU;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7833-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7833-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 944873099616
	for <lists+linux-can@lfdr.de>; Fri, 12 Jun 2026 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380EC3D0925;
	Fri, 12 Jun 2026 11:30:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A03DA5A7
	for <linux-can@vger.kernel.org>; Fri, 12 Jun 2026 11:29:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781263805; cv=none; b=Ar102BRM0QgZkcU/5MeJn7lDhLhJ+4yfci9tRVKP4QHZzoKy1trGcamJUcrFkt7LoAeQRopmHRw26HH6F3XgeImwDE1KO70jEXo/V+6lQcW9vmveWE1rPK5LJhKNV+WZFFi69cuJYC5G0vb1M1FvHJIs4KcKdbOCLKoecDD/fSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781263805; c=relaxed/simple;
	bh=MIjgHr+f+PSDXxTsSwCMNpanYM+E5kkewkpGl1b5uEA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tfI8evjjQccR0HlqyhkyRackgoy/wyQhLz1z3a2qSlT5Le2mmGldj+/foWHYO//wG0IR0hTW+xvQJuzpSvBp3yjqIntl5wCrlGdH7zb30X+ORXhLQLfz2LVeve6BcU2QCnZI6jhcYts53NJVjJM1N92yjCJphZfmFb5Y5QQxYrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehmxitFU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF0A1F000E9;
	Fri, 12 Jun 2026 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781263796;
	bh=xc/DxDi66Kkjl9KCYo5w3Wvfzc0RB1YD7oC6nSG9kog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ehmxitFUkBGtKJVOTl88Ojr/79lhaYpFEJBy0y0Ana8td4m1dknLYijiJaojgoVpb
	 iOWA0ACaSntmsayQi9beqD6++iWZV44CHROJWFwJtbGerEpU83qU0jq9DZoB8t27NQ
	 DRWMGnrsZW+KI3xPyD5HjBn1eOZ0hE+slHAFZfKbT3xC5HIqci/nU549O4XyFpr89Y
	 NNN27Mb+hcLn8JNZ1BN6ig+8TzTmn60IQ2qkNOq8rFPW/gWXT1qK3Xb7DLcfLz8huu
	 CwOfXHNUOJxzvh2sVZBFw3M7sbmVPQ4csOienv1Qv11qZ62Px9SeMi8cQ1dbxySU9n
	 80Vw25lfPlWSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] can: bcm: mark intentional lockless read of
 bo->bound for KCSAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260612-bcm_fixes-v1-2-ca2fa07ee70f@hartkopp.net>
References: <20260612-bcm_fixes-v1-2-ca2fa07ee70f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 11:29:56 +0000
Message-Id: <20260612112956.7DF0A1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-7833-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,hartkopp.net:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C132D678FB7

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for KCSAN data race causing TOCTOU logic bug in CAN=
 BCM socket binding. The patch annotates `bo->bound` with READ_ONCE()/WRITE=
_ONCE() but leaves an adjacent lockless read of `bo->ifindex` unprotected i=
n `bcm_sendmsg()`. Because `bo->ifindex` is cached into a local variable be=
fore checking `bo->bound` and before acquiring `lock_sock()`, a concurrent =
`bcm_notify()` on device unregistration can clear `bo->bound` and `bo->ifin=
dex` while `bcm_sendmsg()` retains and proceeds with the stale `ifindex`.
--

commit 1e0341f7b374835149bc461a869bd9dbd61ed130
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: mark intentional lockless read of bo->bound for KCSAN

This commit annotates an intentional lockless read of bo->bound with
READ_ONCE() and WRITE_ONCE() to resolve a KCSAN data race warning. The data
race occurs between bcm_sendmsg() and bcm_notify().

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> Once the lock is acquired, any subsequent attempts to configure BCM
> jobs (like RX_SETUP) will safely fail because bcm_notify() has
> already cleared bo->ifindex to 0.

[Severity: High]
This isn't a bug introduced by this patch, but does this actually happen? S=
ince
bcm_sendmsg() caches bo->ifindex into a local variable before checking
bo->bound or acquiring lock_sock(), won't it use the stale ifindex instead
of 0?

net/can/bcm.c:bcm_sendmsg() {
	struct bcm_sock *bo =3D bcm_sk(sk);
	int ifindex =3D bo->ifindex; /* default ifindex for this bcm_op */
	...
	/* Lockless fast-path check for bound socket */
	if (!READ_ONCE(bo->bound))
		return -ENOTCONN;
	...
	lock_sock(sk);
	...
	case RX_SETUP:
		ret =3D bcm_rx_setup(&msg_head, msg, ifindex, sk);
	...
}

If bcm_notify() unregisters the device concurrently, dev_get_by_index()
inside bcm_rx_setup() might fail using the stale ifindex, which would
bypass the filter registration entirely without returning an error.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index c49b09f3229fa..9475758a6749f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1527,7 +1528,7 @@ static void bcm_notify(struct bcm_sock *bo, unsigne=
d long msg,
>  				bo->bcm_proc_read =3D NULL;
>  			}
>  #endif
> -			bo->bound   =3D 0;
> +			WRITE_ONCE(bo->bound, 0);
>  			bo->ifindex =3D 0;
>  			notify_enodev =3D 1;
>  		}

[Severity: High]
This is also a pre-existing issue, but could the lack of memory barriers ca=
use
the CPU or compiler to reorder the lockless accesses in bcm_sendmsg(),
observing bo->ifindex =3D=3D 0 while bo->bound =3D=3D 1?

If so, bcm_sendmsg() would execute with ifindex =3D 0 and call
can_rx_register(..., NULL, ...), inadvertently establishing a global wildca=
rd
filter that receives frames from all CAN interfaces in the namespace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-bcm_fixes-=
v1-0-ca2fa07ee70f@hartkopp.net?part=3D2

