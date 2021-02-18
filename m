Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5417431E927
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 12:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBRLb3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Feb 2021 06:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhBRKXX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Feb 2021 05:23:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACA5C061574
        for <linux-can@vger.kernel.org>; Thu, 18 Feb 2021 02:21:58 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lCgRY-0003tW-G3; Thu, 18 Feb 2021 11:21:56 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:30b:bf0c:f6:5da0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8EC835E3F95;
        Thu, 18 Feb 2021 10:21:55 +0000 (UTC)
Date:   Thu, 18 Feb 2021 11:21:54 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V2 2/3] can: flexcan: enable RX FIFO after FRZ/HALT valid
Message-ID: <20210218102154.es44sbablhr2p5o5@pengutronix.de>
References: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
 <20210203100255.12472-3-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ennrs66ec7m5ktxn"
Content-Disposition: inline
In-Reply-To: <20210203100255.12472-3-qiangqing.zhang@nxp.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ennrs66ec7m5ktxn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.02.2021 18:02:54, Joakim Zhang wrote:
> RX FIFO enable failed could happen when do system reboot stress test:
>=20
> [    0.303958] flexcan 5a8d0000.can: 5a8d0000.can supply xceiver not foun=
d, using dummy regulator
> [    0.304281] flexcan 5a8d0000.can (unnamed net_device) (uninitialized):=
 Could not enable RX FIFO, unsupported core
> [    0.314640] flexcan 5a8d0000.can: registering netdev failed
> [    0.320728] flexcan 5a8e0000.can: 5a8e0000.can supply xceiver not foun=
d, using dummy regulator
> [    0.320991] flexcan 5a8e0000.can (unnamed net_device) (uninitialized):=
 Could not enable RX FIFO, unsupported core
> [    0.331360] flexcan 5a8e0000.can: registering netdev failed
> [    0.337444] flexcan 5a8f0000.can: 5a8f0000.can supply xceiver not foun=
d, using dummy regulator
> [    0.337716] flexcan 5a8f0000.can (unnamed net_device) (uninitialized):=
 Could not enable RX FIFO, unsupported core
> [    0.348117] flexcan 5a8f0000.can: registering netdev failed
>=20
> RX FIFO should be enabled after the FRZ/HALT are valid. But the current
> code enable RX FIFO and FRZ/HALT at the same time.
>=20
> Fixes: e955cead03117 ("CAN: Add Flexcan CAN controller driver")
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/net/can/flexcan.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 737e594cb12c..84c98ea7dd55 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1825,10 +1825,13 @@ static int register_flexcandev(struct net_device =
*dev)
>  	if (err)
>  		goto out_chip_disable;
> =20
> -	/* set freeze, halt and activate FIFO, restrict register access */
> -	reg =3D priv->read(&regs->mcr);
> -	reg |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
> -		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
> +	/* set freeze, halt */
> +	err =3D flexcan_chip_freeze(priv);
> +	if (err)
> +		goto out_chip_disable;
> +
> +	/* activate FIFO, restrict register access */
> +	reg |=3D  FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
>  	priv->write(reg, &regs->mcr);

You are basically writing the contents of the CTRL register into the mcr
register, that's not good.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ennrs66ec7m5ktxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAuP78ACgkQqclaivrt
76ns4Qf/ZeNa28EmRk5xSL8JhaWxwEXt+FmLlC1lmQRoBPWVjS2M3k9BWjkQl9pP
2Iy7Ou9gIq12UWeBbXi5DcZzuV8lesxhfONLwgfVJQt77eRsfZiwGJIXswiVgf8Q
reJVZvmBohQa4wjoJeH0tFdEAXUz2Wi6lhq2zPm5lhc5TFqjiY5dk4DZ4EHdXezG
5eOd1PZrXPONN/PhzUll2UNw5ZW4ZyOTcGPSlMx+IR9gL16TWZD+PXuhge59z7Kk
iW/1603+FlLhlDU88ToHRwPQ3BW9qJVSXXHAUDQ+5nthVWt2VjSAKq1PVbBtKlMr
r7HnXFrfuUXcDZ7zcG2sGdS3Les+MA==
=+GxA
-----END PGP SIGNATURE-----

--ennrs66ec7m5ktxn--
