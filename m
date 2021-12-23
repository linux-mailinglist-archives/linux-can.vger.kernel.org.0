Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B8747E74A
	for <lists+linux-can@lfdr.de>; Thu, 23 Dec 2021 18:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbhLWRy2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 Dec 2021 12:54:28 -0500
Received: from mout01.posteo.de ([185.67.36.65]:34873 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233620AbhLWRy1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 Dec 2021 12:54:27 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 52919240027
        for <linux-can@vger.kernel.org>; Thu, 23 Dec 2021 18:54:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1640282066; bh=skiHA+M22QL2xMaPpv1i4ZEZWRjPO6chM0AWQ7sj0s4=;
        h=Subject:From:To:Cc:Date:From;
        b=IgEt63VZ/L3M8cINtDwZeSWoIUjvG0aj8ZQWKu0D3Krgx65+rsTz2NaXXXhnSXngr
         l4U0ks9JUUY2QlAP5Hkss/Rm8WjBVpdz1fzlqVgHA09sqin870kLoErxHiOyYYV5F/
         d0VX5T1l5Bzt16dqwj43nWkVJGrVU48cXh38j7HloDGDfe5PfWmpRpNP2097mPiXk0
         loFomZmSOEkea2l7XoCbg3ltxvapDX6/4SkqmTepf4qt36yGRZZgPw9Zu+SGGCIerM
         ijYoE66cQTIWXdBI13aG2IZUkkL9bNvVNkNAJ5341N8nGiILBHQTmTpuAOwE7mfXPx
         3IeqkblwPD3QQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4JKd9s3Dwgz9rxF;
        Thu, 23 Dec 2021 18:54:25 +0100 (CET)
Subject: Re: Dual CAN(FD) board w/ MACP251xfd
From:   Patrick Menschel <menschel.p@posteo.de>
To:     "Dr. Michael Lauer" <mickey@vanille.de>
Cc:     linux-can@vger.kernel.org, Drew Fustini <drew@beagleboard.org>
References: <A271F63C-FA42-4864-A621-C5195A35EC83@vanille.de>
 <d91f084a-73de-4486-548d-d39fcb1480bc@posteo.de>
Message-ID: <e5acf66b-33a5-363e-5076-f42e8994ac2d@posteo.de>
Date:   Thu, 23 Dec 2021 17:54:24 +0000
MIME-Version: 1.0
In-Reply-To: <d91f084a-73de-4486-548d-d39fcb1480bc@posteo.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dchz1YtWFLghKA5HsPTPay8S5PWdCngh1"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dchz1YtWFLghKA5HsPTPay8S5PWdCngh1
Content-Type: multipart/mixed; boundary="Bi2j6QRHGKwybBgxCkfiZFCZqcfXOBc8z";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: "Dr. Michael Lauer" <mickey@vanille.de>
Cc: linux-can@vger.kernel.org, Drew Fustini <drew@beagleboard.org>
Message-ID: <e5acf66b-33a5-363e-5076-f42e8994ac2d@posteo.de>
Subject: Re: Dual CAN(FD) board w/ MACP251xfd
References: <A271F63C-FA42-4864-A621-C5195A35EC83@vanille.de>
 <d91f084a-73de-4486-548d-d39fcb1480bc@posteo.de>
In-Reply-To: <d91f084a-73de-4486-548d-d39fcb1480bc@posteo.de>

--Bi2j6QRHGKwybBgxCkfiZFCZqcfXOBc8z
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

LOL, already found an error in my own lines. That was sluggish of me.

In your case udev rules should be

SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi0.0/net/can?", NAME=3D"mcp0"=

SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi1.0/net/can?", NAME=3D"mcp1"=


Best Regards,
Patrick

Am 23.12.21 um 18:49 schrieb Patrick Menschel:
> Hello,
>=20
> afaik Drew got that board working.
>=20
> https://marc.info/?l=3Dlinux-can&m=3D160427096004578&w=3D2
>=20
> Same time we did PRs for board specific overlays, not waveshare but
> seeed while waveshare is very similar to seeed v1
>=20
> https://github.com/raspberrypi/linux/pull/4034
> https://github.com/raspberrypi/linux/pull/4041
>=20
> With some reverse engineering we get back to a hopefully working set of=

> lines.
>=20
> Please try these lines in config.txt
>=20
> dtoverlay=3Dmcp251xfd,spi0-0,interrupt=3D25
> dtoverlay=3Dmcp251xfd,spi1-0,interrupt=3D16
>=20
>=20
> There is also a popular way to get rid of the can0 / can1 swapping, use=

> udev rules.
>=20
> Try pasting this into /etc/udev/rules.d/70-can.rules
>=20
> SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
> DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi0.0/net/can?", NAME=3D"mcp=
0"
> SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
> DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi0.1/net/can?", NAME=3D"mcp=
1"
>=20
>=20
> and correspondingly this into /etc/network/interfaces.d/70-can but you
> may want to change bitrates
>=20
> auto mcp0
> iface mcp0 inet manual
> 	pre-up /sbin/ip link set $IFACE type can bitrate 1000000 sample-point
> 0.75 dbitrate 8000000 dsample-point 0.8 fd on
> 	up /sbin/ifconfig $IFACE up
> 	down /sbin/ifconfig $IFACE down
>=20
> auto mcp1
> iface mcp1 inet manual
> 	pre-up /sbin/ip link set $IFACE type can bitrate 1000000 sample-point
> 0.75 dbitrate 8000000 dsample-point 0.8 fd on
> 	up /sbin/ifconfig $IFACE up
> 	down /sbin/ifconfig $IFACE down
>=20
>=20
> It may be wise to open another PR for that board.
>=20
> Best Regards,
> Patrick
>=20
> Am 23.12.21 um 18:05 schrieb Dr. Michael Lauer:
>> Please forgive me, if this is not the proper list for this message,
>> but as far as I know the developer of the mcp251xfd driver is also rea=
ding here.
>>
>> I recently acquired a Dual CAN FD HAT (https://www.waveshare.com/wiki/=
2-CH_CAN_FD_HAT)
>> to run on my Raspberry PI 4. Currently, this is using kernel 5.15.11, =
but for some
>> reason, only one of the two ports are recognized. Instead of detecting=
 the 2nd port,
>> it seems to just _renames_ the port. Here is the relevant kernel log:
>>
>> [    5.495409] CAN device driver interface
>> [    5.552660] spi_master spi1: will run message pump with realtime pr=
iority
>> [    5.559885] mcp251xfd spi1.0 (unnamed net_device) (uninitialized): =
Detected MCP2518FD, but firmware specifies a MCP2517FD. Fixing up.
>> [    5.580908] vc4-drm gpu: bound fe400000.hvs (ops vc4_hvs_ops [vc4])=

>> [    5.585428] Registered IR keymap rc-cec
>> [    5.599117] rc rc0: vc4 as /devices/platform/soc/fef00700.hdmi/rc/r=
c0
>> [    5.601698] mcp251xfd spi1.0 can0: MCP2518FD rev0.0 (-RX_INT -MAB_N=
O_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz=
 e:16.66MHz) successfully initialized.
>> [    5.633622] input: vc4 as /devices/platform/soc/fef00700.hdmi/rc/rc=
0/input3
>> [    5.677448] vc4-drm gpu: bound fef00700.hdmi (ops vc4_hdmi_ops [vc4=
])
>> [    5.697059] Registered IR keymap rc-cec
>> [    5.698682] mcp251xfd spi1.0 can1: renamed from can0
>>
>> The activated overlays in config.txt are
>>
>> dtoverlay=3D2xMCP2517FD
>> dtoverlay=3D2xMCP2518FD-spi0
>>
>> Perhaps anyone of you has a similar config and can tell me what could =
be wrong?
>>
>> Best,
>>
>> Mickey.
>>
>=20


--Bi2j6QRHGKwybBgxCkfiZFCZqcfXOBc8z--

--dchz1YtWFLghKA5HsPTPay8S5PWdCngh1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAmHEt9AFAwAAAAAACgkQMeZuMM+vuE7C
Uw//aAGfPLGVmRhRuzmXVkou9m2LfWQerr0h9SIBA8leqF1aFKngdCFuxeLXZV+aBtQq3H6CADXJ
pSBDWXg4Kl9hDUmnxgG+ttXiA4jCHvZOcBojp22+//3QNnOeMr0anosqy+RuR58YJhBfLTrHYWxH
rBxw+WsR9YC2YyN6lSA9XK2Krg9MpWeXsWD86AB8rh25eydPRkumLQNaDcR3c1mNo1SLL9qP8Z/u
2+0uVh43EdfT4wnbs5s8qRt9O4mEHxesKf4g4gAjdeDnqskZPyL/CLKxy9IUBWc5zQn+J3H4xi2P
dTg1Hn3o3WXciUB4hjPMoOxQJHtK9oDQv3zImb3QecW6ymfZsjMxQZq5+FMEY+6YffOV3cx8mDeQ
GxbevErvqnH+hAk+GhPXes2jwEYQbtUcJZ4KS+PiXtqJgYFcdzv89OTmrXBqZA0hAXsuVJO8AJSx
GioIm/KElMguhhi5uNIu2OzzpaNDhnUP6H8SRamBBrcLdHcF3Q/NWoWgXCQJsHqcSOQa1fl0mm+X
0b6o0ujXFM9Ml8iCaPg2+KYnyDKN48FaLEGhn+IyRQ/aExq/WDPLlsx1aPRFvQOkTQ78y+2hYlPV
uNQhmODnlPwVfKZ0vFsrRrGe0gy3ll9MC05bPdpcOuYPM13EWVsm9yRIdHiYtXnvFUXFlyujc7/9
D9Y=
=KU95
-----END PGP SIGNATURE-----

--dchz1YtWFLghKA5HsPTPay8S5PWdCngh1--
