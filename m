Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D24A3AC4C3
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 09:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhFRHTf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 03:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhFRHTf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 03:19:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB1C061760
        for <linux-can@vger.kernel.org>; Fri, 18 Jun 2021 00:17:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lu8kj-0003gV-O1; Fri, 18 Jun 2021 09:17:21 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:c73:4828:f436:de44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6013963E558;
        Thu, 17 Jun 2021 19:40:03 +0000 (UTC)
Date:   Thu, 17 Jun 2021 21:40:02 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 1/5] can: flexcan: add platform data for ColdFire
Message-ID: <20210617194002.vlkx55arjctozsmx@pengutronix.de>
References: <20210616231652.738027-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="td6ai6ltce3gg23p"
Content-Disposition: inline
In-Reply-To: <20210616231652.738027-1-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--td6ai6ltce3gg23p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.06.2021 01:16:48, Angelo Dureghello wrote:
> Add platform data object for ColdFire architecture.
>=20
> ---
> Changes for v2:
> - move header file in more proper location
> - remove irq defines
> - change variable types to match driver types
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
>  include/linux/can/platform/mcf5441x.h | 28 +++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 include/linux/can/platform/mcf5441x.h
>=20
> diff --git a/include/linux/can/platform/mcf5441x.h b/include/linux/can/pl=
atform/mcf5441x.h
> new file mode 100644
> index 000000000000..6866f0f60caf
> --- /dev/null
> +++ b/include/linux/can/platform/mcf5441x.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Flexcan options for ColdFire family
> + *
> + * Copyright (C) 2021  Angelo Dureghello <angelo@kernel-space.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _PLAT_FLEXCAN_MCF_H
> +#define _PLAT_FLEXCAN_MCF_H
> +
> +struct mcf_flexcan_platform_data {
> +	u8 clk_src;
> +	u32 clock_frequency;
> +	bool big_endian;

Please remove the big_endian, you don't handle it in the flexcan driver
anyways.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--td6ai6ltce3gg23p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDLpRAACgkQqclaivrt
76mwwwgAjqztrE04XkXH2BuLreE6FdtZZhyFKsqmRytUbb0qmDW8NsNxpUhA9C26
19LUUTjV1ffa2D+FilVux1WjQQjBKccPRbfpYFKiii6uAKUExX9ER2/sgrakV0Kc
C28f957Qxfa6lSkpRxdVQMCn08JCSVAAg5/p7ju12BtSxVAG1DbFtxh4lKZLc7px
IC4nF8FCmLwkEZh2PqU30yAxOjMAHh9EU0+svxOx2xRbG1uLUQrNid7HJsao7Xfg
RKCN9w4/ZyRlhgKN99cCLRt6wFxd7lxZ7P2mlboZ3hLMwBEHeZD/+gxFSvd8HDyv
JlPeb1rM2TD5q1c2j1pBFQXQlsTRwQ==
=qqnd
-----END PGP SIGNATURE-----

--td6ai6ltce3gg23p--
