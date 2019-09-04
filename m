Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FAFA80AD
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfIDKua (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:50:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37321 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDKua (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:50:30 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1i5Srs-0005Mr-6M; Wed, 04 Sep 2019 12:50:28 +0200
Received: from [IPv6:2a03:f580:87bc:d400:746e:2448:cd8f:dc51] (unknown [IPv6:2a03:f580:87bc:d400:746e:2448:cd8f:dc51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 02971453152;
        Wed,  4 Sep 2019 10:50:26 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de
References: <20190828065226.23604-1-mkl@pengutronix.de>
 <a101ddf0-5150-dd48-e456-3571cfc7036b@hartkopp.net>
 <80f42661-48d3-09a0-3323-8ac4a0bda74a@pengutronix.de>
 <c3ed7db0-3d80-a17c-6c9e-0a4f821ed5db@hartkopp.net>
 <47797657-653b-8600-e896-98953f90b10d@pengutronix.de>
 <2578c177-0bf2-6acc-e197-83ef78b4dafb@hartkopp.net>
 <4a240257-c65f-110b-5cb1-5b8a91ee1ee4@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 00/21] Add support for the J1939 Protocol
Message-ID: <2a284fa8-5fd8-4e9e-aad4-347feb7941d7@pengutronix.de>
Date:   Wed, 4 Sep 2019 12:50:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4a240257-c65f-110b-5cb1-5b8a91ee1ee4@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="k13eSnK9DiCBURcdvwMDnrzl8ql3l70bI"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k13eSnK9DiCBURcdvwMDnrzl8ql3l70bI
Content-Type: multipart/mixed; boundary="7YAVDQt3gNoYhwiWqTTTtAIJO0Yu4YBUw";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc: kernel@pengutronix.de
Message-ID: <2a284fa8-5fd8-4e9e-aad4-347feb7941d7@pengutronix.de>
Subject: Re: [PATCH 00/21] Add support for the J1939 Protocol
References: <20190828065226.23604-1-mkl@pengutronix.de>
 <a101ddf0-5150-dd48-e456-3571cfc7036b@hartkopp.net>
 <80f42661-48d3-09a0-3323-8ac4a0bda74a@pengutronix.de>
 <c3ed7db0-3d80-a17c-6c9e-0a4f821ed5db@hartkopp.net>
 <47797657-653b-8600-e896-98953f90b10d@pengutronix.de>
 <2578c177-0bf2-6acc-e197-83ef78b4dafb@hartkopp.net>
 <4a240257-c65f-110b-5cb1-5b8a91ee1ee4@pengutronix.de>
In-Reply-To: <4a240257-c65f-110b-5cb1-5b8a91ee1ee4@pengutronix.de>

--7YAVDQt3gNoYhwiWqTTTtAIJO0Yu4YBUw
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/4/19 12:26 PM, Marc Kleine-Budde wrote:
> On 9/4/19 12:25 PM, Oliver Hartkopp wrote:
>> Hi Marc,
>>
>> On 04/09/2019 09.15, Marc Kleine-Budde wrote:
>>> On 9/3/19 6:16 PM, Oliver Hartkopp wrote:
>>
>>>> Some patches do not work alone out of that sequence. Does it make se=
nse
>>>> to squash them into one?
>>>
>>> Yes, the patches build on top of each other, but the series is
>>> bisectable. The criterium is to have one change per patch and the tre=
e
>>> can be compiled before and after the patch. Smaller changes and thus
>>> patches are usually easier to review.
>>>
>>> It would be nice to have the "renaming things" patches separate, for =
the
>>> above reasons. But the introduction of the mid-layer should stay
>>> separate: introduce it and allocate the mid-layer memory, switch the
>>> framework over to make use of it and finally remove all left overs.
>>>
>>>> squash patches 1-4 into one ?
>>>
>>> See above.
>>
>> Ah, I've just seen that the sequence first renamed the structs and the=
n=20
>> the variable names step-by-step.
>>
>> That is indeed the best approach ... forget my remarks about squashing=
=20
>> these patches.
>>
>> You can add my Acked-by for all of these renaming patches too.

The current status is:


> squash patches 1-4 into one ?

Not squashed, Acked-by added.

> 5 ok

Acked-by added.

> squash patches 6-7 into one ?

Not squashed, Acked-by added.

> squash patches 8-9 into one ?

Not squashed, Acked-by added.

> 10 ok

Acked-by added.

> 11 ok - but my mail address is wrong :/

Acked-by added, fixed email address.

> 12 already ok

Acked-by added.

> squash patches 13-15 into one ?

13 has S-o-b
14/15 not squashed, Acked-by added.

> 16-17 ok
> 18 Shouldn't it be CAN_REQUIRED_SIZE() ??

Fixed, No Acked-by for now.

> 19-21 ok

Acked-by added.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7YAVDQt3gNoYhwiWqTTTtAIJO0Yu4YBUw--

--k13eSnK9DiCBURcdvwMDnrzl8ql3l70bI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1vlu4ACgkQWsYho5Hk
nSDfcwgAmdsTJ8DUt6VeTs//REaq77Y+BGvbDGSUaFUinxMIsp4oq4xiXNU+BJct
fMaTwrxFBJt3FYozFFnkEZTaNsTdC5npX9nVYt08udzFH0hmNnOLNjRwxDDGS/an
2WekBaJYdUZMbK5g/Qv8mLOMIjMd2XtMKhTvXWTX/+s1QMu44fFVfvYx59V5ANuF
GiUXdHL3mVEyvLiC+n18qgJeHk+YpPdZ9suW09/nQBi2IyemvcoYQoaM8BNKbRHz
SRfCAimYqPNlCAZi5aYqgt91DdBs+fVxt/EGfrupkqlwaHly0/bjb/fSRGcv8C1j
fOkASZOtyy/ttKVSIdH338pg8UFrsQ==
=/gSw
-----END PGP SIGNATURE-----

--k13eSnK9DiCBURcdvwMDnrzl8ql3l70bI--
