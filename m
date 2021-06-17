Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C033AB76F
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhFQP34 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhFQP3z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 11:29:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22870C061574
        for <linux-can@vger.kernel.org>; Thu, 17 Jun 2021 08:27:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lttvg-0007vk-6m; Thu, 17 Jun 2021 17:27:40 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:653d:6f2f:e25e:5f2e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9579263E313;
        Thu, 17 Jun 2021 15:27:38 +0000 (UTC)
Date:   Thu, 17 Jun 2021 17:27:37 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 4/5] can: flexcan: enable Kconfig for ColdFire
Message-ID: <20210617152737.eapu5wp6ca5iqzv4@pengutronix.de>
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <20210616231652.738027-4-angelo@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bc7ek4i77udtpll3"
Content-Disposition: inline
In-Reply-To: <20210616231652.738027-4-angelo@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--bc7ek4i77udtpll3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.06.2021 01:16:51, Angelo Dureghello wrote:
> Enable flexcan KConfig for ColdFire m5441x cpu's.
>=20
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
>  drivers/net/can/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e355d3974977..7a1be9dad52d 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -97,7 +97,7 @@ config CAN_AT91
> =20
>  config CAN_FLEXCAN
>  	tristate "Support for Freescale FLEXCAN based chips"
> -	depends on OF && HAS_IOMEM
> +	depends on (OF || M5441x) && HAS_IOMEM

I think it's OK to only remove the OF.

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

--bc7ek4i77udtpll3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDLaecACgkQqclaivrt
76kGmQgAtZblFfhWySgYy4TzIL4l+9+s03I2/NlmZUBV1jKP0uwjVN69La0eApMQ
mopi1Y1NAG5t9RNf1G4niRQ0g9tj2RJv1rk21wtGinr3W3LKfnPh9fYHLmh7WJPd
wuSEDAy89IZPRP/6F9nU1jYRUGTsyht1zzorfcDfJrmHzz1KcZq6REcDmdYz9LA5
IJG5lHqF0FLbgHxi/FZh9M+ctkTywM0GCnE+kd4pBJrAJ5wiizFwn3Q9thApmzQm
jxZB7DA5/vBIeJjIVgoVe3z2TIrWkTFoyiLa+GxpdABOVhOl4qPwYvTEWH49cPzH
7WkIplvEVAosoNR+brCG0+ydBwzpPg==
=miXF
-----END PGP SIGNATURE-----

--bc7ek4i77udtpll3--
