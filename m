Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988C83B8DE0
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 08:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhGAGw6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Jul 2021 02:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbhGAGw6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Jul 2021 02:52:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C02C061756
        for <linux-can@vger.kernel.org>; Wed, 30 Jun 2021 23:50:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lyqWi-0007hI-GL; Thu, 01 Jul 2021 08:50:20 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6b79:f6d8:f46:d3ca])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3226D646D4D;
        Thu,  1 Jul 2021 06:50:17 +0000 (UTC)
Date:   Thu, 1 Jul 2021 08:50:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v4 5/5] can: flexcan: add mcf5441x support
Message-ID: <20210701065016.4joc3knflf7foi2k@pengutronix.de>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210630230016.4099050-5-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oz2wlmr5jk2lavg3"
Content-Disposition: inline
In-Reply-To: <20210630230016.4099050-5-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--oz2wlmr5jk2lavg3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2021 01:00:16, Angelo Dureghello wrote:
[...]
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
> @@ -2133,6 +2202,15 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  	priv->devtype_data =3D devtype_data;
>  	priv->reg_xceiver =3D reg_xceiver;
> =20
> +	if (devtype_data->quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> +		priv->irq_boff =3D platform_get_irq(pdev, 1);
> +		if (priv->irq_boff <=3D 0)
> +			return -ENODEV;
I'm missing error handling here.
> +		priv->irq_err =3D platform_get_irq(pdev, 2);
> +		if (priv->irq_err <=3D 0)
> +			return -ENODEV;
I'm missing error handling here.
> +	}
> +
>  	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
>  		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD |
>  			CAN_CTRLMODE_FD_NON_ISO;
> @@ -2322,6 +2400,7 @@ static struct platform_driver flexcan_driver =3D {
>  	},
>  	.probe =3D flexcan_probe,
>  	.remove =3D flexcan_remove,
> +	.id_table =3D flexcan_id_table,
>  };
> =20
>  module_platform_driver(flexcan_driver);

Please add error handling then I think the patch can be merged.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oz2wlmr5jk2lavg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDdZaUACgkQqclaivrt
76kwtwgAjHOzVMlRteBuvzctKsWbzpwAeJnEiMw7tXgxPlKME7GzFJY+9LFSDfZw
okq04uuz3aes6nDSOjAF3WSLvewGw38ZDSMLlFMzGQlsiBIurNBCCrJjLnWLkZnL
6KCKdpyUUAE6lU11UXPb4yMS8XogokX8z56+rSy3bATnwRKvfYZP7qLRSkuT1hI6
oBH3b2N35zVTxnnXarMz3Umgiyabh8rQZDIn5Ux+SExSNuOd2HO5aJ2rY73qg1/j
ay0nd1hRa6inItjnx6WDG8Ia/79uFDOXAyQHzqMGF/J37Awvpl0HTImGNebKo1mv
fyS/6RgKbY01CkqZ2NYugSmprRt5Ow==
=rqCQ
-----END PGP SIGNATURE-----

--oz2wlmr5jk2lavg3--
