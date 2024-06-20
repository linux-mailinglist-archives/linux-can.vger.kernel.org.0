Return-Path: <linux-can+bounces-795-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890479103E9
	for <lists+linux-can@lfdr.de>; Thu, 20 Jun 2024 14:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185EC28262C
	for <lists+linux-can@lfdr.de>; Thu, 20 Jun 2024 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5E31AC42B;
	Thu, 20 Jun 2024 12:27:25 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A581991DC
	for <linux-can@vger.kernel.org>; Thu, 20 Jun 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886445; cv=none; b=QMKP9B4tsWiwNKPWsAOUCx7Z03L6DsGgO/2S8TWyH4I6qoqlu6flEEUtT0w8hUcB/qtSW8JlsiCec5KlfYi45yFGhrA23QKVhEvZnbR0q/JDDbCGRUFgvaXofTfilwX8IhVxHuazOZTmLtO1oR6umFuGsPQ31/DDubbWqNtpLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886445; c=relaxed/simple;
	bh=Wu2LgFnOmJBZ5ujdas2D9HWZy81C/aJPRhzDhrICV3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsASNRY/htYoqnDRMyrnLCKtqM4uiraB3ZtNd7YWL6/XwJUbP+qewwWX1j/qDsZTxHuXUV7sMKLrIu/BxGclFGNzYVHuLAayQH9ov8SqXf4dB0RS8XnNs4qABmzDUlEjT09mwmKMtK/SuWbcpsvErcw2TFiOFzcHNMNWDkyhwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKGsT-0005bi-Ro; Thu, 20 Jun 2024 14:26:57 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKGsR-003hQC-Hd; Thu, 20 Jun 2024 14:26:55 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2E3912ED9D2;
	Thu, 20 Jun 2024 12:26:55 +0000 (UTC)
Date: Thu, 20 Jun 2024 14:26:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] can: m_can: Map WoL to device_set_wakeup_enable
Message-ID: <20240620-magnificent-antique-pogona-4c81e8-mkl@pengutronix.de>
References: <20240523075347.1282395-1-msp@baylibre.com>
 <20240523075347.1282395-4-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rfzr2icf65wjmr2w"
Content-Disposition: inline
In-Reply-To: <20240523075347.1282395-4-msp@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--rfzr2icf65wjmr2w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.05.2024 09:53:43, Markus Schneider-Pargmann wrote:
> In some devices the pins of the m_can module can act as a wakeup source.
> This patch helps do that by connecting the PHY_WAKE WoL option to
> device_set_wakeup_enable. By marking this device as being wakeup
> enabled, this setting can be used by platform code to decide which
> sleep or poweroff mode to use.
>=20
> Also this prepares the driver for the next patch in which the pinctrl
> settings are changed depending on the desired wakeup source.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/net/can/m_can/m_can.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 14b231c4d7ec..80964e403a5e 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2129,6 +2129,26 @@ static int m_can_set_coalesce(struct net_device *d=
ev,
>  	return 0;
>  }
> =20
> +static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo=
 *wol)
> +{
> +	struct m_can_classdev *cdev =3D netdev_priv(dev);
> +
> +	wol->supported =3D device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
> +	wol->wolopts =3D device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
> +}
> +
> +static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo =
*wol)
> +{
> +	struct m_can_classdev *cdev =3D netdev_priv(dev);
> +
> +	if ((wol->wolopts & WAKE_PHY) !=3D wol->wolopts)
> +		return -EINVAL;
> +
> +	device_set_wakeup_enable(cdev->dev, !!wol->wolopts & WAKE_PHY);

Can you please add error handling here? Same for the modifications in
the next patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rfzr2icf65wjmr2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ0IAwACgkQKDiiPnot
vG/QlQf9EPQ0rJoEUiln6+rSd3vSElag0DNfhQ7x8gu+ZyGkuhdE4925LpTJzASr
yubguF2fXnNcV9m+ituFtCiPmiJUGGPSvjel1E6mbddwOj0U4AdKkPeYrX5BcIj8
UeLfRT9zMXBW7EYVU3XB/NKb7ap4Hk2luw7Rbgbn7fEtiKfjjE+toy4NmZR4S2r5
XVqt+ACdjGObgsYxG1D7GkGCFGjZxdwN1lF3/Ik0J7jE4dYmkSBcBX7c3/bo/q8M
yexqV0USpIq4kQqpJWTTe6rS2tNUiZZ7xr8bpbxBJGCXHVpY8wGoRrNytdnZgLTQ
PrnmRCrDcNH0Rauay9xHkVTPNXoOTQ==
=UzvE
-----END PGP SIGNATURE-----

--rfzr2icf65wjmr2w--

