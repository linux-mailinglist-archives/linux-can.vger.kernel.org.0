Return-Path: <linux-can+bounces-2490-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB369FC670
	for <lists+linux-can@lfdr.de>; Wed, 25 Dec 2024 20:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6857A13C8
	for <lists+linux-can@lfdr.de>; Wed, 25 Dec 2024 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3119A14A0A8;
	Wed, 25 Dec 2024 19:52:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CC8BFF
	for <linux-can@vger.kernel.org>; Wed, 25 Dec 2024 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735156363; cv=none; b=mzNAs+Lx6lamvL1PqhD7M+6f4v9osL2EWIqYx8Xt3jw9TXaJClGyuILTOg5u/KglmK3oEds3bl0sYp4sf7Q6gRm3QP5fX4Cx4SGKxcAPSEJ58FeWNYrRm6Tiso/IUh6N86C9TPZfZBeb2Q76kDOJtjV5RyEyUgH30+ZmjjM1u0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735156363; c=relaxed/simple;
	bh=jpxqY2qTgsVEdyu7+bAB+CgPNnEQItGMPkbq/nKHwQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7ihoDjaYg1QulPVk1Xyjx9tmOy4WmtbpYQbMUCrfLTczfWBN/AKVgvhNIIh9ul+SiqQosvtcf++QKxADUKui6/GWjhSDMOLymMhdUI9SNRSR354qXN/gyimuSsYQyuVGaA5JwCcS2sdjD4bwscr9Xozw1NxdPmIhoQbRhgQU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tQXQD-0000Jn-19; Wed, 25 Dec 2024 20:51:57 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tQXQ6-005EvM-35;
	Wed, 25 Dec 2024 20:51:51 +0100
Received: from pengutronix.de (2a02-8206-2430-9d00-8f68-253a-4589-f451.dynamic.ewe-ip-backbone.de [IPv6:2a02:8206:2430:9d00:8f68:253a:4589:f451])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 61711394F8A;
	Wed, 25 Dec 2024 19:50:18 +0000 (UTC)
Date: Wed, 25 Dec 2024 20:50:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v6 1/7] dt-bindings: can: m_can: Add wakeup properties
Message-ID: <20241225-singing-passionate-antelope-88e154-mkl@pengutronix.de>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
 <20241219-topic-mcan-wakeup-source-v6-12-v6-1-1356c7f7cfda@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="srwhw2v5uya67a3g"
Content-Disposition: inline
In-Reply-To: <20241219-topic-mcan-wakeup-source-v6-12-v6-1-1356c7f7cfda@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--srwhw2v5uya67a3g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/7] dt-bindings: can: m_can: Add wakeup properties
MIME-Version: 1.0

On 19.12.2024 20:57:52, Markus Schneider-Pargmann wrote:
> m_can can be a wakeup source on some devices. Especially on some of the
> am62* SoCs pins, connected to m_can in the mcu, can be used to wakeup
> the SoC.
>=20
> The wakeup-source property defines on which devices m_can can be used
> for wakeup and in which power states.
>=20
> The pins associated with m_can have to have a special configuration to
> be able to wakeup the SoC. This configuration is described in the wakeup
> pinctrl state while the default state describes the default
> configuration.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

The DTBS check fails:

| $ make CHECK_DTBS=3Dy ti/k3-am625-beagleplay.dtb
|   DTC [C] arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb
| arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e08000: wakeup-sourc=
e: 'oneOf' conditional failed, one must be fixed:
|         ['suspend', 'poweroff'] is not of type 'boolean'
|         ['suspend', 'poweroff'] is too long
|         from schema $id: http://devicetree.org/schemas/net/can/bosch,m_ca=
n.yaml#
| arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e08000: wakeup-sourc=
e: ['suspend', 'poweroff'] is not of type 'boolean'
|         from schema $id: http://devicetree.org/schemas/wakeup-source.yaml#
| arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e18000: wakeup-sourc=
e: 'oneOf' conditional failed, one must be fixed:
|         ['suspend', 'poweroff'] is not of type 'boolean'
|         ['suspend', 'poweroff'] is too long
|         from schema $id: http://devicetree.org/schemas/net/can/bosch,m_ca=
n.yaml#
| arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: can@4e18000: wakeup-sourc=
e: ['suspend', 'poweroff'] is not of type 'boolean'
|         from schema $id: http://devicetree.org/schemas/wakeup-source.yaml#

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--srwhw2v5uya67a3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdsYfYACgkQKDiiPnot
vG8yoQf/TvollExLSNWWJR9S7tKurNCmxmlPYket9IZbscYEr9zwGB4CG9v6q/K/
ee5jRaJ7ck8hiUEkIQpHwz8Ek+jq84GAJEQYWDjIT5dZSLwkQsZS54/Nv4wPgrbH
3BPxTlMdkDiFHqlxSX/yOTyTbGD8sc3VU2pXx7DfFBl6C4f7bhup19guLiLosUr1
1Nh8jnttzV2pSiG/YzsMQCuj5SuiCYnFpJnJzgUMRPSm4+WEZHlecq5BnszfWeS3
hqZII3Wg1aCdm+CstUvAw+jIfa1InbNjtS2drU5kOsiawKcK0gzdCzQ0cBvvylaf
bpK/ypEN0QZZxuSAkpBmm6+xF1hAyQ==
=WQRL
-----END PGP SIGNATURE-----

--srwhw2v5uya67a3g--

