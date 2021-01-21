Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AE62FE41D
	for <lists+linux-can@lfdr.de>; Thu, 21 Jan 2021 08:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbhAUHiV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jan 2021 02:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbhAUHiI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jan 2021 02:38:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A82C0613C1
        for <linux-can@vger.kernel.org>; Wed, 20 Jan 2021 23:37:28 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l2UWw-0001dr-SA; Thu, 21 Jan 2021 08:37:22 +0100
Received: from hardanger.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:37fb:eadb:47a3:78d5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6A7FE5C97A8;
        Thu, 21 Jan 2021 07:37:21 +0000 (UTC)
Date:   Thu, 21 Jan 2021 08:37:20 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH can tree] can: dev: prevent potential information leak in
 can_fill_info()
Message-ID: <20210121073720.zlskqgitnod3w6hf@hardanger.blackshift.org>
References: <YAkaRdRJncsJO8Ve@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sif3h2wey4pwemlu"
Content-Disposition: inline
In-Reply-To: <YAkaRdRJncsJO8Ve@mwanda>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--sif3h2wey4pwemlu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Dan,

On Thu, Jan 21, 2021 at 09:08:05AM +0300, Dan Carpenter wrote:
> The "bec" struct isn't necessarily always initialized.  For example,
> the mcp251xfd_get_berr_counter() function doesn't initialize anything
> if the interface is down.
>=20
> Fixes: 52c793f24054 ("can: netlink support for bus-error reporting and co=
unters")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for the patch. As this is a fix, I've backported it to net/master, w=
hich
is before the split of the dev.c into separate files. Applied to
linux-can/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--sif3h2wey4pwemlu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAJLykACgkQqclaivrt
76kByAf/dri0xzZQz/DzfMzagXjus6P5AAV6R3awzjWURGIXH1NwljIAeHn/Swt6
+zHwRZInKI8d0c9puZ1KPOUjebA9tQXB9ghni2PfPSQL6RMrpBpG+MnXdF1nH+kc
T5rIZ75ehwTkkmXx7iFMTEh41+jeTgqBFtwmMK64GKSmxv/0ex6crCsFBT7YXdW7
DbXFoTVIGJI9qfw5aTb+j4U/fepo+iR3dmurG9Cvc9PmqYgEAFYrufqYitNR4bPb
LGNsCxjJWJWnFrkE02Sq/ZIl8vATYDmAGKyJrcHStUDChmvF4v8CREROnXrl1zKD
tJXn1a5Yb5bxoxsRoX0PBY3tbTxNKw==
=e/IK
-----END PGP SIGNATURE-----

--sif3h2wey4pwemlu--
