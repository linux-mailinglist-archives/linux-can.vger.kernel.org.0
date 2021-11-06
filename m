Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FED446E8F
	for <lists+linux-can@lfdr.de>; Sat,  6 Nov 2021 16:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhKFPPm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 6 Nov 2021 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbhKFPPl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 Nov 2021 11:15:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B08FC061570
        for <linux-can@vger.kernel.org>; Sat,  6 Nov 2021 08:13:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mjNN9-0007mh-Lj; Sat, 06 Nov 2021 16:12:47 +0100
Received: from pengutronix.de (dialin-80-228-153-084.ewe-ip-backbone.de [80.228.153.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A3BC56A5D8B;
        Sat,  6 Nov 2021 15:12:43 +0000 (UTC)
Date:   Sat, 6 Nov 2021 16:12:41 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: phy-can-transceiver: Make devm_gpiod_get optional
Message-ID: <20211106151241.pnw2qv4x2wlacgmm@pengutronix.de>
References: <20211102112120.23637-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ccilnbgzkbeyziy"
Content-Disposition: inline
In-Reply-To: <20211102112120.23637-1-a-govindraju@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2ccilnbgzkbeyziy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.11.2021 16:51:20, Aswath Govindraju wrote:
> In some cases the standby/enable gpio can be pulled low/high and would not
> be connected to a gpio. The current driver implementation will return an
> error in these cases. Therefore, make devm_gpiod_get optional.
>=20
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2ccilnbgzkbeyziy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGGm2YACgkQqclaivrt
76n6hgf9F90x3vCftppEddVRmUg3e9nVuI1mflQ6m1371lcsOR+pwmMs5gD/Imrn
nMFfIK+z38AUsAABFT3BmfoxD/NOSEWJMSBz9zHw4C4+swCchVYWQd/VBbD6KDnQ
rASFqBMucCnIPaS6gbcZGa2QYQ9xi1svECLTHq0HRh3qc77uX2wBngM5e3mBvW7i
Puudz7Y7xxKWPIML+dGVhIcOOez7l0bBDcrw1f6IUAXef4lIWHy1D5ItJUqGwrTX
T5gtazJ7HEQ/mKzs81HehtF/U3iBYgieDcN/6AOn+KjyfqlMi1Ml/MEqeCyQj9lR
F3Z5WCqWKb8DnnMOydody+KT1AcNEg==
=858p
-----END PGP SIGNATURE-----

--2ccilnbgzkbeyziy--
