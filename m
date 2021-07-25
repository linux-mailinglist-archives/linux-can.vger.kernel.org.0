Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D03D4EB7
	for <lists+linux-can@lfdr.de>; Sun, 25 Jul 2021 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGYPq4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Jul 2021 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYPq4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Jul 2021 11:46:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BBBC061757
        for <linux-can@vger.kernel.org>; Sun, 25 Jul 2021 09:27:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7gyI-0007HF-CY; Sun, 25 Jul 2021 18:27:22 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4c93:5280:877:c958])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 27E0365768F;
        Sun, 25 Jul 2021 16:27:21 +0000 (UTC)
Date:   Sun, 25 Jul 2021 18:27:20 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, linux-can@vger.kernel.org,
        Yasushi SHOJI <yashi@spacecubics.com>
Subject: Re: [PATCH] can: mcba_usb: fix memory leak in mcba_usb
Message-ID: <20210725162720.74fu6qny6dqdc625@pengutronix.de>
References: <CAELBRW+6BGDPaUGrTDJtv020zF1AvtBAy2Jb1+i=uDbcH+0SzA@mail.gmail.com>
 <20210725111242.2d9a819f@gmail.com>
 <CAELBRWJQ+QN6+D0M-61Fz818fm7Q-pP4LW=-KUe+nsyFFSXXPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u42gg3ogmnrxc3tv"
Content-Disposition: inline
In-Reply-To: <CAELBRWJQ+QN6+D0M-61Fz818fm7Q-pP4LW=-KUe+nsyFFSXXPg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--u42gg3ogmnrxc3tv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.07.2021 19:44:43, Yasushi SHOJI wrote:
> Hi Pavel,
>=20
> On Sun, Jul 25, 2021 at 5:12 PM Pavel Skripkin <paskripkin@gmail.com> wro=
te:
> > Can You try the following patch?
> >
> > diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_=
usb.c
> > index a45865bd7254..a1a154c08b7f 100644
> > --- a/drivers/net/can/usb/mcba_usb.c
> > +++ b/drivers/net/can/usb/mcba_usb.c
> > @@ -653,6 +653,8 @@ static int mcba_usb_start(struct mcba_priv *priv)
> >                         break;
> >                 }
> >
> > +               urb->transfer_dma =3D buf_dma;
> > +
> >                 usb_fill_bulk_urb(urb, priv->udev,
> >                                   usb_rcvbulkpipe(priv->udev, MCBA_USB_=
EP_IN),
> >                                   buf, MCBA_USB_RX_BUFF_SIZE,
>=20
> Yup, this patch fixed it.  I've tested on top of v5.10.52.
>=20
> Tested-by: Yasushi SHOJI <yashi@spacecubics.com>
>=20
> > I am sorry for breaking your device :(
>=20
> No problem.  It'd be nice if we'd test with real hardware before
> merging into the stable tree, though.

Yes absolutely - but I don't have access to that hardware. Since you're
interested in that hardware, what about adding you as a reviewer to the
kernel. Then for every change on this driver, you'll be added on Cc and
can test it. What do you think?

> Anyway, thank you for your quick fix!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--u42gg3ogmnrxc3tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD9kOQACgkQqclaivrt
76mnmQgAmHC6bsFIfcr2rzQXi7jP0BwY66roY0VCQwVUbdpV6linahkScwcflI+n
4c0BF9P6lDqSTGROMNRbAUMObIfCTB5yo6IgJNOtQm3Edml5cBoY849j3ONPV5UZ
GLbZWsrAHIIse5VzuAJAsZfMiqK4CR+wEwBpbYf8n+sRSPTuHPl7B5Efvws2fv9Z
ZZrCHeG4obUmwws1ge/ET8dHVwtauV0h32ffDk3AfVhKA3+p3Rq+BjcrPxd5O90m
Eu0xnKu8FiyZJbKC6SnxYVFaK7ZwV/Es1c7B3/moWfcm71GsmOHObOIywr0cVEyn
EmIx7rxSAClM+QUn6nEpsysfqs607w==
=IxFW
-----END PGP SIGNATURE-----

--u42gg3ogmnrxc3tv--
