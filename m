Return-Path: <linux-can+bounces-2792-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A8A311E1
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2025 17:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B81188B4B9
	for <lists+linux-can@lfdr.de>; Tue, 11 Feb 2025 16:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426AC255E42;
	Tue, 11 Feb 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4Y5yIHA"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1165924E4C3;
	Tue, 11 Feb 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291933; cv=none; b=YwzB6/7lXGVFYGWRIxyO4k2Kzxx19u6BTukawVWLR5RnHTX5lsCEOIbF5irp1jRYW+jldKC6UL9Nrguns21H5cM7t7W+aVNnUfL69/iyEl+Zs2x/iAykC4r7TchtnGr66U93zQD8VcdGXPZgY5yuPcJN3fjHIm+tAJnGfiLMRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291933; c=relaxed/simple;
	bh=khNbYEj7D+meq38dfaVMuGZU0JsnF5ZjDcTMSNnp4bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHFZzNObteHzg0uYees8JqWgGZBaMXl+putJWp3DypH07pjGB5rFqH2BXTl++7QmenzAIsSRBnT+a1B0Zcq7/7Oi/PqslXnZDLZEOHwzALqgFbp6KzyFuaN/uOmjJB2+4RcYdtpaxqkQYESftVsOApMi3uJOjsrXAZ9rQvtS83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4Y5yIHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB45BC4CEDD;
	Tue, 11 Feb 2025 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739291932;
	bh=khNbYEj7D+meq38dfaVMuGZU0JsnF5ZjDcTMSNnp4bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4Y5yIHAwlBfzEQ8PzbFlx5Biby5DSgJJphl+C2/mGotvbEIOimAYlmEaxeJyUOzJ
	 r0vnIpZCyUq/9vD7I7XiFR36e28c7atBw1lISQD5zQeAHLKJ7EGnV+71xPLHuUAzyK
	 JYIB50xG5vkpZ9FnOnMgHBrojgKy5PfEFpltHbMiyjsG5oovEfhVo0dd3McIe4v6LD
	 VOuD73EwVdt5O2LCA3nRzz8NfvImrmPH736N7TVjYTfaFXC6v5KKROcJCHvtUIQOTK
	 ZHZGdSfcMj24p6wt5jy3xovhdF+6ypkCz7nX7pDR2tji3qon4OCuDTJ4Dafa3S6aMz
	 6z3HRgkN9/+mg==
Date: Tue, 11 Feb 2025 16:38:48 +0000
From: Conor Dooley <conor@kernel.org>
To: dimitri.fedrau@liebherr.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Message-ID: <20250211-epidermis-crib-b50da209d954@spud>
References: <20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com>
 <20250211-flexcan-add-transceiver-caps-v1-1-c6abb7817b0f@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0M1rxEtOyDljmutQ"
Content-Disposition: inline
In-Reply-To: <20250211-flexcan-add-transceiver-caps-v1-1-c6abb7817b0f@liebherr.com>


--0M1rxEtOyDljmutQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 02:12:33PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> Currently the flexcan driver does not support adding PHYs. Add the
> capability to ensure that the PHY is in operational state when the link
> is set to an "up" state.
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b=
/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index 97dd1a7c5ed26bb7f1b2f78c326d91e2c299938a..397957569588a61111a313cf9=
107e29dacc9e667 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -70,6 +70,9 @@ properties:
>    xceiver-supply:
>      description: Regulator that powers the CAN transceiver.
> =20
> +  phys:
> +    maxItems: 1

Can all devices in this binding support external phy? Are all devices
limited to a single external phy?

> +
>    big-endian:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description: |
>=20
> --=20
> 2.39.5
>=20
>=20

--0M1rxEtOyDljmutQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6t9GAAKCRB4tDGHoIJi
0h+cAQCpb6VaOWlxOnR0WI9RvSnk8Rf0BtVOJZ+Y0f+FxVzUFgD/SECtzHai0eyN
ILxdtE4ExqVMeRAT3FugEv8foAjEMAo=
=vw34
-----END PGP SIGNATURE-----

--0M1rxEtOyDljmutQ--

