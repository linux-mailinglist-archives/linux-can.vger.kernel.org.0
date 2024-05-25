Return-Path: <linux-can+bounces-681-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C88CEFF1
	for <lists+linux-can@lfdr.de>; Sat, 25 May 2024 17:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD8B1C204D6
	for <lists+linux-can@lfdr.de>; Sat, 25 May 2024 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07134BAA6;
	Sat, 25 May 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyUxLVqb"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8AC85628;
	Sat, 25 May 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716652342; cv=none; b=GqP8umVACdSKu3MPJjyLrnCWEWMSvzOXqaIc/BXyfO2DnewHMtvQxzJ5tX9juqrnLHT0D+pWugDf0wm3btK86S/+9loZeeThjBaWPg0tH3vMpKexBXSeioiPwsmUpwOVTrdr75c+VTlib6CHzn7SU65eoqXxJOk36WEUclNYprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716652342; c=relaxed/simple;
	bh=2qvfe4Hqy1g41g1MNI1wwUBi2pgt//ZFn04XX9hGjVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g45rkHv3gG9C5rsBnysurGx7I9C8cuQ21qGGjKG6+lZCk6UfdQu9TtP3mk1z/6mguk194rLzxkd8+bSCd/7iD6+TbZRvOqUPKYXrMD9avFs7PTvZFmpPLW/7gbr2bqI4FIaQQX/NYwJqsHcZSNMBuxvHBupAw3PcP9CqWUfun7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyUxLVqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0016C2BD11;
	Sat, 25 May 2024 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716652342;
	bh=2qvfe4Hqy1g41g1MNI1wwUBi2pgt//ZFn04XX9hGjVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RyUxLVqbnr66RHDchWK1j9fcjgjOUbNBdfzUnplaSXjNXdIxRk2Kzz7x7q7tR31hg
	 7llkAV+pzz6y2aUcVCT5qvl6J0Hb8NIqVAYK5yJ9StvuzBt/+lYo99oexZbtZnQWyK
	 CIb/u9d/+yWhmdAtvYvxQaT3T9PZJKx7ZNqcgyW23HEnCM3VCYluXepj4aM0Y7O2SX
	 kxHgr4zV2rQbEbSsHYBBos+TnUGTKrkCPupik65vrCjb7zIrmNlZ3KfrMaU2FeCLf/
	 uNtNVxHYBXkgctSHG0QE+kAqqV5j219gk/M/v6W8aCzseDiP3z7M4QvI4dlQTfVXyS
	 Ga6u+ge/bMyYw==
Date: Sat, 25 May 2024 16:52:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
	Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] dt-bindings: can: m_can: Add wakeup-source property
Message-ID: <20240525-outdated-unopposed-857d30708413@spud>
References: <20240523075347.1282395-1-msp@baylibre.com>
 <20240523075347.1282395-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nfBgOn45vCwmUCoC"
Content-Disposition: inline
In-Reply-To: <20240523075347.1282395-2-msp@baylibre.com>


--nfBgOn45vCwmUCoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 09:53:41AM +0200, Markus Schneider-Pargmann wrote:
> m_can can be a wakeup source on some devices. Especially on some of the
> am62* SoCs pins, connected to m_can in the mcu, can be used to wakeup
> the SoC.
>=20
> This property defines on which devices m_can can be used for wakeup.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b=
/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index f9ffb963d6b1..33f1688ca208 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -118,6 +118,10 @@ properties:
>    phys:
>      maxItems: 1
> =20
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: This device is capable to wakeup the SoC.

It seems to me like patch 1 & 2 should be squashed, with "wakeup-source"
depending on the correct pinctrl setup?

--nfBgOn45vCwmUCoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlIJLwAKCRB4tDGHoIJi
0romAQCU+ufTErbUDP+o6575ok++8ihKyYxbBj8T5Nwl6VZJHAEA8xmFsrpPwQOV
YAip06pvaKrUzD5redLLLU+5MWfopwk=
=rATI
-----END PGP SIGNATURE-----

--nfBgOn45vCwmUCoC--

