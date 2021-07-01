Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976D73B8DEA
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 08:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhGAG4E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Jul 2021 02:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbhGAG4D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Jul 2021 02:56:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D294DC061756
        for <linux-can@vger.kernel.org>; Wed, 30 Jun 2021 23:53:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lyqZl-00087g-3l; Thu, 01 Jul 2021 08:53:29 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6b79:f6d8:f46:d3ca])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C6FF6646D54;
        Thu,  1 Jul 2021 06:53:27 +0000 (UTC)
Date:   Thu, 1 Jul 2021 08:53:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v4 2/5] m68k: stmark2: update board setup
Message-ID: <20210701065327.maawrm546dkfzxbx@pengutronix.de>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210630230016.4099050-2-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vd6cw62syeon5ln4"
Content-Disposition: inline
In-Reply-To: <20210630230016.4099050-2-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vd6cw62syeon5ln4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2021 01:00:13, Angelo Dureghello wrote:
> Add configuration for flexcan pads.
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>

How do we upstream the m68k changes? Should we split this series into
m68k and CAN?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vd6cw62syeon5ln4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDdZmQACgkQqclaivrt
76mKXQf9ElaIb8smK+jxPyJRFz1ZD/1rcvcVp9JR7RnUEdEDoB3XewdToqdF9bzY
KH7BrIxdD7jiAH8HtZ0beNID/EguP7Li2lV+q75eJjoIMxG/GqDBWCpPG7/RHKBa
3nKDQfpN+w0QtU+UNJKjBkhOjWPgWnwXdCJM5O6vLVHdn5ETfXYXh1/WxsikSzt2
FsXdziyCFEajegfPw9QKpv7e5ktXD03P6CT/s3Zs2KDBNqRMyLB63VVDmaymu2Dk
ApgI1mZZC5vEof5FZhoOinsTlVgpahZVSsRO97DBVtxhCVVaGkfNQvbfaF7S8v2K
ppEH9eAtAhbU7ods3L9xLUJV6QVxaA==
=dlRd
-----END PGP SIGNATURE-----

--vd6cw62syeon5ln4--
