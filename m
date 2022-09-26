Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCECE5E9C44
	for <lists+linux-can@lfdr.de>; Mon, 26 Sep 2022 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiIZIot (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Sep 2022 04:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiIZIor (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Sep 2022 04:44:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D4A1A9
        for <linux-can@vger.kernel.org>; Mon, 26 Sep 2022 01:44:44 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ocjjE-0005HA-Sq; Mon, 26 Sep 2022 10:44:40 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6FE11ED016;
        Mon, 26 Sep 2022 08:25:29 +0000 (UTC)
Date:   Mon, 26 Sep 2022 10:25:26 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jacob Kroon <jacob.kroon@gmail.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Dario Binacchi <dariobin@libero.it>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC can-next] can: remove obsolete PCH CAN driver
Message-ID: <20220926082526.ofoderi7wrpyolff@pengutronix.de>
References: <20220924174424.86541-1-socketcan@hartkopp.net>
 <f9b37775-edd5-2a5b-18bc-b34bb69b8324@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ktbtpscelfhcazlu"
Content-Disposition: inline
In-Reply-To: <f9b37775-edd5-2a5b-18bc-b34bb69b8324@gmail.com>
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


--ktbtpscelfhcazlu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.09.2022 22:24:07, Jacob Kroon wrote:
> On 9/24/22 19:44, Oliver Hartkopp wrote:
> > The PCH CAN driver is a driver for a Bosch C_CAN controller IP core whi=
ch
> > is attached to the system via PCI. This code has been introduced in 2011
> > by Oki Semiconductors developers to support the Intel Atom E6xx series
> > I/O Hub (aka EG20T IOH PCH CAN). Since 2012 the driver only has been
> > maintained by the kernel community.
> >=20
> > As there is a well maintained and continously tested C_CAN/D_CAN driver
> > which also supports the PCI configuration from the PCH CAN EG20T setup
> > this driver became obsolete.
> >=20
> > Cc: Jacob Kroon <jacob.kroon@gmail.com>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: Dario Binacchi <dariobin@libero.it>
> > Cc: Wolfgang Grandegger <wg@grandegger.com>
> > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > ---
> >   drivers/net/can/Kconfig       |    8 -
> >   drivers/net/can/Makefile      |    1 -
> >   drivers/net/can/c_can/Kconfig |    3 +-
> >   drivers/net/can/pch_can.c     | 1249 ---------------------------------
> >   4 files changed, 2 insertions(+), 1259 deletions(-)
> >   delete mode 100644 drivers/net/can/pch_can.c
> >=20
>=20
> Given that the current PCH driver will lockup on my system I'm all for
> removing it.

Should I add your Acked-by?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ktbtpscelfhcazlu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMxYfMACgkQrX5LkNig
0138jQf/dk7aqtnKsNRVcyopHgarIPT65+LPJuo8Xog7EK0pl62WXlN64R1Nn4bt
pXmYnq5Djq8iMPy/lh2rcDhzcwqJ5UayxoHCrP5b5T8KQB3YWgZWlNqFstT7xvnQ
bPBn3okrny4rHkLyxdkToQhaTEaocqEqf+o/l5betxI4rQ+2Xnh2JzKyLoPzfolm
f4UYBeIWLDwwTV0HNhjRD2S9HXaVBzKq9pJqyg6sEX02bzQVGTw4qMW1uqqcma/9
8fsUDnQQBmdKgUagebEFJ5nJRYAiCCqdznXK9o24ehgbMqBE8rcnx2eGEusBFrVa
szjgoYjKUcaukX7Vq+60wJnIAPclwQ==
=WXOz
-----END PGP SIGNATURE-----

--ktbtpscelfhcazlu--
