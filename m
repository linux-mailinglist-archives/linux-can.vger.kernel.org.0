Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB2D5B9AD5
	for <lists+linux-can@lfdr.de>; Thu, 15 Sep 2022 14:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIOMb3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Sep 2022 08:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIOMb2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Sep 2022 08:31:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D527F53D3B
        for <linux-can@vger.kernel.org>; Thu, 15 Sep 2022 05:31:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oYo1c-0006B5-Mj; Thu, 15 Sep 2022 14:31:24 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:e736:a6f2:e69:df99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D57F4E3DE2;
        Thu, 15 Sep 2022 12:31:23 +0000 (UTC)
Date:   Thu, 15 Sep 2022 14:31:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 00/10] can: remove litteral strings used for driver
 names and remove DRV_VERSION
Message-ID: <20220915123115.m7ykru5yucnna3g2@pengutronix.de>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
 <YyLkrj5v2EiBIXk+@surfacebook>
 <20220915122454.xsczmhz4e62musse@pengutronix.de>
 <CAHp75VeXbs4AQ-yQvv2kgpwhCF4fkOL83J=1YcfhV+SeRmai=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fio7pkoxig5mpzmq"
Content-Disposition: inline
In-Reply-To: <CAHp75VeXbs4AQ-yQvv2kgpwhCF4fkOL83J=1YcfhV+SeRmai=w@mail.gmail.com>
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


--fio7pkoxig5mpzmq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.09.2022 15:27:11, Andy Shevchenko wrote:
> > > If you change the name of the file, the module will be
> > > changed and hence the breakage.
> > >
> > > That said, NAK from me (as I do usually the opposite change).
> >
> > Let's look at the diffstat:
> >
> > These are serial line disciplines, they have their own ID:
> >  drivers/net/can/can327.c                         |  4 ++--
> >  drivers/net/can/slcan/slcan-core.c               | 14 ++++++++------
> >
> > This might be a problem, it's a platform driver:
> >  drivers/net/can/softing/softing_main.c           |  4 ++--
> >
> > It should be no problem for USB devices, right?
> >  drivers/net/can/usb/ems_usb.c                    |  4 ++--
> >  drivers/net/can/usb/esd_usb.c                    |  2 +-
> >  drivers/net/can/usb/etas_es58x/es58x_core.c      | 14 +++++---------
> >  drivers/net/can/usb/gs_usb.c                     |  6 +++---
> >  drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |  2 +-
> >  drivers/net/can/usb/usb_8dev.c                   |  4 ++--
>=20
> I agree with your grouping and analysis. This is minor anyway, but
> better to have it more robust. So, yes, with USB I don't believe it
> would be an issue, but for platform driver it might be.

This series is in >=3D v6.0 and there are several platform drivers that
use KBUILD_MODNAME for .name before this series.

I'll take care to revert that change on the softing driver and prepare
patches for the others.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--fio7pkoxig5mpzmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMjGxEACgkQrX5LkNig
012oqwf6AsoC12V2VfRLJT2NzPneifgUcbsA+dB6GMPmIPmIn6KI8c/AvY7zqI6S
XUibUpq1NJYv/z9d5GsHu+jK9StixnlzCPcS9NizbECwvVwgqI2m3EB+UmQxB2bY
HDhne7jFp5I2JlwVegNsP/vSyQiAbPv+l4fOXOmt2hXTIYw4/kCUorGcya6XNFbl
oJFL5sbkyceg6qm7ALw2BMFB1nfkSQoo/wzU0lmh53GHPAAQXxYjWlyHdW8YfRJr
5lPQZXyTsFb+8FxOJWKyv3AUXp1UkOenIbrbegn8VKfk1yWscJ/5I4p1wlnqEQV7
xbfbjf2HtM0iM3qYO+wyQ8mv7S7czw==
=qCrZ
-----END PGP SIGNATURE-----

--fio7pkoxig5mpzmq--
