Return-Path: <linux-can+bounces-2926-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A39A3FC85
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 18:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5E27A7C50
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974622A4C7;
	Fri, 21 Feb 2025 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlwtvUw8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1B215186;
	Fri, 21 Feb 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157161; cv=none; b=Rm/VZKemwFSZfjm/enqDIGf+VquH2en3vbm09jIj9qPlL1noGZHT6bZgp8QvVdrHQ/Rli0jqEpEKzwl5Qc4BAhOcJMln+wDZl9eSoQpyF3jARlpU1mKZSPM+fCPFJ6YPfDliyveeqCW/0S9HQuabEPiwcWfekR/bGkzuFGwZ2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157161; c=relaxed/simple;
	bh=eZGIz409g07Cawfaj6EDBblSb/BHdiA3+F5srYv87a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB8s1uLHws+4WNBMYpkwLix7QnOAbfIysGF7hn9P8vG1O8V+RualPL6lhITvzwS6eTFdANXtmPo4HyUIDLDDqJqTZWShdoQ5C8N4Yw2oUTfsfTyfXM8v4EbKj9q98tVmi6Ne+FORzLy3wmB+J7pYbUg/yMPy8TBl0Gj+dNUuI7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlwtvUw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD51CC4CED6;
	Fri, 21 Feb 2025 16:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740157160;
	bh=eZGIz409g07Cawfaj6EDBblSb/BHdiA3+F5srYv87a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QlwtvUw8Dl1WPUHN3yXu4AGTPUteJ69ga1uuyaytf41Hximkg2xNQhp9n+D5IzWMu
	 ae69M2D80RRQ+xr3Rbu0phiJhXVI5ljd+A/aHD+rDrGvK+s/v7uS1QthC2m+Ub0VlW
	 zKm+C/55KjkZen2s2pgQs218wWsaSkFdI7iJ1BoXqpZ8p382MdO9seAX4DpJW2BBdG
	 yWo5Deizbk653UPyvzx0ZcehRexg9Y/MeHSatoDocriGps+wz/M4OuNcFrX1wtijYO
	 1Wuss1HsUdIYND1vlUQdgiV/R6DRFdye/5Z9HL0u2kZ7ac7yqGf+9HJE9UiufOxMTq
	 rXfMrvIjT2Acw==
Date: Fri, 21 Feb 2025 16:59:16 +0000
From: Conor Dooley <conor@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Message-ID: <20250221-drinking-tantrum-6e0bf9051160@spud>
References: <20250221-flexcan-add-transceiver-caps-v3-0-a947bde55a62@liebherr.com>
 <20250221-flexcan-add-transceiver-caps-v3-1-a947bde55a62@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oeo8jN3jmqo3xz+Z"
Content-Disposition: inline
In-Reply-To: <20250221-flexcan-add-transceiver-caps-v3-1-a947bde55a62@liebherr.com>


--oeo8jN3jmqo3xz+Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 08:40:04AM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> Currently the flexcan driver does only support adding PHYs by using the
> "old" regulator bindings. Add support for CAN transceivers as a PHY.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  .../devicetree/bindings/net/can/fsl,flexcan.yaml          | 15 +++++++++=
++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b=
/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index 73252fe56fe6c8e9fd19142208bb655dc86d47cd..81125883cf86b9d19616bde37=
8f74bdb6a32f1b2 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -77,6 +77,9 @@ properties:
>    xceiver-supply:
>      description: Regulator that powers the CAN transceiver.
> =20
> +  phys:
> +    maxItems: 1
> +
>    big-endian:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description: |
> @@ -171,6 +174,18 @@ allOf:
>          interrupts:
>            maxItems: 1
>          interrupt-names: false
> +  - if:
> +      required:
> +        - xceiver-supply
> +    then:
> +      properties:
> +        phys: false
> +  - if:
> +      required:
> +        - phys
> +    then:
> +      properties:
> +        xceiver-supply: false

The duplication here is not needed, they both will cause errors in the
same situation. With one dropped,
Acked-by: Conor Dooley <conor.dooley@microchip.com>


--oeo8jN3jmqo3xz+Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7iw5AAKCRB4tDGHoIJi
0sEeAQDF7cziCH3YgU2Q1pWw4hwxu21/XtwYMmNSx6V9te9dYgEA+6keZnuZ3EXE
Eqeod0gZy3vGEUWf4utVpEapgWZj8Ak=
=vebm
-----END PGP SIGNATURE-----

--oeo8jN3jmqo3xz+Z--

