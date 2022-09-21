Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D605BFC60
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIUKdG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 06:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiIUKdF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 06:33:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D4E90C68
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 03:33:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oax2K-0002T0-QL; Wed, 21 Sep 2022 12:33:00 +0200
Received: from pengutronix.de (hardanger-2.fritz.box [IPv6:2a03:f580:87bc:d400:f566:9915:77e6:ceb3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 91AFFE87B7;
        Wed, 21 Sep 2022 10:32:59 +0000 (UTC)
Date:   Wed, 21 Sep 2022 12:32:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     dariobin@libero.it, Jacob Kroon <jacob.kroon@gmail.com>,
        linux-can@vger.kernel.org, wg@grandegger.com
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Message-ID: <20220921103259.5x5zf5fwxqnm56nd@pengutronix.de>
References: <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
 <541998938.482927.1663745141832@mail1.libero.it>
 <20220921074741.admuodnlv4yexfwr@pengutronix.de>
 <fb1f38e6-c95c-5847-2ebf-16fd8bc2db94@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i3tukmlwel7qixl2"
Content-Disposition: inline
In-Reply-To: <fb1f38e6-c95c-5847-2ebf-16fd8bc2db94@hartkopp.net>
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


--i3tukmlwel7qixl2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.09.2022 11:55:59, Oliver Hartkopp wrote:
> Btw. I uploaded the 'latest' C_CAN manuals on
>=20
> https://github.com/linux-can/can-doc
>=20
> ... as it could only be found on archive.org :-/
>=20
> Unfortunately I was not able to find any (latest?) D_CAN manual anymore,
> which was originally hosted at http://www.semiconductors.bosch.de/media/e=
n/pdf/ipmodules_1/can/d_can_users_manual_111.pdf
>=20
> Archive.org did not crawl this PDF ;-(
>=20
> If someone still has this D_CAN PDF please send a URL or the PDF itself to
> me, so that I can put it there too.

I've found some old stuff on https://www.yumpu.com/user/bosch.semiconductor=
s.de

You've got PR:
https://github.com/linux-can/can-doc/pull/1

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--i3tukmlwel7qixl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMq6FgACgkQrX5LkNig
012qzggAmq1jjQ+OuiPUkHZ9zrSP7oSQnBnQNB10dblhAF/jafsg178cFBuOez1N
FcKS6awkhmd5xdY4Ijk7fPBmlUgA18BGyeg7j2QbrU/uZtas0WhtOgW4PJrOWiwY
PQcvqCIu4T/w1JnjCjq0hHl4Le4L+wwWspHWew/bLBKZEHBnHdtL7ulEjQVrpGMO
6aRKaIbVQR3KHqfu3ROYbGW4OnzF3ZFCKHoQ20k8pFUEcEAj7DgMbVxDtuV3Wy8d
Y40tfkpkwEi4E82N0ANYDUiwp+6O/6KV2TcabLV139hWwWnuuoTQG7+MPdmmVT83
ZB69+9bsFHxCBMKkrmWayUcBfy9h7Q==
=2cJl
-----END PGP SIGNATURE-----

--i3tukmlwel7qixl2--
