Return-Path: <linux-can+bounces-4336-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DC4B320DE
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 18:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203151BA7B48
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFDB3126B3;
	Fri, 22 Aug 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImHNmKrY"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF227FD4A;
	Fri, 22 Aug 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881729; cv=none; b=Qdqs9eIEOnQyuw9Wg524mwkn+aAsKYOKBtzOhsbxVIfIldjemJSZGr7eNq8H6eQTUIQ2s1yzBRmbb1vrp4yhxCusWld48vfGG2UpgfpBGFhFh0Q9QLc9rYsZyA/2/krnEGVPldp6iw/nvs8XCOHe2WirPpQLcd5WWGv0+dI+ipI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881729; c=relaxed/simple;
	bh=7g181+bcvmLk/IDiMD7z/zBWKVLYMZ0k6iVC20G+ROU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLer9vAtuaTn8Qy8cvmF/cnp4TQI9NQykoY7EfimIXssZ3SVl661M4AymXZ46JD1HB1X6bTFZlGuuMnomCUTRr/ZACAvlivJybOuadHwi+4+ClmfWZ3NO7lRdtoOsUeho3tVjit/BwxewNzSm6sL6HYk9Ps9z9ZAUae4oIbPFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImHNmKrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B93C4CEED;
	Fri, 22 Aug 2025 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881728;
	bh=7g181+bcvmLk/IDiMD7z/zBWKVLYMZ0k6iVC20G+ROU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImHNmKrYF8feUzVfNj1IWZo1oWQKNNbn3adjTQoB1nDREjxrrJUwJELiMyBlaqIL/
	 v6zubrgaab66AjgCvKChDKdkLevu7F63S9hi/fn/5N4SW4kw97wMMIfnzTss/54dmD
	 xjJADDAz6ldRqQdkK9w39f6HrEhYsnfZpy6SuUkFSiYDibUg5w9/uy5EV4GQeoYx6y
	 vDTphXQuMOR0x/TeuO5EmSio6vWckZDaZUieXz4d8Zxq93S/BXdGjHW800HeyDCcZv
	 XY4iacRP9+leHrAcB0ZqwWEmQAPMvAr65AjNjx48yTytmQpfuX7uMBJuC7RcFKMzzH
	 5PSKGfZAW8Bvw==
Date: Fri, 22 Aug 2025 17:55:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: phy: ti,tcan104x-can: Document NXP
 TJA1051/1048
Message-ID: <20250822-crop-ungreased-6494d68e388e@spud>
References: <20250822-can-v1-0-c075f702adea@nxp.com>
 <20250822-can-v1-1-c075f702adea@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LL4e6z1aL4fxQ/Er"
Content-Disposition: inline
In-Reply-To: <20250822-can-v1-1-c075f702adea@nxp.com>


--LL4e6z1aL4fxQ/Er
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 12:05:28PM +0800, Peng Fan wrote:
> The TJA1051 is a high-speed CAN transceiver which is a pin-compatible
> alternative for TI TCAN1043 with Sleep mode supported, and has a compatib=
le
> programming model, therefore use ti,tcan1043 as fallback compatible.
>=20
> The TJA1048 is a dual high-speed CAN transceiver with Sleep mode supporte=
d.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml   | 29 ++++++++++++++++=
+++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b=
/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 4a8c3829d85d3c4a4963750d03567c1c345beb91..de4ab204ec86f91e84eba8f1a=
6343ed137e5cd71 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -19,18 +19,21 @@ properties:
>            - enum:
>                - microchip,ata6561
>            - const: ti,tcan1042
> +      - items:
> +          - enum:
> +              - nxp,tja1051
> +          - const: ti,tcan1043
>        - enum:
>            - ti,tcan1042
>            - ti,tcan1043
> +          - nxp,tja1048
>            - nxp,tjr1443
> =20
> -  '#phy-cells':
> -    const: 0
> +  '#phy-cells': true
> =20
>    standby-gpios:
>      description:
>        gpio node to toggle standby signal on transceiver
> -    maxItems: 1

Please put the outtermost constraints here and narrow it down in the
else.

> =20
>    enable-gpios:
>      description:
> @@ -53,6 +56,26 @@ required:
>    - compatible
>    - '#phy-cells'
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,tja1048
> +
> +    then:
> +      properties:
> +        '#phy-cells':
> +          const: 1
> +        standby-gpios:
> +          maxItems: 2
> +    else:
> +      properties:
> +        '#phy-cells':
> +          const: 0
> +        standby-gpios:
> +          maxItems: 1
> +
>  additionalProperties: false
> =20
>  examples:
>=20
> --=20
> 2.37.1
>=20

--LL4e6z1aL4fxQ/Er
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKig+gAKCRB4tDGHoIJi
0sReAP4445tmzdmWf3M79UC6PC+yh6cXgLj78yyz/06rdvDc2AEA1jcyL7+qJdVg
IM3RILZrUyw345YkF5EtQPKxBWu8dQM=
=tBaH
-----END PGP SIGNATURE-----

--LL4e6z1aL4fxQ/Er--

