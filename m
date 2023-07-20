Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A999775B21E
	for <lists+linux-can@lfdr.de>; Thu, 20 Jul 2023 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGTPNb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 20 Jul 2023 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjGTPNU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 Jul 2023 11:13:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E526BA
        for <linux-can@vger.kernel.org>; Thu, 20 Jul 2023 08:13:19 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qMVLB-0005Mk-Af; Thu, 20 Jul 2023 17:13:17 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 600E71F652B;
        Thu, 20 Jul 2023 15:13:16 +0000 (UTC)
Date:   Thu, 20 Jul 2023 17:13:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Cc:     linux-can@vger.kernel.org, vincent.mailhol@gmail.com
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of the ems_pci.c
 driver
Message-ID: <20230720-disprove-smith-4d5e3456dcb4-mkl@pengutronix.de>
References: <20230720144032.28960-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aaztve4nhik3ymdj"
Content-Disposition: inline
In-Reply-To: <20230720144032.28960-1-uttenthaler@ems-wuensche.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--aaztve4nhik3ymdj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.07.2023 16:40:32, Gerhard Uttenthaler wrote:
> At the suggestion of Marc Kleine-Budde [1], I add myself as maintainer of=
 the ems_pci.c driver.
>=20
> [1] https://lore.kernel.org/all/20230720-purplish-quizzical-247024e66671-=
mkl@pengutronix.de/
>=20
> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>

Applied to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--aaztve4nhik3ymdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS5TwgACgkQvlAcSiqK
BOg2RwgApR+V8NEABEAtXUxi5lfrIDN3tXvzhjAei4ryCQDg7COV+6Azw1jel2/G
J+TW8iirl50qKIVbhJ+It7z5qYm5RHNcSpptOSyz7NorXocdGKuhoDk+L+EepCSv
PFPS7v41J1XPE9EWrV2pi3c1zlOei0m87KErqu/MFiC4NTBcSNMjlcw8UXpQBR18
vyUpSxnF1Bs5x3G/iBsdO9keHMbEVPwECYFI2GpjmF8TQlW+leHrcPIcXb8J7foH
5RjB6vCUFBdoPJNoJF52M0wg3eFG2m+JXn8dQvCBwxTq10cNiCIsCbuOfCyD4b0b
nOhYCN5DHi1qlOgyfL549p8DzMZxVg==
=tyQK
-----END PGP SIGNATURE-----

--aaztve4nhik3ymdj--
