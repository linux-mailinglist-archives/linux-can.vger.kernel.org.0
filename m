Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A83E484176
	for <lists+linux-can@lfdr.de>; Tue,  4 Jan 2022 13:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiADMGZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Jan 2022 07:06:25 -0500
Received: from mout01.posteo.de ([185.67.36.65]:43971 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbiADMGY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 4 Jan 2022 07:06:24 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 1225D240028
        for <linux-can@vger.kernel.org>; Tue,  4 Jan 2022 13:06:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1641297983; bh=YcIR3Sp/wra+Sgt/q7TnI/GOAGThQsfC8x+5TWoNazk=;
        h=To:Cc:From:Subject:Date:From;
        b=ll9BQxjR3WdpGRZGXb88gragSgrw7MF0ZWqp2/4JOMG2yGzDplOyMlcf0qf1LpIrT
         YPBvvXSwHRef2K6vJNBkUaJcd0pEansyHI9bQ2Q2jNsy9Meg/9dFqwiFNtfEYZxwCI
         EEpKniqPrQzjKWy5o7xlN/XOtXO1Wuxp1XRLHsTTCgAhIds7LaIt96js3F2V0C6qe+
         uNTJtWkrClQ9DHNCcwvvLuKiwh02U7G5DmJkfoiEJKI74PGRFybG3SJeFu++McYnaT
         qwfHxb53ldf6rSSBsrkf/YYZhDfiKRB1x7a7bdBPycimLozkR4Y9+hAa6InXcOx8ar
         bhGNoJyO4I3Mw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4JSrtk2gm4z6tmk;
        Tue,  4 Jan 2022 13:06:22 +0100 (CET)
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        =?UTF-8?Q?Maik_Allg=c3=b6wer?= <maik@llgoewer.de>
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
 <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
Cc:     linux-can@vger.kernel.org
From:   Patrick Menschel <menschel.p@posteo.de>
Subject: Re: can-isotp: TX stmin violations
Message-ID: <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
Date:   Tue,  4 Jan 2022 12:06:21 +0000
MIME-Version: 1.0
In-Reply-To: <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3bu1fC7IQNux7ix3Z3cHTgnTdFEUmuq5n"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3bu1fC7IQNux7ix3Z3cHTgnTdFEUmuq5n
Content-Type: multipart/mixed; boundary="iVUzYHV5I3sn16Ga3EVIP2RoZvSPpLREU";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?Q?Maik_Allg=c3=b6wer?=
 <maik@llgoewer.de>
Cc: linux-can@vger.kernel.org
Message-ID: <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
Subject: Re: can-isotp: TX stmin violations
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
 <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
In-Reply-To: <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>

--iVUzYHV5I3sn16Ga3EVIP2RoZvSPpLREU
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Am 03.01.22 um 18:40 schrieb Oliver Hartkopp:
>> In this example CF#2 is delayed by .5 ms on the wire while CF#3 is
>> sent .5 ms too early
>> when I look at the delta between CF#2 and CF#3 .
>>
>> To me it seems that, while the messages are put into some tx-queue at =
the
>> correct time, they are not actually put on the wire at that exact time=

>> leading to CF#3
>> being put on the wire too early.
>=20
> Yes. The CAN frames are sent with a 'minimum' gap which is defined with=

> STmin, see isotp_tx_timer_handler().
>=20
> Generally the handling and the sending of the frame is processed - and
> *then* the offset gap of the current time is added. In your case it
> should always be *slightly more* than 2ms, which is fine from the STmin=

> specification intention.

Hi,

actually spec says *average* gap time should not fall below STMIN.

That .5 is actually not bad at all.
I have seen some autosar manufacturers stretching the spec up to the
point where you request stmin=3D5 and get st=3D10 by design.

Regards,
Patrick


--iVUzYHV5I3sn16Ga3EVIP2RoZvSPpLREU--

--3bu1fC7IQNux7ix3Z3cHTgnTdFEUmuq5n
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAmHUOD0FAwAAAAAACgkQMeZuMM+vuE63
uhAAuWGxmnOeA2NClCz3cKZujq/beIVpxyqn0ofJV1PGTgWOxbng3IpBr7P11u3hgd9YZL3WTs77
TkcH4HS6fU0kdsvcdmQpj8xoeQzn7QeMC6UbistQ65vE4b1LzFGKn9Csh1bXZT4+BW0DV/LBeoD6
F4+ZFybc/H5GxxaLpZsFyMjzy8CH4TW9Q4TosZUZYZfQTV2H7Dz/H/ywqrg5HIXcXvwiwgCMp+/A
IB6AqHt/IkXr24wrQxIjqQW9R0x3EVcgCuhUNyBWJUO7/Kb6CJSNelu4oubUelbCR6P6QV4i+6PA
23xEz15o4r1nIN/QHTRae8alXVzKf8wbA/GWBTveS/UMVmHVZzNzGv66eFjfaglHodDeKc14rDnI
bGSHyXfPNdZ3EkUiE5yEKXVm2+6+ys0xuwkW1/kzlh7nZZ2wh5cImLKSgVX3D//PS4dPFD2+5XG4
B49BUASy6ZExpZG12C8ax7NQS8660nnNcMf4RXZHj8G1iWD+94eBUcPn3I8Jbvd0Pkpcoj1uztMs
oG0fmHsn9tsVVD2PmXVNER4YPmQ2Z3eL57TftcsWGK/4EaVe4sju5FPjooRpPOpExafK1WEDApab
zJQQ3YfeXuxrcRWVfmHyi8n5/LmwxhPLuhSXwJPaMLxT0+waZ57/gbCkn4Kj6W4bAdqGYT8Z9Vs4
o2g=
=PbMV
-----END PGP SIGNATURE-----

--3bu1fC7IQNux7ix3Z3cHTgnTdFEUmuq5n--
