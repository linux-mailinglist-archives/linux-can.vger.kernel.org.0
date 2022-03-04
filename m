Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E574CCEFB
	for <lists+linux-can@lfdr.de>; Fri,  4 Mar 2022 08:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiCDHZi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Mar 2022 02:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbiCDHZi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 4 Mar 2022 02:25:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915B5190C05
        for <linux-can@vger.kernel.org>; Thu,  3 Mar 2022 23:24:49 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nQ2Iv-0003r8-Eg; Fri, 04 Mar 2022 08:24:45 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-ddb4-5d2e-0837-03c2.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:ddb4:5d2e:837:3c2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F3594426A3;
        Fri,  4 Mar 2022 07:24:41 +0000 (UTC)
Date:   Fri, 4 Mar 2022 08:24:40 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kris Bahnsen <kris@embeddedTS.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, wg@grandegger.com,
        linux-gpio@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH] drivers: Fix Links to Technologic Systems web resources
Message-ID: <20220304072440.u4gp4zxfvbza6uvx@pengutronix.de>
References: <20220303225525.29846-1-kris@embeddedTS.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f3xuuvhmrvxwz2x5"
Content-Disposition: inline
In-Reply-To: <20220303225525.29846-1-kris@embeddedTS.com>
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


--f3xuuvhmrvxwz2x5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.03.2022 14:55:25, Kris Bahnsen wrote:
> Technologic Systems has rebranded as embeddedTS with the current
> domain eventually going offline. Update web/doc URLs to correct
> resource locations.
>=20
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
>  drivers/net/can/sja1000/Kconfig  | 2 +-
>  drivers/net/can/sja1000/tscan1.c | 4 ++--

For the CAN part:

Acked-by: Marc Kleine-Budde

regards,
Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--f3xuuvhmrvxwz2x5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIhvrUACgkQrX5LkNig
011UTwf/RCDQPYpiW1gusjlu6S93UPtYTCUpTyJJtkpgWORHtYrRsBAtztRYWQeF
U2qBcbDoP+ANL6xPlWabCtTKLx63mU9zFbIAGMSDcd0ZCKb+V3H4smFDn8AwfPhp
EVr242tpzlUJ1eXdn2Rvns1j3LlSLEJM/75WfqjAuKLiCvta2LCIiU2zsuU5mU3o
JdINnJ3aHAtW/1KAx29OObpTDIykSF0Uk2aGAK5wtCzmuqX9p9xLSranDL6DIpUt
+D6Oyo+v+Cglv/ivoAbXbZ1n2b84QAJnexx8xPsw3D5pbva3FrBDUwuio/cT8Md8
Sx2zDE7ElkG/oZIWB8+Bog/3XGiRBQ==
=g8Dm
-----END PGP SIGNATURE-----

--f3xuuvhmrvxwz2x5--
