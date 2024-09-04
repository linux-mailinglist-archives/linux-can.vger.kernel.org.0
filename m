Return-Path: <linux-can+bounces-1332-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A38996B148
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0792DB213CB
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80E0126BE1;
	Wed,  4 Sep 2024 06:12:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9485C5E
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430334; cv=none; b=Fl5Km8fqR6NErpXpBJs2V4/nMQvWYxuR84djcskign0OKGTl52S2J/CeMjGELzh9f5dYYbyAwb8m0eUW1clqKWxZyafczmY2RCeIK/8/yEoe1NZpFZk7NIKAtPnzm/DLmT71lwzD/VTOz0h6PX+Uj0QRVfAXMuuD+XB70tYdAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430334; c=relaxed/simple;
	bh=uFqKU2u26RsMVaHxZCgg4NS943JlrwihnRUqYYObpxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQRT/odUzHKc9M2koIE+yZSWAdbWL0NCisEXvJEZbhPuCeh++xY4xfTq+Izoiqrhxk+YojW9l9SUxO34LZ3+lk9qr0Cn21so0ptFdzGUuniqYkzRwtz5l8kqChdkHXa6UAfHHGK6yx8PG8GXaBTWo1NjACMI5BOIWztPX8N62+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sljEw-0000oC-JK; Wed, 04 Sep 2024 08:11:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sljEt-005NS9-6K; Wed, 04 Sep 2024 08:11:35 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BA7E7331CC9;
	Wed, 04 Sep 2024 06:11:34 +0000 (UTC)
Date: Wed, 4 Sep 2024 08:11:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: kernel test robot <lkp@intel.com>
Cc: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, David Jander <david.jander@protonic.nl>, 
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next v4 01/20] dt-bindings: can: rockchip_canfd: add
 rockchip CAN-FD controller
Message-ID: <20240904-impressive-centipede-of-science-ae5cbd-mkl@pengutronix.de>
References: <20240903-rockchip-canfd-v4-1-1dc3f3f32856@pengutronix.de>
 <202409040039.TNDhtsSe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lg5lfpbtzitx4wuf"
Content-Disposition: inline
In-Reply-To: <202409040039.TNDhtsSe-lkp@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--lg5lfpbtzitx4wuf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.09.2024 01:09:26, kernel test robot wrote:
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on da4f3b72c8831975a06eca7e1c27392726f54d20]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Marc-Kleine-Budde/=
dt-bindings-can-rockchip_canfd-add-rockchip-CAN-FD-controller/20240903-1732=
43
> base:   da4f3b72c8831975a06eca7e1c27392726f54d20
> patch link:    https://lore.kernel.org/r/20240903-rockchip-canfd-v4-1-1dc=
3f3f32856%40pengutronix.de
> patch subject: [PATCH can-next v4 01/20] dt-bindings: can: rockchip_canfd=
: add rockchip CAN-FD controller
> reproduce: (https://download.01.org/0day-ci/archive/20240904/202409040039=
=2ETNDhtsSe-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409040039.TNDhtsSe-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):

Good bot!

I had already found the issue myself and fixed it in my tree. Will send
a new series today.

>=20
>    Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm57=
03-regulator.yaml references a file that doesn't exist: Documentation/devic=
etree/bindings/mfd/siliconmitus,sm5703.yaml
>    Warning: Documentation/hwmon/g762.rst references a file that doesn't e=
xist: Documentation/devicetree/bindings/hwmon/g762.txt
>    Warning: MAINTAINERS references a file that doesn't exist: Documentati=
on/devicetree/bindings/reserved-memory/qcom
>    Warning: MAINTAINERS references a file that doesn't exist: Documentati=
on/devicetree/bindings/display/exynos/
>    Warning: MAINTAINERS references a file that doesn't exist: Documentati=
on/devicetree/bindings/misc/fsl,qoriq-mc.txt
> >> Warning: MAINTAINERS references a file that doesn't exist: Documentati=
on/devicetree/bindings/net/can/rockchip,rk3568-canfd.yaml
>    Using alabaster theme

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lg5lfpbtzitx4wuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbX+hEACgkQKDiiPnot
vG/ddAf6AqyRDaYjUbvLjXaEMxYi3esfREOpspdABp9dMmJ/OImBDH2FzAgBhH42
YIBrbQ2XL2zOIqiZrM9+jyAAbUbSrEjUnyN/S4ZNK69ige8y6arn1hgXSO1NkuQy
fyw/3NvCn2/5zKrsMjDrb3xFrD/12qI95HFA9UV7bTNDMBEECkmNHb8U39kJI7YJ
RZKh16KH2FDDFoMt9tkrArYFIR2YGmRaNtI3kJX8w8Ea2p3Do6boM9C56arzazNm
K1Zzo4xQM7Cf6hvdJ3E+hu5xmVLcAWvf6mfchWU/k3N4uOr3HoXexMSKq5TLC66I
gQVIbs0EF04Byp3Q+W0smKV2CLeJug==
=M+8x
-----END PGP SIGNATURE-----

--lg5lfpbtzitx4wuf--

