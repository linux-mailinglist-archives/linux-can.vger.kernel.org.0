Return-Path: <linux-can+bounces-2848-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F713A3BAC0
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F49A3B5AD0
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 09:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2D61B4F14;
	Wed, 19 Feb 2025 09:41:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B43215B971
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958105; cv=none; b=ScVMYHSQMMqS0pkPJDkjs2SNP/wguok4muyCloRx76gu+32SkgVulz4eyZwxkR9t/h26YX/fYWlX7jRCvodeCA0T1X5zAgPsiMs/4NRqQ4Gh9yhasNv4RhCrWOXxrSiNs5SDi5git0A1BmOpLj05+1b4Wn2TEz+QhMvyQHHdHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958105; c=relaxed/simple;
	bh=OqVfjPY4uovxjbBBcLnPOdCFmXYjPN5y/81gUS2Ep4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5b6mMmchH8hQvFH+GHSqiSCW0JmOycc5K6tLOiQoHmUG2u6labHbl1t4XDF4RknpXDUFm05Oo1TY7VwJSm2rOLOlj/UG9gQv9mkZGLNk0tp3nDG4nAvIkPr9ovUazJqK6c7ScJA5ZGDpZ/GcINB0l82skBXSEPtNmz2DEVjZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkga5-0001Ah-I0; Wed, 19 Feb 2025 10:41:25 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkga4-001jyF-2O;
	Wed, 19 Feb 2025 10:41:24 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 690343C67A2;
	Wed, 19 Feb 2025 09:41:24 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:41:24 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH 2/2] can: flexcan: add transceiver capabilities
Message-ID: <20250219-garnet-gorilla-of-will-6e389e-mkl@pengutronix.de>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
 <20250211-flexcan-add-transceiver-caps-v1-2-c6abb7817b0f@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xh2teahwk43t3c4n"
Content-Disposition: inline
In-Reply-To: <20250211-flexcan-add-transceiver-caps-v1-2-c6abb7817b0f@liebherr.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--xh2teahwk43t3c4n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] can: flexcan: add transceiver capabilities
MIME-Version: 1.0

On 11.02.2025 14:12:34, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> Currently the flexcan driver does not support adding PHYs. Add the
> capability to ensure that the PHY is in operational state when the link
> is set to an "up" state.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 25 +++++++++++++++++++------
>  drivers/net/can/flexcan/flexcan.h      |  1 +
>  2 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index ac1a860986df69a1dd64c25ff879490d5b21073b..a03dc8e3c80546a0e2fa9a85f=
0e0cc8159afa4f0 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -30,6 +30,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/phy/phy.h>
> =20
>  #include "flexcan.h"
> =20
> @@ -634,18 +635,22 @@ static void flexcan_clks_disable(const struct flexc=
an_priv *priv)
> =20
>  static inline int flexcan_transceiver_enable(const struct flexcan_priv *=
priv)
>  {
> -	if (!priv->reg_xceiver)
> -		return 0;
> +	if (priv->reg_xceiver)
> +		return regulator_enable(priv->reg_xceiver);
> +	else if (priv->xceiver)
> +		return phy_power_on(priv->xceiver);
> =20
> -	return regulator_enable(priv->reg_xceiver);
> +	return 0;
>  }
> =20
>  static inline int flexcan_transceiver_disable(const struct flexcan_priv =
*priv)
>  {
> -	if (!priv->reg_xceiver)
> -		return 0;
> +	if (priv->reg_xceiver)
> +		return regulator_disable(priv->reg_xceiver);
> +	else if (priv->xceiver)
> +		return phy_power_off(priv->xceiver);
> =20
> -	return regulator_disable(priv->reg_xceiver);
> +	return 0;
>  }
> =20
>  static int flexcan_chip_enable(struct flexcan_priv *priv)
> @@ -2061,6 +2066,7 @@ static int flexcan_probe(struct platform_device *pd=
ev)
>  	struct net_device *dev;
>  	struct flexcan_priv *priv;
>  	struct regulator *reg_xceiver;
> +	struct phy *xceiver;
>  	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
>  	struct flexcan_regs __iomem *regs;
>  	struct flexcan_platform_data *pdata;
> @@ -2076,6 +2082,12 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  	else if (IS_ERR(reg_xceiver))
>  		return PTR_ERR(reg_xceiver);
> =20
> +	xceiver =3D devm_phy_optional_get(&pdev->dev, NULL);
> +	if (IS_ERR(xceiver)) {
> +		dev_err(&pdev->dev, "failed to get phy\n");
> +		return PTR_ERR(xceiver);
> +	}
> +
>  	if (pdev->dev.of_node) {
>  		of_property_read_u32(pdev->dev.of_node,
>  				     "clock-frequency", &clock_freq);
> @@ -2173,6 +2185,7 @@ static int flexcan_probe(struct platform_device *pd=
ev)
>  	priv->clk_per =3D clk_per;
>  	priv->clk_src =3D clk_src;
>  	priv->reg_xceiver =3D reg_xceiver;
> +	priv->xceiver =3D xceiver;
> =20
>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
>  		priv->irq_boff =3D platform_get_irq(pdev, 1);

please also add
	if (xceiver)
		priv->can.bitrate_max =3D xceiver->attrs.max_link_rate;


> diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/=
flexcan.h
> index 4933d8c7439e62b5d6fcc445d88c2b5ccbfa13bb..56be40875eee24aee9297c4bc=
7c2fc4380e682ff 100644
> --- a/drivers/net/can/flexcan/flexcan.h
> +++ b/drivers/net/can/flexcan/flexcan.h
> @@ -103,6 +103,7 @@ struct flexcan_priv {
>  	struct clk *clk_per;
>  	struct flexcan_devtype_data devtype_data;
>  	struct regulator *reg_xceiver;
> +	struct phy *xceiver;

All other drivers name this variable "transceiver", does it make sense
to use this name here, too?

>  	struct flexcan_stop_mode stm;
> =20
>  	int irq_boff;

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xh2teahwk43t3c4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme1p0EACgkQDHRl3/mQ
kZxZawf8DS2ziMwjv52nMtPJBIEZ/Wae0iSvk40AHkni1Cj0dKISm4FEWt9LynG/
XbJfdytN4m1N0ZiMQkPEIkck8ZXUQJuYtmky4Qw4weh3voavw9rZuDRIaCFs99ES
6lNz5Wz59iMipHFv//iWGUrviCkhON34NtKwEd3HKAq+oMb6RYEbvYEjQL36DXj1
0xlDfejiMuSn2J9ylx2h978MCLBibly28BVJZ+6x/qVR70moCg+LWXzKXDW83jhy
siFJMcMfumOJRUiBz0UKVxfEV8D13Hj+XipoLeaJbOI/YA7aIAgq+a2E85TRIk37
z6Prd0caYlIt0sKjG3r1Xtg8Zbc4aw==
=0a4S
-----END PGP SIGNATURE-----

--xh2teahwk43t3c4n--

