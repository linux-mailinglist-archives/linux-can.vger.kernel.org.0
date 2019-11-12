Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACAB4F8AB5
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2019 09:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKLIiV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Nov 2019 03:38:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42585 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfKLIiV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2019 03:38:21 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iURgo-0001Ml-MF; Tue, 12 Nov 2019 09:38:18 +0100
Received: from [IPv6:2a03:f580:87bc:d400:fcf3:94db:a77f:e6a3] (unknown [IPv6:2a03:f580:87bc:d400:fcf3:94db:a77f:e6a3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4EA7147AC87;
        Tue, 12 Nov 2019 08:38:17 +0000 (UTC)
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "sean@geanix.com" <sean@geanix.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
 <DB7PR04MB4618061107733A9D53F75FA3E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: Wake up issue about Flexcan driver in v5.4 kernel
Message-ID: <a232c1f6-cd91-8526-6fc9-163e9500bdf9@pengutronix.de>
Date:   Tue, 12 Nov 2019 09:38:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB4618061107733A9D53F75FA3E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="y1aOsjEe0CJZBInf7d8Tzn0Whg8SHWSb8"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y1aOsjEe0CJZBInf7d8Tzn0Whg8SHWSb8
Content-Type: multipart/mixed; boundary="mFnuO6zz7bhlaH4PpjVlIPscsmHUkHjqv";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <a232c1f6-cd91-8526-6fc9-163e9500bdf9@pengutronix.de>
Subject: Re: Wake up issue about Flexcan driver in v5.4 kernel
References: <DB7PR04MB4618BF9DE9152B2F1D49A702E6740@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <bcbae072-3aec-34f7-9b7e-58d78000bd39@pengutronix.de>
 <DB7PR04MB4618061107733A9D53F75FA3E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4618061107733A9D53F75FA3E6770@DB7PR04MB4618.eurprd04.prod.outlook.com>

--mFnuO6zz7bhlaH4PpjVlIPscsmHUkHjqv
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/12/19 8:12 AM, Joakim Zhang wrote:
> I dump some info in wake up case from v5.3.10 with below change:
> printk("\nmailbox_num =3D %u, timestamp =3D %u, can_id =3D %x\n", n, *t=
imestamp, cf->can_id);

Keep in mind, a printk() compared to a trace_printk() will introduce
bigger latencies.

BTW: You might want to use the cangen option "-Ii", so that cangen will
not generate random, but incrementing CAN-ids.

> 1)
> Sender: cangen can0 -vv
>   can0  266   [8]  F2 2D C6 5F 0E FE DE 38
>   can0  71E   [8]  8A F0 C5 2F 9F 3C 72 32
>   can0  256   [2]  03 4B
>   can0  6FC   [8]  B1 46 D5 40 F6 C4 CC 1D
>   can0  21A   [2]  60 2C
>   can0  594   [2]  B1 5A
>   can0  162   [2]  CB 41
>   can0  6B0   [4]  CA 64 AB 70
>   can0  710   [8]  25 27 2F 11 2F 76 54 17
>   can0  50B   [8]  CE B2 C6 49 61 1F B9 3A
>=20
> Receiver: candump can0 &
>  mailbox_num =3D 1, timestamp =3D 4113563648, can_id =3D 266
>  mailbox_num =3D 2, timestamp =3D 4105568256, can_id =3D 71e
>  mailbox_num =3D 3, timestamp =3D 43646976, can_id =3D 256
>  mailbox_num =3D 4, timestamp =3D 276496384, can_id =3D 6fc
>  mailbox_num =3D 5, timestamp =3D 509149184, can_id =3D 21a
>  mailbox_num =3D 6, timestamp =3D 741605376, can_id =3D 594

Reading mailboxes 1 to 6 probably means that it took the duration of 6
CAN frames (+ the added overhead of the printk()s) until the IRQ fired
and reached mailbox 6.

However starting with frame 3 the timestamps look good.

>  mailbox_num =3D 1, timestamp =3D 973406208, can_id =3D 162
>  mailbox_num =3D 1, timestamp =3D 1205010432, can_id =3D 6b0
>  mailbox_num =3D 1, timestamp =3D 1437138944, can_id =3D 710
>  mailbox_num =3D 1, timestamp =3D 1670184960, can_id =3D 50b
>   can0  71E   [8]  8A F0 C5 2F 9F 3C 72 32
>   can0  266   [8]  F2 2D C6 5F 0E FE DE 38
>   can0  256   [2]  03 4B
>   can0  6FC   [8]  B1 46 D5 40 F6 C4 CC 1D
>   can0  21A   [2]  60 2C
>   can0  594   [2]  B1 5A
>   can0  162   [2]  CB 41
>   can0  6B0   [4]  CA 64 AB 70
>   can0  710   [8]  25 27 2F 11 2F 76 54 17
>   can0  50B   [8]  CE B2 C6 49 61 1F B9 3A
>=20
> 2)
> Sender: cangen can0 -g 100 -vv
>   can0  343   [4]  13 89 21 5D
>   can0  2DF   [8]  E6 64 C6 25 ED F0 7B 16
>   can0  353   [8]  9B 84 9B 21 CA A3 CC 50
>   can0  4E2   [8]  63 0E B0 1E 70 0E C2 12
>   can0  643   [4]  75 9E 6E 08
>   can0  3D1   [5]  E9 A6 FE 1D 88
>   can0  4E6   [8]  A3 02 0E 08 1B F1 32 4F
>   can0  6E2   [1]  1B
>   can0  026   [8]  08 36 25 73 05 BB F3 4F
>   can0  1CD   [8]  F3 AB 6F 66 20 ED B2 46
>   can0  157   [8]  EB 90 7F 17 39 0E E7 48
>   can0  227   [8]  A9 1C A9 5B 6B 78 7D 33
>   can0  6D2   [8]  A3 E3 01 56 A3 3A AB 3C
>   can0  2D4   [8]  2C F5 A4 62 BA C7 6E 7D
>   can0  416   [8]  D5 B8 A1 4C F8 E2 EF 0A
>   can0  6B0   [1]  1E
>   can0  620   [6]  DC 01 4F 77 ED 1F
>   can0  615   [8]  0D 0D 98 68 6C E7 EF 06
>   can0  65D   [8]  A5 F5 D6 4F 85 D0 9B 14
>   can0  546   [8]  F0 48 19 48 18 C4 DA 53
>   can0  56D   [3]  BC FE 85
>   can0  71F   [8]  FB 57 77 5D 35 AB E6 73
>=20
> Receiver: candump can0 &
>  mailbox_num =3D 1, timestamp =3D 1521614848, can_id =3D 343
>  mailbox_num =3D 2, timestamp =3D 3618439168, can_id =3D 2df
>  mailbox_num =3D 3, timestamp =3D 1590951936, can_id =3D 353
>  mailbox_num =3D 4, timestamp =3D 3859611648, can_id =3D 4e2
>  mailbox_num =3D 5, timestamp =3D 1833238528, can_id =3D 643
>  mailbox_num =3D 6, timestamp =3D 4101767168, can_id =3D 3d1
>  mailbox_num =3D 7, timestamp =3D 2076770304, can_id =3D 4e6
>  mailbox_num =3D 8, timestamp =3D 50135040, can_id =3D 6e2
>  mailbox_num =3D 9, timestamp =3D 2318729216, can_id =3D 26
>  mailbox_num =3D 10, timestamp =3D 291897344, can_id =3D 1cd
>  mailbox_num =3D 11, timestamp =3D 2559901696, can_id =3D 157
>  mailbox_num =3D 12, timestamp =3D 532742144, can_id =3D 227
>  mailbox_num =3D 1, timestamp =3D 2801336320, can_id =3D 6d2
>  mailbox_num =3D 1, timestamp =3D 776011776, can_id =3D 2d4
>  mailbox_num =3D 1, timestamp =3D 3044343808, can_id =3D 416
>  mailbox_num =3D 1, timestamp =3D 1016332288, can_id =3D 6b0
>=20
>   can0  343   [4]  13 89 21 5D
>   can0  353   [8]  9B 84 9B 21 CA A3 CC 50
>   can0  643   [4]  75 9E 6E 08
>   can0  4E6   [8]  A3 02 0E 08 1B F1 32 4F
>   can0  026   [8]  08 36 25 73 05 BB F3 4F
>   can0  157   [8]  EB 90 7F 17 39 0E E7 48
>   can0  2DF   [8]  E6 64 C6 25 ED F0 7B 16
>   can0  4E2   [8]  63 0E B0 1E 70 0E C2 12
>   can0  3D1   [5]  E9 A6 FE 1D 88
>   can0  6E2   [1]  1B
>   can0  1CD   [8]  F3 AB 6F 66 20 ED B2 46
>   can0  227   [8]  A9 1C A9 5B 6B 78 7D 33
>   can0  6D2   [8]  A3 E3 01 56 A3 3A AB 3C
>   can0  2D4   [8]  2C F5 A4 62 BA C7 6E 7D
>   can0  416   [8]  D5 B8 A1 4C F8 E2 EF 0A
>   can0  6B0   [1]  1E
>=20
> I found that not only the wake up frame will out-of-order, frames
> read in one round including wake up frame all could be disordered.

