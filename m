Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4767B7E0
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjAYRHG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 12:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbjAYRHD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 12:07:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4B5AB74
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 09:06:37 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pKjEI-0003da-Oh; Wed, 25 Jan 2023 18:06:34 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6554:ecba:20de:b047])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B8B63163B70;
        Wed, 25 Jan 2023 17:06:33 +0000 (UTC)
Date:   Wed, 25 Jan 2023 18:06:25 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: AW: RE: mcp251xfd: rx frame truncation (1/2)
Message-ID: <20230125170625.sudokyujzf3slmas@pengutronix.de>
References: <BL3PR11MB64842584529FAEF279F7B137FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669083201C1B9C2DFB9E5497C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB196633E4F8E1195086E2402B97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB648434F2B7DE7F75E291E159FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230119133214.ofapvfc2rzi3gvn4@pengutronix.de>
 <FR0P281MB1966B0AD5BD74FA1AE550F2797C59@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230120215547.ewa5npqsxf5jxjcr@pengutronix.de>
 <BL3PR11MB64841AD10C3CFBC21A2A16FFFBC59@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669C3FDDBE07D6B320C18997CA9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966E1E84C055E268432571197CE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="isyv3to6diemw325"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966E1E84C055E268432571197CE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--isyv3to6diemw325
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.01.2023 16:23:27, Stefan Alth=C3=B6fer wrote:
> I dont know if this is still of interest:
>=20
> As it seemed that all my truncation errors appeared for DLEN=3D64 packets=
, I
> Limited to DLEN=3D32.

Changing the transmitted length influences the timing on the sending
code path, it's the same on the RX path.

> After 38 h I got an "increase error". Seems logical that this can happen =
if the DLEN is read wrong.
>=20
> 1: idx    8 exp:2A5#00 08 27 05 A8 9F 48 02 94 30 F4 DA AD 3D 0C 53 8C 7F=
 91 7E 53 84 9B EB
> 1:           rx:2A5#00 08 27 05 A8 9F 48 02 94 30 F4 DA AD 3D 0C 53 8C 7F=
 91 7E 53 84 9B EB C7 1D 92 24 D1 B4 72 29

It looks like the new data (including the timestamp) has already been
written, but the DLC is not yet updated.

> Now the interesting part:
>=20
> 1: RX72 (010/009)  2A5#00 09 D2 91 35 52 03 A5 41 DA 2A 68 DF D3 07 27 D5=
 9B 57 C9 76 04 06 82
> 1: RX72 (010/008)  2A5#00 08 27 05 A8 9F 48 02 94 30 F4 DA AD 3D 0C 53 8C=
 7F 91 7E 53 84 9B EB C7 1D 92 24 D1 B4 72 29    ********
> 1: RX72 (010/007)  2A5#00 07 7F 72 70 EF D7 85
> 1: RX72 (010/006)  2A5#00 06 E7 F2 46 7D 49 32 A6 4E 72 3D F2 D4 F3 1D 98=
 4E F5 4A
> 1: RX72 (010/005)  2A5#00 05 6F 65 15 38 2E 23 78 43 59 F5
> 1: RX72 (009/004)  2A5#00 04 95 57 EC 29 05 40 97 A3 62 B5 2B C3 5B D8 B2=
 31 7C 26
> 1: RX72 (008/003)  2A5#00 03 1E 88 61 A6 AC EE D5 A4 74 3E E8 EF C8 C9 0E=
 40 15 36 7D A4 98 50
> 1: RX72 (005/002)  2A5#00 02 E9 40 87 24 8D 2F F8 85 69 44 7B 8A E0 1F 77=
 4C 27 3D 8E 62 D3 F1 BF 9B 94 AD 54 6D 9E 21
> 1: RX72 (004/001)  2A5#00 01 63 5C C8 A2 EE B9 D9 F1 CD B1
> 1: RX72 (004/000)  2A5#00 00 F8 39 4C F5 21 9C A4 ED 6C 08 C6 42 3B 95
> 1: RX72 (010/009)  2A5#00 09 B2 54 EC AB 1B 3A A0 D9 01 AD BB 3E 12 2F ED=
 B7 50 41 C1 9F 31 76
> 1: RX72 (010/008)  2A5#00 08 0C E2 3D 65 74 AF A4 21 53 0A 4E F0 B5 8D AB=
 75 91 F5 73 AE A4 BC
> 1: RX72 (010/007)  2A5#00 07 F8 C7 4D F5 BE C7
> 1: RX72 (010/006)  2A5#00 06 AD A4 66 2D 9D AA 3E BA C0 04 4A FE 1D AF 48=
 04 AF 30
> 1: RX72 (010/005)  2A5#00 05 FD F7 79 17 24 76 59 92 72 3F
> 1: RX72 (010/004)  2A5#00 04 7F F9 44 11 1D 15 C6 90 3E 18 64 4A E7 00 E8=
 F4 17 1D
> 1: RX72 (009/003)  2A5#00 03 52 D4 0B CE 9C 9E 0D 17 35 08 DF 5C 1A 2D FC=
 42 6E FC E6 1B 31 27
> 1: RX72 (006/002)  2A5#00 02 62 E2 7C C7 92 3F 7B 97 FB C8 27 11 4D A0 28=
 41 00 A4 AD 35 41 64 C7 1D 92 24 D1 B4 72 29   *********
> 1: RX72 (005/001)  2A5#00 01 B6 92 DC 2E 5D B3 22 4E 58 9E
> 1: RX72 (004/000)  2A5#00 00 04 BC 4D 90 16 85 78 16 F3 60 7C 6C 35 9D
> 1: RX72 (010/009)  2A5#00 09 9E 6A E2 7E 4F 81 1F BE AD 84 15 E5 50 D1 80=
 03 3A 46 63 85 F2 CB
> 1: RX72 (010/008)  2A5#00 08 65 56 38 CC BC 9B B2 69 C5 60 4B AC 68 94 C7=
 97 5D EA 3A 92 BA EF
> 1: RX72 (010/007)  2A5#00 07 E0 E5 9E A0 6F 2C
> 1: RX72 (010/006)  2A5#00 06 AC 2A AD E2 E6 08 49 1B 2E C8 23 A3 35 D0 B5=
 0C B0 F3
>=20
> The on-top data has been received before (see marked lines). However
> at a queue length of 20 (according to ethtool) I would not have
> expected that the distance to this frame Would be 16, but 20. Doesn't
> the chip/driver use the queue elements one-by-one?

The driver uses internally power-of-two sized FIFOs: FIFO 1 with depth
of 16 and FIFO 2 with depth of 4. So this looks correct.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--isyv3to6diemw325
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPRYYwACgkQrX5LkNig
010Z6gf/V730FahR//khcNUeW6/jKlTCT5k3QYu/vlewkdVDURtcMHURwkE/AI9W
Maho3sieiVDjPGj8SAsaIZy47LmN2HZ3yh8p4cuYlVMJlO7ZaAtet0nsI/1G/1BZ
weAbY0MopI3UTSCZJbTnHBy9mJ6R/22dLKptsoLwDSiOWFqpX2f3qKnVgwk1PlDW
CFVeHBAin1TJ32Khw9hrdo8tI2jyi2BEeLJ6/c4E0BxQ7lm9rXgdFhGk5Itn/jFt
QmUM9dMTTU5aPBbW65Kw39fkgpxnsckkEZ4/o8a8tV1NI3GiB/DgWINlF7WByQBD
7NYvBPtbzCqOja73RitBlcgPGdeHpQ==
=xbqD
-----END PGP SIGNATURE-----

--isyv3to6diemw325--
