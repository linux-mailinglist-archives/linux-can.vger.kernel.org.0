Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6553F3D708B
	for <lists+linux-can@lfdr.de>; Tue, 27 Jul 2021 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhG0HqW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Jul 2021 03:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhG0HqV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Jul 2021 03:46:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875CFC061757
        for <linux-can@vger.kernel.org>; Tue, 27 Jul 2021 00:46:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m8Hn9-0004Ae-HT; Tue, 27 Jul 2021 09:46:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ebcc:d5d8:601d:f340])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5F43A658E5E;
        Tue, 27 Jul 2021 07:46:18 +0000 (UTC)
Date:   Tue, 27 Jul 2021 09:46:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>
Subject: Re: [PATCH] can: mcp251xfd: mcp251xfd_open(): request IRQ as shared
Message-ID: <20210727074617.6tsjtlxmmvsmtfvc@pengutronix.de>
References: <20210724205212.737328-1-mkl@pengutronix.de>
 <20210727071717.GA33931@thinkpad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45yrgkscqvyxnzcu"
Content-Disposition: inline
In-Reply-To: <20210727071717.GA33931@thinkpad>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--45yrgkscqvyxnzcu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.07.2021 12:47:17, Manivannan Sadhasivam wrote:
> On Sat, Jul 24, 2021 at 10:52:13PM +0200, Marc Kleine-Budde wrote:
> > The driver's IRQ handler supports shared IRQs, so request a shared IRQ
> > handler.
>=20
> I don't see any issue with the idea but I'd like to understand the
> requirement for it.

Hardware designers might come up with strange ideas, so better be
prepared for this. :)

But seriously, there's a group of people trying to bring the mcp251xfd
driver to work on ACPI based systems. Having a shared mcp251xfd IRQ
handler will (hopefully) help them during debugging.

I've written the IRQ handler to properly only return IRQ_HANDLED if
there really was an interrupt, this means it should be capable running
as a shared IRQ handler. I've tested it and it works. So let the driver
request a shared IRQ handler.

> Usually the IRQ lines are shared when multiple devices use them
> physically. For instance, a MFD device using a single GPIO for all of its
> functions. But I don't see any sort of requirement like that here.

Indeed there is really no good reason to do so, but it works. For
testing I've connected 2 mcp2518fd to the same IRQ line and the kernel
runs both IRQ handlers an interrupt is triggered. If course this brings
the overhead of an additional SPI transfer per IRQ, but it works.

> Making the IRQ lines shared will only induce latency IMO.

ACK - you will not get better performance compared to separate IRQ lines
:) But if you don't use shared interrupts this change doesn't make the
driver or system any slower or induce latency.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--45yrgkscqvyxnzcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD/uccACgkQqclaivrt
76lakwf+JrpspQaJbEjINS19qXVlt+Tax9EdzXnaQIjugOuWrM0QNUSoG2KLXK6D
j5I+ceNwK2nTwBD8rOmwxlsb6t8jVBzPKUFr4nV81MJDcJl8MJrh/ILaijR+AJ3V
EaQ01n8qKO0n8TDONbGqV73NDs2txQL2y+798OfQlWHlbRgzST/kbT3Q9yvT6qyI
MUKfMAJuJ9fDbpAjhGozahswUeZka4O4NjQzY5IS6SdJXlKrpfpEEl0+aMLR2yoU
hq73KiArZUkQ3qSfKH8avruIoSIB8SDSeBNgFgW/v/iDr00Rc6N/4MyWgJ5MIth4
Dv+UMXG+vVY/7+twSj7RD6IuWAoqmw==
=0dtm
-----END PGP SIGNATURE-----

--45yrgkscqvyxnzcu--
