Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F000179EAF5
	for <lists+linux-can@lfdr.de>; Wed, 13 Sep 2023 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjIMOXv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Sep 2023 10:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjIMOXu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Sep 2023 10:23:50 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E473C98
        for <linux-can@vger.kernel.org>; Wed, 13 Sep 2023 07:23:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qgQmL-0003va-UG; Wed, 13 Sep 2023 16:23:41 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qgQmL-0065sy-HA; Wed, 13 Sep 2023 16:23:41 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4B62321FBA1;
        Wed, 13 Sep 2023 14:23:41 +0000 (UTC)
Date:   Wed, 13 Sep 2023 16:23:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     linux-can@vger.kernel.org,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/2] can: tcan4x5x: support resuming from rx interrupt
 signal
Message-ID: <20230913-curling-prescribe-7fcc5991d7a3-mkl@pengutronix.de>
References: <20230912093807.1383720-1-martin@geanix.com>
 <20230912093807.1383720-2-martin@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iix6uxfhlljdszk3"
Content-Disposition: inline
In-Reply-To: <20230912093807.1383720-2-martin@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--iix6uxfhlljdszk3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.09.2023 11:38:04, Martin Hundeb=C3=B8ll wrote:
> Implement the "wakeup-source" device tree property, so the chip is left
> running when suspending, and its rx interrupt is used as a wakeup source
> to resume operation.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@geanix.com>
> ---
>  drivers/net/can/m_can/tcan4x5x-core.c | 33 ++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 8a4143809d33..e0dee2ce3286 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -459,6 +459,9 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>  		goto out_power;
>  	}
> =20
> +	if (device_property_read_bool(&spi->dev, "wakeup-source"))
> +		device_init_wakeup(&spi->dev, true);
> +
>  	ret =3D m_can_class_register(mcan_class);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed registering m_can device %pe\n",
> @@ -487,6 +490,30 @@ static void tcan4x5x_can_remove(struct spi_device *s=
pi)
>  	m_can_class_free_dev(priv->cdev.net);
>  }
> =20
> +static int __maybe_unused tcan4x5x_suspend(struct device *dev)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +
> +	if (device_may_wakeup(dev)) {
> +		enable_irq_wake(spi->irq);
> +
> +		return m_can_class_suspend(dev, true);
> +	}
> +
> +	return m_can_class_suspend(dev, false);
> +}
> +
> +static int __maybe_unused tcan4x5x_resume(struct device *dev)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	int ret =3D m_can_class_resume(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(spi->irq);
> +
> +	return ret;
> +}
> +
>  static const struct of_device_id tcan4x5x_of_match[] =3D {
>  	{
>  		.compatible =3D "ti,tcan4x5x",
> @@ -505,11 +532,15 @@ static const struct spi_device_id tcan4x5x_id_table=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
> =20
> +const struct dev_pm_ops tcan4x5x_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(tcan4x5x_suspend, tcan4x5x_resume)
> +};

drivers/net/can/m_can/tcan4x5x-core.c:535:25: warning: symbol
'tcan4x5x_pm_ops' was not declared. Should it be static?

> +
>  static struct spi_driver tcan4x5x_can_driver =3D {
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
>  		.of_match_table =3D tcan4x5x_of_match,
> -		.pm =3D NULL,
> +		.pm =3D &tcan4x5x_pm_ops,
>  	},
>  	.id_table =3D tcan4x5x_id_table,
>  	.probe =3D tcan4x5x_can_probe,
> --=20
> 2.42.0
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--iix6uxfhlljdszk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUBxeoACgkQvlAcSiqK
BOicbAf/butUAKhiNzS63yhZGorr86pWyA1flrvqyKeIDBpZMOexiDYNhFMVpAvN
wkCn17XSUzhCTSJ8jIDSw3eLTmzoyNkx17xSeW++WIP0eOzKpq+FpI+VPuxC8MSl
hZBMGx449ec8RtWzODdsY+nEVoslYciRK8YFKfPRyqbt3li1XfLxIIiMmaeYvaph
WXA7z5cQWNHuD1SrjU3mEMqTEeTQ37529/vU1510O6eT8xolEHq+xTD7ykPK3Qdg
dt/hu9ywR57/3z1KRbFIumQhBzl0xcI8BFOJaSmURZMcaXtJ/UsGf+l7bsAUXrdD
suo4jUXEZ11lNxAKW/iFN4kjBS/BNQ==
=Z3pP
-----END PGP SIGNATURE-----

--iix6uxfhlljdszk3--
