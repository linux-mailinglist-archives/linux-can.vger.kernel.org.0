Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D57446329
	for <lists+linux-can@lfdr.de>; Fri,  5 Nov 2021 13:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhKEMJ5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Nov 2021 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhKEMJ5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Nov 2021 08:09:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E65C061714
        for <linux-can@vger.kernel.org>; Fri,  5 Nov 2021 05:07:17 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1miy04-00077A-AR; Fri, 05 Nov 2021 13:07:16 +0100
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:5b8d:8c69:dffb:a268])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 874886A54B2;
        Fri,  5 Nov 2021 12:07:15 +0000 (UTC)
Date:   Fri, 5 Nov 2021 13:07:13 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Matthias =?utf-8?Q?Wei=C3=9Fer?= <m.weisser.m@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: sjw in can_calc_bittiming
Message-ID: <20211105120713.qmmsloqxvtwdso5q@pengutronix.de>
References: <CAO8h3eEcK7c6M5T88K0MO6eQk64DY+85Mzsi5zdT9tV9mxiMfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sl7v2kf4duptkvjy"
Content-Disposition: inline
In-Reply-To: <CAO8h3eEcK7c6M5T88K0MO6eQk64DY+85Mzsi5zdT9tV9mxiMfw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--sl7v2kf4duptkvjy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.11.2021 16:03:33, Matthias Wei=C3=9Fer wrote:
> we recently had a case here where one member of a CAN bus couldn't
> receive frames with data content of only zeros:
>=20
> $ cansend can0 123#0000000000000000
>=20
> After some investigation we found the root cause to be a slight
> difference (about 1%) in actual bitrates of the two members. The one
> with showed the RX errors had a sjw value of 1 and a lot of time
> quanta (40) due to the 40MHz CAN clock.
>=20
> This leads to a build up of phase error (as sjw is not able to
> compensate for enough of the bitrate difference) which at some point
> leads to a framing error due to missing a stuff bit. Playing around
> with the sample point can improve or worsen the behavior.
>=20
> We can fix this quite easily by specifying a higher sjw value.

We have seen this behavior, too. :(

> Question is now:
> Wouldn't it make sense to increase sjw in can_calc_bittiming() to
> something like 5% of the total time quanta?

You mean of the total bit time?

The problem is that the SJW is set to 1 time quanta by default. For a
given bit rate the time quanta is not a constant value, but depends on
the oscillator frequency and configured bit rate prescaler. As you
suggested, I agree a better solution would be to set the SJW to a
certain percentage of the bit time. But, what is a proper default value
of a percentage based SJW?

> This may increase the reliability of the CAN network when there are
> differences in the bitrates of the single members. Are there any
> arguments against such an arbitrary selection of sjw?
>=20
> If you agree with such a change I can come up with a proper patch. If
> I wrote totally nonsense please tell me :-)

I'm interested in a patch. There are some requirements and thoughts:
- introduce a define for the default SJW percentage value
- use the default SJW percentage value if the user has not provided a
  SJW
- the "struct can_bittiming" cannot be modified

In a later patch we can introduce a configuration interface to set SJW
percentage value from user space.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--sl7v2kf4duptkvjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGFHmcACgkQqclaivrt
76n4rAf9FUfJb61/AJri55OyI3YpKgu0YkzQm8Ia3lfdjFSv6+JuqRbIpj4zjOLs
Mqig2WquX7Pr/VQimhNFO/2xE1C3kme5Ixa3KsstQ+6TShH+X2wV+GmkVCOJMToB
5madman8Lk+TnF35mOR/kW7JUvgmmzNAWZLFbQYW9DwPUTzbioZuAQh+NnetsORV
Vfdz3Ss1EUR/noDx9bDscUo715FgerUPMu4oVfI4iKHbDgyIbKjKHERf8YUFXTHt
XjLxskBe2RL7TdRd2nb9zRifTHf+U7CKkWil7XY3tnDbQJFv9xAQxNFtne2fY3pD
ezmtL5sKsAfue5Z2T9ZfKZMf7dXZIQ==
=T3T/
-----END PGP SIGNATURE-----

--sl7v2kf4duptkvjy--
