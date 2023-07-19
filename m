Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4DD758EE0
	for <lists+linux-can@lfdr.de>; Wed, 19 Jul 2023 09:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGSHYi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jul 2023 03:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGSHYh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jul 2023 03:24:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15FDE47
        for <linux-can@vger.kernel.org>; Wed, 19 Jul 2023 00:24:36 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qM1Xy-0002qy-Uc; Wed, 19 Jul 2023 09:24:31 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 78B531F4B8B;
        Wed, 19 Jul 2023 06:53:05 +0000 (UTC)
Date:   Wed, 19 Jul 2023 08:53:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        Jimmy Assarsson <extja@kvaser.com>,
        Martin Jocic <majoc@kvaser.com>
Subject: Re: [PATCH net-next 7/8] can: kvaser_pciefd: Move hardware specific
 constants and functions into a driver_data struct
Message-ID: <20230719-purge-obtrusive-997e0ac2d998-mkl@pengutronix.de>
References: <20230717182229.250565-1-mkl@pengutronix.de>
 <20230717182229.250565-8-mkl@pengutronix.de>
 <20230718183315.27c0cd27@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="znjxi2cp3uovi2gj"
Content-Disposition: inline
In-Reply-To: <20230718183315.27c0cd27@kernel.org>
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


--znjxi2cp3uovi2gj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.07.2023 18:33:15, Jakub Kicinski wrote:
> On Mon, 17 Jul 2023 20:22:28 +0200 Marc Kleine-Budde wrote:
> > +const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address=
_offset =3D {
>=20
> > +const struct kvaser_pciefd_irq_mask kvaser_pciefd_altera_irq_mask =3D {
>=20
> > +const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops =3D {
>=20
> > +const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_dat=
a =3D {
>=20
> sparse points out the structs in this and subsequent patch should
> be static. Would you be able to queue a quick fix on top and resend,
> or should we pull as is?

Sorry, I'll post an updated pull request.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--znjxi2cp3uovi2gj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS3iE4ACgkQvlAcSiqK
BOgNnQgAkJ9B8RHY+hLzgnfPbVr0Em9zuVDJdh1qvs0vS0eiic5x+J3rfvIP83do
rSHw1h2uP0GRzUVCq1c6jPLyJRZif41Cn8vBb5zy10ZcpSRimCJ31tsns/fupEkx
HHeaDP6r2oKBSdVWzFSqCrGrfbDVMht5RN3RFOsMTLlpuYa3jYN7kKvhqrirluCi
V6pUyQjSuBbSCF8E/58aLY9W8vNev47GAglnFwAReK/F/RfCYYTvf5gtw7gn8ehd
uEAagpv9BBqmJBcFx435H5cdAvW4jk2S446QyhIetDB/ovF7HJx8PNEBYubQmnWN
4Xsh37ooQD8h9YHgi1El0FC1eHrE6w==
=N+Sh
-----END PGP SIGNATURE-----

--znjxi2cp3uovi2gj--
