Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6996D49350C
	for <lists+linux-can@lfdr.de>; Wed, 19 Jan 2022 07:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350175AbiASGiq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jan 2022 01:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349687AbiASGiq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jan 2022 01:38:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78A3C061574
        for <linux-can@vger.kernel.org>; Tue, 18 Jan 2022 22:38:45 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nA4cE-0000HX-Lg; Wed, 19 Jan 2022 07:38:42 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B1AF11D392;
        Wed, 19 Jan 2022 06:38:40 +0000 (UTC)
Date:   Wed, 19 Jan 2022 07:38:37 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: mcf5441x: flexcan FIFO and mailbox mode (was: Re: [PATCH v5 5/5]
 can: flexcan: add mcf5441x support)
Message-ID: <20220119063837.idsiq72xrv4fvtih@pengutronix.de>
References: <20220106111847.zjkrghehxr7mrkkt@pengutronix.de>
 <1cf937d1-1e26-e611-c85f-f9e2128c225@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3t4iimn5toj3urys"
Content-Disposition: inline
In-Reply-To: <1cf937d1-1e26-e611-c85f-f9e2128c225@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--3t4iimn5toj3urys
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.01.2022 07:25:21, Angelo Dureghello wrote:
> > we're currently discussing the option that the user of a flexcan can
> > switch between RX-FIFO and RX via mailboxes.
> >=20
> > I noticed that the mcf5441x currently is configured for FIFO mode. Have
> > you tested the driver in mailbox mode?
> >=20
> > The reason that some cores use the FIFO mode is, that they cannot
> > receive RTR CAN frames in mailbox mode. According to the IP core
> > overview table, the mcf5441x can receive RTR frames.
> >=20
> > If the IP core supports reception of RTR frames, mailbox mode should be
> > used, as it makes use of more buffers (16-2) instead of 6 in FIFO mode.
> > Should we activate mailbox mode for the mcf5441x?
>=20
> Ok, not sure why i selected FIFO mode initially, my application
> actually is quite simple. Will try the switch to mailbox, sure,
> looking into this.

Thanks for coming back to me. The mailbox mode performs better under
heavy load, as you have more buffers available.=20

If you're using a recent kernel, the flexcan driver has been moved to:
| drivers/net/can/flexcan/flexcan-core.c

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexc=
an/flexcan-core.c
index 0bff1884d5cc..aa0b7efb5ca6 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -296,7 +296,8 @@ static_assert(sizeof(struct flexcan_regs) =3D=3D  0x4 *=
 18 + 0xfb8);
 static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data =3D {
        .quirks =3D FLEXCAN_QUIRK_BROKEN_PERR_STATE |
                FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
-               FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
+               FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+               FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
 };

On older kernel with drivers/net/can/flexcan.c you need:

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 7734229aa078..538b26619460 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -382,7 +382,8 @@ struct flexcan_priv {
=20
 static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data =3D {
        .quirks =3D FLEXCAN_QUIRK_BROKEN_PERR_STATE |
-               FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16,
+               FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
+               FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
 };
=20
 static const struct flexcan_devtype_data fsl_p1010_devtype_data =3D {

Please apply appropriate change and check if the driver still works if
you RX with full CAN bus load. Please also test if you can still receive
RTR frames.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3t4iimn5toj3urys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHnseoACgkQqclaivrt
76lWPgf9FuBJhUgLmEiYib3sj7kwV7dTCvICIJobL0o+3DDuq4c8P71beO4gW0e9
UEHl1i+NtHxwga57nr6BZ3YbxAxcf7UoEDbye0itSEAjgsKd6yPa0seQJiCZvUI6
HGWSZKoLsUTFCF3DsOISqPkyCgA4HEPqrVxFpAtyeY3pNbuyeNjnoQZTL+Djtmly
TfxxSsVMMwTz+uH3bF7f3aef1naFx10b9B28CL74+szRZkVxHl6UrBi1oZyR+3mt
0Sxujv/pJY+l4WHvKF0SsO7NN/2Gr47673wDOaJS4DiGRUdKK0dV84xIpVyfAnb5
dTojuaNX+GyyRFs+IcsP4BojTje3VQ==
=84Ls
-----END PGP SIGNATURE-----

--3t4iimn5toj3urys--
