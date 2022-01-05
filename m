Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2321848500D
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 10:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbiAEJbJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 04:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiAEJbH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 04:31:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DB6C061761
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 01:31:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n52dN-0000Bs-4a; Wed, 05 Jan 2022 10:31:05 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-7899-4998-133d-b4b9.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:7899:4998:133d:b4b9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 52FD76D17DA;
        Wed,  5 Jan 2022 09:31:03 +0000 (UTC)
Date:   Wed, 5 Jan 2022 10:31:02 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v2 1/3] can: flexcan: change RX-FIFO feature at runtime
Message-ID: <20220105093102.ixzcsrr3doolocz4@pengutronix.de>
References: <20220104154133.848784-1-mkl@pengutronix.de>
 <CABGWkvo+h2CASM7q8z3UXRofrY7enVXS6njFKnKyqRUjgkbB_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7kb3epazg3e5ym2i"
Content-Disposition: inline
In-Reply-To: <CABGWkvo+h2CASM7q8z3UXRofrY7enVXS6njFKnKyqRUjgkbB_A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7kb3epazg3e5ym2i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.01.2022 09:25:35, Dario Binacchi wrote:
> > Is the name "rx-fifo" acceptable? Can you think of a better name?
>=20
> If I am not mistaken this series arises from the need to deactivate
> the RxFIFO only if it is acceptable not to receive the notification of
> RTR messages. I wonder if this can be made explicit to the user.
>=20
> Do you think it makes sense to explicitly RTR ("rtr-notify") instead
> of RxFIFO (rx-fifo) ?
>=20
> And if it makes sense to make it clear that it occurs at the expense
> of a smaller number of messages allocated for reception?
>=20
> >
> > What about adding a new quirk to the driver, only if that quirk is
> > that, it is allowed to change between rx-fifo and rx-mailbox mode?
> >
>=20
> What platforms are you thinking of for this type of quirk to add?

Add this quirk for all platforms that currently don't use
FLEXCAN_QUIRK_USE_OFF_TIMESTAMP.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7kb3epazg3e5ym2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHVZVMACgkQqclaivrt
76mbVAgAkek0ii6J9stp+DkRtttCVJRXZnIjTaKmeB2qpaQesVHmGBZbMb8mzu+4
DIMjSP2o9uENgDgOGzVSeUu+V2yadncDVaRNYd3DTMX7biS5iPXWxRxxZy23dX00
GjAqOIBJTPs1kAAHHGnXijDzh5oqkM1bFncxP5Opy2PiyFMCw2LYBkefxEJwqsxi
pu6QfT6OAzaokFaFojdehqzHPghLteMHvSd+LJDw1Bn7rRT604tKix1rC7fGhaO2
6Xra9HmK2nyQP/pSVcRTXbI0jnbcKekx4+XC6nJRrPpJnWx7lknqFtBA5eQUluu8
XyLcuaBX6AhMOIghL/rzhxGjhlPYRA==
=Qo6H
-----END PGP SIGNATURE-----

--7kb3epazg3e5ym2i--
