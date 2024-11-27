Return-Path: <linux-can+bounces-2240-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623BD9DAB09
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 16:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278E3281EED
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3350E200B9A;
	Wed, 27 Nov 2024 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqQ+TpdT"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05993200B96;
	Wed, 27 Nov 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722636; cv=none; b=RhSP/plUOvj281bvMYdC9tXNwf3dTMEEMSiySW5VeYQtr4WVR2HR9WvlnKNQKVlyRUzZjl0ElqJRu0bhthZCAJxN0iG0f+zUQpNh5Q7/Mk9pbX0wiTrPPusMnBHG/wuuvrpRzaAQPeiKznqmf3LEOjliKn1zMMTQFR+keLQ9iJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722636; c=relaxed/simple;
	bh=GMzyUFXayv+iAaucQEDeILamz1DG+KTQDS6JN9UBpnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc+m7VEQjUGHMlhWHHY9T+aQOZj3RFzzUQNDYd/5/HbW1WErBo++CoEKCFKfpAdu82ZT823A8sqBgNTOcOu6AYo8yBeonWldchFE2sFtypUFe/dGCebHkcaOrEI4GtYVmyMmngacEnXVQeyRVqMcMMk+MmksrP8uKosiWbalKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqQ+TpdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176CFC4CECC;
	Wed, 27 Nov 2024 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732722635;
	bh=GMzyUFXayv+iAaucQEDeILamz1DG+KTQDS6JN9UBpnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqQ+TpdTRguckLL0t7N4D06jD3UU2Say8Ly8zKzK9hfpB4JiVMGe5RZel9hf1S0s6
	 kW2IkiUjbbqG/osEEKsqT6RS9BZQhwq/JZIm5UWS8PSF994atIKjYanySQw9s9Je8c
	 TQzG/k+tFX4v/hYvDLghnzLwJUr2GNcga75I04Xu0HsEvMPMGBkQhmtGb8XaqNC5qB
	 XeeeSqtKCvIcsV+MzuRyynvOZr/3p3zEZJ+SheVKAeTrqHp7jKCNItNQQwbrLaOmQd
	 6jMGnf54Acl4d+fVmpZRuoR/eYDL83xOf+meQBrZ+JQo90O5brOZGz0ZYYDwBW0ixG
	 Ba4phCktDLZfQ==
Date: Wed, 27 Nov 2024 15:50:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next] dt-bindings: can: tcan4x5x: add missing
 required clock-names
Message-ID: <20241127-siberian-singular-c2b99a7fd370@spud>
References: <20241127-tcancclk-v1-1-5493d3f03db1@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Dtbb5lJED9JVbgX"
Content-Disposition: inline
In-Reply-To: <20241127-tcancclk-v1-1-5493d3f03db1@geanix.com>


--4Dtbb5lJED9JVbgX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 02:40:47PM +0100, Sean Nyekjaer wrote:
> tcan4x5x requires an external clock called cclk, add it here.

That's not what this patch is doing, the clock input is already there,
so I don't know what this patch actually accomplishes? clock-names isn't
a required property, so you can't even use it in a driver.

>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b=
/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> index ff18cf7393550d1b7107b1233d8302203026579d..f3f3cbc03aec13e517552d2e2=
9ecea1585de8e36 100644
> --- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> +++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> @@ -29,6 +29,10 @@ properties:
>    clocks:
>      maxItems: 1
> =20
> +  clock-names:
> +    items:
> +      - const: cclk
> +
>    reset-gpios:
>      description: Hardwired output GPIO. If not defined then software res=
et.
>      maxItems: 1
> @@ -154,6 +158,7 @@ examples:
>          can@0 {
>              compatible =3D "ti,tcan4x5x";
>              reg =3D <0>;
> +            clock-names =3D "cclk";
>              clocks =3D <&can0_osc>;
>              pinctrl-names =3D "default";
>              pinctrl-0 =3D <&can0_pins>;
> @@ -179,6 +184,7 @@ examples:
>          can@0 {
>              compatible =3D "ti,tcan4552", "ti,tcan4x5x";
>              reg =3D <0>;
> +            clock-names =3D "cclk";
>              clocks =3D <&can0_osc>;
>              pinctrl-names =3D "default";
>              pinctrl-0 =3D <&can0_pins>;
>=20
> ---
> base-commit: e0b741bc53c94f9ae25d4140202557a0aa51b5a0
> change-id: 20241127-tcancclk-c149c0b3b050
>=20
> Best regards,
> --=20
> Sean Nyekjaer <sean@geanix.com>
>=20

--4Dtbb5lJED9JVbgX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0c/xgAKCRB4tDGHoIJi
0i/oAQDT/DIBfjIS4qH8c5ppTXIHAALHWJ85zNRKQ7dBcLjK8AEAlSxJj6iPFf71
agevfrDUIEJdQm6Lkyl8GaUSWzSduwE=
=7L25
-----END PGP SIGNATURE-----

--4Dtbb5lJED9JVbgX--

