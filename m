Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8529ADC5
	for <lists+linux-can@lfdr.de>; Tue, 27 Oct 2020 14:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbgJ0Nsi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Oct 2020 09:48:38 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39125 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbgJ0Nsh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Oct 2020 09:48:37 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kXPL2-0006O1-EY; Tue, 27 Oct 2020 14:48:36 +0100
Received: from [IPv6:2a03:f580:87bc:d400:73e2:4ffe:a133:aaa3] (unknown [IPv6:2a03:f580:87bc:d400:73e2:4ffe:a133:aaa3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1264458337E;
        Tue, 27 Oct 2020 13:48:35 +0000 (UTC)
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <d5ad34b5-7232-eadb-94a0-c58c111fa443@pengutronix.de>
 <8c142aa4-78a2-1291-b5a8-d4af9ba41338@hartkopp.net>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
Message-ID: <64920ca4-35df-2a46-5f1a-09a9e7eeffcf@pengutronix.de>
Date:   Tue, 27 Oct 2020 14:48:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8c142aa4-78a2-1291-b5a8-d4af9ba41338@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1rVBkyPnCa42aD0zsBZvkmz5I9v8v2JuR"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1rVBkyPnCa42aD0zsBZvkmz5I9v8v2JuR
Content-Type: multipart/mixed; boundary="b2r2UlOcksiPsrRdkhpaSYBscandN3Ucp";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, mailhol.vincent@wanadoo.fr
Cc: linux-can@vger.kernel.org
Message-ID: <64920ca4-35df-2a46-5f1a-09a9e7eeffcf@pengutronix.de>
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <d5ad34b5-7232-eadb-94a0-c58c111fa443@pengutronix.de>
 <8c142aa4-78a2-1291-b5a8-d4af9ba41338@hartkopp.net>
In-Reply-To: <8c142aa4-78a2-1291-b5a8-d4af9ba41338@hartkopp.net>

--b2r2UlOcksiPsrRdkhpaSYBscandN3Ucp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/27/20 2:23 PM, Oliver Hartkopp wrote:
> On 27.10.20 14:06, Marc Kleine-Budde wrote:
>> On 10/23/20 10:30 PM, Oliver Hartkopp wrote:
>>> ISO 11898-1 Chapter 8.4.2.3 defines a 4 bit data length code (DLC) ta=
ble which
>>> maps the DLC to the payload length of the CAN frame in bytes:
>>>
>>>      DLC      ->  payload length
>>>      0 .. 8   ->  0 .. 8
>>>      9 .. 15  ->  8
>>>
>>> Although the DLC values 8 .. 15 in Classical CAN always result in a p=
ayload
>>> length of 8 bytes these DLC values are transparently transmitted on t=
he CAN
>>> bus. As the struct can_frame only provides a 'len' element (formerly =
'can_dlc')
>>> which contains the plain payload length ( 0 .. 8 ) of the CAN frame, =
the raw
>>> DLC is not visible to the application programmer, e.g. for testing us=
e-cases.
>>>
>>> To access the raw DLC values 9 .. 15 the len8_dlc element is introduc=
ed, which
>>> is only valid when the payload length 'len' is 8 and the DLC is great=
er than 8.
>>>
>>> The len8_dlc element is filled by the CAN interface driver and used f=
or CAN
>>> frame creation by the CAN driver when the CAN_CTRLMODE_CC_LEN8_DLC fl=
ag is
>>
>> CC stands for Classic CAN? Is this the "official" name?
>=20
> No. It is 'Classical CAN'. I'm not very happy with that naming as there=
=20
> was already a 'CAN2.0B' specification to separate from the first versio=
n=20
> which only had 11 Bit identifiers. This could be Ancient CAN now :-D

So Classical CAN is CAN2.0B?

>> For example there was a press release to harmonize the CAN transceiver=
 nameing
>> recently:
>>
>> https://can-cia.org/news/press-releases/view/harmonized-transceiver-na=
ming/2020/7/16/
>=20
> Yes, there you can find:
>=20
> "CAN high-speed transceivers might be used in Classical CAN, CAN FD, or=
=20
> CAN XL networks"

Doh! I should have re-read that article :) We found it, when we were sear=
ching
for consistent naming for the different CAN transceivers.

> Maybe we could update some comments and documentation for CAN2.0 ->=20
> Classical CAN later.

Good point.

[...]

>>> +	union {
>>> +		/* CAN frame payload length in byte (0 .. CAN_MAX_DLEN)
>>> +		 * was previously named can_dlc so we need to carry that
>>> +		 * name for legacy support
>>> +		 */
>>> +		__u8 len;
>>> +		__u8 can_dlc; /* deprecated */
>>> +	};
>>
>> There was an old compiler version, which struggled with C99 initialize=
d unions
>> within structs.....So this change would break existing source, but I t=
hink that
>> old compilers are long gone (for good).
>=20
> Good to know. Do you know 'version numbers', so that we may place a=20
> warning somewhere?

No, I don't remember. Some old gcc-3.x

> I still have a 2.6.28 system here (gcc 2.95) - but I would not know why=
=20
> updating the can-utils there today. Maybe for the cansniffer ;-)
>=20
> Btw. when it is only about the initialization of static struct=20
> can_frame's, I can also check for these cases in can-utils.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--b2r2UlOcksiPsrRdkhpaSYBscandN3Ucp--

--1rVBkyPnCa42aD0zsBZvkmz5I9v8v2JuR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+YJS4ACgkQqclaivrt
76lq3wf/YD6+G15OkgDsbMozZOLqbTFPUQYCtZGMZ06IsSCaqNnV/C2dvPK3gI9V
fWMASbgRgv9wCSEP1hl7mr6zP/J1p3OjIjNGWHLd996njDpi8hn1ycZ4jwhu/udj
N56Z0VBVHwM1/kMUaR4q0zQbv4aW0n2qb8WTfajQhDqHF1pnrE9IVQ+rRIa7FseF
GXo3IrHhf8mjcHYV0IUs/m/Wel9iuJQQlZESBIbdxTtU7IwQ+diVwepmm6B4a9PY
1ddFWG6amXUOdkuxNuPhDEbq7XQXHrwFFtWsv5i1bQ9Sfbps8cp9Y2nqunw9q9P1
WnWj6jlqL7u1QvmIN4432ldirVR2xQ==
=tbQn
-----END PGP SIGNATURE-----

--1rVBkyPnCa42aD0zsBZvkmz5I9v8v2JuR--
