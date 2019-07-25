Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4805D751A1
	for <lists+linux-can@lfdr.de>; Thu, 25 Jul 2019 16:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfGYOpJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Jul 2019 10:45:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54041 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbfGYOpJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jul 2019 10:45:09 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hqezT-0004X6-RW; Thu, 25 Jul 2019 16:45:07 +0200
Received: from [IPv6:2003:c7:729:c79e:c9d4:83d5:b99:4f4d] (unknown [IPv6:2003:c7:729:c79e:c9d4:83d5:b99:4f4d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CEBDD438F58;
        Thu, 25 Jul 2019 14:45:06 +0000 (UTC)
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
 <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
 <f0c82e62-0b97-68eb-2bcb-27c6e92a113c@hartkopp.net>
 <2f24fc11-8123-8384-bf1c-63ee71424d27@pengutronix.de>
 <65c2946b-15d0-e6cb-a28e-d0b713b6a256@hartkopp.net>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
Message-ID: <1684a411-e05c-a7a0-2b65-ceefc68e6b12@pengutronix.de>
Date:   Thu, 25 Jul 2019 16:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <65c2946b-15d0-e6cb-a28e-d0b713b6a256@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3VUmDhRvfAUNOgnn7lTGBICmRniaU6VX3"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3VUmDhRvfAUNOgnn7lTGBICmRniaU6VX3
Content-Type: multipart/mixed; boundary="Gwfnas1cGmm2wuxJIA8zA7qndfi6MuDEy";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <1684a411-e05c-a7a0-2b65-ceefc68e6b12@pengutronix.de>
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
 <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
 <f0c82e62-0b97-68eb-2bcb-27c6e92a113c@hartkopp.net>
 <2f24fc11-8123-8384-bf1c-63ee71424d27@pengutronix.de>
 <65c2946b-15d0-e6cb-a28e-d0b713b6a256@hartkopp.net>
In-Reply-To: <65c2946b-15d0-e6cb-a28e-d0b713b6a256@hartkopp.net>

--Gwfnas1cGmm2wuxJIA8zA7qndfi6MuDEy
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 7/25/19 3:59 PM, Oliver Hartkopp wrote:
> On 25.07.19 09:04, Marc Kleine-Budde wrote:
>> On 7/24/19 8:07 PM, Oliver Hartkopp wrote:
>=20
>>> If the CAN FD length was 12 before the modification and the modificat=
ion
>>> was to "set bit 0 in the length field" then you get 13.
>>
>> ok
>>
>>> But the length value of 13 is an illegal value for CAN FD length and =
can
>>> not been sent by a CAN FD controller.
>>
>> ok, but that doesn't matter, because all CAN-FD drivers must convert
>> from struct canfd_frame::len to the dlc (=3D=3D their register value)
>> anyways using the can_len2dlc() function.
>>
>>> Therefore we need a round-up to get the next valid CAN FD length valu=
e
>>> (in our example it get's from 13 to 16).
>>
>> I don't think this is needed, the user space might send such packets a=
nd
>> the drivers have to deal with then anyways.
>=20
> Ok, maybe pointing to the driver lead to a wrong discussion.
>=20
> We manipulate the length info and end with a CAN FD frame which has a=20
> length which is unspecified in the CAN standard.

Every user can generate such frames...

> A valid CAN FD frame can not have a data length of 13.

Ok, let's put it this way: after decoding the dlc value from a real CAN
FD frame you received over the wire, the length will not be 13.

> So we fix this up after manipulation.

Why?

I don't know if this is possible with can-gw, but can you do other
calculations based on the len, so you might need the sanitized length.

Every user can generate such frames and the drivers have to deal with it
anyways.

> Neither the CAN controller

In the TX path the CAN controller driver will translate the len into the
dlc, so the CAN _controller_ will not see the wrong length of e.g. 13.

> nor the user reading from a socket should ever get an invalid CAN FD
> frame.

What happens if the user sends a CAN FD frame with len =3D=3D 13? All hw
drivers will convert this into a DLC.

What about the loopback'ed frames?
I don't have CAN FD hardware, so I cannot test.
What about vcan?

vcan doesn't do the len -> dlc -> len conversion:

I manupulated the cansend to send a CANFD frame with the non sanitized le=
n:

> index 8db9fd21aa99..16dbd867f493 100644
> --- a/cansend.c
> +++ b/cansend.c
> @@ -132,7 +132,7 @@ int main(int argc, char **argv)
>                 }
> =20
>                 /* ensure discrete CAN FD length values 0..8, 12, 16, 2=
0, 24, 32, 64 */
> -               frame.len =3D can_dlc2len(can_len2dlc(frame.len));
> +               //frame.len =3D can_dlc2len(can_len2dlc(frame.len));
>         }

Then I see:

> ./cansend vcan0 '5A1##0112233445566778899aa'
> write(3, "\xa1\x05\x00\x00\x0a\x00\x00\x00\x11\x22\x33\x44\x55\x66\x77\=
x88\x99\xaa\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"..., =
72) =3D 72
                             ^^^

len =3D=3D 0xa =3D=3D 10

and the corresponding candump:

> recvmsg(3, {msg_name=3D{sa_family=3DAF_CAN, sa_data=3D"\x00\x00\x05\x00=
\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"},
> msg_namelen=3D24->16,
> msg_iov=3D[{iov_base=3D"\xa1\x05\x00\x00\x0a\x00\x00\x00\x11\x22\x33\x4=
4\x55\x66\x77\x88\x99\xaa\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00"...,
                                       ^^^
len =3D=3D 0xa =3D=3D 10

> iov_len=3D72}], msg_iovlen=3D1, msg_controllen=3D0, msg_flags=3DMSG_DON=
TROUTE},
> 0) =3D 72

Which is then displayed as:

>   vcan0  5A1  [10]  11 22 33 44 55 66 77 88 99 AA

Do we need to sanitize the CAN FD frames somewhere in the stack? Note
you can completely bypass the PF_CAN and insert the frames into the
packet scheduler so they end up unchanged in the driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Gwfnas1cGmm2wuxJIA8zA7qndfi6MuDEy--

--3VUmDhRvfAUNOgnn7lTGBICmRniaU6VX3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl05wG4ACgkQWsYho5Hk
nSBxRQf/cMo8EicxucnF5SW1FwGj3i2Y14kv7W3ymZqyBwLherY8Kdlvn8CoXhJq
d6Ow6foe6R3kg82PzlH4Kc4GllDQMUPIXqA3TjDUisUIv/iK9toeTWuh5Vh2aN2w
yPvmWMO0hl+xsDbafIom0ROn2yhgdcV+5diVO2i7YgTc8LR8FdHJK+r/iHypVASS
Q5oH0icy6o3ttKhkiH7oQ1z7Zb6S1jGxQBFIhkQ8s6bAi1Is36FIxpR3xPq8iwU9
ehSskqKMfRfkFdX2wmmu2h+cGiq9+VmNDNRoiNfkMctwczp3B7hCdlrbwrx7xc+L
z4pGC3Sjq8xuzT0Ca4/YQkfBKei7dQ==
=2ghy
-----END PGP SIGNATURE-----

--3VUmDhRvfAUNOgnn7lTGBICmRniaU6VX3--
