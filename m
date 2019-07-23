Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEB1716B6
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2019 13:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfGWLH0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Jul 2019 07:07:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57569 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfGWLH0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jul 2019 07:07:26 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hpsdf-0001OE-QX; Tue, 23 Jul 2019 13:07:23 +0200
Received: from [IPv6:2003:c7:729:c745:c9d4:83d5:b99:4f4d] (unknown [IPv6:2003:c7:729:c745:c9d4:83d5:b99:4f4d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 791DC437148;
        Tue, 23 Jul 2019 11:07:22 +0000 (UTC)
Subject: Re: [PATCH resend] can/ifi_canfd: Added API for IFI-CANFD
 functionalities
To:     Marek Vasut <marex@denx.de>, marcel.schmidt@schulz-soluware.com,
        linux-can@vger.kernel.org, wg@grandegger.com
References: <20190712095150.29446-1-marcel.schmidt@schulz-soluware.com>
 <e9a85767-c9a2-06a9-c355-e43d0e507c10@pengutronix.de>
 <b89bb3c5-c0d3-257a-4741-c7ed330ab4a0@denx.de>
 <5d1f7519-c344-b429-1342-996809d5d615@pengutronix.de>
 <6501777f-74ba-777c-9a6f-e3333ef0ccb2@denx.de>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c077c5ee-9217-0740-2384-4c9effb7ac85@pengutronix.de>
Date:   Tue, 23 Jul 2019 13:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6501777f-74ba-777c-9a6f-e3333ef0ccb2@denx.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="o0MuYeTBfJPODMJm0qw9VuAkZmo1i65zs"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o0MuYeTBfJPODMJm0qw9VuAkZmo1i65zs
Content-Type: multipart/mixed; boundary="zZa2AcmYfl6ajG66mboHkBjwWa9yXKcWq";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marek Vasut <marex@denx.de>, marcel.schmidt@schulz-soluware.com,
 linux-can@vger.kernel.org, wg@grandegger.com
Message-ID: <c077c5ee-9217-0740-2384-4c9effb7ac85@pengutronix.de>
Subject: Re: [PATCH resend] can/ifi_canfd: Added API for IFI-CANFD
 functionalities
References: <20190712095150.29446-1-marcel.schmidt@schulz-soluware.com>
 <e9a85767-c9a2-06a9-c355-e43d0e507c10@pengutronix.de>
 <b89bb3c5-c0d3-257a-4741-c7ed330ab4a0@denx.de>
 <5d1f7519-c344-b429-1342-996809d5d615@pengutronix.de>
 <6501777f-74ba-777c-9a6f-e3333ef0ccb2@denx.de>
In-Reply-To: <6501777f-74ba-777c-9a6f-e3333ef0ccb2@denx.de>

--zZa2AcmYfl6ajG66mboHkBjwWa9yXKcWq
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 7/23/19 10:20 AM, Marek Vasut wrote:
> On 7/22/19 10:06 AM, Marc Kleine-Budde wrote:
>> On 7/21/19 12:55 PM, Marek Vasut wrote:
>>> On 7/19/19 2:52 PM, Marc Kleine-Budde wrote:
>>>> On 7/12/19 11:51 AM, marcel.schmidt@schulz-soluware.com wrote:
>>>>> From: Marcel Schmidt <marcel.schmidt@schulz-soluware.com>
>>>>>
>>>>> Updates the ifi_canfd platform driver and adds an universal
>>>>> interface that enables the usage of its functionalities outside of
>>>>> this platform driver.
>>>>>
>>>>> It was implemented with respect to role models like SJA1000 or C_Ca=
n.
>>>>> Therefore the driver is split into three files.
>>>>> ifi_canfd_platform.c contains the platform specific implementations=

>>>>> and remains functional the same. ifi_canfd.c+h enables common IFI-C=
ANFD
>>>>> functionalities usable for other drivers.
>>>
>>> I had a quick look at the patch, but I don't quite understand what th=
e
>>> goal/purpose of the patch is ?
>>
>> As Marcel writes, he want to be able to use the functionalities outsid=
e
>> of this driver. Maybe there's another driver that makes use of this.
>>
>> If there is another driver, I think it's best to include it in this
>> series, so that we can see if having a second driver is a good idea in=

>> the first place.
>=20
> I think so too.
>=20
> I am guessing he might be using the IFI CANFD on different (non-mmap)
> bus, like SPI, but then maybe regmap would be a better solution.

Probably. Let's wait for the additional driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--zZa2AcmYfl6ajG66mboHkBjwWa9yXKcWq--

--o0MuYeTBfJPODMJm0qw9VuAkZmo1i65zs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl026mUACgkQWsYho5Hk
nSALgwf7Bx1EZI5Av+n5hPNkcgPBb/KwH/ZNIM6OoWdPU1rKSb2yzDKXDrC0Wfko
qIUTFYu2LSMHSZPEjCHcB8o+bVQ0sqnHzUOSVRY69FW8CnP6gjZ4lOQo0wykBPTH
i/S6uMob8DqxPFgRmh3TY/z3GDK2rneb0L4m9HfVFnDwl5NmWAAlPfghypWOCfLf
gfeFdiU9H/ItWAYUJFcTI/kR6kA6G5yqKran1QmT8OT8ZgPBFM9xxDfxQRyONQBn
Z95RHkjQLtCX6GClBRctgesvSyVsdiu/4aPRBWSOptDArhvhFA10HwugSu/AOY3j
SPCcNe2Pi9wohuIPrVwMwIduSsFqlA==
=J7h2
-----END PGP SIGNATURE-----

--o0MuYeTBfJPODMJm0qw9VuAkZmo1i65zs--
