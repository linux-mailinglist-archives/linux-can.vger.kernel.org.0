Return-Path: <linux-can+bounces-2040-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CAE9C85F6
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23905B21E60
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386DE1DD87C;
	Thu, 14 Nov 2024 09:19:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459429CFB
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575959; cv=none; b=XTrO4qrXvsHRREbVWYUvDjOv2ZtGeBXTwockFntst4VaHNzXcc1RYyxsHju65cSmzsMIMSLLkGgTYVUTsy58s3Jk+4ba5v1G0BJ1w2C6zfWXV1K4cJbcrnuBwnnQvjWImybh+DDEwJtaTcomcGmRohDdXaqyztlwaJ2Z0PhKCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575959; c=relaxed/simple;
	bh=RtZCouCtaFI1zmBIODep1Ex0qiLADVcYrNIwyl66qx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xaj7uk8UQNctyX37YbpXoumM+vLJK18T128HIwbS6DIDTGMwms64kuQJlmifm3vfnTh9jdqdyMsl0sDMgI1V2w+KEMnhDXqiLrCM1JqrcDUpTLIrJPMdN/LaZCXdcYtlVH7PBPGg7n+uGP8FlDb3gGorU+w9hftiwatiVaO01OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBW0D-0007H9-SX; Thu, 14 Nov 2024 10:19:01 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBW0D-000ibF-0Z;
	Thu, 14 Nov 2024 10:19:01 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BC1B0372F1F;
	Thu, 14 Nov 2024 09:19:00 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:19:00 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH can-next v4 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
Message-ID: <20241114-classy-mongoose-of-philosophy-e9dbca-mkl@pengutronix.de>
References: <20241114-tcan-wkrqv-v4-0-f22589d67fb1@geanix.com>
 <20241114-tcan-wkrqv-v4-2-f22589d67fb1@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ogii7zxqsnm7ewak"
Content-Disposition: inline
In-Reply-To: <20241114-tcan-wkrqv-v4-2-f22589d67fb1@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ogii7zxqsnm7ewak
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v4 2/2] can: tcan4x5x: add option for selecting
 nWKRQ voltage
MIME-Version: 1.0

On 14.11.2024 09:52:22, Sean Nyekjaer wrote:
> The nWKRQ pin supports an output voltage of either the internal reference
> voltage (3.6V) or the reference voltage of
> the digital interface 0-6V (VIO).
> Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
>=20
> If this property is omitted the reset default, the internal reference
> voltage, is used.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

I've given my R-b to 1/2 not 2/2 :)

Have you manually added the R-b? "b4" has an support to collect the
trailers and add the to the patches with "b4 trailers -u".

With this change, let b4 add by R-b:

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

> ---
>  drivers/net/can/m_can/tcan4x5x-core.c | 20 ++++++++++++++++++++
>  drivers/net/can/m_can/tcan4x5x.h      |  2 ++
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..12a375c653cbd255b5dc85faf=
2f76de397a644ec 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -92,6 +92,8 @@
>  #define TCAN4X5X_MODE_STANDBY BIT(6)
>  #define TCAN4X5X_MODE_NORMAL BIT(7)
> =20
> +#define TCAN4X5X_NWKRQ_VOLTAGE_VIO BIT(19)
> +
>  #define TCAN4X5X_DISABLE_WAKE_MSK	(BIT(31) | BIT(30))
>  #define TCAN4X5X_DISABLE_INH_MSK	BIT(9)
> =20
> @@ -267,6 +269,13 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
>  	if (ret)
>  		return ret;
> =20
> +	if (tcan4x5x->nwkrq_voltage_vio) {
> +		ret =3D regmap_set_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> +				      TCAN4X5X_NWKRQ_VOLTAGE_VIO);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return ret;
>  }
> =20
> @@ -318,6 +327,15 @@ static const struct tcan4x5x_version_info
>  	return &tcan4x5x_versions[TCAN4X5X];
>  }
> =20
> +static void tcan4x5x_get_dt_data(struct m_can_classdev *cdev)
> +{
> +	struct tcan4x5x_priv *tcan4x5x =3D cdev_to_priv(cdev);
> +	struct device_node *np =3D cdev->dev->of_node;
> +
> +	if (of_property_read_bool(np, "ti,nwkrq-voltage-vio"))
> +		tcan4x5x->nwkrq_voltage_vio =3D true;
> +}
> +
>  static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
>  			      const struct tcan4x5x_version_info *version_info)
>  {
> @@ -453,6 +471,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>  		goto out_power;
>  	}
> =20
> +	tcan4x5x_get_dt_data(mcan_class);
> +
>  	tcan4x5x_check_wake(priv);
> =20
>  	ret =3D tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
> diff --git a/drivers/net/can/m_can/tcan4x5x.h b/drivers/net/can/m_can/tca=
n4x5x.h
> index e62c030d3e1e5a713c997e7c8ecad4a44aff4e6a..203399d5e8ccf3fd7a26b54d8=
356fca9d398524c 100644
> --- a/drivers/net/can/m_can/tcan4x5x.h
> +++ b/drivers/net/can/m_can/tcan4x5x.h
> @@ -42,6 +42,8 @@ struct tcan4x5x_priv {
> =20
>  	struct tcan4x5x_map_buf map_buf_rx;
>  	struct tcan4x5x_map_buf map_buf_tx;
> +
> +	bool nwkrq_voltage_vio;
>  };
> =20
>  static inline void
>=20
> --=20
> 2.46.2
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ogii7zxqsnm7ewak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1wIEACgkQKDiiPnot
vG9qbwgAhVo/ZtACONHdxxF9Cq1VFafMGUn8asKMvcKpXv4Y+z0ev2qSSLQ1hWBC
4/Y960ei0cTJd1tHhKrspU5boKTlGJ4JSMHYzsNdQuC50HNJpdh8j55jiRMUvlQn
/XCSsQelP+X+qqMcykhMD20mm4BcBMOyVsc4jzj65DT4/05wN7cC6NyUMOpmAK9L
tOy9d7E1ksf+OE0O5W38z1CAu4xVtNPvXMt+DHgNs1e2A56VwbEMhED7a4EEG5EC
MNEJJKr5TvBEhKmwWLB67T2pCaLp145b/UQSt7yZSlytenP0s/kI+vOOXXkRpVy2
E4qxEsSYhG+iVZKYdVar0oOgj+DLRQ==
=aHBz
-----END PGP SIGNATURE-----

--ogii7zxqsnm7ewak--

