Return-Path: <linux-can+bounces-17-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932187E9DE7
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 14:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EB11C208C3
	for <lists+linux-can@lfdr.de>; Mon, 13 Nov 2023 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D5D20B15;
	Mon, 13 Nov 2023 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qU/fh39F"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698F1D69C;
	Mon, 13 Nov 2023 13:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8CAC433C7;
	Mon, 13 Nov 2023 13:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699883694;
	bh=TKPvw6QQFIrIIlAjVVPSOQlUEuXKktzFA7tkPQtcwfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qU/fh39FdmMNq5BF7loxDAQMsP9AjZlmZmliyHJ4WN2d9ZLE0CFZANb1LLP/qMkl8
	 G+1diiJvbzWd/2f3Pya0KF32GAZmb1VNZjXNOMxG2OQJXBmafXPXToYfv2xXShwmvR
	 fIDJ/+jWemDR0yeRzws6BjIgc9K4hcUC+x1CiKYheC1CwlOUlbYrMIKE09gabctr67
	 kSZRj6TYO/I5XfmYHZDF1ytN++s+MXazO5JPaGKiEG5GNyeE0B6z/qUtZvjIMpFWLM
	 cogQL9WcWjEgV+ktvW8bcVtFVPwqErJ+i4qaKqFSY4vaXuJyDIsm5TCRPP9OzMZw/u
	 CmN5Z9SasxYqw==
Date: Mon, 13 Nov 2023 13:54:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: can: tcan4x5x: Document the
 wakeup-source flag
Message-ID: <20231113-enduring-till-99aa896c194d@squawk>
References: <20231113131452.214961-1-martin@geanix.com>
 <20231113131452.214961-4-martin@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ra0AIDMytaHONV/n"
Content-Disposition: inline
In-Reply-To: <20231113131452.214961-4-martin@geanix.com>


--ra0AIDMytaHONV/n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 02:14:52PM +0100, Martin Hundeb=F8ll wrote:
> Let it be known that the tcan4x5x device can now be configured to wake
> the host from suspend when a can frame is received.
>=20
> Signed-off-by: Martin Hundeb=F8ll <martin@geanix.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
> Change in v3:
>  * New patch
>=20
>  Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Doc=
umentation/devicetree/bindings/net/can/tcan4x5x.txt
> index 170e23f0610d..20c0572c9853 100644
> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -28,6 +28,8 @@ Optional properties:
>  			      available with tcan4552/4553.
>  	- device-wake-gpios: Wake up GPIO to wake up the TCAN device. Not
>  			     available with tcan4552/4553.
> +	- wakeup-source: Leave the chip running when suspended, and configure
> +			 the RX interrupt to wake up the device.
> =20
>  Example:
>  tcan4x5x: tcan4x5x@0 {
> @@ -42,4 +44,5 @@ tcan4x5x: tcan4x5x@0 {
>  		device-state-gpios =3D <&gpio3 21 GPIO_ACTIVE_HIGH>;
>  		device-wake-gpios =3D <&gpio1 15 GPIO_ACTIVE_HIGH>;
>  		reset-gpios =3D <&gpio1 27 GPIO_ACTIVE_HIGH>;
> +		wakeup-source;
>  };
> --=20
> 2.42.0
>=20

--ra0AIDMytaHONV/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIqqAAKCRB4tDGHoIJi
0tdHAP9dHKBxH0CQDuzswZAUqET+t41dnd4QAO9v/VYprt/XCgEA4i3Ae6PpfrT2
1j5VWiyTw6KJNSWYlBwNYtTCAbyqVAY=
=z6zG
-----END PGP SIGNATURE-----

--ra0AIDMytaHONV/n--

