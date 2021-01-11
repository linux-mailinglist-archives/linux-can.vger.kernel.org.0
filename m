Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C857B2F0F94
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 11:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbhAKJ7O (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 04:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbhAKJ7N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 04:59:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3264DC061786
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 01:58:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kyty3-00065f-P7; Mon, 11 Jan 2021 10:58:31 +0100
Received: from [IPv6:2a03:f580:87bc:d400:1a37:80df:441f:8a61] (unknown [IPv6:2a03:f580:87bc:d400:1a37:80df:441f:8a61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A44175BF66D;
        Mon, 11 Jan 2021 09:58:30 +0000 (UTC)
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20210109174013.534145-1-mkl@pengutronix.de>
 <20210109174013.534145-5-mkl@pengutronix.de>
 <5ce2f307-3352-c3ea-50b7-97e07401a7b9@hartkopp.net>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [net-next 04/13] can: dev: move length related code into seperate
 file
Message-ID: <c3c44ecf-d332-9ae7-46e4-78ad54057e78@pengutronix.de>
Date:   Mon, 11 Jan 2021 10:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5ce2f307-3352-c3ea-50b7-97e07401a7b9@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bdlAl77FFFV0iItBashClLsXW39zXse1R"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bdlAl77FFFV0iItBashClLsXW39zXse1R
Content-Type: multipart/mixed; boundary="Ofbxrn7XOLQNsmzbnIM2LJqd2PE64aRNL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Message-ID: <c3c44ecf-d332-9ae7-46e4-78ad54057e78@pengutronix.de>
Subject: Re: [net-next 04/13] can: dev: move length related code into seperate
 file
References: <20210109174013.534145-1-mkl@pengutronix.de>
 <20210109174013.534145-5-mkl@pengutronix.de>
 <5ce2f307-3352-c3ea-50b7-97e07401a7b9@hartkopp.net>
In-Reply-To: <5ce2f307-3352-c3ea-50b7-97e07401a7b9@hartkopp.net>

--Ofbxrn7XOLQNsmzbnIM2LJqd2PE64aRNL
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/11/21 9:49 AM, Oliver Hartkopp wrote:
>> diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length=
=2Ec
>> new file mode 100644
>> index 000000000000..540d40dc0bc2
>> --- /dev/null
>> +++ b/drivers/net/can/dev/length.c
>> @@ -0,0 +1,40 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
>> + * Copyright (C) 2006 Andrey Volkov, Varma Electronics
>> + * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
>> + */
>=20
> See comment below ...
>=20
>> +
>> +#include <linux/can/dev.h>
>> +
>> +/* CAN DLC to real data length conversion helpers */
>> +
>> +static const u8 dlc2len[] =3D {0, 1, 2, 3, 4, 5, 6, 7,
>> +			     8, 12, 16, 20, 24, 32, 48, 64};
>> +
>> +/* get data length from raw data length code (DLC) */
>> +u8 can_fd_dlc2len(u8 dlc)
>> +{
>> +	return dlc2len[dlc & 0x0F];
>> +}
>> +EXPORT_SYMBOL_GPL(can_fd_dlc2len);
>> +
>> +static const u8 len2dlc[] =3D {0, 1, 2, 3, 4, 5, 6, 7, 8,		/* 0 - 8 *=
/
>> +			     9, 9, 9, 9,			/* 9 - 12 */
>> +			     10, 10, 10, 10,			/* 13 - 16 */
>> +			     11, 11, 11, 11,			/* 17 - 20 */
>> +			     12, 12, 12, 12,			/* 21 - 24 */
>> +			     13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
>> +			     14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
>> +			     14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
>> +			     15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
>> +			     15, 15, 15, 15, 15, 15, 15, 15};	/* 57 - 64 */
>> +
>> +/* map the sanitized data length to an appropriate data length code *=
/
>> +u8 can_fd_len2dlc(u8 len)
>> +{
>> +	if (unlikely(len > 64))
>> +		return 0xF;
>> +
>> +	return len2dlc[len];
>> +}
>> +EXPORT_SYMBOL_GPL(can_fd_len2dlc);
>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>> index 054c3bed190b..d75fba1d030a 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -18,6 +18,7 @@
>>   #include <linux/can/bittiming.h>
>>   #include <linux/can/error.h>
>>   #include <linux/can/led.h>
>> +#include <linux/can/length.h>
>>   #include <linux/can/netlink.h>
>>   #include <linux/can/skb.h>
>>   #include <linux/netdevice.h>
>> @@ -83,15 +84,6 @@ struct can_priv {
>=20
>=20
> (..)
>=20
>> diff --git a/include/linux/can/length.h b/include/linux/can/length.h
>> new file mode 100644
>> index 000000000000..fabd93bcde3e
>> --- /dev/null
>> +++ b/include/linux/can/length.h
>> @@ -0,0 +1,51 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2006 Andrey Volkov <avolkov@varma-el.com>
>> + *               Varma Electronics Oy
>> + * Copyright (C) 2008 Wolfgang Grandegger <wg@grandegger.com>
>=20
> The CAN FD and len8_dlc length stuff was completely contributed by myse=
lf.
>=20
> So if this code is now moved to a separate file the former Copyrights=20
> should be replaced with
>=20
> Copyright (C) 2020 Oliver Hartkopp <socketcan@hartkopp.net>

Ok. I carried the copyrights from the files I move the from forward to th=
e new file.

For dev.c -> length.c the code was added with:

> commit 1e0625facab2e871472472b7df87d8fbe6caf75a
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> Date:   Wed Jun 13 20:48:21 2012 +0200
>=20
>     candev: add/update helpers for CAN FD
>    =20
>     - update sanity checks
>     - add DLC to length conversion helpers
>       - can_dlc2len() - get data length from can_dlc with sanitized can=
_dlc
>       - can_len2dlc() - map the sanitized data length to an appropriate=
 DLC
>    =20
>     Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>     Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

and then updated with:

> commit c7b74967799b1af52b3045d69d4c26836b2d41de
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> Date:   Fri Nov 20 11:04:44 2020 +0100
>=20
>     can: replace can_dlc as variable/element for payload length
>    =20
>     The naming of can_dlc as element of struct can_frame and also as va=
riable
>     name is misleading as it claims to be a 'data length CODE' but in r=
eality
>     it always was a plain data length.
>    =20
>     With the indroduction of a new 'len' element in struct can_frame we=
 can now
>     remove can_dlc as name and make clear which of the former uses was =
a plain
>     length (-> 'len') or a data length code (-> 'dlc') value.
>    =20
>     Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>     Link: https://lore.kernel.org/r/20201120100444.3199-1-socketcan@har=
tkopp.net
>     [mkl: gs_usb: keep struct gs_host_frame::can_dlc as is]
>     Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

> commit 3ab4ce0d6fa8c93d41df4a74ec8d2c9198be2109
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> Date:   Tue Nov 10 11:18:49 2020 +0100
>=20
>     can: rename CAN FD related can_len2dlc and can_dlc2len helpers
>    =20
>     The helper functions can_len2dlc and can_dlc2len are only relevant =
for
>     CAN FD data length code (DLC) conversion.
>    =20
>     To fit the introduced can_cc_dlc2len for Classical CAN we rename:
>    =20
>     can_dlc2len -> can_fd_dlc2len to get the payload length from the DL=
C
>     can_len2dlc -> can_fd_len2dlc to get the DLC from the payload lengt=
h
>    =20
>     Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>     Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>     Link: https://lore.kernel.org/r/20201110101852.1973-6-socketcan@har=
tkopp.net
>     Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

So I'll make copyright:

Copyright (C) 2012, 2020 Oliver Hartkopp <socketcan@hartkopp.net>

The changes in dev.h -> length.h were in 2020 only, using that year only.=


regards.
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--Ofbxrn7XOLQNsmzbnIM2LJqd2PE64aRNL--

--bdlAl77FFFV0iItBashClLsXW39zXse1R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl/8IUMACgkQqclaivrt
76nX3Qf+MftZFdP8+/pG81SHLiauFBa+Eace5ihulyn1hh/seIUu7uVoT7ICxsbf
o4N/gGCtEttRdkXrovnn2GoYHL+TSKFxfo/1NPy1MOXYDbx1ZwOSdYqqkwvhQiCf
N0JpedGJ+QkJ0gV/Pm8K1ALQ+DuvSF6EUiQEY+EK1IGJE3mkpBfpmRYLXs6BYXjd
s8uZ4KxUNQcs5cBb0ize/NUEXxrlvhzBIX/avdLdTMkkCCrAhHDwFLJClhpRzHDH
KvNPBucPYewXg6Z7QkolDeNJ4T5FwnbKN7QbUKB5QENH20iaYYDL6qjZQdf0WyYC
YOPT/xDKLk91eKJPWPjCtbEFPycGUA==
=NdjA
-----END PGP SIGNATURE-----

--bdlAl77FFFV0iItBashClLsXW39zXse1R--
