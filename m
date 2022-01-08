Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9F4885B5
	for <lists+linux-can@lfdr.de>; Sat,  8 Jan 2022 20:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiAHTv4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 8 Jan 2022 14:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiAHTv4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Jan 2022 14:51:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E6BC06173F
        for <linux-can@vger.kernel.org>; Sat,  8 Jan 2022 11:51:55 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n6Hkl-0002oh-UT; Sat, 08 Jan 2022 20:51:51 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-6624-65e0-1d16-9a67.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6624:65e0:1d16:9a67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 578946D39A3;
        Sat,  8 Jan 2022 19:51:49 +0000 (UTC)
Date:   Sat, 8 Jan 2022 20:51:48 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v3 7/7] docs: networking: device drivers: can: add flexcan
Message-ID: <20220108195148.auem62moegm5rnn7@pengutronix.de>
References: <20220107193105.1699523-1-mkl@pengutronix.de>
 <20220107193105.1699523-8-mkl@pengutronix.de>
 <CABGWkvpKLc13vSDUDquSZeR+2t9tEenAduxtWeyLK4xpRdKKig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eev4pt67pr4g6247"
Content-Disposition: inline
In-Reply-To: <CABGWkvpKLc13vSDUDquSZeR+2t9tEenAduxtWeyLK4xpRdKKig@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--eev4pt67pr4g6247
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.01.2022 14:12:27, Dario Binacchi wrote:
> > +On/off RTR frames reception
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +For most flexcan IP cores the driver supports 2 RX modes:
> > +
> > +- FIFO
> > +- mailbox
> > +
> > +The older flexcan cores (integrated into the i.MX25, i.MX28, i.MX35
> > +and i.MX53 SOCs) only reception of RTR frames if the controller is
> > +configured for RX-FIFO mode.
>=20
> only receive RTR frames
>=20
> > +
> > +The RX FIFO mode uses a hardware FIFO with a depth of 6 CAN frames,
> > +while the mailbox mode uses a software FIFO with a depth of up to 62
> > +CAN frames. With the help of the bigger buffer, the mailbox mode
> > +performs better under high system load situations.
> > +
> > +As reception of RTR frames is part of the CAN standard, all flexcan
> > +core come up in a mode where RTR reception is possible.
>=20
> all flexcan cores

Fixed both.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--eev4pt67pr4g6247
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHZ61EACgkQqclaivrt
76loXwgAk5sA69UM4KWOXN64fa4uwlAuoI8LhJXjl5uSOtKUIzkQo/jIxcibF+cX
97c99Y1CNXYmoF7gxpwCFsr+nreRcUZdOHWZyYlmfktg9I+kIYd9pdGgLUtayXin
8yMlYVaQTkvcN2Uz8bfLTTJVuW15xL4PIVEWsXavyMEzgYtSGuOHTKSD0XkeZnRm
qwaL5OMLYlHA9ieZS2D8QZ9+Gnd/U1rfq7PVBGkuTcqSPngGfqylSjqHRmMJ3JCx
BWV9yT4vzuofWJGgwyyOoDpbaxhnEki+SPsrJOMg4l7XbA4qBksdpYxRvXOCD4ZO
XA+F8p84xAbvi42GwrnXxkPBExhtog==
=HBiE
-----END PGP SIGNATURE-----

--eev4pt67pr4g6247--
