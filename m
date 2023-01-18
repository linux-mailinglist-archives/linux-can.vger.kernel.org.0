Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE9671BCE
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 13:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjARMTE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 07:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjARMRA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 07:17:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8A14ED19
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 03:39:50 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pI6nF-0002FJ-5y; Wed, 18 Jan 2023 12:39:49 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:37eb:cfb:76e3:a0a7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7810015AAB8;
        Wed, 18 Jan 2023 11:39:48 +0000 (UTC)
Date:   Wed, 18 Jan 2023 12:39:39 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: mcp251xfd: rx frame truncation
Message-ID: <20230118113939.fezj2bfbb4vt32uq@pengutronix.de>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jrlfhlvyrogsv6w7"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--jrlfhlvyrogsv6w7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.01.2023 11:26:31, Stefan Alth=C3=B6fer wrote:
> While still testing the double-RX erratum patch I'm experiencing another =
problem.
>=20
> I'm using my setup with two mcp2518fd and my own 'sctest' program. Both a=
re
> sending  messages to each other. I start sending a number of transmit ahe=
ad=20
> frames and then  send out one more messages when a frame arrives at the p=
eer.=20
> So  overrun should not occur.
>=20
> In contrast to the tests I did over the weekend, I increased the transmit=
=20
> ahead to 3, sending now up to 64 bytes and the frame size is now random.
>=20
> I now frequently see these kind of messages appear:
>=20
> Jan 18 05:34:00 raspberrypi kernel: [405471.116322] mcp251xfd spi0.0 can0=
: Transmit Event FIFO buffer not empty. (seq=3D0x00001e36, tef_tail=3D0x000=
01e3a, tef_head=3D0x00001e3b, tx_head=3D0x00001e3b).
> Jan 18 09:36:27 raspberrypi kernel: [420017.452369] mcp251xfd spi6.0 can1=
: Transmit Event FIFO buffer full. (seq=3D0x00001062, tef_tail=3D0x00001066=
, tef_head=3D0x00001067, tx_head=3D0x00001067).
>=20
> Why do they occur?

As I mentioned in the other mail, the erratum also affects the TX FIFO.

In tests with high TX load I have seen the message "buffer not empty" in
the past, but never the message "buffer full". With the "buffer not
empty" errors, I haven't seen any CAN frame drops or truncated messages,
but I've been testing mainly CAN-2.0.

I'll have to look at the TEF and TX handling with what I learned from
developing the RX FIFO workaround.

I'll look into your mail in detail later.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jrlfhlvyrogsv6w7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPH2nkACgkQrX5LkNig
011vsgf8D0pM46cWF7SKu0il1F18vsAnb/1l+g99+XigrREtqsEq9H2RhqPyMzt4
xMEHRwsml23SJqLEblACkLh03Xp/uHa9A4snHwDfA5rRLCtylbHzwf6I2iSlRC+b
f4wisFXGZNtk6+yJSBfuRwFt0jKtXJl6MnZM4Jy+Zgkz4qXesttR3Bq490on/Krw
g6X6l9B9rFGlJUJ/s0S/1IK5WytSwHSHZ3JMoD9w60bTgWpSoFtRTpiUETTPnT2x
SDVBezIVL/6lGC/mRa1bydslUlqeWMuQD6T/s6ixumCS8mLT4Rb6NhGhRYBbDKKP
AvaeLyKLOQpYseGJYc5LlyRgIMBB4w==
=cDdu
-----END PGP SIGNATURE-----

--jrlfhlvyrogsv6w7--
