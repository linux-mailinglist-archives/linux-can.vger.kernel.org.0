Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B48CC45
	for <lists+linux-can@lfdr.de>; Wed, 14 Aug 2019 09:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfHNHDl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Aug 2019 03:03:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57951 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHNHDk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Aug 2019 03:03:40 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hxnJr-0001XQ-Dg; Wed, 14 Aug 2019 09:03:39 +0200
Received: from [IPv6:2001:67c:670:202:595f:209f:a34b:fbc1] (unknown [IPv6:2001:67c:670:202:595f:209f:a34b:fbc1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 588F9444FAA;
        Wed, 14 Aug 2019 07:03:38 +0000 (UTC)
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
 <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
 <f0c82e62-0b97-68eb-2bcb-27c6e92a113c@hartkopp.net>
 <2f24fc11-8123-8384-bf1c-63ee71424d27@pengutronix.de>
 <65c2946b-15d0-e6cb-a28e-d0b713b6a256@hartkopp.net>
 <1684a411-e05c-a7a0-2b65-ceefc68e6b12@pengutronix.de>
 <727ad8d4-acc3-d72d-613e-fb3429f670f6@hartkopp.net>
 <6acd5e5b-764a-f3f9-8e2c-6dacd3923e7e@pengutronix.de>
 <9b4ca3eb-c3b9-926c-9b86-6077229791be@hartkopp.net>
 <e8b96c8b-5942-d6ff-f61f-dffd1c99c942@pengutronix.de>
 <eeaf5a93-82ae-f2fb-c4cc-1c9f7f926171@hartkopp.net>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
Message-ID: <6663f38d-61f7-d258-ebd5-86a0e16c6b68@pengutronix.de>
Date:   Wed, 14 Aug 2019 09:03:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eeaf5a93-82ae-f2fb-c4cc-1c9f7f926171@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="RMJl4hNBdidXXyphaGj2LV2oWtTasCndG"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RMJl4hNBdidXXyphaGj2LV2oWtTasCndG
Content-Type: multipart/mixed; boundary="VuK1wahVqh95Oy35nGKvHBgGSAFIRpkXP";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <6663f38d-61f7-d258-ebd5-86a0e16c6b68@pengutronix.de>
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
 <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
 <f0c82e62-0b97-68eb-2bcb-27c6e92a113c@hartkopp.net>
 <2f24fc11-8123-8384-bf1c-63ee71424d27@pengutronix.de>
 <65c2946b-15d0-e6cb-a28e-d0b713b6a256@hartkopp.net>
 <1684a411-e05c-a7a0-2b65-ceefc68e6b12@pengutronix.de>
 <727ad8d4-acc3-d72d-613e-fb3429f670f6@hartkopp.net>
 <6acd5e5b-764a-f3f9-8e2c-6dacd3923e7e@pengutronix.de>
 <9b4ca3eb-c3b9-926c-9b86-6077229791be@hartkopp.net>
 <e8b96c8b-5942-d6ff-f61f-dffd1c99c942@pengutronix.de>
 <eeaf5a93-82ae-f2fb-c4cc-1c9f7f926171@hartkopp.net>
In-Reply-To: <eeaf5a93-82ae-f2fb-c4cc-1c9f7f926171@hartkopp.net>

--VuK1wahVqh95Oy35nGKvHBgGSAFIRpkXP
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/9/19 7:29 PM, Oliver Hartkopp wrote:
>> Which race condition do you have in mind?
>=20
> E.g. you create a can-gw job that forwards the incoming CAN frame to 10=
=20
> different vcan's.
>=20
> These 10 skb's have been cloned which means their skb->data points to=20
> the exact same location. When now each vcan instance on a multicore=20
> system reads and writes the length info you have a classical race on=20
> that one memory location.

Thanks. I've totally missed the point that can-gw can forward CAN frames
to more than one interface.

>> For loopback ("can_put_echo_skb()"), I see a race condition in some CA=
N
>> drivers: They first do a can_put_echo_skb(), then keep using the skb t=
o
>> write ->data into the hardware.
>>
>> If we modify the skb in can_put_echo_skb(), then the CAN driver will s=
ee
>> the sanitized struct canfd_frame::len. This means for dlc =3D=3D 13, 1=
4, 15
>> the driver will write more data into the hardware than needed. It
>> probably depends on the HW what the controller sends out if you have a=

>> dlc =3D=3D 14 (which means len up to 48 bytes) but only write 33 bytes=
 into
>> the registers.
>=20
> Then you have uninitialized content from the CAN registers and not from=
=20
> the skb on the wire :-)

ACK.

>> While other drivers don't touch the skb after can_put_echo_skb().
>>
>> Can we modify the ->len in can_get_echo_skb() (or the __ variant) righ=
t
>> before pushing the skv into the networking stack? We have to look at t=
he
>> data path for driver that cannot/don't use can_get_echo_skb() due to n=
o
>> TX-complete interrupt.
>>
>> Looking at vcan, where's the race condition when modifying the skb in
>> vcan_tx()?
>=20
> As written above. Additionally the echo is mostly done in can_send() in=
=20
> af_can.c. And vcan_tx() is just a /dev/null from the packet flow=20
> perspective.

With can-gw, the skb hitting vcan may be cloned and thus changing the
data is not allowed. But what about the loopback path? Are there
usecases where a cloned skb used?

>>> I tend to sanitize the CAN FD length values when they are introduced
>>> into the system (CAN_RAW, CAN_BCM, CAN FD drivers*) and when they are=

>>> modified (CAN_GW).
>>>
>>> * =3D already done
>>
>> You miss the datapath that directly injects packets into the networkin=
g
>> stack with the mechanism that tcpdump uses but the sending into the
>> kernel instead of receiving (I don't remember the exact name). This pa=
th
>> skips all checks in CAN_RAW. This is why we have the
>> "can_dropped_invalid_skb()" in all drivers.
>=20
> I don't know whether these tools can create ethertype CAN(FD) skbs whic=
h=20
> is mandatory for the CAN stack to process skbs. But if so, you are righ=
t.

You can inject arbitrary packets into the kernel.

>> So from my point of view it makes no sense to sanitize the len value i=
n
>> gw, as the drivers convert from len to dlc anyways.
>>
>> What do I see when I attach a candump to the src and another one to th=
e
>> dst interface? I suspenct:
>>
>> src) the unmodified canfd_frame with sanitized len, as the controller
>> knowns only the dlc.
>>
>> dst) the modified-by-gw canfd_frame, _after_ the loopback by the drive=
r?
>> If there's neither sanitation in the gw not in the loopback, it's the
>> unsanitized len.
>>
>> When I have another application sending on the dst interface, the
>> candump receives the un-sanitized, as there's no sanitation in the loo=
pback.
>>
>> For me the loopback is and vcan is the part to modify, as gw is just a=

