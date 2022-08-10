Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28F058EA84
	for <lists+linux-can@lfdr.de>; Wed, 10 Aug 2022 12:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiHJKgM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Aug 2022 06:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiHJKgL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Aug 2022 06:36:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8FF4C615
        for <linux-can@vger.kernel.org>; Wed, 10 Aug 2022 03:36:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oLj4K-00043w-7h; Wed, 10 Aug 2022 12:36:08 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 960EBC683D;
        Wed, 10 Aug 2022 10:36:07 +0000 (UTC)
Date:   Wed, 10 Aug 2022 12:36:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Bath <mark@baggywrinkle.co.uk>
Cc:     linux-can@vger.kernel.org
Subject: Re: Raspberry PI running 5.10.x Kernel and issues with Daul channel
 Waveshare based 2.1 MCP251xFD CAN HAT
Message-ID: <20220810103605.nsh7r4pe6g7lzbvv@pengutronix.de>
References: <9024B39B-CCDA-4E10-9A4E-70A4335F6304@baggywrinkle.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7jkdvcgrcyvtob7m"
Content-Disposition: inline
In-Reply-To: <9024B39B-CCDA-4E10-9A4E-70A4335F6304@baggywrinkle.co.uk>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7jkdvcgrcyvtob7m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.08.2022 11:30:53, Mark Bath wrote:
> I hope someone can give me some pointers on what might be causing my
> system an issue or how to debug the issue.
>=20
> The revision 2 Waveshare Dual channel MCP251xFD CAN HAT was working
> fine in my LAB with 2 or 3 other can devices. Both can channels are
> using standard 29 bit CAN2.0 extended identifiers. The can0 interface
> was running at 250kb, and can1at 500Kb.
>=20
> As soon as I moved the device into my live environment I have started
> to have issues.
>=20
> The 250Kb segment has around 10-15 devices and a bus length of
> something in the order of 40m, properly terminated at each end with a
> 120ohm resistor. The 500kb segment has 2 devices and is maybe 10m in
> length and also properly terminated. Without the PI connected both
> segments are running fine with no reported BER counters. The following
> output is from an embedded linux based device on the network when my
> PI is not connected.
>=20
> root@Venus:~# ip -details link show can0
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode D=
EFAULT group default qlen 100
>     link/can  promiscuity 0 minmtu 0 maxmtu 0=20
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 100=20
> 	  bitrate 250000 sample-point 0.875=20
> 	  tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
> 	  sun4i_can: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
> 	  clock 24000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_=
segs 65535=20
>=20
> The bus loading is very low.
>=20
> root@Venus:~# canbusload can0@250000=20
>  can0@250000    84   13440   5376   5%
>  can0@250000   133   21280   8512   8%
>  can0@250000    95   15200   6080   6%
>  can0@250000   114   18240   7296   7%
>  can0@250000   105   16800   6720   6%
>  can0@250000   132   21020   8368   8%
>  can0@250000   104   16640   6656   6%
>=20
> As soon as I attach the PI4 with the revision 2.1 waveshare 251xFD
> dual can hat I start getting BER errors on devices, and the PI is
> reporting RX BER errors.
>=20
> The embedded Linux device
> root@Venus:~# ip -details link show can0
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode D=
EFAULT group default qlen 100
>     link/can  promiscuity 0 minmtu 0 maxmtu 0=20
>     can state ERROR-ACTIVE (berr-counter tx 0 rx 83) restart-ms 100=20
> 	  bitrate 250000 sample-point 0.875=20
> 	  tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
                                         ^^^^^^^^^^^^^^^^^^

Here the sjw is 50% of phase-seg2.

> 	  sun4i_can: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
> 	  clock 24000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_=
segs 65535=20
>=20
>=20
> RaspberryPI4 with the wave share dual can hat
> root@Olaso-PI:~# ip -details link show can0
> 5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode D=
EFAULT group default qlen 100
>     link/can  promiscuity 0 minmtu 0 maxmtu 0=20
>     can state ERROR-WARNING (berr-counter tx 0 rx 124) restart-ms 100=20
> 	  bitrate 250000 sample-point 0.875=20
> 	  tq 25 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
                                          ^^^^^^^^^^^^^^^^^^^
Can you try to configure sjw to 10 on the mcp251xfd for 250 kbit/s.

Which tool are you using to configure the bitrate?

> 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
> 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
> 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_=
segs 65535=20
>=20
> ip -details link show can1
> 6: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode D=
EFAULT group default qlen 100
>     link/can  promiscuity 0 minmtu 0 maxmtu 0=20
>     can state ERROR-WARNING (berr-counter tx 0 rx 125) restart-ms 100=20
> 	  bitrate 500000 sample-point 0.875=20
> 	  tq 25 prop-seg 34 phase-seg1 35 phase-seg2 10 sjw 1
                                          ^^^^^^^^^^^^^^^^^^^

Try a sjw of 5 for 500 kbit/s.

> 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
> 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
> 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_=
segs 65535=20
>=20
> Do you have any idea what might be doing this. I have checked cables,
> termination, voltages, etc and all are OK. I have asked Waveshare and
> basically been given the not our issue, its the network.
>=20
> I have even checked the cable drops between the backbone and PI, by
> plugging alternative devices in and they have behaved correctly.
> Moving the PI to an alternative drop has also not hanged anything.
>=20
> It seems to me that there might be a timing issue, but have no idea
> how to check.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7jkdvcgrcyvtob7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLzihIACgkQrX5LkNig
012kywf+N0Ubl5ErmFDqR2Z4BkZ8fYr3tm7dwcHVAnN60xESdUA/GNEGlpouHmYG
Pl6iVPk4pmVDgzc7LsKwV5pwBb9TUGEnmkJIS0gyuJEd+a9a7M8EmjS8YVrJxRc6
Tub3wyrp4nUwPjOXxZYzF+iGgrPbuAsWwdVqcuNOww6H08s6g1l/9AtyvqIQzVMe
YU+k4jB4uZBQFv4JWM7KOaPbB9puFNwEcG9cF5NPWmlmej2EYDX/JvxzpJLjuCwW
fmrpzBtz8EEa0wLVmoitnMujUjy3qpYLa9fYaT5OPQk79QnXYpYkt5JoW1EStEed
IcyKcLcG+NbUuCtwobz8wdY8kQsSEw==
=8Ga4
-----END PGP SIGNATURE-----

--7jkdvcgrcyvtob7m--
