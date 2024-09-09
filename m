Return-Path: <linux-can+bounces-1441-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 977959712B5
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 10:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA7D1F22D3C
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9EE1B1D74;
	Mon,  9 Sep 2024 08:57:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F9176237
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872248; cv=none; b=mSF+BoOljFjrYABsOxqDD6GEwX1WbO85E3o8IgPgyD2drBPJiCSHtUcaTV7K3CiS3mtS6z2pplDKCG/ypdrgVb7VEx5KdSPQZ76ZiGUDAh5VDKgiTpYsWeJEhwGYq6uSSTEKBQy97etNlr3lvGz8WVvFX1gCCiWQPb0mgdOVq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872248; c=relaxed/simple;
	bh=8xxXr+ro/u+DzU/FZBGhGxfHBvikVGquq4JzD94W42s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F742sqywr8q6RyZn4bB62dFw24DiBeoEw4m4IAUkfRy9ZkichuuuEwGDc02+nY413foA5kedIJJRfEuIjiOdKrmg1KnyyfjL6AKxj9vTMpWWe5QXYdHVlX7qA3ZQCoTFe3o8RcGJLJKIQTbSyeFvEX0+zvI77rBMCGXC8WoWVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snaCq-0004Ic-JM; Mon, 09 Sep 2024 10:57:08 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snaCo-006btk-VB; Mon, 09 Sep 2024 10:57:06 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 97BCB3366D4;
	Mon, 09 Sep 2024 08:57:06 +0000 (UTC)
Date: Mon, 9 Sep 2024 10:57:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, kernel@pengutronix.de, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] can: rockchip_canfd: fix return type of
 rkcanfd_start_xmit()
Message-ID: <20240909-arcane-practical-petrel-015d24-mkl@pengutronix.de>
References: <20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org>
 <20240909084448.GU2097826@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fuepnusvih4poru2"
Content-Disposition: inline
In-Reply-To: <20240909084448.GU2097826@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fuepnusvih4poru2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.09.2024 09:44:48, Simon Horman wrote:
> On Fri, Sep 06, 2024 at 01:26:41PM -0700, Nathan Chancellor wrote:
> > With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> > indirect call targets are validated against the expected function
> > pointer prototype to make sure the call target is valid to help mitigate
> > ROP attacks. If they are not identical, there is a failure at run time,
> > which manifests as either a kernel panic or thread getting killed. A
> > warning in clang aims to catch these at compile time, which reveals:
> >=20
> >   drivers/net/can/rockchip/rockchip_canfd-core.c:770:20: error: incompa=
tible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *=
, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct n=
et_device *)') with an expression of type 'int (struct sk_buff *, struct ne=
t_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
> >     770 |         .ndo_start_xmit =3D rkcanfd_start_xmit,
> >         |                           ^~~~~~~~~~~~~~~~~~
> >=20
> > ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> > 'netdev_tx_t', not 'int' (although the types are ABI compatible). Adjust
> > the return type of rkcanfd_start_xmit() to match the prototype's to
> > resolve the warning.
> >=20
> > Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-=
FD controller")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>=20
> Thanks, I was able to reproduce this problem at build time
> and that your patch addresses it.

FTR: the default clang in Debian unstable, clang-16.0.6 doesn't support
this. With clang-20 from experimental it works, haven't checked older
versions, though.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fuepnusvih4poru2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbeuF8ACgkQKDiiPnot
vG+3gQf+MluezEfY084GfE16SOshu37NwV1Ignu8Goqy9G7jmMndcoundvwxiosq
9Hd/6ILhI4GzWIF4a7UKOP6e+QPHz3eJ4V2Mgbs13QYtoLDf1nT+h+14MkiIMipK
s6z9Ee31ptiZbn2raC7J6f8Z72+F0iysurkx39ZT8vt7Okq70pBQUN+HzPgH4Ryv
MPcMpvh6mRaSQyC3zUuTnO1fW6hTMQGhOjJ4/TH5yaQvSo2N4qJExjM05X6Zz7lx
uXt78y+/LA7U3Ew4fXyEhStgIxPlFalFcR47lXQzuVBmIRiV3Z44PONYJHPjsS8m
lUd5S51lrVQG5sCik6LNGoQvZst9Yg==
=JBly
-----END PGP SIGNATURE-----

--fuepnusvih4poru2--

