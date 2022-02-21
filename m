Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871384BEBD7
	for <lists+linux-can@lfdr.de>; Mon, 21 Feb 2022 21:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbiBUU2W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Feb 2022 15:28:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiBUU2K (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Feb 2022 15:28:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD45E237C8
        for <linux-can@vger.kernel.org>; Mon, 21 Feb 2022 12:27:46 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nMFHc-0000H3-0x; Mon, 21 Feb 2022 21:27:44 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-8a8f-88e2-750d-6aa5.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:8a8f:88e2:750d:6aa5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AC7AC39F2C;
        Mon, 21 Feb 2022 20:27:42 +0000 (UTC)
Date:   Mon, 21 Feb 2022 21:27:42 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: Queries on CAN frame work
Message-ID: <20220221202742.pamu76aloh2i5iw7@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qyxlat5qubuo64a"
Content-Disposition: inline
In-Reply-To: <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
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


--2qyxlat5qubuo64a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.02.2022 14:43:57, Srinivas Neeli wrote:
> > Can you please provide me:
> > - the bit timing constants of the IP core for the arbitration and data
> >   phase
> > - the bit rate for the arbitration and data phase
> >   (especially where the framework calculates not common prescalers)
> > - the clock rate of the CAN bus clock
> >=20
> > Can you also provide the hand calculated bit timing parameters for the
> > above scenarios?
>=20
> Baud rate 1/5Mbps
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> root@xilinx-vck190-2021_1:~# ip link set can6 type can bitrate 1000000 db=
itrate 5000000 fd on  =20
> [   26.837057] xilinx_can ff070000.can can6: bitrate error 0.0%
> [   26.842731] xilinx_can ff070000.can can6: bitrate error 0.0%
>  can6 txqroot@xilinx-vck190-2021_1:~# ifconfig can6 txqueuelen 1000
>  root@xilinx-vck190-2021_1:~# ip link set can6 up
> [   27.340880] IPv6: ADDRCONF(NETDEV_CHANGE): can6: link becomes ready
> root@xilinx-vck190-2021_1:~# ip -d -s link show can6
>  can6: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEF=
AULT group default qlen 1000
>     link/can  promiscuity 0 minmtu 0 maxmtu 0=20
>     can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0=20
> 	  bitrate 999999 sample-point 0.750=20
> 	  tq 250 prop-seg 1 phase-seg1 1 phase-seg2 1 sjw 1
> 	  xilinx_can: tseg1 1..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
> 	  dbitrate 4999999 dsample-point 0.750=20
> 	  dtq 50 dprop-seg 1 dphase-seg1 1 dphase-seg2 1 dsjw 1
> 	  xilinx_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
> 	  clock 79999999=20
> 	  re-started bus-errors arbit-lost error-warn error-pass bus-off
> 	  0          0          0          0          0          0         numtx=
queues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535=20
>     RX: bytes  packets  errors  dropped overrun mcast  =20
>     0          0        0       0       0       0      =20
>     TX: bytes  packets  errors  dropped carrier collsns=20
>     0          0        0       0       0       0      =20
> root@xilinx-vck190-2021_1:~#=20
>=20
> Parameters
> BPRA -20, TS1 =3D 2, TS2 =3D1,sjw =3D1,
> BPRD - 4, TS1 =3D 2, Ts2 =3D 1,sjw =3D1,
> Clock ~80Mhz(79999999)
>=20
> Hand configuration:
> ---------------------------=20
> ip link set can0 type can tq 12 prop-seg 29 phase-seg1 30 phase-seg2 20 s=
jw 1 dtq 12 dprop-seg 5 dphase-seg1 6 dphase-seg2 4 dsjw 1 fd on  (A/D: 1/5=
Mbps, Sample point=3D75%)
>=20
> Baud rate 1/4Mbps
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> root@xilinx-vck190-2021_1:~# ip link set can6 type can bitrate 1000000 db=
itrate 4000000 fd on  =20
> [  209.572938] xilinx_can ff070000.can can6: bitrate error 0.0%
> [  209.578627] xilinx_can ff070000.can can6: bitrate error 0.0%
> root@xilinx-vck190-2021_1:~#=20
> root@xilinx-vck190-2021_1:~# ip -d -s link show can6
> 9: can6: <NOARP,ECHO> mtu 72 qdisc pfifo_fast state DOWN mode DEFAULT gro=
up default qlen 1000
>     link/can  promiscuity 0 minmtu 0 maxmtu 0=20
>     can <FD> state STOPPED (berr-counter tx 0 rx 0) restart-ms 0=20
> 	  bitrate 999999 sample-point 0.750=20
> 	  tq 250 prop-seg 1 phase-seg1 1 phase-seg2 1 sjw 1
> 	  xilinx_can: tseg1 1..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
> 	  dbitrate 3999999 dsample-point 0.750=20
> 	  dtq 62 dprop-seg 1 dphase-seg1 1 dphase-seg2 1 dsjw 1
> 	  xilinx_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
> 	  clock 79999999=20
> 	  re-started bus-errors arbit-lost error-warn error-pass bus-off
> 	  0          0          0          0          0          0         numtx=
queues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535=20
>     RX: bytes  packets  errors  dropped overrun mcast  =20
>     0          0        0       0       0       0      =20
>     TX: bytes  packets  errors  dropped carrier collsns=20
>     0          0        0       0       0       0      =20
> root@xilinx-vck190-2021_1:~#=20
>=20
> Parameters
> BPRA -20, TS1 =3D 2, TS2 =3D1,sjw =3D1,
> BPRD - 5 , TS1 =3D 2, Ts2 =3D 1,sjw =3D1,
> Clock ~80Mhz(79999999)
>=20
> Hand configuration:
> --------------------------
> ip link set can0 type can tq 12 prop-seg 29 phase-seg1 30 phase-seg2 20 s=
jw 1 dtq 12 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 1 fd on (A/D: 1/4M=
bps, Sample point=3D75%)
> Reference:
> https://www.kvaser.com/support/calculators/can-fd-bit-timing-calculator/
>=20
> is there any plan to implement newsletter recommendations in frame work ?
> https://can-newsletter.org/uploads/media/raw/f6a36d1461371a2f86ef0011a

Thanks those parameters. I think I have everything I need and I'll try
to reproduce the problem here.

I want to add the clock rate to the can-bit-timing user space tool.
Which SoC uses this 79999999 Hz Clock?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2qyxlat5qubuo64a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIT9bkACgkQrX5LkNig
010/eQf/Qkm8pSB0SzPZ8qC9Wu9bA0f0x86xf9QW77sdCEIBsRifWRDi77/0XUbe
/Qjt/iZzoV6w8GEH7Tqt3fnho5PzC4CrnPfoN2VPZqY9zOBnEshJ/JuzypH+6FOC
LMydZsNnJw8l+Ys7ywuMPreOEwAQ4rFik8fzOQh6iGsRERl0bAid6oRXZqVGdKT8
6Dk/yAhZIrh13E0D+WWUOZY7VTYp1eBsvcCSshpa2mM+8Ieecp8EaqxyPq0tT1Xl
2AR5KU4kGwLwBCpAt5crxrXF+zLY7uXsEfC4fIinLwsOMwyx4ewE8GdlkhODUpYC
CogtqnnKMn9cGA6rnwCDkl6OdlF1Uw==
=aW1Y
-----END PGP SIGNATURE-----

--2qyxlat5qubuo64a--
