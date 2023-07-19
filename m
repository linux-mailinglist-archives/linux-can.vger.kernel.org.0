Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5AE758EE4
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 09:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGSHZZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jul 2023 03:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGSHZY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jul 2023 03:25:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F87A4
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 00:25:23 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qM1Yl-0003ZN-0R; Wed, 19 Jul 2023 09:25:19 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 57B5A1F4CDD;
        Wed, 19 Jul 2023 07:25:18 +0000 (UTC)
Date:   Wed, 19 Jul 2023 09:25:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        Jimmy Assarsson <extja@kvaser.com>,
        Martin Jocic <majoc@kvaser.com>
Subject: Re: [PATCH net-next 7/8] can: kvaser_pciefd: Move hardware specific
 constants and functions into a driver_data struct
Message-ID: <20230719-flint-saloon-a64345c0243c-mkl@pengutronix.de>
References: <20230717182229.250565-1-mkl@pengutronix.de>
 <20230717182229.250565-8-mkl@pengutronix.de>
 <20230718183315.27c0cd27@kernel.org>
 <20230719-purge-obtrusive-997e0ac2d998-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h4jqsk2ahouwyzc2"
Content-Disposition: inline
In-Reply-To: <20230719-purge-obtrusive-997e0ac2d998-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--h4jqsk2ahouwyzc2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.07.2023 08:53:04, Marc Kleine-Budde wrote:
> On 18.07.2023 18:33:15, Jakub Kicinski wrote:
> > On Mon, 17 Jul 2023 20:22:28 +0200 Marc Kleine-Budde wrote:
> > > +const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_addre=
ss_offset =3D {
> >=20
> > > +const struct kvaser_pciefd_irq_mask kvaser_pciefd_altera_irq_mask =
=3D {
> >=20
> > > +const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops =3D {
> >=20
> > > +const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_d=
ata =3D {
> >=20
> > sparse points out the structs in this and subsequent patch should
> > be static. Would you be able to queue a quick fix on top and resend,
> > or should we pull as is?
>=20
> Sorry, I'll post an updated pull request.

https://lore.kernel.org/all/20230719072348.525039-1-mkl@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h4jqsk2ahouwyzc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS3j9sACgkQvlAcSiqK
BOiuAAf/azvBFxBcifWVi6V/fUHkB+BhP+7WHoxaj/4nDSbmAHDKCAgouS+cEXUE
ipuBULEMTgSJVTZFucbVdyksUkmkTyhNJ8m1jGmZdFAhzwGpmdyuA2WY7R9uTz0a
YWbLqtmapO+foz0mFtZGSrZN514TY/iMC194mIbPydwFfna5RCcxQQj2Dy1Pg59J
4shXznLeHuaD7rbi4MklO3L4BkOkoO/qgJjT20LeEX3mN7SgB99iXu/Cdn8E5BRs
3AFNZA/6PoizYNDSmwrT5aJ9I0AqcpOQgZivii31SceunawNrfX2vBeulYCygHeC
KJDvKXFRyyrNxGYM+6Ua6tqJWx7rrA==
=gDai
-----END PGP SIGNATURE-----

--h4jqsk2ahouwyzc2--
