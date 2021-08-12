Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109513EA5CD
	for <lists+linux-can@lfdr.de>; Thu, 12 Aug 2021 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhHLNjm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Aug 2021 09:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhHLNjl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Aug 2021 09:39:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A361C061756
        for <linux-can@vger.kernel.org>; Thu, 12 Aug 2021 06:39:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mEAvS-0002HD-BW; Thu, 12 Aug 2021 15:39:14 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:3ed7:427:d9dd:eb1b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0BE4666612F;
        Thu, 12 Aug 2021 13:39:12 +0000 (UTC)
Date:   Thu, 12 Aug 2021 15:39:11 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?TcOkdGpl?= <Stefan.Maetje@esd.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] mailmap: update email address of Matthias Fuchs
Message-ID: <20210812133911.ewv2ge474gdxuuwf@pengutronix.de>
References: <20210806104833.102081-1-mkl@pengutronix.de>
 <10024d316c23d7be2ce6037f7994aa2af033208f.camel@esd.eu>
 <20210809072414.syapcl2v7urytygg@pengutronix.de>
 <1b5875759dc9d68f2379cde389b1bf5595ee3964.camel@esd.eu>
 <20210809175158.5xdkqeemjo3hqwcw@pengutronix.de>
 <10975691377830c5fa647918b07fd8c5adf7483b.camel@esd.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2rjljajh7h5zjash"
Content-Disposition: inline
In-Reply-To: <10975691377830c5fa647918b07fd8c5adf7483b.camel@esd.eu>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2rjljajh7h5zjash
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.08.2021 13:27:57, Stefan M=C3=A4tje wrote:
> Am Montag, den 09.08.2021, 19:51 +0200 schrieb Marc Kleine-Budde:
> > On 09.08.2021 17:22:51, Stefan M=C3=A4tje wrote:
> > > > Speaking of that patch. Can you please create an entry in the
> > > > MAINTAINERS file, too? I suggest to add yourself as M: and the
> > > > socketcan@e.u as R:. The change in the MAINTAINERS file will be a s=
econd
> > > > patch in that series. Just include it the next iteration of that se=
ries.
> > >=20
> > > Do you think of something like the patch below?
> >=20
> > ACK
> :
> > > =20
> > > +CAN NETWORK DRIVERS ESD HARDWARE
> >=20
> > This usually starts with the company's name or the driver name, so
> > something like "ESD PCIe/402 CAN DRIVER" and a separate entry for the
> > USB driver or "ESD CAN NETWORK DRIVERS" if you want to have a single
> > entry.
>=20
> Following the requirement to start with the company's name I'll include t=
his
> patch for MAINTAINERS:

not a requirement, but usually done :)

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41fcfdb24a81..8ad40b5d082e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6900,6 +6900,14 @@ S:       Maintained
>  F:     include/linux/errseq.h
>  F:     lib/errseq.c
> =20
> +ESD CAN NETWORK DRIVERS
> +M:     Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> +R:     socketcan@esd.eu
> +L:     linux-can@vger.kernel.org
> +S:     Maintained
> +F:     drivers/net/can/esd/
> +F:     drivers/net/can/usb/esd_usb2.c
> +
>  ET131X NETWORK DRIVER
>  M:     Mark Einon <mark.einon@gmail.com>
>  S:     Odd Fixes
>=20

Fine! Adding this to the MAINTAINERS should be a separate patch in the seri=
es.

> > > > > and his email address shows up in MODULE_AUTHOR() macro. He also =
left
> > > > > our company already.
> > > >=20
> > > > In newly added changes, it makes sense that all email addresses are
> > > > working. :D
> > >=20
> > > So I'll remove his stale email address together with the
> > > MODULE_AUTHOR() macro and file the authorship credits in a changed
> > > copyright history at the top of the source files.
> >=20
> > Yes, his name but with the socketcan@e.u email in MODULE_AUTHOR().
> > Regarding the top of the file's copyright information, the last patch
> > only mentions 2 iterations of "esd" but no "real" people nor email
> > addresses. I don't know what's you company's policy for the copyright
> > line is, I don't mind adding Thomas, but use the socketcan@e.u email.
> > People tend to look at the source file in case of problems, so better
> > have working addresses there.
> >=20
>=20
> For the MODULE_AUTHOR() stuff and the copyright notices I will change it
> like this:

Looks good! Squash into the patch where the file is added.

> diff --git a/drivers/net/can/esd/esd_402_pci-core.c
> b/drivers/net/can/esd/esd_402_pci-core.c
> index 191e7f45c5d9..50d9c1dd1197 100644
> --- a/drivers/net/can/esd/esd_402_pci-core.c
> +++ b/drivers/net/can/esd/esd_402_pci-core.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (C) 2015 - 2017 esd electronic system design gmbh
> - * Copyright (C) 2017 - 2021 esd electronics gmbh
> +/* Copyright (C) 2015 - 2016 Thomas K=C3=B6rper, esd electronic system d=
esign gmbh
> + * Copyright (C) 2017 - 2021 Stefan M=C3=A4tje, esd electronics gmbh
>   */
> =20
>  #include <linux/kernel.h>
> @@ -524,7 +524,7 @@ static struct pci_driver pci402_driver =3D {
> =20
>  module_pci_driver(pci402_driver);
> =20
> -MODULE_DESCRIPTION("Socket-CAN driver for esd CAN PCI(e)/402 cards");
> -MODULE_AUTHOR("Thomas K=C3=B6rper <thomas.koerper@esd.eu>");
> +MODULE_DESCRIPTION("Socket-CAN driver for esd CAN 402 card family with e=
sdACC
> core on PCIe");
> +MODULE_AUTHOR("Thomas K=C3=B6rper <socketcan@esd.eu>");
>  MODULE_AUTHOR("Stefan M=C3=A4tje <stefan.maetje@esd.eu>");
>  MODULE_LICENSE("GPL");
>=20
>=20
> > Regarding the Co-Developed and Signed-off-by: Thomas posted the patches
> > back in 2015 with his email address, so use it for the Co-Developed and
> > Signed-off-by in your patch, too. This seems (or is) a bit inconsistent,
> > but the S-o-b's should record the history of the patch.
>=20
> I'll add this in the next iteration of my driver patch as recommended.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2rjljajh7h5zjash
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEVJH0ACgkQqclaivrt
76lSegf9Ens8RcDI8okXriDTS0i6hstbd6OhXK96shOZbh9FycRNfaEo8PDNhrl7
v9izrcBIupR3ua/LhCjEb8Ow3nC9nI+FTdmBD4ikjIVw5A1G8ZuSmwUT+spwWmQd
q4l55fk2LlGw2l2ofCFxvvtS2//69CY2n4PyKT+wIpIbv4XX8PF/nvuYTQ3nMp2w
5KR1J+HFCRYE6alcqXkPe7uqUeFAqlJDW9eZNf6r1MT3AwH8hhF7vszDh17jouuL
bzdBDMFIf2Xbj6XfJ0VRAnjM1ai26j4rD+66pMesjOBlz9iaApsSDhAJ8l8oKGqZ
w9ghL+i1zh5p6+G7mNhtI2UtzX5LQw==
=F8Uo
-----END PGP SIGNATURE-----

--2rjljajh7h5zjash--
