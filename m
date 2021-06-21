Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5519A3AF6BF
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 22:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhFUUUm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFUUUj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 16:20:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C555C061756
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 13:18:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lvQN9-0003l5-7z; Mon, 21 Jun 2021 22:18:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:eaae:20c7:f8b6:e250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B9592640B23;
        Mon, 21 Jun 2021 20:18:17 +0000 (UTC)
Date:   Mon, 21 Jun 2021 22:18:16 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Angelo Dureghello <angelo@kernel-space.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH v3 4/5] can: flexcan: update Kconfig to allow non-of cases
Message-ID: <20210621201816.pk6n4xa7j4bi6vfk@pengutronix.de>
References: <20210621184615.3345846-1-angelo@kernel-space.org>
 <20210621184615.3345846-4-angelo@kernel-space.org>
 <CAMuHMdV8a=YKowGLY3kGqwsfAPd3VPEXS8x7xqYaUz9ZBh64hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yj3vw6ph5tyfn4fj"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV8a=YKowGLY3kGqwsfAPd3VPEXS8x7xqYaUz9ZBh64hg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--yj3vw6ph5tyfn4fj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.06.2021 22:11:58, Geert Uytterhoeven wrote:
> On Mon, Jun 21, 2021 at 8:47 PM Angelo Dureghello
> <angelo@kernel-space.org> wrote:
> > Update flexcan to support architectures without fdt.
> >
> > Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> > ---
> > Changes for v2:
> > none
> > Changes for v3:
> > - change to just remove OF
> > ---
> >  drivers/net/can/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> > index e355d3974977..a0f4ae7ccb84 100644
> > --- a/drivers/net/can/Kconfig
> > +++ b/drivers/net/can/Kconfig
> > @@ -97,7 +97,7 @@ config CAN_AT91
> >
> >  config CAN_FLEXCAN
> >         tristate "Support for Freescale FLEXCAN based chips"
> > -       depends on OF && HAS_IOMEM
> > +       depends on HAS_IOMEM
>=20
> I think you want to add a line
>=20
>     depends on ARCH_LAYERSCAPE || ARCH_MXC || COLDFIRE ||
> FSL_SOC_BOOKE || COMPILE_TEST
>=20
> (or PPC instead of FSL_SOC_BOOKE?)
> so the question doesn't pop up when compiling a kernel for a system
> that cannot have a Freescale FlexCAN IP block.

Back in 2018 Pankaj Bansal replaced the "depends on ARM || PPC" by "OF
&& HAS_IOMEM", see:

| 0f8af56f74cd can: flexcan: enable flexcan for all architectures

So I think there won't be too many configs where the oldconfig question
would pop up.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--yj3vw6ph5tyfn4fj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDQ9AYACgkQqclaivrt
76nQOgf+OOCYGQMAUUMzrQBi4KDdGNryr2qRnX4cXNqmHq7fBN+gDyjEDBJwSDLH
AHUKUuT78Ttjj2KkcU3f7FnVdNjUXe56DNC3D8LKkuVR0nTwFvbPX6l/mmrOF59T
QwI/Tw4H0dXf41kVrsQW3KGCLCi641v5YBMvd7DDgPksk62+nQOEDqIGquEVIbev
1nGr6enW+oYgQnkKNrFB5tkeNhCRLSCV+s9wPdA46LZoLw08m3zK5E9hK5EzqNNf
gZWy5qQr3GFKfMPrikB0bcvdvnX1J9s+J5Q4zY/lT6pIjTW114aIDhLyOTciiJNN
US18VrRNbCQaAjHL7gAPucGQzO5iig==
=UzJN
-----END PGP SIGNATURE-----

--yj3vw6ph5tyfn4fj--
