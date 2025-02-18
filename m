Return-Path: <linux-can+bounces-2838-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8453EA39A94
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 12:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3FF7A1982
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EBE2343BE;
	Tue, 18 Feb 2025 11:22:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455281A841C
	for <linux-can@vger.kernel.org>; Tue, 18 Feb 2025 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877732; cv=none; b=hStEfW95+Xf7ARSAzTg1c8JOH9DeYjEev8KSsaHsHPK6pSECJjhVQWUkgyGyy0VcokFBWa+AdUFdz2nC7Q00fnBlVeqvJjQPuuQU8YtPL56a2rlPsuJnMspoc2RzLMbztbrrm4pzhFmmkzFmPRk3cCW8lx8D7ppx5AEiZfeeqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877732; c=relaxed/simple;
	bh=fWEKlASmJf4ePNJ+S+uAWdduea8Brr0CkD1djFARbnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jwrnqc8WCoOrwIYb4op/6WfQhaXj06ySvQ+Evc/Fvun/p5dXfQhXUCCSoh5qreJGoxRWi3qWVYR2vQuR8x8laGAm57+9/kRsnTtJ/DzcuX0mDCj0tWFHiLqNtvdXyjUAMYbe0eofTeXEE8lAEWEWByWMiobMZI9ZPKF/LmJOF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkLfw-00072b-Tc; Tue, 18 Feb 2025 12:22:04 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkLfw-001aGV-03;
	Tue, 18 Feb 2025 12:22:04 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AEF643C5B5E;
	Tue, 18 Feb 2025 11:22:03 +0000 (UTC)
Date: Tue, 18 Feb 2025 12:22:03 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-can@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 09/11] can: rcar_canfd: Add RZ/G3E support
Message-ID: <20250218-voracious-wise-rabbit-ec8e49-mkl@pengutronix.de>
References: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
 <20250218105007.66358-10-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wujwblwrplzazan5"
Content-Disposition: inline
In-Reply-To: <20250218105007.66358-10-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wujwblwrplzazan5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 09/11] can: rcar_canfd: Add RZ/G3E support
MIME-Version: 1.0

On 18.02.2025 10:49:59, Biju Das wrote:
> The CAN-FD IP found on the RZ/G3E SoC is similar to R-Car Gen4, but
> it has no external clock instead it has clk_ram, it has 6 channels
> and supports 20 interrupts. Add support for RZ/G3E CAN-FD driver.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index d6d7ba3e9ca1..69ccd69f68dd 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -607,6 +607,14 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info=
 =3D {
>  	.multi_channel_irqs =3D 1,
>  };
> =20
> +static const struct rcar_canfd_hw_info r9a09g047_hw_info =3D {
> +	.max_channels =3D 6,
> +	.postdiv =3D 1,
> +	.multi_channel_irqs =3D 1,
> +	.gen4_type =3D 1,
> +	.only_internal_clks =3D 1,
> +};
> +
>  /* Helper functions */
>  static inline bool is_gen4(struct rcar_canfd_global *gpriv)
>  {
> @@ -1861,6 +1869,7 @@ static int rcar_canfd_probe(struct platform_device =
*pdev)
>  	u32 rule_entry =3D 0;
>  	bool fdmode =3D true;			/* CAN FD only mode - default */
>  	char name[9] =3D "channelX";
> +	struct clk *clk_ram;
>  	int i;
> =20
>  	info =3D of_device_get_match_data(dev);
> @@ -1950,6 +1959,11 @@ static int rcar_canfd_probe(struct platform_device=
 *pdev)
>  		gpriv->extclk =3D !gpriv->info->only_internal_clks;
>  	}
> =20
> +	clk_ram =3D devm_clk_get_optional_enabled(dev, "ram_clk");

This will keep the clock enabled, even if the interface is down. Do you
care for a more fine grained clock handling?

> +	if (IS_ERR(clk_ram))
> +		return dev_err_probe(dev, PTR_ERR(clk_ram),
> +				     "cannot get ram clock\n");
> +
>  	addr =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(addr)) {
>  		err =3D PTR_ERR(addr);
> @@ -2112,6 +2126,7 @@ static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_ca=
nfd_suspend,
> =20
>  static const __maybe_unused struct of_device_id rcar_canfd_of_table[] =
=3D {
>  	{ .compatible =3D "renesas,r8a779a0-canfd", .data =3D &rcar_gen4_hw_inf=
o },
> +	{ .compatible =3D "renesas,r9a09g047-canfd", .data =3D &r9a09g047_hw_in=
fo },
>  	{ .compatible =3D "renesas,rcar-gen3-canfd", .data =3D &rcar_gen3_hw_in=
fo },
>  	{ .compatible =3D "renesas,rcar-gen4-canfd", .data =3D &rcar_gen4_hw_in=
fo },
>  	{ .compatible =3D "renesas,rzg2l-canfd", .data =3D &rzg2l_hw_info },

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wujwblwrplzazan5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme0bVcACgkQDHRl3/mQ
kZziqggArN35bcy8/jtIYsgn2yCW1Git8sG2uRz0FxcAEZpGRYR6go+RxD4vnij2
pa3CcorMM0ST7RJ7RnkWs0Llc8lAM6IWo/bqRHKFsB816kS1NFTK4ItPOnX4Q+57
eAUnAeYdQadIDk1xTgI+WvbW8njYYKrpp7GLtE67TAklenS5xFwG0FfdtAZY/qNp
ZyuX1K3q2bi6cHX5S9WoNY4FVe4W20DePmwMjSE3EHDg0De444OpWiwAz3gdaydq
cd6meDUyMlFvv964UmX4ssuF9VO1+J5NQvhHeAFahIUjXHkXEthqB9IZEogwpBxp
O2pELutspw7pkjKKTj+PeoUVbF8jWA==
=Qpzw
-----END PGP SIGNATURE-----

--wujwblwrplzazan5--

