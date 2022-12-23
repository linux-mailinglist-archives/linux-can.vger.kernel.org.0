Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB886553D9
	for <lists+linux-can@lfdr.de>; Fri, 23 Dec 2022 20:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiLWTZi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 23 Dec 2022 14:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiLWTZh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Dec 2022 14:25:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ED51FCD2
        for <linux-can@vger.kernel.org>; Fri, 23 Dec 2022 11:25:36 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p8nfi-0003XN-1H; Fri, 23 Dec 2022 20:25:34 +0100
Received: from pengutronix.de (unknown [IPv6:2a00:20:7010:6fd1:249a:8e73:9248:c0bb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 519451460BE;
        Fri, 23 Dec 2022 19:25:32 +0000 (UTC)
Date:   Fri, 23 Dec 2022 20:25:30 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: AW: mcp251xfd: Bad message receiption
Message-ID: <20221223192530.la2ic2nsmhf257bc@pengutronix.de>
References: <FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <PH7PR11MB6498DA4A162106BD4ACB7551FBE89@PH7PR11MB6498.namprd11.prod.outlook.com>
 <FR0P281MB1966CA0C12ED24574368A36E97E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20221222130219.xrfnm54g6lfjozvs@pengutronix.de>
 <FR0P281MB19666A63278AAA9D20B6989297E99@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kkprmd6ygciebwq4"
Content-Disposition: inline
In-Reply-To: <FR0P281MB19666A63278AAA9D20B6989297E99@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--kkprmd6ygciebwq4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.12.2022 08:18:17, Stefan Alth=C3=B6fer wrote:
> > Why do you have so many errors on can1? The device event went into bus-=
off.
>=20
> The device was not freshly started, and I just intended to share the
> setup. No errors when the problem appeared this night.

Ok

> > Can you share your "scselftest" program?
>=20
> Sure, attached as extracted from the build system for my test tools.
> Hope this is not the bad guy. Included my ancient copy of
> libsocketcan.

> > Do you get the same error if the test is only running on a single
> > mcp2518fd?
>=20
> I'm pretty sure I had cases where I started the test on both, one
> failed sooner and one failed later. However, currently the second test
> is still running (after 9h).

I want to know if there's an influence between the 2 interfaces.

> > Do you get the same error if only a single mcp2518fd is attached to the=
 raspi?
>=20
> Only tested this with the CM4

Would be interesting if you only attache 1 mcp2518fd to the board and
then re-run the test.

> > Can you share your kernel, including the modifications?
>=20
> Yes if it turns out to be necessary, but I just cloned it from here:
> git clone --depth=3D1 --branch <branch>
> https://github.com/raspberrypi/linux

You said you made some modifications to the kernel, also it would be
good to use the _extact_ version you using to reproduce the error.

> Following these instructions: https://www.raspberrypi.com/documentation/c=
omputers/linux_kernel.html#kernel-headers

> Now this nights error log:

Thanks for the text, much easier to handle. :)

> Loop 4429 2022-12-23T03:07:45 last+4s total:4h299m
> + ./sctestself -b -n 4 -l 999 -t 2 -v cmperr,logmsg -F refilldata,leastdo=
ts,allowintloopb,stoponerror -d 8 can1
> CAN selftest can1 .......idx    2 tx:2A5#00 02 6A 8F 6C 81 C3 B0
>          rx:2A5#00 00 85 9A EF 54 34 5D
> idx    3 tx:2A5#00 03 4F 8F 85 59 8E DA
>          rx:2A5#00 00 85 9A EF 54 34 5D
> .c (700) fail
> 0: RX (004/003)  2A5#00 00 85 9A EF 54 34 5D
> 0: RX (004/002)  2A5#00 00 85 9A EF 54 34 5D

2 bad RX here

> 0: TX (003/002)  2A5#00 03 4F 8F 85 59 8E DA
> 0: RX (003/001)  2A5#00 01 7C 30 5C 7A 2D 1C
> 0: TX (002/001)  2A5#00 02 6A 8F 6C 81 C3 B0
> 0: RX (002/000)  2A5#00 00 AC AF 70 9B 32 03
> 0: TX (001/000)  2A5#00 01 7C 30 5C 7A 2D 1C
> 0: TX (000/000)  2A5#00 00 AC AF 70 9B 32 03
> 0: RX (004/003)  2A5#00 03 65 32 F8 E7 E6 F5
> 0: RX (004/002)  2A5#00 02 CC D5 09 FE 55 99
> 0: TX (003/002)  2A5#00 03 65 32 F8 E7 E6 F5
> 0: RX (003/001)  2A5#00 01 62 4F 17 34 44 CE
> 0: TX (002/001)  2A5#00 02 CC D5 09 FE 55 99
> 0: RX (002/000)  2A5#00 00 FE 58 FE FD C0 EF
> 0: TX (001/000)  2A5#00 01 62 4F 17 34 44 CE
> 0: TX (000/000)  2A5#00 00 FE 58 FE FD C0 EF
> 0: RX (004/003)  2A5#00 03 C9 7B EF 83 93 E0
> 0: RX (004/002)  2A5#00 02 DD 5E 82 B4 FD C4
> 0: TX (003/002)  2A5#00 03 C9 7B EF 83 93 E0
> 0: RX (003/001)  2A5#00 01 90 3B 32 80 90 67
> 0: TX (002/001)  2A5#00 02 DD 5E 82 B4 FD C4
> 0: RX (002/000)  2A5#00 00 8F 28 D2 F5 B6 98
> 0: TX (001/000)  2A5#00 01 90 3B 32 80 90 67
> 0: TX (000/000)  2A5#00 00 8F 28 D2 F5 B6 98
> 0: RX (004/003)  2A5#00 03 C5 1E FE 68 F1 65
> 0: RX (004/002)  2A5#00 02 7E 2B BA 18 F1 7B
> 0: TX (003/002)  2A5#00 03 C5 1E FE 68 F1 65
> 0: RX (003/001)  2A5#00 01 CE 1B D7 9E 42 15
> 0: TX (002/001)  2A5#00 02 7E 2B BA 18 F1 7B

> 0: RX (002/000)  2A5#00 00 85 9A EF 54 34 5D

properly received

> 0: TX (001/000)  2A5#00 01 CE 1B D7 9E 42 15

> 0: TX (000/000)  2A5#00 00 85 9A EF 54 34 5D

send

> 0: RX (004/003)  2A5#00 03 37 6D 66 8E C6 9B
> 0: RX (004/002)  2A5#00 02 2D 83 A3 D3 66 27
> 0: TX (003/002)  2A5#00 03 37 6D 66 8E C6 9B
> 0: RX (003/001)  2A5#00 01 E8 A5 9A C6 C1 AC
> 0: TX (002/001)  2A5#00 02 2D 83 A3 D3 66 27
> 0: RX (002/000)  2A5#00 00 E6 7A D0 27 3E DF
> 0: TX (001/000)  2A5#00 01 E8 A5 9A C6 C1 AC
> 0: TX (000/000)  2A5#00 00 E6 7A D0 27 3E DF
> 0: RX (004/003)  2A5#00 03 D4 54 CF 9A 6D 7A
> 0: RX (004/002)  2A5#00 02 06 3F 57 59 35 F6
> 0: TX (003/002)  2A5#00 03 D4 54 CF 9A 6D 7A
> 0: RX (003/001)  2A5#00 01 C1 F6 A6 E3 84 64
> 0: TX (002/001)  2A5#00 02 06 3F 57 59 35 F6
> Stopped. Ctrl-C to exit.
>=20
> And the register dump

[...]

> mcp251xfd-dump did not work for me, but It looks as if the correct data i=
s in the rx fifo.

With v5.18 the RAM layout changed, the mcp251xfd-dump tool was not
adopted. yet.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kkprmd6ygciebwq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOmAKcACgkQrX5LkNig
0139mgf/SVmb7oTNvs87MLX6UsBqyDi5YO4XLBf14zDPAno7Lo+Q+ugTy/PBZcey
TYNVooEyvizm29WD1gK4p/HFNCmpnA9JFJtp8q0JEf+fLqDihEoJhAvzj/eEuDdO
mOpmhY++vCyV5Oc3MIU3x4rKTJFHYMrSc6etDg8P5unHGBvkyWl++9cJ9qSyF/qy
RPPmNuIVuNzEBgS7ce21GBlqBGAgLTst6ldIqeyD6pMyQM9dDWkabUug4f3ywt2X
rgMo4kh8NSdzrHDX3Msr7eSiYZVc7yyzOYbFomoZg+kik0NVTNtZ4wyNlhMuviXY
r8Qku44+vpZOlVXZUuFCxWRWMx+EGA==
=3axi
-----END PGP SIGNATURE-----

--kkprmd6ygciebwq4--
