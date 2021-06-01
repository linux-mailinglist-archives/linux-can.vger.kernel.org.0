Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695E1397166
	for <lists+linux-can@lfdr.de>; Tue,  1 Jun 2021 12:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhFAK1V (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Jun 2021 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhFAK1T (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Jun 2021 06:27:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EE5C061574
        for <linux-can@vger.kernel.org>; Tue,  1 Jun 2021 03:25:37 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lo1aa-0002Sm-Ed; Tue, 01 Jun 2021 12:25:36 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f875:cb52:3051:44e8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8F81063087A;
        Tue,  1 Jun 2021 10:25:35 +0000 (UTC)
Date:   Tue, 1 Jun 2021 12:25:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 2/5] can: m_can: m_can_isr(): handle
 device-specific interrupts
Message-ID: <20210601102534.ocbktq2jj4g564q4@pengutronix.de>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526124747.674055-3-torin@maxiluxsystems.com>
 <20210526150705.s4ms7jhowsuts3yf@pengutronix.de>
 <20210526151833.5ppprex6zzrclr6u@pengutronix.de>
 <20210601082338.b7t67oebywhcwcnd@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4sjdsiy7f5zrxein"
Content-Disposition: inline
In-Reply-To: <20210601082338.b7t67oebywhcwcnd@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4sjdsiy7f5zrxein
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.06.2021 09:23:38, Torin Cooper-Bennun wrote:
> On Wed, May 26, 2021 at 05:18:33PM +0200, Marc Kleine-Budde wrote:
> > On 26.05.2021 17:07:05, Marc Kleine-Budde wrote:
> > > On 26.05.2021 13:47:44, Torin Cooper-Bennun wrote:
> > > > +	if (!ir) {
> > > > +		/* Handle device-specific interrupts */
> > > > +		if (cdev->ops->handle_dev_interrupts)
> > > > +			irq_ret =3D cdev->ops->handle_dev_interrupts(cdev, false);
> > > > +		return irq_ret;
> > > > +	}
> > > > +
> > > > +	/* ACK M_CAN interrupts */
> > > > +	m_can_write(cdev, M_CAN_IR, ir);
> > > > =20
> > > > +	/* ACK device-specific interrupts */
> > > >  	if (cdev->ops->handle_dev_interrupts)
> > > >  		cdev->ops->handle_dev_interrupts(cdev, true);
> > >=20
> > > Why do you call a 2nd time the handle_dev_interrupts() callback?
> >=20
> > I see, clear and no clear. Why are these two separate operations?
>=20
> As discussed here,
>=20
> https://lore.kernel.org/linux-can/20210514141012.3ehw4tosog3lreq4@pengutr=
onix.de/
>=20
> you previously recommended adding a 2nd parameter the callback to
> indicate that we only want to clear the device IR, not read it, in order
> to save an SPI transaction when M_CAN core interrupts were already
> handled.

ACK.

I had in mind a single call to handle_dev_interrupts().

In tcan4x5x_clear_interrupts() the original code does 4 individual reg
writes. With:

| tcan4x5x: tcan4x5x_clear_interrupts(): rm unnecessary reg clears

two of them are removed \o/. In Linux we want to avoid individual SPI
transfers at all cost, as they are quite expensive. So the SPI accesses
should be optimized for the no error use case.

If the tcan4x5x interrupts only need clearing/handling in the error
case, it might be an option to only call handle_dev_interrupts() if the
M_CAN_IR register shows no interrupts.

If both m-can and tcan interrupts are pending, in the first run only the
m-can IRQs are handled. If the IRQ line is still asserted the Linux IRQ
code should call the ISR again, no m-can IRQ, then the tcan IRQs will be
handled.

> However, quoting from your previous mail,
>=20
> > On 26.05.2021 13:47:44, Torin Cooper-Bennun wrote:
> > > Device-specific interrupts are handled, if no M_CAN core interrupts w=
ere
> > > handled in the ISR call.
> >=20
> > In case there are both core and device specific interrupts the kernel
> > IRQ handler will call the ISR a 2nd time - should be OK.
>=20
> this implies I should leave device IR totally alone unless no M_CAN
> interrupts are asserted, and do the following only:

ACK

> |	ir =3D m_can_read(cdev, M_CAN_IR);
> |
> |	if (!ir) {
> |		/* Handle device-specific interrupts */
> |		if (cdev->ops->handle_dev_interrupts)
> |			irq_ret =3D cdev->ops->handle_dev_interrupts(cdev, false);

ACK - and the handle_dev_interrupts handler should do all necessary
things :)

> |		return irq_ret;
> |	}
> |
> |	/* ACK M_CAN interrupts */
> |	m_can_write(cdev, M_CAN_IR, ir);
>=20
> I can probably also kill off the clear_only parameter.

If the tcan only needs handling/clearing in the error case, then there's
no need for a 2nd parameter.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4sjdsiy7f5zrxein
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmC2CxwACgkQqclaivrt
76l0Wwf+LojOA7Gq1QDFJdjKkCchMlzW106JaFc0OaDvBAXcjJHt1zLGuS3nt18C
f073GoH73KwHfLQplnSX9nLAInWBYiHTfxw5W28ykCJHZJlPqy1HHaAaREk/lwPD
BgcSNv1UAVksaD+x1UyP++CzEz5YBgM+bsz3Wl/KSYZXrofbvPDGRfaArIT1VWwX
wNQBRF1f75sf31z00eaN3k90nQKDGy6POY2ZXh0Me4YHn5cXsS8/9LWKfvx6Fkg2
7k7uARGvAYxVs/jF1lO5CXb91RjqL5+3y42/+GgaP7j3/BOrDIRA4RpelYYpqCA6
49ig0TPXK0p2eDXW3pTj/6BIaVEFyA==
=t0ke
-----END PGP SIGNATURE-----

--4sjdsiy7f5zrxein--
