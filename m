Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21FC3AF5C1
	for <lists+linux-can@lfdr.de>; Mon, 21 Jun 2021 20:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFUTCD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Jun 2021 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhFUTCC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 15:02:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA11C061756
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 11:59:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lvP95-00043v-VH; Mon, 21 Jun 2021 20:59:44 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:eaae:20c7:f8b6:e250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7EF5E640A9A;
        Mon, 21 Jun 2021 18:59:41 +0000 (UTC)
Date:   Mon, 21 Jun 2021 20:59:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v3 1/5] can: flexcan: add platform data header
Message-ID: <20210621185940.ancmxf7tyzotbcp3@pengutronix.de>
References: <20210621184615.3345846-1-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6dvgyzymkidvpveb"
Content-Disposition: inline
In-Reply-To: <20210621184615.3345846-1-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--6dvgyzymkidvpveb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.06.2021 20:46:11, Angelo Dureghello wrote:
> Add platform data header for flexcan.
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
> Changes for v2:
> - move header file in more proper location
> - remove irq defines
> - change variable types to match driver types
> Changes for v3:
> - rename to more generic flexcan.h
> - reorder struct fields to avoid paddings
> - remove unused big_endian
> ---
>  include/linux/can/platform/flexcan.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 include/linux/can/platform/flexcan.h
>=20
> diff --git a/include/linux/can/platform/flexcan.h b/include/linux/can/pla=
tform/flexcan.h
> new file mode 100644
> index 000000000000..ab4628ce701b
> --- /dev/null
> +++ b/include/linux/can/platform/flexcan.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
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
> +#ifndef _PLAT_FLEXCAN_H
> +#define _PLAT_FLEXCAN_H
> +
> +struct mcf_flexcan_platform_data {

please remove the mcf_ prefix

> +	u32 clock_frequency;
> +	u8 clk_src;
> +};
> +
> +#define FLEXCAN_MCF5411X_MB_CNT_MCF	16
> +
> +#endif /* _PLAT_FLEXCAN_H */
> --=20
> 2.31.1
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6dvgyzymkidvpveb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDQ4ZoACgkQqclaivrt
76nHOQgAjiXk6XYraHPjfOnEG6/F4KBdo1iQSnFwASIDGRl9h3sO+nx4HMwsNTV8
fX6dD8fHrvqX58hCHr+MmciWoiOGhFQfruKINdoTDK16Pfnlb15s/Blvw1E1AMi1
NRCXhZMkR0uPE+EjsojXSo/X2rBrCJO9AtgIRjZTnq5UIBSPTBbw09RlGF9ru+gt
KlNu0r9YuJNwPrUQSa2VWmKqPtz3EmIuVTES73D2L8/sjQQ7a6Edgeuf4gdt7oaB
swDY7Lde/Ey0qANoB0ahneyy9rlIv70nznydY1C3gUsNvyArg52v5eC4ODSIM1CI
8Y34z43OrVYMbTV38s/G308N4Xe8LQ==
=xbdx
-----END PGP SIGNATURE-----

--6dvgyzymkidvpveb--
