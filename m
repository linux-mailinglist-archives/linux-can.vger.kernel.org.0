Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3BF32C5A1
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 02:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351502AbhCDAX4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240731AbhCCM4o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 07:56:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B76C061756
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 04:55:26 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHR2C-0006wP-Tx; Wed, 03 Mar 2021 13:55:24 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a20d:2fb6:f2cb:982e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 12F595ECC0A;
        Wed,  3 Mar 2021 12:55:24 +0000 (UTC)
Date:   Wed, 3 Mar 2021 13:55:23 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: m_can: m_can_rx_handler(): fix RX in periphs being
 blocked by error handling
Message-ID: <20210303125523.4tfd6ifwyugoygzh@pengutronix.de>
References: <20210303124950.3917746-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2tzsl3auetcc7u6q"
Content-Disposition: inline
In-Reply-To: <20210303124950.3917746-1-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2tzsl3auetcc7u6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.03.2021 12:49:52, Torin Cooper-Bennun wrote:
> In peripherals, m_can_rx_handler is called with quota =3D 1 from an ISR
> context.

To be precise, it's a threaded Interrupt. Why not call the rx_handler
with a reasonable quota instead?

Marc

> If the M_CAN reports a high volume of errors, such as message
> loss due to heavy bus traffic, then error handling, which is prioritised
> in m_can_rx_handler, fills the quota immediately, and RX does not occur.
> This has been observed to cause an indefinite blocking of RX.
>=20
> The patch fixes this by ensuring that in peripherals, m_can_do_rx_poll
> is always called with a quota of at least 1, regardless of any errors
> handled.
>=20
> This has been tested with the TCAN4550 under heavy bus traffic; message
> loss is still detected correctly.
>=20
> Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> ---
>  drivers/net/can/m_can/m_can.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 3752520a7d4b..3ec42e613ca1 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -866,8 +866,14 @@ static int m_can_rx_handler(struct net_device *dev, =
int quota)
>  	if (irqstatus & IR_ERR_BUS_30X)
>  		work_done +=3D m_can_handle_bus_errors(dev, irqstatus, psr);
> =20
> -	if (irqstatus & IR_RF0N)
> -		work_done +=3D m_can_do_rx_poll(dev, (quota - work_done));
> +	if (irqstatus & IR_RF0N) {
> +		int rx_quota =3D quota - work_done;
> +
> +		if (cdev->is_peripheral && (rx_quota <=3D 0))
> +			rx_quota =3D 1;
> +
> +		work_done +=3D m_can_do_rx_poll(dev, rx_quota);
> +	}
>  end:
>  	return work_done;
>  }
> --=20
> 2.30.1
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2tzsl3auetcc7u6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA/hzgACgkQqclaivrt
76nrYQgAjhyqRSHOwGOPej0KGMKuqg9BicIHT9EAu8dUOSg566PAZxbbSo7G9I/G
fgRzQxglsLWiU4t1j1/Mt9WqPML1OICj8jycsnNVZu7twQ/ZdlyUtb8JMKeXl8Hg
ERke6uNCfRhlxoyxoPgPlkb65G97z+UfZitRrFPSxcVH+A3G9LPb3x+Vqm8/ZrJY
AhNAwJIGrfqr4+tVoqIVZzPNV9GuSzy0QUU5yMTN8JYwJRcI0Hz3myUpd665i5A5
9ObtxbqH4ewoj6Gl9pIIvD5pl8LM+KDYRZfJ3QA/PgwjEjY0HPfRUrcnTadA2Xax
RpcoZ/yvnnxd9neRMz/Y+ybSZGe+mA==
=SIQz
-----END PGP SIGNATURE-----

--2tzsl3auetcc7u6q--
