Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A20666BDC
	for <lists+linux-can@lfdr.de>; Thu, 12 Jan 2023 08:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjALHzG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Jan 2023 02:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbjALHzD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Jan 2023 02:55:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12FB43A2C
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2023 23:55:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pFsQH-0007KP-8f; Thu, 12 Jan 2023 08:54:53 +0100
Received: from pengutronix.de (hardanger-3.fritz.box [IPv6:2a03:f580:87bc:d400:9cb:a401:da4a:2786])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 483EA1550A5;
        Thu, 12 Jan 2023 07:54:52 +0000 (UTC)
Date:   Thu, 12 Jan 2023 08:54:52 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Message-ID: <20230112075452.4v3ba2hibxx3i5rm@pengutronix.de>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tyngm3a5cm32kdeb"
Content-Disposition: inline
In-Reply-To: <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
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


--tyngm3a5cm32kdeb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.01.2023 23:30:04, Marc Kleine-Budde wrote:
> On 11.01.2023 23:20:37, Marc Kleine-Budde wrote:
> > this is a proof of concept implementation to work around the
> > "double-RX" erratum found by Stefan Alth=C3=B6fer.
> >=20
> > With the help of Thomas we found out that the chip has a time window
> > after receiving a CAN frame where the RX FIFO STA register content is
> > not read correctly.
> >=20
> > From the driver's point of view, everything looks consistent at first,
> > but the head index of the chip is too large. This causes the driver to
> > rehandle old CAN frames that have already been processed.
> >=20
> > The workaround uses the RX timestamp to distinguish between new and
> > old data. As soon as old data is found, processing is stopped.
> >=20
> > The series applies against current net/main. The patches lack proper
> > descriptions, I'll add them in the next round.
> >=20
> > Happy testing,
> > Marc
> >=20
> > Link: https://lore.kernel.org/all/FR0P281MB1966273C216630B120ABB6E197E8=
9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM
>=20
> If you add a "#define DEBUG" before any #includes in mcp251xfd-rc.c
> you'll get a debug message like this if the workaround triggers:
>=20
> | Jan 11 22:53:10 riot kernel: mcp251xfd spi1.0 mcp251xfd0: mcp251xfd_han=
dle_rxif_one: last_valid=3D0x17395fba3d56bb9c ts=3D0x17395fba3d08ee9e d=3D0=
xffffffffffb23302 data=3D00 02 80 fa 24 cc 43 41 - Dropping

In my over night test the workaround triggered 31 times. The test has
found no problems.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tyngm3a5cm32kdeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmO/vMkACgkQrX5LkNig
013jEQf+Mxkocu61pt2PnxOrKAMY23M8/UAcqv3G6hHKBdU0Y+V42BWle7S4pcdl
6s5P3t+Vw9cD5uz0nEnCXRoyowh4s91iiYvbdOPuJJxB+8wSp3MqmvPGNAhpmHTk
p8w0stpidLamXnnRoq6ixNZs78zCbzeHTBNVqeIBZKaXKmB74DJ9ZanU3dhPrPj2
Bmt+9pmEwww2wxETDStpN7YO2GE1D6OSjF4EpSdVYOfzlWEHGj6OhONNMI9v2hSy
6PXnKFEKZ4zkTdx68qjIUmukcfJ5TNwg8Bj+1MwhJZa2SOOonTN2WIPL+/CCs7On
/k7o9NhOWsri+ri+R8mQ4Eb9Vavtng==
=dQQ6
-----END PGP SIGNATURE-----

--tyngm3a5cm32kdeb--
