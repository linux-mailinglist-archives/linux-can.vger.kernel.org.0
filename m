Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C6258EB36
	for <lists+linux-can@lfdr.de>; Wed, 10 Aug 2022 13:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiHJLZR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Aug 2022 07:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHJLZQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Aug 2022 07:25:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F20745F79
        for <linux-can@vger.kernel.org>; Wed, 10 Aug 2022 04:25:15 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oLjpp-0001iP-LD; Wed, 10 Aug 2022 13:25:13 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 00875C68D4;
        Wed, 10 Aug 2022 11:25:12 +0000 (UTC)
Date:   Wed, 10 Aug 2022 13:25:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Bath <mark@baggywrinkle.co.uk>
Cc:     linux-can@vger.kernel.org
Subject: Re: Raspberry PI running 5.10.x Kernel and issues with Daul channel
 Waveshare based 2.1 MCP251xFD CAN HAT
Message-ID: <20220810112510.zmpo6eqo7bipvtth@pengutronix.de>
References: <9024B39B-CCDA-4E10-9A4E-70A4335F6304@baggywrinkle.co.uk>
 <20220810103605.nsh7r4pe6g7lzbvv@pengutronix.de>
 <CD5C45C2-85DE-4105-B096-13FDA3FE1932@baggywrinkle.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jygnw25nn6sw3h4i"
Content-Disposition: inline
In-Reply-To: <CD5C45C2-85DE-4105-B096-13FDA3FE1932@baggywrinkle.co.uk>
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


--jygnw25nn6sw3h4i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.08.2022 12:14:46, Mark Bath wrote:
>=20
>=20
> > On 10 Aug 2022, at 11:36, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >=20
> >> The embedded Linux device
> >> root@Venus:~# ip -details link show can0
> >> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mod=
e DEFAULT group default qlen 100
> >>    link/can  promiscuity 0 minmtu 0 maxmtu 0=20
> >>    can state ERROR-ACTIVE (berr-counter tx 0 rx 83) restart-ms 100=20
> >> 	  bitrate 250000 sample-point 0.875=20
> >> 	  tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
> >                                         ^^^^^^^^^^^^^^^^^^
> >=20
> > Here the sjw is 50% of phase-seg2.
> >=20
> >> 	  sun4i_can: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
> >> 	  clock 24000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_m=
ax_segs 65535=20
> >>=20
> >>=20
> >> RaspberryPI4 with the wave share dual can hat
> >> root@Olaso-PI:~# ip -details link show can0
> >> 5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mod=
e DEFAULT group default qlen 100
> >>    link/can  promiscuity 0 minmtu 0 maxmtu 0=20
> >>    can state ERROR-WARNING (berr-counter tx 0 rx 124) restart-ms 100=
=20
> >> 	  bitrate 250000 sample-point 0.875=20
> >> 	  tq 25 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
> >                                          ^^^^^^^^^^^^^^^^^^^
> > Can you try to configure sjw to 10 on the mcp251xfd for 250 kbit/s.
>=20
> That did it. All stable and working great.

\o/

> > Which tool are you using to configure the bitrate?
>=20
> Ip command from iproute2
>=20
> ip link set $dev up txqueuelen 100 type can bitrate $rate restart-ms 100

Ok, I just wanted to know in case you needed help to set the sjw.

> >> 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
> >> 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-in=
c 1
> >> 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_m=
ax_segs 65535=20
> >>=20
> >> ip -details link show can1
> >> 6: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mod=
e DEFAULT group default qlen 100
> >>    link/can  promiscuity 0 minmtu 0 maxmtu 0=20
> >>    can state ERROR-WARNING (berr-counter tx 0 rx 125) restart-ms 100=
=20
> >> 	  bitrate 500000 sample-point 0.875=20
> >> 	  tq 25 prop-seg 34 phase-seg1 35 phase-seg2 10 sjw 1
> >                                          ^^^^^^^^^^^^^^^^^^^
> >=20
> > Try a sjw of 5 for 500 kbit/s.
>=20
> That also worked.

\o/

> Should I be manually setting the sow value or should it have been set
                                   ^^^
                                   sjw :)
> automatically?

For now you have to do it automatically. I have on my todo list to
improve the bit timing calculation algorithm to calculate a proper sjw
value. The kernel default is currently an absolute value of "1". sjw is
better described as a percentage of min(phase-seg1, phase-seg2).

> Thank you for the quick response, while it looks like an easy fix, the
> system has many different possible can hats that could be used so
> modifying the ip command could be challenging for just this HAT.

If you target sjw to be 50% of phase-seg2, the absolute sjw value
depends on phase-seg2. phase-seg2 depends on the input CAN clock, the
bitrate of the CAN bus and the used CAN controller.

So if you always use mcp2518fd with 40 MHz external oscillator you have
a sjw per CAN bus bitrate. (i.e. 10 for 250 kbit/s, 5 for 500 kbit/s).

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jygnw25nn6sw3h4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLzlZQACgkQrX5LkNig
013Luwf/QXaGtSIkmAbfTTkk3zJYNfIyHG2I9TRyi2TQADAc00H7ZI+Lb9e41v05
T8UQWphRrLRnS1kXMZFSGtAL2XA7rmtQDGjBxpsFIRNa/iFiZGRAXsK+JND3nSV5
4vcN7Wr45q2vXvyqbCbgAJDHNRyVTX+G5fVIO8XprWE8i99L9vEvRSpVW713RMhA
+X1LoMDCL2FY9W2WMrtBeonsyFw2ibWSSLJ959DEb6qDjUtCabq3gYmf/1UTJPGQ
55Wz8Ycx4VVuDCSaDuSPKBxFiMa/R4RvfF+8b8HM3aGBSb6dqmIamYqOomIxXv3v
ZBkaGoVVLwg/nl6B7Ogd0wjlr4jfow==
=FE91
-----END PGP SIGNATURE-----

--jygnw25nn6sw3h4i--
