Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595985F773C
	for <lists+linux-can@lfdr.de>; Fri,  7 Oct 2022 13:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJGLO5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Oct 2022 07:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJGLO4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Oct 2022 07:14:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6503E756
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 04:14:53 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oglJa-0006Mc-Su; Fri, 07 Oct 2022 13:14:50 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B0C10F6DEB;
        Fri,  7 Oct 2022 11:14:49 +0000 (UTC)
Date:   Fri, 7 Oct 2022 13:14:48 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Daniel S. Trevitz" <dan@sstrev.com>
Cc:     linux-can@vger.kernel.org,
        Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: Re: [PATCH 1/1] Termination resistor documentation
Message-ID: <20221007111448.vlgmz7ih7coozwdd@pengutronix.de>
References: <4514353.LvFx2qVVIh@daniel6430>
 <20221007074117.5enbqlt4fno7vtlz@pengutronix.de>
 <5016474.31r3eYUQgx@daniel6430>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lga6gjkm4sbptxc7"
Content-Disposition: inline
In-Reply-To: <5016474.31r3eYUQgx@daniel6430>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--lga6gjkm4sbptxc7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.10.2022 06:37:24, Daniel S. Trevitz wrote:
> On Friday, October 7, 2022 3:41:17 AM EDT Marc Kleine-Budde wrote:
> > On 06.10.2022 15:27:50, Daniel S. Trevitz wrote:
> > > Add documentation for how to use and setup the switchable termination
> > > resistor support for the can-controllers.
> > >=20
> > > Signed-off-by: Daniel Trevitz <dan@sstrev.com>
> > > ---
> > >=20
> > >  Documentation/networking/can.rst | 30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >=20
> > > diff --git a/Documentation/networking/can.rst
> > > b/Documentation/networking/can.rst index ebc822e605f5..bb39cfa4c502
> > > 100644
> > > --- a/Documentation/networking/can.rst
> > > +++ b/Documentation/networking/can.rst
> > > @@ -1148,6 +1148,36 @@ tuning on deep embedded systems'. The author is
> > > running a MPC603e>=20
> > >  load without any problems ...
> > >=20
> > > +Switchable Termination Resistors
> > > +--------------------------------
> > > +
> > > +CAN bus requires a specific impedance across the differential pair,
> > > +typically provided by two 120Ohm resistors on the farthest nodes of
> > > +the bus. Some CAN controllers support activating / deactivating a
> > > +termination resistor(s) to provide the correct impedance.::
> > > +
> >=20
> > > +  - Query the available resistances:
> > You need double :: followed by a newline to mark as code.
> This whole section is a code block; :: is up three lines.

Yes, your're right. What about making only the individual commands code?

Marc


--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lga6gjkm4sbptxc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNACiUACgkQrX5LkNig
010ZwAf/fE3a2KXFrPO9G1tvsIp24vFEefceRDdWudmUXlLNFSUrKhZuzow+Px8V
WjOM1rUc3AhFQS+McSbMpoRCg+T5P2ChbgqZ8waGgJKMxw33oLTwKhOgXl5cPuqr
R6uD4onarQdzSxSq506jAylGuUAONE6rmtPQ7rFQZnQyZ1j0ZVtE2jSSG0+HWQw4
GxJkXO9PCW0uMQgyvMuVJNZZNIww4+2EhZ2JsnskYsaRC4mix+D+OzZ+GK73gpsK
UhdHIPwoDVP5v/STguTI0QFSCJdbEOT4SRqSoSpax2yQNj/AJihvo9g1mxmfySK5
m4qHpA3qfZ3e0POTQwa+Mf3k8TinvA==
=a6sH
-----END PGP SIGNATURE-----

--lga6gjkm4sbptxc7--
