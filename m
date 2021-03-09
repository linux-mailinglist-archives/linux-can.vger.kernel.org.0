Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA23325B2
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 13:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCIMrw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 07:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCIMrw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 07:47:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C2AC06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 04:47:52 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJbmA-00009O-RG; Tue, 09 Mar 2021 13:47:50 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 01B9A5F17EE;
        Tue,  9 Mar 2021 12:47:49 +0000 (UTC)
Date:   Tue, 9 Mar 2021 13:47:49 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v6 0/12] can: c_can: add support to 64 message objects
Message-ID: <20210309124749.gy2gm6pls47psnc6@pengutronix.de>
References: <20210305130211.2860914-1-mkl@pengutronix.de>
 <1739785095.246292.1615293691102@mail1.libero.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ezkoxiol43nor5dy"
Content-Disposition: inline
In-Reply-To: <1739785095.246292.1615293691102@mail1.libero.it>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ezkoxiol43nor5dy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 13:41:31, Dario Binacchi wrote:
> Before applying the series:
>=20
>  bitrate       time         ca         cb
>   125000    6m 45.22s    1000000        0
>   250000    3m 25.94s    1000000        0
>   500000    1m 45.62s    1000000        0
>  1000000    1m  9.28s    1000000        0
>=20
> After applying the series:
>=20
>  bitrate       time         ca         cb
>   125000    6m 42.71s    1000000        0
>   250000    3m 23.28s    1000000        0
>   500000    1m 44.04s    1000000        0
>  1000000    1m  8.44s    1000000        0

It even got marginally faster. \o/

Thanks for testing,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ezkoxiol43nor5dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHbnIACgkQqclaivrt
76kPoQgAsPh5syGeFURHZLvGxfkKfJ00b3rN84qyRsy0rDcWCQcPQNlECvNiMTwj
vOF3lIo6KVovqQEIYErX+6ORQIFJxuBEUZoWEaFpD0SclknqldZn6pVvvYM4vVyR
8AJeDW2sxBpIQZeaHOgYCz/oCSt85paGl4AKp2L6T7VSWv8bT7VvKaq7A/HzqNTX
4ToArveVytPGBCKjcqW+TofKJ36bmzgmxesvx+O7/plLv/kMs68F4WZ8TrAXPQhD
QN0AqP3O+iGs37Y4uz7Yg6TNfuUfb4Nl9dqLZB9O1lxNzR2tG48kgjfYx536RhGY
vOiuAh2QVtg7gjPB2KwghMwbVgus9g==
=75vi
-----END PGP SIGNATURE-----

--ezkoxiol43nor5dy--
