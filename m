Return-Path: <linux-can+bounces-5173-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD691BD5FBA
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 21:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C2CC4E515F
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 19:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF812D8774;
	Mon, 13 Oct 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdGJrebm"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F81D5141;
	Mon, 13 Oct 2025 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384514; cv=none; b=oBPIN9b09y/mBFCcxkDTkrfOA8adB+pHz7Q/XCX66RH7ilsrDPjBH2FDvJelC/+1zUVDpT2U8VgCTIWUNmOm7Wl9lYLEhVFj2LL2rn0QC8cH01Al3fZy6fvjDngAtpiocQ0L0uh94oe9Qty3nS4PwcNY9LMLeOfnQu4iHAGwyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384514; c=relaxed/simple;
	bh=TN4iB2CJGrf00fYoivIs8F3mcv13g9G1yoNmREgyI0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLqbcSo1oAFcFl16GYnxn/ncKu8zkSGl6RNtGjYRpAP2dAziQpHxUB30SCkAJCcgum/4nUxsXXxoZ3aRyq8dv2C7285mtmZHKw5kWKnA6vTgEawcy5vfIu0Xzi1kNrnmbJFG8aEZqFPjLXRuOtIM3NSWVr27ChrPooZs1KU/iEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdGJrebm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B55AC4CEE7;
	Mon, 13 Oct 2025 19:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760384513;
	bh=TN4iB2CJGrf00fYoivIs8F3mcv13g9G1yoNmREgyI0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdGJrebmezTWKGSpgumj7LiBG9RZrMcJlphUgq6ShxzzH8Wcdd4IVA+ZISQJkCofy
	 f0lHmzx9WsKVJrSMAX37Bw+O0ZyaDj+zCAJwT5TIqmn0bfI3ef3KSAfmnrlkMlXHK3
	 w5srV80rWymr9pr0Er+zXtUlIu5KWpax8LmkN+GYBxsTvojJudop+mXd0wtq71oT7C
	 tT66J0zzxPRlBln3a2hNMdGLuh9UjcYrt+fGnok7CuTLCQ9vGXKpjuR8lDwi+l7scs
	 4rCL2gFUDSFe1qV2DasKvIhzy3lQQ9Gyx3CFbXPfMKYF8MrcvS7WQscWQHCoBmJY6k
	 fJVQVSdpaXhFg==
Date: Mon, 13 Oct 2025 20:41:49 +0100
From: Conor Dooley <conor@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: add support for NXPs TJA1145
 CAN transceiver
Message-ID: <20251013-supplier-edition-0ffc88286b5d@spud>
References: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
 <20251013-tja1145-support-v3-1-4a9d245fe067@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gDq1zSAoM2zKWAOI"
Content-Disposition: inline
In-Reply-To: <20251013-tja1145-support-v3-1-4a9d245fe067@liebherr.com>


--gDq1zSAoM2zKWAOI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:19:18AM +0200, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> Adding documentation for NXPs TJA1145 CAN transceiver, which resides like
> the ti,tcan104x-can.yaml in the same directory as other generic PHY
> subsystem bindings. At the moment there is only support for simple PHYs
> by using regulator bindings in combination with can-transceiver.yaml or
> PHYs that implement the generic PHY subsystem like the NXP TJA1145.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  .../devicetree/bindings/phy/nxp,tja1145-can.yaml   | 79 ++++++++++++++++=
++++++
>  1 file changed, 79 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml b=
/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..3b81a2e1ead8452ed5fcf2021=
f33d628d4e12346
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/nxp,tja1145-can.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TJA1145 CAN transceiver
> +
> +maintainers:
> +  - Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: nxp,tja1145-can

I'd drop the -can here, since I don't think the device can be anything
else?

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 4000000
> +
> +  spi-cpha: true

Is this optionally cpha or always? I'd mark it required if it is always
needed for the device to function.

> +
> +  spi-cs-setup-delay-ns:
> +    minimum: 50
> +    default: 50
> +
> +  spi-cs-hold-delay-ns:
> +    minimum: 50
> +    default: 50
> +
> +  spi-cs-inactive-delay-ns:
> +    minimum: 250
> +    default: 250
> +
> +  vcc-supply:
> +    description:
> +      CAN transceiver supply voltage
> +
> +  vio-supply:
> +    description:
> +      Supply voltage for I/O level adaptor
> +
> +  vbat-supply:
> +    description:
> +      Battery supply voltage
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +
> +unevaluatedProperties: false

If the properties you've listed above from spi-peripheral-props are the
only ones suitable for the device, I think additionalProperties: false
is sufficient here.

Cheers,
Conor.

pw-bot: changes-requested

> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        can-phy@0 {
> +            compatible =3D "nxp,tja1145-can";
> +            reg =3D <0>;
> +            #phy-cells =3D <0>;
> +            spi-max-frequency =3D <4000000>;
> +            spi-cpha;
> +            spi-cs-setup-delay-ns =3D <50>;
> +            spi-cs-hold-delay-ns =3D <50>;
> +            spi-cs-inactive-delay-ns =3D <250>;
> +            vcc-supply =3D <&reg_5v0>;
> +            vio-supply =3D <&reg_3v3>;
> +            vbat-supply =3D <&reg_24v0>;
> +        };
> +    };
>=20
> --=20
> 2.39.5
>=20
>=20

--gDq1zSAoM2zKWAOI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO1V/QAKCRB4tDGHoIJi
0h2TAPoCuPTog2pckMDH53JpNnuwMSfjkLpKZLkadls23rdiuwEAjRbEuCE6RjC1
aOal4qmhslM7N0QDXfw58Aq3RHwJ7QA=
=cLzX
-----END PGP SIGNATURE-----

--gDq1zSAoM2zKWAOI--

