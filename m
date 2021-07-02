Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD453B9E8F
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 11:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhGBJ6d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGBJ6c (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 05:58:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F132DC061762
        for <linux-can@vger.kernel.org>; Fri,  2 Jul 2021 02:56:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lzFtt-0002SF-KH; Fri, 02 Jul 2021 11:55:57 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fe13:c2b2:7939:752b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 935CC6477C7;
        Fri,  2 Jul 2021 09:55:56 +0000 (UTC)
Date:   Fri, 2 Jul 2021 11:55:56 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v4 1/5] can: flexcan: add platform data header
Message-ID: <20210702095556.zq2edwmblexswbaz@pengutronix.de>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210701092738.iw4l4vekpvn2c4an@pengutronix.de>
 <eca22abd-7aff-5113-3cc7-a8abf10062e1@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ckp7k3nhniuhd7ek"
Content-Disposition: inline
In-Reply-To: <eca22abd-7aff-5113-3cc7-a8abf10062e1@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ckp7k3nhniuhd7ek
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.07.2021 11:21:40, Angelo Dureghello wrote:
> Hi Marc,
>=20
> On 01/07/21 11:27 AM, Marc Kleine-Budde wrote:
> > On 01.07.2021 01:00:12, Angelo Dureghello wrote:
> > > Add platform data header for flexcan.
> >=20
> > BTW: the DKIM signatures on your mails are invalid:
> >=20
> > |   =E2=9C=97 [PATCH v4 1/5] can: flexcan: add platform data header
> > |     + Link: https://lore.kernel.org/r/20210630230016.4099050-1-angelo=
@kernel-space.org
> > |     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > |   =E2=9C=97 [PATCH v4 4/5] can: flexcan: update Kconfig to enable col=
dfire
> > |     + Link: https://lore.kernel.org/r/20210630230016.4099050-4-angelo=
@kernel-space.org
> > |     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > |   =E2=9C=97 [PATCH v4 5/5] can: flexcan: add mcf5441x support
> > |     + Link: https://lore.kernel.org/r/20210630230016.4099050-5-angelo=
@kernel-space.org
> > |     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > |   ---
> > |   Attestation is available, but did not succeed:
> > |     =E2=9C=97 Failed DKIM/kernel-space.org attestation
> >=20
>=20
> thanks for catching this, fixed, now dkim tests are passing.

It still fails with the new series:

|   =E2=9C=97 [PATCH v5 1/5] can: flexcan: add platform data header
|     + Link: https://lore.kernel.org/r/20210702094841.327679-1-angelo@kern=
el-space.org
|     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|   =E2=9C=97 [PATCH v5 4/5] can: flexcan: update Kconfig to enable coldfire
|     + Link: https://lore.kernel.org/r/20210702094841.327679-4-angelo@kern=
el-space.org
|     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|   =E2=9C=97 [PATCH v5 5/5] can: flexcan: add mcf5441x support
|     + Link: https://lore.kernel.org/r/20210702094841.327679-5-angelo@kern=
el-space.org
|     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|   ---
|   Attestation is available, but did not succeed:
|     =E2=9C=97 Failed DKIM/kernel-space.org attestation

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ckp7k3nhniuhd7ek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDe4qkACgkQqclaivrt
76kXoAgAslx7ksLJgiBOODhU6wgNEbard0r7bCyt8lXF6LM/ZIuscpBNQ0C3n2WL
6IXkhIvHdt9s0fnER1o6CCB7ddjI34U39hJ6AC76wD4sPhi5hSvrHb+ySSJpvH1Y
LQsFn3RaM13sLf6/akw/dD0lmcnmiu+OmLcZId9HVAK1S5xr2GlikXkuBGYfe8vz
fQe4UCv7W3DLqtbGQB4kaV6LG+wFadiLCR0H+A3LuM0KoFqPwG1LVs/rANo0kIrp
86cOUsT7CeRosEhu2S6Z4D25i6thakGwt3BynbA0fklRyoTE8JNJdwmGk88BAtgB
rbfrqV09wNr+Ac0bc6cijE2wAHki+w==
=lKxZ
-----END PGP SIGNATURE-----

--ckp7k3nhniuhd7ek--
