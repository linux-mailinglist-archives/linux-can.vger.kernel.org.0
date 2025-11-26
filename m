Return-Path: <linux-can+bounces-5692-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195EC8943E
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9615B4E1120
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F553009F1;
	Wed, 26 Nov 2025 10:24:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03B42E54CC
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152697; cv=none; b=Mr7XBJKDFZBMGqVl4I1tuSJOFRQkYJ7Zffsw852kJ2QsjR9PUTvoLZcNXgO+uYjqYNOXTaVp5fhrrSsKI1Q3iQsO19dLHZXl3mlaRVNVBQ0dHxOiUfPL+02+ViJ0ShodoJcAFnfjgLRQL1aXFnPm8cp/Ad1WRPFyAEWgIJj6exU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152697; c=relaxed/simple;
	bh=xTLl81nEUbgpYbf926lX4IbvnWJUeM+Kx5ZbiV8T5Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvn59F4KTBvjekjExffduNX5GjZT4o9zmpW7E5oze+GUG6Gns0K5LFkz36MTZeMmb7z5o3LLaRnCv2f5xfg8M4wlcpwUyrFS8fAo3RY4Nz6ruLzKTY5USrOgv/hRCsgGUMJK0LJ80fxcK/o/mHMqWAT2aZJ01RD2f9dslWSlVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOChX-00022C-6h; Wed, 26 Nov 2025 11:24:43 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOChW-002aUK-3C;
	Wed, 26 Nov 2025 11:24:43 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BC06D4A895B;
	Wed, 26 Nov 2025 10:24:42 +0000 (UTC)
Date: Wed, 26 Nov 2025 11:24:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [net-next v2] dt-bindings: can: mpfs: document resets
Message-ID: <20251126-famous-hummingbird-of-fruition-13a9ac-mkl@pengutronix.de>
References: <20251121-sample-footsore-743d81772efc@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g3sfs5o3fx6m5g7n"
Content-Disposition: inline
In-Reply-To: <20251121-sample-footsore-743d81772efc@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--g3sfs5o3fx6m5g7n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [net-next v2] dt-bindings: can: mpfs: document resets
MIME-Version: 1.0

Hello,

can I get a review from the DT people?

regards,
Marc

On 21.11.2025 13:42:30, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The CAN cores on Polarfire SoC both have a reset. The platform firmware
> brings both cores out of reset, but the linux driver must use them
> during normal operation. The resets should have been made required, but
> this is one of the things that can happen when the binding is written
> without driver support.
>
> Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN contr=
oller")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> This is the second mistake in this binding, both spotted because of the
> driver being written (although this one sat downstream for a while for
> w/e reason). I wish I could say that I'd send the driver soon, but I am
> busy upstreaming things I wrote and therefore understand at the moment,
> so a driver that I'd have to go understand and review before sending is
> low priority, sorry!
>
> v2: update the example too...
>
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Marc Kleine-Budde <mkl@pengutronix.de>
> CC: Vincent Mailhol <mailhol@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: linux-riscv@lists.infradead.org
> CC: linux-can@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can=
=2Eyaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> index 1219c5cb601f..519a11fbe972 100644
> --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
> @@ -32,11 +32,15 @@ properties:
>        - description: AHB peripheral clock
>        - description: CAN bus clock
>
> +  resets:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - clocks
> +  - resets
>
>  additionalProperties: false
>
> @@ -46,6 +50,7 @@ examples:
>          compatible =3D "microchip,mpfs-can";
>          reg =3D <0x2010c000 0x1000>;
>          clocks =3D <&clkcfg 17>, <&clkcfg 37>;
> +        resets =3D <&clkcfg 17>;
>          interrupt-parent =3D <&plic>;
>          interrupts =3D <56>;
>      };
> --
> 2.51.0
>
>
>

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g3sfs5o3fx6m5g7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkm1WcACgkQDHRl3/mQ
kZzBVgf8Dk5jGCTiZqW6mNooZiWfVobVmrJXKGeWxn9ru6xMAj1vqqiPtaGtAc6+
PLHtSpw1qfMJ3yxq5W/8gjwRpTUW6rSFceNnd1YLEAMcgEuj0KrrVUvUfam/vHrN
FJ+J5qPkVJ41C6BWyo2QIl7ctfoWnja87nAvUSmHb/ry+EUYqZW8X83nRAClM6Ge
jByCkpixKaWkEkk55HhYzHd2PmRNxk7GQavXtbth0OtA+zfFYjNPWAUzlszC0Ugk
yLM5YIGE1jCvuzpz/DzFoHk8WAURWMiiwFT0umzrzAElEBccJnTLjKFQe7CNIcRJ
Au3+x63iuzSQiJSBiy1MrGraXUc6Fg==
=WFeS
-----END PGP SIGNATURE-----

--g3sfs5o3fx6m5g7n--

