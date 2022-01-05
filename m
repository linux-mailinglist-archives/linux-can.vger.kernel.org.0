Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD444850D3
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 11:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiAEKOT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 05:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbiAEKOS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 05:14:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B94CC061761
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 02:14:18 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n53JA-0004Bl-Oi; Wed, 05 Jan 2022 11:14:16 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-7899-4998-133d-b4b9.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:7899:4998:133d:b4b9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B0ED86D1835;
        Wed,  5 Jan 2022 10:14:15 +0000 (UTC)
Date:   Wed, 5 Jan 2022 11:14:14 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v2 1/3] can: flexcan: change RX-FIFO feature at runtime
Message-ID: <20220105101414.kg7mwp2uop6rsfbv@pengutronix.de>
References: <20220104154133.848784-1-mkl@pengutronix.de>
 <CABGWkvo+h2CASM7q8z3UXRofrY7enVXS6njFKnKyqRUjgkbB_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="735iszjo372r3yat"
Content-Disposition: inline
In-Reply-To: <CABGWkvo+h2CASM7q8z3UXRofrY7enVXS6njFKnKyqRUjgkbB_A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--735iszjo372r3yat
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.01.2022 09:25:35, Dario Binacchi wrote:
> > Is the name "rx-fifo" acceptable? Can you think of a better name?
>=20
> If I am not mistaken this series arises from the need to deactivate
> the RxFIFO only if it is acceptable not to receive the notification of
> RTR messages.

ACK

> I wonder if this can be made explicit to the user.

I was hoping that we can find a better string that better represents
what this option does.

> Do you think it makes sense to explicitly RTR ("rtr-notify") instead
> of RxFIFO (rx-fifo)? And if it makes sense to make it clear that it
> occurs at the expense of a smaller number of messages allocated for
> reception?

I see it the other way round, probably biased by the existing driver :)
The user wants to use more buffers at the expense of loosing the ability
to receive RTR messages.

I've talked to one of my colleges and we came to the conclusion that the
driver should present the user the option to opt out from RTR reception.

If the user has opted out from RTR reception the driver can do internal
optimization, such as switching from FIFO to mailbox mode.

What about "rtr-rx" or "rx-rtr"?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--735iszjo372r3yat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHVb3QACgkQqclaivrt
76nXHAf+O+XsCkP99punK27EmDHY++g8MDxfdUi8khZTjvq+Ta77USgMTZXbypMs
SRZkFb0U3ebHroaEw33ySL4+sIN+hXJkK/YhvsN9mTFNmUxAJY0l6OVgQ7nzRU2c
RPy553vHM3b1bjanip/ZGHbCXv95gPYP3srOu0hEu43BV+x6HDcNpwrfvlzLC/6v
SB7UhCOxMw66QkzuVqE7RIMyRes619yABPd8xM1xvXTsRX4ADNICY+g37IvEnM+l
K1dmd5o6TV4fsMBRbtWvX1ANtulrD7bY64HIzISq3UyCO9e0UMK2u8onD6P8PJ3f
1BgL6LkavNleztRTRPmnsfZhO7kIiw==
=z+oS
-----END PGP SIGNATURE-----

--735iszjo372r3yat--
