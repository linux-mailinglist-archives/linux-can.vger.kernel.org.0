Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AB3380CA7
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 17:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhENPRD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhENPRD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 11:17:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A45C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 08:15:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhZXa-0007yQ-By; Fri, 14 May 2021 17:15:50 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ab9e:cb46:9dda:16ff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7F8086244CE;
        Fri, 14 May 2021 15:15:49 +0000 (UTC)
Date:   Fri, 14 May 2021 17:15:48 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 3/3] can: tcan4x5x: add
 handle_dev_interrupts callback to ops
Message-ID: <20210514151548.jqydfez77fp74fdf@pengutronix.de>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514121946.2344901-4-torin@maxiluxsystems.com>
 <20210514141012.3ehw4tosog3lreq4@pengutronix.de>
 <20210514145101.uk7wldgsao5cvuj7@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vh6lsslykffjdrv7"
Content-Disposition: inline
In-Reply-To: <20210514145101.uk7wldgsao5cvuj7@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vh6lsslykffjdrv7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2021 15:51:01, Torin Cooper-Bennun wrote:
> On Fri, May 14, 2021 at 04:10:12PM +0200, Marc Kleine-Budde wrote:
> > For new code, please don't wrap the regmap_*() functions so that the
> > error values are ignored. I know, it's a bit annoying to always do the
> > "if (err) return err" dance.
>=20
> Will do, thanks.
>=20
> > As this is the interrupt handler there's not much we can do in case of
> > an error. In the mcp251xfd driver I print an error message and shut down
> > the interface. You should at least print an error message at the end of
> > the handle_interrupts() function.
>=20
> I assume you mean the handling of errors out of aforementioned
> regmap_*() functions specifically?

ACK, I'm talking about the return value of the regmap_() functions.

> I agree we should shut down the interface - I've previously endured
> serious debugging pain due to SPI errors going unrecognised and
> causing havoc.

You can eventually do the same, return negative error value from the
tcan4x5x handler and the main IRQ handler will shut down the chip. A
return value >=3D 0 would be the IRQ_*.

Some background information:

You have to keep in mind, the regmap_() functions might fail due to a
non permanent problem, e.g. resource shortage (out-of-memory, etc...). I
decided it's too complicated to properly recover from those, especially
if the driver touches some FIFO pointer.

The mcp251xfd chip offers CRC check summing during read. If the driver
detect a CRC read error (that stays even after some retries), I let the
regmap_read() function to return an error that is then passed down the
call stack. And then chip will be shut down.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vh6lsslykffjdrv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCelCIACgkQqclaivrt
76kMegf/T26QZbxnuKmwCTYNZMbI4msZ9d6ld5T91h9LX8x+GBY89mXnYhIPxpv+
E7YVrgkpl61AP9XDHVIeVcsSBjZ9vxqoEd0U7gee2c/d+Y47zsnZcOuQsgYtOYpf
4S6YQHr7UAFB9Q8pQQb5aaxpYBDYz3qXLz1O2T5kDLvmDzW6vut34AGkbSv+bMnX
tOvGglxKCljyjG2D88W3Q9TycqU3f7bBGP0x/1cWgsQV2Aue8CYqU0lg5lD3El6r
jsZnlf7l8n2HMGil7K2/jkH2v4LEjeVvRTQBjmc3wKSViB4KT3qzP2ESKJCwE7nc
KXKcfsZE9CDJSo7dPTsjW2p07JnN1Q==
=wi89
-----END PGP SIGNATURE-----

--vh6lsslykffjdrv7--
