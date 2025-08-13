Return-Path: <linux-can+bounces-4216-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F4B242E0
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 09:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ACC67ADB52
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 07:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2DA18B12;
	Wed, 13 Aug 2025 07:37:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA928640A
	for <linux-can@vger.kernel.org>; Wed, 13 Aug 2025 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070644; cv=none; b=IqH54JR6k5lCM8/ypmDH7hZeE70wljibzWKK+c0AaRB1fnftDzVwPBhYMXg1+HS/SBr5hYOLZ3CNkhpgyaMmhP5MB8f4eUpUMeISU4KkEmzgVa2YTv2tYEFFJenj0yfsd6cCLOwCmQPyYHV+ktzIzpU4n/arR+9lYlu2Z369JPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070644; c=relaxed/simple;
	bh=yRKQ/qj20C5/lqHEMd0hzLsxmQNgetkTkCMhlz7c524=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rE0550uFEh9efeJ4kjWWbQBh9N90fzwp343xBoiD7s/yrpOtWE11G4CMHNmdZBI6eFyBZyFoF4WR8BOSZwTYs88MyCd2bKzsf2hzSC3R7XIqbGZyov190m3foxUzUcRUkB5X3HeXhsnuof5JouO+swXWa+gMgDVNy/8SGRB8tpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um62h-0004jV-88; Wed, 13 Aug 2025 09:37:03 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um62f-0003R6-2V;
	Wed, 13 Aug 2025 09:37:01 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 549B04567EC;
	Wed, 13 Aug 2025 07:37:01 +0000 (UTC)
Date: Wed, 13 Aug 2025 09:37:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
	Simon Horman <horms@kernel.org>, Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/4] dt-bindings: can: m_can: Add wakeup properties
Message-ID: <20250813-shaggy-notorious-octopus-718ca6-mkl@pengutronix.de>
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
 <20250812-topic-mcan-wakeup-source-v6-12-v8-1-6972a810d63b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7i4a7r5obmubacha"
Content-Disposition: inline
In-Reply-To: <20250812-topic-mcan-wakeup-source-v6-12-v8-1-6972a810d63b@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7i4a7r5obmubacha
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 1/4] dt-bindings: can: m_can: Add wakeup properties
MIME-Version: 1.0

On 12.08.2025 11:10:22, Markus Schneider-Pargmann wrote:
> The pins associated with m_can have to have a special configuration to
> be able to wakeup the SoC from some system states. This configuration is
> described in the wakeup pinctrl state while the default state describes
> the default configuration.
>=20
> Also m_can can be a wakeup-source if capable of wakeup.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  .../devicetree/bindings/net/can/bosch,m_can.yaml   | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b=
/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..ecba8783198fc1658fcc236d8=
aa3c89d8c90abbd 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -106,6 +106,22 @@ properties:
>          maximum: 32
>      minItems: 1
> =20
> +  pinctrl-0:
> +    description: Default pinctrl state
> +
> +  pinctrl-1:
> +    description: Wakeup pinctrl state
> +
> +  pinctrl-names:
> +    description:
> +      When present should contain at least "default" describing the defa=
ult pin
> +      states. The second state called "wakeup" describes the pins in the=
ir
> +      wakeup configuration required to exit sleep states.
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: wakeup
> +
>    power-domains:
>      description:
>        Power domain provider node and an args specifier containing
> @@ -122,6 +138,12 @@ properties:
>      minItems: 1
>      maxItems: 2
> =20
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      List of phandles to system idle states in which mcan can wakeup th=
e system.

What non TI SoCs that don't have partial IO and want regular Wake-On-CAN
and don't define system idle states?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7i4a7r5obmubacha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicQJkACgkQDHRl3/mQ
kZz6nwgAi53j+yYe5CkMZo/2NhANMlLaJCSU/7JNOdJpbcCFzdd67T+qnQRnOtf1
iod8yJPTBy57d3WB9NHqcXNHXwT0QiqJDisHkR2noDGC0UY2dfiM3nDY3GeX3Llg
fedlqD9BCl3xJkBAMPMcg81Wqs1Dh0AlYFYRn3MPJHmdxNqQI33hKaNZaEYlmfnx
dUdHCPW6VB2GwJv739v1dDgqrwHM2ZlwRwwicSAun0sfw87un6PcyY61PAcQzkXR
iY5ZAG3E2srVsvhjldOpXtPH2PNMR3EtaaKf0xsGvS7L1aBOklupQmTlg8os44w9
9d9rc78A8vAPmw/qDup9ZGHJsP/ENw==
=bHMV
-----END PGP SIGNATURE-----

--7i4a7r5obmubacha--

