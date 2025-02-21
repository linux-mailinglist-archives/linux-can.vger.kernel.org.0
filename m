Return-Path: <linux-can+bounces-2928-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BBDA3FE05
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 18:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3DAF7AB531
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4724F599;
	Fri, 21 Feb 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaeMKIK8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76C36AF5;
	Fri, 21 Feb 2025 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160429; cv=none; b=gikERCAjuidneirWq18/ipIME42madpPLapQQtVc2/ghftktBunSNF57zmk8/heOMSO90Bx6jaA9hH40rIl53xQ8fUHEIwVnIYJuFr1DCzUq6PJVv06TclB01l50PgYtFsipvZMAczTklX/PeWO2ipBlXmV/9s8SdudvPcbYsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160429; c=relaxed/simple;
	bh=AhfLsUYs81ln+JUI7FebmZbguccwKwkjJcb8hxjBs0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJPGRBHUnS7RVDzkySX6twFYlZg5bUpIsglBO0ucaY04FS+7UXTUJMRoEc930+hRQd4Kprq1ztjJ3tOny0kPJ9REiC6CYWBYWG9dmmidpvrVTezZQVMtQYKRVCvR1PiHOdWAmG+QIwfYVZ1GNnbzNSZpzWvGlufjEkvp7qXESk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaeMKIK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5E7C4CED6;
	Fri, 21 Feb 2025 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740160428;
	bh=AhfLsUYs81ln+JUI7FebmZbguccwKwkjJcb8hxjBs0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaeMKIK8nBlO67jR2mzQXmY9bIbPr/WjudVzFsxW8OrLTP/U0nhcDI+aMXa1OXZaR
	 LOsC1AgSUuyZtTV2jbat7aAgfjCj3/1c25PT0ggdjpVKQr3Gvwh+27Fa6q49xn6tLk
	 76xB751Ga4lM0zBwsZ0qu0MF+yUtRtDC9WU6kwD3rScHmQuEfZUcABlCpMSlOhzo2d
	 sqL6OUJHNmOWi8fBqQKxZLjnkHn+y44tZPNX0f/OPiX+iU426YqNAQlPZfCbbiPXvG
	 weTca1NP9p7scbT+DalBKVodzL1VLurqpB9qmyDctdq5yYVAmUZ3IIHWWY9GHXOK0y
	 f/xDZDBRKwKyA==
Date: Fri, 21 Feb 2025 17:53:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Simon Horman <horms@kernel.org>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3E support
Message-ID: <20250221-childlike-deepen-8daa4513d5b5@spud>
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
 <20250220130427.217342-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cehEN5ozafK3t6/Z"
Content-Disposition: inline
In-Reply-To: <20250220130427.217342-3-biju.das.jz@bp.renesas.com>


--cehEN5ozafK3t6/Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 01:04:18PM +0000, Biju Das wrote:
> Document support for the CAN-FD Interface on the RZ/G3E (R9A09G047) SoC,
> which supports up to six channels.
>=20
> The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
> and RZ/G2L, but differs in some hardware parameters:
>  * No external clock, but instead has ram clock.
>  * Support up to 6 channels.
>  * 20 interrupts.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * No change.
> ---
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 67 +++++++++++++++++--
>  1 file changed, 62 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
=2Eyaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index f87f90f431e5..189d5303ad75 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -42,6 +42,8 @@ properties:
>                - renesas,r9a07g054-canfd    # RZ/V2L
>            - const: renesas,rzg2l-canfd     # RZ/G2L family
> =20
> +      - const: renesas,r9a09g047-canfd     # RZ/G3E
> +
>    reg:
>      maxItems: 1
> =20
> @@ -59,6 +61,19 @@ properties:
>            - description: CAN1 error interrupt
>            - description: CAN1 transmit interrupt
>            - description: CAN1 transmit/receive FIFO receive completion i=
nterrupt
> +          - description: CAN2 error interrupt
> +          - description: CAN2 transmit interrupt
> +          - description: CAN2 transmit/receive FIFO receive completion i=
nterrupt
> +          - description: CAN3 error interrupt
> +          - description: CAN3 transmit interrupt
> +          - description: CAN3 transmit/receive FIFO receive completion i=
nterrupt
> +          - description: CAN4 error interrupt
> +          - description: CAN4 transmit interrupt
> +          - description: CAN4 transmit/receive FIFO receive completion i=
nterrupt
> +          - description: CAN5 error interrupt
> +          - description: CAN5 transmit interrupt
> +          - description: CAN5 transmit/receive FIFO receive completion i=
nterrupt
> +        minItems: 8
> =20
>    interrupt-names:
>      oneOf:
> @@ -74,15 +89,33 @@ properties:
>            - const: ch1_err
>            - const: ch1_rec
>            - const: ch1_trx
> +          - const: ch2_err
> +          - const: ch2_rec
> +          - const: ch2_trx
> +          - const: ch3_err
> +          - const: ch3_rec
> +          - const: ch3_trx
> +          - const: ch4_err
> +          - const: ch4_rec
> +          - const: ch4_trx
> +          - const: ch5_err
> +          - const: ch5_rec
> +          - const: ch5_trx
> +        minItems: 8
> =20
>    clocks:
>      maxItems: 3
> =20
>    clock-names:
> -    items:
> -      - const: fck
> -      - const: canfd
> -      - const: can_clk
> +    oneOf:
> +      - items:
> +          - const: fck
> +          - const: canfd
> +          - const: can_clk
> +      - items:
> +          - const: fck
> +          - const: ram_clk
> +          - const: can_clk
> =20
>    power-domains:
>      maxItems: 1
> @@ -173,7 +206,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,rzg2l-canfd
> +            enum:
> +              - renesas,r9a09g047-canfd
> +              - renesas,rzg2l-canfd
>      then:
>        properties:
>          resets:
> @@ -187,6 +222,19 @@ allOf:
>        required:
>          - reset-names
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g047-canfd
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 20
> +
> +        interrupt-names:
> +          maxItems: 20

Should these be minItems instead of maxItems? The list has 20 elements
at the moment (right?) so you're not adding any restriction here.

> +
>    - if:
>        properties:
>          compatible:
> @@ -219,6 +267,15 @@ allOf:
>        patternProperties:
>          "^channel[4-7]$": false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g047-canfd
> +    then:
> +      patternProperties:
> +        "^channel[6-7]$": false
> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.43.0
>=20

--cehEN5ozafK3t6/Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7i9pwAKCRB4tDGHoIJi
0vbwAQClFPXZwni1ExsohSXdUXRb/iDkix2olv0zaC6TuTqTtgD/Rjt7hKzBAEAJ
tBj2+gW11qB7pkfw7ZTcW4LNJHnHQAw=
=fVJj
-----END PGP SIGNATURE-----

--cehEN5ozafK3t6/Z--

