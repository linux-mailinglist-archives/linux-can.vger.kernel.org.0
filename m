Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC7666634
	for <lists+linux-can@lfdr.de>; Wed, 11 Jan 2023 23:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjAKWaV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Jan 2023 17:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbjAKWaT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2023 17:30:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E612C76
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2023 14:30:18 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pFjbq-0004je-1Z; Wed, 11 Jan 2023 23:30:14 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a7f:f128:20cb:2cef])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 43295154CC5;
        Wed, 11 Jan 2023 22:30:13 +0000 (UTC)
Date:   Wed, 11 Jan 2023 23:30:04 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Message-ID: <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sy7sdxxha5aszu5q"
Content-Disposition: inline
In-Reply-To: <20230111222042.1139027-1-mkl@pengutronix.de>
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


--sy7sdxxha5aszu5q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.01.2023 23:20:37, Marc Kleine-Budde wrote:
> this is a proof of concept implementation to work around the
> "double-RX" erratum found by Stefan Alth=C3=B6fer.
>=20
> With the help of Thomas we found out that the chip has a time window
> after receiving a CAN frame where the RX FIFO STA register content is
> not read correctly.
>=20
> From the driver's point of view, everything looks consistent at first,
> but the head index of the chip is too large. This causes the driver to
> rehandle old CAN frames that have already been processed.
>=20
> The workaround uses the RX timestamp to distinguish between new and
> old data. As soon as old data is found, processing is stopped.
>=20
> The series applies against current net/main. The patches lack proper
> descriptions, I'll add them in the next round.
>=20
> Happy testing,
> Marc
>=20
> Link: https://lore.kernel.org/all/FR0P281MB1966273C216630B120ABB6E197E89@=
FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM

If you add a "#define DEBUG" before any #includes in mcp251xfd-rc.c
you'll get a debug message like this if the workaround triggers:

| Jan 11 22:53:10 riot kernel: mcp251xfd spi1.0 mcp251xfd0: mcp251xfd_handl=
e_rxif_one: last_valid=3D0x17395fba3d56bb9c ts=3D0x17395fba3d08ee9e d=3D0xf=
fffffffffb23302 data=3D00 02 80 fa 24 cc 43 41 - Dropping

You can also have a look at the interface statistics. The "RX errors:
fifo" is incremented if the workaround triggers.

| $ ip --details -s -s link show mcp251xfd0
| 5: mcp251xfd0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP =
mode DEFAULT group default qlen 10
|     link/can  promiscuity 0 minmtu 0 maxmtu 0=20
|     can <LOOPBACK,BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx =
0 rx 0) restart-ms 1000=20
|           bitrate 1000000 sample-point 0.750
|           tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 1 brp 1
|           mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_=
inc 1
|           dbitrate 4000000 dsample-point 0.700
|           dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
|           mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbr=
p_inc 1
|           clock 40000000=20
|           re-started bus-errors arbit-lost error-warn error-pass bus-off
|           0          0          0          0          0          0       =
  numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 parentb=
us spi parentdev spi1.0=20
|     RX:  bytes packets errors dropped  missed   mcast          =20
|      190713920 9871978      0       0       0       0=20
|     RX errors:  length    crc   frame    fifo overrun          =20
|                      0      0       0       1       0
                                           ^^^^
|     TX:  bytes packets errors dropped carrier collsns          =20
|       95356960 4935989      0       0       0       0=20
|     TX errors: aborted   fifo  window heartbt transns
|                      0      0       0       0       1=20

Note: Certain Out-of-Memory situations also increase the fifo error
counter, but I think you'll get a nice OOM error message from the
kernel, too.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--sy7sdxxha5aszu5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmO/OGkACgkQrX5LkNig
011fLgf/Sh/oKZwTMYHzK/ivbXZjGhgpisWDxYvqyvxlR4rMvQktppgFy5+qYjEI
OtWPSYJ6uqepcQzbTymgThPv8WDBhhywM4YlrV2FYrhSPNZy9D1rRpawA8RTV60x
Vgg2xozBuQz9A2p6tJ0E19RPjMAjZ73JmdxJzT2yP07bfldKng6/O9OYESh1lTzr
IvdPtph2ApzI3zcFhyLKEA/0fS5h01ER21qwcjizo/9fEupXWquIM8J1TvDKZpo9
z4nbajy0i/IsL2M/FsWLeXqcgZjnGOF22qbYLOEv5ryrG482af106Qy+xwZAcTKv
JcfkvqfONf1z5h457ShTa198pOvLKg==
=vtWA
-----END PGP SIGNATURE-----

--sy7sdxxha5aszu5q--
