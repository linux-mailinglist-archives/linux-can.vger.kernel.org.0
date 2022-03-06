Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D814CEBFD
	for <lists+linux-can@lfdr.de>; Sun,  6 Mar 2022 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiCFOsa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Mar 2022 09:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCFOsa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 6 Mar 2022 09:48:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D745E02E
        for <linux-can@vger.kernel.org>; Sun,  6 Mar 2022 06:47:36 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nQsAY-00013z-Cr; Sun, 06 Mar 2022 15:47:34 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-8f62-2f8a-935c-c311.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:8f62:2f8a:935c:c311])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9846E43862;
        Sun,  6 Mar 2022 14:47:32 +0000 (UTC)
Date:   Sun, 6 Mar 2022 15:47:32 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: Queries on CAN frame work
Message-ID: <20220306144732.xrc77kwcjhm63dg5@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220221202742.pamu76aloh2i5iw7@pengutronix.de>
 <DM6PR02MB53863A690DBA53A41B867084AF3B9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <DM6PR02MB538671F823B0E2F32E1FB521AF079@DM6PR02MB5386.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nyhiv6kh4nd6qznr"
Content-Disposition: inline
In-Reply-To: <DM6PR02MB538671F823B0E2F32E1FB521AF079@DM6PR02MB5386.namprd02.prod.outlook.com>
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


--nyhiv6kh4nd6qznr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.03.2022 14:30:43, Srinivas Neeli wrote:
> > Versal ACAP SOC we are observing 7999999Hz Clock.
> > https://www.xilinx.com/support/documentation/architecture-
> > manuals/am011-versal-acap-trm.pdf
>=20
> Did you get time to reproduce the issue?

Yes, reproduction is not that hard.

> Is there any changes planning in CAN frame work(based on CIA
> newsletter) ?.

Yes, but I can't give you a time frame for this, unfortunately.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--nyhiv6kh4nd6qznr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIkyYEACgkQrX5LkNig
01139Af9HLKsBx7EOJvCSKqdVSNiFI+geUrOG17EPGN8yoqprqaVinKUayb9ZruQ
yf7C8vOlDirbLixoy1GQ0IuNUF1cZU/AvUpeIVGSrXtO+P8Fm/89emO+k5yvr0nv
ZUdY0IUI8xO45G7+VoVXNlY1CqH25wCG4kczuhxxyBC7V9E1tuoTALNtxruFpWmv
9m25tfZcW1gROli0MmwDiMkJQKyeH3ongGFNJZgeF00uLu8HYkS72nkrVZqs8Lbd
SXTLWXf72ZxUy8ufk8+PNl4aD9B1r1+FzjGgOZnPs5DatSsyWhgh5TdcP9zqWfam
pi8rlK95kD0GoG5uHg0uu+w6zj3Jlw==
=9e3u
-----END PGP SIGNATURE-----

--nyhiv6kh4nd6qznr--
