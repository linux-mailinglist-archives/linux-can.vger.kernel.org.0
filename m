Return-Path: <linux-can+bounces-5449-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 900A5C6188E
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 17:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15B22348A28
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9245230DEB0;
	Sun, 16 Nov 2025 16:26:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7882DCF69
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763310385; cv=none; b=Ggn31tUuJV48BWU8XffE75bWWKSFiaKDbDtAaOy/dKnWpg0lKBd4ecOfpSYfPXt+PQwO6uOxcIGbB47JPdWT30G6u4pw/asswM4e/Ffql1ZdC64I/q97pB+YI8xu8nfMPBZthyE2oTuE7B2zB+kCuuF9p+CYol8O7kXF4LFafz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763310385; c=relaxed/simple;
	bh=j5UcFuzW9Wz3/i7ZJVa58sptQD4yq6pCRhLpZYhvP40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHZz9MODfxiVpiuTs935sfsCxvIPq+s56F3MZwJQOLy3H5Y2RSsQp7j2QFG2eDbzFZAYNo+xNCTILRGzsOT6zbLQdg5QSMd+q37OlcmEj8olNRCcNQ7XoYUx9NsSKLl59EPfpBuaMuxgSsG+m1pv1rcFDc5ztENVDtRv/tlCtsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKfZp-0000le-9L; Sun, 16 Nov 2025 17:26:09 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKfZo-000lyM-0x;
	Sun, 16 Nov 2025 17:26:08 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E81E14A0D9F;
	Sun, 16 Nov 2025 16:26:07 +0000 (UTC)
Date: Sun, 16 Nov 2025 17:26:07 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, 
	Maxime Ripard <mripard@kernel.org>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Thomas =?utf-8?Q?M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
Subject: Re: [PATCH can] can: sun4i_can: sun4i_can_interrupt(): fix max irq
 loop handling
Message-ID: <20251116-mysterious-delightful-spaniel-18d220-mkl@pengutronix.de>
References: <20251116-sun4i-fix-loop-v1-1-3d76d3f81950@pengutronix.de>
 <2804881.mvXUDI8C0e@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="em24b66ivg3z2dow"
Content-Disposition: inline
In-Reply-To: <2804881.mvXUDI8C0e@jernej-laptop>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--em24b66ivg3z2dow
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can] can: sun4i_can: sun4i_can_interrupt(): fix max irq
 loop handling
MIME-Version: 1.0

On 16.11.2025 17:20:37, Jernej =C5=A0krabec wrote:
> Dne nedelja, 16. november 2025 ob 16:55:26 Srednjeevropski standardni =C4=
=8Das je Marc Kleine-Budde napisal(a):
> > Reading the interrupt register `SUN4I_REG_INT_ADDR` causes all of its b=
its
> > to be reset. If we ever reach the condition of handling more than
> > `SUN4I_CAN_MAX_IRQ` IRQs, we will have read the register and reset all =
its
> > bits but without actually handling the interrupt inside of the loop bod=
y.
> >
> > This may, among other issues, cause us to never `netif_wake_queue()` ag=
ain
> > after a transmission interrupt.
> >
> > Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - K=
ernel module")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
> > Signed-off-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > I've ported the fix from the sja1000 driver to the sun4i_can, which bas=
ed
> > on the sja1000 driver.
>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Thank you very much! I have seen a lot of feedback from you about the
sun4i driver. Would you like to become the maintainer of the driver?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--em24b66ivg3z2dow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkZ+xoACgkQDHRl3/mQ
kZzTlwf+KKSw3ld6WMWkRDCymQOeVahqaRqN6JLXg1lCVaiFL5OC0OApQ1hYnCLR
rEnb47cb4jxA/HVt1O2aCS6sOT+OKVSU5kOhFbFFnwcZxrGe54PzPDM//9iHNzd6
k0HxI1kejcL9ehlMgY5kxUyQG0YUyl2IZjMoPIldc0STty7sK6sBwC4Cq2R6lGtb
/7RSNZk95tKD7mOabKemeCJDkVrQ0XW2OK9HZaWTxcPEOcmSkp61pZ6rkzJPx06M
fPPFvVvG3stojpsJXrslsB/hl+NIjh02w+Tvk6fO+UvyXHsIbKVIpe/aLDUWaRwv
65u3bPD6FMVnzSXzfHs0jijKWABtBw==
=CLj+
-----END PGP SIGNATURE-----

--em24b66ivg3z2dow--

