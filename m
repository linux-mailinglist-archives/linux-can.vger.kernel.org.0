Return-Path: <linux-can+bounces-1494-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ED2976408
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 10:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55F1286A69
	for <lists+linux-can@lfdr.de>; Thu, 12 Sep 2024 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8848A1917E9;
	Thu, 12 Sep 2024 08:06:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075AF1917EC
	for <linux-can@vger.kernel.org>; Thu, 12 Sep 2024 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128393; cv=none; b=FxarzmGJQDzu5okDNeoGxDmiE0FZ9w7vSvFECYo3qe5uRLURFvKAiyKEMKH0p+zGj9FWUtUjB2r3okVKfBJVVu7n7fyEu5+YI5gAKAfTSw8HBXOzwLhCDxr3j1rvYRySNAMBLGoM38tMfHYjO+ityTNfbvOvwkWiBCpJxvSi5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128393; c=relaxed/simple;
	bh=yo6ClgrrYtZtJj0pgLHxHUjiwKMsQVS4UyGqBqyc2Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0aIPPFpwNB0P7SwNa20pL70ncaDiRjV/cTiiM8AaDmgE1jMBzD8F4EN5KvVy4jLmT85yyeMba8cY8lpSG176qpH/OMZwb1z1kZ6Ns+PuRnHZp+j6D1UOgf5Y2aidSLvdtmMwgaFbCGlVrBx36Z0suMPa68gUMX9ID56VD4GsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeqA-0004AS-FW; Thu, 12 Sep 2024 10:06:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq7-007KiX-Rx; Thu, 12 Sep 2024 10:06:07 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E4905338DC1;
	Thu, 12 Sep 2024 07:35:27 +0000 (UTC)
Date: Thu, 12 Sep 2024 09:35:27 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Charan Pedumuru <charan.pedumuru@microchip.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: atmel: Convert to json schema
Message-ID: <20240912-literate-caped-mandrill-4c0c9d-mkl@pengutronix.de>
References: <20240912-can-v1-1-c5651b1809bb@microchip.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orv67sewbwknpnrd"
Content-Disposition: inline
In-Reply-To: <20240912-can-v1-1-c5651b1809bb@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--orv67sewbwknpnrd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.09.2024 11:19:16, Charan Pedumuru wrote:
> Convert atmel-can documentation to yaml format
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
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

The driver doesn't have a compatible for "microchip,sam9x60-can".

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

AFAICS clock-names is required for all compatibles.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    can0: can@f000c000 {

I think unused labels should be removed.

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
>=20
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--orv67sewbwknpnrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbimbwACgkQKDiiPnot
vG+igQf7BhUphCaYd67/BKLQBNIguPGy39T5kQzPkdg/QflMpcz6bSZQXYsvyguA
GsRPQcDt7APYW7tTpTnIa0ZNlYj+lF7cWPl9afS90kk4kRAPPvSYb9Vd2UAMjsPt
m/jhQsupujHXJg8m2REBHmB0npIGoHuL+kqg0qRIIucFWs0jgsMPG6C11e/QiFtQ
ArgNdeuIsS7DUqKNXy9eb43tnRSomQkn4M1NojRVKSmAuzMrvheHmKA2mQOLJ2Or
4JRvI/oRZsbx1KBxqID2y/NMb9pk7TbVw6gZnTLJcYKg5GmhXuIbPIP3RZ6eWnB4
8h+/7/1vWZlVuhVrFKzyXj9OfBiIyQ==
=50PA
-----END PGP SIGNATURE-----

--orv67sewbwknpnrd--

