Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB362B8F5C
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 10:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgKSJtq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 04:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgKSJtp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2020 04:49:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA4AC0613CF
        for <linux-can@vger.kernel.org>; Thu, 19 Nov 2020 01:49:45 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kfgZU-0003gB-7q; Thu, 19 Nov 2020 10:49:44 +0100
Received: from [IPv6:2a03:f580:87bc:d400:d2a0:42c2:7db3:b10] (unknown [IPv6:2a03:f580:87bc:d400:d2a0:42c2:7db3:b10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E79E65961EA;
        Thu, 19 Nov 2020 09:49:42 +0000 (UTC)
Subject: Re: [PATCH 5/5] can: flexcan: flexcan_close(): change order if
 commands to properly shut down the controller
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>
References: <20201119085251.2949181-1-mkl@pengutronix.de>
 <20201119085251.2949181-6-mkl@pengutronix.de>
 <DB8PR04MB6795CBAA8B6729A478E2BE9CE6E00@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <104ac870-4560-0ecb-7aef-d663c7288dda@pengutronix.de>
Date:   Thu, 19 Nov 2020 10:49:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB6795CBAA8B6729A478E2BE9CE6E00@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SfJ76nXQ7O1JYsctbVYMxWxp9U7v4gUdE"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SfJ76nXQ7O1JYsctbVYMxWxp9U7v4gUdE
Content-Type: multipart/mixed; boundary="VmSabOTGsiI8HjT2HEaLwcG9QWWOAONnz";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>
Message-ID: <104ac870-4560-0ecb-7aef-d663c7288dda@pengutronix.de>
Subject: Re: [PATCH 5/5] can: flexcan: flexcan_close(): change order if
 commands to properly shut down the controller
References: <20201119085251.2949181-1-mkl@pengutronix.de>
 <20201119085251.2949181-6-mkl@pengutronix.de>
 <DB8PR04MB6795CBAA8B6729A478E2BE9CE6E00@DB8PR04MB6795.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB6795CBAA8B6729A478E2BE9CE6E00@DB8PR04MB6795.eurprd04.prod.outlook.com>

--VmSabOTGsiI8HjT2HEaLwcG9QWWOAONnz
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/19/20 10:46 AM, Joakim Zhang wrote:
>=20
>> -----Original Message-----
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>> Sent: 2020=E5=B9=B411=E6=9C=8819=E6=97=A5 16:53
>> To: linux-can@vger.kernel.org
>> Cc: Joakim Zhang <qiangqing.zhang@nxp.com>; kernel@pengutronix.de; Mar=
c
>> Kleine-Budde <mkl@pengutronix.de>
>> Subject: [PATCH 5/5] can: flexcan: flexcan_close(): change order if co=
mmands
>> to properly shut down the controller
>>
>> There haven been reports, that the flexcan_close() soradically hangs d=
uring
>> simultanious ifdown, sending of CAN messages and probably open CAN bus=
:
>>
>> | (__schedule) from [<808bbd34>] (schedule+0x90/0xb8)
>> | (schedule) from [<808bf274>] (schedule_timeout+0x1f8/0x24c)
>> | (schedule_timeout) from [<8016be44>] (msleep+0x18/0x1c)
>> | (msleep) from [<80746a64>] (napi_disable+0x60/0x70)
>> | (napi_disable) from [<8052fdd0>] (flexcan_close+0x2c/0x140)
>> | (flexcan_close) from [<80744930>] (__dev_close_many+0xb8/0xd8)
>> | (__dev_close_many) from [<8074db9c>] (__dev_change_flags+0xd0/0x1a0)=

>> | (__dev_change_flags) from [<8074dc84>] (dev_change_flags+0x18/0x48)
>> | (dev_change_flags) from [<80760c24>] (do_setlink+0x44c/0x7b4)
>> | (do_setlink) from [<80761560>] (rtnl_newlink+0x374/0x68c)
>>
>> I was unable to reproduce the issue, but a cleanup of the flexcan clos=
e
>> sequence has probably fixed the problem at the reporting user.
>>
>> This patch changes the sequence in flexcan_close() to:
>> - stop the TX queue
>> - disable the interrupts on the chip level and wait via free_irq()
>>   synchronously for the interrupt handler to finish
>> - disable RX offload, which disables synchronously NAPI
>> - disable the flexcan on the chip level
>> - free RX offload
>> - disable the transceiver
>> - close the CAN device
>> - disable the clocks
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  drivers/net/can/flexcan.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c ind=
ex
>> 0fb768dee99f..002e93f2b249 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -1789,15 +1789,16 @@ static int flexcan_close(struct net_device *de=
v)
>>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>>
>>  	netif_stop_queue(dev);
>> +	flexcan_chip_interrupts_disable(dev);
>> +	free_irq(dev->irq, dev);
>>  	can_rx_offload_disable(&priv->offload);
>>  	flexcan_chip_stop_disable_on_error(dev);
>>  	flexcan_chip_interrupts_disable(dev);
>=20
> Hi Marc,
>=20
> Is it a special treatment? flexcan_chip_interrupts_disable called twice=
?

Thanks for catching this. It's a mistake, will fix.

> 	flexcan_chip_interrupts_disable(dev);
> 	free_irq(dev->irq, dev);
>   	can_rx_offload_disable(&priv->offload);
>   	flexcan_chip_stop_disable_on_error(dev);
>   	flexcan_chip_interrupts_disable(dev);

Thanks for the review,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--VmSabOTGsiI8HjT2HEaLwcG9QWWOAONnz--

--SfJ76nXQ7O1JYsctbVYMxWxp9U7v4gUdE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+2P7IACgkQqclaivrt
76n3WAf/UIRVvrJc7ciOEhC3cqBLNNtBCklMcLTXOS0DNjIndtvJlIpSEKBJkK04
EeKJU6yapt/AAAw7LKHvBNp46ceeAYGPpTzbKgYa7QE1kWvZnPVcUHKYuIhzKxRc
VlkU5rigi6rGK25K0J7VH9Ef3hp+sjXRALc5I2aex+G5/8MmrSb2lQkvL72LTOFP
EbBbCyE5xlUay+/ZQR74h5qYw3Kk34MIzTKSUFYL8c3mN7SiXONQUVzlbuBmS1tY
stegjXS5vAGWJ+Cv3b18yBaZQOuoVNw+4Om4CS1T/Hpt4Yy1wD8PNT6rWhEexE/t
to9WGXBEWE+duv/wKC1KiIKhpTh5Mg==
=KT8L
-----END PGP SIGNATURE-----

--SfJ76nXQ7O1JYsctbVYMxWxp9U7v4gUdE--
