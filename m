Return-Path: <linux-can+bounces-3957-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3BDB0188C
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 11:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DFA8E0687
	for <lists+linux-can@lfdr.de>; Fri, 11 Jul 2025 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE127E043;
	Fri, 11 Jul 2025 09:45:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44646258CFA
	for <linux-can@vger.kernel.org>; Fri, 11 Jul 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227117; cv=none; b=bkVX2YkTyW4RAzgjrgswImRUvAxuZqNmh8ObxJjq+w71xB/80d9c6SKMRWF6HNnwkeCmKorY+Zw6cy18JYmUxBbZB/vCayKuFQJLBp+sTIshyWinkg8i8ohWj7Qs++RBY9eTl51RAFCh/lnTwlziDVAhbPrL4Jx73hv2PHXgtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227117; c=relaxed/simple;
	bh=bhuuy8yk+f+h4u7r60YWWgcM7al6qVb0VMaZTqt2gmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbCMPbNSim8maeR0jQ4h5bCC7xR0siHMq6YnbT835JXkv9CDE9cJRdJYhVjG10/OCD3nGEG6UlhSWNWyygTnzY5PfBGyiCXHu1j4myjttOgwI2LGLgSnJZIYtb9MpqimahMA654ABMeLN6A5EyCEVDAt2zCZhACSIHsvgVfKsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAJc-0004nw-3E; Fri, 11 Jul 2025 11:45:12 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uaAJb-007tpk-0h;
	Fri, 11 Jul 2025 11:45:11 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D741543C776;
	Fri, 11 Jul 2025 09:45:10 +0000 (UTC)
Date: Fri, 11 Jul 2025 11:45:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Brett Werling <brett.werling@garmin.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, bwerl.dev@gmail.com
Subject: Re: [PATCH] can: tcan4x5x: fix reset gpio usage during probe
Message-ID: <20250711-translucent-gharial-from-tartarus-e3cdf0-mkl@pengutronix.de>
References: <20250708181154.2987123-1-brett.werling@garmin.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ta634pwcon6pango"
Content-Disposition: inline
In-Reply-To: <20250708181154.2987123-1-brett.werling@garmin.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ta634pwcon6pango
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: tcan4x5x: fix reset gpio usage during probe
MIME-Version: 1.0

