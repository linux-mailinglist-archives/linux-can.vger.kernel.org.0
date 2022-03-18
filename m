Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277B84DD636
	for <lists+linux-can@lfdr.de>; Fri, 18 Mar 2022 09:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiCRIcQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Mar 2022 04:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiCRIcP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Mar 2022 04:32:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD4D27CE0C
        for <linux-can@vger.kernel.org>; Fri, 18 Mar 2022 01:30:57 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nV80e-0002cf-3N; Fri, 18 Mar 2022 09:30:56 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1ddb-5eff-56d9-d971.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1ddb:5eff:56d9:d971])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9E0824DB40;
        Fri, 18 Mar 2022 08:30:54 +0000 (UTC)
Date:   Fri, 18 Mar 2022 09:30:54 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: Queries on CAN frame work
Message-ID: <20220318083054.iukyynbnrnrvtrqd@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220317220033.pxfioxhgxmm55b3f@pengutronix.de>
 <DM6PR02MB53866545ABAF3FBC596D43A6AF139@DM6PR02MB5386.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sitcy7ydp5nywgzf"
Content-Disposition: inline
In-Reply-To: <DM6PR02MB53866545ABAF3FBC596D43A6AF139@DM6PR02MB5386.namprd02.prod.outlook.com>
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


--sitcy7ydp5nywgzf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.03.2022 06:12:30, Srinivas Neeli wrote:
> > Are you using the mainline xilinx_can driver? The "ip" command says, yo=
u're
> > using:
>=20
> Yes , mainline and internal drivers are same.

No, you are not. As explained in my last mail, there's no struct
can_bittiming_const in the mainline driver that matches your "ip"
output.

> Xilinx maintains common driver for multiple CAN and CANFD  IP's.
> Xilinx supports below CAN IP's:
> xlnx,zynq-can-1.0 (zynq platform & zynqmp platform)
> xlnx,axi-can-1.00.a ( Soft IP version 1.00)
> xlnx,canfd-1.0 (Soft canfd ip version 1.0)
> xlnx,canfd-2.0(Soft canfd ip Version 2.0)
> xlnx,canfd2.0 equal to versal canfd ip, so using same compatible string f=
or both.
>=20
> For each ip sjw_max and brp values are different.
> Due to this reason created multiple bit timing structures.

ACK. But your driver is obviously different to the mainline driver (see
above).

> > >  sjw 1..128  brp 1..256
> > > dsjw 1..16  dbrp 1..256
> >=20
> > Looking at the mainline xilinx driver, we have:
> >=20
> > | /* CAN Bittiming constants as per Xilinx CAN specs */ static const
> > | struct can_bittiming_const xcan_bittiming_const =3D {
> > | 	.name =3D DRIVER_NAME,
> > | 	.tseg1_min =3D 1,
> > | 	.tseg1_max =3D 16,
> > | 	.tseg2_min =3D 1,
> > | 	.tseg2_max =3D 8,
> > | 	.sjw_max =3D 4,
> >                    ^
> > Does not match due to "sjw 1..128".
> >=20
> > | 	.brp_min =3D 1,
> > | 	.brp_max =3D 256,
> > | 	.brp_inc =3D 1,
> > | };
> > |
> > | /* AXI CANFD Arbitration Bittiming constants as per AXI CANFD 1.0 spec
> > | */ static const struct can_bittiming_const xcan_bittiming_const_canfd=
 =3D {
> > | 	.name =3D DRIVER_NAME,
> > | 	.tseg1_min =3D 1,
> > | 	.tseg1_max =3D 64,
> > | 	.tseg2_min =3D 1,
> > | 	.tseg2_max =3D 16,
> > | 	.sjw_max =3D 16,
> >                    ^^
> > Does not match due to "sjw 1..128".
> >=20
> > | 	.brp_min =3D 1,
> > | 	.brp_max =3D 256,
> > | 	.brp_inc =3D 1,
> > | };
> > |
> > | /* AXI CANFD Data Bittiming constants as per AXI CANFD 1.0 specs */
> > | static struct can_bittiming_const xcan_data_bittiming_const_canfd =3D=
 {
> > | 	.name =3D DRIVER_NAME,
> > | 	.tseg1_min =3D 1,
> > | 	.tseg1_max =3D 16,
> > | 	.tseg2_min =3D 1,
> > | 	.tseg2_max =3D 8,
> > | 	.sjw_max =3D 8,
> >                    ^
> > Does not match due to "dsjw 1..16"
> >=20
> > | 	.brp_min =3D 1,
> > | 	.brp_max =3D 256,
> > | 	.brp_inc =3D 1,
> > | };
> > |
> > | /* AXI CANFD 2.0 Arbitration Bittiming constants as per AXI CANFD 2.0
> > | spec */ static const struct can_bittiming_const
> > xcan_bittiming_const_canfd2 =3D {
> > | 	.name =3D DRIVER_NAME,
> > | 	.tseg1_min =3D 1,
> > | 	.tseg1_max =3D 256,
> > | 	.tseg2_min =3D 1,
> > | 	.tseg2_max =3D 128,
> > | 	.sjw_max =3D 128,
> > | 	.brp_min =3D 2,
> >                    ^
> > Does not match due to "brp 1..256".
> >=20
> > | 	.brp_max =3D 256,
> > | 	.brp_inc =3D 1,
> > | };
> > |
> > | /* AXI CANFD 2.0 Data Bittiming constants as per AXI CANFD 2.0 spec */
> > | static struct can_bittiming_const xcan_data_bittiming_const_canfd2 =
=3D {
> > | 	.name =3D DRIVER_NAME,
> > | 	.tseg1_min =3D 1,
> > | 	.tseg1_max =3D 32,
> > | 	.tseg2_min =3D 1,
> > | 	.tseg2_max =3D 16,
> > | 	.sjw_max =3D 16,
> > | 	.brp_min =3D 2,
> >                    ^
> > Does not match due to "dbrp 1..256".
>=20
> Versal early silicon we observed bit enlarging issue with brp  =3D1 in
> side IP using simulaitons(Not observed on software side) , but it
> fixed in production silicon.
>=20
> Plan to revert this patch to support TDC feature(To support higher
> baud rates we need brp =3D1).

Ok.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--sitcy7ydp5nywgzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmI0QzoACgkQrX5LkNig
013Rhwf+OJ8Pw1x8X8OirRu1HtqmwWLzYXYmfjvIX+Y+41Z0WpFt9fDAWZdGKl71
0CBksgR4KrKOm1unxVV4G83F3rQvxp7RvVDYipSEelh7Vn1GnYAk1ZXS4U8IZSXT
inQk/CQlFJasL3LXOsZsZQBNseimMXMO65z3+kia63Gi1x0oBkZdRrDacnrokUAu
M90iCdiSa/PYskEhdANtBR9La7l8U3wr3nGTZbd3KRYABsjRkSVViTSQzaScLP7a
LRUErDQhfCKn0h7sEFiUn7aoEDjZyw0xPtSdVVmXT6p14dvOhGB4GpPl2r5lpRQ4
RHYq6VHFl6hhwVxRtBjdlw1yxv/gzQ==
=O+F4
-----END PGP SIGNATURE-----

--sitcy7ydp5nywgzf--
