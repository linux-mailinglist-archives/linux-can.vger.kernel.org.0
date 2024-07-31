Return-Path: <linux-can+bounces-1070-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C31942893
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 10:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41B71C218D0
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F274450E2;
	Wed, 31 Jul 2024 08:02:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4131A4B29
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412922; cv=none; b=T5b6bCBuV9gh6MZ0SwwjDeFEbAEpjZM93obWmkSEsrPe1jsJf2WME3IJZjydWMzf3QzLE3cf5ssCx0VW3qO4K+yk3TYW6+AexYu96gShgngIpI72hGYl2QBlFSj6fEd+ikWWiVEfHUXEcZtcVRCs4wtFX5cUwbeHTfF0bKe/9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412922; c=relaxed/simple;
	bh=C5FyirmAhRA35CTH9SzD6UuUJmCfDxZY3oJx3UZWCgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLiv3dJZ1aKCY1SxNv5Tk4wuAy2IanZFX50gOslM2s1E6C0C8feoVMUoCVtvqY9KoN8x3ODSn1a281aqmT9DvqBpbJiugRjqWhAIqDzyazeCEU04jTLlNZxuYbfitW9RcXJslj87ZbfdAVZ9NW8c7SLfTm+MGCD7FXcZFqppVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ4HC-0002st-NQ; Wed, 31 Jul 2024 10:01:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ4HC-003Tbs-6H; Wed, 31 Jul 2024 10:01:38 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B91A5312689;
	Wed, 31 Jul 2024 08:01:36 +0000 (UTC)
Date: Wed, 31 Jul 2024 10:01:36 +0200
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
Subject: Re: [PATCH can-next 12/21] can: rockchip_canfd: add TX PATH
Message-ID: <20240731-berserk-wandering-lemming-5abd7e-mkl@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
 <20240729-rockchip-canfd-v1-12-fa1250fd6be3@pengutronix.de>
 <20240730164401.GD1967603@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qjjxgu7e523drimg"
Content-Disposition: inline
In-Reply-To: <20240730164401.GD1967603@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qjjxgu7e523drimg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.07.2024 17:44:01, Simon Horman wrote:
> On Mon, Jul 29, 2024 at 03:05:43PM +0200, Marc Kleine-Budde wrote:
> > The IP core has a TX event FIFO. In other IP cores, this type of FIFO
> > normally contains the event that a CAN frame has been successfully
> > sent. However, the IP core on the rk3568v2 the FIFO also holds events
> > of unsuccessful transmission attempts.
> >=20
> > It turned out that the best way to work around this problem is to set
> > the IP core to self-receive mode (RXSTX), filter out the self-received
> > frames and insert them into the complete TX path.
> >=20
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> ...
>=20
> > diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net=
/can/rockchip/rockchip_canfd-tx.c
>=20
> ...
>=20
> > +void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 t=
s,
> > +				unsigned int *frame_len_p)
> > +{
> > +	struct net_device_stats *stats =3D &priv->ndev->stats;
> > +	unsigned int tx_tail;
> > +	struct sk_buff *skb;
> > +
> > +	tx_tail =3D rkcanfd_get_tx_tail(priv);
> > +	skb =3D priv->can.echo_skb[tx_tail];
>=20
> nit: skb is set but otherwise unused in this function.

Moved into the appropriate patch.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qjjxgu7e523drimg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmap710ACgkQKDiiPnot
vG88YQgAg+dwmK2wbxGVd7we6a2Cm07aRjhauJAkwCiRHZAO+KZFaTb2E43AhhSE
MwD/uba8v7zETenTpLeWSqLQlDnwAxRitVnloLZJLuKHPbpnxxC8Wjqx32d8ZQ0o
HLgF72DO1nW+fkyjOVV9r8OWKyFi9e709yJ7ZajbJ6mAFi5vxt17B6lhWsY7+6Oc
7ziCvHbdbpKwG2ys0ce5wlALqglcfwVpXQ3a30A4DPysKX9IZpWaBALjSd/E2h8d
f1EoInEKm4yAdrUTgKF+MAZ86SqZWm8M7ns7chmZvVqydr7XShTBlKNwDRZugXwn
O4h2ggdIU5YnzeB9u3uPkbYvHJqDHw==
=ge4Q
-----END PGP SIGNATURE-----

--qjjxgu7e523drimg--

