Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D919C4DD075
	for <lists+linux-can@lfdr.de>; Thu, 17 Mar 2022 23:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiCQWB4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Mar 2022 18:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCQWBz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Mar 2022 18:01:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F1E0D9
        for <linux-can@vger.kernel.org>; Thu, 17 Mar 2022 15:00:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nUyAe-000891-HC; Thu, 17 Mar 2022 23:00:36 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-7d7c-4c6b-7e76-eef0.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:7d7c:4c6b:7e76:eef0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 808314D7A1;
        Thu, 17 Mar 2022 22:00:34 +0000 (UTC)
Date:   Thu, 17 Mar 2022 23:00:33 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: Queries on CAN frame work
Message-ID: <20220317220033.pxfioxhgxmm55b3f@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fyo4qtdbkvnlmr6s"
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


--fyo4qtdbkvnlmr6s
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
>     0          0        0       0       0       0

Are you using the mainline xilinx_can driver? The "ip" command says,
you're using:

>  sjw 1..128  brp 1..256
> dsjw 1..16  dbrp 1..256

Looking at the mainline xilinx driver, we have:

| /* CAN Bittiming constants as per Xilinx CAN specs */
| static const struct can_bittiming_const xcan_bittiming_const =3D {
| 	.name =3D DRIVER_NAME,
| 	.tseg1_min =3D 1,
| 	.tseg1_max =3D 16,
| 	.tseg2_min =3D 1,
| 	.tseg2_max =3D 8,
| 	.sjw_max =3D 4,
                   ^
Does not match due to "sjw 1..128".

| 	.brp_min =3D 1,
| 	.brp_max =3D 256,
| 	.brp_inc =3D 1,
| };
|=20
| /* AXI CANFD Arbitration Bittiming constants as per AXI CANFD 1.0 spec */
| static const struct can_bittiming_const xcan_bittiming_const_canfd =3D {
| 	.name =3D DRIVER_NAME,
| 	.tseg1_min =3D 1,
| 	.tseg1_max =3D 64,
| 	.tseg2_min =3D 1,
| 	.tseg2_max =3D 16,
| 	.sjw_max =3D 16,
                   ^^
Does not match due to "sjw 1..128".

| 	.brp_min =3D 1,
| 	.brp_max =3D 256,
| 	.brp_inc =3D 1,
| };
|=20
| /* AXI CANFD Data Bittiming constants as per AXI CANFD 1.0 specs */
| static struct can_bittiming_const xcan_data_bittiming_const_canfd =3D {
| 	.name =3D DRIVER_NAME,
| 	.tseg1_min =3D 1,
| 	.tseg1_max =3D 16,
| 	.tseg2_min =3D 1,
| 	.tseg2_max =3D 8,
| 	.sjw_max =3D 8,
                   ^
Does not match due to "dsjw 1..16"

| 	.brp_min =3D 1,
| 	.brp_max =3D 256,
| 	.brp_inc =3D 1,
| };
|=20
| /* AXI CANFD 2.0 Arbitration Bittiming constants as per AXI CANFD 2.0 spe=
c */
| static const struct can_bittiming_const xcan_bittiming_const_canfd2 =3D {
| 	.name =3D DRIVER_NAME,
| 	.tseg1_min =3D 1,
| 	.tseg1_max =3D 256,
| 	.tseg2_min =3D 1,
| 	.tseg2_max =3D 128,
| 	.sjw_max =3D 128,
| 	.brp_min =3D 2,
                   ^
Does not match due to "brp 1..256".

| 	.brp_max =3D 256,
| 	.brp_inc =3D 1,
| };
|=20
| /* AXI CANFD 2.0 Data Bittiming constants as per AXI CANFD 2.0 spec */
| static struct can_bittiming_const xcan_data_bittiming_const_canfd2 =3D {
| 	.name =3D DRIVER_NAME,
| 	.tseg1_min =3D 1,
| 	.tseg1_max =3D 32,
| 	.tseg2_min =3D 1,
| 	.tseg2_max =3D 16,
| 	.sjw_max =3D 16,
| 	.brp_min =3D 2,
                   ^
Does not match due to "dbrp 1..256".

| 	.brp_max =3D 256,
| 	.brp_inc =3D 1,
| };

Can you send patches to update the xilinx CAN driver?

I'm continue working on the CAN bittiming code.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--fyo4qtdbkvnlmr6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIzr30ACgkQrX5LkNig
012Gfwf/eRMdYb8UD1iqvbIYYPK3hZ6W2uclxwJbfyP4yCW6ongE3oF5GeDxVfX4
iAehce7CB42aWQcXpUIXOh45XhUy57UQALRD1amRFtGuzP1M3d4CVX3fh4Id2zp/
VGsydeMsj7pecxeecsM+sWgMSm1aCw8yAEWvl0Yvp36RrlujqdaKNPnZhMAMQU+F
WyyOUhfHz/9RTszDUPB+Yla70VOM7lbLugKaCEZo+rj5iWuak4FNzLm07ddaYTrz
I7xoVRDfYRHQ+sbbYsT05WdptZfQkBOG6YZ04QEa+pABx86V7KjwTPHkc4cRW2mu
lsEjOQst0rxcLhzHagMHzn5yf91ldg==
=j+Wp
-----END PGP SIGNATURE-----

--fyo4qtdbkvnlmr6s--