>> another source of unsanitized len information.
>>
>>> My idea was to fix things up when someone manipulates the CAN or CAN =
FD
>>> length field with can-gw.
>>
>> For CAN you don't have to do any sanitization, only check if the len i=
s
>> <=3D 8.
>=20
> Mapping [0..8] to [0..8] is pointless but correct :-)

:p

>>> Or do you think I should just omit it and let the data flow as-is?
>>
>> ACK
>=20
> Ok, will send a v2 with a removed sanitized CAN FD length. The=20
> boundaries of the max length information (max 8 or 64) is tested anyway=
=2E

Tnx. It's in the linux-can-next-for-5.4-20190814 pull reqeust.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VuK1wahVqh95Oy35nGKvHBgGSAFIRpkXP--

--RMJl4hNBdidXXyphaGj2LV2oWtTasCndG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1TskMACgkQWsYho5Hk
nSAYTgf+OKEB8o4cqJ2CFk3I+rPaNz/A2q1nwzZxaw6YbcOKY/rfX4ve2HwRbrT/
vy4yMXPOUSXMsVpUIO19huXPOElLgegFY3qm0SJk+b6Bn6+MFuYvYwWfLTRG0Yh5
X1VzcOInAnnZTKuwrYDONY6eVDaIiq2ZxcEeG8E45uub3wyCGbQrKyueaZxTQYTD
NS9CAH4PIpAqxUMcSgVZ8PRE8L0H46j2XsD8N6XWyanfHZxrN+e+HoM7aiyBonEz
M+pxUJRk4xs8I4cEi1ZIWoWOqdLvBIDn0Z+0Vcbbc2gtVqx0a5k7ELbtWD4Ca84o
3B2VVbbz3noK4f2dyd0W5KJ1yRBB6A==
=6KVP
-----END PGP SIGNATURE-----

--RMJl4hNBdidXXyphaGj2LV2oWtTasCndG--
