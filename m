Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BAF29E310
	for <lists+linux-can@lfdr.de>; Thu, 29 Oct 2020 03:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgJ2Cox (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Oct 2020 22:44:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33747 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgJ1VeJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 17:34:09 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kXkiV-0008Gu-GR; Wed, 28 Oct 2020 13:38:15 +0100
Received: from [IPv6:2a03:f580:87bc:d400:9a81:bf61:4515:808d] (unknown [IPv6:2a03:f580:87bc:d400:9a81:bf61:4515:808d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 277C3583DF4;
        Wed, 28 Oct 2020 12:38:14 +0000 (UTC)
Subject: Re: [PATCH 4/4] can: rename can_dlc with len for all struct can_frame
 users
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201028110033.113702-1-socketcan@hartkopp.net>
 <20201028110033.113702-5-socketcan@hartkopp.net>
 <febc25d0-e715-1494-c972-0939ac46d481@pengutronix.de>
 <63426205-95d1-6c2e-5551-746fd009fc86@hartkopp.net>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4a2249b6-5fda-efb8-48af-c30709dc0bc2@pengutronix.de>
Date:   Wed, 28 Oct 2020 13:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <63426205-95d1-6c2e-5551-746fd009fc86@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GuMVgSmMO3Kc7DRbgBP3A3tRrrg3Svd12"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GuMVgSmMO3Kc7DRbgBP3A3tRrrg3Svd12
Content-Type: multipart/mixed; boundary="kdXJLlxyiOEGhmXZGn07LVBaHfbx4L6K0";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, mailhol.vincent@wanadoo.fr
Cc: linux-can@vger.kernel.org
Message-ID: <4a2249b6-5fda-efb8-48af-c30709dc0bc2@pengutronix.de>
Subject: Re: [PATCH 4/4] can: rename can_dlc with len for all struct can_frame
 users
References: <20201028110033.113702-1-socketcan@hartkopp.net>
 <20201028110033.113702-5-socketcan@hartkopp.net>
 <febc25d0-e715-1494-c972-0939ac46d481@pengutronix.de>
 <63426205-95d1-6c2e-5551-746fd009fc86@hartkopp.net>
In-Reply-To: <63426205-95d1-6c2e-5551-746fd009fc86@hartkopp.net>

--kdXJLlxyiOEGhmXZGn07LVBaHfbx4L6K0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/28/20 12:54 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 28.10.20 12:20, Marc Kleine-Budde wrote:
>> On 10/28/20 12:00 PM, Oliver Hartkopp wrote:
>>> Cleanup the can_dlc usage by renaming it with len from can_frame.len
>>>
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> [...]
>>
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>>> index 6dee4f8f2024..537dd4636c90 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -28,14 +28,14 @@ MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger=
=2Ecom>");
>>>   /* CAN DLC to real data length conversion helpers */
>>>  =20
>>>   static const u8 dlc2len[] =3D {0, 1, 2, 3, 4, 5, 6, 7,
>>>   			     8, 12, 16, 20, 24, 32, 48, 64};
>>>  =20
>>> -/* get data length from can_dlc with sanitized can_dlc */
>>> -u8 can_dlc2len(u8 can_dlc)
>>> +/* get data length from dlc with sanitized len */
>>> +u8 can_dlc2len(u8 dlc)
>>>   {
>>> -	return dlc2len[can_dlc & 0x0F];
>>> +	return dlc2len[dlc & 0x0F];
>>>   }
>>>   EXPORT_SYMBOL_GPL(can_dlc2len);
>>
>> unrelated change.
>=20
> Probably the commit message has to be altered.
> The plan is to remove can_dlc as it was misnamed/misused.

Make it so!
> In this specific case we provide a real (raw) dlc and not the can_dlc=20
> which was a length value.

ok

>> [...]
>>
>>
>>> diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/ca=
n/peak_canfd/peak_canfd.c
>>> index cc01db0c18b8..c25cb53eba4e 100644
>>> --- a/drivers/net/can/peak_canfd/peak_canfd.c
>>> +++ b/drivers/net/can/peak_canfd/peak_canfd.c
>>
>> [...]
>>
>>> @@ -650,11 +650,11 @@ static netdev_tx_t peak_canfd_start_xmit(struct=
 sk_buff *skb,
>>>   	struct pucan_tx_msg *msg;
>>>   	u16 msg_size, msg_flags;
>>>   	unsigned long flags;
>>>   	bool should_stop_tx_queue;
>>>   	int room_left;
>>> -	u8 can_dlc;
>>> +	u8 len;
>>
>> unrelated change
>=20
> Same here. can_dlc was just wrong in all cases.

ok

>>>  =20
>>>   	if (can_dropped_invalid_skb(ndev, skb))
>>>   		return NETDEV_TX_OK;
>>>  =20
>>>   	msg_size =3D ALIGN(sizeof(*msg) + cf->len, 4);
>>> @@ -680,22 +680,22 @@ static netdev_tx_t peak_canfd_start_xmit(struct=
 sk_buff *skb,
>>>   		msg->can_id =3D cpu_to_le32(cf->can_id & CAN_SFF_MASK);
>>>   	}
>>>  =20
>>>   	if (can_is_canfd_skb(skb)) {
>>>   		/* CAN FD frame format */
>>> -		can_dlc =3D can_len2dlc(cf->len);
>>> +		len =3D can_len2dlc(cf->len);
>>>  =20
>>>   		msg_flags |=3D PUCAN_MSG_EXT_DATA_LEN;
>>>  =20
>>>   		if (cf->flags & CANFD_BRS)
>>>   			msg_flags |=3D PUCAN_MSG_BITRATE_SWITCH;
>>>  =20
>>>   		if (cf->flags & CANFD_ESI)
>>>   			msg_flags |=3D PUCAN_MSG_ERROR_STATE_IND;
>>>   	} else {
>>>   		/* CAN 2.0 frame format */
>>> -		can_dlc =3D cf->len;
>>> +		len =3D cf->len;
>>>  =20
>>>   		if (cf->can_id & CAN_RTR_FLAG)
>>>   			msg_flags |=3D PUCAN_MSG_RTR;
>>>   	}
>>>  =20
>>> @@ -705,11 +705,11 @@ static netdev_tx_t peak_canfd_start_xmit(struct=
 sk_buff *skb,
>>>   	/* set driver specific bit to differentiate with application loopb=
ack */
>>>   	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
>>>   		msg_flags |=3D PUCAN_MSG_SELF_RECEIVE;
>>>  =20
>>>   	msg->flags =3D cpu_to_le16(msg_flags);
>>> -	msg->channel_dlc =3D PUCAN_MSG_CHANNEL_DLC(priv->index, can_dlc);
>>> +	msg->channel_dlc =3D PUCAN_MSG_CHANNEL_DLC(priv->index, len);
>>>   	memcpy(msg->d, cf->data, cf->len);
>>>  =20
>>>   	/* struct msg client field is used as an index in the echo skbs ri=
ng */
>>>   	msg->client =3D priv->echo_idx;
>>>  =20
>>
>> [...]
>>
>>> diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/s=
ofting/softing_fw.c
>>> index ccd649a8e37b..7e1536877993 100644
>>> --- a/drivers/net/can/softing/softing_fw.c
>>> +++ b/drivers/net/can/softing/softing_fw.c
>>> @@ -622,11 +622,11 @@ int softing_startstop(struct net_device *dev, i=
nt up)
>>>   	 * from here, no errors should occur, or the failed: part
>>>   	 * must be reviewed
>>>   	 */
>>>   	memset(&msg, 0, sizeof(msg));
>>>   	msg.can_id =3D CAN_ERR_FLAG | CAN_ERR_RESTARTED;
>>> -	msg.can_dlc =3D CAN_ERR_DLC;
>>> +	msg.len =3D CAN_ERR_DLC;
>>
>> unrelated?
>=20
> No, definitely not. msg is a struct can_frame. Therefore 'len' should b=
e=20
> used.

I missed that. tnx.

> When implementing the stuff for len8_dlc we are now very clear where we=
=20
> have a length value and where we have a data length code.
>=20
> (..) (skipping tons of 'same here?')
>=20
>>> -/* get data length from can_dlc with sanitized can_dlc */
>>> -u8 can_dlc2len(u8 can_dlc);
>>> +/* get data length from dlc with sanitized len */
>>> +u8 can_dlc2len(u8 dlc);
>>
>> unrealted?
>=20
> Same as at its first occurance. Remove can_dlc from the radar.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--kdXJLlxyiOEGhmXZGn07LVBaHfbx4L6K0--

--GuMVgSmMO3Kc7DRbgBP3A3tRrrg3Svd12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+ZZjAACgkQqclaivrt
76kYRwf/XXCJ7SP2iSAybGQv+89ItVqZahAxmhwWYffAzdFD+7v/HrVze/J6cvrb
mhQIwE43789J8EU201mexoB9MOV1poUmR3SvP9ydjRF2WO3/D/nhsRzBBzU4/I4O
iP9bWgCRvmPakT/F4ONVuf9HYeSi2QSCZzk3QJ25r54FtpNE16F/TO3r+KKr+2QK
mttAI3jTz2sY4qVgEuA2iSLlkrf9JcCvY3k1FrCu7vDeaibx7UJCreMLxK0HPHBW
rtzPicZT1HB/6FeYOzqaUhb0qSGjKRVkRq7FozhcjWBrHfSAAdhWFUcmo2CcMIjR
LjC8RPkEgzHkOsqGlquFVqFFjvHCLQ==
=CDgH
-----END PGP SIGNATURE-----

--GuMVgSmMO3Kc7DRbgBP3A3tRrrg3Svd12--
