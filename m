Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64A13AB2E4
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 13:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFQLr3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbhFQLr2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 07:47:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36686C061574
        for <linux-can@vger.kernel.org>; Thu, 17 Jun 2021 04:45:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltqSS-0005IA-3S; Thu, 17 Jun 2021 13:45:16 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:653d:6f2f:e25e:5f2e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 99EEE63E05C;
        Thu, 17 Jun 2021 11:45:14 +0000 (UTC)
Date:   Thu, 17 Jun 2021 13:45:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>, wg@grandegger.com,
        geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 1/5] can: flexcan: add platform data for ColdFire
Message-ID: <20210617114513.5ykfud2ovxeosviv@pengutronix.de>
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <3f74ce4f-b4c5-d622-7cba-b4ce070fd967@linux-m68k.org>
 <93a5c017-a538-af84-fe7d-a152dec0bd07@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cip6z7u65556fn5l"
Content-Disposition: inline
In-Reply-To: <93a5c017-a538-af84-fe7d-a152dec0bd07@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--cip6z7u65556fn5l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.06.2021 09:23:13, Angelo Dureghello wrote:
> > Is this actually specific to the ColdFire M5411x SoC?
> > I thought a number of other ColdFire parts also have canbus support.
> > Are they not all the same underlying hardware block?
> >=20
> > So should this be more generic, say flexcan.h or mcf_flexcan.h or
> > something like that?
>=20
>=20
> yes, the file can be reused for all mcf, they have similar
> hardware blocks (flexcan) but with small differences, like i.e.
> number of buffers, so the define guards are named generic (MCF),
> with specific defines as needed,

If there are other flexcan IP cores with small differences compared to
this one, you better give this IP core a popper name. See Patch 3:

| +static struct platform_device mcf_flexcan0 =3D {=20
| +	.name =3D "flexcan-mcf",

what about naming it "flexcan-mcf5441x"? Or is this too specific? As
this is not a DT compatible we can change this later if needed.

| +	.id =3D 0,=20
| +	.num_resources =3D ARRAY_SIZE(mcf_flexcan0_resource),=20
| +	.resource =3D mcf_flexcan0_resource,=20
| +	.dev.platform_data =3D &mcf_flexcan_info,=20
| +};=20

> Will rename it to mcf_flexcan.h.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--cip6z7u65556fn5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDLNccACgkQqclaivrt
76nWwgf+KXnCL+1EYQYoLfJ+jl9JlmC9AcK8dObOHOiyp67aa410y2hsHPxyoFwb
oZIEAh990OdVGJmzO4AkYBNaGQ4X033+KZDlcBazssu3IYYW1DhGgPN/+uf1le04
aLD7y+jySBmrdbqVy+OxLLmv6Qj2LshInA/JzAwfNnvLXWyhfoyJw6c1f4Yy7jZy
6DkulnyzR4KSnEJ9gnEQxbXtiQurTbCNNGiFgKa+UuQsZ6kDg3n0s9rPAGbcerov
a4I1e4XSneTFZ78vK2Gh7IBr6/fPWHm3XAKKgdzsY+ryXrg0C8j6eYx+BMn3+yeQ
bp9Z3SRCPapBsH3ztusryLjNNq+8tA==
=7ei/
-----END PGP SIGNATURE-----

--cip6z7u65556fn5l--
