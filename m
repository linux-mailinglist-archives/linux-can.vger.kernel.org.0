Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BE35BFC9C
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIUKx4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIUKxz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 06:53:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112077CAA0
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 03:53:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oaxMW-0004pa-MF; Wed, 21 Sep 2022 12:53:52 +0200
Received: from pengutronix.de (hardanger-2.fritz.box [IPv6:2a03:f580:87bc:d400:f566:9915:77e6:ceb3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B378FE87F4;
        Wed, 21 Sep 2022 10:53:51 +0000 (UTC)
Date:   Wed, 21 Sep 2022 12:53:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     dariobin@libero.it, Jacob Kroon <jacob.kroon@gmail.com>,
        linux-can@vger.kernel.org, wg@grandegger.com
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Message-ID: <20220921105351.peoyk2a64ayd27gj@pengutronix.de>
References: <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
 <541998938.482927.1663745141832@mail1.libero.it>
 <20220921074741.admuodnlv4yexfwr@pengutronix.de>
 <fb1f38e6-c95c-5847-2ebf-16fd8bc2db94@hartkopp.net>
 <20220921103259.5x5zf5fwxqnm56nd@pengutronix.de>
 <f44c183a-f5f4-abe8-2dd9-47f6abb223e2@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncd3xnkcbq2ebtbd"
Content-Disposition: inline
In-Reply-To: <f44c183a-f5f4-abe8-2dd9-47f6abb223e2@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ncd3xnkcbq2ebtbd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.09.2022 12:39:06, Oliver Hartkopp wrote:
>=20
>=20
> On 21.09.22 12:32, Marc Kleine-Budde wrote:
> > On 21.09.2022 11:55:59, Oliver Hartkopp wrote:
> > > Btw. I uploaded the 'latest' C_CAN manuals on
> > >=20
> > > https://github.com/linux-can/can-doc
> > >=20
> > > ... as it could only be found on archive.org :-/
> > >=20
> > > Unfortunately I was not able to find any (latest?) D_CAN manual anymo=
re,
> > > which was originally hosted at http://www.semiconductors.bosch.de/med=
ia/en/pdf/ipmodules_1/can/d_can_users_manual_111.pdf
> > >=20
> > > Archive.org did not crawl this PDF ;-(
> > >=20
> > > If someone still has this D_CAN PDF please send a URL or the PDF itse=
lf to
> > > me, so that I can put it there too.
> >=20
> > I've found some old stuff on https://www.yumpu.com/user/bosch.semicondu=
ctors.de
> >=20
> > You've got PR:
> > https://github.com/linux-can/can-doc/pull/1
>=20
> Pulled.
>=20
> Excellent contribution! Thanks Marc!

Doh! I accidentally committed the readme of your M_CAN history repo.
I'll force push the master to get rid of it. OK?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ncd3xnkcbq2ebtbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMq7TwACgkQrX5LkNig
011HgQf6AojGrIEF/DPyeHofkWoKjpbio0CYiwLhIld6rHvS90xkYJ8mqyQLh/Os
w6YIeRDtGV5YY8E8A1KM/xC/amTgV1P5xe80E7Bek/48U3+rk3sZff+ANPrYVSrJ
oreroQNA8Aaw/ehqhdRK463T4zXNB1lD7Ax6bdT4p9zUt7Eqxs/MMYmgG75b1SPN
IPNu/cBvkubqCsjcceBgoHOYDb5pJPvMVG5+TE/WjYI3Uc8/iWbSxiqboZrtdrzY
gNXxEQyNVyR9FwUBiP4fW0I0ymgrRy5U/nMH0O/8OftYF2iCtPA9XBX76KM0lJCJ
eHFa8KmNwoZrzAMYo8QHFZ1kw5ZH3Q==
=tC8H
-----END PGP SIGNATURE-----

--ncd3xnkcbq2ebtbd--
