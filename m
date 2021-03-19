Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132053418EC
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 10:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCSJ4l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhCSJ4d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 05:56:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B3EC06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 02:56:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNBrr-0006e4-Vy; Fri, 19 Mar 2021 10:56:32 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7ffa:65dd:d990:c71d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DE3E25FA753;
        Fri, 19 Mar 2021 09:56:30 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:56:30 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 2/3] can/peak_usb: add forgotten supported devices
Message-ID: <20210319095630.pheblaalfg6r6zvo@pengutronix.de>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-3-s.grosjean@peak-system.com>
 <20210309152837.3vpzfgcxsexr7l7u@pengutronix.de>
 <20210319083925.rvkbikpmkfxhjmr2@pengutronix.de>
 <CAMZ6RqL_ua4NzJ5VMC8Nw0iSXfBDDuOpabVJv+EEK82c4AsnEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hsydvovqctkae2ey"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqL_ua4NzJ5VMC8Nw0iSXfBDDuOpabVJv+EEK82c4AsnEQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hsydvovqctkae2ey
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.03.2021 18:47:06, Vincent MAILHOL wrote:
> On Fri. 19 Mar 2021 at 17:39, Marc Kleine-Budde <mkl@pengutronix.de> wrot=
e:
> > On 09.03.2021 16:28:37, Marc Kleine-Budde wrote:
> > > On 09.03.2021 09:21:27, Stephane Grosjean wrote:
> > > > Since the peak_usb driver also supports the CAN-USB interfaces
> > > > "PCAN-USB X6" and "PCAN-Chip USB" from PEAK-System GmbH, this patch=
 adds
> > > > their names to the list of explicitly supported devices.
> > > >
> > > > Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> > > > ---
> > > >  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/n=
et/can/usb/peak_usb/pcan_usb_fd.c
> > > > index 6183a42f6491..8e6250c4c417 100644
> > > > --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > > > +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > > > @@ -19,6 +19,8 @@
> > > >
> > > >  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
> > > >  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
> > > > +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB X6 adapter");
> > > > +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-Chip USB");
> > >
> > > I've exchanged these, to correspond the order of the device ids.
> >
> > Funny side note:
> > MODULE_SUPPORTED_DEVICE was a noop define. All uses have been globally
> > removed from Linus' tree after this patch hit linux-net/master, but
> > before it landed in Linus' tree.
>=20
> Silly question but does it mean that we should not use
> MODULE_SUPPORTED_DEVICE in newly submitted patches?

ACK - It's been removed from Linus' tree, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D6417f03132a6952cd17ddd8eaddbac92b61b17e0

> After seeing St=C3=A9phane's patch, I added it to my driver. Even if it is
> a noop define, it adds meta information in the source code so I was
> inclined to keep it.

As the noop define has been removed, the driver will no longer compile.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hsydvovqctkae2ey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBUdUsACgkQqclaivrt
76k4DQf/SN7DIlfk7h7/5l+C8eSRBUazXHkZMAxqarnwVFVJ6+TwyjCmci9P/cw2
YeLDc9u9dbk/U5+CvkENIf3+J1PXpmi33iYe3tayyj5E3X8orXG+3mRmZT7t6t7F
LptspTVwBa3Gb/158WwY2DGLnZU6VsuV092DKV96+um7LYtV2QWjgenyxZUvOIR3
BM6ZaI9iW43oZ90S0oUugUU2hlcpmPFaNapqe+MQ+tD1fms1E5LtslfDNNW5X+ah
weXGM2ldiB9L3p5ON6gd6/vmCijaA6K3TAWmLXo0SYUt5JGwZUORHXxbo5jREXvl
DFhSVG7e8/+UXPlqAGXglHKKqxvn3w==
=5uGs
-----END PGP SIGNATURE-----

--hsydvovqctkae2ey--
