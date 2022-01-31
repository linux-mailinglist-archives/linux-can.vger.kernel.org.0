Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0939B4A3EBC
	for <lists+linux-can@lfdr.de>; Mon, 31 Jan 2022 09:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbiAaImM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Jan 2022 03:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiAaImL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jan 2022 03:42:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BC1C061714
        for <linux-can@vger.kernel.org>; Mon, 31 Jan 2022 00:42:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nESGH-0003qj-LE; Mon, 31 Jan 2022 09:42:09 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 25E1F282CB;
        Mon, 31 Jan 2022 08:42:09 +0000 (UTC)
Date:   Mon, 31 Jan 2022 09:42:05 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     petter@ka-long.de
Cc:     linux-can@vger.kernel.org
Subject: Re: MCP2518FD : Failed to detect MCP2518FD (osc=0x00000000)
Message-ID: <20220131084205.53otmukeyt2dt4zj@pengutronix.de>
References: <20220131083304.122C45B0007E@dd15738.kasserver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xl7akwq6stor3gtp"
Content-Disposition: inline
In-Reply-To: <20220131083304.122C45B0007E@dd15738.kasserver.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xl7akwq6stor3gtp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.01.2022 09:33:04, petter@ka-long.de wrote:
> I am working on an IMX7D board. Some time ago I have back-ported the
> MCP2518FD driver to the official 5.4.70 NXP kernel and it works fine.
>=20
> I am struggleing to get the mcp driver working on the latest nxp
> kernel 5.10.72.
>=20
> Same hardware.
>=20
> I did not find any unusal in the logs. pinctrl did not complain, spi
> seems to initialize normal.
>=20
> The old kernel with the new (almost old one) device tree works. The
> new kernel did not work with the old or new device tree.
>=20
> At the moment I am stuck. Could be anything. Must not be the driver
> itself.

Is SPI DMA enabled? Try disabling it.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xl7akwq6stor3gtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmH3oNsACgkQqclaivrt
76mcMwf/Rz2mH6mNR66om9LycIOEi20sxc0Fk9abpl33B3+QfF0kX74Az75k4qi/
1JsN/4hsRC69EazGG2TnUtCO2w2nz0SheFFG+g1y2NQFTWeh4fP4FIDfFXEowp+e
E/HhtY+1M1zeRnTs354YVdwqzxHTzy7lY0i+5Hf8tIRI7rKYKe38TUWbfPLEoBUY
Uu3BojGogqGBaopSPtAg3nP9qAq4MbZ/+Eh49GUw0Ncd5cIs4fLCeSM2aK8kSDzj
Rkw6U6sBeAbDCJmg1gR1mC8bwW55OmgI/2k4Xwg5bZ5D6v9tl/7ToQXe3ARabukj
tCVj5DKJA3W1aPw+8nQQAEa2GVM3Uw==
=W/e8
-----END PGP SIGNATURE-----

--xl7akwq6stor3gtp--
