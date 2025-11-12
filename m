Return-Path: <linux-can+bounces-5382-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C810EC540E6
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 20:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4E33B0296
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0434A79D;
	Wed, 12 Nov 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN1ilMGg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C333AD8D;
	Wed, 12 Nov 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974271; cv=none; b=Su0Ul/qygIffRsdEL3vsmjkKKD2Tv/qHoxXBmAGoHxdnz3904uLousCUSLxiz3aplWtdJYjZQWQaGvTkcZQL1loHNcocZ85ccLwdqKUI61ppLISO9ynReNc1WegDs0e/mk4rN8VrvANscMuRnqnayZZDS3/Raf/bU4I2UI2/a1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974271; c=relaxed/simple;
	bh=OsZBDvzHWBseg3Knx1k9apRw+CVUYMUDRIxIjk6M13w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpcDZTcqFnqqubhZms0dWa1sp31v3UyD3eBagNvBK4P/SZZ0WXkD/FUVi1l06C05UdaP8lhSixy6xo2iIQCXRN2MDOts4U+DwPo6aeNI2ULkDC1bIXNY80sSmPyE9Idzbgw1swaC0Uo6T6lCf+fYvalCaDwaH7p07zP6Eu4anrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN1ilMGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDD9C4CEF5;
	Wed, 12 Nov 2025 19:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762974271;
	bh=OsZBDvzHWBseg3Knx1k9apRw+CVUYMUDRIxIjk6M13w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EN1ilMGgWW8T6uXzRy1PpJ6wHDNYjkIgRF8C2S09QM6Pp9dTc64ppdgUJytGHFD9f
	 c18leiGKUMZKJ6nA+8vHY5Ux8zQ45jfQRox2kXQo9HqKLBBfqVLTYI26r3GR6a4sFV
	 rYtq0SqLkeF9ihQdQJycAlh16u09SIbV7B9cRgo4HINTUnsnUNzm2oe2ftrT+mJ3TH
	 xaia2aPceqtEnq/hZryp5jnqH+9Gcr4IWlACvomiq48jDKc1xGXkkqHvv/PAgJI5kR
	 Ys4Hk0KGfofvnbp9rP5+1Qqq+UfsNw8M4ABS7k6okOZPJduSN3NEyJp1qmnpPj0qr5
	 cn7FxoPbcD0og==
Date: Wed, 12 Nov 2025 19:04:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, cl@rock-chips.com, linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v8 1/4] dt-bindings: can: rockchip_canfd: add
 rk3576 CAN controller
Message-ID: <20251112-surely-enroll-02a3a3646084@spud>
References: <20251112015940.3695638-1-zhangqing@rock-chips.com>
 <20251112015940.3695638-2-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EQbl/SQeCGRxcKF0"
Content-Disposition: inline
In-Reply-To: <20251112015940.3695638-2-zhangqing@rock-chips.com>


--EQbl/SQeCGRxcKF0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 09:59:37AM +0800, Elaine Zhang wrote:
> Add documentation for the rockchip rk3576 CAN controller.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-=
canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-ca=
nfd.yaml
> index a077c0330013..22e10494e7d1 100644
> --- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.y=
aml
> +++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.y=
aml
> @@ -10,13 +10,12 @@ title:
>  maintainers:
>    - Marc Kleine-Budde <mkl@pengutronix.de>
> =20
> -allOf:
> -  - $ref: can-controller.yaml#

Since in the other mail it was stated that this was removed in error
pw-bot: changes-requested

--EQbl/SQeCGRxcKF0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRTaOgAKCRB4tDGHoIJi
0qoVAP4ySdGjjDkARJ7pR6fmuWavLo9sUrf8lfFCP/JEOD1eUgEApqQ3+nwlh4ab
e8WwfeqUajB1sRAcrjGqY5QGC287OQY=
=K1Vm
-----END PGP SIGNATURE-----

--EQbl/SQeCGRxcKF0--

