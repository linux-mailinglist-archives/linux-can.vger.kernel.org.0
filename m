Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8739B48633B
	for <lists+linux-can@lfdr.de>; Thu,  6 Jan 2022 11:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiAFKyU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 Jan 2022 05:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiAFKyU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Jan 2022 05:54:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4DCC061245
        for <linux-can@vger.kernel.org>; Thu,  6 Jan 2022 02:54:19 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n5QPR-0005B6-P5; Thu, 06 Jan 2022 11:54:17 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-fd40-da16-8525-0d68.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:fd40:da16:8525:d68])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CC6316D2518;
        Thu,  6 Jan 2022 10:54:16 +0000 (UTC)
Date:   Thu, 6 Jan 2022 11:54:15 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v2 1/3] can: flexcan: change RX-FIFO feature at runtime
Message-ID: <20220106105415.pdmrdgnx6p2tyff6@pengutronix.de>
References: <20220104154133.848784-1-mkl@pengutronix.de>
 <CABGWkvo+h2CASM7q8z3UXRofrY7enVXS6njFKnKyqRUjgkbB_A@mail.gmail.com>
 <20220105101414.kg7mwp2uop6rsfbv@pengutronix.de>
 <CABGWkvo-tuYDDJv+EBzPhf5RGCyt5eMD14ePq9C9Y4de_=fX=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ty3jegmrw4f65u6z"
Content-Disposition: inline
In-Reply-To: <CABGWkvo-tuYDDJv+EBzPhf5RGCyt5eMD14ePq9C9Y4de_=fX=Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ty3jegmrw4f65u6z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.01.2022 11:40:52, Dario Binacchi wrote:
> > I was hoping that we can find a better string that better represents
> > what this option does.
> >
> > > Do you think it makes sense to explicitly RTR ("rtr-notify") instead
> > > of RxFIFO (rx-fifo)? And if it makes sense to make it clear that it
> > > occurs at the expense of a smaller number of messages allocated for
> > > reception?
> >
> > I see it the other way round, probably biased by the existing driver :)
>=20
> Could this change of perspective then not require the addition of a new
> quirk that allows to change between rx-fifo and rx-mailbox mode?

ACK - I only want to enable switching between rx-fifo and rx-mailbox
mode for the devices that currently use rx-fifo mode. It makes no sense
to switch from rx-mailbox to rx-fifo mode if your flexcan IP core can
receive RTR messages in rx-mailbox mode.

There even is the limitation that rx-fifo mode doesn't support CAN-FD
mode....but the driver checks for this.

> > The user wants to use more buffers at the expense of loosing the ability
> > to receive RTR messages.
>=20
> Can / should it be documented in some way other than the commit message?

Yes - Documentation/networking/device_drivers/can/ looks like a good place.

> > I've talked to one of my colleges and we came to the conclusion that the
> > driver should present the user the option to opt out from RTR reception.
> >
> > If the user has opted out from RTR reception the driver can do internal
> > optimization, such as switching from FIFO to mailbox mode.
>=20
> Is it really always true? In the case of imx6 can we still remain in
> mailbox mode
> and enable / disable RTR reception through Remote Request Storing (CTRL2
> [RRS]) bit?
>=20
> > What about "rtr-rx" or "rx-rtr"?
>=20
> I prefer "rx-rtr"

Ok, I'll change the patch. Can you write send a doc RFC patch. Place it
in the path mentioned above, please use rst format.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ty3jegmrw4f65u6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHWylQACgkQqclaivrt
76n6BwgAiWpeqUuSS4ENTLhrgEcj1qw6ivhw8zk58c0yruuVO6udRRHqVLtg43DS
q7Ct9uL+7Npz7nhNp6zAA4H9ANvWTU4Fe+PL1GkL2thOJfzx9A9pWZ8tHJgec6p8
Fsey0/BCgA/qi3gOfDWH4ZdgQW6FjmXwt4ZRahdaXVcQ3Q+ohaCLSwbMEhaqmzHC
M3tmujDzaGKX0vNH1W6ePW5NqJPDDhqm7975q3p+jyIYvBoUsnR22zoVZqkqH0b7
WH1oLdpfHXI6ajcdEcX/6nYlMnkzRKxBj+Ogv4aFBpHziJls6FkH/kBWQp7hqg2y
3l0LcrIuI+/LptUZXkPTqWUPt1YiWg==
=oOZn
-----END PGP SIGNATURE-----

--ty3jegmrw4f65u6z--
