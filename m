Return-Path: <linux-can+bounces-3118-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C01A64DC4
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715087A3793
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B030239097;
	Mon, 17 Mar 2025 12:01:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244C1A5BB8
	for <linux-can@vger.kernel.org>; Mon, 17 Mar 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212914; cv=none; b=NusJJUlz3RTvIH8nu2eV5rOAibRHvqQrZ5drHlZiIi+MlWkf2DvkqLNDDVEB8zUXAD3mkuMLnMTzNjymM8rOvTyX29ZlLfOdvVlpC6/MG2sasZhI/PKGYtjoXxYf5UUEpamS0aIehpj4enqtkU8wR0bUdihbcZrFEIOA5KmrstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212914; c=relaxed/simple;
	bh=PlMEiEJDam59+aty2oFc2pESN+enaEybP02730+FEq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGyZWU3pPj0bw6f5sK8lPWWrHHYMT/NgCIr3PJ8I9cSsfLveRTkA8Xugbpp2E6TesA/3Qa4LVLhflBJirvKSePr83j+nEvKI03yEcWgjdcMz22ex3U2HKLJe/O/oLgMgz+yppQ7rlxaNHjhwp4rwUPhMSfFHVVq6hDc0U42x3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tu99w-00020y-0U; Mon, 17 Mar 2025 13:01:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tu99t-000EuM-0g;
	Mon, 17 Mar 2025 13:01:29 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A87EC3DE480;
	Mon, 17 Mar 2025 10:41:48 +0000 (UTC)
Date: Mon, 17 Mar 2025 11:41:48 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, linus.walleij@linaro.org, 
	brgl@bgdev.pl, andi.shyti@kernel.org, mailhol.vincent@wanadoo.fr, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, wim@linux-watchdog.org, linux@roeck-us.net, jdelvare@suse.com, 
	alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v8 4/7] can: Add Nuvoton NCT6694 CANFD support
Message-ID: <20250317-outrageous-helpful-agama-39476f-mkl@pengutronix.de>
References: <20250225081644.3524915-1-a0282524688@gmail.com>
 <20250225081644.3524915-5-a0282524688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vzg54m2aeg5i4qkb"
Content-Disposition: inline
In-Reply-To: <20250225081644.3524915-5-a0282524688@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vzg54m2aeg5i4qkb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 4/7] can: Add Nuvoton NCT6694 CANFD support
MIME-Version: 1.0

On 25.02.2025 16:16:41, Ming Yu wrote:
[...]

> diff --git a/drivers/net/can/usb/nct6694_canfd.c b/drivers/net/can/usb/nc=
t6694_canfd.c
> new file mode 100644
> index 000000000000..d97fce5cdf32
> --- /dev/null
> +++ b/drivers/net/can/usb/nct6694_canfd.c

[...]

> +static const struct can_bittiming_const nct6694_can_bittiming_nominal_co=
nst =3D {
> +	.name =3D DRVNAME,
> +	.tseg1_min =3D 2,
> +	.tseg1_max =3D 256,
> +	.tseg2_min =3D 2,
> +	.tseg2_max =3D 128,
> +	.sjw_max =3D 128,
> +	.brp_min =3D 1,
> +	.brp_max =3D 511,
> +	.brp_inc =3D 1,
> +};
> +
> +static const struct can_bittiming_const nct6694_can_bittiming_data_const=
 =3D {
> +	.name =3D DRVNAME,
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D 32,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 16,
> +	.sjw_max =3D 16,
> +	.brp_min =3D 1,
> +	.brp_max =3D 31,
> +	.brp_inc =3D 1,
> +};

[...]

> +static int nct6694_can_start(struct net_device *ndev)
> +{
> +	struct nct6694_can_priv *priv =3D netdev_priv(ndev);
> +	const struct can_bittiming *d_bt =3D &priv->can.data_bittiming;
> +	const struct can_bittiming *n_bt =3D &priv->can.bittiming;
> +	struct nct6694_can_setting *setting __free(kfree) =3D NULL;
> +	const struct nct6694_cmd_header cmd_hd =3D {
> +		.mod =3D NCT6694_CAN_MOD,
> +		.cmd =3D NCT6694_CAN_SETTING,
> +		.sel =3D ndev->dev_port,
> +		.len =3D cpu_to_le16(sizeof(*setting))
> +	};
> +	int ret;
> +
> +	setting =3D kzalloc(sizeof(*setting), GFP_KERNEL);
> +	if (!setting)
> +		return -ENOMEM;
> +
> +	setting->nbr =3D cpu_to_le32(n_bt->bitrate);
> +	setting->dbr =3D cpu_to_le32(d_bt->bitrate);

I just noticed one thing that needs clarification/documentation.

You have nct6694_can_bittiming_nominal_const and
nct6694_can_bittiming_data_const, but only pass the bit rates to your
device.

Do the bit timing const really reflect the HW limitations of your
device?

Are you sure your device uses the same algorithm as the kernel and
calculates the same bit timing parameters as the kernel, so that the
values given to the user space reflects the bit timing parameter chosen
by your device?

> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		setting->ctrl1 |=3D cpu_to_le16(NCT6694_CAN_SETTING_CTRL1_MON);
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
> +		setting->ctrl1 |=3D cpu_to_le16(NCT6694_CAN_SETTING_CTRL1_NISO);
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +		setting->ctrl1 |=3D cpu_to_le16(NCT6694_CAN_SETTING_CTRL1_LBCK);
> +
> +	ret =3D nct6694_write_msg(priv->nct6694, &cmd_hd, setting);
> +	if (ret)
> +		return ret;
> +
> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +	return 0;
> +}

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vzg54m2aeg5i4qkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfX/GkACgkQDHRl3/mQ
kZzJDgf8DgOIcr0MWwz7wlhWys5Fxw4Vtn5MszTN3NLbf2p+jPRy/TQKbi3A7p+B
PZFdTyo+sYOdG9csQChfdGGqWEA5cd6vIMYmIbUO1401s5U+bYudq1+h68pyfOhf
XOKXDxnSWXlzFLw2vu2SsZ3M4svT1cU0S6NRSxPx/o4QuFfsG7KLFqwdMK+MEc8P
CcqcJKo47KwOEcWuQm/eTq4LQFvmmKz8/6PCcrY2P99PQ9bqTkoiC7R+KMONa1p3
f2/q875xuTHckepTB7slLcXA9K7ikoT7T865z4jHsZt5ClD3+L/j5pSa82E1kcxN
nv4xvBHXTSmzW8wtGa6VrUWOif5cYg==
=GQzc
-----END PGP SIGNATURE-----

--vzg54m2aeg5i4qkb--

