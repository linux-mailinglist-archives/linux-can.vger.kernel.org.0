Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF1732C596
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 01:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355371AbhCDAXo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582455AbhCCKWN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 05:22:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934F3C06121F
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 00:31:43 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHMuy-0007sf-Au; Wed, 03 Mar 2021 09:31:40 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a20d:2fb6:f2cb:982e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 773885ECA84;
        Wed,  3 Mar 2021 08:31:37 +0000 (UTC)
Date:   Wed, 3 Mar 2021 09:31:36 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     Mariusz Madej <mariusz.madej@xtrack.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: m_can: reset IR_RF0L in message reception loop
Message-ID: <20210303083136.72bwnozqhzznvanu@pengutronix.de>
References: <0710fbd2-4b88-21bf-88f7-0b97d7e7dc0b@xtrack.com>
 <20210303080809.zfjh6oolqxcv4pir@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6hos46e4c4o3y5xo"
Content-Disposition: inline
In-Reply-To: <20210303080809.zfjh6oolqxcv4pir@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--6hos46e4c4o3y5xo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.03.2021 08:08:09, Torin Cooper-Bennun wrote:
> On Mon, Mar 01, 2021 at 10:21:27PM +0100, Mariusz Madej wrote:
> > Message lost warning is reported in loop without interrupt reset. Besid=
es
> > redundant log messages it may lead to serious performance problem, where
> > fifo gets full faster than next reception is scheduled by NAPI. This
> > patch fixes it.
>=20
> Looking at the flow in m_can_rx_handler, it looks as though
> m_can_handle_bus_errors -> m_can_handle_lost_msg already handles message
> loss properly, and issues a netdev_err. I wonder whether we can remove
> the warning from m_can_do_rx_poll entirely:
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 3752520a7d4b..d783c46cac16 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -501,9 +501,6 @@ static int m_can_do_rx_poll(struct net_device *dev, i=
nt quota)
>  	}
> =20
>  	while ((rxfs & RXFS_FFL_MASK) && (quota > 0)) {
> -		if (rxfs & RXFS_RFL)
> -			netdev_warn(dev, "Rx FIFO 0 Message Lost\n");
> -
>  		m_can_read_fifo(dev, rxfs);
> =20
>  		quota--;
>=20

Looks good to me. Can you send a proper patch?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6hos46e4c4o3y5xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA/SWYACgkQqclaivrt
76mFlAf/R2uYGdkXEMEEEzI2uqCZIEYZpaTkvtVSREjo4bryWGYiyZ8XjsU+od3P
pf1o/M//pVo8wfyZmgBNhcTHNEvU74BhOIvBBqba3wfUot8JF+ZHW5s9ZM8g4/FF
X7IOSxGWR5evJx5PrJ2KzoUxhs12SHvkzwLcpwNygXlcxr+zX5oi5aaTf5ZwcVcA
Id4iEnSFtqU8gE+P5WaiFE2KywtpQjYbiYHk8/wNakhrab05qf7UcpI90i97Srbq
2y8nqPbUzwymeRdJUdppRJ/FxluLkSE0IDkbIuXhOaFlzu/yhWhz6tQW4qDvgdSF
J3sVEYggU1aoiONK2vKBoIKMDD4ORQ==
=GPnK
-----END PGP SIGNATURE-----

--6hos46e4c4o3y5xo--
