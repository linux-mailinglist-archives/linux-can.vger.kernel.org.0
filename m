Return-Path: <linux-can+bounces-1480-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054AE97619B
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 08:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDCE2839EC
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 06:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D0A18BC1A;
	Thu, 12 Sep 2024 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MiShd/+q"
X-Original-To: linux-can@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60376025;
	Thu, 12 Sep 2024 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123036; cv=none; b=iKH+Cnp7jqzSF1aLj8ZSzWl2a/7WHtpDBg43FBb/Bz5XJZImBAbZJZbQi3nHWkOJ+08+O+kCDNjppNRF/InPl8lbadhBASkGeiaILleaD9SEULct6RPw/67riYweogGzsFrA9psLwZhj21sNNfrODC2MptC9urAO2x161IWOzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123036; c=relaxed/simple;
	bh=SU09P/N+FU06lHPPT9dW6yBaIR6NBJ/GB0UO74Le92s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB2lICCSruc5OjP7IcA5o+90XSUmA+hZgmL65shvrHZ17aHxgt53Fx7w2T8PALmZ9wW27R0nkW49eG+PJqQlv5Jk6nQ95QhH540LnUXGFqpohwG2nBeoRW1xSfQrN8zLUhH/1d/Wdc05CZAJ8Q2XrjFjriU9cxmmaBD29Gkmk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MiShd/+q; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726123034; x=1757659034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SU09P/N+FU06lHPPT9dW6yBaIR6NBJ/GB0UO74Le92s=;
  b=MiShd/+qx9OH43ZyuKzg2oZtri9JbVezY3gPQYr8ZalAB+Jm+f3iYk3l
   YMqL2uNAZWn4qWzhDXfjpMT4sbtXB/wEH3vnmEG1kpVCjdi5AduUiis+g
   wZh20uZLHSguAzLLkVQK5ek3CsYDwCqI9sFhwdeud8NDQvDY3CWTAVL7P
   rEStcTf/ZgaLg3N+P+zfsQceebYbaXMbsU4VQ2dGCg6UGuRoFLcjb8g/W
   S6Y8yzP9CVkcZ9VAQ6+FXO87P4JQbtyA7qZs/igdeh2fGQLQE6c1trU2+
   dtvPW8YHS6dvKENty5/kojxV7GCqw+HZ36GmmfwylPhCQXED5bYNjBM8W
   A==;
X-CSE-ConnectionGUID: SF6Mom6KSPO+4b8Pq1TERA==
X-CSE-MsgGUID: 1HQHhiWbRS2jPXC7Yoajuw==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="asc'?scan'208";a="199114207"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 23:37:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 23:37:12 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Sep 2024 23:37:10 -0700
Date: Thu, 12 Sep 2024 07:36:37 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Charan Pedumuru <charan.pedumuru@microchip.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	<linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: net: can: atmel: Convert to json schema
Message-ID: <20240912-pushup-shaky-f0980435caf3@wendy>
References: <20240912-can-v1-1-c5651b1809bb@microchip.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fawzaBO9W7nNBNRn"
Content-Disposition: inline
In-Reply-To: <20240912-can-v1-1-c5651b1809bb@microchip.com>

--fawzaBO9W7nNBNRn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:19:16AM +0530, Charan Pedumuru wrote:
> Convert atmel-can documentation to yaml format
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>

Please see the comments I left on the internal v2 of this patch.

Thanks,
Conor.

> ---
>  .../bindings/net/can/atmel,at91sam9263-can.yaml    | 67 ++++++++++++++++=
++++++
>  .../devicetree/bindings/net/can/atmel-can.txt      | 15 -----
>  2 files changed, 67 insertions(+), 15 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-=
can.yaml b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.=
yaml
> new file mode 100644
> index 000000000000..269af4c993a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/atmel,at91sam9263-can.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel CAN Controller
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - atmel,at91sam9263-can
> +          - atmel,at91sam9x5-can
> +          - microchip,sam9x60-can
> +      - items:
> +          - enum:
> +              - microchip,sam9x60-can
> +          - const: atmel,at91sam9x5-can
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: can_clk
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: can-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,sam9x60-can
> +    then:
> +      required:
> +        - compatible
> +        - reg
> +        - interrupts
> +        - clocks
> +        - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    can0: can@f000c000 {
> +          compatible =3D "atmel,at91sam9x5-can";
> +          reg =3D <0xf000c000 0x300>;
> +          interrupts =3D <30 IRQ_TYPE_LEVEL_HIGH 3>;
> +    };
> diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt b/Do=
cumentation/devicetree/bindings/net/can/atmel-can.txt
> deleted file mode 100644
> index 218a3b3eb27e..000000000000
> --- a/Documentation/devicetree/bindings/net/can/atmel-can.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -* AT91 CAN *
> -
> -Required properties:
> -  - compatible: Should be "atmel,at91sam9263-can", "atmel,at91sam9x5-can=
" or
> -    "microchip,sam9x60-can"
> -  - reg: Should contain CAN controller registers location and length
> -  - interrupts: Should contain IRQ line for the CAN controller
> -
> -Example:
> -
> -	can0: can@f000c000 {
> -		compatible =3D "atmel,at91sam9x5-can";
> -		reg =3D <0xf000c000 0x300>;
> -		interrupts =3D <40 4 5>
> -	};
>=20
> ---
> base-commit: 32ffa5373540a8d1c06619f52d019c6cdc948bb4
> change-id: 20240912-can-8eb7f8e7566d
>=20
> Best regards,
> --=20
> Charan Pedumuru <charan.pedumuru@microchip.com>
>=20

--fawzaBO9W7nNBNRn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuKL8AAKCRB4tDGHoIJi
0t9CAP0SdR9OtPTrKWLG8ZfJgmtnwlP9n9OKm4E4tJAAWZOncwEAttpdCT2WsNy9
8GnsssxR3tYA3aqoSkW5rH0gXCmW6ww=
=0Z9k
-----END PGP SIGNATURE-----

--fawzaBO9W7nNBNRn--

