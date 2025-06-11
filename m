Return-Path: <linux-can+bounces-3805-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C938AD4C53
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 09:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193E7189E55B
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 07:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE914B07A;
	Wed, 11 Jun 2025 07:10:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6F61494A8
	for <linux-can@vger.kernel.org>; Wed, 11 Jun 2025 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625853; cv=none; b=qS+tuT36kQan/+KrVOd5+wTpkrybSxGe9HSIidvUIvn3aKHM6wk2JCGFV2o6jE3B5xFnMo4rc1e9/kgfzBYnGOmSTnl/QUrCgLT8EYE1itG3Wl4Kab41zvE3EQaZPSguIj36bsj5Zdb+ckD2cfW7L/aZm63lw9bWF4VKFf9NsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625853; c=relaxed/simple;
	bh=IxWUtWO4MefccYxys5pw0T9++Il9ml35PDb/lu5pdxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewgoQXOkZym58/LBe0TKhcPqBkW9CT2lUlyV5H0QdtdMO/qFG5i6dyjlI4D2DYh7czNK2F6mLJ6GdtlDAlhNdl1e09qMI7oHfM90XpptJF4+ZAMrGw9h25usqjthx7XY0htWjKug+Y3sBAQR3iiaNJarxvwvfXPRsJRjgpC6/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uPFbh-0001qo-Mz; Wed, 11 Jun 2025 09:10:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uPFbh-002uCJ-0d;
	Wed, 11 Jun 2025 09:10:45 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D4B28424F13;
	Wed, 11 Jun 2025 07:10:44 +0000 (UTC)
Date: Wed, 11 Jun 2025 09:10:43 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
Message-ID: <20250611-just-degu-of-virtuosity-933b17-mkl@pengutronix.de>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-2-socketcan@hartkopp.net>
 <20250528-quirky-ultra-hawk-37000f-mkl@pengutronix.de>
 <77c5a904-8b2c-4a78-890d-2777ddefe250@wanadoo.fr>
 <20250528-bronze-penguin-of-joviality-0ce1a8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="syuhdvkdlsgnczlx"
Content-Disposition: inline
In-Reply-To: <20250528-bronze-penguin-of-joviality-0ce1a8-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--syuhdvkdlsgnczlx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 02/11] can: netlink: replace tabulation by space in
 assignment
MIME-Version: 1.0

On 28.05.2025 18:12:53, Marc Kleine-Budde wrote:
> > > The patches 2...5 look good to me. If Oliver adds his S-o-b, I can ta=
ke
> > > them for linux-can-next.
> >=20
> > If you prefer, I already submitted those in the past in a dedicated ser=
ies with
> > a proper cover letter:
> >=20
> > https://lore.kernel.org/linux-can/20241112165118.586613-7-mailhol.vince=
nt@wanadoo.fr/
>=20
> Even better.

These are in net-next now \o/

> > Because I got zero answers, I split it even further. This is why only o=
ne patch
> > got merge in for 6.15. I was planning to resend those clean-up patches =
anyway,
> > but if you are OK to take them directly from my previous series, go ahe=
ad.
> > Nothing has changed for these since November, except from the first pat=
ch with
> > was merged separately.
>=20
> I've adjusted the cover letter, as patch 1 is already mainline, and
> taken the rest of the series to can-next/testing. Note, once -rc1 is
> out, I'll rebase this branch.

I've rebased the remaining can-xl patches to current net-next/main and
pushed it to my b4/can-xl branch:

| https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/?h=3Db4/can-xl

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--syuhdvkdlsgnczlx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhJK/AACgkQDHRl3/mQ
kZxyhggAo/bT/CVEMhog3HxGxjCtbsdiViJYCA6Tk85OcwwpDS+qqMZMNOeQEUYx
1P6ihZyBUGWTfNIEuybxMi/33HKFzJdqxBsG4jwysgiGmcFgj5mU3dbHzSY1vojz
Lo1zBKE+XtfukR4yI2GoU4NUdvGg/xBJ9Sy4+HjfBEzL3qK4V1LjR3cLNk3WdX0I
xgfs/cly3otD7S87eDldnudfmqSJpUsJRfnVh/T5HLpTdTY06I2zbAvvgCVsoFY1
t7WouhT+Pf1y2mmfZHyVyOHHM5d/ixX5gkwBG/+Aw1yFSqye+Q2fTKxGASQ5Jvj7
OI6XL8rfiYW9aI9PA1PXVsk9AGXEsA==
=d812
-----END PGP SIGNATURE-----

--syuhdvkdlsgnczlx--

