Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287952B377D
	for <lists+linux-can@lfdr.de>; Sun, 15 Nov 2020 18:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgKOR4C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 15 Nov 2020 12:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgKOR4C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 12:56:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C80C0613D1
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 09:56:02 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1keMFs-0007lt-99; Sun, 15 Nov 2020 18:56:00 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:1e3d:e0be:764c:4a56])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 28250592EFE;
        Sun, 15 Nov 2020 17:55:59 +0000 (UTC)
Date:   Sun, 15 Nov 2020 18:55:56 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     linux-can@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 1/6] can: kvaser_pciefd: Fix KCAN bittiming limits
Message-ID: <20201115175556.f3kuyxwsy77hluvt@hardanger.blackshift.org>
References: <20201115163027.16851-1-jimmyassarsson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pthpnf2mf27ewofe"
Content-Disposition: inline
In-Reply-To: <20201115163027.16851-1-jimmyassarsson@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--pthpnf2mf27ewofe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2020 at 05:30:22PM +0100, Jimmy Assarsson wrote:
> From: Jimmy Assarsson <extja@kvaser.com>
>=20
> Use correct bittiming limits for the KCAN CAN controller.
>=20
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>

Applied this and 2 to linux-can/testing. The rest to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pthpnf2mf27ewofe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+xa6gACgkQqclaivrt
76lH2wgAssSvQPZW6QYeirN6sor9i2AVWqV7BPwzYLxKIrVOZlAk4Svi8sKgwXzU
f3hSUGDzGZmXEVT1ub5yHTZPAfFOaALsT1TH004+ylBTOXP8J4tPGwVdmcIFOizG
fLYL3H+Uz63eo43oRKBRrRrVEcQIAN3c4q9Dieq4YlIag2n8sFL9PUe/gdi3fPbG
6hMtrsMBAmUY5Z+zOR4vDOltD8EoWgSKEB81jBytVbSa191nLcIiMMNMXcn8/rAu
EnanxpZheHYJEDB75sOkZ0FujDu4JyuytFkFQ5bDusjJ/pwl5LcMrVLVXMJTv2K+
x1/gZS20j4VOcinGSQX140uF454BNQ==
=4/6M
-----END PGP SIGNATURE-----

--pthpnf2mf27ewofe--
