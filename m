Return-Path: <linux-can+bounces-1201-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A39597E7
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2024 12:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC80E283665
	for <lists+linux-can@lfdr.de>; Wed, 21 Aug 2024 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85891BA278;
	Wed, 21 Aug 2024 08:46:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB81BA27E
	for <linux-can@vger.kernel.org>; Wed, 21 Aug 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230003; cv=none; b=XQhq1oq/c/UdwSDgZ3Z0kNstgTZP3rZVj0AVfebXmVugiYcmk/WK5IBFWEsvUemZZfGhaC4xPxRewgFbpvj8NRFwZ++pfGqjELp8m4VDNQnGhcn6zpnpCznRuMhe+NKTd2DH/m4Q+wKx1I1I9hAMfEdVvk8Iar3jwyzo/IzRwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230003; c=relaxed/simple;
	bh=wtAH7hKNGgRc4NmHEgup1Gqg1nVj696osHIZLy2OFPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbZxbQJhrpvv/9JF6nQqdB0ZqYbSJVY0BJyvL60QfduPlmtRz/hZfFSJ/o/DHDocu5ADugtbCHFHDWMxTfn98Xq2+kB+H+DGDh6DMYBhn4bAxMZuDeM+LJ8g2fAmCy248R0m92Jm2V9WKOay+bG8EJ3b6mOTFSpOxM4s8wNaVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sggzD-00042g-MQ; Wed, 21 Aug 2024 10:46:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sggzD-001yEi-0H; Wed, 21 Aug 2024 10:46:35 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A62BC322A7D;
	Wed, 21 Aug 2024 08:46:34 +0000 (UTC)
Date: Wed, 21 Aug 2024 10:46:34 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH] can: kvaser_pciefd: Enable 64-bit DMA addressing
Message-ID: <20240821-amethyst-honeybee-from-neptune-c2b8ed-mkl@pengutronix.de>
References: <20240819142255.643149-1-martin.jocic@kvaser.com>
 <20240821-proficient-raptor-of-order-8cace0-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="256rxwblht7h62j6"
Content-Disposition: inline
In-Reply-To: <20240821-proficient-raptor-of-order-8cace0-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--256rxwblht7h62j6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.08.2024 10:43:58, Marc Kleine-Budde wrote:
> On 19.08.2024 16:22:55, Martin Jocic wrote:
> > Enabling 64-bit addressing for DMA buffers will prevent issues
> > on some memory constrained platforms like e.g. Raspberry Pi 5,
> > where the driver won't load because it cannot allocate enough
> > continuous memory in the default 32-bit memory address range.
> >=20
> > Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
> > ---
> >  drivers/net/can/kvaser_pciefd.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_p=
ciefd.c
> > index a60d9efd5f8d..5885f1ce189d 100644
> > --- a/drivers/net/can/kvaser_pciefd.c
> > +++ b/drivers/net/can/kvaser_pciefd.c
> > @@ -1104,6 +1104,11 @@ static int kvaser_pciefd_setup_dma(struct kvaser=
_pciefd *pcie)
> >=20
> >  	/* Disable the DMA */
> >  	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_RE=
G);
> > +
> > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > +	dma_set_mask_and_coherent(&pcie->pci->dev, DMA_BIT_MASK(64));
> > +#endif
> > +
>=20
> Several other driver first set a 64 bit mask and if this fails they set
> a 32 bit mask and then bail out, e.g.:
>=20
> https://elixir.bootlin.com/linux/v6.10.6/source/drivers/net/ethernet/inte=
l/i40e/i40e_main.c#L15613

That was the wrong link, I meant to send this one:

https://elixir.bootlin.com/linux/v6.10.6/source/drivers/net/ethernet/broadc=
om/bnxt/bnxt.c#L14213

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--256rxwblht7h62j6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbFqWcACgkQKDiiPnot
vG/Hygf8CdJzh1GAFgNxM0Re0AGfixMfdgmB39vV5AooCJ6SAC4WUu71UMn2nGii
4fylEbbaBqxHj37jREdHTmOfyFx/6VhJkb6lOrV10/zdbR5RcnD8/Bc7XBLowukB
viw1G0w7HzkZemXreSQB1ud4GYgerArGNYvpm5B8Bm+4N3+JucX/gQZ33XNVjSqA
REcDeJPdabkVUnvyt1uuHsCJA8VpyzSfxzMmpJGh3DDiBTGnBawv6jQxn2ZUrVb7
/fa0gXkO5i4gfNTl5jGHaLwGe546RBNiWejtVpScdlyvu116NsxqTLypXCUP0XQj
xXcDzY0mplNz+3bpDKgNui5n0pVXsQ==
=0Msb
-----END PGP SIGNATURE-----

--256rxwblht7h62j6--

