Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84875ED47
	for <lists+linux-can@lfdr.de>; Mon, 24 Jul 2023 10:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGXIVV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 24 Jul 2023 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGXIVV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Jul 2023 04:21:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB9D130
        for <linux-can@vger.kernel.org>; Mon, 24 Jul 2023 01:21:19 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qNqoS-0006f6-5U; Mon, 24 Jul 2023 10:21:04 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 91D5A1F8378;
        Mon, 24 Jul 2023 08:21:01 +0000 (UTC)
Date:   Mon, 24 Jul 2023 10:21:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lukas Magel <lukas.magel@posteo.net>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] can: peak_usb: remove unused/legacy
 peak_usb_netif_rx() function
Message-ID: <20230724-anemia-canola-508fb2e26392-mkl@pengutronix.de>
References: <20230721180758.26199-1-ps.report@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2l4np6uf55mes7zh"
Content-Disposition: inline
In-Reply-To: <20230721180758.26199-1-ps.report@gmx.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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


--2l4np6uf55mes7zh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.07.2023 20:07:58, Peter Seiderer wrote:
> Remove unused/legacy peak_usb_netif_rx() function (not longer used
> since commit 28e0a70cede3 ("can: peak_usb: CANFD: store 64-bits hw
> timestamps").
>=20
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Applied to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2l4np6uf55mes7zh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS+NGcACgkQvlAcSiqK
BOjC7Af/W6pC9oD0GH+r7tZRybBPDyWZMCMQy7h3ye3f+QktxRZAP1WVbUdF21wp
1nYJeHJ1+bLOYaKfmBxuZOJLQ6eHVksWA2KRiaqWqvk0pOPeioUyzog1rhJdifzM
tmRnop8JU1mhb2f59S9MCwpCDhhFXdw+EQo0rVNlqyPdDZ1VNyouD9ptqB73fOX0
4dLr2a0f0UFRJ/o3YPDd63B8rKGIb1T5L3CUudEOhwM+RFIJXhQA3a3/Dd1spG1p
5PRdk/AWo6JFObhy9VdphxyMDDRWHQvpusCk4j8yKOPjsIqZ2bNKlO0wVi+fiNUV
OE2o4MASv27JHbA46Kk/NiCQ/vWv8w==
=FTcs
-----END PGP SIGNATURE-----

--2l4np6uf55mes7zh--