Yes, these timestamps are all over the place. It's due to the "big" gap
of 100ms between the CAN frames. What's the configured bitrate of your bu=
s?

If the timestamp counter is incremented with each bit on the bus
(recheck the data sheet) a 16 bit counter will overflow quite often. At
500 kbit/s it about 2^16 / 500000 =3D 0.131072ms.

If we cannot patch the silicon to have a wider counter or a counter
pre-scaler :) You could implement a first IRQ after wakeup hack to read
all frames in order without sorting them.


I think we can explain case 2), but I think case 1) is different. Can
you repeat testcase 1) several times and send the output?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--mFnuO6zz7bhlaH4PpjVlIPscsmHUkHjqv--

--y1aOsjEe0CJZBInf7d8Tzn0Whg8SHWSb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3Kb3QACgkQWsYho5Hk
nSDQagf/RURYMoqzg6ZJ8Z4ake2YlC/n9WiURE17FDLA+jFUt6T52+w31JpSXb9Q
S7iXVCEBxweNsPVOJbbbrdn8CXLm+nqXAWA3VwyjYYCUR4ROfgNPp+C7i8iLJwe6
EPUI2SvV6mFJuxwlZ/Uz2LT8bXQ0YEe5F9HArelW4alSxvpyZ3+larwAn3ui6sDJ
664HVLerX5ewPcTByIJYYfVJoU5xo3NwQ+mpyYbzStnEy6uzhs5/9M3jiH0CFtal
zhRp8ugyzVQhcSbyTfvIaqwsSqDVxmE3sF+RcdperE9tEZYRIFvz/WrXQuLF2mo2
F15Vx4wfgzyJ8mjEKN5XSjy65vf3/w==
=heAy
-----END PGP SIGNATURE-----

--y1aOsjEe0CJZBInf7d8Tzn0Whg8SHWSb8--
