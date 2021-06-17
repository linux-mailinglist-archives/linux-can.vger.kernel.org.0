Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398563AAECB
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 10:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFQIcP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFQIcO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 04:32:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED54BC06175F
        for <linux-can@vger.kernel.org>; Thu, 17 Jun 2021 01:30:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltnPV-0005Ym-3W; Thu, 17 Jun 2021 10:30:01 +0200
Received: from [IPv6:2a03:f580:87bc:d400:653d:6f2f:e25e:5f2e] (unknown [IPv6:2a03:f580:87bc:d400:653d:6f2f:e25e:5f2e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4B54763DE2D;
        Thu, 17 Jun 2021 08:29:59 +0000 (UTC)
To:     Angelo Dureghello <angelo@kernel-space.org>,
        Greg Ungerer <gerg@linux-m68k.org>, wg@grandegger.com
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <3f74ce4f-b4c5-d622-7cba-b4ce070fd967@linux-m68k.org>
 <93a5c017-a538-af84-fe7d-a152dec0bd07@kernel-space.org>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 1/5] can: flexcan: add platform data for ColdFire
Message-ID: <7196215c-9fdc-2355-d663-da77bff0a4a4@pengutronix.de>
Date:   Thu, 17 Jun 2021 10:29:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <93a5c017-a538-af84-fe7d-a152dec0bd07@kernel-space.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OR4JDskFJHi1Alw3gGkgebn0BOBob9HmC"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OR4JDskFJHi1Alw3gGkgebn0BOBob9HmC
Content-Type: multipart/mixed; boundary="61HU4aZt0VPy9dbxfWF5ZdVtpe2ipSaGf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Angelo Dureghello <angelo@kernel-space.org>,
 Greg Ungerer <gerg@linux-m68k.org>, wg@grandegger.com
Cc: geert@linux-m68k.org, linux-m68k@vger.kernel.org,
 linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
Message-ID: <7196215c-9fdc-2355-d663-da77bff0a4a4@pengutronix.de>
Subject: Re: [PATCH v2 1/5] can: flexcan: add platform data for ColdFire
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <3f74ce4f-b4c5-d622-7cba-b4ce070fd967@linux-m68k.org>
 <93a5c017-a538-af84-fe7d-a152dec0bd07@kernel-space.org>
In-Reply-To: <93a5c017-a538-af84-fe7d-a152dec0bd07@kernel-space.org>

--61HU4aZt0VPy9dbxfWF5ZdVtpe2ipSaGf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/17/21 9:23 AM, Angelo Dureghello wrote:
> Hi Greg,
>=20
> On 17/06/21 2:17 AM, Greg Ungerer wrote:
>> Hi Angelo,
>>
>> On 17/6/21 9:16 am, Angelo Dureghello wrote:
>>> Add platform data object for ColdFire architecture.
>>>
>>> ---
>>> Changes for v2:
>>> - move header file in more proper location
>>> - remove irq defines
>>> - change variable types to match driver types
>>>
>>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>>> ---
>>> =C2=A0 include/linux/can/platform/mcf5441x.h | 28 +++++++++++++++++++=
++++++++
>>> =C2=A0 1 file changed, 28 insertions(+)
>>> =C2=A0 create mode 100644 include/linux/can/platform/mcf5441x.h
>>>
>>> diff --git a/include/linux/can/platform/mcf5441x.h=20
>>> b/include/linux/can/platform/mcf5441x.h
>>> new file mode 100644
>>> index 000000000000..6866f0f60caf
>>> --- /dev/null
>>> +++ b/include/linux/can/platform/mcf5441x.h
>>> @@ -0,0 +1,28 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Flexcan options for ColdFire family
>>> + *
>>> + * Copyright (C) 2021=C2=A0 Angelo Dureghello <angelo@kernel-space.o=
rg>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See th=
e
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#ifndef _PLAT_FLEXCAN_MCF_H
>>> +#define _PLAT_FLEXCAN_MCF_H
>>> +
>>> +struct mcf_flexcan_platform_data {
>>> +=C2=A0=C2=A0=C2=A0 u8 clk_src;
>>> +=C2=A0=C2=A0=C2=A0 u32 clock_frequency;
>>> +=C2=A0=C2=A0=C2=A0 bool big_endian;
>>> +};
>>> +
>>> +#define FLEXCAN_MCF5411X_MB_CNT_MCF=C2=A0=C2=A0=C2=A0 16
>>> +
>>> +#endif /* _PLAT_FLEXCAN_MCF_H */
>>
>> Is this actually specific to the ColdFire M5411x SoC?
>> I thought a number of other ColdFire parts also have canbus support.
>> Are they not all the same underlying hardware block?
>>
>> So should this be more generic, say flexcan.h or mcf_flexcan.h or=20
>> something like that?
>=20
>=20
> yes, the file can be reused for all mcf, they have similar
> hardware blocks (flexcan) but with small differences, like i.e.
> number of buffers, so the define guards are named generic (MCF),
> with specific defines as needed,
>=20
> Will rename it to mcf_flexcan.h.

The platform data is not mcf specific, it only holds the information whic=
h would
otherwise be part of the device tree (and is not accessible via other fra=
meworks).

=46rom my point of view, it makes sense to name it flexcan.h and place it=
 under
include/linux/can/platform.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--61HU4aZt0VPy9dbxfWF5ZdVtpe2ipSaGf--

--OR4JDskFJHi1Alw3gGkgebn0BOBob9HmC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDLCAMACgkQqclaivrt
76ke9gf3Rf7vDuLHoflaq7TT6i6mR/S7GJK5Laz0FerDrwQ8EV0hqIbfRjH88PiZ
qRd/Cc/P8oxLr+V43XHOpxG8jW2p49GjMhqmPmM9IcqnX0Lgn1n1ZKCF/eFJ8nN9
CEKiCZTq2enm+mYZ8gxYLL2CfJSyxNqjWIE21iqP7o6asZII3IOfKA/0vNi2K7BC
jPA7G5A/DcoA3GPbqU/lTcZ2jCCicd5DsX/ysVNA7mQeXYrUo/IPOReePlBKgxOU
QiUhYJ92Z+RD8Vz0CPouPmDyertYj2o1kv+J17xADZUrEj0IAfNS6E39Xndqy+lm
P5GnnGE1krZwOnNCGsu1IyTcxUyE
=xeux
-----END PGP SIGNATURE-----

--OR4JDskFJHi1Alw3gGkgebn0BOBob9HmC--
