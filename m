Return-Path: <linux-can+bounces-4215-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0460B242AB
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 09:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC63818952EF
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C082C326D;
	Wed, 13 Aug 2025 07:24:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC62DCF42
	for <linux-can@vger.kernel.org>; Wed, 13 Aug 2025 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069849; cv=none; b=WnLkvrZ4gS9AYNyOQlqWe2HlmbZoeVUtumZX0/Ci/DfZDnZT/wzDdBRrfD92H4SyAEg4YrWkNwiSPjWH6LIvvUThZmE92AfYmzuJcwGVfkMpceNr6nbbXPatXWVq2Zd+Mxh0NbX3CijvAUJE1cUE6sHivNiaPDRSYT5dAbGVktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069849; c=relaxed/simple;
	bh=LTp9h4E8z/4gVVB70sS+uyodcHcZqU3Ib72DtMoUEeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwuZ4ioHtCXmS+TFZF+0yALTo3M9zjHe+8/3/0/dxHgeUXSfieib0MvlqrbP4J2N7y7EVt1Hlyeb38JwSMGEceWyEVbnKD5/6JOjvkJjU2QFvfm2D58qLXmBsxQEmsZpw7zuYeKvRgNVX7fXbU1UXj6rtnww0QMb/Fj4GTkN8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1um5pP-00031i-Bb; Wed, 13 Aug 2025 09:23:19 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1um5pN-0003LF-1a;
	Wed, 13 Aug 2025 09:23:17 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1C5FD4567D0;
	Wed, 13 Aug 2025 07:23:17 +0000 (UTC)
Date: Wed, 13 Aug 2025 09:23:16 +0200
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
Message-ID: <20250813-energetic-hare-of-pizza-6ad6df-mkl@pengutronix.de>
References: <20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com>
 <20250812-topic-mcan-wakeup-source-v6-12-v8-1-6972a810d63b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nfqkg2ypmiobsl4a"
Content-Disposition: inline
In-Reply-To: <20250812-topic-mcan-wakeup-source-v6-12-v8-1-6972a810d63b@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--nfqkg2ypmiobsl4a
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

This breaks at least the stm32mp15 SoCs that define a sleep state:

&m_can1 {
	resets =3D <&rcc FDCAN_R>;
	pinctrl-names =3D "default", "sleep";
	pinctrl-0 =3D <&m_can1_pins_b>;
	pinctrl-1 =3D <&m_can1_sleep_pins_b>;
	status =3D "okay";
};

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
> +
> +

One newline should be enough.

>  required:
>    - compatible
>    - reg
>=20
> --=20
> 2.50.1
>=20
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nfqkg2ypmiobsl4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmicPWEACgkQDHRl3/mQ
kZxZ6ggAndbI3imPTI4yTppaCqGe0O0ugEouNouvoXOSLMDIPzSYMNem3/ug/wMQ
RdnIkPTCILVaBDpWLamA5J8ZIJRQuaXxDUdiSHZNV+MnHAwvKQ9RTlSAX6O0EYa0
wtz0KbvyR5MoaJ7VeQMPi3cZ4r3Z3Jkn76nLYLqk0W8ONEm79Qc/BdAsigDNP/A0
C/taLXRROfu8IlwfXhMjGrRxjbpsdek/JOyqujbbPhAH+JdhDN+aqVxMAi72ht1d
lHIHUkUGLlPFqGny9yAYtOZumuEJPMJQRMTG/t9ZuI9LyTKfUgalb2/bQGsYGp/5
KG2dR4+6OGFm1HkZu3vFb6QJW5qPtQ==
=mzQ8
-----END PGP SIGNATURE-----

--nfqkg2ypmiobsl4a--

