Return-Path: <linux-can+bounces-1438-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92DF970F64
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 09:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A21282B87
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2C1AE02A;
	Mon,  9 Sep 2024 07:15:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD6D1AE05C
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866106; cv=none; b=nNHMo/umkWTsgYuy0DYfO2XsKwtAJwKoDa1OPdzXk5gW8ZMDtD08wBmbZFsZ/eRQhwD7c6ZbcPrNIqhNzN19EwvTqVPCMoDNmEFgZcBv4ODxj146uFriQoPFMX0aIGJKnKBtvq3ZnKEGjtmiDeC3ztKHK6BKyTKbXo8YMBk69/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866106; c=relaxed/simple;
	bh=snuoNvsrx2PKI9Nr4K54WSHcvlbHkfybutdtOuFAYKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvlVJMPxmOAExKwdgddwCkhdeYKh6wb2xg7Ba39N7CY89wa4/1rs+DyzC8H28PrEvlqBPIPJ4huaiQyWnbWWlxTfvZOsy4x/pVuKMW2xzIKV12FjNuH2IsRZmK+JfXVH/tUepi1sUCrT6xsXRWnUJt+Up423qjUjPNi0M3YkZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snYbn-0005G9-Us; Mon, 09 Sep 2024 09:14:47 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snYbn-006awm-4H; Mon, 09 Sep 2024 09:14:47 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AF69C33650C;
	Mon, 09 Sep 2024 07:14:46 +0000 (UTC)
Date: Mon, 9 Sep 2024 09:14:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Subject: Re: [PATCH] can: rockchip_canfd: fix return type of
 rkcanfd_start_xmit()
Message-ID: <20240909-arcane-hopping-trogon-e66ce9-mkl@pengutronix.de>
References: <20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fw2ahjtdojmvq5a"
Content-Disposition: inline
In-Reply-To: <20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5fw2ahjtdojmvq5a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.09.2024 13:26:41, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> warning in clang aims to catch these at compile time, which reveals:
>=20
>   drivers/net/can/rockchip/rockchip_canfd-core.c:770:20: error: incompati=
ble function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, =
struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net=
_device *)') with an expression of type 'int (struct sk_buff *, struct net_=
device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>     770 |         .ndo_start_xmit =3D rkcanfd_start_xmit,
>         |                           ^~~~~~~~~~~~~~~~~~
>=20
> ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> 'netdev_tx_t', not 'int' (although the types are ABI compatible). Adjust
> the return type of rkcanfd_start_xmit() to match the prototype's to
> resolve the warning.
>=20
> Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD=
 controller")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5fw2ahjtdojmvq5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbeoGMACgkQKDiiPnot
vG8E7gf/XpZwpCzyzLr/XwHFG9RLcVnIdAp2UjKJAb9bt2OLqRFLpeg/sn4rvM6c
sn/3WBHWjl1pOxih8/srCfm46JO86F4Z9WLduY5dFC2a9CiBWW6vB/+J0467HyIy
T7iMjqhJpMOi/RW2xQIb3rm0DjewSxjhhGmmHgbtR8HS210U08AxZWCxq0dULR5u
BmGC2rq5GyVhCoD2TVsUIpzKHIbwm7zk82CxeVgzXvWHVZ8/g71UN4qvWOvo6vsr
U52Za8YFmERPv2WmuiHn2KdUht1aAJsyzIqWoCXXHWKoGo6WhuipCSLbLxL+UwAq
AdnREoaojt9NTDFQXa1B1x67ftG8HA==
=qgme
-----END PGP SIGNATURE-----

--5fw2ahjtdojmvq5a--

