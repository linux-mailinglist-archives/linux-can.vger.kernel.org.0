Return-Path: <linux-can+bounces-8421-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r4jqF5Y8VmoL2AAAu9opvQ
	(envelope-from <linux-can+bounces-8421-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 15:41:42 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBCE75546B
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 15:41:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8421-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8421-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 577C5300748F
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D44657FB;
	Tue, 14 Jul 2026 13:41:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866546AF17
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 13:41:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036498; cv=none; b=JxtRbvyQI2fcn8ul0OpgjO2fn1T9G3ZI26NGhmhaoks3usKjzdyvrdCHGVNa63CWt66/6p1iIwQKAop5jyb/mz0qBWS0BRlWqV9lQiycqRpUBijwPXTm2AERL3RNiJQj8qpqaVWWl9Xic83SR2oDTO8OPidhW4Dz6lvFiqsdXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036498; c=relaxed/simple;
	bh=CGnFeuVop/KLAAMKhpXFWiukIZ99PyPW/8c0zYqnv/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCI4UeiQr3a2pjH0zNiSGLoGI0BvCI1JzNoo+2iA6CZ+g5zMiBJ0pRAMSb1By2oQ0OplodmegFXObD/uJMYJM3hY3WWY34Slkwc5Egxnl+7yWmUfj1qwTAmdErEvnd3dRwUv3OujBVABPAZTGlvD8kvKJc3A7+6tDOLkYvevCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0157F2021F5;
	Tue, 14 Jul 2026 15:41:34 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wjdO9-001mR2-2v;
	Tue, 14 Jul 2026 15:41:33 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9CEC7568C39;
	Tue, 14 Jul 2026 13:41:33 +0000 (UTC)
Date: Tue, 14 Jul 2026 15:41:30 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: sashiko-reviews@lists.linux.dev, 
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device
 removal
Message-ID: <20260714-tidy-quizzical-collie-4aaee0-mkl@pengutronix.de>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-9-fd667c61099a@hartkopp.net>
 <20260714104431.65C751F000E9@smtp.kernel.org>
 <2c2bc659-fd26-4c48-a5f4-e9e6a3c43003@hartkopp.net>
 <20260714-towering-phenomenal-nyala-ad406f-mkl@pengutronix.de>
 <1a521f25-0aee-4eae-a0da-3eb7f0702e84@hartkopp.net>
 <20260714-vehement-native-jaguar-4f52dd-mkl@pengutronix.de>
 <ee59dccc-0532-4b00-8783-9763e04c327e@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gs6mnxeh7jkmzjsk"
Content-Disposition: inline
In-Reply-To: <ee59dccc-0532-4b00-8783-9763e04c327e@hartkopp.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	TAGGED_FROM(0.00)[bounces-8421-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:sashiko-reviews@lists.linux.dev,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pengutronix.de:url,pengutronix.de:from_mime,pengutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCBCE75546B


--gs6mnxeh7jkmzjsk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device
 removal
MIME-Version: 1.0

On 14.07.2026 15:07:48, Oliver Hartkopp wrote:
> When there was a new issue pointed out by sashiko I fixed it inside the
> patch with --amend when it belonged to the topic of the patch.

You've probably already working on this one:
https://lore.kernel.org/all/20260714115254.D9C2B1F000E9@smtp.kernel.org/

> So I tried to follow the one problem, one patch pattern. And every patch
> makes things better and introduces no new regressions (which sashiko-bot
> would have detected) - while probably not fixing everything at once.

Perfect!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gs6mnxeh7jkmzjsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCalY8hwAKCRDMOmT6rpmt
0i8gAP9tdzp+M7J8rzSzsELUXb+XkR8OcUVbI6wS4GV9OUW0AQEAtnN2mALrT84U
usUUN7AfpuE+mAPUAyN+th8HEj8LfAY=
=HKKa
-----END PGP SIGNATURE-----

--gs6mnxeh7jkmzjsk--

