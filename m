Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA1687CBA
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBBLx4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjBBLxz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:53:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC04A14E92
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:53:54 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNYA3-0005FP-Hg; Thu, 02 Feb 2023 12:53:51 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fff9:bfd9:c514:9ad9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 09C5316D404;
        Thu,  2 Feb 2023 11:53:51 +0000 (UTC)
Date:   Thu, 2 Feb 2023 12:53:42 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
        kernel@pengutronix.de, Mark Bath <mark@baggywrinkle.co.uk>
Subject: Re: [PATCH v2 10/17] can: bittiming: factor out
 can_sjw_set_default() and can_sjw_check()
Message-ID: <20230202115342.4why7ttcc4bziljk@pengutronix.de>
References: <20230202110854.2318594-1-mkl@pengutronix.de>
 <20230202110854.2318594-11-mkl@pengutronix.de>
 <CAMZ6RqJuUvTo=LAYdHQryjcr+FD+o=-_TJmrwjpgiixN6dTyFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y7a2kdu53b4jlnok"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJuUvTo=LAYdHQryjcr+FD+o=-_TJmrwjpgiixN6dTyFw@mail.gmail.com>
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


--y7a2kdu53b4jlnok
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.02.2023 20:51:04, Vincent Mailhol wrote:
> On Thu. 2 Feb. 2023 at 20:09, Marc Kleine-Budde <mkl@pengutronix.de> wrot=
e:
> > Factor out the functionality of assigning a SJW default value into
> > can_sjw_set_default() and the checking the SJW limits into
> > can_sjw_check().
> >
> > This functions will be improved and called from a different function
> > in the following patches.
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/net/can/dev/bittiming.c | 30 ++++++++++++++++++++++++++----
> >  include/linux/can/bittiming.h   |  5 +++++
> >  2 files changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bitt=
iming.c
> > index 0b0b8c767c5b..101de1b3bf30 100644
> > --- a/drivers/net/can/dev/bittiming.c
> > +++ b/drivers/net/can/dev/bittiming.c
> > @@ -6,6 +6,24 @@
> >
> >  #include <linux/can/dev.h>
> >
> > +void can_sjw_set_default(struct can_bittiming *bt)
> > +{
> > +       if (bt->sjw)
> > +               return;
> > +
> > +       /* If user space provides no sjw, use 1 as default */
> > +       bt->sjw =3D 1;
> > +}
> > +
> > +int can_sjw_check(const struct net_device *dev, const struct can_bitti=
ming *bt,
> > +                 const struct can_bittiming_const *btc, struct netlink=
_ext_ack *extack)
> > +{
> > +       if (bt->sjw > btc->sjw_max)
> > +               return -ERANGE;
>=20
> You return -ERANGE here but then replace it by -EINVAL in patch #12.

ACK.

> Better to directly return -EINVAL here.

This patch only factors out the functionality, but doesn't change it on
purpose.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--y7a2kdu53b4jlnok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmPbpEMACgkQvlAcSiqK
BOiScQf/VHD3OJYf713gkFyvwdTEv/z2DD8Y4G9tVJ4YH/2oO5FzPe3Lz8Nmqc2Q
bnNQTMiog6BigBzdBjtqaA5GxVTQRSccv1nxz8iU2LZZ+VGmcGrj7OiAX6DjBv5V
dnFFiMpdnbythe+3V5Tm1wl+JuiQ/BsRAHQ71WyeNbLQhzzwFxArFH13iu1WYC5d
JQ7rsqHuyPe/X0BqD19T8c5Ey3BAZUjqhIj1s7z4mZqAOZgSwiJBDnYRrSXgtN37
2AY/PK4iX3LwNuw6GN/cRIlAsrXQOgh/V4BlpZguraai5qNzaR3jCPNklG3x/r/6
gzt+naJY5+op+FIXNEJj3ciYWCfjCA==
=TS4y
-----END PGP SIGNATURE-----

--y7a2kdu53b4jlnok--
