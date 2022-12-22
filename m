Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B989165436D
	for <lists+linux-can@lfdr.de>; Thu, 22 Dec 2022 15:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLVO4e (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Dec 2022 09:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiLVO4d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Dec 2022 09:56:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825551EAD5
        for <linux-can@vger.kernel.org>; Thu, 22 Dec 2022 06:56:32 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p8Mzm-00025w-9H; Thu, 22 Dec 2022 15:56:30 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E64B814548F;
        Thu, 22 Dec 2022 13:02:20 +0000 (UTC)
Date:   Thu, 22 Dec 2022 14:02:19 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "Thomas.Kopp@microchip.com" <Thomas.Kopp@microchip.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: mcp251xfd: Bad message receiption
Message-ID: <20221222130219.xrfnm54g6lfjozvs@pengutronix.de>
References: <FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <PH7PR11MB6498DA4A162106BD4ACB7551FBE89@PH7PR11MB6498.namprd11.prod.outlook.com>
 <FR0P281MB1966CA0C12ED24574368A36E97E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s3ewm6inoau7ko35"
Content-Disposition: inline
In-Reply-To: <FR0P281MB1966CA0C12ED24574368A36E97E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--s3ewm6inoau7ko35
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.12.2022 10:30:22, Stefan Alth=C3=B6fer wrote:
> Hi Thomas,
>=20
> > Do I read the pdf correctly (based on the /var/log stuff) that you have=
 two MCP2518FD connected to a Pi4B and=20
> > both of them are running in internal/external loopback mode no interact=
ion between them and the SPIs are separate?
>=20
> Yes. For the loopback test the CANs are separate. Errors also occur when =
sending messages between
> the controllers, but I think that is more difficult to analyze.
>=20
> root@raspberrypi:~# ip -d -s a s can0
> 4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP group =
default qlen 1000
>     link/can  promiscuity 0 minmtu 0 maxmtu 0
>     can <LOOPBACK,BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx =
0 rx 0) restart-ms 0
>           bitrate 1000000 sample-point 0.800
>           tq 25 prop-seg 15 phase-seg1 16 phase-seg2 8 sjw 6
>           mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-=
inc 1
>           dbitrate 4000000 dsample-point 0.800
>           dtq 25 dprop-seg 3 dphase-seg1 4 dphase-seg2 2 dsjw 2
>           mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbr=
p-inc 1
>           clock 40000000
>           re-started bus-errors arbit-lost error-warn error-pass bus-off
>           0          0          0          0          0          0       =
  numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
>     RX: bytes  packets  errors  dropped missed  mcast
>     3097429872 2517466658 0       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     3696197680 1258733264 0       0       0       0
> root@raspberrypi:~# ip -d -s a s can1
> 5: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP group =
default qlen 1000
>     link/can  promiscuity 0 minmtu 0 maxmtu 0
>     can <LOOPBACK,BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx =
0 rx 0) restart-ms 0
>           bitrate 1000000 sample-point 0.800
>           tq 25 prop-seg 15 phase-seg1 16 phase-seg2 8 sjw 6
>           mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-=
inc 1
>           dbitrate 4000000 dsample-point 0.800
>           dtq 25 dprop-seg 3 dphase-seg1 4 dphase-seg2 2 dsjw 2
>           mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbr=
p-inc 1
>           clock 40000000
>           re-started bus-errors arbit-lost error-warn error-pass bus-off
>           0          112256     0          1          3          1       =
  numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
                       ^^^^^^                ^          ^          ^
>     RX: bytes  packets  errors  dropped missed  mcasta
>     2590649888 773910314 3       0       0       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     3442619696 386944310 112254  12      0       0

Why do you have so many errors on can1? The device event went into bus-off.

> This is the SPI setup for the dual CAN PI:
>=20
> dtparam=3Dspi=3Don
> dtoverlay=3Dspi6-1cs
> # mcp251xfd DTS for RPI4 default CAN on SPI6.0
> dtoverlay=3Dmcp251xfd-spi6-0,interrupt_pin=3D25,oscillator=3D40000000
> # mcp251xfd DTS for RPI4 CAN extension on SPI0.0
> dtoverlay=3Dmcp251xfd,spi0-0,interrupt=3D16,oscillator=3D40000000
>=20
> Or did you mean something else with "script"?

Can you share your "scselftest" program?

> I'll try the register dump when I suffer the next error ;-)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--s3ewm6inoau7ko35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOkVVcACgkQrX5LkNig
013hzggAh32Kh5OycMwfn2lQQeN/0XDzNyZelNlNTvO4l8gmh5Md6NoUGL0/9taK
bJDLD8cvw53sSuoPn9w4TTY+9W3ouOchR0Tnb/5/lkG2B/7LcaSMJQPUdKEe1cw8
FE9PCRdX5tl4+2w+EzUfGHVm8s6ug5+QeRv/rAQPAnTI5598MV/UFnCtPTcfI5ZX
6dU89gFSxrOj2JVL2Nek/IXaCMPzSGWNOoZ0peFDHroAHHkuufkrHz2ZyO/zFTkV
YlpOfB1gra0NG95RBRB3tdZMeMHbCJ6n91QOiJaMocSZGjWmj/0n4CGyqYJS4L99
KG/1NnbotMhaEFc6ycy5Ld+3arhN9A==
=EeM5
-----END PGP SIGNATURE-----

--s3ewm6inoau7ko35--
