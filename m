Return-Path: <linux-can+bounces-2887-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B83A3D386
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 09:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA541887474
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311361EBFF0;
	Thu, 20 Feb 2025 08:43:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990691EB1B8
	for <linux-can@vger.kernel.org>; Thu, 20 Feb 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041006; cv=none; b=LDP8yvHPtqIGXLA+k4Bjx4+fVaDeoTFbrbXLTE3I7YVXG9jnpgSzRPOWLYCVVVx0AJAc9u+9x+y6h0oGWSpqCCVuwB5x877pdLz3sSUzpLfYk0s228OM/poZBQ4hEiWFixbmJLPQUhjWOiJENi5hxCyZekqHfz4KHpwWLwj5twI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041006; c=relaxed/simple;
	bh=Gp0T4fnNUqwihNa8+Tjq8O23Jixx9trh7HX0d7F1Jno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deG3Wv453vmF5dQ9o9ac2OCXeJZ/3qwMYH8PvTw/psZAw1/2BCO6kAKP+6Fpggqjhhq+4WtgZ4J0IB8lq1RuB/zTHK1B8tD+QU4i2dv59+8pNtEIy7t0JXb5CGIR/rZs/vsyn1eO5Naa7/rW3cadNyINyaIMjpBd7TDPP9Trc68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tl29L-00046c-RC; Thu, 20 Feb 2025 09:43:15 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tl29K-001uGz-2g;
	Thu, 20 Feb 2025 09:43:14 +0100
Received: from pengutronix.de (p5b164285.dip0.t-ipconnect.de [91.22.66.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 72CF03C7576;
	Thu, 20 Feb 2025 08:43:14 +0000 (UTC)
Date: Thu, 20 Feb 2025 09:43:13 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v2 2/2] can: flexcan: add transceiver capabilities
Message-ID: <20250220-rugged-solid-gopher-541299-mkl@pengutronix.de>
References: <20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com>
 <20250220-flexcan-add-transceiver-caps-v2-2-a81970f11846@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5wxzyxw3wi7nxkjj"
Content-Disposition: inline
In-Reply-To: <20250220-flexcan-add-transceiver-caps-v2-2-a81970f11846@liebherr.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5wxzyxw3wi7nxkjj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] can: flexcan: add transceiver capabilities
MIME-Version: 1.0

On 20.02.2025 09:22:11, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> Currently the flexcan driver does only support adding PHYs by using the
> "old" regulator bindings. Add support for CAN transceivers as a PHY. Add
> the capability to ensure that the PHY is in operational state when the li=
nk
> is set to an "up" state.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 30 ++++++++++++++++++++++++----=
--
>  drivers/net/can/flexcan/flexcan.h      |  1 +
>  2 files changed, 25 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index b347a1c93536d54efaa5f7d3347bd47c20860b3e..45d9a6957d9a806ed80d810a6=
a5f7eb99fcc702c 100644
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
> @@ -644,18 +645,22 @@ static void flexcan_clks_disable(const struct flexc=
an_priv *priv)
> =20
>  static inline int flexcan_transceiver_enable(const struct flexcan_priv *=
priv)
>  {
> -	if (!priv->reg_xceiver)
> -		return 0;
> +	if (priv->reg_xceiver)
> +		return regulator_enable(priv->reg_xceiver);
> +	else if (priv->transceiver)
> +		return phy_power_on(priv->transceiver);
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
> +	else if (priv->transceiver)
> +		return phy_power_off(priv->transceiver);
> =20
> -	return regulator_disable(priv->reg_xceiver);
> +	return 0;
>  }
> =20
>  static int flexcan_chip_enable(struct flexcan_priv *priv)
> @@ -2086,6 +2091,7 @@ static int flexcan_probe(struct platform_device *pd=
ev)
>  	struct net_device *dev;
>  	struct flexcan_priv *priv;
>  	struct regulator *reg_xceiver;
> +	struct phy *transceiver;
>  	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
>  	struct flexcan_regs __iomem *regs;
>  	struct flexcan_platform_data *pdata;
> @@ -2101,6 +2107,14 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  	else if (IS_ERR(reg_xceiver))
>  		return PTR_ERR(reg_xceiver);
> =20
> +	transceiver =3D devm_phy_optional_get(&pdev->dev, NULL);
> +	if (PTR_ERR(transceiver) =3D=3D -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(transceiver)) {
> +		dev_err(&pdev->dev, "failed to get phy\n");
> +		return PTR_ERR(transceiver);
> +	}

Please use dev_err_probe(), it will be silent in case of EPROBE_DEFER.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5wxzyxw3wi7nxkjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAme26x8ACgkQDHRl3/mQ
kZxJ1wf/aytaPCGbQ/cDAiYhE6JJxMu3i9iCxPZTcnkjiacYKaCGTesf3DzoFD0o
k3v+rAEubhZ4HbzR/JTM0u3NxDKlOVpI2QRdrjUQ6UpCcItnysdgZddRgIeIym1p
I9mVOYkOIybEURT+Ym+g4tPhi6UpKrEfDAMRVBTum8NEmO8aikMAvjuu+74rDe0a
zwfsLpKKqVgmQZTOJ9XNQQuzrvMCOv7V75BimdGosvKNiKO3PFZkkBL6mRz889VB
mCZwLnowqCRxH6z4YGWwHr81uLFUv/03GJ5DsS88t+USqFMdKeIgCGefYpS2llGw
67DsPbGmT2OMCOTktDJWYCiQntfVQg==
=roda
-----END PGP SIGNATURE-----

--5wxzyxw3wi7nxkjj--

