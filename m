Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBADB391B76
	for <lists+linux-can@lfdr.de>; Wed, 26 May 2021 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhEZPRf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 May 2021 11:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbhEZPRe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 May 2021 11:17:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214EFC061574
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 08:16:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1llvGL-0007Kp-K5; Wed, 26 May 2021 17:16:01 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:cbc5:840b:a05c:ea5c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CE88362CB1F;
        Wed, 26 May 2021 15:16:00 +0000 (UTC)
Date:   Wed, 26 May 2021 17:15:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 5/5] can: tcan4x5x: implement handling of device
 interrupts
Message-ID: <20210526151559.sfmseqqxzatlboay@pengutronix.de>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526124747.674055-6-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2zmfg37rnbhupzmb"
Content-Disposition: inline
In-Reply-To: <20210526124747.674055-6-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2zmfg37rnbhupzmb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.05.2021 13:47:47, Torin Cooper-Bennun wrote:
> Handle power, transceiver and SPI failures by printing a useful error
> message (multiple simultaneous failures are not logged) and disabling
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is this a limitation of your code or the tcan core?

> the TCAN4550 by setting it to standby mode.
>=20
> Additionally, print an error message if any regmap access fails in the
> tcan4x5x_handle_dev_interrupts() call.
>=20
> Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> ---
>  drivers/net/can/m_can/tcan4x5x-core.c | 50 ++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index a300a14dc5de..2016a4b54a44 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -38,6 +38,7 @@
>  #define TCAN4X5X_CANDOM_INT_EN BIT(8)
>  #define TCAN4X5X_CANBUS_ERR_INT_EN BIT(5)
>  #define TCAN4X5X_BUS_FAULT BIT(4)
> +#define TCAN4X5X_SPIERR_INT BIT(3)
>  #define TCAN4X5X_MCAN_INT BIT(1)
>  #define TCAN4X5X_ENABLE_TCAN_INT \
>  	(TCAN4X5X_UVSUP_INT_EN | TCAN4X5X_UVIO_INT_EN | TCAN4X5X_TSD_INT_EN | \
> @@ -214,7 +215,54 @@ static int tcan4x5x_clear_interrupts(struct m_can_cl=
assdev *cdev)
>  static irqreturn_t tcan4x5x_handle_dev_interrupts(struct m_can_classdev =
*cdev,
>  						  bool clear_only)
>  {
> -	tcan4x5x_clear_interrupts(cdev);
> +	struct tcan4x5x_priv *priv =3D cdev_to_priv(cdev);
> +	int err =3D 0;
> +	irqreturn_t handled =3D IRQ_NONE;

nitpick: please make "int err" the last.

> +
> +	if (!clear_only) {
> +		u32 ir =3D 0;
> +		const char *fail_str =3D "";

nitpick: please make the u32 the last.

> +
> +		err =3D regmap_read(priv->regmap, TCAN4X5X_INT_FLAGS, &ir);
> +		if (err)
> +			goto exit_regmap_failure;
> +
> +		handled =3D IRQ_HANDLED;
> +
> +		if (ir & TCAN4X5X_UVSUP_INT_EN)
> +			fail_str =3D "supply under-voltage (UVSUP)";
> +		else if (ir & TCAN4X5X_UVIO_INT_EN)
> +			fail_str =3D "I/O under-voltage (UVIO)";
> +		else if (ir & TCAN4X5X_TSD_INT_EN)
> +			fail_str =3D "thermal shutdown (TSD)";
> +		else if (ir & TCAN4X5X_ECCERR_INT_EN)
> +			fail_str =3D "uncorrectable ECC error (ECCERR)";
> +		else if (ir & TCAN4X5X_CANDOM_INT_EN)
> +			fail_str =3D "CAN stuck dominant (CANDOM)";

The error message suggests, that this error can be triggered by messing
around with the CAN high/low wires. I'm not sure if it's a good idea to
shutdown the driver in this case.

> +		else if (ir & TCAN4X5X_SPIERR_INT)
> +			fail_str =3D "SPI error (SPIERR)";
> +		else
> +			handled =3D IRQ_NONE;
> +
> +		if (handled =3D=3D IRQ_HANDLED) {
> +			netdev_err(cdev->net, "%s: device is disabled.\n",

Better change the error message and say that the driver is disabling the
device due to the error.

> +				   fail_str);
> +			err =3D regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
> +						 TCAN4X5X_MODE_SEL_MASK,
> +						 TCAN4X5X_MODE_STANDBY);
> +			if (err)
> +				goto exit_regmap_failure;
> +		}
> +	}
> +
> +	err =3D tcan4x5x_clear_interrupts(cdev);
> +	if (err)
> +		goto exit_regmap_failure;
> +
> +	return handled;
> +
> +exit_regmap_failure:
> +	netdev_err(cdev->net, "regmap access failed in IRQ handler.\n");
>  	return IRQ_NONE;
>  }
> =20
> --=20
> 2.30.2
>=20
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2zmfg37rnbhupzmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCuZi0ACgkQqclaivrt
76mWlAf/UGzHdaYejMSrr0Z3oFMg03XMQvViWhTrO6ayZRqOLnppJVmQlrq0a6N3
ah1QZiqxS9qrDq+Mx9rvppOcdFQisWnOKE5yKed9lZzsEzIeHSMdWxuCTu4Xvsrd
x38kQUO+ewSUC14MEGB5voqEq+Yx/yXfRYeGucYC6lK56t1zVVnzhLcjIXzu/yjW
YOaaUhXXFjFbkpdEsBnf2UZiQKgQG7GH6fAb2Y3wp+LIBGMmGHDc8h3YdqbV2KTC
dvLpKjLGoBPMYvrWy7FZFNzaalPnluMootpLpJDglx0coSYCXezo5MpJbEmUK7sw
nopekRSghSJsERjtYtAwRaCU3ep2OA==
=SFIR
-----END PGP SIGNATURE-----

--2zmfg37rnbhupzmb--
