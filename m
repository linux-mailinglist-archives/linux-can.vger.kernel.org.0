Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3122DA9E9
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 10:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgLOJRJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 04:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgLOJRD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 04:17:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA10C06179C
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 01:16:22 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kp6RQ-0006lj-Pj; Tue, 15 Dec 2020 10:16:20 +0100
Received: from [IPv6:2a03:f580:87bc:d400:d81b:8ab4:f042:fe4f] (unknown [IPv6:2a03:f580:87bc:d400:d81b:8ab4:f042:fe4f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6F24C5ADC67;
        Tue, 15 Dec 2020 09:16:19 +0000 (UTC)
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
References: <20201214091426.417867-1-mkl@pengutronix.de>
 <CAMZ6Rq+t630Fv_vYDmxitY47ScKMbEp+YCeZ_PAqTngOHajQ2g@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH RFC net-next] can: dev: can_skb_get_dll_len(): introduce
 function to get data length of frame in data link layer
Message-ID: <2c3a332a-f3c5-7052-8276-44980efc3442@pengutronix.de>
Date:   Tue, 15 Dec 2020 10:16:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+t630Fv_vYDmxitY47ScKMbEp+YCeZ_PAqTngOHajQ2g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="raoXrLmZ2OmsjJs1VkKY4fARvJzL9tacT"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--raoXrLmZ2OmsjJs1VkKY4fARvJzL9tacT
Content-Type: multipart/mixed; boundary="ntuvsWQvNB2NK4aJadcD1J2FBGR0LA6y6";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: linux-can <linux-can@vger.kernel.org>,
 Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Message-ID: <2c3a332a-f3c5-7052-8276-44980efc3442@pengutronix.de>
Subject: Re: [PATCH RFC net-next] can: dev: can_skb_get_dll_len(): introduce
 function to get data length of frame in data link layer
References: <20201214091426.417867-1-mkl@pengutronix.de>
 <CAMZ6Rq+t630Fv_vYDmxitY47ScKMbEp+YCeZ_PAqTngOHajQ2g@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+t630Fv_vYDmxitY47ScKMbEp+YCeZ_PAqTngOHajQ2g@mail.gmail.com>

--ntuvsWQvNB2NK4aJadcD1J2FBGR0LA6y6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/14/20 5:59 PM, Vincent MAILHOL wrote:
>> while reviewing the etas_es58X driver and hacking on BQL support for t=
he
>> mcp251xfd driver, it turned out the a function to calculate the length=
 of the
>> CAN frame that's send over the wire should go into the generic CAN dev=
 code.
>=20
> It took me a bit of time to figure out how to use the BQL. Contrary to
> the other features, I couldn't pull inspiration from the other CAN
> drivers. I am happy to see that you want to extend it to other
> drivers.
>=20
> Also, on a side topic, please let me know if you have any comments on
> the etas_es58x driver ;)

I'll look more into the driver later this week.

>> Looking at the CAN and OSI layering I think the first layer where we h=
ave all
>> the bits that we see on the wire is the data link layer (DLL).
>>
>> https://www.can-cia.org/can-knowledge/can/can-data-link-layers
>>
>> This is why I named the function can_skb_get_dll_len().
>=20
> I would personally prefer to call it can_skb_get_frame_len(). The ISO
> 11898 standard defines the "frame" as:
>=20
>    Protocol Data Unit of the data link layer specifying the
>    arrangement and meaning of bits or bit fields in the sequence of
>    transfer across the transmission medium.
>=20
> I imagine that you want to introduce the term "dll" instead of "frame"
> to clearly differentiate it from the struct can_frame and struct
> can_fd_frame.

ACK

> But "frame" remains the most relevant term according to
> the standard. I think that things are clear enough so that other
> kernel hackers would understand that the len fields of struct can_frame=

> and struct can_fd_frame represent the length of the payload and that
> can_skb_get_frame_len() is the length of the frame at the data link
> layer.

Ok.

>> I'm planing to add a (better) calculation of the CAN-FD dll_len, depen=
ding on
>> the data and including different CRC lengths.
>=20
> Great! For my driver, everything seemed OK as it is currently but if
> this gets merged to the generic CAN dev code this part should
> definitely be improved (the comment I added in my code was there to
> warn whoever wanted to reuse it about the limitations).

:)

