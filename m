Return-Path: <linux-can+bounces-2591-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4BCA09243
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 14:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D405E3A8E9E
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29792080DB;
	Fri, 10 Jan 2025 13:40:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03920B7E0
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516443; cv=none; b=LL2ux6E7bUv9oS+jR/WmAMtdpzYdfZFVQ9Qww6TO2Z85xJmqxB+cvqPIO2U2qTlQ7wtzGjgyFeLX4phkfJhL6ZiFlrIbqRmjGqoJ8Dc7OOMx08aqZmKpnR7chCQLI6ceZbPEi6K9iF60YQz/ihRHl5QF/s/JtGqmGQr5VtUpfgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516443; c=relaxed/simple;
	bh=PLerkdNZcgRBNhpGasCoN27kcTo1EYb+lORo5iq5NJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhAmy3piHGbw/EsZs9bi9WXm27bCdYptAwnVrmOUH5q98c592jVWSQS+MDVDw20MT7eJ2kQZw7id8/n613zCx8PQAoJnRVSYuCRYVumgSy2lPaVNYNZ6fdiNyATpuPaxZpUEW+Uknjj9rVQVbG4MGe4SpI3lPwMZDej37WAmhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWFFX-0000CQ-Hi; Fri, 10 Jan 2025 14:40:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWFFW-000Axh-1o;
	Fri, 10 Jan 2025 14:40:30 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9E0143A47AE;
	Fri, 10 Jan 2025 13:10:55 +0000 (UTC)
Date: Fri, 10 Jan 2025 14:10:55 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH net-next 15/18] can: kvaser_usb: Update stats and state
 even if alloc_can_err_skb() fails
Message-ID: <20250110-notorious-kangaroo-from-atlantis-1645f8-mkl@pengutronix.de>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
 <20250110112712.3214173-16-mkl@pengutronix.de>
 <20250110125803.GF7706@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cjml7fqyn67m4v2v"
Content-Disposition: inline
In-Reply-To: <20250110125803.GF7706@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--cjml7fqyn67m4v2v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 15/18] can: kvaser_usb: Update stats and state
 even if alloc_can_err_skb() fails
MIME-Version: 1.0

On 10.01.2025 12:58:03, Simon Horman wrote:
> On Fri, Jan 10, 2025 at 12:04:23PM +0100, Marc Kleine-Budde wrote:
> > From: Jimmy Assarsson <extja@kvaser.com>
> >=20
> > Ensure statistics, error counters, and CAN state are updated consistent=
ly,
> > even when alloc_can_err_skb() fails during state changes or error messa=
ge
> > frame reception.
> >=20
> > Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> > Link: https://patch.msgid.link/20241230142645.128244-1-extja@kvaser.com
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> ...
>=20
> > diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers=
/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>=20
> ...
>=20
> > @@ -1187,11 +1169,18 @@ static void kvaser_usb_leaf_rx_error(const stru=
ct kvaser_usb *dev,
> >  		if (priv->can.restart_ms &&
> >  		    old_state =3D=3D CAN_STATE_BUS_OFF &&
> >  		    new_state < CAN_STATE_BUS_OFF) {
> > -			cf->can_id |=3D CAN_ERR_RESTARTED;
> > +			if (cf)
> > +				cf->can_id |=3D CAN_ERR_RESTARTED;
> >  			netif_carrier_on(priv->netdev);
> >  		}
> >  	}
> > =20
> > +	if (!skb) {
> > +		stats->rx_dropped++;
> > +		netdev_warn(priv->netdev, "No memory left for err_skb\n");
> > +		return;
> > +	}
> > +
> >  	switch (dev->driver_info->family) {
> >  	case KVASER_LEAF:
> >  		if (es->leaf.error_factor) {
>=20
> Hi Jimmy and Marc,
>=20
> The next line of this function is:
>=20
> 			cf->can_id |=3D CAN_ERR_BUSERROR | CAN_ERR_PROT;
>=20
> Which dereferences cf. However, the check added at the top of
> this hunk assumes that cf may be NULL. This doesn't seem consistent.

The driver allocates the skb with:

	skb =3D alloc_can_err_skb(priv->netdev, &cf);

Which in turn calls alloc_can_skb(), which finally calls:

        *cf =3D skb_put_zero(skb, sizeof(struct can_frame));

To put the cf into the skb.

The newly added check "if (!skb)", takes care of skb allocation errors,
so that the de-referencing of "cf" is OK after this point.

regards,
Marc

P.S.:
IIRC smatch stumbled over the same pattern in another driver a while
back. Is there anything we can do about it?

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cjml7fqyn67m4v2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeBHFwACgkQKDiiPnot
vG80LggAjEDGR28sazurzlGbT9gGqqa1ncnBQ78YG2PZ0n/UYeRfQ7aruOozVnkB
vzNctUW7D6CuCjRIWaZTvDhsRs3tW+fANOKgpad7tMhBrKqyTQguaaeA1zZlipGZ
M2vDeZx++iwGcEAodiOPVex2uMd0YZR8jNwo11Mv4xrAwH1L2ISYje+ETrFA6yGg
x0lHKe73FUBGEHRP2B/K0/1u4/XwQupkSsiiVrX48Zddl5Vp7oLEilSUU1dtTCYM
kKKo9353FE04H5StzVtUMTJu1L2L/IEkMKKuK4jlB7JoaVlVrQKHGRGgKrs9WiBE
cd9BTCvy8rHvsshubljlLKWsOxbqVw==
=Iak+
-----END PGP SIGNATURE-----

--cjml7fqyn67m4v2v--

