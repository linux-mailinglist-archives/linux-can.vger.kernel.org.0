Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DCA2DADFF
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 14:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgLONa4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 08:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgLONay (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 08:30:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B9C0617A7
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 05:30:14 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpAP6-0008W4-IK; Tue, 15 Dec 2020 14:30:12 +0100
Received: from [IPv6:2a03:f580:87bc:d400:d81b:8ab4:f042:fe4f] (unknown [IPv6:2a03:f580:87bc:d400:d81b:8ab4:f042:fe4f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3FFAB5ADE91;
        Tue, 15 Dec 2020 13:30:11 +0000 (UTC)
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
References: <20201214091426.417867-1-mkl@pengutronix.de>
 <CAMZ6Rq+t630Fv_vYDmxitY47ScKMbEp+YCeZ_PAqTngOHajQ2g@mail.gmail.com>
 <2c3a332a-f3c5-7052-8276-44980efc3442@pengutronix.de>
 <CAMZ6RqJGrgMyWLRVBk9zUn0-pg-J+oRKhDtQ8kyVvBgF=Hi89A@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH RFC net-next] can: dev: can_skb_get_dll_len(): introduce
 function to get data length of frame in data link layer
Message-ID: <d3326243-ab66-3e5c-8b6c-e9ce62da1d9d@pengutronix.de>
Date:   Tue, 15 Dec 2020 14:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqJGrgMyWLRVBk9zUn0-pg-J+oRKhDtQ8kyVvBgF=Hi89A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="p2Z7tGQnkAEj2Qb7VjpjIPYmpFWSlYPRU"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p2Z7tGQnkAEj2Qb7VjpjIPYmpFWSlYPRU
Content-Type: multipart/mixed; boundary="zl4JPe80A7a0N18qkXh8nYwlrpDEQH1D5";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: linux-can <linux-can@vger.kernel.org>,
 Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Message-ID: <d3326243-ab66-3e5c-8b6c-e9ce62da1d9d@pengutronix.de>
Subject: Re: [PATCH RFC net-next] can: dev: can_skb_get_dll_len(): introduce
 function to get data length of frame in data link layer
References: <20201214091426.417867-1-mkl@pengutronix.de>
 <CAMZ6Rq+t630Fv_vYDmxitY47ScKMbEp+YCeZ_PAqTngOHajQ2g@mail.gmail.com>
 <2c3a332a-f3c5-7052-8276-44980efc3442@pengutronix.de>
 <CAMZ6RqJGrgMyWLRVBk9zUn0-pg-J+oRKhDtQ8kyVvBgF=Hi89A@mail.gmail.com>
In-Reply-To: <CAMZ6RqJGrgMyWLRVBk9zUn0-pg-J+oRKhDtQ8kyVvBgF=Hi89A@mail.gmail.com>

--zl4JPe80A7a0N18qkXh8nYwlrpDEQH1D5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/15/20 1:40 PM, Vincent MAILHOL wrote:
[...]
>>> This is just an overview, the data bitrate is also applied to some
>>> other fields of the frame (e.g. the CRC). So when creating the macro
>>> for the CANFD_FRAME_OVERHEAD, it should be split between the nominal
>>> and data bitrates.
>>
>> I think we shouldn't mess with the number of bytes depending on BRS. W=
hen it
>> turns out that for CAN-FD this is not exact enough, we should look int=
o the wifi
>> drivers. As wifi doesn't even have a constant channel speed.
>=20
> I have to admit that I was also not a fan of that idea, but it was the
> only thing I could think of.
>=20
> I am curious to see how this issue could be handled in a smarter way.

Let's wait until we have a "problem" with that :)

[...]

>> Talking about CAN-FD and naming: For the CAN-FD frame/dll length we ne=
ed the
>> actual length of the data field.
>>
>> The code looks like this:
>>
>>> static const u8 len2XXX[] =3D {
>>>       0, 1, 2, 3, 4, 5, 6, 7, 8,      /* 0 - 8 */
>>>       12, 12, 12, 12,                 /* 9 - 12 */
>>>       16, 16, 16, 16,                 /* 13 - 16 */
>>>       20, 20, 20, 20,                 /* 17 - 20 */
>>>       24, 24, 24, 24,                 /* 21 - 24 */
>>>       32, 32, 32, 32, 32, 32, 32, 32, /* 25 - 32 */
>>>       40, 40, 40, 40, 40, 40, 40, 40, /* 33 - 40 */
>>>       48, 48, 48, 48, 48, 48, 48, 48  /* 41 - 48 */
>>> };
>>>
>>> /* map the sanitized data length to an appropriate XXX length */
>>> u8 can_len2XXX(u8 len)
>>> {
>>>       if (unlikely(len > ARRAY_SIZE(len2XXX)))
>>>               return 64;
>>>
>>>       return len2XXX[len];
>>> }
>>
>> Have you got a good name for this, too?

I've send a v2...(hmmm, but missed the v2)

> Before speaking of the naming, let me discuss the how to.
>=20
> For CAN-FD, the overhead length (i.e. all fields of the frame minus
> the data) might vary depending on:
>    * Whether the frame is SFF or EFF

ACK, included in the v2

>    * Size of the CRC: either 15, 17 or 21 depending only on the length
>      of the data.

I haven't looked into the actual standard, but from what I have found, th=
e CRC
for CAN-FD frames is 17 (for data length 0...16 bytes) or 21 (for data le=
ngth >
16 byes). Also there are 4 or 5 fixed stuff bits (corresponding to 17 or =
21 bits
of CRC) in the CRC.

I got the impression that even 0...8 byte CAN-FD frames use a CRC of 17.

> I did not fully check the ISO standard, but I hope I did not forget ano=
ther
> field of variable length in the above list.
>=20
> The CRC field will be handled in the len2XXX[] table, the SFF/EFF will
> be handled in the can_len2XXX() function.

For now I've selected the 21 bit CRC, for CAN-FD:

> #define CANFD_DLL_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
=3D=3D 8 bytes

for CRC17 it would be 5 bits less =3D> 56 bit =3D> 7 bytes


> #define CANFD_DLL_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
=3D=3D 10 bytes

for CRC17 it would be 5 bits less =3D> 75 bits =3D> 8 bytes

I think that 1 bit is not worth the trouble.

> The other fields (sof, dlc, eof, ...) are constant, and can be
> squeezed in either the len2XXX[] table or the can_len2XXX() function.

I want to use the can_fd_data_len2frame_data_len() in the mcp251xfd drive=
r, so
I'd like to keep that.

> The choice of how to group things is fully arbitrary.
>=20
> Some candidates would be:
>   * can_fd_data_len2crc_len[] which would just do return the length on
>     the CRC and leave all other calculation to the can_len2XXX()
>     function.
>   * can_fd_data_len2ssf_len[] which will return the full frame length
>     as if it was a SFF. The can_len2XXX() function would only do the
>     very last step and add the length difference between the SFF and
>     EFF if relevant.
>=20
> All in between mix are also possible but would result in more
> convoluted naming (e.g. can_fd_data_len2data_crc_len[] that would
> return the data length plus the CRC length).
>=20
> In all scenarios, the can_len2XXX() function would serve the same
> purpose: calculate the full frame length. So I propose to name it
> can_fd_data_len2frame_len().

What about: can_fd_data_len2frame_data_len()

As it only the frame's data length, not the complete frame len. (I don't =
mind
long function names :))

