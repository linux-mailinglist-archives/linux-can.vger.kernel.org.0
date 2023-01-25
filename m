Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A46B67B224
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 13:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjAYMBj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 07:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAYMBj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 07:01:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388040F0
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 04:01:34 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pKeT7-0006xn-5l; Wed, 25 Jan 2023 13:01:33 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6554:ecba:20de:b047])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7E6171636ED;
        Wed, 25 Jan 2023 12:01:32 +0000 (UTC)
Date:   Wed, 25 Jan 2023 13:01:24 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: mcp251xfd diagnostic outputs
Message-ID: <20230125120124.yfqwnvg72uk5rbvv@pengutronix.de>
References: <FR0P281MB1966B647014B87F9EA96E77197C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yemop2u3xsuppu73"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966B647014B87F9EA96E77197C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--yemop2u3xsuppu73
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.01.2023 11:13:18, Stefan Alth=C3=B6fer wrote:
> the driver logs this kind of annoying messages:
>     Jan 14 04:10:48 raspberrypi kernel: [54876.751957] mcp251xfd spi6.0 c=
an1: CRC read error at address 0x0010 (length=3D4, data=3D00 4b 01 00, CRC=
=3D0xe146) retrying.
>=20
> Unless DEBUG is active, I don't think that it is justified to print every=
 single=20
> SPI CRC issue in detail to the logs:
> - The errors are due to chip errata
> - You cannot deduct that you have software/hardware issue from those erro=
rs
> - As you do not know how the data should have been, you cant do
>   diagnostic (single-bit vs multi-bit errors or the like)
>=20
> So far I have only seen these errors for access to register 0x0010 and=20
> rarely for 0x0000, probably because those registers have dynamic content.

ACK

> Nevertheless, diagnostic for SPI CRC errors might still be useful. I
> suggest to add driver proprietary static counters in /sys for that:
>
>     .../can0/spi_crc_dynamic_data       (for 0x000, 0x0010)   to avoid th=
e word "expected"
>     .../can0/spi_crc_static_data        (for all others)

The networking stack has a proper interface for network interface
statistics, better make use of these.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--yemop2u3xsuppu73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPRGhEACgkQrX5LkNig
013rSQf/ZBOzIxExxUHLLz+DkykePb5WV0NJ9L/o9XRB0uATf3Ui2OER/OxDbrOv
vnphCL3MpPTQADGaKZiwj3R83HNL/UarP1PA1G+jS7DCPSk/gTWuxTAJr0TM6NcX
wlV8GoAKNGmprzXsZG4SQxNGBjwDv7xtiDatXHSoPJDGLpD7IJv9D/1IkxRPBZ3Z
dq6eCNLRkDztUlIpmz1hHjuV9kgobsMhkEBpwOPL1/ngs5eHd9dX2cWlaH3CFp2k
MlvfHapNqFWMbUfazjpsVDI/tN4G3d6IbDS4cjJKfeUAtiGnc/HI3n6nOF+nV7kC
w1iXD0yJ/18+Xr3zykuwPnNqaqwfUg==
=bB/7
-----END PGP SIGNATURE-----

--yemop2u3xsuppu73--
