Return-Path: <linux-can+bounces-1831-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101329B44D7
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 09:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335B91C22144
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC6204038;
	Tue, 29 Oct 2024 08:49:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53076FB0
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191782; cv=none; b=I24NHkeG5y0z2vy9vj3e6ylYgg0KJReJvSWlvN7uSOtIWiRhRkh8WumigywgZBQE7/s652nQ+Un0x7NJLJr9DO0lNq5esvpgHAysv4Kv0hw3kf4twJ1FqPNRQGbWeiFEtUql4Nhl6DOjd5L78czeEYSltIjryv32C7odeIYnGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191782; c=relaxed/simple;
	bh=V0gJK34+R44Nxz5p4bEW0/efUib90BQ+rA/46N/6EnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBfAg3VXmg4LnpatJ5Zv3CyjAO/zO1/g5OJK52XdbnJYkpKUfEy4bvm/n4+/kJI9dlEm/VidbbW9p7pHiXEZNsfzNE141cm9dr6iUAduXHSw8bYkkpMKHnr/zqd8K+qvqNGzr7KdcVf+fSEhdnL/msxA6p7LHyGYwOPcidF4Rrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5hun-0001By-5t; Tue, 29 Oct 2024 09:49:25 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t5hul-000zmf-1H;
	Tue, 29 Oct 2024 09:49:23 +0100
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 06D593613B3;
	Tue, 29 Oct 2024 08:49:23 +0000 (UTC)
Date: Tue, 29 Oct 2024 09:49:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kory Maincent <kory.maincent@bootlin.com>, Paolo Abeni <pabeni@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Shannon Nelson <shannon.nelson@amd.com>, 
	Simon Horman <horms@kernel.org>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/6] can: dev: add generic function
 can_update_bus_error_stats()
Message-ID: <20241029-poised-augmented-binturong-1fde9f-mkl@pengutronix.de>
References: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
 <20241029084525.2858224-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nb27cg7aycdxcprh"
Content-Disposition: inline
In-Reply-To: <20241029084525.2858224-2-dario.binacchi@amarulasolutions.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--nb27cg7aycdxcprh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 1/6] can: dev: add generic function
 can_update_bus_error_stats()
MIME-Version: 1.0

Hello Dario,

On 29.10.2024 09:44:45, Dario Binacchi wrote:
> The function aims to generalize the statistics update by centralizing
> the related code, thus avoiding code duplication.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---

no proper review, just found that double assignment.

Marc

>=20
> (no changes since v1)
>=20
>  drivers/net/can/dev/dev.c | 30 ++++++++++++++++++++++++++++++
>  include/linux/can/dev.h   |  1 +
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 6792c14fd7eb..0a3b1aad405b 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -16,6 +16,36 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/of.h>
> =20
> +void can_update_bus_error_stats(struct net_device *dev, struct can_frame=
 *cf)
> +{
> +	struct can_priv *priv =3D netdev_priv(dev);
                                ^^^^^^^^^^^^^^^^
> +	bool rx_errors =3D false, tx_errors =3D false;
> +
> +	if (!cf || !(cf->can_id & (CAN_ERR_PROT | CAN_ERR_BUSERROR)))
> +		return;
> +
> +	priv =3D netdev_priv(dev);
               ^^^^^^^^^^^^^^^^
> +	priv->can_stats.bus_error++;
> +
> +	if ((cf->can_id & CAN_ERR_ACK) && cf->data[3] =3D=3D CAN_ERR_PROT_LOC_A=
CK)
> +		tx_errors =3D true;
> +	else if (cf->data[2] & (CAN_ERR_PROT_BIT1 | CAN_ERR_PROT_BIT0))
> +		tx_errors =3D true;
> +
> +	if (cf->data[2] & (CAN_ERR_PROT_FORM | CAN_ERR_PROT_STUFF))
> +		rx_errors =3D true;
> +	else if ((cf->data[2] & CAN_ERR_PROT_BIT) &&
> +		 (cf->data[3] =3D=3D CAN_ERR_PROT_LOC_CRC_SEQ))
> +		rx_errors =3D true;
> +
> +	if (rx_errors)
> +		dev->stats.rx_errors++;
> +
> +	if (tx_errors)
> +		dev->stats.tx_errors++;
> +}
> +EXPORT_SYMBOL_GPL(can_update_bus_error_stats);
> +
>  static void can_update_state_error_stats(struct net_device *dev,
>  					 enum can_state new_state)
>  {
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 23492213ea35..0977656b366d 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -201,6 +201,7 @@ void can_state_get_by_berr_counter(const struct net_d=
evice *dev,
>  				   enum can_state *rx_state);
>  void can_change_state(struct net_device *dev, struct can_frame *cf,
>  		      enum can_state tx_state, enum can_state rx_state);
> +void can_update_bus_error_stats(struct net_device *dev, struct can_frame=
 *cf);
> =20
>  #ifdef CONFIG_OF
>  void of_can_transceiver(struct net_device *dev);
> --=20
> 2.43.0
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nb27cg7aycdxcprh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcgoZAACgkQKDiiPnot
vG9DJAf+IjRLKjCVJmbmPHaFHXnHTKmBia/tOnLejXkcSE3gM0yImO4wx/e0/fR9
xlq+iP4nhtpxNRjSwxsxo+hID2VY/upEB3myC/2X3tqd415vVcjTtGlhUcqE8SZD
fItDimabq/cKdfOy4nXn3K+zXUNDp47253zMpaS00I/wiKG0hmhFQcYFN0oF1gP+
semFdCcB6pt4ju4PiSsc4hdszCKa+BCEOH3hlbJlVuc9+Ll0E0Cfc9RE+wk8kW9Y
qgZHo6kndqMeasM5iKn0k7GfOSObhcK1ti/imvhiu8//EMJd2Tdxa/RHySNiIYT4
8WtAyaSoQiyhXtHxgeHIql4EDU89Lg==
=AU70
-----END PGP SIGNATURE-----

--nb27cg7aycdxcprh--

