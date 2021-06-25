Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B203B4144
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 12:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFYKR3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 06:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFYKR3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Jun 2021 06:17:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D527DC061574
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 03:15:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwirV-0003LD-AB; Fri, 25 Jun 2021 12:15:01 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6633:1401:6bbf:57ef])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D1084643752;
        Fri, 25 Jun 2021 10:14:59 +0000 (UTC)
Date:   Fri, 25 Jun 2021 12:14:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Moriis Ku <saumah@gmail.com>
Cc:     wg@grandegger.com, linux-can@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com
Subject: Re: [PATCH] SUNIX SDC CAN controller driver
Message-ID: <20210625101459.axvd34bodduch2vv@pengutronix.de>
References: <20210625094520.13283-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="def7zae3ipfkdrtj"
Content-Disposition: inline
In-Reply-To: <20210625094520.13283-1-saumah@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--def7zae3ipfkdrtj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.06.2021 17:45:20, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
>=20
> Add support for SUNIX SDC CAN controller
>=20
> Cc: Jason Lee <jason_lee@sunix.com>
> Cc: Taian Chen <taian.chen@sunix.com>
> Cc: Morris Ku <morris_ku@sunix.com>
> Cc: Edward Lee <Edward.lee@sunix.com>
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  sx2010_can.c | 1243 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1243 insertions(+)
>  create mode 100644 sx2010_can.c
>=20
> diff --git a/sx2010_can.c b/sx2010_can.c
> new file mode 100644
> index 0000000..5d9d360
> --- /dev/null
> +++ b/sx2010_can.c
> @@ -0,0 +1,1243 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SUNIX SDC CAN controller driver.
> + *
> + * Copyright (C) 2021, SUNIX Co., Ltd.
> + *
> + */
[...]
> +MODULE_AUTHOR("Jason Lee <jason_lee@sunix.com>");
> +MODULE_DESCRIPTION("SUNIX SDC CAN controller driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRIVER_NAME);

This driver looks like a 99% copy of the mcp251x.c driver, but your
copyrights state something different. :(

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--def7zae3ipfkdrtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDVrKAACgkQqclaivrt
76nf+wf7BtNWEDss1j/YNCnSz/gA4JX1TxacahynrI0T9meyTv3gsbVBACnmnRqz
XDP+cxm125eQoAEMm81Wbk4wbgYtntVhwZeJb1bORGtEhltFT6ex104SQJ90BagV
FwAhNP97En+e4xIPBE16XEudv++EPkeLp3FU7PMmRYQU2DMFiGiWHnzjIKLhgal5
g73IF4jud4bNDuu5HtmlK8YZNPsIvuk1zUnxu/qYVes5H2ExUpB/b/WnICVquIp7
2Rn5tZGqLu1FTFJpa4F0Pgx1zrEREJcQFpmWJkO+xEGTjnkH7vJ9RRQwtFsH5dTU
D5gcge6Etk598vDT8Wd8nrCKoSHHtw==
=7itD
-----END PGP SIGNATURE-----

--def7zae3ipfkdrtj--
