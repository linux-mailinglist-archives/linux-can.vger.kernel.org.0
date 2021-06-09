Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3033A0F17
	for <lists+linux-can@lfdr.de>; Wed,  9 Jun 2021 10:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhFII62 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Jun 2021 04:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhFII62 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Jun 2021 04:58:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A12EC061574
        for <linux-can@vger.kernel.org>; Wed,  9 Jun 2021 01:56:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lqu0k-0005xp-ON; Wed, 09 Jun 2021 10:56:30 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:46e:2de7:d94b:3466])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 542B66371C8;
        Wed,  9 Jun 2021 08:56:28 +0000 (UTC)
Date:   Wed, 9 Jun 2021 10:56:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH 5/5] can: flexcan: add mcf5441x support
Message-ID: <20210609085627.432kdoxrdklt5vsa@pengutronix.de>
References: <20210608204542.983925-1-angelo@kernel-space.org>
 <20210608204542.983925-5-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f47gcazuuykv74de"
Content-Disposition: inline
In-Reply-To: <20210608204542.983925-5-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--f47gcazuuykv74de
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.06.2021 22:45:42, Angelo Dureghello wrote:
> Add flexcan support for NXP ColdFire mcf5441x family.
>=20
> This flexcan module is quite similar to imx6 flexcan module, but
> with some exceptions:
>=20
> - 3 separate interrupt sources, MB, BOFF and ERR,

Please don't hard code the 2 extra interrupts as offsets, but create
proper IRQ resources.

> - implements 16 mb only,
> - m68k architecture is not supporting devicetrees, so a
>   platform data check/case has been added,

You might want to revert:

| 2c0ac9208135 can: flexcan: convert the driver to DT-only

and use it as a starting point.

> - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
>   module.
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
>  drivers/net/can/flexcan.c | 80 +++++++++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 57f3635ad8d7..af95273327cd 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -28,6 +28,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_data/flexcan-mcf.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> @@ -205,6 +206,10 @@
> =20
>  #define FLEXCAN_TIMEOUT_US		(250)
> =20
> +#define FLEXCAN_OFFS_INT_BOFF		1
> +#define FLEXCAN_OFFS_INT_ERR		3
> +#define FLEXCAN_MB_CNT_MCF		16
> +
>  /* FLEXCAN hardware feature flags
>   *
>   * Below is some version info we got:
> @@ -246,6 +251,8 @@
>  #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
>  /* Setup stop mode with SCU firmware to support wakeup */
>  #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
> +/* Setup for flexcan module as in mcf, 16 mb, 3 separate interrupts  */
> +#define FLEXCAN_QUIRK_SETUP_MCF BIT(12)
> =20
>  /* Structure of the message buffer */
>  struct flexcan_mb {
> @@ -371,6 +378,12 @@ struct flexcan_priv {
>  	void (*write)(u32 val, void __iomem *addr);
>  };
> =20
> +static const struct flexcan_devtype_data fsl_mcf_devtype_data =3D {
> +	.quirks =3D FLEXCAN_QUIRK_BROKEN_WERR_STATE |
> +		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> +		FLEXCAN_QUIRK_SETUP_MCF,
> +};
> +
>  static const struct flexcan_devtype_data fsl_p1010_devtype_data =3D {
>  	.quirks =3D FLEXCAN_QUIRK_BROKEN_WERR_STATE |
>  		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> @@ -637,13 +650,17 @@ static int flexcan_clks_enable(const struct flexcan=
_priv *priv)
>  {
>  	int err;
> =20
> -	err =3D clk_prepare_enable(priv->clk_ipg);
> -	if (err)
> -		return err;
> +	if (priv->clk_ipg) {
> +		err =3D clk_prepare_enable(priv->clk_ipg);
> +		if (err)
> +			return err;
> +	}
> =20
> -	err =3D clk_prepare_enable(priv->clk_per);
> -	if (err)
> -		clk_disable_unprepare(priv->clk_ipg);
> +	if (priv->clk_per) {
> +		err =3D clk_prepare_enable(priv->clk_per);
> +		if (err)
> +			clk_disable_unprepare(priv->clk_ipg);
> +	}
> =20
>  	return err;
>  }
> @@ -1401,8 +1418,13 @@ static int flexcan_rx_offload_setup(struct net_dev=
ice *dev)
>  		priv->mb_size =3D sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
>  	else
>  		priv->mb_size =3D sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
> -	priv->mb_count =3D (sizeof(priv->regs->mb[0]) / priv->mb_size) +
> -			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
> +
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF) {
> +		priv->mb_count =3D FLEXCAN_MB_CNT_MCF;
> +	} else {
> +		priv->mb_count =3D (sizeof(priv->regs->mb[0]) / priv->mb_size) +
> +				 (sizeof(priv->regs->mb[1]) / priv->mb_size);
> +	}

nitpick: no { } needed

> =20
>  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
>  		priv->tx_mb_reserved =3D
> @@ -1774,6 +1796,18 @@ static int flexcan_open(struct net_device *dev)
>  	if (err)
>  		goto out_can_rx_offload_disable;
> =20
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF) {
> +		err =3D request_irq(dev->irq + FLEXCAN_OFFS_INT_BOFF,
> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
> +		if (err)
> +			goto out_can_rx_offload_disable;
> +
> +		err =3D request_irq(dev->irq + FLEXCAN_OFFS_INT_ERR,
> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
> +		if (err)
> +			goto out_can_rx_offload_disable;

I'm missing the free_irq() in error handling and the flexcan_close()
function. Please test your driver if it work still after several
modprobe rmmod cycles.

> +	}
> +
>  	flexcan_chip_interrupts_enable(dev);
> =20
>  	can_led_event(dev, CAN_LED_EVENT_OPEN);
> @@ -2047,7 +2081,9 @@ static int flexcan_probe(struct platform_device *pd=
ev)
>  	struct regulator *reg_xceiver;
>  	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
>  	struct flexcan_regs __iomem *regs;
> +	struct mcf_flexcan_platform_data *pdata;
>  	int err, irq;
> +	bool big_endian_module;
>  	u8 clk_src =3D 1;
>  	u32 clock_freq =3D 0;
> =20
> @@ -2059,11 +2095,17 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	else if (IS_ERR(reg_xceiver))
>  		return PTR_ERR(reg_xceiver);
> =20
> -	if (pdev->dev.of_node) {
> -		of_property_read_u32(pdev->dev.of_node,
> -				     "clock-frequency", &clock_freq);
> -		of_property_read_u8(pdev->dev.of_node,
> -				    "fsl,clk-source", &clk_src);
> +	pdata =3D dev_get_platdata(&pdev->dev);
> +	if (pdata) {
> +		clock_freq =3D pdata->clock_frequency;
> +		clk_src =3D pdata->clk_src;
> +	} else {
> +		if (pdev->dev.of_node) {

else if

> +			of_property_read_u32(pdev->dev.of_node,
> +					     "clock-frequency", &clock_freq);
> +			of_property_read_u8(pdev->dev.of_node,
> +					    "fsl,clk-source", &clk_src);
> +		}
>  	}
> =20
>  	if (!clock_freq) {
> @@ -2091,6 +2133,11 @@ static int flexcan_probe(struct platform_device *p=
dev)
> =20
>  	devtype_data =3D of_device_get_match_data(&pdev->dev);
> =20
> +	if (pdata && !devtype_data) {
> +		devtype_data =3D
> +			(struct flexcan_devtype_data *)&fsl_mcf_devtype_data;

That looks broken, see 2c0ac9208135 how to do this properly. Please add a
name "flexcan-mcf" to the id_table and use fsl_mcf_devtype_data as
driver_data.

> +	}
> +
>  	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
>  	    !(devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)) {
>  		dev_err(&pdev->dev, "CAN-FD mode doesn't work with FIFO mode!\n");
> @@ -2110,8 +2157,11 @@ static int flexcan_probe(struct platform_device *p=
dev)
> =20
>  	priv =3D netdev_priv(dev);
> =20
> -	if (of_property_read_bool(pdev->dev.of_node, "big-endian") ||
> -	    devtype_data->quirks & FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN) {
> +	big_endian_module =3D pdata ? pdata->big_endian :
> +		of_property_read_bool(pdev->dev.of_node, "big-endian");

Please add the FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN to you
fsl_mcf_devtype_data if needed. There's no need to add a 3rd way of
configuring this.

> +
> +	if (big_endian_module ||
> +		(devtype_data->quirks & FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN)) {
>  		priv->read =3D flexcan_read_be;
>  		priv->write =3D flexcan_write_be;
>  	} else {
> --=20
> 2.31.1
>=20
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--f47gcazuuykv74de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDAgjgACgkQqclaivrt
76kfDwf/UaCyMfrgKG+vsBRACf+7mRrZXD9z3ZCunRTH5Tju71snO/eThFZZLLel
ktP/RVjb7Ju5GBqEX3Zq4NtiDmj4cms8ILDkn2bgGE/Ki2BM4rEfMbJUeATKOTyG
XW46CyqDZsHa6CCeSz1ibWl/Mx28A8EnspZorE6tiw6xcc4Yd5/Zbqy+YDn+SX7u
OmxFPQDohE7ZdSCW2vzPvvUnUVO8Dgtyxg4+V/mpwOmS2Vaac5HgnhGQNfNga498
6Ebh7iD5icakKGXNVrU7dNG5bCZexoQFGePgP/7OCZ1t07VEjiiorwa8GqFRyPEr
gviJ5DsFtmrRNGQCBZOXJl6sIaBXow==
=P+T5
-----END PGP SIGNATURE-----

--f47gcazuuykv74de--
