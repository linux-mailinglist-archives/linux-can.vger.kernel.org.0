Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38AB47E73B
	for <lists+linux-can@lfdr.de>; Thu, 23 Dec 2021 18:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhLWRtM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 Dec 2021 12:49:12 -0500
Received: from mout02.posteo.de ([185.67.36.66]:60417 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhLWRtM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 Dec 2021 12:49:12 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 290DE240103
        for <linux-can@vger.kernel.org>; Thu, 23 Dec 2021 18:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1640281751; bh=rk0hZQHZTJR1S8knH1UrBbQIvDxpfJhv/l3VbkFsxPY=;
        h=To:From:Cc:Subject:Date:From;
        b=b938TphI8Ey2HGAjTodWD6FlnCIrmsCoy5QkqWjBbK8hkMYikWXeqAO54P2HuFNIN
         KAYEi6I4yqrrUIhccoGHldDJuyd5PiFbSpMPNVuhIqe0pgdV5sLBJDW9YIeXhjLER8
         8p45KDrQ/QqrEY4qrqOHCuJ+z2tjoOru57tC04k31o1WwE3k0oXwLdWRb+qthDwwLK
         stZuybX151bapXnzw+3As+3jWJ7SDjRmG7Pu5uSex7fZrr9kqSxg3MYt+3FrNgCX50
         h6zxKeJfrtQD1K3kOG6+NCa4Ji9aKC+riHNiLiWAAV15T276D6EomeqkfBoawH/cik
         igTSqxVfyCYxQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4JKd3p2YgTz6tms;
        Thu, 23 Dec 2021 18:49:10 +0100 (CET)
To:     "Dr. Michael Lauer" <mickey@vanille.de>
References: <A271F63C-FA42-4864-A621-C5195A35EC83@vanille.de>
From:   Patrick Menschel <menschel.p@posteo.de>
Cc:     linux-can@vger.kernel.org, Drew Fustini <drew@beagleboard.org>
Subject: Re: Dual CAN(FD) board w/ MACP251xfd
Message-ID: <d91f084a-73de-4486-548d-d39fcb1480bc@posteo.de>
Date:   Thu, 23 Dec 2021 17:49:09 +0000
MIME-Version: 1.0
In-Reply-To: <A271F63C-FA42-4864-A621-C5195A35EC83@vanille.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="58kVrEpx3lHc9KPCwHqZTwyJjRf7vHajF"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--58kVrEpx3lHc9KPCwHqZTwyJjRf7vHajF
Content-Type: multipart/mixed; boundary="ny1sn3BwAnRbkMzktNOHpl9MXUbkOG8ui";
 protected-headers="v1"
From: Patrick Menschel <menschel.p@posteo.de>
To: "Dr. Michael Lauer" <mickey@vanille.de>
Cc: linux-can@vger.kernel.org, Drew Fustini <drew@beagleboard.org>
Message-ID: <d91f084a-73de-4486-548d-d39fcb1480bc@posteo.de>
Subject: Re: Dual CAN(FD) board w/ MACP251xfd
References: <A271F63C-FA42-4864-A621-C5195A35EC83@vanille.de>
In-Reply-To: <A271F63C-FA42-4864-A621-C5195A35EC83@vanille.de>

--ny1sn3BwAnRbkMzktNOHpl9MXUbkOG8ui
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello,

afaik Drew got that board working.

https://marc.info/?l=3Dlinux-can&m=3D160427096004578&w=3D2

Same time we did PRs for board specific overlays, not waveshare but
seeed while waveshare is very similar to seeed v1

https://github.com/raspberrypi/linux/pull/4034
https://github.com/raspberrypi/linux/pull/4041

With some reverse engineering we get back to a hopefully working set of
lines.

Please try these lines in config.txt

dtoverlay=3Dmcp251xfd,spi0-0,interrupt=3D25
dtoverlay=3Dmcp251xfd,spi1-0,interrupt=3D16


There is also a popular way to get rid of the can0 / can1 swapping, use
udev rules.

Try pasting this into /etc/udev/rules.d/70-can.rules

SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi0.0/net/can?", NAME=3D"mcp0"=

SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add",
DEVPATH=3D=3D"/devices/platform/soc/*/*/*/spi0.1/net/can?", NAME=3D"mcp1"=



and correspondingly this into /etc/network/interfaces.d/70-can but you
may want to change bitrates

auto mcp0
iface mcp0 inet manual
	pre-up /sbin/ip link set $IFACE type can bitrate 1000000 sample-point
0.75 dbitrate 8000000 dsample-point 0.8 fd on
	up /sbin/ifconfig $IFACE up
	down /sbin/ifconfig $IFACE down

auto mcp1
iface mcp1 inet manual
	pre-up /sbin/ip link set $IFACE type can bitrate 1000000 sample-point
0.75 dbitrate 8000000 dsample-point 0.8 fd on
	up /sbin/ifconfig $IFACE up
	down /sbin/ifconfig $IFACE down


It may be wise to open another PR for that board.

Best Regards,
Patrick

Am 23.12.21 um 18:05 schrieb Dr. Michael Lauer:
> Please forgive me, if this is not the proper list for this message,
> but as far as I know the developer of the mcp251xfd driver is also read=
ing here.
>=20
> I recently acquired a Dual CAN FD HAT (https://www.waveshare.com/wiki/2=
-CH_CAN_FD_HAT)
> to run on my Raspberry PI 4. Currently, this is using kernel 5.15.11, b=
ut for some
> reason, only one of the two ports are recognized. Instead of detecting =
the 2nd port,
> it seems to just _renames_ the port. Here is the relevant kernel log:
>=20
> [    5.495409] CAN device driver interface
> [    5.552660] spi_master spi1: will run message pump with realtime pri=
ority
> [    5.559885] mcp251xfd spi1.0 (unnamed net_device) (uninitialized): D=
etected MCP2518FD, but firmware specifies a MCP2517FD. Fixing up.
> [    5.580908] vc4-drm gpu: bound fe400000.hvs (ops vc4_hvs_ops [vc4])
> [    5.585428] Registered IR keymap rc-cec
> [    5.599117] rc rc0: vc4 as /devices/platform/soc/fef00700.hdmi/rc/rc=
0
> [    5.601698] mcp251xfd spi1.0 can0: MCP2518FD rev0.0 (-RX_INT -MAB_NO=
_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz =
e:16.66MHz) successfully initialized.
> [    5.633622] input: vc4 as /devices/platform/soc/fef00700.hdmi/rc/rc0=
/input3
> [    5.677448] vc4-drm gpu: bound fef00700.hdmi (ops vc4_hdmi_ops [vc4]=
)
> [    5.697059] Registered IR keymap rc-cec
> [    5.698682] mcp251xfd spi1.0 can1: renamed from can0
>=20
> The activated overlays in config.txt are
>=20
> dtoverlay=3D2xMCP2517FD
> dtoverlay=3D2xMCP2518FD-spi0
>=20
> Perhaps anyone of you has a similar config and can tell me what could b=
e wrong?
>=20
> Best,
>=20
> Mickey.
>=20


--ny1sn3BwAnRbkMzktNOHpl9MXUbkOG8ui--

--58kVrEpx3lHc9KPCwHqZTwyJjRf7vHajF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE6VSgQlqXIUKDwAxHMeZuMM+vuE4FAmHEtpUFAwAAAAAACgkQMeZuMM+vuE7p
1RAAofw3gZMipvqGH5bcy0gkOe3AKZA97zKZMEPFY0yF/Dp7ytKZ/Ifc5Ye0sTgE7LiUeSntcZQp
CgJFpxwsElw8bvhD177FOxpRwjz/fc0g13BuTP6ZavYQse0vIoFQbqqBll7450ZpN3EYZtSc6sEN
ZLNfOGB9mN63Rl7RbApiYnDgHpleQgMrRxlW/90uc3WPVLYQqFZPw7kIrPBIk8hTXZY5zXHem9H7
6u2eMBz4QO/3Bk2oCswdmm01IABprHb+Ng6fMsgn7h0Om/1E/JyvY2LiCh9w4LAakBb+T7ZimxCS
IwWKDsWEexk0y1GZWorq8DQuGTimU1AaIqwCGP2qIZhpl2oycu/20A5JVQgGbqFLtcZkU4RIczfY
jmG13NnpIDfFlk7KK8mLGRgarGDhMq5BeoKOGr49lmSCWa/YL1XJIVzdvPM3O7hFZRFDNuOsvCUu
9dckzev9oALNYsjl3faeSLWqjChabH/6IIJ6YZDPE8XV6z5r2WUCyrjyGlGI6H6BDM2gjKq08ZZH
P4v4TuuoSazIKV9bDOzxMfm1vkIJt4ybMOq/MNa8SPK/PGnEOyQwylIYIzPgj225w69i9cHjY1BF
61FFRCsaUDSCisOes1NmanRbaoF6uXt84FoU6fcmFxSH4F12zN29EbdRUTJZgLDvbHyVl6oQQSVU
CKk=
=c9Cc
-----END PGP SIGNATURE-----

--58kVrEpx3lHc9KPCwHqZTwyJjRf7vHajF--
