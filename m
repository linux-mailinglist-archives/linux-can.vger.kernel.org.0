Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E8C293A42
	for <lists+linux-can@lfdr.de>; Tue, 20 Oct 2020 13:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393553AbgJTLsd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Oct 2020 07:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393373AbgJTLsb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Oct 2020 07:48:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535F0C061755
        for <linux-can@vger.kernel.org>; Tue, 20 Oct 2020 04:48:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kUq7x-0000G1-Kq; Tue, 20 Oct 2020 13:48:29 +0200
Received: from [IPv6:2a03:f580:87bc:d400:c351:f59d:74d9:d207] (unknown [IPv6:2a03:f580:87bc:d400:c351:f59d:74d9:d207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0713E57E208;
        Tue, 20 Oct 2020 11:48:27 +0000 (UTC)
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
 <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
Message-ID: <116918a9-e09a-d1d6-f3b6-d6af4a9d0ac2@pengutronix.de>
Date:   Tue, 20 Oct 2020 13:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8bXClyJUzjtgzm3L5831VD7f7AgCxZaHW"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8bXClyJUzjtgzm3L5831VD7f7AgCxZaHW
Content-Type: multipart/mixed; boundary="hDRyJGOAZ6GzZOKF70TtqW7v00ZD1nHxy";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <116918a9-e09a-d1d6-f3b6-d6af4a9d0ac2@pengutronix.de>
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
 <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>

--hDRyJGOAZ6GzZOKF70TtqW7v00ZD1nHxy
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/20/20 1:30 PM, Vincent Mailhol wrote:
>> On 19.10.20 21:05, Marc Kleine-Budde wrote:
>>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>
>>> In classical CAN, the length of the data (i.e. CAN payload) is not
>>> always equal to the DLC! If the frame is a Remote Transmission Reques=
t
>>> (RTR), data length is always zero regardless of DLC value and else, i=
f
>>> the DLC is greater than 8, the length is 8. Contrary to common belief=
,
>>> ISO 11898-1 Chapter 8.4.2.3 (DLC field) do allow DLCs greater than 8
>>> for Classical Frames and specifies that those DLCs shall indicate tha=
t
>>> the data field is 8 bytes long.
>>>
>>> Above facts are widely unknown and so many developpers uses the "len"=

>>> field of "struct canfd_frame" to get the length of classical CAN
>>> frames: this is incorrect!
>>>
>>> This patch introduces function get_can_len() which can be used in
>>> remediation. The function takes the SKB as an input in order to be
>>> able to determine if the frame is classical or FD.
>>>
>>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>> Link: https://lore.kernel.org/r/20201002154219.4887-4-mailhol.vincent=
@wanadoo.fr
>>> [mkl: renamed get_can_len() -> can_get_len()]
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>   include/linux/can/dev.h | 23 +++++++++++++++++++++++
>>>   1 file changed, 23 insertions(+)
>>>
>>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>>> index 41ff31795320..2bb132fc6d88 100644
>>> --- a/include/linux/can/dev.h
>>> +++ b/include/linux/can/dev.h
>>> @@ -192,6 +192,29 @@ u8 can_dlc2len(u8 can_dlc);
>>>   /* map the sanitized data length to an appropriate data length code=
 */
>>>   u8 can_len2dlc(u8 len);
>>>  =20
>>> +/*
>>> + * can_get_len(skb) - get the length of the CAN payload.
>>> + *
>>> + * In classical CAN, the length of the data (i.e. CAN payload) is no=
t
>>> + * always equal to the DLC! If the frame is a Remote Transmission
>>> + * Request (RTR), data length is always zero regardless of DLC value=

>>> + * and else, if the DLC is greater than 8, the length is 8. Contrary=

>>> + * to common belief, ISO 11898-1 Chapter 8.4.2.3 (DLC field) do allo=
w
>>> + * DLCs greater than 8 for Classical Frames and specifies that those=

>>> + * DLCs shall indicate that the data field is 8 bytes long.
>>> + */
>>> +static inline u8 can_get_len(const struct sk_buff *skb)
>>> +{
>>> +     const struct canfd_frame *cf =3D (const struct canfd_frame *)sk=
b->data;
>>> +
>>> +     if (can_is_canfd_skb(skb))
>>> +             return min_t(u8, cf->len, CANFD_MAX_DLEN);
>>> +     else if (cf->can_id & CAN_RTR_FLAG)
>>> +             return 0;
>>> +     else
>>> +             return min_t(u8, cf->len, CAN_MAX_DLEN);
>>> +}
>>
>> The main idea behind this patch and patch 05/16 is to provide a correc=
t
>> statistic in the tx bytes, right?
>>
>> A simple test for the CAN_RTR_FLAG will do the job as all the length
>> sanitizing is already done in the tx path by can_dropped_invalid_skb()=

>> in all known drivers right *before* the skb is stored in the echo skb =
array.
>>
>> IMO there's no need for a separate helper function. Maybe a macro whic=
h
>> should have something with 'payload' in its name - to determine the tx=

>> byte statistics based on CAN_RTR_FLAG ...
>=20
> Actually, the main idea is not only to provide a valid length for the
> tx statistics.
>=20
> First fact is that many of the drivers (if not all?) will have the
> same issue for the rx statistics as well, so this helper function can
> be beneficial in other locations as well but that is not yet the main
> point.
>=20
> What bugs me the most, is that there is a global misunderstanding of
> the definition of the Classical CAN frame's DLC in the kernel.
>=20
> ISO 11898-1:2015 tells us in section 8.4.2.4 "DLC field" that, I
> quote: "[...]  *This DLC shall consist of 4 bit*. The admissible
> number of data bytes for Classical Frames shall range from 0 to
> 8. DLCs in the range of 0 to 7 shall indicate data fields of length of
> 0 byte to 7 byte. In Classical Frames, *all other DLCs shall indicate
> that the data field is 8 bytes long*. [...]"
>=20
> So the DLC is a 4 bits value (meaning from 0 to 15) and all values
> from 8 to 15 designate a data length of 8.
>=20
> The real idea is to have an ISO 11898-1 compliant function to retrieve
> the length.
>=20
> That said, I hear your comment that the DLC is sanitized in
> can_dropped_invalid_skb(). However, what bothers me is that this
> sanitazation is done on false assumptions: Classical frames with DLC
> greater than 8 and lower or equal to 15, which are valid by the
> standard, are being discarded.
>=20
> To give you the full picture, I plan to send a RFC to fix this DLC
> issue to allow Classical CAN frame with DLCs between 9 and 15 to be
> sent and received in Socket CAN.  This can_get_len() function is one
> piece of it, however, because I also found the bad RTR length issue, I
> thought to introduce this one in advance. Sorry for the lack of
> context.
>=20
> The RFC I am thinking of will not be trivial. The main reason is that
> the macro CAN_MAX_DLC which is incorrectly set to 8 instead of 15 is
> exposed to the user land in include/linux/can.h. Modifying it would be
> a no-go because we do not want to break user space. The direction
> would be to have a socket option to set the maximum DLC to 15 on
> demand and to keep it to 8 by default (this way, niche users who needs
> this can do so but other people are not impacted).
>=20
> One question you might ask is: "why should be allow DLC greater than
> 8?". One concrete use case is security testing. In order to check for
> vulnerabilities, we want to send such frames for test coverage
> (especially during fuzz testing). Aside of that I do not know other
> use cases. I am not aware of any OEM that would use this in production
> but I still want to push to have this option in the kernel just for
> the security testing reason.
>=20
> I hope that you now understand the full idea behind this patch. If you
> agree with my comments, please reconsider adding that patch. If I
> failed to convince you and if you prefer to first see the full
> picture, then I am OK to go with the simple test for the CAN_RTR_FLAG
> as you suggested in your other patch and will come back to you later
> on the MAX DLC topic when ready.
>=20
> Thanks for reading me until the end!

Ok, I see your point. I'll keep Oliver's patch on linux-can/testing.

If you want to improve the stack toward more 11898-1:2015 complience plea=
se make
that a dedicated series.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--hDRyJGOAZ6GzZOKF70TtqW7v00ZD1nHxy--

--8bXClyJUzjtgzm3L5831VD7f7AgCxZaHW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+OzocACgkQqclaivrt
76lMaQf/S4hxz48LqTHsQQpql7OsF/FQTEbKe5N3tE/yX9tRpe2B24bMh+yrJC4a
RcAQsvmbvDqixa5+fD51Xjj7fTWdZUYPwG+L/jmY9JVNri2K0Ih758/8yDzWOGtT
D0qq13eGYZmvPb+fpZTMp0TJ7dLJRGaJCgVa9zrJCGazxcrhPnWtV/vMEeNR/cOA
meqjJ2Eh8P7gogu/vzDLTioXeNG1QWWlidW+kdiflk971vpUYGOpnOVcVIB2eBAI
dmHGTr42IuuiSFVbWVEETfusTdO6GQmmrrlhhGOYnlRymWIQh5SFLpKLfbrnbC76
2ap2nPiuBKzwm4WThypPzwJfvEMmpA==
=d1O3
-----END PGP SIGNATURE-----

--8bXClyJUzjtgzm3L5831VD7f7AgCxZaHW--
