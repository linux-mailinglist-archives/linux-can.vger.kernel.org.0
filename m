Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54085ADA01
	for <lists+linux-can@lfdr.de>; Mon,  5 Sep 2022 22:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiIEUB7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Sep 2022 16:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiIEUB5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2022 16:01:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67915D121
        for <linux-can@vger.kernel.org>; Mon,  5 Sep 2022 13:01:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVIHx-0004BQ-H7; Mon, 05 Sep 2022 22:01:45 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:87c3:3596:1bd0:fbb4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EC29ADB0CA;
        Mon,  5 Sep 2022 20:01:42 +0000 (UTC)
Date:   Mon, 5 Sep 2022 22:01:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Add RZ/N1 CAN support
Message-ID: <20220905200142.vfp5yju72pvs6kov@pengutronix.de>
References: <20220830164518.1381632-1-biju.das.jz@bp.renesas.com>
 <20220905160758.ieo673gvaejjjfuk@pengutronix.de>
 <OS0PR01MB59227189DB7DC3721B097B9F867F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwqtu6uz72iunors"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59227189DB7DC3721B097B9F867F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--pwqtu6uz72iunors
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.09.2022 16:13:09, Biju Das wrote:
> Hi Marc,
>=20
> > Subject: Re: [PATCH v3 0/3] Add RZ/N1 CAN support
> >=20
> > On 30.08.2022 17:45:15, Biju Das wrote:
> > > This patch series supports CAN{0,1} populated on RZ/N1D-DB board.
> > >
> > > v2->v3:
> > >  * Documented power-domains support.
> > >  * Dropped clock-names property from CAN nodes.
> > >  * Added power-domains property to the CAN nodes.
> > > v1->v2:
> > >  * Added RZ/N1 specific compatible string.
> > >  * Added clock-names property.
> > >
> > > This patch series depend upon [1]
> > > [1] https://lore.kernel.org/linux-renesas-
> > soc/20220819084532.ywtziogd7ycuozxx@pengutronix.de/
> > >
> > > Biju Das (3):
> > >   dt-bindings: can: nxp,sja1000: Document RZ/N1 power-domains support
> > >   ARM: dts: r9a06g032: Add CAN{0,1} nodes
> > >   ARM: dts: r9a06g032-rzn1d400-db: Enable CAN{0,1}
> >=20
> > Who will take this series (once it's ready)?
>=20
> I guess, normally bindings by respective maintainer(ie, by you) and=20
> Renesas SoC/board dtsi/dts by Geert. Already SoC dtsi is
> queued for 6.1[1]. So I guess binding can be applied to respective subsys=
tem
> tree.
>=20
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220830=
164518.1381632-3-biju.das.jz@bp.renesas.com/

Ok, applied 1/3 to linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pwqtu6uz72iunors
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMWVaMACgkQrX5LkNig
013ipgf9Ehfap5fs/HIohlnXELYxfAkqB5tNsP6c32IcYp28hfFiFnfccavYgUf8
RJTHPzFflwsq3qvjID3uc9lNoUGCvtO7ahdysxbCFoj/IxXmOMQw0kGxM7rAwLHV
F7id2G2DcdUoed2fp3dYrRfPt54pJvVvMTrSJCskeYOb+nsyyGm+QWPBUAjBKJwe
a11Decw38T3JtIRr0R2XfUNQ2ZONXUfUoYNiOPTZ+2t3rH/kqgXvzYh2d8qyMdsO
P8AYLABd+pT8zzLglkw4UU+n7ZXRnROR79g4HpRpmy3gDBxNY0XYdDFZq+a5IgdB
JbHfldu2hHIK/Tlb73ij17+hj9Q2lg==
=9X2h
-----END PGP SIGNATURE-----

--pwqtu6uz72iunors--
