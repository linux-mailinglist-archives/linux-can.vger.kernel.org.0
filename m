Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6998F3417A1
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 09:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhCSIje (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 04:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbhCSIj2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 04:39:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDD3C06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 01:39:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNAfH-0006RH-Ch; Fri, 19 Mar 2021 09:39:27 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7ffa:65dd:d990:c71d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 85E765FA69C;
        Fri, 19 Mar 2021 08:39:26 +0000 (UTC)
Date:   Fri, 19 Mar 2021 09:39:25 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 2/3] can/peak_usb: add forgotten supported devices
Message-ID: <20210319083925.rvkbikpmkfxhjmr2@pengutronix.de>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-3-s.grosjean@peak-system.com>
 <20210309152837.3vpzfgcxsexr7l7u@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5m5rzxkb5mla4266"
Content-Disposition: inline
In-Reply-To: <20210309152837.3vpzfgcxsexr7l7u@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5m5rzxkb5mla4266
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 16:28:37, Marc Kleine-Budde wrote:
> On 09.03.2021 09:21:27, Stephane Grosjean wrote:
> > Since the peak_usb driver also supports the CAN-USB interfaces
> > "PCAN-USB X6" and "PCAN-Chip USB" from PEAK-System GmbH, this patch adds
> > their names to the list of explicitly supported devices.
> >=20
> > Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> > ---
> >  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_fd.c
> > index 6183a42f6491..8e6250c4c417 100644
> > --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > @@ -19,6 +19,8 @@
> > =20
> >  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
> >  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
> > +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB X6 adapter");
> > +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-Chip USB");
>=20
> I've exchanged these, to correspond the order of the device ids.

Funny side note:
MODULE_SUPPORTED_DEVICE was a noop define. All uses have been globally
removed from Linus' tree after this patch hit linux-net/master, but
before it landed in Linus' tree.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5m5rzxkb5mla4266
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBUYzsACgkQqclaivrt
76lplQf9FXJs6zO2B6pEPzgs4hsqtDB8IXGTjSXkUhu+jJeHdM1WjfQ1mEHGvrN5
4Qro4s3Npm4RSVfLAFdb1LbDe33J7hW2wk8sJeXUI2GKJPul+wjVorwpisJAkqaE
xGnPBuRg2MxnZQT2MNf5w2yNZ+WzDMJMKrt2n6qHVY1sEp7+hteVQDdp1i5w5Qv1
0GLGJzS0xZiK/n8xnDQbFfPUzjPyfDYx8R50uVlCNkZFTFPKIdDyiNHMAvKiaWG/
5Kr7VVnkMBBtp/KksjDysojJglo51hn2HJ/1fTdBtzIJ6An53vO2HKn4r6DOcagk
SU497GOAJye5AxKQfOPpZ3rrw1kNxQ==
=fOOs
-----END PGP SIGNATURE-----

--5m5rzxkb5mla4266--
