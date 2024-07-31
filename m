Return-Path: <linux-can+bounces-1072-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364A94289C
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E451F2421F
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 08:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F81A7217;
	Wed, 31 Jul 2024 08:02:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981354757
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412966; cv=none; b=ej80ztdc6IgbR9z6W6E+aWijsDBPXus0m3NdlO9NVTo0caQUPj7LUlKUeXUSA67ZMSfvCBrOOqCECb751qqfT8gUGwY41vdVTxDAbRgyi9G3yZ3WxETL5QLlWOuNnYeFDtGpfQZn+EJtqkjUM6kzOmVlFLo6nfx85EOaoP65XO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412966; c=relaxed/simple;
	bh=B9EoDBWO9Q3r9mF13BJcsHcG9ypcp4CxuGIV405OFto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX8UIj7OHsA/mlMmxwwuzkJLvFGviZ0TwVzvmQO/b8GTODLYXiM08dSQj5tLIUlZNKHd6mJA65q38S62TjNdloPN+HNtKRXhlxxBAdNA2eBm2dzRYkoyhBABq0sph95vMW4YsAJh9WXA/mPlNbk2WS8Tu1iMsapF2F9cA37tLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ4Hy-0003Hb-De; Wed, 31 Jul 2024 10:02:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ4Hx-003Tck-SV; Wed, 31 Jul 2024 10:02:25 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6582D312695;
	Wed, 31 Jul 2024 08:02:24 +0000 (UTC)
Date: Wed, 31 Jul 2024 10:02:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, David Jander <david.jander@protonic.nl>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next 04/21] can: rockchip_canfd: add driver for
 Rockchip CAN-FD controller
Message-ID: <20240731-viridian-chimpanzee-of-opportunity-be6bfb-mkl@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
 <20240729-rockchip-canfd-v1-4-fa1250fd6be3@pengutronix.de>
 <20240730163439.GA1967603@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2smo7pdiqnolmwei"
Content-Disposition: inline
In-Reply-To: <20240730163439.GA1967603@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2smo7pdiqnolmwei
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.07.2024 17:34:39, Simon Horman wrote:
> On Mon, Jul 29, 2024 at 03:05:35PM +0200, Marc Kleine-Budde wrote:
> > Add driver for the Rockchip CAN-FD controller.
> >=20
> > The IP core on the rk3568v2 SoC has 12 documented errata. Corrections
> > for these errata will be added in the upcoming patches.
> >=20
> > Since several workarounds are required for the TX path, only add the
> > base driver that only implements the RX path.
> >=20
> > Although the RX path implements CAN-FD support, it's not activated in
> > ctrlmode_supported, as the IP core in the rk3568v2 has problems with
> > receiving or sending certain CAN-FD frames.
> >=20
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> ...
>=20
> > +static void rkcanfd_get_berr_counter_raw(struct rkcanfd_priv *priv,
> > +					 struct can_berr_counter *bec)
> > +{
> > +	struct can_berr_counter bec_raw;
> > +
> > +	bec->rxerr =3D rkcanfd_read(priv, RKCANFD_REG_RXERRORCNT);
> > +	bec->txerr =3D rkcanfd_read(priv, RKCANFD_REG_TXERRORCNT);
> > +	bec_raw =3D *bec;
>=20
> nit: bec_raw is assigned but otherwise unused
>      although this is addressed in patch 15 of this series.

Moved there.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2smo7pdiqnolmwei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmap74wACgkQKDiiPnot
vG+JOAf/emfb6nH2Azb5hIEwHO7Ec6NiZHFJ4fxltDUrlhvntd6uusXl6Fhi0m+K
/d62RTxIAGKmqclchzSUmco9PBQzM+qvKzS4pEJIy9x94/8d9zN4UWu958fzvbtf
ODwyBm0kENT3b3eeqHjO9UtE+Z84BTX45DE0CRdfX4Qg+skvoJUqAUL1Y96Yqe3M
W4FTwtV0YCNzy/K8UCv84h7p2iSV2oXZDIQy41Z/P1EjK1K1cQV2TJfDUYusX8qs
aKmfWKTqART2puRBVfIcZ4Jj55lWEzqRS5olGH8PtS938tDt76W9GqukIZzaApZJ
AXdreEG7Q0UW3XENcL+XLOzhtoyPaw==
=hCaX
-----END PGP SIGNATURE-----

--2smo7pdiqnolmwei--

