Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8164DD6ED
	for <lists+linux-can@lfdr.de>; Fri, 18 Mar 2022 10:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiCRJQk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Mar 2022 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiCRJQk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Mar 2022 05:16:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BAD220B06
        for <linux-can@vger.kernel.org>; Fri, 18 Mar 2022 02:15:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nV8hc-000895-JM; Fri, 18 Mar 2022 10:15:20 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1ddb-5eff-56d9-d971.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1ddb:5eff:56d9:d971])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 924C94DBB8;
        Fri, 18 Mar 2022 09:15:18 +0000 (UTC)
Date:   Fri, 18 Mar 2022 10:15:18 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: Queries on CAN frame work
Message-ID: <20220318091518.sxumfvkbj4c224im@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220317225058.3gdvlqnwu5arzbfj@pengutronix.de>
 <DM6PR02MB538652DBE943788F4686531BAF139@DM6PR02MB5386.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g373f57aqny2bntn"
Content-Disposition: inline
In-Reply-To: <DM6PR02MB538652DBE943788F4686531BAF139@DM6PR02MB5386.namprd02.prod.outlook.com>
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


--g373f57aqny2bntn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.03.2022 06:55:56, Srinivas Neeli wrote:
> > I've updated the algorithm to prefer lower brp values. Can you check
> > if these values make sense to you?
>=20
> Thanks for update.
> Few more changes need to update in algorithm.
> 1) Choose SJW as large as possible (we can assign " tseg2")

ACK - changes to SJW needs still to be done.

>  For CANFD CIA recommendations :
>  Recommendation 1:=20
>     Choose the highest available CAN clock frequency (20 MHz, 40 MHz, 80 =
MHz)=20
> Recommendation 2:
>     Set the BRPA bit-rate pre-scaler equal BRPD
> Recommendation 3:
>     Choose BRPA and BRPD as low as possible.
> Recommendation 4:=20
>     Configure all CAN FD nodes to have the same arbitration phase Sample =
point (SP) and the same data phase SP
> Recommendation 5:=20
>     Choose SJWD and SJWA as large as possible (best is the max possible v=
alue)
> Recommendation 6:=20
>     Enable TDC when needed=20
>      If we enable TDC feature ,please try to configure brp value 1 in alg=
orithm(TDC feature support brp 1/2 but observed good results with 1).
> >=20
> > | $ ./can-calc-bit-timing --alg=3Dcan-next xilinx_dwnstrm -c 79999999 B=
it
> > | timing parameters for xilinx_dwnstrm with 79.999999 MHz ref clock (cm=
d-
> > line) using algo 'can-next'
> > |  nominal                                  real  Bitrt    nom   real  =
SampP
> > |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP  =
Error
> > |  1000000     12  29   30   20   1   1   999999   0.0%  75.0%  75.0%  =
 0.0%
>=20
> Observed different BRP values for 1Mbps in here and below list for
> same sampling point.

Yes. Seems I should update the table to clarify what they output.

The 1st table uses the CAN-2.0 bit timing constants, the 2nd table is
using the CAN-FD data bit timing constants.

> > |   800000     12  39   40   20   1   1   799999   0.0%  80.0%  80.0%  =
 0.0%
> > |   666666     12  47   48   24   1   1   666666   0.0%  80.0%  80.0%  =
 0.0%
> > |   500000     12  69   70   20   1   1   499999   0.0%  87.5%  87.5%  =
 0.0%
> > |   250000     25  69   70   20   1   2   249999   0.0%  87.5%  87.5%  =
 0.0%
> > |   125000     50  69   70   20   1   4   124999   0.0%  87.5%  87.5%  =
 0.0%
> > |   100000     50  87   87   25   1   4    99999   0.0%  87.5%  87.5%  =
 0.0%
> > |    83333     50 104  105   30   1   4    83333   0.0%  87.5%  87.5%  =
 0.0%
> > |    50000    100  87   87   25   1   8    49999   0.0%  87.5%  87.5%  =
 0.0%
