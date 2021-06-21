Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDAA3AE935
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhFUMjZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 08:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFUMjW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 08:39:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E6C061574
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 05:37:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lvJAn-00086G-Qq; Mon, 21 Jun 2021 14:37:05 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3569:1fb5:40be:61fc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B30D8640644;
        Mon, 21 Jun 2021 12:37:04 +0000 (UTC)
Date:   Mon, 21 Jun 2021 14:37:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: Testing two MCP2518FD's on i.MX8MM
Message-ID: <20210621123704.yc7ohwbuedofoq53@pengutronix.de>
References: <CAOMZO5CwS-cO3W148YHVYFwcL3QC8oFJfeQBb+WN=QgEPU7AsQ@mail.gmail.com>
 <CAOMZO5D3suvPzaMq3Fx9LKDC9mzb-0w6i3EbQum-ozczdY-EPQ@mail.gmail.com>
 <20210615071557.o7fjkleuk777otvm@pengutronix.de>
 <CAOMZO5AMP537Qz1MAb-D_27C=WH-5Cf602hichxty95A6db9-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xn57vvywhbh4vq4z"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AMP537Qz1MAb-D_27C=WH-5Cf602hichxty95A6db9-A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xn57vvywhbh4vq4z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.06.2021 09:24:31, Fabio Estevam wrote:
> > The imx SPI driver has quite some overhead, when it comes to small SPI
> > transfers. The mcp251fd driver performs much better with the SPI IP
> > cores on the raspi, which have quite good optimized drivers.
> >
> > Hook up a scope to the SPI's clock and chip select lines of the imx,
> > you'll see the time between end of transfer until the chip select is
> > inactive is longer than the SPI transfer itself.
> >
> > I expect most bang for the buck can be archived by adding an IRQ less
> > busy polling transfer mode, which kicks in below a certain SPI transfer
> > length.
> >
> > On the mcp251xfd driver side, there is some room for optimization. The
> > basic idea is to reduce the number of SPI transfers by combining several
> > reads into one transfer. This can be done in some places.
> >
> > For peak loads in CAN-2.0 mode it would be interesting to make use of
> > the remaining RAM for a 2nd FIFO.
>=20
> Thanks for your reply.
>=20
> I do see some RCU related errors every time the application is launched:

[...]

> Any ideas how these RCU errors could be fixed?

Can you test if
https://lore.kernel.org/r/20210621123436.2897023-1-mkl@pengutronix.de
fixes your problem? We still have to check if lockdep complains...

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xn57vvywhbh4vq4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDQh+0ACgkQqclaivrt
76nBzwf/Qtlgb6+a5EkCfiw7FIq02kzFWyzaP5sN5MvZmh+PDdbkkx60qf+7cSou
IPv3CSgsQPnXHTRyiGthpNo4hQW/aArdZbz4nvWxlVUSc0fOofGXtKqLni7/tUYV
jbbKiAyhTDtTqRf9I8McwbI85QN61UwNT1hrHwTmlRh3lbs6UQWD3lDylmVNIopX
9yjMiswSd7Vathje3IcjLFX1/8p+uoI7iine/8hY3jnds2uX1wXXlQPukPlt+tIb
olF0hXu6saTVUPYjvp9jgsjXGjklI4mR3dE7jCkBekV8Fg3AGWzHCut5MlJqtw+Y
ekqeshZH88bMMhq9NAI/Q6Gnxp3PxA==
=I2HM
-----END PGP SIGNATURE-----

--xn57vvywhbh4vq4z--
