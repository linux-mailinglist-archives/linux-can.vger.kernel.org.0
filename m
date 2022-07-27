Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F94582540
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 13:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiG0LRB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiG0LRA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 07:17:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED94B7CE
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 04:16:58 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oGf28-0001zw-Qk; Wed, 27 Jul 2022 13:16:56 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A9B49BC104;
        Wed, 27 Jul 2022 11:16:55 +0000 (UTC)
Date:   Wed, 27 Jul 2022 13:16:53 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH 0/3] can: export export slcan_ethtool_ops and remove
 setter functions
Message-ID: <20220727111653.aznnej5bz5dmysfv@pengutronix.de>
References: <20220727104939.279022-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bn25ghkhoq3jc53a"
Content-Disposition: inline
In-Reply-To: <20220727104939.279022-1-mailhol.vincent@wanadoo.fr>
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


--bn25ghkhoq3jc53a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.07.2022 19:49:36, Vincent Mailhol wrote:
> The c_can, flexcan and slcan use a setter function to populate
> net_device::ethtool_ops. Using a setter here add one additional
> function call and add some small bloat in the object file. Exporting
> the structure allow to remove this setter.
>=20
> The mcp251xfd uses a similar pattern except that it does some
> additional initialization. As such, this driver is left untouched.
>=20
>=20
> * Statistics *
>=20
> For the slcan driver, this patch reduces the object file by 14 bytes
> (details in the first patch). Although we did not conduct a benchmark
> for the other drivers but we expect the exact same figures.

Applied to can-next/master.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bn25ghkhoq3jc53a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLhHqMACgkQrX5LkNig
011tXwgAjOxzdiwix0hjyxtLETATB0eDARKmBUO4GYHaqPOdCktMASAY68rYB1Dd
dk+stLY3DMQ2PzOQsmAYCaTTWjkMk61dqAyUxvRyTptsr8malAEL8W2wsWGNaRTk
MjcQksSetgHDAQkqjk8SbfhE8cdSao050zS+fxno0/4/MbDYo1aVKCIci4Z+kkb+
q2PMgW5Not6ZfofuJjtdJR6Rx7OuQ6BFcnz0q0i5EgbMXY3qX0dFlRDa3K586M9u
e7KfL0oTOLZzwb0BUvsk15keN4r0KsrSvmqfVTyzvTNyYkUmRtyHDH968cuv1gIn
CeC8xQ8/FLV0QGek8BVuyxSf8Sm4KQ==
=jK5e
-----END PGP SIGNATURE-----

--bn25ghkhoq3jc53a--
