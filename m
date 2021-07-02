Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B03B9E8E
	for <lists+linux-can@lfdr.de>; Fri,  2 Jul 2021 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhGBJ5i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Jul 2021 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGBJ5i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Jul 2021 05:57:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EEAC061762
        for <linux-can@vger.kernel.org>; Fri,  2 Jul 2021 02:55:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lzFt0-0002JK-Cx; Fri, 02 Jul 2021 11:55:02 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:fe13:c2b2:7939:752b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 578576477C3;
        Fri,  2 Jul 2021 09:55:00 +0000 (UTC)
Date:   Fri, 2 Jul 2021 11:54:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v5 1/5] can: flexcan: add platform data header
Message-ID: <20210702095459.juqidqhvlxmn6hk3@pengutronix.de>
References: <20210702094841.327679-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvwnzyzyyfxkde3k"
Content-Disposition: inline
In-Reply-To: <20210702094841.327679-1-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--cvwnzyzyyfxkde3k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.07.2021 11:48:37, Angelo Dureghello wrote:
> Add platform data header for flexcan.
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

Applied 1,4,5 to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--cvwnzyzyyfxkde3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDe4nEACgkQqclaivrt
76kJ9gf+L/bE+nw6TcBdZUYxfL+q8y6ShquvJ3SLYjnwNFOXWjru/vf4VN2KRlqJ
6g47Auazv2NWJvf9gpijgEsVCbocNaTHg0DYy/GalDeZdkrvihXzHLXcdfuRi0vy
wz65oAwKMpBsq5EA0Uj+JlHNc52CotYyKiHjb8IztusSkgUUQKDz6neJvSzv5OjJ
8f/MRGwdbi4yiHSz2g0r+WfpBaYDNZTBnOmXQsJzychxtTy4kf/+esTTRbG1IIYe
Ww3sPYHX7a05U8gQDlC3w6yem5WR4YEzPgWhuolVVJVJo+6ETFuSMLhPFOqerPmH
VGJAE+9/P7QRLN42JlgJ1XE+TnI5Vg==
=r4I6
-----END PGP SIGNATURE-----

--cvwnzyzyyfxkde3k--
