Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC2533CECC
	for <lists+linux-can@lfdr.de>; Tue, 16 Mar 2021 08:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhCPHqt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Mar 2021 03:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhCPHqb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Mar 2021 03:46:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBDBC06174A
        for <linux-can@vger.kernel.org>; Tue, 16 Mar 2021 00:46:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lM4PM-00063l-9t; Tue, 16 Mar 2021 08:46:28 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6392:1248:cd55:3bde])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0DDB05F639F;
        Tue, 16 Mar 2021 07:46:26 +0000 (UTC)
Date:   Tue, 16 Mar 2021 08:46:26 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     wg@grandegger.com, qiangqing.zhang@nxp.com,
        linux-can@vger.kernel.org
Subject: Re: [PATCH] can: flexcan: fix chip freeze for missing bitrate
Message-ID: <20210316074626.7iz2vmjo42mxqjua@pengutronix.de>
References: <20210315231510.650593-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e6amiogjwqv2jc3x"
Content-Disposition: inline
In-Reply-To: <20210315231510.650593-1-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--e6amiogjwqv2jc3x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.03.2021 00:15:10, Angelo Dureghello wrote:
> For cases when flexcan is built-in, bitrate is still not set
> at registering. So flexcan_chip_freeze() generates:
>=20
> [    1.860000] *** ZERO DIVIDE ***   FORMAT=3D4
> [    1.860000] Current process id is 1
> [    1.860000] BAD KERNEL TRAP: 00000000
> [    1.860000] PC: [<402e70c8>] flexcan_chip_freeze+0x1a/0xa8
>=20
> To allow chip freeze, using an hardcoded timeout when bitrate is still
> not set.
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

Applied to linux-can/testing

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--e6amiogjwqv2jc3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBQYk8ACgkQqclaivrt
76mZlwf7BLTAqzFsY+6y1wa+7fsh6a47CwI4rmeG8URI5w3W7E8PYESM+UNAxO+D
ZHjEpq20yN8YGMDEPPSa23JNc1DflzlhKFnwiwNpEeWiT42T71To7WPo+Jdt6Z1L
8S4uaIBStHulPETXRHN6hGlgQSnHVpET3aHwmxC0GRXy8HGyTUoXH5qJtxXdUQAm
0EgIUvuzRSRPEkUxdd5oziszC0sIU2RAnV7dbxqYnNkTQv/ElBiOSQEWGFFzMmsS
qA/Db7e4oLeiakiUy1T+dmfkLxnCd133SFSyOBZB2Mlw1B1qbKLG19qEAp/loIMJ
zVorxBEDrZHcFMDpyeaMHDVXrTvU9A==
=5Q9E
-----END PGP SIGNATURE-----

--e6amiogjwqv2jc3x--
