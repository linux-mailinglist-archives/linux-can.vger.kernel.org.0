Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEC327D1B1
	for <lists+linux-can@lfdr.de>; Tue, 29 Sep 2020 16:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbgI2Opz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Sep 2020 10:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgI2Opy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2020 10:45:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B04C061755
        for <linux-can@vger.kernel.org>; Tue, 29 Sep 2020 07:45:54 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kNGt7-0004x0-7L; Tue, 29 Sep 2020 16:45:53 +0200
Received: from [IPv6:2a03:f580:87bc:d400:feea:fa2e:c0c5:a14c] (unknown [IPv6:2a03:f580:87bc:d400:feea:fa2e:c0c5:a14c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6873A56D922;
        Tue, 29 Sep 2020 14:45:51 +0000 (UTC)
To:     =?UTF-8?Q?Matthias_Wei=c3=9fer?= <m.weisser.m@gmail.com>,
        linux-can@vger.kernel.org
References: <CAO8h3eGqrxFMKrsrjECeog6cheLrRpn_y6Ty9BMUv_ncU1c67g@mail.gmail.com>
 <20200923190551.GA14591@x1.vandijck-laurijssen.be>
 <CAO8h3eEXG0WiJbmiswXd6uWbR4AE-tzL772mNLvUhbqgK7+jRQ@mail.gmail.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: mcp25xxfd driver testing
Message-ID: <6b2e02ad-b7e5-9de3-d251-9ac5e9099fce@pengutronix.de>
Date:   Tue, 29 Sep 2020 16:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAO8h3eEXG0WiJbmiswXd6uWbR4AE-tzL772mNLvUhbqgK7+jRQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XaB4U1C2Js5wyIccpdDuiVcmQQZg5e3Wr"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XaB4U1C2Js5wyIccpdDuiVcmQQZg5e3Wr
Content-Type: multipart/mixed; boundary="xs7xekbMTzxVGdw5Ba9CcL2G9lhOIJTFz";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Matthias_Wei=c3=9fer?= <m.weisser.m@gmail.com>,
 linux-can@vger.kernel.org
Message-ID: <6b2e02ad-b7e5-9de3-d251-9ac5e9099fce@pengutronix.de>
Subject: Re: mcp25xxfd driver testing
References: <CAO8h3eGqrxFMKrsrjECeog6cheLrRpn_y6Ty9BMUv_ncU1c67g@mail.gmail.com>
 <20200923190551.GA14591@x1.vandijck-laurijssen.be>
 <CAO8h3eEXG0WiJbmiswXd6uWbR4AE-tzL772mNLvUhbqgK7+jRQ@mail.gmail.com>
In-Reply-To: <CAO8h3eEXG0WiJbmiswXd6uWbR4AE-tzL772mNLvUhbqgK7+jRQ@mail.gmail.com>

--xs7xekbMTzxVGdw5Ba9CcL2G9lhOIJTFz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/29/20 4:11 PM, Matthias Wei=C3=9Fer wrote:
> Am Mi., 23. Sept. 2020 um 21:06 Uhr schrieb Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be>:
>>> Also receiving of any CAN frame doesn't work
>>> # candump any,0:0,#FFFFFFFF
>>> [  259.937612] spi_master spi1: I/O Error in DMA RX
>>> [  259.943743] mcp25xxfd spi1.0: SPI transfer failed: -110
>>> [  259.949644] spi_master spi1: failed to transfer one message from q=
ueue
>>> [  259.956566] mcp25xxfd spi1.0 can0: IRQ handler
>>> mcp25xxfd_handle_rxif() returned -110.
>>> [  259.964547] mcp25xxfd spi1.0 can0: IRQ handler returned -110
>>> (intf=3D0x3f1a0002).
>>
>> There is something bizarre with the DMA implementation of imx.
>> The variscite device-tree's come with dma disabled in their SPI nodes,=

>> using
>>
>>         &ecspi1 {
>>                 status =3D "okay";
>>                 /delete-property/ dmas;
>>                 /delete-property/ dma-names;
>>         };
>>
>> Since I was struggling to consume 1Mbit, I tried to enable DMA again,
>> and ran into the same SPI tranfer failed. Disabling DMA fixes this.

At least it works now :)

> After adopting my DT I am now able to successfully receive CAN frames
> now. Load testing needs to be done....
>=20
> I also tried with different SDMA firmware versions but that didn't
> change anything.

Are you using latest stable v5.4?

Try latest mainline, if it still breaks drop the a regression bug on the =
spi list.

>>> Trying to send a CAN-FD frame with baud rate switch fails
>>> # cansend can0 123##142
>>> [  190.921477] mcp25xxfd spi1.0 can0: bus-off
>=20
> This still leads to an immediate bus off. I think I have to get the
> scope out to check the reason here.

I have only tested the mcp25xxfd against each other, maybe there is a pro=
blem
with the automatic bitrate calculation.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--xs7xekbMTzxVGdw5Ba9CcL2G9lhOIJTFz--

--XaB4U1C2Js5wyIccpdDuiVcmQQZg5e3Wr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl9zSJoACgkQqclaivrt
76kqTAf7B9+HTF2xPt971KcIqmtpqXhYDifPs08amg/dkvSckXdLUku3Hl0vWTq4
0PnDAZmQd3aHAyDDWzltZlyR7XtmLOKRRuKLQeWeoO1Al/ceYGV7DeurORDmktQz
njEbDyxhJR8v02C5bRLHFHjllOa5xZ311VSZWQG658Sa92e9liN2aBt0kIfhD03Q
0RgHAg65Q/FApM0IRqUyxXvC8DX/8HZlSgNC/28e3WNbpuEov/Q+iEjPQ/n8WOyz
2Bwrm1E9bit8PAOuzJnTnjhG1EnmO0/3nhnipaHxXue/E/6TieWesw0kbWEbEnvb
hIIUh495vNs5Xwihbgm5LaJW//tQLw==
=sPu+
-----END PGP SIGNATURE-----

--XaB4U1C2Js5wyIccpdDuiVcmQQZg5e3Wr--