>> As this code is copied from the etas_es58X driver, I've added the auth=
ors as
>> Co-developed-by and I'd like to add their S-o-b to this patch.
>>
>> Please review and commnt on the naming on the functions.
>>
>> regards,
>> Marc
>>
>>  drivers/net/can/dev.c   | 103 +++++++++++++++++++++++++++++++++++++++=
+
>>  include/linux/can/dev.h |   3 ++
>>  2 files changed, 106 insertions(+)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>> index 81e39d7507d8..58c04785b46d 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -58,6 +58,109 @@ u8 can_len2dlc(u8 len)
>>  }
>>  EXPORT_SYMBOL_GPL(can_len2dlc);
>>
>> +/* Size of a Classical CAN Standard Frame in Bits:
>=20
> Size of a Classical CAN Standard Frame in Bytes:

The table is in bits, the overhead makros are in bytes, I'll try to clari=
ft this.

> The macro divides the grand total by 8. The subtotal is indeed
> presented in bits but the macro is in bytes.
>=20
>> + *
>> + * Start-of-frame                      1
>> + * Identifier                          11
>> + * Remote transmission request (RTR)   1
>> + * Identifier extension bit (IDE)      1
>> + * Reserved bit (r0)                   1
>> + * Data length code (DLC)              4
>> + * Data field                          0...64
>> + * CRC                                 15
>> + * CRC delimiter                       1
>> + * ACK slot                            1
>> + * ACK delimiter                       1
>> + * End-of-frame (EOF)                  7
>> + * Inter frame spacing                 3
>> + *
>> + * Rounded up and ignoring bitsuffing
>> + */
>> +#define CAN_DLL_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
>> +
>> +/* Size of a Classical CAN Extended Frame in Bits:
>=20
> Same as above.
>=20
>> + *
>> + * Start-of-frame                      1
>> + * Identifier A                        11
>> + * Substitute remote request (SRR)     1
>> + * Identifier extension bit (IDE)      1
>> + * Identifier B                                18
>> + * Remote transmission request (RTR)   1
>> + * Reserved bits (r1, r0)              2
>> + * Data length code (DLC)              4
>> + * Data field                          0...64
>> + * CRC                                 15
>> + * CRC delimiter                       1
>> + * ACK slot                            1
>> + * ACK delimiter                       1
>> + * End-of-frame (EOF)                  7
>> + * Inter frame spacing                 3
>> + *
>> + * Rounded up and ignoring bitsuffing
>> + */
>> +#define CAN_DLL_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
>> +
>> +/* Maximum size of a Classical CAN frame
>> + * (rounded up and ignoring bitsuffing)
>> + */
>> +#define CAN_DLL_LEN_MAX (CAN_DLL_OVERHEAD_EFF + CAN_MAX_DLEN)
>> +
>> +/* Maximum size of a CAN-FD frame (rough estimation because
>> + * ES58X_SFF_BYTES() and ES58X_EFF_BYTES() macros are using the
>> + * constant values for Classical CAN, not CAN-FD).
>> + */
>=20
> /* Maximum size of a CAN-FD frame (rough estimation because
>  * CAN_DLL_OVERHEAD_SFF and CAN_DLL_OVERHEAD_EFF macros are using the
>  * constant values for Classical CAN, not CAN-FD).
>  */
>=20
> Some leftovers from the etas_es58x :)

ACK, in the mean time I've makros for CAN-FD.

>=20
>> + */
>> +#define CANFD_DLL_LEN_MAX (CAN_DLL_OVERHEAD_EFF + CANFD_MAX_DLEN)
>> +
>> +/**
>> + * can_skb_get_dll_len() - Calculate the CAN Data Link Layer length i=
n
>> + * bytes of a given skb.
>> + * @skb: socket buffer of a CAN message.
>> + *
>> + * Do a rough calculation: bit stuffing is ignored and length in bits=

>> + * is rounded up to a length in bytes.
>> + *
>> + * Rationale: this function is to be used for the BQL functions
>> + * (netdev_sent_queue() and netdev_completed_queue()) which expect a
>> + * value in bytes. Just using skb->len is insufficient because it wil=
l
>> + * return the constant value of CAN(FD)_MTU. Doing the bit stuffing
>> + * calculation would be too expensive in term of computing resources
>> + * for no noticeable gain.
>> + *
>> + * Remarks:
>> + * a.) The payload of CAN FD frames with BRS flag are sent at a
>> + * different bitrate. Currently, the can-utils canbusload tool does
>> + * not support CAN-FD yet and so we could not run any benchmark to
>> + * measure the impact. There might be possible improvement here.
>=20
> My initial idea was to convert the data transmitted at data bitrate
> speed to their equivalent duration at nominal rate (example: 8 bytes
> at 2Mbps are equivalent to 2 bytes at 500 Kbps).
>=20
> Code would look as below:
>=20
> unsigned int can_skb_get_frame_len(const struct can_priv *can,
>                    const struct sk_buff *skb)
> {
> /* ... */
>=20
>     if (cfd->flags & CANFD_BRS)
>         len =3D mult_frac(CANFD_FRAME_OVERHEAD, can->bittiming.bitrate,=

>                  can->data_bittiming.bitrate);
> /* ... */
> }
>=20
> This is just an overview, the data bitrate is also applied to some
> other fields of the frame (e.g. the CRC). So when creating the macro
> for the CANFD_FRAME_OVERHEAD, it should be split between the nominal
> and data bitrates.

