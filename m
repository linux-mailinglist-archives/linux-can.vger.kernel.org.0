Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614B134F99A
	for <lists+linux-can@lfdr.de>; Wed, 31 Mar 2021 09:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhCaHPC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 31 Mar 2021 03:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhCaHOd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 31 Mar 2021 03:14:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3482EC061574
        for <linux-can@vger.kernel.org>; Wed, 31 Mar 2021 00:14:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lRV3d-0001T5-Ha; Wed, 31 Mar 2021 09:14:29 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a06:b6ed:4055:757b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 57854604B16;
        Wed, 31 Mar 2021 07:14:28 +0000 (UTC)
Date:   Wed, 31 Mar 2021 09:14:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
        linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251x: fix support for half duplex SPI host
 controllers
Message-ID: <20210331071427.w4bplxt2hoiduho2@pengutronix.de>
References: <20210330100246.1074375-1-mkl@pengutronix.de>
 <CAJ+vNU0w2faqmW0MOA9FQD8=vxpJH1Lc8c0BMcAVKGNq1vNjjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dozzgkgjhzp7zuuw"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0w2faqmW0MOA9FQD8=vxpJH1Lc8c0BMcAVKGNq1vNjjg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--dozzgkgjhzp7zuuw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 30.03.2021 14:06:03, Tim Harvey wrote:
> On Tue, Mar 30, 2021 at 3:02 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >
> > Some SPI host controllers do not support full-duplex SPI transfers.
> >
> > The function mcp251x_spi_trans() does a full duplex transfer. It is
> > used in several places in the driver, where a TX half duplex transfer
> > is sufficient.
> >
> > To fix support for half duplex SPI host controllers, this patch
> > introduces a new function mcp251x_spi_write() and changes all callers
> > that do a TX half duplex transfer to use mcp251x_spi_write().

> So was the issue being resolved here that there was another SPI host
> controller that wasn't advertising that it was half duplex only

I don't know which SPI host controller Gerhard uses, but I assume it has
half duplex set, as the driver probe fails with:

| [  112.226164] mcp251x spi0.1: spi transfer failed: ret = -22

The -22 is returned by the SPI framework if you have a half duplex
controller and a transfer with both TX and RX buffer set. This is the
case in the mcp251x_spi_trans() function.

> or was something else wrong with e0e25001d088 ("can: mcp251x: add
> support for half duplex controllers")?

Your patch only converted the SPI read path to use half duplex
transfers. My patch also converts the SPI write path.

If your half duplex controller works without that patch, the controller
driver doesn't advertise correctly that it is half duplex only. If the
hardware is indeed half duplex only, better send a patch that sets the
half duplex flag. If the hardware support full duplex, but the driver
somehow doesn't implement it correctly, so that it implements half
duplex only you should at least drop a note on the SPI mailing list.

Can you test this patch and give me a Tested-by?

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--dozzgkgjhzp7zuuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBkIVEACgkQqclaivrt
76nUWAgAsqcfQuGKL8SgISA7yqKTEuFlRZAr5WPJx9iivxAaCEqDNiLEFhZ3LenW
9TLRo4SlUTdAzt3kkfjFJI4uQU0wNxSyzUNjVr5E5js69xT7ZbxeE150vR6pJl4u
Cxr7kWJuEGSjMVICmVS6phCuZehSUETpRgjnmCWCfYJlRcp9l9PlNs+iB9Nal5LA
mPuk7kc16uPSiuzVH1jSNooHZG5IkgzVYwFBuuM0/AYUjYxev6dBdTimwjFARisB
7ktRRa8i/oBIRWd/CJz5nwTUlNcnBNBhHdRlIlL0LO0vt0KHQLp1l3cnE7j85ooY
vCQpdda6SYau8Ofze4iyULgYqX6olg==
=KYeh
-----END PGP SIGNATURE-----

--dozzgkgjhzp7zuuw--
