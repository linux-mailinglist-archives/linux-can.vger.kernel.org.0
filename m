Return-Path: <linux-can+bounces-2048-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F03B19C8648
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0146EB22AA6
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278371E04BE;
	Thu, 14 Nov 2024 09:33:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD31DA0ED
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576793; cv=none; b=ou5WLQSWYZfUzj+c7MoM3YEoMKNfLZuZ2vycgbqlgcgOl5DLu5oZuOxxLH1x7OxiaHCY2dXFmKldbbacVZpsLmOgUxzyHhfv8epGuVlXO80DLoD/hfTQg6fjmRA036RMJlEfWkb2SaIDZAEae46WQjxf9E4AP4vCcOO4keYlZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576793; c=relaxed/simple;
	bh=YRGF3p57aTWGrXe/eH6/Q8GFpy/jcuMGWsfoDCUpfDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvqyGyoBNzNElwCI4bCm9zrU9a4NMfGSFBPF1pCHP0A+2sCOdxlzmey3lnffpIMYDD9+Sdve9akL3U+dlfBHYjRmVUJ9T38gdWbKBe66vCUNLOfE0Tiqzh1g7oy+m0Co6EcqoEm8FP+afVc/6y+XpmNCydPuGZxCdfyyZYzy1PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBWDn-00029E-Sy; Thu, 14 Nov 2024 10:33:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBWDl-000idI-2a;
	Thu, 14 Nov 2024 10:33:01 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6C805372F64;
	Thu, 14 Nov 2024 09:33:01 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:33:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] can: tcan4x5x: add deinit callback to set standby
 mode
Message-ID: <20241114-unique-oyster-of-honor-963b97-mkl@pengutronix.de>
References: <20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com>
 <20241111-tcan-standby-v1-2-f9337ebaceea@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vhaxvdnxrml75eby"
Content-Disposition: inline
In-Reply-To: <20241111-tcan-standby-v1-2-f9337ebaceea@geanix.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--vhaxvdnxrml75eby
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] can: tcan4x5x: add deinit callback to set standby
 mode
MIME-Version: 1.0

On 11.11.2024 11:51:24, Sean Nyekjaer wrote:
> At Vsup 12V, standby mode will save 7-8mA, when the interface is
> down.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/net/can/m_can/tcan4x5x-core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..c8336750cdc276b539dde7555=
b2510fba0d0da75 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -270,6 +270,17 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
>  	return ret;
>  }
> =20
> +static int tcan4x5x_deinit(struct m_can_classdev *cdev)
> +{
> +	struct tcan4x5x_priv *tcan4x5x =3D cdev_to_priv(cdev);
> +	int ret =3D 0;
> +
> +	ret =3D regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> +				 TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_STANDBY);

return regmap_update_bits();

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vhaxvdnxrml75eby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1w8oACgkQKDiiPnot
vG8tVAf/Zq2t5InShRcFklZNepqf/HT7bgyQtAinr3X3GrDykdZD2NEv2PBf/FKv
S6zkpZkfQ/c5JbiB11bNgn8rzLm5Ia32TeQDbCaHWK8CXAgxt0ITuT4L3RFuFWLs
xVPQuMQ83iCeLaiwLWuyutT1viIwnLryevyTEfXnoT2ya4G3scCfKv+1LFbXyvVT
+7i2ZdVv1ZbFRPTit0pcN7bn7zVXG77GVAR9Py5m7naCRkhhMtbuhlBq6iYwdWQz
YufX+ju3mY8tOlMSGnCrs/7yFA+AIPV6dvdiMawg0zBNqlwi/6o4KNhnuybII4cI
d69WmcNeiPvXhfYk5do71kk8tGoZSg==
=aruM
-----END PGP SIGNATURE-----

--vhaxvdnxrml75eby--

