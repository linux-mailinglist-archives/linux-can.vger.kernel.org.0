Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD4A4DD962
	for <lists+linux-can@lfdr.de>; Fri, 18 Mar 2022 13:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiCRMGk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Mar 2022 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiCRMGj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Mar 2022 08:06:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95C62E0446
        for <linux-can@vger.kernel.org>; Fri, 18 Mar 2022 05:05:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nVBM6-0003bJ-Li; Fri, 18 Mar 2022 13:05:18 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-1ddb-5eff-56d9-d971.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1ddb:5eff:56d9:d971])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 362D94E9A9;
        Fri, 18 Mar 2022 12:03:52 +0000 (UTC)
Date:   Fri, 18 Mar 2022 13:03:51 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: Re: Queries on CAN frame work
Message-ID: <20220318120351.turz3egduwbrzj2l@pengutronix.de>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220317225058.3gdvlqnwu5arzbfj@pengutronix.de>
 <DM6PR02MB538652DBE943788F4686531BAF139@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220318091518.sxumfvkbj4c224im@pengutronix.de>
 <DM6PR02MB53869D6C6A11B9D76B35E646AF139@DM6PR02MB5386.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f4myqrq26ippokf6"
Content-Disposition: inline
In-Reply-To: <DM6PR02MB53869D6C6A11B9D76B35E646AF139@DM6PR02MB5386.namprd02.prod.outlook.com>
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


--f4myqrq26ippokf6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.03.2022 10:15:02, Srinivas Neeli wrote:
> > > Few more changes need to update in algorithm.
> > > 1) Choose SJW as large as possible (we can assign " tseg2")
> >=20
> > ACK - changes to SJW needs still to be done.
>=20
> Already we are assigning sjw =3D tseg2 in manual mode. Automatic we are a=
ssigning 1.
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev/bittim=
ing.c#L158

You can set sjw and dsjw even if using automatic bit rate calculation:

| ip link set peakfd0 type can bitrate 1000000 sjw 2 dbitrate 5000000 dsjw =
2 fd on

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--f4myqrq26ippokf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmI0dSUACgkQrX5LkNig
013PEAgAnmMjoJm6I5cF+ZyYbWidq/9iMqYM5EwgoVD7ljiKQYI3NDtNRjRdb3f4
w7soUnXIXKh3f68okrU/RZyEfFoXyQ3WYARhu9X8IBrw5uuoRwJQon7dmn1Wde7t
GOuDuOzwudCAiSbWTRNGg8smD0kLRsvjg4xRQB6zztawpjI44sLi1bSKsKez4teH
RuaW/Mmbwaw2DqUCSXDZjK8wfwAnh6F5HOdWOST98eGvtoNc/q8Rnh6s+jh0KklL
VBaGqqaCKHQWJf2th5+onSpTAMIZiS4fbavNlydWXbYDuYlz3gJbml5/I5QbbzRC
HlB/m9VZ5exNcr8WQeYV8pb632h7uw==
=VqmZ
-----END PGP SIGNATURE-----

--f4myqrq26ippokf6--
