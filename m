Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225912F95DB
	for <lists+linux-can@lfdr.de>; Sun, 17 Jan 2021 23:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbhAQWRp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Jan 2021 17:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbhAQWRo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Jan 2021 17:17:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27DBC061574
        for <linux-can@vger.kernel.org>; Sun, 17 Jan 2021 14:17:03 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l1GM1-0000Ij-T9; Sun, 17 Jan 2021 23:17:01 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:f1b3:765:9bfa:1947])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D66585C591C;
        Sun, 17 Jan 2021 22:16:59 +0000 (UTC)
Date:   Sun, 17 Jan 2021 23:16:58 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Subject: Re: [net-next 09/17] can: length: can_fd_len2dlc(): simplify length
 calculcation
Message-ID: <20210117221658.zvy6r7kmzfaq4osb@hardanger.blackshift.org>
References: <20210113211410.917108-1-mkl@pengutronix.de>
 <20210113211410.917108-10-mkl@pengutronix.de>
 <CAMZ6Rq+Wxn_kG7rSkUrMYMqNw790SMe-UKmpUVdEA_eGcjoT+g@mail.gmail.com>
 <2f3fff1a-9a50-030b-6a29-2009c8b65b68@hartkopp.net>
 <CAMZ6RqLKYnGDePueN1ftL9a47Qf-ZR7bc4eLGwzCkncsD6ok2Q@mail.gmail.com>
 <75d3c8e9-acbd-09e9-e185-94833dbfb391@hartkopp.net>
 <CAMZ6RqKZcuJH2DPeZjgqvL2MG+LoLScHTdd4s+K9OFYDUFT2ZQ@mail.gmail.com>
 <a79041a9-a211-bd3f-42b3-35919bd12470@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4q56gq73xjouadif"
Content-Disposition: inline
In-Reply-To: <a79041a9-a211-bd3f-42b3-35919bd12470@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4q56gq73xjouadif
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 01:38:12PM +0100, Oliver Hartkopp wrote:
> The problem is NOT that we make sure to access this array correctly.
>=20
> This particular array is no set of arbitrary values that may be extended
> later on BUT it is a 'translation map' for defined length values which wi=
ll
> never change.
>=20
> Therefore ARRAY_SIZE(array) hides the fact that every length value "great=
er
> than 48" results to a DLC of 15.
>=20
> For that reason my former code was very clear:
>=20
> 1. It had a table that mapped 0 .. 64 to a DLC
> 2. It had a test for '> 64' as sanity test.

I stole the idea of removing the last 16 bytes of the array from the padlen=
()
function in the ISOTP code.

> Now the sanity test is gone and mixed up with the mapping of length value=
s -
> and finally with ARRAY_SIZE(whatever) which doesn't give a hint why this =
is
> checked.

=2E..then I wrongly replaced the 48 with the ARRAY_SIZE().

> We are writing code to be understandable for the reader and the suggested
> 'improvement' which saves 16 bytes does exactly the opposite.
>=20
> For that reason the entire patch is broken.
>=20
> An improvement could be to rename
>=20
> 64 -> CANFD_MAX_LEN
> 0xF -> CANFD_MAX_DLC
>=20
> but nothing more.

What about this patch:

diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
index d35c4e82314d..f5509e48fe95 100644
--- a/drivers/net/can/dev/length.c
+++ b/drivers/net/can/dev/length.c
@@ -27,12 +27,14 @@ static const u8 len2dlc[] =3D {
        13, 13, 13, 13, 13, 13, 13, 13, /* 25 - 32 */
        14, 14, 14, 14, 14, 14, 14, 14, /* 33 - 40 */
        14, 14, 14, 14, 14, 14, 14, 14, /* 41 - 48 */
+       15, 15, 15, 15, 15, 15, 15, 15, /* 49 - 56 */
+       15, 15, 15, 15, 15, 15, 15, 15  /* 57 - 64 */
 };

 /* map the sanitized data length to an appropriate data length code */
 u8 can_fd_len2dlc(u8 len)
 {
-       if (len >=3D ARRAY_SIZE(len2dlc))
+       if (unlikely(len > CANFD_MAX_LEN))
                return CANFD_MAX_DLC;

        return len2dlc[len];

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4q56gq73xjouadif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAEt1cACgkQqclaivrt
76kw9Qf+PcOCV6gvyJtQTra41a6NFCHBG3tyDkXMaKAAPYT2xdgrBnxwxSw2Jy16
Sm3iRV7grtuxBuk7tRVM6FkGQI3Mm7B08O+bEVHE3GYgfx85nuPALWNv/B1oTs+L
l5kFb0oYJD0klqE4wNo/2pZ0d9NFcw8PzTe7LJ4MHKZGixq3R3+Ji8/auZjs+f0g
u99hpg2JGo6UjswctLh8MdbUBCIuh0cQh1CbfPlvisYKgxYNvA1glnorxoRrGx4t
gBXdhI+BGSstYcB8ZYQhu4/IS5U1yZhGQKao1DudXUX6dhET6L0RP5wtQvpSiMJE
xl8d/soSYqUnHjIsgi4sSQ8Lg5QeXg==
=UWDU
-----END PGP SIGNATURE-----

--4q56gq73xjouadif--
