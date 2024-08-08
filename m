Return-Path: <linux-can+bounces-1178-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D8C94C1D1
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 17:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9F24B2681D
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951E218FDA6;
	Thu,  8 Aug 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfS1VluF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12618FC93;
	Thu,  8 Aug 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132099; cv=none; b=sZMYDAAn1E4ckvg0j/5KbRH8qlfF+inUjQPM9ZxXQUhmfRQmiHTB1letLK6JIIPqwWtKjHtWHlVnNIc2nnces4ComJVD9VgjEJipWgi1abrYSJO7XeeNs5Kb+VnWhDjDda8Wbyc/2LIA+8UUdPomkloEHIYclPfszXIGLptXxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132099; c=relaxed/simple;
	bh=LGQaDws2R6YDe+LE/QWfXHcmATfrM492U4rphHVB1Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIdzteg9uawn/PLEktmaSpa+OOhnySTiMQreVUXQ6vywn5A+aF+FaAk8wCz2S0OQgDBassRLCVrRBUPL0X8APLhZD1nCKNoEyifORh/G307zblx2iz99OYZyAyQtRDr+9yJ8oGcZsojtqSunSLhDKANSBbXkhMxlObP5ufV2uH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfS1VluF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E409C32782;
	Thu,  8 Aug 2024 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723132098;
	bh=LGQaDws2R6YDe+LE/QWfXHcmATfrM492U4rphHVB1Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfS1VluF4yyTx2lYEtwJQ7GCbKwFEW41kHIfoG7zTx9LHZfCAd9OqsCoHebbLH8Jw
	 wIi5MqaUJRCHZQoGFC1DDu4hcBoMn68p1+hgS+zSZCROOLjaFasE3KZZ5598jWjJU+
	 LeWcQ+WbtjfW2uwQUIrBjkNgm++cime5f2jZIKLL1M3/g0DbWbvxbTnZSOwxtT191q
	 OFlPag20JUv96jSap9pyhYZMrAwAfKAeIJGSXH2Uu7ndh4KOlEqtPnOuL/f/JSb145
	 PMOFoAWWoOsEzY/1LbUjoIrOXo4hgmeX+t6N0xtC2B96Bou8NnKKJsgt6xVeNLIdjK
	 aYB/lWyYQO9CQ==
Date: Thu, 8 Aug 2024 16:48:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Ilya Orazov <ilordash02@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6561
Message-ID: <20240808-caucasian-cartridge-f728ed4982cd@spud>
References: <20240807180210.1334724-2-ilordash02@gmail.com>
 <20240807180956.1341332-1-ilordash02@gmail.com>
 <20240807180956.1341332-2-ilordash02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QnEpDUSyh44tmswU"
Content-Disposition: inline
In-Reply-To: <20240807180956.1341332-2-ilordash02@gmail.com>


--QnEpDUSyh44tmswU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 09:09:56PM +0300, Ilya Orazov wrote:
> Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
> It is pin-compatible with TI TCAN1042 and has a compatible programming
> model, therefore use ti,tcan1042 as fallback compatible.
>=20
> Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b=
/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 79dad3e89aa6..f6f1fd843874 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -14,10 +14,15 @@ properties:
>      pattern: "^can-phy"
> =20
>    compatible:
> -    enum:
> -      - nxp,tjr1443
> -      - ti,tcan1042
> -      - ti,tcan1043
> +    oneOf:
> +      - items:
> +        - enum:
> +          - microchip,ata6561
> +        - const: ti,tcan1042
> +      - enum:
> +          const: ti,tcan1042
> +          const: ti,tcan1043
> +          const: nxp,tjr1443

The enum doesn't need the "const:s", just a "-", hence the bot
complaining.

--QnEpDUSyh44tmswU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrTovgAKCRB4tDGHoIJi
0qexAP4qBwVjLrfdjcWcHp0z0iuokytwqiwpClLFlWIPv5uIIAD/Z0QqnlccIfdk
AUSp0QtDDJLAbtjBwCkroY6vSBQg6wA=
=7lOE
-----END PGP SIGNATURE-----

--QnEpDUSyh44tmswU--

