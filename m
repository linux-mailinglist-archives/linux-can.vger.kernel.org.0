Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A0B3AB436
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhFQNDI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 09:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhFQNDI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 09:03:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E14C061574
        for <linux-can@vger.kernel.org>; Thu, 17 Jun 2021 06:01:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltrdg-0006R8-KT; Thu, 17 Jun 2021 15:00:56 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:653d:6f2f:e25e:5f2e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1969163E166;
        Thu, 17 Jun 2021 13:00:54 +0000 (UTC)
Date:   Thu, 17 Jun 2021 15:00:53 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 5/5] can: flexcan: add mcf5441x support
Message-ID: <20210617130053.yovl3b3p5mn2srnd@pengutronix.de>
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <20210616231652.738027-5-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aqy2zbv5swvjgbvz"
Content-Disposition: inline
In-Reply-To: <20210616231652.738027-5-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--aqy2zbv5swvjgbvz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.06.2021 01:16:52, Angelo Dureghello wrote:
> Add flexcan support for NXP ColdFire mcf5441x family.
>=20
> This flexcan module is quite similar to imx6 flexcan module, but
> with some exceptions:
>=20
> - 3 separate interrupt sources, MB, BOFF and ERR,
> - implements 16 mb only,
> - m68k architecture is not supporting devicetrees, so a
>   platform data check/case has been added,
> - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
>   module.

Please add the mcg5441x to the "FLEXCAN hardware feature flags" table in
the driver, and add a new column for the number of mailboxes.

