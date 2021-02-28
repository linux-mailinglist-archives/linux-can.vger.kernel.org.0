Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39B32719D
	for <lists+linux-can@lfdr.de>; Sun, 28 Feb 2021 09:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhB1Igi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 28 Feb 2021 03:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhB1Igi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 28 Feb 2021 03:36:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A866C061756
        for <linux-can@vger.kernel.org>; Sun, 28 Feb 2021 00:35:57 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lGHYP-0006pj-NL; Sun, 28 Feb 2021 09:35:53 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:71bc:3141:ed1b:e2d2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 280B45EA820;
        Sun, 28 Feb 2021 08:35:52 +0000 (UTC)
Date:   Sun, 28 Feb 2021 09:35:51 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org, dmurphy@ti.com
Subject: Re: [PATCH] tcan4x5x: clear MRAM before entering Normal mode
Message-ID: <20210228083551.csd5oq32g6wmkcxk@pengutronix.de>
References: <20210226163440.313628-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5gw35cxdu2gvwjq2"
Content-Disposition: inline
In-Reply-To: <20210226163440.313628-1-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5gw35cxdu2gvwjq2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.02.2021 16:34:41, Torin Cooper-Bennun wrote:
> This prevents a potentially destructive race condition. The device is
> fully operational on the bus after entering Normal mode, so zeroing the
> MRAM after entering this mode may lead to loss of information, e.g. new
> received messages.
>=20
> Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>

I've added a Fixed: tag and applied the patch to linux-can/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5gw35cxdu2gvwjq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA7VeQACgkQqclaivrt
76mumAf+O/eFuFkJlaWu9sXN2aeH05vovYShFrl4Pp5zyZVAjkDfPinlXKQxWwAa
uSVxERa4lfXIPIxXBBdh05BvLcGSaUYqR81h7IN92+zkUu/lKcjBwpjtBMuhjN51
fYLwpgsrSj014R9QiFM6v7rV3ZtPJr46q5umDPU3Uyy/52OHXLyHonU1Ffg0V9Nw
Ofw5aaNCtBeJ89bnlBVdiaUZoJyS6n1zL7eRAue4we66BxA0N5F6poxwGNmi13ya
lSt9OG2k/SppXJruiO+wcIlo2Adn3zXH7hanG+bOzDhcRAjald4Qhp2RNfTE42+x
0kewoeWE4juM0nn4ftQucj3xj4pHbw==
=4+hp
-----END PGP SIGNATURE-----

--5gw35cxdu2gvwjq2--
