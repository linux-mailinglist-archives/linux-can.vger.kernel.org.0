Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48AA396EBF
	for <lists+linux-can@lfdr.de>; Tue,  1 Jun 2021 10:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhFAIVd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Jun 2021 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbhFAIV3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Jun 2021 04:21:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB61C06175F
        for <linux-can@vger.kernel.org>; Tue,  1 Jun 2021 01:19:48 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lnzcl-0001u1-Oe; Tue, 01 Jun 2021 10:19:43 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f875:cb52:3051:44e8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C76826306A7;
        Tue,  1 Jun 2021 08:19:42 +0000 (UTC)
Date:   Tue, 1 Jun 2021 10:19:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 5/5] can: tcan4x5x: implement handling of device
 interrupts
Message-ID: <20210601081942.pqzgtmkygwg2vpit@pengutronix.de>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526124747.674055-6-torin@maxiluxsystems.com>
 <20210526151559.sfmseqqxzatlboay@pengutronix.de>
 <20210601075028.hubzfkhkfdcxtlq5@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yergradsnencucsl"
Content-Disposition: inline
In-Reply-To: <20210601075028.hubzfkhkfdcxtlq5@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--yergradsnencucsl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.06.2021 08:50:28, Torin Cooper-Bennun wrote:
> On Wed, May 26, 2021 at 05:15:59PM +0200, Marc Kleine-Budde wrote:
> > On 26.05.2021 13:47:47, Torin Cooper-Bennun wrote:
> > > Handle power, transceiver and SPI failures by printing a useful error
> > > message (multiple simultaneous failures are not logged) and disabling
> >            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >=20
> > Is this a limitation of your code or the tcan core?
>=20
> My code doesn't print an error message for every handled interrupt, only
> the first, because it's very rare to see more than one. Perhaps it's
> prudent to print a line for each handled interrupt just in case.

Yes, please make it so.

> > >  static irqreturn_t tcan4x5x_handle_dev_interrupts(struct m_can_class=
dev *cdev,
> > >  						  bool clear_only)
> > >  {
> > > -	tcan4x5x_clear_interrupts(cdev);
> > > +	struct tcan4x5x_priv *priv =3D cdev_to_priv(cdev);
> > > +	int err =3D 0;
> > > +	irqreturn_t handled =3D IRQ_NONE;
> >=20
> > nitpick: please make "int err" the last.
>=20
> ACK
>=20
> >=20
> > > +
> > > +	if (!clear_only) {
> > > +		u32 ir =3D 0;
> > > +		const char *fail_str =3D "";
> >=20
> > nitpick: please make the u32 the last.
>=20
> ACK
>=20
> > > +		else if (ir & TCAN4X5X_CANDOM_INT_EN)
> > > +			fail_str =3D "CAN stuck dominant (CANDOM)";
> >=20
> > The error message suggests, that this error can be triggered by messing
> > around with the CAN high/low wires. I'm not sure if it's a good idea to
> > shutdown the driver in this case.
>=20
> ACK, but I need to test whether the device stays functional without CPU
> intervention after CANDOM is asserted.

- Does IRQ line stay asserted if the CAN lines are still stuck dominant?

If yes, this would result in an IRQ storm, which we don't want to have.
If you/we want to handle this in a "proper" way, send a CAN error frame [1],
mask this interrupt, setup a timer/workqueue/etc and unmask it after
some 100ms.
 =20
[1] But I'm not sure if we have proper values for stuck dominant yet.
    https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/can/e=
rror.h#L110
 =20
- What happens if the stuck dominant condition is gone?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--yergradsnencucsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmC17ZsACgkQqclaivrt
76lrBQf/dt4ofo83t85XlMS54/+2DCScangXmhw5ULy3DYXXOHZ+2Q+mW3goG0Ox
I6ZP8U+vMP8a9fK1CfsIhj/3COPPi8GXYpzBaPU8CLWdt38OBjbaH9WC089f96iy
lH6OrlhLR4DE7mNBJsGp4xUiCaXvkkh6jGSWJsJ8hS7xmxXJjmS0q3tKvpBkmSJQ
1brYZ7s6a7Ac5xZzz0mFNPiiN57RTjENTPUEHq1jF2SEv2c64C1Bxsyv97fyJC7j
xfTkupCaPPGIs9RYaa3AubCrhFzKpsRtqq/0W7/TH835Wg1yUVbP3Hysr/mKSTov
hZUbtG86TR1Mzeg76+RWBg41+TsZsg==
=bsAx
-----END PGP SIGNATURE-----

--yergradsnencucsl--
