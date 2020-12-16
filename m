Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D387E2DC13B
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 14:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgLPN1e (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Dec 2020 08:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgLPN1d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Dec 2020 08:27:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77990C061794
        for <linux-can@vger.kernel.org>; Wed, 16 Dec 2020 05:26:53 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kpWpP-0004RH-VP; Wed, 16 Dec 2020 14:26:52 +0100
Received: from [IPv6:2a03:f580:87bc:d400:10ad:750d:921e:f802] (unknown [IPv6:2a03:f580:87bc:d400:10ad:750d:921e:f802])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 739805AEAD6;
        Wed, 16 Dec 2020 13:26:49 +0000 (UTC)
To:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DB8P190MB06343276BF64CB3530DEB5D6D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: assignment of spi to can channels
Message-ID: <32e1f29b-b16e-bc8e-e57a-92c67d45a335@pengutronix.de>
Date:   Wed, 16 Dec 2020 14:26:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DB8P190MB06343276BF64CB3530DEB5D6D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XkAXlLqY5UKI7V6H3tvARlXrX3Wxly3Ce"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XkAXlLqY5UKI7V6H3tvARlXrX3Wxly3Ce
Content-Type: multipart/mixed; boundary="yemZvHERvCcAtZr5GnsGc5Dq0bgKyfW5m";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sven Schuchmann <schuchmann@schleissheimer.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <32e1f29b-b16e-bc8e-e57a-92c67d45a335@pengutronix.de>
Subject: Re: assignment of spi to can channels
References: <DB8P190MB06343276BF64CB3530DEB5D6D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <DB8P190MB06343276BF64CB3530DEB5D6D9C50@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>

--yemZvHERvCcAtZr5GnsGc5Dq0bgKyfW5m
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/16/20 11:43 AM, Sven Schuchmann wrote:
> Hello,
> I have a question regarding the assignment of spi to can channels.
> At this time I see sometimes this:
>=20
> [    6.665217] mcp251xfd spi0.0 can0: MCP2518FD rev0.0 (-RX_INT ...
> [    6.675670] mcp251xfd spi1.0 can1: MCP2518FD rev0.0 (-RX_INT ...
>=20
> and sometimes this:
>=20
> [    6.612654] mcp251xfd spi1.0 can0: MCP2518FD rev0.0 (-RX_INT ...
> [    6.623504] mcp251xfd spi0.0 can1: MCP2518FD rev0.0 (-RX_INT ...
>=20
> Probably asked a thousand times but I did not find
> a solution: How can I fix the assignment from spi0.0 to can0
> and spi1.0 to can1?

The classic solution would be a udev rule in e.g. /etc/udev/rules.d/70-ca=
n.rules"

> SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add", DEVPATH=3D=3D"/devices/platfor=
m/soc/*/*/*/spi0.0/net/can?", NAME=3D"mcp0"
> SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add", DEVPATH=3D=3D"/devices/platfor=
m/soc/*/*/*/spi1.0/net/can?", NAME=3D"mcp1"
> SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add", DEVPATH=3D=3D"/devices/platfor=
m/soc/*/*/*/spi2.0/net/can?", NAME=3D"mcp2"
> SUBSYSTEM=3D=3D"net", ACTION=3D=3D"add", DEVPATH=3D=3D"/devices/platfor=
m/soc/*/*/*/spi2.1/net/can?", NAME=3D"mcp3"

Figure out the exact DEVPATH with

> udevadm test /sys/class/net/can0
> udevadm test /sys/class/net/can1

Note, with older versions of udev it was possible to rename interfaces wi=
thin
the same namespace, e.g. use "NAME=3Dcan0". I think this doesn't work wit=
h newer
udevs anymore, so in this example "mcp?" is used.

The above udev-only approach is from some old documentation I found, but =
not
tested. I'm using the modern systemd approach...


The modern approach is to use systemd-networkd, this requires systemd > 2=
46, as
the older versions don't have the chip select "-cs-" in the "Path".

/etc/systemd/network/70-mcp251xfd0.link:
> [Match]
> Driver=3Dmcp251xfd
> # RPI3 RPI4
> Path=3Dplatform-3f204000.spi-cs-0 platform-fe204000.spi-cs-0
>=20
> [Link]
> Name=3Dmcp251xfd0

Again use "udevadm test /sys/class/net/can0", but the "Path" in the .link=
 file
corresponds to ID_PATH from udevadm test. See "man systemd.link" for deta=
ils.

And use this file to configure the CAN interface.

/etc/systemd/network/80-can.network:
> [Match]
> Name=3Dmcp251x*
>=20
> [CAN]
> BitRate=3D500K
> RestartSec=3D1s

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--yemZvHERvCcAtZr5GnsGc5Dq0bgKyfW5m--

--XkAXlLqY5UKI7V6H3tvARlXrX3Wxly3Ce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl/aCxUACgkQqclaivrt
76lrzQgApTDfOACKWWJkIypng1X8XujoRELRVN0gScD5132H3q+cIHRIvzCoAnGC
gih/YSkOdRNeqKKY8ARsDA40wZaVs+NM40ya1hOEKUMoYAYV3eFj09DhVFDVfZRv
WQtv1yFG5AeUOH3/AEDSQ1F96fH7KjjUY3Q2Jt2+txBUn+x6/Utvy7XJS5uliPdT
kPJYkh68DUkxXIUN+Jmjg8HUjP8LE92fOJCvt3AFRTrzNRZOO9cdZjgnN0so3ktY
eD9P4CVWrSanYcoWw2b9MJAFYFqGBqz0RxYr20ik6hKy3ek6zfYVjSvSE6jSgvKr
a5z8gLSPSzFKPkofp+LE94V3CAmwxQ==
=6pQ3
-----END PGP SIGNATURE-----

--XkAXlLqY5UKI7V6H3tvARlXrX3Wxly3Ce--
