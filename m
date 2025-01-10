Return-Path: <linux-can+bounces-2567-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F4A08DA3
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 783E27A3F9C
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9A1E200F;
	Fri, 10 Jan 2025 10:13:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093522054EE
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504021; cv=none; b=P5Dknzt2mip+2aq/2fgGi0sfcuhIb6U/JVNux3L9CIdbmVDXHRqtqu0eTjefbidZ6+5EYDMCS9ia/dOeXcdmYIL03jIkskYPFZy5/HNs8VV+dCcUNSOb42yHCLlwu1q2c4kEQE/eELeWHRg9braW6A5A4vhfMrnM9UIqtoOO6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504021; c=relaxed/simple;
	bh=dqMzT4Xu1L5BjVHRnIaTJuoJwr/cdQvhhMHWsfdcQko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOlG7YOraKYMw0jqFnx92TiWkqb+rydUhlGrBve4eQGxMgc9eGspL1C4xK6B+8bbI67oIE9CSNNp6CwAkiaRmDoEP11Nhgrp7W/fby7OYoCC+22dNH7/EfZ5e9tLBUhN4Qls6tEqnmDwabSw6oYzyaTnNCYX4C8REl3pPEWAM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWC1D-0006Vz-Px; Fri, 10 Jan 2025 11:13:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWC1D-0008oI-1r;
	Fri, 10 Jan 2025 11:13:31 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 482BC3A4491;
	Fri, 10 Jan 2025 10:13:31 +0000 (UTC)
Date: Fri, 10 Jan 2025 11:13:31 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: can-transceiver: Drop unnecessary "mux-states"
 property presence check
Message-ID: <20250110-amiable-impartial-chinchilla-0dc0ae-mkl@pengutronix.de>
References: <20241231163251.244167-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3cw2zb4afavmoxfo"
Content-Disposition: inline
In-Reply-To: <20241231163251.244167-1-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--3cw2zb4afavmoxfo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] phy: can-transceiver: Drop unnecessary "mux-states"
 property presence check
MIME-Version: 1.0

On 31.12.2024 10:32:51, Rob Herring (Arm) wrote:
> It doesn't matter whether "mux-states" is not present or there is some
> other issue parsing it causing an error. Drop the presence check and
> rework the error handling to ignore anything other than deferred probe.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/phy/phy-can-transceiver.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-tran=
sceiver.c
> index ee4ce4249698..ed8ba30eb038 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -103,6 +103,7 @@ static int can_transceiver_phy_probe(struct platform_=
device *pdev)
>  	struct phy *phy;
>  	struct gpio_desc *standby_gpio;
>  	struct gpio_desc *enable_gpio;
> +	struct mux_state *mux_state;
>  	u32 max_bitrate =3D 0;
>  	int err;
> =20
> @@ -113,15 +114,12 @@ static int can_transceiver_phy_probe(struct platfor=
m_device *pdev)
>  	match =3D of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata =3D match->data;
> =20
> -	if (of_property_read_bool(dev->of_node, "mux-states")) {
> -		struct mux_state *mux_state;
> -
> -		mux_state =3D devm_mux_state_get(dev, NULL);
> -		if (IS_ERR(mux_state))
> -			return dev_err_probe(&pdev->dev, PTR_ERR(mux_state),
> -					     "failed to get mux\n");
> +	mux_state =3D devm_mux_state_get(dev, NULL);
> +	if (IS_ERR(mux_state)) {
> +		if (PTR_ERR(mux_state) =3D=3D -EPROBE_DEFER)
> +			return PTR_ERR(mux_state);
> +	} else
>  		can_transceiver_phy->mux_state =3D mux_state;
> -	}

Nitpick:
I think we want { } on both sides of the if/else.

After fixing this:
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

> =20
>  	phy =3D devm_phy_create(dev, dev->of_node,
>  			      &can_transceiver_phy_ops);
> --=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3cw2zb4afavmoxfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeA8scACgkQKDiiPnot
vG8nLAf/dLVWSXMBeNKUG0l6POKIND14Axc6EfZuG/QFbvxGVyFzM89BQUCZeYwi
aSo7HwiPNwPeD3R/LBjaPx76h2Zo5SIRyBc+aYKvW4+HjmhNR6t0iZTx9jhoyssu
8cuSBspk9Le8yLvoxAiERzZdvLIia3HqJH0Qy3zxmjG7oTO2mv7D8OONt6Sr5R7f
r6/nCRXhN2wQoWo8AxAKS6Z9sZ4G/QB6UeTJ8olRbqsGj6fJHjUbKta9tiBQMeW/
aIkwopHPnGIKwPrH3ZA8jGMKA9q/fVGWox+XrWmsNPK778y/nApGIIr2rLxVnzXv
I2RyDfKCkBf4TKEYpN20dWddx5+vPw==
=mBep
-----END PGP SIGNATURE-----

--3cw2zb4afavmoxfo--

