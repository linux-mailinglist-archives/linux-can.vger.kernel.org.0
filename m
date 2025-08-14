Return-Path: <linux-can+bounces-4248-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC5B265CB
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBB91CC711B
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE12EAB9D;
	Thu, 14 Aug 2025 12:46:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C665239E7E
	for <linux-can@vger.kernel.org>; Thu, 14 Aug 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175566; cv=none; b=qhUfbASkpe106DymByeOLSJ3lC+Yh+8I8l3kA55/O8RZhjwk0884s+xHix3B6FClyQ04N5waCcBrALX5QIIiKdnwOp0fOrI3VEDjKBpcAytBR+vzCLUf78671ajBwXpA5WDQzUx2EYHk6kGY7p8b83p/4jsttXx+6wXz9a7Y1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175566; c=relaxed/simple;
	bh=lFgsh9jmxyxNGTzJX1qYz+zNxlTO73vVIgDDr8RndeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGqzhqAUnZHAQvojJCvmVVVrH9s3JPnJd0XVgz+DAPcmIjsuYFw6sIuVUtdE+aKyvkLoPqn6bMPJyNb6F7HClsRXcOzT42B9Z8SCwtMtS80heiYgix3vY0t0g+Mzsu3/rsFJe8jUr5XjXv3eIbgW7Yi1cpOwSLDYuhx8fLbz5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1umXLE-0004UJ-Vk; Thu, 14 Aug 2025 14:46:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1umXLE-000FyY-1D;
	Thu, 14 Aug 2025 14:46:00 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1F06B457760;
	Thu, 14 Aug 2025 12:46:00 +0000 (UTC)
Date: Thu, 14 Aug 2025 14:45:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] can: rcar_can: Fix s2ram with PSCI
Message-ID: <20250814-neat-muscular-fennec-ea8ade-mkl@pengutronix.de>
References: <699b2f7fcb60b31b6f976a37f08ce99c5ffccb31.1755165227.git.geert+renesas@glider.be>
 <20250814-gray-yak-of-happiness-829267-mkl@pengutronix.de>
 <CAMuHMdUXBTpPpS6S6=u3N75Ut+NqBJ2Xu1chnYgjK7XBZ5tXYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x4ii3li5zwhz3xv3"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUXBTpPpS6S6=u3N75Ut+NqBJ2Xu1chnYgjK7XBZ5tXYQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--x4ii3li5zwhz3xv3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: rcar_can: Fix s2ram with PSCI
MIME-Version: 1.0

On 14.08.2025 14:28:34, Geert Uytterhoeven wrote:
> Hi Marc,
>=20
> On Thu, 14 Aug 2025 at 14:08, Marc Kleine-Budde <mkl@pengutronix.de> wrot=
e:
> > On 14.08.2025 13:26:37, Geert Uytterhoeven wrote:
> > > On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume, t=
he
> > > CAN interface no longer works, until it is brought down and up again.
> > >
> > > Fix this by calling rcar_can_start() from the PM resume callback, to
> > > fully initialize the controller instead of just restarting it.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Can you add a fixes tag?
>=20
> Well, the issue is more like an integration/platform issue: before the
> advent of PSCI system suspend powering down the SoC, s2ram worked fine.
>=20
> One might consider the (rudimentary) addition of support for R-Car
> Gen3 to the driver as the first "broken" commit:
> Fixes: e481ab23c57b37c9 ("can: rcar_can: Add r8a7795 support")
> But at that time, Linux didn't even support wake-up from PSCI system
> suspend on R-Car Gen3 systems...

I see. Thanks for the explanation.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--x4ii3li5zwhz3xv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmid2oUACgkQDHRl3/mQ
kZwkSgf+MYuqJb0kU+cC5gq92LgWqqwhV+58r2/YDjvHYRanQM+hioNJC0deMzS8
ekqL/w05D2+jVblq+e6rQyi7Z0KZGk7fF/F59kPCExbZjSJSOBZp+byz8d1Dzr5a
AeEKhBYMQaeq/fWWQhOgRXy/FC3NYiKLer6zfdPE3v1jle9HhRn/k+7wzW+pK+Rj
sMWioyvYmJQGYu9/l/IhiGhAvry6B4bfR4tpFRve9Mn0jZeRecXn4thPMxLIlFmJ
cxLU3O/87P6gGjGrsfKqXnN+Bl7iNaQ+MQ+zmsXh3M46wcDhmpWK8ke7+/OYQY4N
GIXtevBEI2dNfVY+CovE4oSoUSMMvQ==
=RulA
-----END PGP SIGNATURE-----

--x4ii3li5zwhz3xv3--