> ---
> Changes for v2:
> - re-add platform data handling restarting from 2c0ac9208135
> - re-add flexcan_id_table, as from 2c0ac9208135
> - usinig irq resources for ERR and BOFF interrupts
> - add missing free_irq() for interrupts
> - minor syntax fixes
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
>  drivers/net/can/flexcan.c | 95 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 84 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 57f3635ad8d7..2188dc36a010 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -28,6 +28,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/can/platform/mcf5441x.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> @@ -246,6 +247,8 @@
>  #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
>  /* Setup stop mode with SCU firmware to support wakeup */
>  #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
> +/* Setup for flexcan module as in mcf, 16 mb, 3 separate interrupts  */
> +#define FLEXCAN_QUIRK_SETUP_MCF BIT(12)
> =20
>  /* Structure of the message buffer */
>  struct flexcan_mb {
> @@ -363,6 +366,9 @@ struct flexcan_priv {
>  	struct regulator *reg_xceiver;
>  	struct flexcan_stop_mode stm;
> =20
> +	int irq_boff;
> +	int irq_err;
> +
>  	/* IPC handle when setup stop mode by System Controller firmware(scfw) =
*/
>  	struct imx_sc_ipc *sc_ipc_handle;
> =20
> @@ -371,6 +377,12 @@ struct flexcan_priv {
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
> @@ -637,13 +649,17 @@ static int flexcan_clks_enable(const struct flexcan=
_priv *priv)
>  {
>  	int err;
> =20
> -	err =3D clk_prepare_enable(priv->clk_ipg);
> -	if (err)
> -		return err;
> +	if (priv->clk_ipg) {
> +		err =3D clk_prepare_enable(priv->clk_ipg);

Does the coldfire clk_disable_unprepare() work with NULL pointers? I'm
asking for flexcan_clks_disable()...

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
> @@ -1401,8 +1417,12 @@ static int flexcan_rx_offload_setup(struct net_dev=
ice *dev)
>  		priv->mb_size =3D sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
>  	else
>  		priv->mb_size =3D sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
> -	priv->mb_count =3D (sizeof(priv->regs->mb[0]) / priv->mb_size) +
> -			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
> +
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF)
> +		priv->mb_count =3D FLEXCAN_MCF5411X_MB_CNT_MCF;
> +	else
> +		priv->mb_count =3D (sizeof(priv->regs->mb[0]) / priv->mb_size) +
> +				 (sizeof(priv->regs->mb[1]) / priv->mb_size);
> =20
>  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
>  		priv->tx_mb_reserved =3D
> @@ -1774,6 +1794,18 @@ static int flexcan_open(struct net_device *dev)
>  	if (err)
>  		goto out_can_rx_offload_disable;
> =20
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF) {
> +		err =3D request_irq(priv->irq_boff,
> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
> +		if (err)
> +			goto out_can_rx_offload_disable;

Please add proper error handling.

> +
> +		err =3D request_irq(priv->irq_err,
> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
> +		if (err)
> +			goto out_can_rx_offload_disable;

Please add proper error handling.

> +	}
> +
>  	flexcan_chip_interrupts_enable(dev);
> =20
>  	can_led_event(dev, CAN_LED_EVENT_OPEN);
> @@ -1804,6 +1836,12 @@ static int flexcan_close(struct net_device *dev)
>  	netif_stop_queue(dev);
>  	flexcan_chip_interrupts_disable(dev);
>  	free_irq(dev->irq, dev);
> +
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF) {
> +		free_irq(priv->irq_boff, dev);
> +		free_irq(priv->irq_err, dev);
> +	}

please free in the opposite order of requesting

> +
>  	can_rx_offload_disable(&priv->offload);
>  	flexcan_chip_stop_disable_on_error(dev);
> =20
> @@ -2039,14 +2077,26 @@ static const struct of_device_id flexcan_of_match=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, flexcan_of_match);
> =20
> +static const struct platform_device_id flexcan_id_table[] =3D {
> +	{
> +		.name =3D "flexcan-mcf",
> +		.driver_data =3D (kernel_ulong_t)&fsl_mcf_devtype_data,
> +	}, {
> +		/* sentinel */
> +	},
> +};
> +MODULE_DEVICE_TABLE(platform, flexcan_id_table);
> +
>  static int flexcan_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id;
>  	const struct flexcan_devtype_data *devtype_data;
>  	struct net_device *dev;
>  	struct flexcan_priv *priv;
>  	struct regulator *reg_xceiver;
>  	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
>  	struct flexcan_regs __iomem *regs;
> +	struct mcf_flexcan_platform_data *pdata;
>  	int err, irq;
>  	u8 clk_src =3D 1;
>  	u32 clock_freq =3D 0;
> @@ -2061,9 +2111,15 @@ static int flexcan_probe(struct platform_device *p=
dev)
> =20
>  	if (pdev->dev.of_node) {
>  		of_property_read_u32(pdev->dev.of_node,
> -				     "clock-frequency", &clock_freq);
> +				"clock-frequency", &clock_freq);

unrelated change

>  		of_property_read_u8(pdev->dev.of_node,
> -				    "fsl,clk-source", &clk_src);
> +				"fsl,clk-source", &clk_src);

unrelated change

> +	} else {
> +		pdata =3D dev_get_platdata(&pdev->dev);
> +		if (pdata) {
> +			clock_freq =3D pdata->clock_frequency;
> +			clk_src =3D pdata->clk_src;
> +		}
>  	}
> =20
>  	if (!clock_freq) {
> @@ -2089,7 +2145,14 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  	if (IS_ERR(regs))
>  		return PTR_ERR(regs);
> =20
> -	devtype_data =3D of_device_get_match_data(&pdev->dev);
> +	of_id =3D of_match_device(flexcan_of_match, &pdev->dev);
> +	if (of_id)
> +		devtype_data =3D of_id->data;
> +	else if (platform_get_device_id(pdev)->driver_data)
> +		devtype_data =3D (struct flexcan_devtype_data *)
> +			platform_get_device_id(pdev)->driver_data;
> +	else
> +		return -ENODEV;
> =20
>  	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
>  	    !(devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)) {
> @@ -2133,6 +2196,15 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  	priv->devtype_data =3D devtype_data;
>  	priv->reg_xceiver =3D reg_xceiver;
> =20
> +	if (devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF) {
> +		priv->irq_boff =3D platform_get_irq(pdev, 1);
> +		if (priv->irq_boff <=3D 0)
> +			return -ENODEV;

Please add proper error handling.

> +		priv->irq_err =3D platform_get_irq(pdev, 2);
> +		if (priv->irq_err <=3D 0)
> +			return -ENODEV;

Please add proper error handling.

> +	}
> +
>  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
>  		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD |
>  			CAN_CTRLMODE_FD_NON_ISO;
> @@ -2322,6 +2394,7 @@ static struct platform_driver flexcan_driver =3D {
>  	},
>  	.probe =3D flexcan_probe,
>  	.remove =3D flexcan_remove,
> +	.id_table =3D flexcan_id_table,
>  };
> =20
>  module_platform_driver(flexcan_driver);
> --=20
> 2.31.1
>=20
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--aqy2zbv5swvjgbvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDLR4IACgkQqclaivrt
76ly9wf+P+aNO7HXexEBC+xGnwAVME6j18sm1J1ioO2GKozZFhkamB+bkkh5fAQt
fkqjbArhqqc4JFIMzbMB3c8M+LIcdno8ReN3q73Ptfab/oHxV+gyl+DL41QrKNKj
jBipsKN4wWZ+KAo/fuTKVlyTET66CDHduZ4erw+/6ioKZQmRoVNWh5SHHfIw3A99
pefDezPtQly58PXic7mGFSq6ZLiIJ26xXLd5YTI6eDkksj1Pb/1cUCU0kNwrUEox
2wTNYRF0f/nMsqAsc0yCUXZr4/+pyvIr2OmeaL04t473c1pFWCnaU3j1z8+flHCV
qq2ibRLG74sqCmjACXZt9q0tVtMMSg==
=7v8T
-----END PGP SIGNATURE-----

--aqy2zbv5swvjgbvz--
