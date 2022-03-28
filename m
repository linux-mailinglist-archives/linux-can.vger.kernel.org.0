Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA654E9E95
	for <lists+linux-can@lfdr.de>; Mon, 28 Mar 2022 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiC1SAo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Mar 2022 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbiC1SAo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Mar 2022 14:00:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB193151F
        for <linux-can@vger.kernel.org>; Mon, 28 Mar 2022 10:59:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nYtdr-0006G2-2G; Mon, 28 Mar 2022 19:58:59 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-3f39-5bba-2215-6d78.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:3f39:5bba:2215:6d78])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A90B155CAF;
        Mon, 28 Mar 2022 17:58:57 +0000 (UTC)
Date:   Mon, 28 Mar 2022 19:58:57 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kris Bahnsen <kris@embeddedTS.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>, wg@grandegger.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-can@vger.kernel.org
Subject: Re: [PATCH] drivers: Fix Links to Technologic Systems web resources
Message-ID: <20220328175857.dvmvh5knabc6sq3x@pengutronix.de>
References: <20220303225525.29846-1-kris@embeddedTS.com>
 <CAMRc=McesjKviO=5gK3GN+XukZfSr=um9W8+sqXw9GSFX0QTgw@mail.gmail.com>
 <1648489760.3393.6.camel@embeddedTS.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5x2aybzkooanl7ci"
Content-Disposition: inline
In-Reply-To: <1648489760.3393.6.camel@embeddedTS.com>
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


--5x2aybzkooanl7ci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.03.2022 10:49:20, Kris Bahnsen wrote:
> On Fri, 2022-03-04 at 08:24 +0100, Marc Kleine-Budde wrote:
> >=20
> > For the CAN part:
> >=20
> > Acked-by: Marc Kleine-Budde
> >=20
> > regards,
> > Marc
>=20
> On Mon, 2022-03-07 at 10:22 +0100, Bartosz Golaszewski wrote:
> >=20
> > For GPIO
> >=20
> > Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
> >=20
>=20
>=20
> Inquiring about the status of this patch. I have not seen it show up in
> any repositories. Is there any other action I need to take at this time?
> Apologies if this time frame is normal for such a low priority patch, I
> am not sure what to expect. Thanks!

I'm taking the CAN part. I think it's best to repost the GPIO part as a
separate patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5x2aybzkooanl7ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJB914ACgkQrX5LkNig
01249Qf/Q1KFpfrfnpMUCK90BP3W7bfMV2Do3WSVvqrcQK7YqZiN8DCwMK5mHi8Y
VVXNDVooQKEtaqD7Mpw3FfEznRs0ZKrgZnynrc1nxjs9jXMoD/KDMAE4PNxPgG0L
u972gOPxy/iIoIL+4gBrZyLbZ+G8Xx522mvLp90L6ZftTcwfPcGB6+i1O/KsCkK2
Xr7V/Hfrku+Q+K9CO4WSY9eBtoHNZlvICCdLlPxTNm0fgWQN0EBpL5ruD51aN5H1
Gk3oxeqCxUuqJzuB1YbFKyuluP15QiiM/E1iHCRpD0K25u2SQQIWjwGfYeLlJlVq
YSb7ZBm8v/ke51mvVoBJ37qYlWG2XQ==
=V9Y9
-----END PGP SIGNATURE-----

--5x2aybzkooanl7ci--
