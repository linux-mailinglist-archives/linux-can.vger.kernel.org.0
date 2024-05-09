Return-Path: <linux-can+bounces-621-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB488C1485
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2DBAB215E6
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 18:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3389D71738;
	Thu,  9 May 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcWbs/r1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2FB4A21;
	Thu,  9 May 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278185; cv=none; b=jqjUccbNx8kjy3idHsiIIaTnUNUHOb1GxXiTqu0PBAq7W8j/qU6szcj8ZlysYSzP+R2QbgHcDX2YNT8WyE4XPgsCeIHGudHIhRvJSglADpdpr87v+DKaTaM6uekf9UIFxPA3dH7mdERpe1QnNBKcCV7TijUkmw91+9OOdpUML38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278185; c=relaxed/simple;
	bh=jwv2fzzjt0cfgGB3Brq3DaNH87PYRXNR2e6rGYGOafE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y82mLFY9ueoQfAwtLzvVH2zRHyVkivHPSbOCvb6AQUI1nBLoR6eBW5/wl20MZuxjA0SnHo92wzCfmjjQfL1szgPRdO4jp4thyC6Iuf8P065nFWOmf1leO9J87wd8Bm7M35y1yWj0fS09lo+ovsgLSwmgoRAL2Ha4B0zpOtgqT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcWbs/r1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B79C116B1;
	Thu,  9 May 2024 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715278184;
	bh=jwv2fzzjt0cfgGB3Brq3DaNH87PYRXNR2e6rGYGOafE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcWbs/r1G654QjExkZzDw+Ye8SGuO5KNSoJXgb3ZcHmQu3x4E4I2S1EyboJZJ69Pm
	 mQGtOZps9Mk4n5oD3NC0m6qaZEA2R4B3yV8ziliaYQKJuVPbeega5VLoJMM7bdEW8w
	 QsO0dRoyLJXReH4e+Gr2o/o8rwX7eRPfNmNxtDhq2odx+5HXePP3adhAZMwihdufgm
	 TJYZN9r45oB8RBk9LJ07YyNdaLx0jXiIe+uuIlXoZ3rnG7UWq+TcvufvwhgqAcdXUj
	 IWIJQk7xiKk8ZMCAMycm8EUrbMdGg/3MJ+w5ZJHt/4Fmr2dZhqKHu/Lwo0Trc23XnT
	 53sTqY3R2bs6Q==
Date: Thu, 9 May 2024 19:09:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 06/11] dt-bindings: net/can: Add serial LIN adapter
 hexLINSER
Message-ID: <20240509-kindred-cauterize-ced967ec9d73@spud>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
 <20240509171736.2048414-7-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="36g1c/htqkz0JRR5"
Content-Disposition: inline
In-Reply-To: <20240509171736.2048414-7-christoph.fritz@hexdev.de>


--36g1c/htqkz0JRR5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 07:17:31PM +0200, Christoph Fritz wrote:
> Add dt-bindings for hexDEV hexLINSER serial LIN adapters. These adapters
> are basically just LIN transceivers that are mostly hard-wired to serial
> devices.
>=20
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  .../bindings/net/can/hexdev,hex-linser.yaml   | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,hex-=
linser.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/hexdev,hex-linser.=
yaml b/Documentation/devicetree/bindings/net/can/hexdev,hex-linser.yaml
> new file mode 100644
> index 0000000000000..42dce3348f73c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/hexdev,hex-linser.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/hexdev,hex-linser.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: hexDEV hexLINSER serial LIN adapter
> +
> +description:
> +  LIN transceiver, mostly hard-wired to a serial device, used for commun=
ication
> +  on a LIN bus.
> +  For more details on the adapter, visit <https://hexdev.de/hexlin#hexLI=
NSER>.

I figured I should check in firefox this time, link works fine :)

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--36g1c/htqkz0JRR5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj0RYQAKCRB4tDGHoIJi
0rn9AP9GeUrrcK2lOZklZKtI73PoesLELNp3iickgJOn7nnz3gEA2+jfFsbOdudy
aNhI8GeBNvUtapOXQ7u6wpXTXsMdLgQ=
=CoEI
-----END PGP SIGNATURE-----

--36g1c/htqkz0JRR5--

