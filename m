Return-Path: <linux-can+bounces-3053-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59953A5EDD8
	for <lists+linux-can@lfdr.de>; Thu, 13 Mar 2025 09:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632D717BD95
	for <lists+linux-can@lfdr.de>; Thu, 13 Mar 2025 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29874260A2C;
	Thu, 13 Mar 2025 08:19:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75846225A23
	for <linux-can@vger.kernel.org>; Thu, 13 Mar 2025 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853993; cv=none; b=B4M5pDsvRqsfxZ5xIa2xIR3GnOaKLepiFnszl7csqW5TIvtTm6uAPA6HjaXu63hOT0uNTDVrobQD0pmChlcKk6hmL7aKWY0VSFV5RfoVLYujAuXC6U2y9zP+EcwOS1kLYs9REDGr4yySUA/EKux/p5mJ+QIe7SMqRO6nyKiOh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853993; c=relaxed/simple;
	bh=ICD6c+vTcPmgCvlPSfErvejItxtLWXfY+HODu9IhgnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDf186Ixr+X6NLsbzL02CzoBklnFljaMLo/a50HHHyQrt+bJtXBF7bezd7B6HDhv5jbqfeXAbL7C8OtUwakaXzNIfF21Jg4HYznYi20owQP+wvNvAj1UJF92c7WQ44vkirw2jCGAoCGqeatdP28F9eCyxYo2SpnA404dEOMeMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tsdn3-0005SZ-8X; Thu, 13 Mar 2025 09:19:41 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tsdn1-005VJV-2Z;
	Thu, 13 Mar 2025 09:19:39 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1CD723D9534;
	Thu, 13 Mar 2025 07:12:07 +0000 (UTC)
Date: Thu, 13 Mar 2025 08:12:06 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, heiko@sntech.de, 
	linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: rockchip: bail out if skb cannot be allocated
Message-ID: <20250313-urban-bat-of-cubism-bf5a4a-mkl@pengutronix.de>
References: <20250313011506.3132295-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hi4c7kylwypwmzkk"
Content-Disposition: inline
In-Reply-To: <20250313011506.3132295-1-chenyuan0y@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--hi4c7kylwypwmzkk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: rockchip: bail out if skb cannot be allocated
MIME-Version: 1.0

Hello Chenyuan Yang,

thanks for your contribution.

On 12.03.2025 20:15:05, Chenyuan Yang wrote:
> Add NULL pointer check in rkcanfd_handle_error_int() to
> bail out if skb cannot be allocated.

If the skb cannot be allocated, the cf is also NULL.

regards,
Marc

> This is similar to the commit f7f0adfe64de
> ("can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out if skb c=
annot be allocated").
>=20
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
>  drivers/net/can/rockchip/rockchip_canfd-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index d9a937ba126c..90395cbdaab9 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -551,7 +551,7 @@ static int rkcanfd_handle_error_int(struct rkcanfd_pr=
iv *priv)
> =20
>  	rkcanfd_handle_error_int_reg_ec(priv, cf, reg_ec);
> =20
> -	if (!cf)
> +	if (!cf || !skb)
>  		return 0;
> =20
>  	err =3D can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
> --=20
> 2.34.1
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hi4c7kylwypwmzkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfShUIACgkQDHRl3/mQ
kZw+Vgf+Opaq2kYtMPX9Sc52f+TJg+T4rZBFr2HjmKx59vTMbPeQwECyTkMiZRyG
+KKA5CF5MTLZoS0+mi5Jh2Ju7iUVfH+PON/Yzk7bI1tGkGJ0T1WU5O6q2wrVx1rs
MXLa/FNPQbCGvJQsIVpylRq3cw2Ny0kXv9vEMrdCa3RWKDEU/jZxgnYiAc49wyZV
WlJ6RwNXJLO4fwr03+o8l/YUstsQ2vk/SqRB9/r10a2cduWUORBg7TWKPXy7sEoa
TvrcPdFFKhHB8hScGokd367/9wL2VjPPojL3k1d76maZobHNaYZ9doXv2O4zoAC8
aAghWiucEJKt71ZqaqKf47d8494AwA==
=TqR1
-----END PGP SIGNATURE-----

--hi4c7kylwypwmzkk--

