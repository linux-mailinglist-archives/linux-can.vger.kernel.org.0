Return-Path: <linux-can+bounces-4242-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4501B264FE
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C682A3838
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2987B2FC88E;
	Thu, 14 Aug 2025 12:08:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C372FC889
	for <linux-can@vger.kernel.org>; Thu, 14 Aug 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173289; cv=none; b=Ss1bSKfKmrtSgo0otzfIABBcaBofoGhXntYJORk6lOIU0Ls9sFPEEnxuykyzka4CnX9f6tQltwUfDHOAqZTEWIQdaeHJXPH2j/+VMTLswQwpr8oh24Yi2gF+EDMAPYtRk69w4IbZJMn1ppLqneCDiuLxX8yVc87kaKFNyx8ijF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173289; c=relaxed/simple;
	bh=FgJxivcfmejqzId/i4toPWx5SbvfpkCG3xzUcmUTftU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtFB9N4J6IrbkQ27xkvKoIv5L8Qx2SKnAkKE6uG8QIBPNwkt5VAeqJJ7sdSK4FecS3MEnaearNExBOyIPeZOg4rANm47PNoHyA18DOrzv5ctHLpv0C3GbR71KksKwHhE7M6kVFgHz6SdRd2QKr2BZQEl/gP60HTE8rD+vEy3ua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1umWkW-0000ak-0j; Thu, 14 Aug 2025 14:08:04 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1umWkV-000FUn-1x;
	Thu, 14 Aug 2025 14:08:03 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 08EDA457702;
	Thu, 14 Aug 2025 12:06:33 +0000 (UTC)
Date: Thu, 14 Aug 2025 14:06:31 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/9] can: rcar_can: Convert to Runtime PM
Message-ID: <20250814-incredible-cordial-coot-5f9fc9-mkl@pengutronix.de>
References: <cover.1755172404.git.geert+renesas@glider.be>
 <ae8fdd96d926ddd2c699ec2795a4c9937c3f3bc3.1755172404.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l3y752wfrreepeej"
Content-Disposition: inline
In-Reply-To: <ae8fdd96d926ddd2c699ec2795a4c9937c3f3bc3.1755172404.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--l3y752wfrreepeej
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/9] can: rcar_can: Convert to Runtime PM
MIME-Version: 1.0

On 14.08.2025 14:02:01, Geert Uytterhoeven wrote:
> The R-Car CAN module is part of a Clock Domain on all supported SoCs.
> Hence convert its driver from explicit clock management to Runtime PM.

Does kconfig ensure that Runtime PM is selected?
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/can/rcar/rcar_can.c | 46 +++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_=
can.c
> index 57030992141cc523..aecbb02c7dc9c90a 100644
> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -16,6 +16,7 @@
>  #include <linux/can/dev.h>
>  #include <linux/clk.h>
>  #include <linux/of.h>
> +#include <linux/pm_runtime.h>
> =20
>  #define RCAR_CAN_DRV_NAME	"rcar_can"
> =20
> @@ -92,7 +93,6 @@ struct rcar_can_priv {
>  	struct net_device *ndev;
>  	struct napi_struct napi;
>  	struct rcar_can_regs __iomem *regs;
> -	struct clk *clk;
>  	struct clk *can_clk;
>  	u32 tx_head;
>  	u32 tx_tail;
> @@ -506,10 +506,10 @@ static int rcar_can_open(struct net_device *ndev)
>  	struct rcar_can_priv *priv =3D netdev_priv(ndev);
>  	int err;
> =20
> -	err =3D clk_prepare_enable(priv->clk);
> +	err =3D pm_runtime_resume_and_get(ndev->dev.parent);
>  	if (err) {
>  		netdev_err(ndev,
> -			   "failed to enable peripheral clock, error %d\n",
> +			   "pm_runtime_resume_and_get() failed, error %d\n",

Can you convert the errors to %pE?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l3y752wfrreepeej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmid0UIACgkQDHRl3/mQ
kZx0KQf/ckmcqCHYustGVHLmBldbhuyp7xajpIuNi0ECf3de3XjIW198vNz4mRsg
Qe+ZJ35nAjyayYcVOsd5+YM92kZXf6jDadvRWa6704syR4eYCucbeF1TxrM6q5ib
5oaNIVlDqx691jFlAiMWldfm6xiZA8ToBCLh22vk8jiEYvY74tOpIo+RDvQGH3OI
SIw50FACtukSpd5lqGpCXJwB1olcByoiWdfrfeQECuKc0NkGBBsYqYyM4vDR1IHA
e8lIsLvXUjLkwMxynQcleofMSb6gwVJCeen1QtJRgbpamfJf5g/QEcwZjcUQ6ulP
CDW3phlbQmBb+jR4wDTYcCZPeKpP4Q==
=3Vd9
-----END PGP SIGNATURE-----

--l3y752wfrreepeej--

