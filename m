Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603F9581351
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 14:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbiGZMnp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 08:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiGZMno (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 08:43:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A91F248C2
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 05:43:44 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oGJuY-00084B-2a; Tue, 26 Jul 2022 14:43:42 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 106EBBAC18;
        Tue, 26 Jul 2022 12:43:41 +0000 (UTC)
Date:   Tue, 26 Jul 2022 14:43:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 00/10] can: remove litteral strings used for driver
 names and remove DRV_VERSION
Message-ID: <20220726124338.wnv7jrtzles3epl7@pengutronix.de>
References: <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
 <20220726085447.csoxejg63ho2vrfk@pengutronix.de>
 <CABGWkvr3nE9ihLTB0QM05UXzHUYS4N2U7OnOdFFyfOPFAYg84A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g5wxqdztaevqecfq"
Content-Disposition: inline
In-Reply-To: <CABGWkvr3nE9ihLTB0QM05UXzHUYS4N2U7OnOdFFyfOPFAYg84A@mail.gmail.com>
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


--g5wxqdztaevqecfq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2022 11:58:17, Dario Binacchi wrote:
> On Tue, Jul 26, 2022 at 10:54 AM Marc Kleine-Budde <mkl@pengutronix.de> w=
rote:
> >
> > On 26.07.2022 17:26:57, Vincent Mailhol wrote:
> > > This is a cleanup series.
> > >
> > > The patches 1 to 8 get rid of any hardcoded strings and instead relies
> > > on the KBUILD_MODNAME macros to get the device name. Patch 9 replaces
> > > the ES58X_MODULE_NAME macro with KBUILD_MODNAME in
> > > etas_es58x. Finally, also in etas_es58x, patch 10 removes the
> > > DRV_VERSION so that the module uses the default behavior and advertise
> > > the kernel version instead of a custom version.
> >
> > Added to linux-can-next/master. Dropped patch "[PATCH v2 03/14] can:
> > slcan: add software tx timestamps", to let Dario Binacchi pick that up.
>=20
> or "can: slcan: use KBUILD_MODNAME and define pr_fmt to replace
> hardcoded names" ?

Doh! ACK, fixed.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--g5wxqdztaevqecfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLf4XcACgkQrX5LkNig
0108kgf+NnyfW8W2I5uuNOfqa3H6RzWNSdwFo5Z3ZOcdKhW5flDu9dDWVvKeIfvT
bQMXhTSnyiexUboghu/msrWPHxNWAyIiThF7P6ascYQekiAO1apmrEYL03EfUmkz
qpopAmWRm8w1dXY9tKKoCWEihWeMaEZ3R4s2uPvfSZ2uC1TvNuNyq7mAYJ3rcyyw
uUWJGSCECD0BoX0GPMAQ7t5D1rMlq/3pOMjtwm/2O0n1nTHJEYdXjUWRGU3VNbDQ
HiMHYMux2gC7/nZnl/4GqpkJl6x7gfCk0yAZOSFU5d3jqhh4wHdA/U9ldUbV9hF1
4pk8YI6dkhXV/BhaTVBcL2/wp4IrsA==
=32qg
-----END PGP SIGNATURE-----

--g5wxqdztaevqecfq--