I think we shouldn't mess with the number of bytes depending on BRS. When=
 it
turns out that for CAN-FD this is not exact enough, we should look into t=
he wifi
drivers. As wifi doesn't even have a constant channel speed.

>> + * b.) The macro CAN_DLL_OVERHEAD_EFF and CAN_DLL_OVERHEAD_SFF are
>> + * for classical CAN. Need to do the addition for CAN-FD (the value
>> + * are expected to be close enough so the impact should be minimal or=

>> + * none).
>> + *
>> + * Return: length in bytes.
>> + */
>> +unsigned int can_skb_get_dll_len(const struct sk_buff *skb)
>> +{
>> +       const struct canfd_frame *cf =3D (const struct canfd_frame *)s=
kb->data;
>> +       u8 len;
>> +
>> +       if (can_is_canfd_skb(skb)) {
>> +               len =3D cf->len + CAN_DLL_OVERHEAD_EFF;
>=20
> The CAN-FD frame can also be sent in SFF. An additional check on the
> CAN_EFF_FLAG is needed here.

ACK. CAN-FD was work-in-progress in this patch.

>> +       } else {
>> +               if (cf->can_id & CAN_RTR_FLAG)
>> +                       len =3D 0;
>> +               else
>> +                       len =3D cf->len;
>> +
>> +               if (cf->can_id & CAN_EFF_FLAG)
>> +                       len +=3D CAN_DLL_OVERHEAD_EFF;
>> +               else
>> +                       len +=3D CAN_DLL_OVERHEAD_SFF;
>> +       }
>> +
>> +       return len;
>> +}
>> +EXPORT_SYMBOL_GPL(can_skb_get_dll_len);
>> +
>>  #ifdef CONFIG_CAN_CALC_BITTIMING
>>  #define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
>>
>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>> index 41ff31795320..fc830f919099 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -192,6 +192,9 @@ u8 can_dlc2len(u8 can_dlc);
>>  /* map the sanitized data length to an appropriate data length code *=
/
>>  u8 can_len2dlc(u8 len);
>>
>> +/* get data link layer length of CAN/CAN-FD frame */
>> +unsigned int can_skb_get_dll_len(const struct sk_buff *skb);
>> +
>>  struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int ech=
o_skb_max,
>>                                     unsigned int txqs, unsigned int rx=
qs);
>>  #define alloc_candev(sizeof_priv, echo_skb_max) \

This patch was mainly to get the naming discussion started.

Talking about CAN-FD and naming: For the CAN-FD frame/dll length we need =
the
actual length of the data field.

The code looks like this:

> static const u8 len2XXX[] =3D {
> 	0, 1, 2, 3, 4, 5, 6, 7, 8,	/* 0 - 8 */
> 	12, 12, 12, 12,			/* 9 - 12 */
> 	16, 16, 16, 16,			/* 13 - 16 */
> 	20, 20, 20, 20,			/* 17 - 20 */
> 	24, 24, 24, 24,			/* 21 - 24 */
> 	32, 32, 32, 32, 32, 32, 32, 32,	/* 25 - 32 */
> 	40, 40, 40, 40, 40, 40, 40, 40,	/* 33 - 40 */
> 	48, 48, 48, 48, 48, 48, 48, 48	/* 41 - 48 */
> };
>=20
> /* map the sanitized data length to an appropriate XXX length */
> u8 can_len2XXX(u8 len)
> {
> 	if (unlikely(len > ARRAY_SIZE(len2XXX)))
> 		return 64;
>=20
> 	return len2XXX[len];
> }

Have you got a good name for this, too?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--ntuvsWQvNB2NK4aJadcD1J2FBGR0LA6y6--

--raoXrLmZ2OmsjJs1VkKY4fARvJzL9tacT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl/YfuAACgkQqclaivrt
76m0IAf+MjOpEOdhxwrfx3vbB68f6ercbHvPjM05Z32ykma8Jc/v8PzaKNjDKiRZ
4ukUSb7nxK0tpz2KFdHOZYhOME9QlNCRAKbZWIt3kKZyfa4ndUhY0GgXPD8A/5T/
kvr21L0JpKhAn/RixhtmbKELKvr3g9/Not+G6q8jToigYDx+Xjg2eaksOUF4L2qY
OciistRscSmdZHn39vXFkY1+fpT+3uB/7atk0R+TjM6JBaCxRYsV1nG0CmmUbJQs
ZNgRDyP7RHTwkQiCH9wrWIh2NiHGQHJn1D8j+BkG6j+/eMcn7Ua9vRXmhtmC90t/
xJveLPSHNOBfbhJ60d0N08sd4+v1XQ==
=QSa2
-----END PGP SIGNATURE-----

--raoXrLmZ2OmsjJs1VkKY4fARvJzL9tacT--
