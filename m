Return-Path: <linux-can+bounces-641-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36638C6554
	for <lists+linux-can@lfdr.de>; Wed, 15 May 2024 13:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D2B1C215E4
	for <lists+linux-can@lfdr.de>; Wed, 15 May 2024 11:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82EF629E4;
	Wed, 15 May 2024 11:12:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759CE433DC
	for <linux-can@vger.kernel.org>; Wed, 15 May 2024 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715771575; cv=none; b=sSfU/Fl4iHduxYN4LnUjWYlllHY3Q6RA3WP/eykUS/nmapUpCGWJcydZXXSDPSmPWSIbNWZYBDNx/eDiDTBzc1TlJQJM3b2D+43Cz0kp2kMroaeIFFowcbKidIPYQD4ZZN1MAdaOHeJIHEmk2rth8UQtoZm0d/7ZGAte6P8kNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715771575; c=relaxed/simple;
	bh=iarP7kXKMwaOizVjSKT+Ft0Wz+Wp8DKeQCoXPj/XugM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayLOgbVhKYg+dzZN//y9GNw6BvOO8ZPHIjzEsyhZnWZ4UT0IB/RsMr0GZc6gSZvPUFC8/NeHfC/6dleTIeiApExzxvunmkQJR9BQBPNK2Fh6Q/QKB2BCf+jFmXRhxSKhx49mmBF+zAgp3iE5Jil/Zjiz1CEus031C4+JJgLspSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s7CYq-00021g-LW; Wed, 15 May 2024 13:12:40 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s7CYo-001WWJ-9x; Wed, 15 May 2024 13:12:38 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DE1782D1C71;
	Wed, 15 May 2024 11:12:37 +0000 (UTC)
Date: Wed, 15 May 2024 13:12:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vitor Soares <ivitro@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vitor Soares <vitor.soares@toradex.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] can: mcp251xfd: fix infinite loop when xmit fails
Message-ID: <20240515-athletic-sensible-swine-4e7692-mkl@pengutronix.de>
References: <20240514105822.99986-1-ivitro@gmail.com>
 <20240514-corgi-of-marvelous-peace-968f5c-mkl@pengutronix.de>
 <465a2ddb222beed7c90b36c523633fc5648715bb.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p2gqh7q5mtz2efsu"
Content-Disposition: inline
In-Reply-To: <465a2ddb222beed7c90b36c523633fc5648715bb.camel@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--p2gqh7q5mtz2efsu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2024 15:34:01, Vitor Soares wrote:
> > > +void mcp251xfd_tx_obj_write_sync(struct work_struct *ws)
> > > +{
> > > +       struct mcp251xfd_priv *priv =3D container_of(ws, struct
> > > mcp251xfd_priv,
> > > +                                                  tx_work);
> > > +       struct mcp251xfd_tx_obj *tx_obj =3D priv->tx_work_obj;
> > > +       struct mcp251xfd_tx_ring *tx_ring =3D priv->tx;
> > > +       int err;
> > > +
> > > +       err =3D spi_sync(priv->spi, &tx_obj->msg);
> > > +       if (err)
> > > +               mcp251xfd_tx_failure_drop(priv, tx_ring, err);
> > > +
> > > +       priv->tx_work_obj =3D NULL;
> >=20
> > Race condition:
> > - after spi_sync() the CAN frame is send
> > - after the TX complete IRQ the TX queue is restarted
> > - the xmit handler might get BUSY
> > - fill the tx_work_obj again

You can avoid the race condition by moving "priv->tx_work_obj =3D NULL;"
in front of the "spi_sync();". Right?

> > > +}
> > > +
> > >  static int mcp251xfd_tx_obj_write(const struct mcp251xfd_priv *priv,
> > >                                   struct mcp251xfd_tx_obj *tx_obj)
> > >  {
> > > @@ -175,7 +210,7 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *=
skb,
> > >         if (can_dev_dropped_skb(ndev, skb))
> > >                 return NETDEV_TX_OK;
> > > =20
> > > -       if (mcp251xfd_tx_busy(priv, tx_ring))
> > > +       if (mcp251xfd_tx_busy(priv, tx_ring) || priv->tx_work_obj)
> >=20
> > This should not happen, but better save than sorry.
>=20
> As there is the race condition you mentioned above, on this condition:
> priv->tx_work_obj =3D tx_obj --> xmit will return NETDEV_TX_BUSY
>=20
> or
>=20
> priv->tx_work_obj =3D NULL --> It goes through the rest of the code or
> the workqueue may sleep after setting tx_work_obj to NULL. Should I
> use work_busy() here instead or do you have another suggestion?

Yes, introduce mcp251xfd_work_busy().

I'm not sure what happens if the xmit is called between the
"priv->tx_work_obj =3D NULL" and the end of the work. Will queue_work()
return false, as the queue is still running?

> Everything else is clear to me and I'm addressing it for the v6.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p2gqh7q5mtz2efsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZEmKAACgkQKDiiPnot
vG8QuAf/Sdxq15eqo964upghsJzAYE2c+AqyhOJ41rndONHflyczJems3Jbk1t+3
BiFwD7+PFKsXec+6qguGK2vnmu74D5+PYi2zYI2Cyz5eBJhAj8M/fgpfzroPD9Oe
6tFYeTC6lRi3YW0pHxefQxP44OpTnac3CLYhPREMM0OpJJ8VLljSzEUdx2xWgFmk
M4foDpuran5XVYH/cSh9ecEXkNiJjZ7XZf3f4hXM/K0BdN2og/CyT7xGQG/Yl3lL
ZRZZDV8O6sC/tQhx4UukoaUP7bwR4z6oho8SyYU+wUsiKO6zn9xXZyEFbMmD3iJ0
lym7DsDGUyRI2gCPRjFhnJbBaIWDAQ==
=56G6
-----END PGP SIGNATURE-----

--p2gqh7q5mtz2efsu--

