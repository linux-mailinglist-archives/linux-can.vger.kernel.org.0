Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1A87CA7
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 16:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfHIO1l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 10:27:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36197 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHIO1l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 10:27:41 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hw5rn-0005T6-4q; Fri, 09 Aug 2019 16:27:39 +0200
Received: from [IPv6:2a03:f580:87bc:d400:595f:209f:a34b:fbc1] (unknown [IPv6:2a03:f580:87bc:d400:595f:209f:a34b:fbc1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F2E6D442232;
        Fri,  9 Aug 2019 14:27:37 +0000 (UTC)
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
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 mQINBFFVq30BEACtnSvtXHoeHJxG6nRULcvlkW6RuNwHKmrqoksispp43X8+nwqIFYgb8UaX
 zu8T6kZP2wEIpM9RjEL3jdBjZNCsjSS6x1qzpc2+2ivjdiJsqeaagIgvy2JWy7vUa4/PyGfx
 QyUeXOxdj59DvLwAx8I6hOgeHx2X/ntKAMUxwawYfPZpP3gwTNKc27dJWSomOLgp+gbmOmgc
 6U5KwhAxPTEb3CsT5RicsC+uQQFumdl5I6XS+pbeXZndXwnj5t84M+HEj7RN6bUfV2WZO/AB
 Xt5+qFkC/AVUcj/dcHvZwQJlGeZxoi4veCoOT2MYqfR0ax1MmN+LVRvKm29oSyD4Ts/97cbs
 XsZDRxnEG3z/7Winiv0ZanclA7v7CQwrzsbpCv+oj+zokGuKasofzKdpywkjAfSE1zTyF+8K
 nxBAmzwEqeQ3iKqBc3AcCseqSPX53mPqmwvNVS2GqBpnOfY7Mxr1AEmxdEcRYbhG6Xdn+ACq
 Dq0Db3A++3PhMSaOu125uIAIwMXRJIzCXYSqXo8NIeo9tobk0C/9w3fUfMTrBDtSviLHqlp8
 eQEP8+TDSmRP/CwmFHv36jd+XGmBHzW5I7qw0OORRwNFYBeEuiOIgxAfjjbLGHh9SRwEqXAL
 kw+WVTwh0MN1k7I9/CDVlGvc3yIKS0sA+wudYiselXzgLuP5cQARAQABtCZNYXJjIEtsZWlu
 ZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPokCVAQTAQoAPgIbAwIeAQIXgAULCQgHAwUV
 CgkICwUWAgMBABYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJcUsSbBQkM366zAAoJECte4hHF
 iupUgkAP/2RdxKPZ3GMqag33jKwKAbn/fRqAFWqUH9TCsRH3h6+/uEPnZdzhkL4a9p/6OeJn
 Z6NXqgsyRAOTZsSFcwlfxLNHVxBWm8pMwrBecdt4lzrjSt/3ws2GqxPsmza1Gs61lEdYvLST
 Ix2vPbB4FAfE0kizKAjRZzlwOyuHOr2ilujDsKTpFtd8lV1nBNNn6HBIBR5ShvJnwyUdzuby
 tOsSt7qJEvF1x3y49bHCy3uy+MmYuoEyG6zo9udUzhVsKe3hHYC2kfB16ZOBjFC3lH2U5An+
 yQYIIPZrSWXUeKjeMaKGvbg6W9Oi4XEtrwpzUGhbewxCZZCIrzAH2hz0dUhacxB201Y/faY6
 BdTS75SPs+zjTYo8yE9Y9eG7x/lB60nQjJiZVNvZ88QDfVuLl/heuIq+fyNajBbqbtBT5CWf
 mOP4Dh4xjm3Vwlz8imWW/drEVJZJrPYqv0HdPbY8jVMpqoe5jDloyVn3prfLdXSbKPexlJaW
 5tnPd4lj8rqOFShRnLFCibpeHWIumqrIqIkiRA9kFW3XMgtU6JkIrQzhJb6Tc6mZg2wuYW0d
 Wo2qvdziMgPkMFiWJpsxM9xPk9BBVwR+uojNq5LzdCsXQ2seG0dhaOTaaIDWVS8U/V8Nqjrl
 6bGG2quo5YzJuXKjtKjZ4R6k762pHJ3tnzI/jnlc1sXzuQENBFxSzJYBCAC58uHRFEjVVE3J
 31eyEQT6H1zSFCccTMPO/ewwAnotQWo98Bc67ecmprcnjRjSUKTbyY/eFxS21JnC4ZB0pJKx
 MNwK6zq71wLmpseXOgjufuG3kvCgwHLGf/nkBHXmSINHvW00eFK/kJBakwHEbddq8Dr4ewmr
 G7yr8d6A3CSn/qhOYWhIxNORK3SVo4Io7ExNX/ljbisGsgRzsWvY1JlN4sabSNEr7a8YaqTd
 2CfFe/5fPcQRGsfhAbH2pVGigr7JddONJPXGE7XzOrx5KTwEv19H6xNe+D/W3FwjZdO4TKIo
 vcZveSDrFWOi4o2Te4O5OB/2zZbNWPEON8MaXi9zABEBAAGJA3IEGAEKACYWIQTBQAugs5ie
 b7x9W1wrXuIRxYrqVAUCXFLMlgIbAgUJAeKNmgFACRArXuIRxYrqVMB0IAQZAQoAHRYhBJrx
 JF84Dn3PPNRrhVrGIaOR5J0gBQJcUsyWAAoJEFrGIaOR5J0grw4H/itil/yryJCvzi6iuZHS
 suSHHOiEf+UQHib1MLP96LM7FmDabjVSmJDpH4TsMu17A0HTG+bPMAdeia0+q9FWSvSHYW8D
 wNhfkb8zojpa37qBpVpiNy7r6BKGSRSoFOv6m/iIoRJuJ041AEKao6djj/FdQF8OV1EtWKRO
 +nE2bNuDCcwHkhHP+FHExdzhKSmnIsMjGpGwIQKN6DxlJ7fN4W7UZFIQdSO21ei+akinBo4K
 O0uNCnVmePU1UzrwXKG2sS2f97A+sZE89vkc59NtfPHhofI3JkmYexIF6uqLA3PumTqLQ2Lu
 bywPAC3YNphlhmBrG589p+sdtwDQlpoH9O7NeBAAg/lyGOUUIONrheii/l/zR0xxr2TDE6tq
 6HZWdtjWoqcaky6MSyJQIeJ20AjzdV/PxMkd8zOijRVTnlK44bcfidqFM6yuT1bvXAO6NOPy
 pvBRnfP66L/xECnZe7s07rXpNFy72XGNZwhj89xfpK4a9E8HQcOD0mNtCJaz7TTugqBOsQx2
 45VPHosmhdtBQ6/gjlf2WY9FXb5RyceeSuK4lVrz9uZB+fUHBge/giOSsrqFo/9fWAZsE67k
 6Mkdbpc7ZQwxelcpP/giB9N+XAfBsffQ8q6kIyuFV4ILsIECCIA4nt1rYmzphv6t5J6PmlTq
 TzW9jNzbYANoOFAGnjzNRyc9i8UiLvjhTzaKPBOkQfhStEJaZrdSWuR/7Tt2wZBBoNTsgNAw
 A+cEu+SWCvdX7vNpsCHMiHtcEmVt5R0Tex1Ky87EfXdnGR2mDi6Iyxi3MQcHez3C61Ga3Baf
 P8UtXR6zrrrlX22xXtpNJf4I4Z6RaLpB/avIXTFXPbJ8CUUbVD2R2mZ/jyzaTzgiABDZspbS
 gw17QQUrKqUog0nHXuaGGA1uvreHTnyBWx5P8FP7rhtvYKhw6XdJ06ns+2SFcQv0Bv6PcSDK
 aRXmnW+OsDthn84x1YkfGIRJEPvvmiOKQsFEiB4OUtTX2pheYmZcZc81KFfJMmE8Z9+LT6Ry
 uSS5AQ0EXFLNDgEIAL14qAzTMCE1PwRrYJRI/RSQGAGF3HLdYvjbQd9Ozzg02K3mNCF2Phb1
 cjsbMk/V6WMxYoZCEtCh4X2GjQG2GDDW4KC9HOa8cTmr9Vcno+f+pUle09TMzWDgtnH92WKx
 d0FIQev1zDbxU7lk1dIqyOjjpyhmR8Put6vgunvuIjGJ/GapHL/O0yjVlpumtmow6eME2muc
 TeJjpapPWBGcy/8VU4LM8xMeMWv8DtQML5ogyJxZ0Smt+AntIzcF9miV2SeYXA3OFiojQstF
 vScN7owL1XiQ3UjJotCp6pUcSVgVv0SgJXbDo5Nv87M2itn68VPfTu2uBBxRYqXQovsR++kA
 EQEAAYkCPAQYAQoAJhYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJcUs0OAhsMBQkB4o0iAAoJ
 ECte4hHFiupUbioQAJ40bEJmMOF28vFcGvQrpI+lfHJGk9zSrh4F4SlJyOVWV1yWyUAINr8w
 v1aamg2nAppZ16z4nAnGU/47tWZ4P8blLVG8x4SWzz3D7MCy1FsQBTrWGLqWldPhkBAGp2VH
 xDOK4rLhuQWx3H5zd3kPXaIgvHI3EliWaQN+u2xmTQSJN75I/V47QsaPvkm4TVe3JlB7l1Fg
 OmSvYx31YC+3slh89ayjPWt8hFaTLnB9NaW9bLhs3E2ESF9Dei0FRXIt3qnFV/hnETsx3X4h
 KEnXxhSRDVeURP7V6P/z3+WIfddVKZk5ZLHi39fJpxvsg9YLSfStMJ/cJfiPXk1vKdoa+FjN
 7nGAZyF6NHTNhsI7aHnvZMDavmAD3lK6CY+UBGtGQA3QhrUc2cedp1V53lXwor/D/D3Wo9wY
 iSXKOl4fFCh2Peo7qYmFUaDdyiCxvFm+YcIeMZ8wO5udzkjDtP4lWKAn4tUcdcwMOT5d0I3q
 WATP4wFI8QktNBqF3VY47HFwF9PtNuOZIqeAquKezywUc5KqKdqEWCPx9pfLxBAh3GW2Zfjp
 lP6A5upKs2ktDZOC2HZXP4IJ1GTk8hnfS4ade8s9FNcwu9m3JlxcGKLPq5DnIbPVQI1UUR4F
 QyAqTtIdSpeFYbvH8D7pO4lxLSz2ZyBMk+aKKs6GL5MqEci8OcFW
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
Message-ID: <e8b96c8b-5942-d6ff-f61f-dffd1c99c942@pengutronix.de>
Date:   Fri, 9 Aug 2019 16:27:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9b4ca3eb-c3b9-926c-9b86-6077229791be@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XzWcunsX7QfeuAbPfVQ9dbTevjO89lJN2"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XzWcunsX7QfeuAbPfVQ9dbTevjO89lJN2
Content-Type: multipart/mixed; boundary="szAs9rl5n7DRs07CzFe4dc0Pnu1cb0D2W";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <e8b96c8b-5942-d6ff-f61f-dffd1c99c942@pengutronix.de>
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
In-Reply-To: <9b4ca3eb-c3b9-926c-9b86-6077229791be@hartkopp.net>

--szAs9rl5n7DRs07CzFe4dc0Pnu1cb0D2W
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 8/9/19 12:27 PM, Oliver Hartkopp wrote:
>>> In fact the only point where can_len2dlc() is active is when the CAN
>>> frame is sent with a real CAN (FD) controller.
>>>
>>> Maybe it would make sense to create a special flag for the can-gw
>>> modifications like CGW_FLAGS_CAN_FD_SANITIZE_LEN.
>>
>> My point is, it makes no sense to do any CAN-FD related len sanitisati=
on
>> in the can-gw, as the user will not see any strange length.
>>
>>> So we could point out that the CAN FD length information is manipulat=
ed
>>> and that we offer to round the values or not.
>>
>> What I suggest instead is to do len sanitisation in the vcan driver, s=
o
>> that the problem I illustrated above will be fixed.
>>
>> Another path we have to think about is the loop back of CAN-FD frames,=
 I
>> think they are not sanitised as well.
>=20
> The problem in loopback and vcan is similar.
>=20
> But the issues that rises up when sanitizing the FD length value in=20
> loopback/vcan/af_can -> we start to fiddle inside the skb data.
>=20
> When we do so, we need to skb_copy() the skb instead of working on=20
> clones to prevent race conditions inside the data, see:
>=20
> https://elixir.bootlin.com/linux/v5.2.6/source/net/can/gw.c#L387
>=20
> skb_copy would have a performance impact and it would trigger a big=20
> rewriting of the current code. Don't know if it's worth that.

Which race condition do you have in mind?

For loopback ("can_put_echo_skb()"), I see a race condition in some CAN
drivers: They first do a can_put_echo_skb(), then keep using the skb to
write ->data into the hardware.

If we modify the skb in can_put_echo_skb(), then the CAN driver will see
the sanitized struct canfd_frame::len. This means for dlc =3D=3D 13, 14, =
15
the driver will write more data into the hardware than needed. It
probably depends on the HW what the controller sends out if you have a
dlc =3D=3D 14 (which means len up to 48 bytes) but only write 33 bytes in=
to
the registers.

While other drivers don't touch the skb after can_put_echo_skb().

Can we modify the ->len in can_get_echo_skb() (or the __ variant) right
before pushing the skv into the networking stack? We have to look at the
data path for driver that cannot/don't use can_get_echo_skb() due to no
TX-complete interrupt.

Looking at vcan, where's the race condition when modifying the skb in
vcan_tx()?

> I tend to sanitize the CAN FD length values when they are introduced=20
> into the system (CAN_RAW, CAN_BCM, CAN FD drivers*) and when they are=20
> modified (CAN_GW).
>=20
> * =3D already done

You miss the datapath that directly injects packets into the networking
stack with the mechanism that tcpdump uses but the sending into the
kernel instead of receiving (I don't remember the exact name). This path
skips all checks in CAN_RAW. This is why we have the
"can_dropped_invalid_skb()" in all drivers.

So from my point of view it makes no sense to sanitize the len value in
gw, as the drivers convert from len to dlc anyways.

What do I see when I attach a candump to the src and another one to the
dst interface? I suspenct:

src) the unmodified canfd_frame with sanitized len, as the controller
knowns only the dlc.

dst) the modified-by-gw canfd_frame, _after_ the loopback by the driver?
If there's neither sanitation in the gw not in the loopback, it's the
unsanitized len.

When I have another application sending on the dst interface, the
candump receives the un-sanitized, as there's no sanitation in the loopba=
ck.

For me the loopback is and vcan is the part to modify, as gw is just a
another source of unsanitized len information.

> My idea was to fix things up when someone manipulates the CAN or CAN FD=
=20
> length field with can-gw.

For CAN you don't have to do any sanitization, only check if the len is
<=3D 8.

> Or do you think I should just omit it and let the data flow as-is?

ACK

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--szAs9rl5n7DRs07CzFe4dc0Pnu1cb0D2W--

--XzWcunsX7QfeuAbPfVQ9dbTevjO89lJN2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1NgtIACgkQWsYho5Hk
nSBLpAf/bxf6ovDRDicb82ju/DoKCyAZft4VZ2U0xMFBvwWhg5W9DfXToXPGIHpA
mCvRPJKVM5zfqyh+kKl72v9WVdR8ngWzMig+DM20UE2s3OZ/CLidKtSXznc+jtO3
q5i80LZzv9qAyaL4vadyqvHpPVS2GyE52WKE7MqGgPgr1CJVFSeCg4PdlrDwFZTw
HDDMVXDtxSRA5b18fjMPHnFf2jaS+lM9PlPerrgEU0EsVYOaIwxJGo4a9jSKr3HY
rkJ0rYT8yM+D+l/i/60PeszF/3MSbzae/knXAb41FJ5HDplGeH35GXSbckC0FbHa
4jVsAGydRJNdBxSap+363jFCFclf5A==
=vMqR
-----END PGP SIGNATURE-----

--XzWcunsX7QfeuAbPfVQ9dbTevjO89lJN2--
