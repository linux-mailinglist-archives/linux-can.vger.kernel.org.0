Return-Path: <linux-can+bounces-3023-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF1DA56CBE
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 16:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4257A173192
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47122206A7;
	Fri,  7 Mar 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rD3JLEEc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD521E0BA;
	Fri,  7 Mar 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362984; cv=none; b=l61baK3Qe1GMHWnwzj7ny5kXhovrRw9JEUTxhfypLoasy6USw1P/eRcPGYQLELIw3K0HKh0Db+jvcZiN/b0NpjNf52W0i8ZYlukXe0/exIp+nOeiiQ9V78N07ze2PJKbOlpsUfNeD0DgzeXl5gZG0L8Yokb4DrsUZmDuag4eJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362984; c=relaxed/simple;
	bh=ZbL34hW/27gh68ZRT0ugYFZcKY9WnAmuyG/G7jaVWmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6IvAhb+h4suKFruQqhiSOt+DUnwckQie1KrDlj8iyNjiJ0aUu9mOmkcM6BHQ1hZoz5EJ84krNJRPBKtBOHDiO/X94fElO1WobL5FOaCm3ZcKlWAmDHEALBtZVlBLf40F1tJOj5i14RcBBDdoHhWxi8bUos3Ov1t0mUxvYmzIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rD3JLEEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA02C4CED1;
	Fri,  7 Mar 2025 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741362984;
	bh=ZbL34hW/27gh68ZRT0ugYFZcKY9WnAmuyG/G7jaVWmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rD3JLEEcm40zrCG8Ym/lLoA7Lawl1zLgd4HtvGwPQ04n+NfYHluLZGBwBsZxk5lIs
	 L/Fwh9dA6fGjnv4OHmlgoh4mr2PH+UIQdvXspQtsP0WkMqXxMwlT1NxAl+KuuG2N3N
	 VBvhcQbZ6adZo9kcQeEAj0+SC9C10ScoU5V5hVC8Pn5fUa0rOHATZUN0hc1aOah5X/
	 M46N4kfM4MY90JI6ajG47sgP35rdAthZh3aUKsmkd0KaFfp25jiCtqyKt8MqK6tfkt
	 Qms8L9wgG4Ot0sri6KYbiA3FLyexrQ0tIDXoHX6/yWchB/lMuzj0elXWrmlI+z8rH1
	 9xrWK4XwzwGcQ==
Date: Fri, 7 Mar 2025 15:56:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX94 support
Message-ID: <20250307-catwalk-handiwork-5f2d11b60d85@spud>
References: <20250306171032.243954-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iGmX26asLor8ZikF"
Content-Disposition: inline
In-Reply-To: <20250306171032.243954-1-Frank.Li@nxp.com>


--iGmX26asLor8ZikF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 12:10:32PM -0500, Frank Li wrote:
> Add compatible string "fsl,imx94-flexcan" for the i.MX94 chip, which is
> backward compatible with i.MX95. Set it to fall back to
> "fsl,imx94-flexcan".

typo here, not that it matters ultimately.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b=
/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> index 73252fe56fe6c..560da9fa1ea15 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> +++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
> @@ -45,6 +45,10 @@ properties:
>            - enum:
>                - nxp,s32g3-flexcan
>            - const: nxp,s32g2-flexcan
> +      - items:
> +          - enum:
> +              - fsl,imx94-flexcan
> +          - const: fsl,imx95-flexcan
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--iGmX26asLor8ZikF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sXIwAKCRB4tDGHoIJi
0nSxAP4rhBDGVyVFAz83c7InJ5rTTWbKUhqfPsT71YY6YQAQOgEAtmRpkn/QlPGE
iO4Ewn/RiJ5VPNUmnH0AZ2/vMp1ZIws=
=YkNV
-----END PGP SIGNATURE-----

--iGmX26asLor8ZikF--

