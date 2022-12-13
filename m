Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7113D64BD0B
	for <lists+linux-can@lfdr.de>; Tue, 13 Dec 2022 20:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbiLMTRf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Dec 2022 14:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbiLMTR3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Dec 2022 14:17:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0185A21E26
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 11:17:20 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p5AmD-00040J-Rz; Tue, 13 Dec 2022 20:17:17 +0100
Received: from pengutronix.de (hardanger.fritz.box [IPv6:2a03:f580:87bc:d400:154c:16df:813d:4fb3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4414F13E18D;
        Tue, 13 Dec 2022 19:17:17 +0000 (UTC)
Date:   Tue, 13 Dec 2022 20:17:17 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] can: m_can: Cache tx putidx and transmits in flight
Message-ID: <20221213191717.422omlznn2cjjwjz@pengutronix.de>
References: <20221116205308.2996556-1-msp@baylibre.com>
 <20221116205308.2996556-4-msp@baylibre.com>
 <20221201111450.fpadmwscjyhefs2u@pengutronix.de>
 <20221202083740.moa7whqd52oasbar@blmsp>
 <20221202144630.l4jil6spb4er5vzk@pengutronix.de>
 <20221213171309.c4nrdhwjj2ivrqim@blmsp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bcur63jhnvxo3fy4"
Content-Disposition: inline
In-Reply-To: <20221213171309.c4nrdhwjj2ivrqim@blmsp>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--bcur63jhnvxo3fy4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.12.2022 18:13:09, Markus Schneider-Pargmann wrote:
> > > The tcan mram size is limited to 2048 so I would like to avoid limiti=
ng
> > > the possible sizes of the tx fifos.
> >=20
> > What FIFO sizes are you using currently?
>=20
> I am currently using 13 for TXB, TXE and RXF0.

Have you CAN-FD enabled?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bcur63jhnvxo3fy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOYz7oACgkQrX5LkNig
013yOwf/WiOvUyh+xa09Nz4+inYEqnqII6YfTLcYZRTdf09PmO9ycmOt+ZNmf2j1
qEkz1M4G0WzdBDdE9QfCr8WKo6pIE8/TrCkKD/D4rAmlgpHYJ1CkZjKZKGVmMuAw
qhJybdYoYx7z3eeXbJmws6ApPtfcz8HWjEmubcZEO/sK1wBqXonGfNzie2CXiYzc
v9LqFwUe41Xe136qZ2gr0AktNJcwnh8btwGNmJVOAijmKlD5rShKpGmcK8EQFPKp
v/hxkYZo95fNu1Df0/8YvevlTGZ1kZMyIuAP4ip5O71d4KMhgMzGMTIyGMWteyOV
8koHq9OeqTNEPj2hITpyTuM9FllONw==
=/Rqn
-----END PGP SIGNATURE-----

--bcur63jhnvxo3fy4--
