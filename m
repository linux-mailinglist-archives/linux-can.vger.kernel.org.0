Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE93B8F57
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhGAJEu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Jul 2021 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbhGAJEu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Jul 2021 05:04:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EE1C061756
        for <linux-can@vger.kernel.org>; Thu,  1 Jul 2021 02:02:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lysaK-0004js-RY; Thu, 01 Jul 2021 11:02:13 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6b79:f6d8:f46:d3ca])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6FA15646E2F;
        Thu,  1 Jul 2021 09:02:11 +0000 (UTC)
Date:   Thu, 1 Jul 2021 11:02:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v4 4/5] can: flexcan: update Kconfig to enable coldfire
Message-ID: <20210701090210.s6s7h5mrptlckbtv@pengutronix.de>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210630230016.4099050-4-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kw5h2rzmey2xh2bf"
Content-Disposition: inline
In-Reply-To: <20210630230016.4099050-4-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--kw5h2rzmey2xh2bf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2021 01:00:15, Angelo Dureghello wrote:
> Update flexcan to support coldfire architecture.
>=20
> Any new platform should use OF, but coldfire architecture is
> actually not supporting devicetrees.
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
> Changes for v2:
> none
> Changes for v3:
> - change to just remove OF
> Changes for v4:
> - readjust options with coldfire and compile test additions
> ---
>  drivers/net/can/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e355d3974977..3d6f319f6c91 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -97,7 +97,8 @@ config CAN_AT91
> =20
>  config CAN_FLEXCAN
>  	tristate "Support for Freescale FLEXCAN based chips"
> -	depends on OF && HAS_IOMEM
> +	depends on OF || COLDFIRE || COMPILE_TEST

This adds a trailing whitespace, fixed while applying.

> +	depends on HAS_IOMEM
>  	help
>  	  Say Y here if you want to support for Freescale FlexCAN.
> =20
> --=20
> 2.31.1
>=20
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kw5h2rzmey2xh2bf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDdhJAACgkQqclaivrt
76lh+Af/ZP4Fqu1P+xdZL6VPtTvzR18w4ytV26+B04WH68cZBgFZ8adAGnoxR41i
P9WqADItM7WRAWPFyXV0Fd2VtTMgV8fronMHyq2fPn0/yr2GpJkFgnkrlrciyT8C
Z4Q8IDs9l6WWHM44qgiesvbNRsLvdbWNjHcTuguEvDfq2/VX9RqVZRM3A8qNsxvk
pyeKpMak305aPYToTC3MG6MZX4PLCNSfMm1mBNS6uzudZNs1BygIhMYIsez2mNuh
1BVppjQUs5pg6aLD9NB9XeBS2E8b+kmBmNkZDXOCYpNvZ/z+qQKoS7ypYkHCbD3S
zGGgbLSkyVKix5+9CxTIp/M0faYi0Q==
=NikZ
-----END PGP SIGNATURE-----

--kw5h2rzmey2xh2bf--
