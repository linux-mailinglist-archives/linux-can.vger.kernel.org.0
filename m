Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B98247ECDF
	for <lists+linux-can@lfdr.de>; Fri, 24 Dec 2021 08:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbhLXHvy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Dec 2021 02:51:54 -0500
Received: from mout02.posteo.de ([185.67.36.66]:50515 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234111AbhLXHvw (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 24 Dec 2021 02:51:52 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5A6BE240103
        for <linux-can@vger.kernel.org>; Fri, 24 Dec 2021 08:51:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1640332310; bh=yaUAH+Cw0dzC4Ps8C7d6sd+Bl62u35eZJSkifV4CEKE=;
        h=To:From:Cc:Subject:Date:From;
        b=mumpglBpguljwTyPh3w4L9UyCXoGrZHfQmyH62IzR4JpQkFYXgrMBWZ+dlnETPeMh
         CXVdNHKjWU/KJ9ohQ1FPqB6dH+d/1hbpDgFOx/qd+lGkjZjr0u5TA6fINA90Auh/uP
         hQJ2Zmb+/odPCcrQRCcELppgMZUZ2pWrgLwSDOLQDYDM+ZMggxrMyLYDO9zXswiahi
         BpTL5KlXskelJ3sgug9+5HluGdI3hmEDZxjWuitFeiTx0eLP4CymaEjEuveBc0YFWr
         TtuM5f7RPrHmDK8O+rpTCURu5w9DjGnyxeDi7sj0aYe562dGoHT5c5PCw13Yn3p+Cf
         nNIqJrvyvAehw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4JKzm55Yhmz6tpC;
        Fri, 24 Dec 2021 08:51:49 +0100 (CET)
To:     Gediminas Simanskis <gediminas@rusoku.com>
References: <A271F63C-FA42-4864-A621-C5195A35EC83@vanille.de>
 <d91f084a-73de-4486-548d-d39fcb1480bc@posteo.de>
 <e5acf66b-33a5-363e-5076-f42e8994ac2d@posteo.de>
 <5AB3E4E4-3DB8-4B5C-931C-6C8E2722B2EB@rusoku.com>
From:   Patrick Menschel <menschel.p@posteo.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: Dual CAN(FD) board w/ MACP251xfd
Message-ID: <899d0104-723c-dfd7-6477-3be4246bf827@posteo.de>
Date:   Fri, 24 Dec 2021 07:51:49 +0000
MIME-Version: 1.0
In-Reply-To: <5AB3E4E4-3DB8-4B5C-931C-6C8E2722B2EB@rusoku.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JHcKqsjapOcLyl1cdUmc3kX0HkhP8TOkS"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JHcKqsjapOcLyl1cdUmc3kX0HkhP8TOkS
Content-Type: multipart/mixed; boundary="RqFxMWh52rrdbxJQKEpF8BxAtLBxupPMw";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: Gediminas Simanskis <gediminas@rusoku.com>
Cc: linux-can@vger.kernel.org
Message-ID: <899d0104-723c-dfd7-6477-3be4246bf827@posteo.de>
Subject: Re: Dual CAN(FD) board w/ MACP251xfd
References: <A271F63C-FA42-4864-A621-C5195A35EC83@vanille.de>
 <d91f084a-73de-4486-548d-d39fcb1480bc@posteo.de>
 <e5acf66b-33a5-363e-5076-f42e8994ac2d@posteo.de>
 <5AB3E4E4-3DB8-4B5C-931C-6C8E2722B2EB@rusoku.com>
In-Reply-To: <5AB3E4E4-3DB8-4B5C-931C-6C8E2722B2EB@rusoku.com>

--RqFxMWh52rrdbxJQKEpF8BxAtLBxupPMw
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Well,

the udev stuff is apparently necessary with both designs due to
unpredictable enumeration.

With the overlays I tried the DT naming/alias mechanism but it did not
work for some reason.

Concerning performance, I have not seen any benchmark that compares both
designs but I believe there is a catch with using two spis because Seeed
changed their design from two to one spi.

You can also hear a very unpleasant chirp noise when CAN traffic runs at
full load, so EMC must be horrible, could be even worse with two spi.

Best Regards,
Patrick

Am 23.12.21 um 19:21 schrieb Gediminas Simanskis:
> Maybe it=E2=80=99s not such a bad idea to use independent spi bus eq SP=
I0 and SPI1  ;-)
>=20
>=20
>> On 2021-12-23, at 19:54, Patrick Menschel <menschel.p@posteo.de> wrote=
:
>>
>> LOL, already found an error in my own lines. That was sluggish of me.
>>
>> In your case udev rules should be
>>
>> SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
>> DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi0.0/net/can?", NAME=3D"mc=
p0"
>> SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
>> DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi1.0/net/can?", NAME=3D"mc=
p1"
>>
>> Best Regards,
>> Patrick
>>
>> Am 23.12.21 um 18:49 schrieb Patrick Menschel:
>>> Hello,
>>>
>>> afaik Drew got that board working.
>>>
>>> https://marc.info/?l=3Dlinux-can&m=3D160427096004578&w=3D2
>>>
>>> Same time we did PRs for board specific overlays, not waveshare but
>>> seeed while waveshare is very similar to seeed v1
>>>
>>> https://github.com/raspberrypi/linux/pull/4034
>>> https://github.com/raspberrypi/linux/pull/4041
>>>
>>> With some reverse engineering we get back to a hopefully working set =
of
>>> lines.
>>>
>>> Please try these lines in config.txt
>>>
>>> dtoverlay=3Dmcp251xfd,spi0-0,interrupt=3D25
>>> dtoverlay=3Dmcp251xfd,spi1-0,interrupt=3D16
>>>
>>>
>>> There is also a popular way to get rid of the can0 / can1 swapping, u=
se
>>> udev rules.
>>>
>>> Try pasting this into /etc/udev/rules.d/70-can.rules
>>>
>>> SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
>>> DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi0.0/net/can?", NAME=3D"m=
cp0"
>>> SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
>>> DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi0.1/net/can?", NAME=3D"m=
cp1"
>>>
>>>
>>> and correspondingly this into /etc/network/interfaces.d/70-can but yo=
u
>>> may want to change bitrates
>>>
>>> auto mcp0
>>> iface mcp0 inet manual
>>> 	pre-up /sbin/ip link set $IFACE type can bitrate 1000000 sample-poin=
t
>>> 0.75 dbitrate 8000000 dsample-point 0.8 fd on
>>> 	up /sbin/ifconfig $IFACE up
>>> 	down /sbin/ifconfig $IFACE down
>>>
>>> auto mcp1
>>> iface mcp1 inet manual
>>> 	pre-up /sbin/ip link set $IFACE type can bitrate 1000000 sample-poin=
t
>>> 0.75 dbitrate 8000000 dsample-point 0.8 fd on
>>> 	up /sbin/ifconfig $IFACE up
>>> 	down /sbin/ifconfig $IFACE down
>>>
>>>
>>> It may be wise to open another PR for that board.
>>>
>>> Best Regards,
>>> Patrick
>>>
>>> Am 23.12.21 um 18:05 schrieb Dr. Michael Lauer:
>>>> Please forgive me, if this is not the proper list for this message,
>>>> but as far as I know the developer of the mcp251xfd driver is also r=
eading here.
>>>>
>>>> I recently acquired a Dual CAN FD HAT (https://www.waveshare.com/wik=
i/2-CH_CAN_FD_HAT)
>>>> to run on my Raspberry PI 4. Currently, this is using kernel 5.15.11=
, but for some
>>>> reason, only one of the two ports are recognized. Instead of detecti=
ng the 2nd port,
>>>> it seems to just _renames_ the port. Here is the relevant kernel log=
:
>>>>
>>>> [    5.495409] CAN device driver interface
>>>> [    5.552660] spi_master spi1: will run message pump with realtime =
priority
>>>> [    5.559885] mcp251xfd spi1.0 (unnamed net_device) (uninitialized)=
: Detected MCP2518FD, but firmware specifies a MCP2517FD. Fixing up.
>>>> [    5.580908] vc4-drm gpu: bound fe400000.hvs (ops vc4_hvs_ops [vc4=
])
>>>> [    5.585428] Registered IR keymap rc-cec
>>>> [    5.599117] rc rc0: vc4 as /devices/platform/soc/fef00700.hdmi/rc=
/rc0
>>>> [    5.601698] mcp251xfd spi1.0 can0: MCP2518FD rev0.0 (-RX_INT -MAB=
_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00M=
Hz e:16.66MHz) successfully initialized.
>>>> [    5.633622] input: vc4 as /devices/platform/soc/fef00700.hdmi/rc/=
rc0/input3
>>>> [    5.677448] vc4-drm gpu: bound fef00700.hdmi (ops vc4_hdmi_ops [v=
c4])
>>>> [    5.697059] Registered IR keymap rc-cec
>>>> [    5.698682] mcp251xfd spi1.0 can1: renamed from can0
>>>>
>>>> The activated overlays in config.txt are
>>>>
>>>> dtoverlay=3D2xMCP2517FD
>>>> dtoverlay=3D2xMCP2518FD-spi0
>>>>
>>>> Perhaps anyone of you has a similar config and can tell me what coul=
d be wrong?
>>>>
>>>> Best,
>>>>
>>>> Mickey.
>>>>
>>>
>>
>=20


--RqFxMWh52rrdbxJQKEpF8BxAtLBxupPMw--

--JHcKqsjapOcLyl1cdUmc3kX0HkhP8TOkS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAmHFfBUFAwAAAAAACgkQMeZuMM+vuE6m
zA/9EiVe0pK0ePrIkpok6QwrAQCMI5ZZpWgY7e5INao4WjBJcte7uKSTK5PfYZ+JNqAyxvGR0KyB
4436UEm6Bizi6uKW/fz/L94VpEaeITULNoc9WJsgufWlxCGJ6CqiWGy448UpnxHApGNBpN5qzmlp
hhaZEq/ybAI5XhIqZsej3jHnEEwZRy3mQBgn4JWo+/cz1FEknL8I41+F8AJXiDaSNhTy+rAO7Ylm
bFNgIBW/rpMIvS3/CnmMV7tVhJ4DrcMpqKPDxRZTKzz0Kb0hgIewgjGdiK2bHZv8tTyUejX0pKbD
EORLjbA1X5c8hvnxRDC38Iu7mWYFSh21XUV2LCwQBGWAm9JpUTI2oH4guTMzKdDm5H5sCdWoUnpY
b/gZWpi8wNgMWjdkvoPz14+esbXEUDt1UV3xiObPcdpK8aIcjev0ke1yU5swFxk3WoJvE2XqB/0e
EmRFYDhmxGlloXOkX3rynb6+/MScXjdhHjzEa/8bPfIVNEcdcXZNUTkJ9FhvjvAdqaxnfrWq8gBZ
LNQqWc0UN0FZrb3DvT+P9e4ucJdb1Iq2GBgo3y6iJKSqTn+N8OKVWRk8ygtG7h+7NTiOac6WkB3a
fjkjKAHPmMchBR0XcBhXFTsjW0ziaUOxcLekggEJIYsNWaSP3cliwmuB2IWSEp/M5o4WPsgQntsY
WHE=
=nTAy
-----END PGP SIGNATURE-----

--JHcKqsjapOcLyl1cdUmc3kX0HkhP8TOkS--
