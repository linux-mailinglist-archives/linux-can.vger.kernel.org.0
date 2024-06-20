Return-Path: <linux-can+bounces-794-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352B9103DB
	for <lists+linux-can@lfdr.de>; Thu, 20 Jun 2024 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7378282C6E
	for <lists+linux-can@lfdr.de>; Thu, 20 Jun 2024 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D600F15B12F;
	Thu, 20 Jun 2024 12:21:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8F46BF
	for <linux-can@vger.kernel.org>; Thu, 20 Jun 2024 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886067; cv=none; b=Y88kIqWOHQJrL4odr42EesTIY43t4RVN2Ge/sx5Icrt3wEdpUHPPqYbpsVRfgBEkbQWZyKFOa9SWFIWmVWoLlk/P/68qxibz2qyJ2dA2+tsuwzJIgLHxL1sJqZ/R2UYaC51gGPwgYgx+Te0QtRKTbq1LPdOCQ8VFME8Oco8mawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886067; c=relaxed/simple;
	bh=pDLcbdt48mR4rRqS0d+K99sMBmIQnr8vwVop5yMPZ/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD3nRCIrieqndWsAHWFkYVo9lMu2olERetH310/RCB2ARq5+lnyuve4FNsDNPyFCxBuf+b2RbPNOG8SD4I0uQbrz8Ub64WHtay7egJXpgWuCXU6ytz+3fV1lso5N1NGfdJDmGKPLmZ/rRMV1EjUE7HTBoh9VcdG+rXVFvpBXm3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKGmd-0005Iq-GU; Thu, 20 Jun 2024 14:20:55 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKGmb-003hPJ-Ie; Thu, 20 Jun 2024 14:20:53 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 41E2D2ED9C4;
	Thu, 20 Jun 2024 12:20:53 +0000 (UTC)
Date: Thu, 20 Jun 2024 14:20:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thomas Kopp <thomas.kopp@microchip.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] can: hi311x: simplify with
 spi_get_device_match_data()
Message-ID: <20240620-imaginary-sepia-gibbon-048a32-mkl@pengutronix.de>
References: <20240606142424.129709-1-krzysztof.kozlowski@linaro.org>
 <CAMZ6RqKCWzzbd-P7rOMEryd=31pdD_PJJvtQFYcmS+wAf8q+CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="klzengf2dxnhd3i4"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKCWzzbd-P7rOMEryd=31pdD_PJJvtQFYcmS+wAf8q+CQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--klzengf2dxnhd3i4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.06.2024 12:26:13, Vincent MAILHOL wrote:
> Hi Krzysztof,
>=20
> On Thu. 6 Jun. 2024 =C3=A0 23:24, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > Use spi_get_device_match_data() helper to simplify a bit the driver.
>=20
> Thanks for this clean up.
>=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  drivers/net/can/spi/hi311x.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
> > index e1b8533a602e..5d2c80f05611 100644
> > --- a/drivers/net/can/spi/hi311x.c
> > +++ b/drivers/net/can/spi/hi311x.c
> > @@ -830,7 +830,6 @@ static int hi3110_can_probe(struct spi_device *spi)
> >         struct device *dev =3D &spi->dev;
> >         struct net_device *net;
> >         struct hi3110_priv *priv;
> > -       const void *match;
> >         struct clk *clk;
> >         u32 freq;
> >         int ret;
> > @@ -874,11 +873,7 @@ static int hi3110_can_probe(struct spi_device *spi)
> >                 CAN_CTRLMODE_LISTENONLY |
> >                 CAN_CTRLMODE_BERR_REPORTING;
> >
> > -       match =3D device_get_match_data(dev);
> > -       if (match)
> > -               priv->model =3D (enum hi3110_model)(uintptr_t)match;
> > -       else
> > -               priv->model =3D spi_get_device_id(spi)->driver_data;
> > +       priv->model =3D (enum hi3110_model)spi_get_device_match_data(sp=
i);
>=20
> Here, you are dropping the (uintptr_t) cast. Casting a pointer to an
> enum type can trigger a zealous -Wvoid-pointer-to-enum-cast clang
> warning, and the (uintptr_t) cast is the defacto standard to silence
> such warnings, thus the double (enum hi3110_model)(uintptr_t) cast in
> the initial version.

I've re-added the intermediate cast to uintptr_t while applying.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--klzengf2dxnhd3i4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ0HqIACgkQKDiiPnot
vG87Lwf9EzzimSKKSgtFXoq2HO8VnuxBP+DjBq8rr0kvKOmwRNIqSF872gMkSwFI
iLjNLKkfnxe3IwGAdk7lzRG/iyk6IUul/pNk/WD1ZUY9TAF7Rm0RxIlGnDTFFxuE
pF3JlzBMTyv+p8e2Yqslkuvx9UIHKdVX0bfglLfyVDnVrfZjHtuS7fDNSNbtRiNJ
2MxXMnjT+seoCKodHScZksNVilcjR6F0ieR2J40vZo+ihsTpuziYiZ4/z7qUQgS0
3MChr23NDRvSQdMuh48jp8l8k6r3eWi5lgF+Ps0mKruHXMZk3xMWXh/kjuWSxHsZ
fXhR9WjSzF0IsAfUUVBopTc4TMvlhw==
=U3TR
-----END PGP SIGNATURE-----

--klzengf2dxnhd3i4--

