Return-Path: <linux-can+bounces-5280-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B70F0C1C93E
	for <lists+linux-can@lfdr.de>; Wed, 29 Oct 2025 18:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 659A44E128F
	for <lists+linux-can@lfdr.de>; Wed, 29 Oct 2025 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CC9328B64;
	Wed, 29 Oct 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBBijb++"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0102F8BEE;
	Wed, 29 Oct 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760094; cv=none; b=SWe86erTTp/vp+ViMs1lIh5qJv9ASx1b60ph6xpqmBhGASq7EuprRpMYmkCPbJWV0LhyE2Qk627FkJZPyxL/8DZxZlOZVUr6EbBforFyCg3n/gNNNwF7h8VH0eY+6abKUWwf5l80jqlgocsxSv87AFeySuM4ffvFXwL7XWKotVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760094; c=relaxed/simple;
	bh=gmuvfAv/HRo9/GwGj6MrrNns2n4S/yptkDh+ez1A/BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0RfxrPh28QY6ckcIyXAsQcs2eH3YXzzN8NrFHA7XQdiyyx2HxSR20HF6ZnezOe0/Ex9XZIWYXKKP39k/6sGS2vUbz3cRA2K/IzaxxrP4sPmdup9p7iJEmbcp/cE/Gjznl+kNEPf2O8gkUDeT168yRi8GrlASa4Pm+znKVzI85c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBBijb++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30CCC4CEF7;
	Wed, 29 Oct 2025 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761760093;
	bh=gmuvfAv/HRo9/GwGj6MrrNns2n4S/yptkDh+ez1A/BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBBijb++94bBV+SfzKmrzvQHpsG2lpDu/Ezjq70clIZUkpYOKyA3Ucnx/leoM5EHN
	 0vXvguO7ibhtHZLH86g0kSFNkQZT9uaU20GSzB2vxK/IXScQJAd5bkuFyS0vB3RkJC
	 VKVwWVMYHbebGpxW5XkPxlzp+aMbXYTZFtjXsWiPm1fYv+oxg/mTiTWhEUejdTuXR5
	 fkMwGORoAbO+FwFdJTrr0e3nHQxK8nR+uJJ6rwrxJ/aw8vmy3INxHi1PGcv9bXRzv0
	 aqz46WoMgdfBdP7BBSOkD7beU9vqkIjYrknRILy5C0BYsQpZteiEB5ol1CsYdWhOrL
	 GvA5x2rdvnZMg==
Date: Wed, 29 Oct 2025 17:48:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, cl@rock-chips.com, linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 1/4] dt-bindings: can: rockchip_canfd: add rk3576 CAN
 controller
Message-ID: <20251029-unreal-heroics-6e56a89e34d0@spud>
References: <20251029032302.1238973-1-zhangqing@rock-chips.com>
 <20251029032302.1238973-2-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="01IpGdZZ9oQxgRWr"
Content-Disposition: inline
In-Reply-To: <20251029032302.1238973-2-zhangqing@rock-chips.com>


--01IpGdZZ9oQxgRWr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:22:59AM +0800, Elaine Zhang wrote:
> Add documentation for the rockchip rk3576 CAN controller.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../net/can/rockchip,rk3568v2-canfd.yaml      | 52 +++++++++++++++++--
>  1 file changed, 48 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-=
canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-ca=
nfd.yaml
> index a077c0330013..30782218728e 100644
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
> -
>  properties:
>    compatible:
>      oneOf:
> -      - const: rockchip,rk3568v2-canfd
> +      - enum:
> +          - rockchip,rk3568v2-canfd
> +          - rockchip,rk3576-can
>        - items:
>            - const: rockchip,rk3568v3-canfd
>            - const: rockchip,rk3568v2-canfd
> @@ -43,6 +42,33 @@ properties:
>        - const: core
>        - const: apb
> =20
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +
> +allOf:
> +  - $ref: can-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3576-can
> +    then:
> +      properties:
> +        dmas:
> +          minItems: 1
> +          maxItems: 2
> +        dma-names:
> +          minItems: 1
> +          maxItems: 2

This looks wrong. You have one dma, but you're setting maxItems to 2.
Seems fine otherwise.
pw-bot: changes-requested


Cheers,
Conor.

> +    else:
> +      properties:
> +        dmas: false
> +        dma-names: false
> +
>  required:
>    - compatible
>    - reg
> @@ -72,3 +98,21 @@ examples:
>              reset-names =3D "core", "apb";
>          };
>      };
> +
> +  - |
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        can@2ac00000 {
> +            compatible =3D "rockchip,rk3576-can";
> +            reg =3D <0x0 0x2ac00000 0x0 0x1000>;
> +            interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks =3D <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
> +            clock-names =3D "baud", "pclk";
> +            resets =3D <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
> +            reset-names =3D "core", "apb";
> +            dmas =3D <&dmac0 20>;
> +            dma-names =3D "rx";
> +        };
> +    };
> --=20
> 2.34.1
>=20

--01IpGdZZ9oQxgRWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJTWAAKCRB4tDGHoIJi
0qVhAPsG3U2zIV2IEhCQGMbLtQJNoGSUmzb6yyOYDB/ZsqWM9gD/UvCgdautseC1
gMmchbJQAcHxrEqzZGxopx+iLXenaQ8=
=an9+
-----END PGP SIGNATURE-----

--01IpGdZZ9oQxgRWr--

