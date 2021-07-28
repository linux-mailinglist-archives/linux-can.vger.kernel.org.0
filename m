Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EF3D892B
	for <lists+linux-can@lfdr.de>; Wed, 28 Jul 2021 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhG1H5D (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Jul 2021 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhG1H5D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Jul 2021 03:57:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F863C061757
        for <linux-can@vger.kernel.org>; Wed, 28 Jul 2021 00:57:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m8eR2-00012i-Ki; Wed, 28 Jul 2021 09:57:00 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7213:487e:ab4f:842a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1671E659F98;
        Wed, 28 Jul 2021 07:57:00 +0000 (UTC)
Date:   Wed, 28 Jul 2021 09:56:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Angelo Dureghello <angelo@kernel-space.org>
Subject: Re: [PATCH] can: flexcan: flexcan_error_irq_disable(): add missing
 variable initialization
Message-ID: <20210728075659.6npegwljokksjtjy@pengutronix.de>
References: <20210728075428.1493568-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4cjmacmbg2fi5vxw"
Content-Disposition: inline
In-Reply-To: <20210728075428.1493568-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4cjmacmbg2fi5vxw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The subject is obviously wrong, fixed to "flexcan_clks_enable()".

Marc

On 28.07.2021 09:54:28, Marc Kleine-Budde wrote:
> This patch adds the missing initialization of the "err" variable in
> the flexcan_clks_enable() function.
>=20
> Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/flexcan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 54ffb796a320..7734229aa078 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -649,7 +649,7 @@ static inline void flexcan_error_irq_disable(const st=
ruct flexcan_priv *priv)
> =20
>  static int flexcan_clks_enable(const struct flexcan_priv *priv)
>  {
> -	int err;
> +	int err =3D 0;
> =20
>  	if (priv->clk_ipg) {
>  		err =3D clk_prepare_enable(priv->clk_ipg);
> --=20
> 2.30.2
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4cjmacmbg2fi5vxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEBDckACgkQqclaivrt
76kPGQf6A9kSxTZzznkmLGW2Oku6t9Gf3/evliTgVqD3vIQ/BgdLn7blF74otNtx
vmfikxgVNjEIdoSd/pBdYitePZ8KHmLsFzrPG22KB+CsT+/00ahefTD/0wItqq1N
iK5b8+hPNVKfPBFKAG6scYP1nLweo36J1OMnD+S+CzlIowb3ed+W02J9o2pJHLKX
699WOGeXq4W4ZrCBI2WSTCnbdc5FTve9DXEedWeIyB43O7vxPKq5MYUVSauDTp0P
jLlucc601zLyFBEKUmvsWZKsbTdDVhiM6WFrR2TnZCsxDa2pM+dNYOlCcjunhSuR
0aH5FhdkThgtTvhkU4ZYsi9NslOMXg==
=lUjB
-----END PGP SIGNATURE-----

--4cjmacmbg2fi5vxw--
