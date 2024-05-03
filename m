Return-Path: <linux-can+bounces-556-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49158BB182
	for <lists+linux-can@lfdr.de>; Fri,  3 May 2024 19:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A732284E7F
	for <lists+linux-can@lfdr.de>; Fri,  3 May 2024 17:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6050157A76;
	Fri,  3 May 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5bpwIbT"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161178276;
	Fri,  3 May 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756376; cv=none; b=XQJZ7DdZOTrRF3bKGrIX1qYQUU8KU/EuFomh4w8l2w/66gz1nTlfHd+7NN0HYUJ8m8H2bbNf1pDgheT8BrmQMxQDHKAdOP3+LmXbZ5E/jJ1uBw5FL0K5SFWfnQTvt/Yk5jlX1SJbih5+S2x7ZqlTb4jB+/IEfimr409sp9quFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756376; c=relaxed/simple;
	bh=j1AlBmA8EvR89RnAFEz1pY/E0yUi35JufxzFz9CJ0aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUX9lwRAnq5roOimv/F4oVYdZpCiQHClY+XGwmFLsU/bwUi5rl2wMD/qMsGzPVA6qQVtKxYE6Gz6jZQLpyu1Ng4hHl6CoZOGi5QRul2jpODX2bFTT7Simjn2/X0NmT42+Yefv77TbaOf+TPXHdLl3qaTFIxn2DhZrErynryWa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5bpwIbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D46C116B1;
	Fri,  3 May 2024 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714756376;
	bh=j1AlBmA8EvR89RnAFEz1pY/E0yUi35JufxzFz9CJ0aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5bpwIbT9mTSo+G1s5jqROstAZvjypQL7s6c2tLAQ7VbQitlkGrEhRbNW/j3ZsJMW
	 zUud7VDAvN8lABU9AdCzSkl+VkSpWYl9DzDDXQK/+2ShanKw/XNteSUI+KGIIqXFS3
	 UhRXda6SJsIgb5vtEP8M8LqEMCzijTSLy+j0paxRCh+FntKRbvJqb7p+VnVDslz+9E
	 RPsN6jOcDc+d9yTqHLREDlVmSP9VCYug1ZuqQcH6oXuSc3SYeF1+WdGtbnSIJe4eWy
	 cIn8Qs8Lg6N08dMOqCuNO1eXfM/akKJ5ayzKHHR0HlRSpR9iVAvFnXPjbwNIpvg/U8
	 Gq6m0tOCYYiPg==
Date: Fri, 3 May 2024 18:12:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 06/11] dt-bindings: net/can: Add serial (serdev) LIN
 adapter
Message-ID: <20240503-fading-extruding-2105bbd8b479@spud>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
 <20240502182804.145926-7-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wALyyOjqkAbb5csW"
Content-Disposition: inline
In-Reply-To: <20240502182804.145926-7-christoph.fritz@hexdev.de>


--wALyyOjqkAbb5csW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 08:27:59PM +0200, Christoph Fritz wrote:
> Add dt-bindings for serial LIN bus adapters. These adapters are
> basically just LIN transceivers that are hard-wired to serial devices.
>=20
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  .../bindings/net/can/hexdev,lin-serdev.yaml   | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,lin-=
serdev.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.=
yaml b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> new file mode 100644
> index 0000000000000..c178eb9be1391
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/hexdev,lin-serdev.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Serial LIN Adapter
> +
> +description:
> +  LIN transceiver, mostly hard-wired to a serial device, used for commun=
ication
> +  on a LIN bus.
> +  For more details on an adapter, visit <https://hexdev.de/hexlin#tty>.
> +
> +maintainers:
> +  - Christoph Fritz <christoph.fritz@hexdev.de>
> +
> +properties:
> +  compatible:
> +    const: hexdev,lin-serdev

Maybe I've just missed something on earlier versions that I didn't
read, but the name of the device on the website you link is "hexLIN",
so why is "lin-serdev" used here instead?

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    serial {
> +        linbus {
> +            compatible =3D "hexdev,lin-serdev";
> +        };
> +    };
> --=20
> 2.39.2
>=20

--wALyyOjqkAbb5csW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjUbEQAKCRB4tDGHoIJi
0swqAQCF8l5qprfFPZ6cZ7vHJYmcFVMucGf+WHsQS/KyE583BwEAv8DFN0XXp2jS
E0yi6lEyzextMZsTck5ziHMgFfOMZAk=
=6TI4
-----END PGP SIGNATURE-----

--wALyyOjqkAbb5csW--

