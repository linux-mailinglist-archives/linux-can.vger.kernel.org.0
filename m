Return-Path: <linux-can+bounces-3396-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E5FA87C88
	for <lists+linux-can@lfdr.de>; Mon, 14 Apr 2025 11:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1791E3B5096
	for <lists+linux-can@lfdr.de>; Mon, 14 Apr 2025 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3917D1C6FF0;
	Mon, 14 Apr 2025 09:56:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B801E833E
	for <linux-can@vger.kernel.org>; Mon, 14 Apr 2025 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624566; cv=none; b=BAm5ClI4atRZULoK8ZDqAEsZ6GB09emqzI96Fm6wtxapDNgnOKbNMb550U0eGD5A24g4x3FbDtmyGZKHcdMELyfjeiuSy5/hnWfWn22voQRcc+JeypxxXjoZmwxlK+6q9vYr7FksENucNzq0PNCKX6WjqPMW6nZuY59p+yg38oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624566; c=relaxed/simple;
	bh=OV1EzzxU6BT+4RXWgFZVQIO7++2gzfwNYAlmrRPG1S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLmtR/Xm13VcqdHWvPQXlW+1Tk2Itfw5HZXuRiYX7y3qKaV2ctltTjEwLtFY1UVutVJFiJpHVlf3EgUhIZvvk8mAK5+DYYm3oSRHPtHC6RAPLKwmdi5QKtjnenq5wpvLQYVY+Dj6NTCincx69Di8n9lkPLFPm9R8i4m6IpRyrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4GXS-0007bO-1c; Mon, 14 Apr 2025 11:55:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4GXQ-000EF7-1a;
	Mon, 14 Apr 2025 11:55:36 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1E13C3F82E7;
	Mon, 14 Apr 2025 09:55:36 +0000 (UTC)
Date: Mon, 14 Apr 2025 11:55:34 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, 
	Maxime Ripard <mripard@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>, 
	imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>, Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH] can: flexcan: enable PER clock before obtaining its rate
Message-ID: <20250414-camouflaged-silver-dodo-d0c000-mkl@pengutronix.de>
References: <20250414073646.1473157-1-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emwb45a7ubtws4mt"
Content-Disposition: inline
In-Reply-To: <20250414073646.1473157-1-ciprianmarian.costea@oss.nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--emwb45a7ubtws4mt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: flexcan: enable PER clock before obtaining its rate
MIME-Version: 1.0

On 14.04.2025 10:36:46, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>=20
> The FlexCan driver assumes that the frequency of the 'per' clock can be
> obtained even on disabled clocks, which is not always true.
>=20
> According to 'clk_get_rate' documentation, it is only valid once the clock
> source has been enabled.

In commit bde8870cd8c3 ("clk: Clarify clk_get_rate() expectations")
Maxime Ripard changed the documentation of the of the function in clk.c
to say it's allowed. However clk.h states "This is only valid once the
clock source has been enabled.".

I've added the common clock maintainers to Cc.

Which documentation is correct? Is the clk.h correct for archs not using
the common clock framework?

regards,
Marc

> Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 6d80c341b26f..b142aa60620e 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2056,6 +2056,26 @@ static int flexcan_setup_stop_mode(struct platform=
_device *pdev)
>  	return 0;
>  }
> =20
> +static unsigned long get_per_clk_rate(struct clk *clk)
> +{
> +	unsigned long rate;
> +	int err;
> +
> +	rate =3D clk_get_rate(clk);
> +	if (rate)
> +		return rate;
> +
> +	/* Just in case this clock is disabled by default */
> +	err =3D clk_prepare_enable(clk);
> +	if (err)
> +		return 0;
> +
> +	rate =3D clk_get_rate(clk);
> +	clk_disable_unprepare(clk);
> +
> +	return rate;
> +}
> +
>  static const struct of_device_id flexcan_of_match[] =3D {
>  	{ .compatible =3D "fsl,imx8qm-flexcan", .data =3D &fsl_imx8qm_devtype_d=
ata, },
>  	{ .compatible =3D "fsl,imx8mp-flexcan", .data =3D &fsl_imx8mp_devtype_d=
ata, },
> @@ -2137,7 +2157,7 @@ static int flexcan_probe(struct platform_device *pd=
ev)
>  			dev_err(&pdev->dev, "no per clock defined\n");
>  			return PTR_ERR(clk_per);
>  		}
> -		clock_freq =3D clk_get_rate(clk_per);
> +		clock_freq =3D get_per_clk_rate(clk_per);
>  	}
> =20
>  	irq =3D platform_get_irq(pdev, 0);
> --=20
> 2.45.2
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--emwb45a7ubtws4mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmf825MACgkQDHRl3/mQ
kZyPOgf/ZK/dctPrRanQ8cESl0HysD5WUyHjOnGz8QheSqA3FaUsQ5v4t1bvSEyL
f0iPY0c9UoUe2aDDRppY4lSMjeiXg3YVaJLd1nBBOwUsF+SZ/WySZ3UaWGdYV+sN
jQk+Hok8HJ4zeW2teZ03GMUJBfgmKDhiil/xmls0arclzXxoFe1vwcuvKObVoqAg
s/6gspWKEoKBul0N+M2LkFOO2hUg7W1q/yYqZzs5PPnkHXWo28eTLLUIzenzhShW
B3J9GopR7Q5Bphv31Djkt3afp2h8iqoQgv1Dql9XejSNG37kUbpP9b9TXltrVKDN
OVjasVrqFdBKezzIqAF77aB9ZdzYaw==
=PwcY
-----END PGP SIGNATURE-----

--emwb45a7ubtws4mt--

