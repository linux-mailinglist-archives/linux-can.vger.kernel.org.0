Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A742AD432
	for <lists+linux-can@lfdr.de>; Tue, 10 Nov 2020 11:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgKJK5p (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Nov 2020 05:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgKJK5o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Nov 2020 05:57:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA4CC0613CF
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2020 02:57:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kcRLJ-0003ot-U1; Tue, 10 Nov 2020 11:57:42 +0100
Received: from [IPv6:2a03:f580:87bc:d400:6c8a:7fd4:ebb4:403c] (unknown [IPv6:2a03:f580:87bc:d400:6c8a:7fd4:ebb4:403c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8879558EE6D;
        Tue, 10 Nov 2020 10:57:40 +0000 (UTC)
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-6-uttenthaler@ems-wuensche.com>
 <a5cabc30-4e7c-dd3d-9f4c-afc42864fe10@pengutronix.de>
 <9474fc10-dc04-28fa-9459-54545ac8d293@ems-wuensche.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 05/17] can: ems_usb: Replace constant define
 RX_BUFFER_SIZE by variable bulk_rd_buf_size, because this will have different
 values for CPC-USB/ARM7 and CPC-USB/FD. For the same reason added a function
 pointer ems_usb_write_mode. In device probe function added a switch statement
 to select between CPC-USB/ARM7 and CPC-USB/FD and rearranged initialization
 sequence accordingly.
Message-ID: <1a4fbcc6-c27e-a660-3dae-0b96d28d97b1@pengutronix.de>
Date:   Tue, 10 Nov 2020 11:57:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9474fc10-dc04-28fa-9459-54545ac8d293@ems-wuensche.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cZXoh20F2C2TuxUREPjwIea5igbD8eWJe"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cZXoh20F2C2TuxUREPjwIea5igbD8eWJe
Content-Type: multipart/mixed; boundary="yMnD1wlJ4X728ZIzHj01zh1Hbe5r5E3k5";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
 linux-can@vger.kernel.org
Cc: wg@grandegger.com
Message-ID: <1a4fbcc6-c27e-a660-3dae-0b96d28d97b1@pengutronix.de>
Subject: Re: [PATCH 05/17] can: ems_usb: Replace constant define
 RX_BUFFER_SIZE by variable bulk_rd_buf_size, because this will have different
 values for CPC-USB/ARM7 and CPC-USB/FD. For the same reason added a function
 pointer ems_usb_write_mode. In device probe function added a switch statement
 to select between CPC-USB/ARM7 and CPC-USB/FD and rearranged initialization
 sequence accordingly.
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-6-uttenthaler@ems-wuensche.com>
 <a5cabc30-4e7c-dd3d-9f4c-afc42864fe10@pengutronix.de>
 <9474fc10-dc04-28fa-9459-54545ac8d293@ems-wuensche.com>
In-Reply-To: <9474fc10-dc04-28fa-9459-54545ac8d293@ems-wuensche.com>

--yMnD1wlJ4X728ZIzHj01zh1Hbe5r5E3k5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/10/20 11:31 AM, Gerhard Uttenthaler wrote:
> Am 06.11.20 um 18:15 schrieb Marc Kleine-Budde:
>> Please keep the patch subject within reasonable length.
>> It sould describe what you have done. The patch description should des=
cribe the why.
> OK
>=20
>>
>> On 11/6/20 6:01 PM, Gerhard Uttenthaler wrote:
>>> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
>>> ---
>>>  drivers/net/can/usb/ems_usb.c | 66 +++++++++++++++++++++++++--------=
--
>>>  1 file changed, 47 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_=
usb.c
>>> index 4ed0d681a68c..a3943042b8c8 100644
>>> --- a/drivers/net/can/usb/ems_usb.c
>>> +++ b/drivers/net/can/usb/ems_usb.c
>>> @@ -266,7 +266,6 @@ static struct usb_device_id ems_usb_table[] =3D {=

>>> =20
>>>  MODULE_DEVICE_TABLE(usb, ems_usb_table);
>>> =20
>>> -#define RX_BUFFER_SIZE      64
>>
>> Can you keep this define instead of using a "64" below? Give it a prop=
er
>> prefix/postfix if needed.
> OK
>=20
>>
>>>  #define CPC_HEADER_SIZE     4
>>>  #define INTR_IN_BUFFER_SIZE 4
>>> =20
>>> @@ -290,6 +289,8 @@ struct ems_usb {
>>>  	struct usb_device *udev;
>>>  	struct net_device *netdev;
>>> =20
>>> +	u32 bulk_rd_buf_size;
>>> +
>>>  	atomic_t active_tx_urbs;
>>>  	struct usb_anchor tx_submitted;
>>>  	struct ems_tx_urb_context tx_contexts[MAX_TX_URBS];
>>> @@ -301,7 +302,9 @@ struct ems_usb {
>>>  	u8 *tx_msg_buffer;
>>> =20
>>>  	u8 *intr_in_buffer;
>>> -	unsigned int free_slots; /* remember number of available slots */
>>> +	u32 free_slots; /* remember number of available slots */
>>
>> nitpick
>> Why this change?
> It was the last "unsigned int". They all are u32 now.

seems unrelated to the rest of the changes?

[...]

>>> -static const struct can_bittiming_const ems_usb_bittiming_const =3D =
{
>>> -	.name =3D "ems_usb",
>>> +static const struct can_bittiming_const ems_usb_bittiming_const_arm7=
 =3D {
>>> +	.name =3D "ems_usb_arm7",
>>
>> You are changing the user space visible name of the CAN device. Is thi=
s needed?
> The driver will be able to handle both devices CPC-USB/ARM7 and
> CPC-USB/FD. If a user calls:
>=20
> ip -details -statistics link show can0
>=20
> then I noticed that "ems_usb" is inside the output. This seemed
> ambiguous for me as it could be a CPC-USB/ARM7 or a CPC-USB/FD. Sure
> this will need all patches applied to become visible.

Consider there is a software that relies on the "ems_usb" string. A kerne=
l
update should not change this if not needed. The new "FD" adapter can and=
 should
have a different name there.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--yMnD1wlJ4X728ZIzHj01zh1Hbe5r5E3k5--

--cZXoh20F2C2TuxUREPjwIea5igbD8eWJe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+qch8ACgkQqclaivrt
76k47Af/dmJnLQEMSjomjjXjTMWou4GPXaTaRSMhMzlWKX3jqlWeGJuJk5y1S8Y8
SfowDpuRfHQI0YXXjAoL0S67Ze73/ikTkyt4AReDYKs3MfAVE+/BZQDRmjtN7McX
ybR+oJws7WAsIkzQtDhxfK8PvnrnxRQX9LVGG9hRYyPld9UbUNep60dPVexIvOs2
czwXTOHbovl9ok36JLhYsnHVk4BdxjngG62dIl+WFtAXo9ev5u4foHL7sRJYAb+8
dDOvSisFacyVMAv1bEXo/1FK9hmLSHH1x4b51YrI0ejnoGhx42WPzXZ2O1mzR8RH
GKY3ZxbAsEPEFN2Ca/A5qj3dMJIk+g==
=Umyd
-----END PGP SIGNATURE-----

--cZXoh20F2C2TuxUREPjwIea5igbD8eWJe--
