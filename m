Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB832AEA5
	for <lists+linux-can@lfdr.de>; Wed,  3 Mar 2021 03:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhCBX6x (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Mar 2021 18:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836675AbhCBHTr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Mar 2021 02:19:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BF2C061797
        for <linux-can@vger.kernel.org>; Mon,  1 Mar 2021 23:19:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lGzJA-0000Ef-LV; Tue, 02 Mar 2021 08:19:04 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:170b:eff8:30a0:9455])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AF9355EC01E;
        Tue,  2 Mar 2021 07:19:02 +0000 (UTC)
Date:   Tue, 2 Mar 2021 08:19:01 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Timo =?utf-8?B?U2NobMO8w59sZXI=?= <schluessler@krause.de>,
        ukrfoil@gmail.com, linux-can <linux-can@vger.kernel.org>
Subject: Re: mcp251x hangs during ifup
Message-ID: <20210302071901.ptwvejkedascbdsv@pengutronix.de>
References: <20210301165856.37gvqkomvjkjvbj2@pengutronix.de>
 <CAMZ6RqKfXR9cHxjvnPwxjWHWEuxYNV9V4qLSd0ZQGP0JOMKX0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="civbd7xmcgx54scm"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKfXR9cHxjvnPwxjWHWEuxYNV9V4qLSd0ZQGP0JOMKX0w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--civbd7xmcgx54scm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.03.2021 10:40:21, Vincent MAILHOL wrote:
> On Tue. 2 Mar 2021 at 01:58, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >
> > Hello,
> >
> > in the armbian forum a problem with the mcp215x was reported:
> >
> > https://forum.armbian.com/topic/14909-orange-pi-mcp2515-ip-up-freezes/
> >
> > In the last comment (Posted Saturday at 10:05 PM) Aleksey posted a
> > mcp251x.c with a workaround. After cleanup the diff looks like this:
> >
> > diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251=
x.c
> > index f69fb4238a65..6d5fcf5a19a2 100644
> > --- a/drivers/net/can/spi/mcp251x.c
> > +++ b/drivers/net/can/spi/mcp251x.c
> > @@ -1221,7 +1221,7 @@ static int mcp251x_open(struct net_device *net)
> >         INIT_WORK(&priv->tx_work, mcp251x_tx_work_handler);
> >         INIT_WORK(&priv->restart_work, mcp251x_restart_work_handler);
> > -       ret =3D mcp251x_hw_wake(spi);
> > +       ret =3D mcp251x_hw_reset(spi);
> >         if (ret)
> >                 goto out_free_wq;
> >         ret =3D mcp251x_setup(net, spi);
> >
> > Vincent, it seems the gpio support has broken the driver on some
> > platforms. Do you have an idea?
>=20
> This mcp251x_hw_wake() function was introduced in below commit:
> 8ce8c0abcba3 ("can: mcp251x: only reset hardware as required")
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D8ce8c0abcba314e1fe954a1840f6568bf5aef2ef
>=20
> The GPIO support was then introduced later on in below commit:
> 2d52dabbef60 ("can: mcp251x: add GPIO support")
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D2d52dabbef60da91b72617519495fe77b621e6b8
>=20
> I am adding Timo to the loop. He is the author of the two commits above.
> I think he will be of better support than me here :)

Of course I wanted to add Timo, thanks. I think I've picked your e-mail,
as you've done the newest change on the driver after me :)

Sorry for the noise.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--civbd7xmcgx54scm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA95uMACgkQqclaivrt
76k0fgf+LlAHre/jdoXdbM0/Fwaslw0ohhN5tX3dSmDMrDFov95bVubk/vO8fWm9
LSSSL1/RqGNOP4INBCb+ZXxSs0NVvUOVVMIwcLO3Xb5eHKTnqLnk7cDQKEnaXFgP
BPfVo8bkH30wVWtKXUlmnG2M3UnaoCVoWmfacpmr/Kn3U83kVWtx0XwrnzzEWKIJ
gCzDDW4cTNg/Oj2YCO1ieYZQM2BY0g7Y9jTy3QmFci7QuvJxCE2NxxkVA/dTmyf9
EviKrI7wIOx0tyVeS6RUjC843H83S2BHuzKAtJbrQy1Ueef1jSTnuCBLC18LN6H2
9uNUGxLfsYtD19ukHiXYs/TRU5YBKw==
=UhLa
-----END PGP SIGNATURE-----

--civbd7xmcgx54scm--
