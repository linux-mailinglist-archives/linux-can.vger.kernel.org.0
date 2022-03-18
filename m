Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B924DDB14
	for <lists+linux-can@lfdr.de>; Fri, 18 Mar 2022 14:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbiCRN7T (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Mar 2022 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiCRN7S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Mar 2022 09:59:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2538EE028
        for <linux-can@vger.kernel.org>; Fri, 18 Mar 2022 06:57:58 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nVD77-0008BT-Ad; Fri, 18 Mar 2022 14:57:57 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1ddb-5eff-56d9-d971.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1ddb:5eff:56d9:d971])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 043D34EA7D;
        Fri, 18 Mar 2022 13:57:55 +0000 (UTC)
Date:   Fri, 18 Mar 2022 14:57:55 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: Queries on CAN frame work
Message-ID: <20220318135755.2g7262fvco5f6uf5@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220317225058.3gdvlqnwu5arzbfj@pengutronix.de>
 <DM6PR02MB538652DBE943788F4686531BAF139@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220318091518.sxumfvkbj4c224im@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o2zw3prq6r55lixq"
Content-Disposition: inline
In-Reply-To: <20220318091518.sxumfvkbj4c224im@pengutronix.de>
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


--o2zw3prq6r55lixq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.03.2022 10:15:18, Marc Kleine-Budde wrote:
> > > | $ ./can-calc-bit-timing --alg=3Dcan-next xilinx_dwnstrm -c 79999999=
 Bit
> > > | timing parameters for xilinx_dwnstrm with 79.999999 MHz ref clock (=
cmd-
> > > line) using algo 'can-next'
> > > |  nominal                                  real  Bitrt    nom   real=
  SampP
> > > |  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP=
  Error
> > > |  1000000     12  29   30   20   1   1   999999   0.0%  75.0%  75.0%=
   0.0%
> >=20
> > Observed different BRP values for 1Mbps in here and below list for
> > same sampling point.
>=20
> Yes. Seems I should update the table to clarify what they output.

Here's the updated output. It says now "Data" Bit timing parameters in
the 2nd table.

| Bit timing parameters for xilinx_can_fd2i with 79.999999 MHz ref clock (c=
md-line) using algo 'can-next'
|  nominal                                  real  Bitrt    nom   real  SampP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP  Erro=
r  =20
|  1000000     12  29   30   20   1   1   999999   0.0%  75.0%  75.0%   0.0=
%  =20
|   800000     12  39   40   20   1   1   799999   0.0%  80.0%  80.0%   0.0=
%  =20
|   666666     12  47   48   24   1   1   666666   0.0%  80.0%  80.0%   0.0=
%  =20
|   500000     12  69   70   20   1   1   499999   0.0%  87.5%  87.5%   0.0=
%  =20
|   250000     25  69   70   20   1   2   249999   0.0%  87.5%  87.5%   0.0=
%  =20
|   125000     50  69   70   20   1   4   124999   0.0%  87.5%  87.5%   0.0=
%  =20
|   100000     50  87   87   25   1   4    99999   0.0%  87.5%  87.5%   0.0=
%  =20
|    83333     50 104  105   30   1   4    83333   0.0%  87.5%  87.5%   0.0=
%  =20
|    50000    100  87   87   25   1   8    49999   0.0%  87.5%  87.5%   0.0=
%  =20
|    33333    125 104  105   30   1  10    33333   0.0%  87.5%  87.5%   0.0=
%  =20
|    20000    250  87   87   25   1  20    19999   0.0%  87.5%  87.5%   0.0=
%  =20
|    10000    500  87   87   25   1  40     9999   0.0%  87.5%  87.5%   0.0=
%  =20
|=20
| Data Bit timing parameters for xilinx_can_fd2i with 79.999999 MHz ref clo=
ck (cmd-line) using algo 'can-next'
|  nominal                                  real  Bitrt    nom   real  SampP
|  Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP  Bitrate  Error  SampP  SampP  Erro=
r  =20
| 12000000     12   2    2    2   1   1 11428571   4.8%  75.0%  71.4%   4.8=
%  =20
| 10000000     12   2    3    2   1   1  9999999   0.0%  75.0%  75.0%   0.0=
%  =20
|  8000000     12   3    3    3   1   1  7999999   0.0%  75.0%  70.0%   6.7=
%  =20
|  5000000     12   5    6    4   1   1  4999999   0.0%  75.0%  75.0%   0.0=
%  =20
|  4000000     12   7    7    5   1   1  3999999   0.0%  75.0%  75.0%   0.0=
%  =20
|  2000000     12  14   15   10   1   1  1999999   0.0%  75.0%  75.0%   0.0=
%  =20
|  1000000     25  14   15   10   1   2   999999   0.0%  75.0%  75.0%   0.0=
%  =20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--o2zw3prq6r55lixq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmI0j+AACgkQrX5LkNig
012m1QgAnw37L5MymW14ox08xvXClOimDeMgTxh9HS/gwFohWunwRR3+H+ScEZ/o
nFQ742bwH1lslmxu54YieSG5YVOdCoVadsdw9PIKwl+AInhLqD2hIlMfw51XdbQm
N95L6fxHgdLouu5QHky1ceRWtlpJ7lDF0OUrclCQi8DCaCuNf21FJjqL4r2V6U4F
ZdEgiXEeyyH4mOL/IynYCKSI5+RI81E6UotHYa11L59vKn+yYVdBdlpKlET1ORhx
jM0JR9I4EQSjQnknGHKCXzsUjML/zS+lHRRWqRVwWANv9WyWH11g7/sQWwYCkX2D
EbNpCdsHsm0D5IZ97BeIXFNYHOCCpQ==
=W0kh
-----END PGP SIGNATURE-----

--o2zw3prq6r55lixq--
