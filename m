Return-Path: <linux-can+bounces-3690-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC95AC4225
	for <lists+linux-can@lfdr.de>; Mon, 26 May 2025 17:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4858A16A897
	for <lists+linux-can@lfdr.de>; Mon, 26 May 2025 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9A20E306;
	Mon, 26 May 2025 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYycV5m4"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0160A29;
	Mon, 26 May 2025 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748272357; cv=none; b=cEz4LSTY93wOMOOLmsQiGqOUYWdBrayPVPB+Oo/VUaifqRR7snvpQYg0fRrybXOwoNyHAzaIIiBt+Hl+ZxPa6nIDpD6WSLo1aVTaZgaOKl99hEf4a33o3kkZoyXZylHiPw5L9Eagc1LeTw8DYKtFfq7WxvPDwnnVJSmZjsmTFqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748272357; c=relaxed/simple;
	bh=kWo5T5lnE4BmAH5IoBFw87ICQLy1irQV74u/xe9P580=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPQu+m1QLkcDbNg9yyr0t1VqOmzlz9u0MrgteipCYpAoETck1a/he2mul6OTuiZQVQBIyS8pkKTZ6L8gz6GlFS3p0ia0JfDLUJPYbXM2Dtdad7BDSJ0ydh9mduWRzQQejtV7ciV0SnA2pYjvO044uYcPeE2W03PlguCdXyRTFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYycV5m4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B704C4CEE7;
	Mon, 26 May 2025 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748272355;
	bh=kWo5T5lnE4BmAH5IoBFw87ICQLy1irQV74u/xe9P580=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYycV5m4ePwBLCKUSKF5SD+WvmqIUWGw6kHzt5LTW9+7ujoYmoEZvYk6Oiqg0TUHV
	 Pqo2LXmqjm8/+6Wy8SkGxDdZAHb5Qhv5XZtNf8pg+oM5MvIr465jZvoP8S+IgyhP01
	 AnPmwriQ9hMaEkyhB2fsqy/ii2iZT+L+LPfwBK83RK4wgiOfcgGT8tDPFP5VUlbiey
	 VVjDj6IWZl26N+jWuSIJkgCHfM9ClFN8PgeNWbUu2shbi95qqKHcVpPvy+Nmx+DtuR
	 9QhJITqRCZ54oc16/CtnlF/G2Wow6hZc2cn0nPQplEs8pKhN1HEJDZMmthokYiECGU
	 wuWb+724LiNRg==
Date: Mon, 26 May 2025 16:12:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, cl@rock-chips.com, kever.yang@rock-chips.com,
	linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: can: rockchip_canfd: add rk3576
 CAN-FD controller
Message-ID: <20250526-prelude-twiddle-790ebead48b3@spud>
References: <20250526062559.2061311-1-zhangqing@rock-chips.com>
 <20250526062559.2061311-2-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n/oHaDOCTLOQXhJc"
Content-Disposition: inline
In-Reply-To: <20250526062559.2061311-2-zhangqing@rock-chips.com>


--n/oHaDOCTLOQXhJc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 02:25:56PM +0800, Elaine Zhang wrote:
> Add documentation for the rockchip rk3576 CAN-FD controller.
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../net/can/rockchip,rk3568v2-canfd.yaml      | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-=
canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-ca=
nfd.yaml
> index a077c0330013..c6595fef6cb5 100644
> --- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.y=
aml
> +++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.y=
aml
> @@ -12,11 +12,27 @@ maintainers:
> =20
>  allOf:
>    - $ref: can-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3576-canfd
> +      required:
> +        - compatible
> +    then:
> +      required:
> +        - dmas
> +        - dma-names
> +    else:
> +      properties:
> +        dmas: false
> +        dma-names: false

Once the allOf contains more than just an include it should be moved
down below the properties that it is constraining. Otherwise, I think
this looks fine.

> =20
>  properties:
>    compatible:
>      oneOf:
>        - const: rockchip,rk3568v2-canfd
> +      - const: rockchip,rk3576-canfd
>        - items:
>            - const: rockchip,rk3568v3-canfd
>            - const: rockchip,rk3568v2-canfd
> @@ -43,6 +59,13 @@ properties:
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
>  required:
>    - compatible
>    - reg
> @@ -72,3 +95,21 @@ examples:
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
> +            compatible =3D "rockchip,rk3576-canfd";
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

--n/oHaDOCTLOQXhJc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDSE3gAKCRB4tDGHoIJi
0joiAP99gMdxwhanZ7bbRzJWitqBe47RArKHWPRN6EcplWt4EwD/fPxHOjIXLxSo
INHR8oDcF4Rov+HADRHyTXPkbs6K8AQ=
=QjRT
-----END PGP SIGNATURE-----

--n/oHaDOCTLOQXhJc--

