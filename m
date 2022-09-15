Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771E15B9AA9
	for <lists+linux-can@lfdr.de>; Thu, 15 Sep 2022 14:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIOMZJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Sep 2022 08:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIOMZI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Sep 2022 08:25:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB730548
        for <linux-can@vger.kernel.org>; Thu, 15 Sep 2022 05:25:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oYnvU-0005IO-Bu; Thu, 15 Sep 2022 14:25:04 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:e736:a6f2:e69:df99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 200B9E3DC9;
        Thu, 15 Sep 2022 12:25:03 +0000 (UTC)
Date:   Thu, 15 Sep 2022 14:24:54 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     andy.shevchenko@gmail.com
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 00/10] can: remove litteral strings used for driver
 names and remove DRV_VERSION
Message-ID: <20220915122454.xsczmhz4e62musse@pengutronix.de>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
 <YyLkrj5v2EiBIXk+@surfacebook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mb7zzu53klm7f7iv"
Content-Disposition: inline
In-Reply-To: <YyLkrj5v2EiBIXk+@surfacebook>
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


--mb7zzu53klm7f7iv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 15.09.2022 15:18:02, andy.shevchenko@gmail.com wrote:
> Tue, Jul 26, 2022 at 05:26:57PM +0900, Vincent Mailhol kirjoitti:
> > This is a cleanup series.
> >
> > The patches 1 to 8 get rid of any hardcoded strings and instead relies
> > on the KBUILD_MODNAME macros to get the device name. Patch 9 replaces
> > the ES58X_MODULE_NAME macro with KBUILD_MODNAME in
> > etas_es58x. Finally, also in etas_es58x, patch 10 removes the
> > DRV_VERSION so that the module uses the default behavior and advertise
> > the kernel version instead of a custom version.
>
> I guess you all understand that this is potential ABI breakage.

Good point.

> The driver can be instantiated by its name (for matching purposes) from board
> files or MFD cell.

Hope we don't have board files anymore....

> If you change the name of the file, the module will be
> changed and hence the breakage.
>
> That said, NAK from me (as I do usually the opposite change).

Let's look at the diffstat:

These are serial line disciplines, they have their own ID:
 drivers/net/can/can327.c                         |  4 ++--
 drivers/net/can/slcan/slcan-core.c               | 14 ++++++++------

This might be a problem, it's a platform driver:
 drivers/net/can/softing/softing_main.c           |  4 ++--

It should be no problem for USB devices, right?
 drivers/net/can/usb/ems_usb.c                    |  4 ++--
 drivers/net/can/usb/esd_usb.c                    |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c      | 14 +++++---------
 drivers/net/can/usb/gs_usb.c                     |  6 +++---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |  2 +-
 drivers/net/can/usb/usb_8dev.c                   |  4 ++--

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--mb7zzu53klm7f7iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMjGZMACgkQrX5LkNig
012ZlQgAhgmsjCjdSWyZqARO203msP+VqQ7AjeYgGsk448ak1HGBCWEzTei1wHs7
o3D3SJnf6ILephHj2h1dpH91Ym3CELeChrtAQrBq/QPFOUGXNmksSYKW/Lee6TeE
4YiiSSg1/+5tyAiX7vqhP4kyTq+gT2DFt5J4a4UHGVLzLDX7Hti4zIQL3dvKnQAz
ci2kORkRg5AdJ3IjgRGi15SDSQYLa3rW4OJoHKtxfunGuGqLs4+jiYKWna7m3MNR
Co6GombSQPDlqofWLXhB6IVUUGXHcNEvYldVrTuEtWOq776FVL2fPn/M8ixbLz2L
WIkWLMhEoNCc/zl6Yut0N19sWj7/Zw==
=gse0
-----END PGP SIGNATURE-----

--mb7zzu53klm7f7iv--