> > |    33333    125 104  105   30   1  10    33333   0.0%  87.5%  87.5%  =
 0.0%
> > |    20000    250  87   87   25   1  20    19999   0.0%  87.5%  87.5%  =
 0.0%
> > |    10000    500  87   87   25   1  40     9999   0.0%  87.5%  87.5%  =
 0.0%
> > |
> > | Bit timing parameters for xilinx_dwnstrm with 79.999999 MHz ref clock
> > (cmd-line) using algo 'can-next'
> > |  nominal                                  real  Bitrt    nom   real  =
SampP
> > |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP  =
Error
> > | 12000000     12   2    2    2   1   1 11428571   4.8%  75.0%  71.4%  =
 4.8%
> > | 10000000     12   2    3    2   1   1  9999999   0.0%  75.0%  75.0%  =
 0.0%
> > |  8000000     12   3    3    3   1   1  7999999   0.0%  75.0%  70.0%  =
 6.7%
> > |  5000000     12   5    6    4   1   1  4999999   0.0%  75.0%  75.0%  =
 0.0%
> > |  4000000     12   7    7    5   1   1  3999999   0.0%  75.0%  75.0%  =
 0.0%
> > |  2000000     12  14   15   10   1   1  1999999   0.0%  75.0%  75.0%  =
 0.0%
> > |  1000000     25  14   15   10   1   2   999999   0.0%  75.0%  75.0%  =
 0.0%
>=20
> Here brp =3D2 and in above list brp =3D1.

According to the "ip" command's output, these are you timing parameters:

| 		.bittiming_const =3D {
| 			.name =3D "xilinx_dwnstrm",
| 			.tseg1_min =3D 1,
| 			.tseg1_max =3D 256,
| 			.tseg2_min =3D 1,
| 			.tseg2_max =3D 128,
| 			.sjw_max =3D 128,
| 			.brp_min =3D 1,
| 			.brp_max =3D 256,
| 			.brp_inc =3D 1,
| 		},
| 		.data_bittiming_const =3D {
| 			.name =3D "xilinx_dwnstrm",
| 			.tseg1_min =3D 1,
| 			.tseg1_max =3D 32,
| 			.tseg2_min =3D 1,
| 			.tseg2_max =3D 16,
| 			.sjw_max =3D 16,
| 			.brp_min =3D 1,
| 			.brp_max =3D 256,
| 			.brp_inc =3D 1,
| 		},

Note that for the data bit timing the tseg1_max is 32.

> > |  nominal                                  real  Bitrt    nom   real  =
SampP
> > |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP  =
Error
> > |  1000000     12  29   30   20   1   1   999999   0.0%  75.0%  75.0%  =
 0.0%        <-- CAN-2.0
> > |  1000000     25  14   15   10   1   2   999999   0.0%  75.0%  75.0%  =
 0.0%        <-- CAN-FD (data)
                       \_____/
                        tseg1

tseg1 =3D 14 + 15 =3D 29

With brp =3D=3D 1 the tseg1 would be 29 + 30 =3D 59, which means it's too
large.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--g373f57aqny2bntn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmI0TaIACgkQrX5LkNig
011FKgf9GIc7XSq8ettpH87zo2sdFn046hqJrlMUOyvqZFRRpRQHKHG9DTGBQdcq
kTjrs2A31O3qiaKB0Qq9MHdWCYEQ7SFw5dG8ws2c1fWBAIxZng4xhp5prxVicr9O
SZw3B7rzmRUDwP8gTo3AB1FJw6gPKRGpvSUqB6KvbH+3W0Qv6703dL38s81Q0iIX
nxFrSJRvbwPwQ5b1h/Rks3vI5M6q8z0ZliptdGbp8QSPUYq0gIu8mZ/D5jqiWyib
2CfOF2HL19YfhAO0lPTXG0wTJiNdUKggwBaz8J+jjEY/iJXI/kXfSuGEMiaD0R/O
q0l5uEqTo51kuFgQRvFTB8nXHioGkw==
=Peg/
-----END PGP SIGNATURE-----

--g373f57aqny2bntn--
