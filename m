Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9753B2C95
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 12:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhFXKm6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 06:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhFXKm6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 06:42:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B6C061574
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 03:40:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwMmk-0008Mw-56
        for linux-can@vger.kernel.org; Thu, 24 Jun 2021 12:40:38 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:47f5:be86:773e:3d3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6D8CC642AB7
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 10:40:37 +0000 (UTC)
Date:   Thu, 24 Jun 2021 12:40:36 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Subject: Re: [PATCH 1/3] can-calc-bittiming: add stm32 bxcan
Message-ID: <20210624104036.2n46qq3rzhw3y6pc@pengutronix.de>
References: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
 <20210624062016.tabvejebommpqcuj@pengutronix.de>
 <20210624103736.GB20770@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ekvatjq6xs47zuzm"
Content-Disposition: inline
In-Reply-To: <20210624103736.GB20770@x1.vandijck-laurijssen.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ekvatjq6xs47zuzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.06.2021 12:37:36, Kurt Van Dijck wrote:
> On Thu, 24 Jun 2021 08:20:16 +0200, Marc Kleine-Budde wrote:
> > On 24.06.2021 05:19:52, Kurt Van Dijck wrote:
> > > Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > > ---
> > >  can-calc-bit-timing.c | 32 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > >=20
> > > diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
> > > index d99bd22..fb61947 100644
> > > --- a/can-calc-bit-timing.c
> > > +++ b/can-calc-bit-timing.c
> > > @@ -273,6 +273,22 @@ static void printf_btr_rcar_can(struct can_bitti=
ming *bt, bool hdr)
> > >  	}
> > >  }
> > > =20
> > > +		.bittiming_const =3D {
> > > +			.name =3D "bxcan",
> >=20
> > What's that? A new CAN-IP  core?
>=20
> It's the 'old' CAN core used in STM32 cortex-m mcu's.

Ahh - and it says stm32 in the subject of this mail :D

> > I can apply these patches to the can-utils or you can create a github
> > pull request and I'll merge it there. What do you prefer?
>=20
> my preference is to apply from email.

Fine with me.

> The dinosaur icon on my github account comes with a reason?

You like dinos? Don't know how fluent your german is:
https://www.dinowitz.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ekvatjq6xs47zuzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDUYSIACgkQqclaivrt
76nSkQf9GJQR7PmCflHlQ0FPpgCpZC9MJsG5rhmOgyZkoijfCGeedhjZc4c/YdmQ
q6CBI/Pe9zLGvW2ipGnsrQubuwBzwOdlculsktFAFTl6UrARWM8+1msE5y/3LJ0Y
w5Xo4clR9kFyT8MyFGtYEhlXosCNxPOW+YljQa1cdRURGeIIGAYEZOnZeOwPyQ8d
vcOicT37mRxqJpvUEeyG11i6jjRr4tXPAr93MpokrFmOu3ZJ1oIfd4lYbPJL5D3i
zbN33Ag7P7U5Qi04uFd9Izd3NSWTYQpigaVGtNtpLfpbRX9Ku2GwYdCu++sxM3aK
FsbZI4YwGDYOzMCUT5Dch2u2nJq1lA==
=LBNh
-----END PGP SIGNATURE-----

--ekvatjq6xs47zuzm--