> All that said, it is hard for me to pick a favorite. Out of all above
> idea, I propose to keep the second candidate:
>    * can_fd_data_len2ssf_len[]
> But this is with no big conviction.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--zl4JPe80A7a0N18qkXh8nYwlrpDEQH1D5--

--p2Z7tGQnkAEj2Qb7VjpjIPYmpFWSlYPRU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl/YumAACgkQqclaivrt
76kFtQf+JQSe6whi2wqsNii+Gd9tw1I9cMCIJuoLGW62FXz9CoNdXG73i0N6A7eZ
ewaTX5dTcQTWcwr3OMeheporte/ELqzTY/+fLbN8lrEl6t+Zb8waV9vGo5HeU5JF
oFocn7tzJh51zT6LhZe+LSBbJNZt28agnJGuQpxZpVlNJJEtzIssO0lsX5BORMNA
xLFUiJLCEH2CKskA6tab/BH72jtaRmu0NrROEjqNRsC8uu6VV5pe0RtpF/bwy5ZH
j0WiVORsLQE3dhxyPw8LHkSUbYQpeWFVBzKH8Trm+UGQzB0zgv4WSzhHOxHqpGWx
hSjNOVoQUaZ++EkMUCMnGiZfJhGwsA==
=H28f
-----END PGP SIGNATURE-----

--p2Z7tGQnkAEj2Qb7VjpjIPYmpFWSlYPRU--
