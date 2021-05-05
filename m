Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E023738C9
	for <lists+linux-can@lfdr.de>; Wed,  5 May 2021 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhEEKql (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 May 2021 06:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhEEKql (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 May 2021 06:46:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C62C061574
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 03:45:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1leF2B-0002VO-Ou; Wed, 05 May 2021 12:45:39 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:96db:da04:b018:e517])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B82C561D179;
        Wed,  5 May 2021 10:45:37 +0000 (UTC)
Date:   Wed, 5 May 2021 12:45:36 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de,
        kernel test robot <lkp@intel.com>
Subject: Re: [can-nextc 1/2] can: mcp251x: mcp251x_can_probe(): silence clang
 warning
Message-ID: <20210505104536.d6fli5gaqu4tssox@pengutronix.de>
References: <20210504200520.1179635-1-mkl@pengutronix.de>
 <20210504200520.1179635-2-mkl@pengutronix.de>
 <YJJv1f95WfTeJXCZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mnci6om3dwo7lj4m"
Content-Disposition: inline
In-Reply-To: <YJJv1f95WfTeJXCZ@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--mnci6om3dwo7lj4m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.05.2021 13:13:41, Andy Shevchenko wrote:
> On Tue, May 04, 2021 at 10:05:19PM +0200, Marc Kleine-Budde wrote:
> > This patch silences the following clang warning:
> >=20
> > | drivers/net/can/spi/mcp251x.c:1333:17: warning: cast to smaller integ=
er type
> > | 'enum mcp251x_model' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> > |                 priv->model =3D (enum mcp251x_model)match;
> > |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
> >=20
> > Fixes: 8de29a5c34a5 ("can: mcp251x: Make use of device property API")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/net/can/spi/mcp251x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251=
x.c
> > index 492f1bcb0516..275b2ddab143 100644
> > --- a/drivers/net/can/spi/mcp251x.c
> > +++ b/drivers/net/can/spi/mcp251x.c
> > @@ -1343,7 +1343,7 @@ static int mcp251x_can_probe(struct spi_device *s=
pi)
> >  	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
> >  		CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_LISTENONLY;
> >  	if (match)
> > -		priv->model =3D (enum mcp251x_model)match;
> > +		priv->model =3D (enum mcp251x_model)(kernel_ulong_t)match;
>=20
> Usually we use uintptr_t, but either way

I've updated the patch to uintptr_t.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--mnci6om3dwo7lj4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCSd04ACgkQqclaivrt
76mEAAgAkZtIMRBXOLPpfRTja5vjMfYNxIxtmb1ng+NyDTYJYP91ysP0U+/UPr/S
amnocGTVQFDeR4/MNZWlmFKnmr3yxDxzoM0pTpBNXtbTeVYy67yjSuZJC0ALtziP
gl4IwSScQc2RkT5UlH4c40nfYc1E9SEGU2g+l2aOuumiWP7u2yn7+42pvG12U1xx
ER9VJ2LnZakrnWJwUz4rpZnQWp0mKuUyIs8VwaXdYGNfNLOpF6nPAwfxTITIHrhn
XdhqV3CcWc3cQ3+wvmMjXQ9v1tXa8FRBr9DDGE7DRlnhzpOZHi8TF9U2ys4qKTAG
URslY6dRXZXfgOBfDII3UK9vZTMZsw==
=ShUU
-----END PGP SIGNATURE-----

--mnci6om3dwo7lj4m--
