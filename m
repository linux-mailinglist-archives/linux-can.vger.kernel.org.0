Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422623AF5F3
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 21:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFUTVu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFUTVt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 15:21:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8187C061574
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 12:19:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lvPSF-00065d-0S; Mon, 21 Jun 2021 21:19:31 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:eaae:20c7:f8b6:e250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E93AB640AB3;
        Mon, 21 Jun 2021 19:19:28 +0000 (UTC)
Date:   Mon, 21 Jun 2021 21:19:28 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v3 5/5] can: flexcan: add mcf5441x support
Message-ID: <20210621191928.ye7m563rxsfyna24@pengutronix.de>
References: <20210621184615.3345846-1-angelo@kernel-space.org>
 <20210621184615.3345846-5-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmkvbexp4ow3gk46"
Content-Disposition: inline
In-Reply-To: <20210621184615.3345846-5-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--rmkvbexp4ow3gk46
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.06.2021 20:46:15, Angelo Dureghello wrote:
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
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
> Changes for v2:
> - re-add platform data handling restarting from 2c0ac9208135
> - re-add flexcan_id_table, as from 2c0ac9208135
> - usinig irq resources for ERR and BOFF interrupts
> - add missing free_irq() for interrupts
> - minor syntax fixes
> Changes for v3:
> - change platform data include name
> - add mcf5441x to hw feature flags
> - add mb column to hw feature flags
> - fix irq free order
> - add proper error handlings
> - remove unrelated changes
> - split quirk in mb_n and irq_n quirks
> ---
>  drivers/net/can/flexcan.c | 126 ++++++++++++++++++++++++++++++++------
>  1 file changed, 106 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 57f3635ad8d7..123737be2d6b 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -28,6 +28,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/can/platform/flexcan.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> @@ -208,18 +209,19 @@
>  /* FLEXCAN hardware feature flags
>   *
>   * Below is some version info we got:
> - *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err=
 RTR rece-   FD Mode
> + *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err=
 RTR rece-   FD Mode     MB
>   *                                Filter? connected?  Passive detection =
 ption in MB Supported?
> - *   MX25  FlexCAN2  03.00.00.00     no        no        no       no    =
    no           no
> - *   MX28  FlexCAN2  03.00.04.00    yes       yes        no       no    =
    no           no
> - *   MX35  FlexCAN2  03.00.00.00     no        no        no       no    =
    no           no
> - *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no    =
    no           no
> - *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no    =
   yes           no
> - *   MX8QM FlexCAN3  03.00.23.00    yes       yes        no       no    =
   yes          yes
> - *   MX8MP FlexCAN3  03.00.17.01    yes       yes        no      yes    =
   yes          yes
> - *   VF610 FlexCAN3  ?               no       yes        no      yes    =
   yes?          no
> - * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no    =
   yes           no
> - * LX2160A FlexCAN3  03.00.23.00     no       yes        no      yes    =
   yes          yes
> + *   MX25   FlexCAN2  03.00.00.00     no        no        no       no   =
     no           no     64
> + *   MX28   FlexCAN2  03.00.04.00    yes       yes        no       no   =
     no           no     64
> + *   MX35   FlexCAN2  03.00.00.00     no        no        no       no   =
     no           no     64
> + *   MX53   FlexCAN2  03.00.00.00    yes        no        no       no   =
     no           no     64
> + *   MX6s   FlexCAN3  10.00.12.00    yes       yes        no       no   =
    yes           no     64
> + *   MX8QM  FlexCAN3  03.00.23.00    yes       yes        no       no   =
    yes          yes     64
> + *   MX8MP  FlexCAN3  03.00.17.01    yes       yes        no      yes   =
    yes          yes     64
> + *   VF610  FlexCAN3  ?               no       yes        no      yes   =
    yes?          no     64
> + * LS1021A  FlexCAN2  03.00.04.00     no       yes        no       no   =
    yes           no     64
> + * LX2160A  FlexCAN3  03.00.23.00     no       yes        no      yes   =
    yes          yes     64
> + * MCF5441X FlexCAN2  ?               no       yes        no       no   =
    yes           no     16
>   *
>   * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
>   */
> @@ -246,6 +248,10 @@
>  #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
>  /* Setup stop mode with SCU firmware to support wakeup */
>  #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
> +/* Setup 3 separate interrupts, main, boff and err */
> +#define FLEXCAN_QUIRK_NR_IRQ_3 BIT(12)
> +/* Setup 16 mailboxes */
> +#define FLEXCAN_QUIRK_NR_MB_16 BIT(13)
> =20
>  /* Structure of the message buffer */
>  struct flexcan_mb {
> @@ -363,6 +369,9 @@ struct flexcan_priv {
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
> @@ -371,6 +380,11 @@ struct flexcan_priv {
>  	void (*write)(u32 val, void __iomem *addr);
>  };
> =20
> +static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data =3D {
> +	.quirks =3D FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> +		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16,
> +};
> +
>  static const struct flexcan_devtype_data fsl_p1010_devtype_data =3D {
>  	.quirks =3D FLEXCAN_QUIRK_BROKEN_WERR_STATE |
>  		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> @@ -637,13 +651,17 @@ static int flexcan_clks_enable(const struct flexcan=
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
> @@ -1401,8 +1419,12 @@ static int flexcan_rx_offload_setup(struct net_dev=
ice *dev)
>  		priv->mb_size =3D sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
>  	else
>  		priv->mb_size =3D sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
> -	priv->mb_count =3D (sizeof(priv->regs->mb[0]) / priv->mb_size) +
> -			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
> +
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_NR_MB_16)
> +		priv->mb_count =3D FLEXCAN_MCF5411X_MB_CNT_MCF;
> +	else
> +		priv->mb_count =3D (sizeof(priv->regs->mb[0]) / priv->mb_size) +
> +				 (sizeof(priv->regs->mb[1]) / priv->mb_size);
> =20
>  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
>  		priv->tx_mb_reserved =3D
> @@ -1774,6 +1796,18 @@ static int flexcan_open(struct net_device *dev)
>  	if (err)
>  		goto out_can_rx_offload_disable;
> =20
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> +		err =3D request_irq(priv->irq_boff,
> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
> +		if (err)
> +			goto out_can_irq_disable;

out_free_irq

> +
> +		err =3D request_irq(priv->irq_err,
> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
> +		if (err)
> +			goto out_can_irq_boff_disable;

out_free_irq_boff

> +	}
> +
>  	flexcan_chip_interrupts_enable(dev);
> =20
>  	can_led_event(dev, CAN_LED_EVENT_OPEN);
> @@ -1782,6 +1816,10 @@ static int flexcan_open(struct net_device *dev)
> =20
>  	return 0;
> =20
> + out_can_irq_boff_disable:
> +	free_irq(priv->irq_boff, dev);
> + out_can_irq_disable:
> +	free_irq(dev->irq, dev);
>   out_can_rx_offload_disable:
>  	can_rx_offload_disable(&priv->offload);
>  	flexcan_chip_stop(dev);
> @@ -1803,6 +1841,12 @@ static int flexcan_close(struct net_device *dev)
> =20
>  	netif_stop_queue(dev);
>  	flexcan_chip_interrupts_disable(dev);
> +
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> +		free_irq(priv->irq_err, dev);
> +		free_irq(priv->irq_boff, dev);
> +	}
> +
>  	free_irq(dev->irq, dev);
>  	can_rx_offload_disable(&priv->offload);
>  	flexcan_chip_stop_disable_on_error(dev);
> @@ -2039,14 +2083,26 @@ static const struct of_device_id flexcan_of_match=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, flexcan_of_match);
> =20
> +static const struct platform_device_id flexcan_id_table[] =3D {
> +	{
> +		.name =3D "flexcan-mcf5441x",
> +		.driver_data =3D (kernel_ulong_t)&fsl_mcf5441x_devtype_data,
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
> @@ -2064,6 +2120,12 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  				     "clock-frequency", &clock_freq);
>  		of_property_read_u8(pdev->dev.of_node,
>  				    "fsl,clk-source", &clk_src);
> +	} else {
> +		pdata =3D dev_get_platdata(&pdev->dev);
> +		if (pdata) {
> +			clock_freq =3D pdata->clock_frequency;
> +			clk_src =3D pdata->clk_src;
> +		}
>  	}
> =20
>  	if (!clock_freq) {
> @@ -2089,7 +2151,14 @@ static int flexcan_probe(struct platform_device *p=
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
> @@ -2133,6 +2202,19 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  	priv->devtype_data =3D devtype_data;
>  	priv->reg_xceiver =3D reg_xceiver;
> =20
> +	if (devtype_data->quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> +		priv->irq_boff =3D platform_get_irq(pdev, 1);
> +		if (priv->irq_boff <=3D 0) {
> +			err =3D -ENODEV;
> +			goto failed_get_irq_boff;
> +		}
> +		priv->irq_err =3D platform_get_irq(pdev, 2);
> +		if (priv->irq_err <=3D 0) {
> +			err =3D -ENODEV;
> +			goto failed_get_irq_err;
> +		}
> +	}

I suggest to move this directly after the platform_get_irq(pdev, 0),
that makes error handling a lot easier.

> +
>  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
>  		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD |
>  			CAN_CTRLMODE_FD_NON_ISO;
> @@ -2170,6 +2252,9 @@ static int flexcan_probe(struct platform_device *pd=
ev)
>   failed_register:
>  	pm_runtime_put_noidle(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> + failed_get_irq_err:
> +	free_irq(priv->irq_boff, dev);

This is wrong - you cannot free an IRQ you have not requested.

> + failed_get_irq_boff:
>  	free_candev(dev);
>  	return err;
>  }
> @@ -2322,6 +2407,7 @@ static struct platform_driver flexcan_driver =3D {
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
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rmkvbexp4ow3gk46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDQ5j0ACgkQqclaivrt
76kNFQgAmYttlq8RemJ8oW+i+TsSeN8qB9o6H+ylJnVSxdq0GfLhkvQbCsrfV5VZ
50Lbrj/khWkDSWPPW4YJGPqZ6riBH2SS4ol0/ZeUgZMuxTIkzWprcJcVDnoreUml
OoL4V87BvEt9SksvpFqGFHZeWP9x5uT6zxjxkkjjrOIbHUDNZm4He8eX6K0THH2X
z0I2sB3DIA92NYQEkngrWoEdDXiAMjeKoUioscvCdN99U2PjttSS9Bs1Op4mE4RM
TBfiwrpXgpgtWk2E+ajcK5ZKkmAxJXgnVMeYeyFSzDM94ncmCnkl85uSkkcU0lEZ
PzTQONDfMjvptFtIyJtvKjdEOjHArg==
=EOPC
-----END PGP SIGNATURE-----

--rmkvbexp4ow3gk46--
