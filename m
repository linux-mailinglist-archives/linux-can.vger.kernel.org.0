Return-Path: <linux-can+bounces-1191-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183579509BA
	for <lists+linux-can@lfdr.de>; Tue, 13 Aug 2024 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8D5287819
	for <lists+linux-can@lfdr.de>; Tue, 13 Aug 2024 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F07A1A2556;
	Tue, 13 Aug 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbByNzIw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F51DDD1;
	Tue, 13 Aug 2024 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564941; cv=none; b=cGqFwS3C2QixL0J8Dmv+pw2x97yMSCahO3ZJRWV6+xDwK93yBIMqLU89hwbOVNnhn4dJhLFtq1uuHRtsUdLunJE5b2nPFhDvijLkt1xn53NJUu+WJH89lkZ/WOB7SjW9u2xUPhgzCvx/MhVmabNx6fFvcXjUD6nEqwUnsLB+Bzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564941; c=relaxed/simple;
	bh=heU3e+lgGe2K9h8SHjoXVlse01k5eF5nF+N9YHix9k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAYRhcxv4dxgyXozgrb0Vud3uzjm3Nzx3P/s1LJowlawh3vQSnHZtBRgQoQs/NDizrDM8ev+cexnI5W5btoWSD19kYHTBnGrtKEA6d1i35UCRwrwvvk3rf8d6SNv4KXiZDz5wB14ruBTqt5PerN0iCWe6FgldufV+XHD7hOK+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbByNzIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE88BC4AF09;
	Tue, 13 Aug 2024 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564940;
	bh=heU3e+lgGe2K9h8SHjoXVlse01k5eF5nF+N9YHix9k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pbByNzIwsEGuHe8fmU3XukBHbtOm+y+ja9Oebt7wtU4oSivdGnjxLJEGN3uLiKL5x
	 gsKHTRVOgIXfIzKOQR2agpACdzz1Ezd+l8U1/aK5MukeZrKDvFrlqf7JpW6CEqmqwK
	 ab8RJ3wucnU9I8CnWwFInJ6zGmO4XD7cBw2uVzrg+8lSCUKz2WqvkSzmp+Gs1thyJ4
	 vWbmGWLspgF7wcwa6lqZpCQO+bNy7x1XUeh9MDT5dcnWzv4AgQGPQeqXXADLg4UrbT
	 iTUQokm/9OfzdIpSpPRVjqJlukrbuNk2naHkQh8U6qgixckrU0zAhhfwr+tW6cg9gd
	 rPM0UXGUM5+DQ==
Date: Tue, 13 Aug 2024 17:02:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: can: convert microchip,mcp251x.txt to
 yaml
Message-ID: <20240813-distant-plastic-6534f660376c@spud>
References: <20240812211625.3835600-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1mgxfAj48UD1hYzJ"
Content-Disposition: inline
In-Reply-To: <20240812211625.3835600-1-Frank.Li@nxp.com>


--1mgxfAj48UD1hYzJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 05:16:24PM -0400, Frank Li wrote:
> Convert binding doc microchip,mcp251x.txt to yaml.
> Additional change:
> - add ref to spi-peripheral-props.yaml
>=20
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dtb: /bus@5a000000/s=
pi@5a020000/can@0:
> 	failed to match any schema with compatible: ['microchip,mcp2515']
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/net/can/microchip,mcp251x.txt    | 30 --------
>  .../bindings/net/can/microchip,mcp251x.yaml   | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/can/microchip,m=
cp251x.txt
>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,m=
cp251x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.=
txt b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
> deleted file mode 100644
> index 381f8fb3e865a..0000000000000
> --- a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -* Microchip MCP251X stand-alone CAN controller device tree bindings
> -
> -Required properties:
> - - compatible: Should be one of the following:
> -   - "microchip,mcp2510" for MCP2510.
> -   - "microchip,mcp2515" for MCP2515.
> -   - "microchip,mcp25625" for MCP25625.
> - - reg: SPI chip select.
> - - clocks: The clock feeding the CAN controller.
> - - interrupts: Should contain IRQ line for the CAN controller.
> -
> -Optional properties:
> - - vdd-supply: Regulator that powers the CAN controller.
> - - xceiver-supply: Regulator that powers the CAN transceiver.
> - - gpio-controller: Indicates this device is a GPIO controller.
> - - #gpio-cells: Should be two. The first cell is the pin number and
> -                the second cell is used to specify the gpio polarity.
> -
> -Example:
> -	can0: can@1 {
> -		compatible =3D "microchip,mcp2515";
> -		reg =3D <1>;
> -		clocks =3D <&clk24m>;
> -		interrupt-parent =3D <&gpio4>;
> -		interrupts =3D <13 IRQ_TYPE_LEVEL_LOW>;
> -		vdd-supply =3D <&reg5v0>;
> -		xceiver-supply =3D <&reg5v0>;
> -		gpio-controller;
> -		#gpio-cells =3D <2>;
> -	};
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.=
yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.yaml
> new file mode 100644
> index 0000000000000..789545b6c669a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.yaml

Filename matching a compatible please.

> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/can/microchip,mcp251x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP251X stand-alone CAN controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp2510
> +      - microchip,mcp2515
> +      - microchip,mcp25625
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that powers the CAN controller.
> +
> +  xceiver-supply:
> +    description: Regulator that powers the CAN transceiver.
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        can0: can@1 {

The label here is not used and should be dropped.

Otherwise, looks good to me.

Thanks,
Conor.

> +             compatible =3D "microchip,mcp2515";
> +             reg =3D <1>;
> +             clocks =3D <&clk24m>;
> +             interrupt-parent =3D <&gpio4>;
> +             interrupts =3D <13 IRQ_TYPE_LEVEL_LOW>;
> +             vdd-supply =3D <&reg5v0>;
> +             xceiver-supply =3D <&reg5v0>;
> +             gpio-controller;
> +             #gpio-cells =3D <2>;
> +        };
> +    };
> +
> --=20
> 2.34.1
>=20

--1mgxfAj48UD1hYzJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZruDhwAKCRB4tDGHoIJi
0jCJAQDK0XmyAuShyMNkF6eWhwtO6Z1aZ1Qovf/60mTCFiCWZgD+IllneA7wU7n6
EQKqolgIHYG76wOD9T8bv7O2ePuT9Qk=
=p2lO
-----END PGP SIGNATURE-----

--1mgxfAj48UD1hYzJ--

