Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2403C32C5A5
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 02:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbhCDAX6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbhCCNMX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 08:12:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5294C061788
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 05:11:25 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHRHg-0008PM-Gk; Wed, 03 Mar 2021 14:11:24 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a20d:2fb6:f2cb:982e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BAE7D5ECC1C;
        Wed,  3 Mar 2021 13:11:23 +0000 (UTC)
Date:   Wed, 3 Mar 2021 14:11:22 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: m_can: m_can_rx_handler(): fix RX in periphs being
 blocked by error handling
Message-ID: <20210303131122.nem3z2iq4ts3iirj@pengutronix.de>
References: <20210303124950.3917746-1-torin@maxiluxsystems.com>
 <20210303125523.4tfd6ifwyugoygzh@pengutronix.de>
 <20210303130750.y2leqimmthzn2liy@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ppb3kpalxj6x5kto"
Content-Disposition: inline
In-Reply-To: <20210303130750.y2leqimmthzn2liy@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ppb3kpalxj6x5kto
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.03.2021 13:07:50, Torin Cooper-Bennun wrote:
> On Wed, Mar 03, 2021 at 01:55:23PM +0100, Marc Kleine-Budde wrote:
> > > In peripherals, m_can_rx_handler is called with quota =3D 1 from an I=
SR
> > > context.
> >=20
> > To be precise, it's a threaded Interrupt. Why not call the rx_handler
> > with a reasonable quota instead?
>=20
> I see, thanks. Forgive my ignorance, but how long should a threaded ISR
> reasonably block for?

It's a IRQ thread, so it's subject to scheduling and priorities can be
configured. The IRQ thread of the mcp251xfd driver runs until all IRQs
are handled.

> Was there ever a good reason for the quota to be 1 here?

Don't know.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ppb3kpalxj6x5kto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA/ivgACgkQqclaivrt
76m28Af/R7awfbIhphTghJQtqavF9x0MZ30vo0Da0bIqAskTPFwxLuG4zHkDyfuZ
pu2x+Lpp5Ywv7TsTOcglx7VN6WXjob0gfI1wyaENTT9rWNaZSIQ/4wCNFLOOuolA
mM9koYLKkc6+hHMa38N3f9k83IWvI4G0X+AuELIbCnYwtsq0h1c3kxhAqAYzQHFR
6fWcBcBeFpzNoJXhyTmAkb/lQX+4dbktFNoPOFVft8NUMTz8Pr+y9mN77zcjkRg3
OTT6Uu4UJ2BFjk0V4FQ0R67A+z1EAgvfzCj7a+D2j64ifcLPlS8CbtGrwyWEaP6l
tx7DC2aM3doph5D5Zd1AnZu61EbHpg==
=W+d3
-----END PGP SIGNATURE-----

--ppb3kpalxj6x5kto--