On 08.07.2025 13:11:53, Brett Werling wrote:
> Fixes reset GPIO usage during probe by ensuring we retrieve the GPIO and
> take the device out of reset (if it defaults to being in reset) before
> we attempt to communicate with the device. This is achieved by moving
> the call to tcan4x5x_get_gpios() before tcan4x5x_find_version() and
> avoiding any device communication while getting the GPIOs. Once we
> determine the version, we can then take the knowledge of which GPIOs we
> obtained and use it to decide whether we need to disable the wake or
> state pin functions within the device.
>=20
> This change is necessary in a situation where the reset GPIO is pulled
> high externally before the CPU takes control of it, meaning we need to
> explicitly bring the device out of reset before we can start
> communicating with it at all.
>=20
> This also has the effect of fixing an issue where a reset of the device
> would occur after having called tcan4x5x_disable_wake(), making the
> original behavior not actually disable the wake. This patch should now
> disable wake or state pin functions well after the reset occurs.
>=20
> Signed-off-by: Brett Werling <brett.werling@garmin.com>
> ---
>  drivers/net/can/m_can/tcan4x5x-core.c | 56 +++++++++++++++------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 8edaa339d590..c37733bf124e 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -343,21 +343,19 @@ static void tcan4x5x_get_dt_data(struct m_can_class=
dev *cdev)
>  		of_property_read_bool(cdev->dev->of_node, "ti,nwkrq-voltage-vio");
>  }
> =20
> -static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
> -			      const struct tcan4x5x_version_info *version_info)
> +static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
>  {
>  	struct tcan4x5x_priv *tcan4x5x =3D cdev_to_priv(cdev);
>  	int ret;
> =20
> -	if (version_info->has_wake_pin) {
> -		tcan4x5x->device_wake_gpio =3D devm_gpiod_get(cdev->dev, "device-wake",
> -							    GPIOD_OUT_HIGH);
> -		if (IS_ERR(tcan4x5x->device_wake_gpio)) {
> -			if (PTR_ERR(tcan4x5x->device_wake_gpio) =3D=3D -EPROBE_DEFER)
> -				return -EPROBE_DEFER;
> +	tcan4x5x->device_wake_gpio =3D devm_gpiod_get_optional(cdev->dev,
> +							     "device-wake",
> +							     GPIOD_OUT_HIGH);
> +	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
> +		if (PTR_ERR(tcan4x5x->device_wake_gpio) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> =20
> -			tcan4x5x_disable_wake(cdev);

Although the original code doesn't propagate any errors....

> -		}
> +		tcan4x5x->device_wake_gpio =3D NULL;
>  	}
> =20
>  	tcan4x5x->reset_gpio =3D devm_gpiod_get_optional(cdev->dev, "reset",
> @@ -369,19 +367,27 @@ static int tcan4x5x_get_gpios(struct m_can_classdev=
 *cdev,
>  	if (ret)
>  		return ret;
> =20
> -	if (version_info->has_state_pin) {
> -		tcan4x5x->device_state_gpio =3D devm_gpiod_get_optional(cdev->dev,
> -								      "device-state",
> -								      GPIOD_IN);
> -		if (IS_ERR(tcan4x5x->device_state_gpio)) {
> -			tcan4x5x->device_state_gpio =3D NULL;
> -			tcan4x5x_disable_state(cdev);
> -		}
> -	}
> +	tcan4x5x->device_state_gpio =3D devm_gpiod_get_optional(cdev->dev,
> +							      "device-state",
> +							      GPIOD_IN);
> +	if (IS_ERR(tcan4x5x->device_state_gpio))
> +		tcan4x5x->device_state_gpio =3D NULL;
> =20
>  	return 0;
>  }
> =20
> +static void tcan4x5x_check_gpios(struct m_can_classdev *cdev,
> +				 const struct tcan4x5x_version_info *version_info)
> +{
> +	struct tcan4x5x_priv *tcan4x5x =3D cdev_to_priv(cdev);
> +
> +	if (version_info->has_wake_pin && !tcan4x5x->device_wake_gpio)
> +		tcan4x5x_disable_wake(cdev);

=2E.. please add error checking and propagate errors.

> +
> +	if (version_info->has_state_pin && !tcan4x5x->device_state_gpio)
> +		tcan4x5x_disable_state(cdev);
> +}
> +
>  static const struct m_can_ops tcan4x5x_ops =3D {
>  	.init =3D tcan4x5x_init,
>  	.deinit =3D tcan4x5x_deinit,
> @@ -468,17 +474,19 @@ static int tcan4x5x_can_probe(struct spi_device *sp=
i)
>  		goto out_m_can_class_free_dev;
>  	}
> =20
> +	ret =3D tcan4x5x_get_gpios(mcan_class);
> +	if (ret) {
> +		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
> +		goto out_power;
> +	}
> +
>  	version_info =3D tcan4x5x_find_version(priv);
>  	if (IS_ERR(version_info)) {
>  		ret =3D PTR_ERR(version_info);
>  		goto out_power;
>  	}
> =20
> -	ret =3D tcan4x5x_get_gpios(mcan_class, version_info);
> -	if (ret) {
> -		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
> -		goto out_power;
> -	}
> +	tcan4x5x_check_gpios(mcan_class, version_info);

same here

> =20
>  	tcan4x5x_get_dt_data(mcan_class);

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ta634pwcon6pango
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhw3SMACgkQDHRl3/mQ
kZxW2Qf/bb0Eyzf4UlSPfuSwr0KWOFcM6vsf/KIDsWGzY8ztfNxInH3HAbzsDuRj
nFhaqHYJOEMEsrXZyn2ySwAt6noJkOGuYN0RBYC3os2PbpCvhLem+IsXIvFum7uI
LN2Waree+sgWudaa9ciS/YrzSW06BUIlltwqj8gPCxkZxfT7HjqM9Zgv0H8JgPfW
m49gXObRssv308kJLoKZO0xQn+qYLsu//zFFy8ViDi+iGKOvQfk5KvQQDBIuSSUd
MQSqgPBneCHmwb03Oveugn/fSzSaBYqmwQeTKGCHhdIk5Vbs3Kaz0tWnkujlJson
C2V4VHmQWIOnMZlq9WurIxSxLnzx8g==
=UgrP
-----END PGP SIGNATURE-----

--ta634pwcon6pango--

