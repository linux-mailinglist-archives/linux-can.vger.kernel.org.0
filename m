Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593752F1038
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 11:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbhAKKhY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 05:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbhAKKhY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 05:37:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F07C061786
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 02:36:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kyuZ0-0003J1-Oz; Mon, 11 Jan 2021 11:36:42 +0100
Received: from [IPv6:2a03:f580:87bc:d400:2f09:9e2:49c8:f829] (unknown [IPv6:2a03:f580:87bc:d400:2f09:9e2:49c8:f829])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D33C85BF717;
        Mon, 11 Jan 2021 10:36:41 +0000 (UTC)
Subject: Re: [PATCH] can: dev: extend can_put_echo_skb() to handle frame_len
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <20210109174013.534145-1-mkl@pengutronix.de>
 <20210109174013.534145-12-mkl@pengutronix.de>
 <CAMZ6RqKfVZ-Z10EK611NZots0Q61bJ6b5TPxSgWAv3nWo0+ryg@mail.gmail.com>
 <CAMZ6RqJ23-T8doazD+=0AO38VzetfudLWO3si+pO+mqE3vSgKw@mail.gmail.com>
 <20210111061335.39983-1-mailhol.vincent@wanadoo.fr>
 <28ab072d-a075-ce6b-6fed-a6d623a86a52@pengutronix.de>
 <CAMZ6Rq+irzbsiLP+bKL=h4JRh7pNXacwc9v4YO4NK=eNqOT3ew@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <33e0b567-2d99-de6e-7ca5-2a7a808554c7@pengutronix.de>
Date:   Mon, 11 Jan 2021 11:36:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+irzbsiLP+bKL=h4JRh7pNXacwc9v4YO4NK=eNqOT3ew@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VxvJUH1vLHGXJ7Lm5FRx97203sqtuX4sG"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VxvJUH1vLHGXJ7Lm5FRx97203sqtuX4sG
Content-Type: multipart/mixed; boundary="ms2im3DTlQ3hmqUaL6xVFOjKofN554KFo";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: linux-can <linux-can@vger.kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <33e0b567-2d99-de6e-7ca5-2a7a808554c7@pengutronix.de>
Subject: Re: [PATCH] can: dev: extend can_put_echo_skb() to handle frame_len
References: <20210109174013.534145-1-mkl@pengutronix.de>
 <20210109174013.534145-12-mkl@pengutronix.de>
 <CAMZ6RqKfVZ-Z10EK611NZots0Q61bJ6b5TPxSgWAv3nWo0+ryg@mail.gmail.com>
 <CAMZ6RqJ23-T8doazD+=0AO38VzetfudLWO3si+pO+mqE3vSgKw@mail.gmail.com>
 <20210111061335.39983-1-mailhol.vincent@wanadoo.fr>
 <28ab072d-a075-ce6b-6fed-a6d623a86a52@pengutronix.de>
 <CAMZ6Rq+irzbsiLP+bKL=h4JRh7pNXacwc9v4YO4NK=eNqOT3ew@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+irzbsiLP+bKL=h4JRh7pNXacwc9v4YO4NK=eNqOT3ew@mail.gmail.com>

--ms2im3DTlQ3hmqUaL6xVFOjKofN554KFo
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/11/21 11:35 AM, Vincent MAILHOL wrote:
> On Mon. 11 Jan 2021 at 18:38, Marc Kleine-Budde <mkl@pengutronix.de> wr=
ote:
>>
>> On 1/11/21 7:13 AM, Vincent Mailhol wrote:
>> [...]
>>
>>> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
>>> index 568dc28f7a4e..64bd2b60febc 100644
>>> --- a/drivers/net/can/dev/skb.c
>>> +++ b/drivers/net/can/dev/skb.c
>>> @@ -38,7 +38,7 @@ void can_flush_echo_skb(struct net_device *dev)
>>>   * priv->echo_skb, if necessary.
>>>   */
>>>  int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>>> -                  unsigned int idx)
>>> +                  unsigned int idx, unsigned int frame_len)
>>>  {
>>>       struct can_priv *priv =3D netdev_priv(dev);
>>>
>>> @@ -62,6 +62,10 @@ int can_put_echo_skb(struct sk_buff *skb, struct n=
et_device *dev,
>>>               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>>>               skb->dev =3D dev;
>>>
>>> +             /* save frame_len to reuse it when transmission is comp=
leted */
>>> +             if (frame_len)
>>> +                     can_skb_prv(skb)->frame_len =3D frame_len;
>>> +
>>
>> I think we can assign it unconditionally?
>=20
> Ack, I prepare the v2 right away and post it in answer to this
> message.
>=20
> Will also rename the patch subject from
> "can: dev: extend can_put_echo_skb() to handle frame_len"
> to
> "can: dev: can_put_echo_skb(): extend to store can frame length".
>=20
> This way the name is more aligned with your patch "can: dev:
> can_get_echo_skb(): extend to return can frame length".

no need to - I'll send v2 in a sec.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--ms2im3DTlQ3hmqUaL6xVFOjKofN554KFo--

--VxvJUH1vLHGXJ7Lm5FRx97203sqtuX4sG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl/8KjYACgkQqclaivrt
76m0/wgAsIUG9NQtsWVFx2qL91+iXw/Q/0ed8Ke9Hd6C7vS1F1afHj4yAV2Ya1GK
iINHcJZBtvnUzz48KQZCRTSmgElEUS2HyponrXHHOgqjhvLJVVjtHqTOh+i8IRtX
rz5F7OLSLxA3QdQtXEcuZZuzfS447SyFCV3JJ1egjEXdjawfC9Q5e8snJemGcun1
z4VFcxotFx2oTakI19vg76sX7QRYrhiV+2OPIEN+BbOIJ0LUq5ysAVCTQBxPZ54g
t0hF4Mnbd5nu/fBcU0NAob2fEZtLhg9OUEJkRs3rgWtF0jC9t3lw/Onu1vrPpRgh
rN5VeNpRTObx31mXiCvfaV/8JY3zfQ==
=7TRS
-----END PGP SIGNATURE-----

--VxvJUH1vLHGXJ7Lm5FRx97203sqtuX4sG--
