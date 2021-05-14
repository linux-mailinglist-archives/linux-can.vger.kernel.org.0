Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC00A380B2F
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhENOL2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbhENOL0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 10:11:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B2C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 07:10:15 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhYW5-0008Js-N0; Fri, 14 May 2021 16:10:13 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ab9e:cb46:9dda:16ff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B8B4F6243FF;
        Fri, 14 May 2021 14:10:12 +0000 (UTC)
Date:   Fri, 14 May 2021 16:10:12 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 3/3] can: tcan4x5x: add
 handle_dev_interrupts callback to ops
Message-ID: <20210514141012.3ehw4tosog3lreq4@pengutronix.de>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514121946.2344901-4-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5yqjpvbolhgxn2wd"
Content-Disposition: inline
In-Reply-To: <20210514121946.2344901-4-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5yqjpvbolhgxn2wd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2021 13:19:46, Torin Cooper-Bennun wrote:
> Though the TCAN4550's device-specific interrupts are cleared in
> tcan4x5x_clear_interrupts(), they are ignored, which may cause the m_can
> driver to stop working due to the ISR becoming disabled (the famous
> "nobody cared" message).
>=20
> Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> ---
>  drivers/net/can/m_can/tcan4x5x-core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 4147cecfbbd6..cee7dfff381f 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -39,6 +39,7 @@
>  #define TCAN4X5X_CANBUS_ERR_INT_EN BIT(5)
>  #define TCAN4X5X_BUS_FAULT BIT(4)
>  #define TCAN4X5X_MCAN_INT BIT(1)
> +#define TCAN4X5X_VTWD_INT BIT(0)
>  #define TCAN4X5X_ENABLE_TCAN_INT \
>  	(TCAN4X5X_MCAN_INT | TCAN4X5X_BUS_FAULT | \
>  	 TCAN4X5X_CANBUS_ERR_INT_EN | TCAN4X5X_CANINT_INT_EN)
> @@ -190,6 +191,16 @@ static int tcan4x5x_power_enable(struct regulator *r=
eg, int enable)
>  		return regulator_disable(reg);
>  }
> =20
> +static u32 tcan4x5x_read_tcan_reg(struct m_can_classdev *cdev, int reg)
> +{
> +	struct tcan4x5x_priv *priv =3D cdev_to_priv(cdev);
> +	u32 val;
> +
> +	regmap_read(priv->regmap, reg, &val);
> +
> +	return val;
> +}
> +
>  static int tcan4x5x_write_tcan_reg(struct m_can_classdev *cdev,
>  				   int reg, int val)
>  {
> @@ -221,6 +232,19 @@ static int tcan4x5x_clear_interrupts(struct m_can_cl=
assdev *cdev)
>  				       TCAN4X5X_CLEAR_ALL_INT);
>  }
> =20
> +static irqreturn_t tcan4x5x_handle_dev_interrupts(struct m_can_classdev =
*cdev)
> +{
> +	irqreturn_t ret =3D IRQ_NONE;
> +	int ir;
> +
> +	ir =3D tcan4x5x_read_tcan_reg(cdev, TCAN4X5X_INT_FLAGS);

For new code, please don't wrap the regmap_*() functions so that the
error values are ignored. I know, it's a bit annoying to always do the
"if (err) return err" dance.

As this is the interrupt handler there's not much we can do in case of
an error. In the mcp251xfd driver I print an error message and shut down
the interface. You should at least print an error message at the end of
the handle_interrupts() function.

I think it's best to have a single handle_interrupts() callback that
combines the existing clear_interrupts and this code. If you want to
save an SPI transaction and only read the TCAN4X5X_INT_FLAGS if the
M_CAN_IR is unset, pass is as 2nd parameter from the generic interrupt
handler.

> +
> +	if (ir & (TCAN4X5X_CANDOM_INT_EN | TCAN4X5X_VTWD_INT))
> +		ret =3D IRQ_HANDLED;
> +
> +	return ret;
> +}
> +
>  static int tcan4x5x_init(struct m_can_classdev *cdev)
>  {
>  	struct tcan4x5x_priv *tcan4x5x =3D cdev_to_priv(cdev);
> @@ -305,6 +329,7 @@ static struct m_can_ops tcan4x5x_ops =3D {
>  	.write_fifo =3D tcan4x5x_write_fifo,
>  	.read_fifo =3D tcan4x5x_read_fifo,
>  	.clear_interrupts =3D tcan4x5x_clear_interrupts,
> +	.handle_dev_interrupts =3D tcan4x5x_handle_dev_interrupts,
>  };
> =20
>  static int tcan4x5x_can_probe(struct spi_device *spi)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5yqjpvbolhgxn2wd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCehMEACgkQqclaivrt
76kdAAf8Df+CH1hAVBOv1RuwHfWlm6ocexCc1fZHv9b5aQN0tw8v/dNVpVuEBunR
Cz1TOzmM9X2Mbe+8fuhPHYx9HxPsFciUzWtm2E1EEAf8ksN1PtwU+1FiRKjY0Lat
yLY8HgoGoQhfzrkRZz+Nt/Evm3GmEEcfkDma9LOTKJuaDpF4IxLzO33l2rqgo8MR
WfhK8Isb0pNeCH30TGv1sPMjPXF8uIovRXZgolOnt4bf6bvuXTdx9yMUlF8RyrcY
VqF0ugDCpEt2q5r++Kgw6ZGGjxZ06tiWoiopf9v0V9q7CNELVexScQw6h2X/B1jC
MAg/AbdtMLN5DPiMDK+b4v5/vW0xHw==
=WBYB
-----END PGP SIGNATURE-----

--5yqjpvbolhgxn2wd--
