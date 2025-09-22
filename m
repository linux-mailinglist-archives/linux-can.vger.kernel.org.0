Return-Path: <linux-can+bounces-4820-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B563B9349D
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 22:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2AD1907E86
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 20:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D06927F010;
	Mon, 22 Sep 2025 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btMCe4pJ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6426F28B;
	Mon, 22 Sep 2025 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574525; cv=none; b=qvRjTFRIyrSN6tPD1HlCtUj7c6BAiAtbVyVcjyVqQuZkm041RZ+HkGaPAsxekzrBweK+vc0BD98HSInCRIVFYrEzGNYf/U3o9jN348l+haKkfPBB0w47xx2BYS57BJSm4HkGqzOQvotMZCCLJA2Sey0JLarMEnqK1necfwb3R2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574525; c=relaxed/simple;
	bh=tYpOjofHpW9mWp+Pr+zwn20aiOFBJXMUD80BxBDT1OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJIY3Ydj5UcuSoZ9/SnkJRNbLhNQaGhjpdKI89OmOFdG7M9AiaeuOQi3dhHK2INV4Qo9Tbf7MVBr03boEA7C/MOZ7aODNZzAHKL2LshVTHuPI9PpEoXdZkSfSgHbOCrJovKBvC7nUhOrVZ2zvVrSeHQlU8Xy/B/hBqimLk46Ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btMCe4pJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5211C4CEF0;
	Mon, 22 Sep 2025 20:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758574524;
	bh=tYpOjofHpW9mWp+Pr+zwn20aiOFBJXMUD80BxBDT1OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btMCe4pJzrjEFcSIlChfqpHzRKX9nmREvFuQo1txXzAfXiMm7dqUgVYz/Yg24jZfh
	 oEC0lhquRT3S7V6O3w4AhmbeOIoeL8PEjKvTuf9hYNW3DLFeoNTjSxSkZvta8koKyN
	 LXm5t6Kbm0VC1PdnmcRy/++FJf3w3qG5pOJYGUGf2wr2YowDAUyHurGLKeI6XZ6PwB
	 Qttw6vo5oui+LCk5cciNBbSNLP8Z/+yvxIQGRQ8bdkk9ytAxiuFaZRQtIXHpkPh1sN
	 HvoJimqkW8ltIgE5weKxlHGjBkju03NhQdRKOJ71ZfuCQERW+3wBIu9gPl3p041Bxy
	 XvQr5ridOkuaw==
Date: Mon, 22 Sep 2025 15:55:21 -0500
From: Rob Herring <robh@kernel.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	cl@rock-chips.com, kever.yang@rock-chips.com,
	linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/4] dt-bindings: can: rockchip_canfd: add rk3576
 CAN-FD controller
Message-ID: <20250922205521.GA1307111-robh@kernel.org>
References: <20250922071543.73923-1-zhangqing@rock-chips.com>
 <20250922071543.73923-2-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922071543.73923-2-zhangqing@rock-chips.com>

On Mon, Sep 22, 2025 at 03:15:40PM +0800, Elaine Zhang wrote:
> Add documentation for the rockchip rk3576 CAN-FD controller.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../net/can/rockchip,rk3568v2-canfd.yaml      | 47 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
> index a077c0330013..74b1a502f0b7 100644
> --- a/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/rockchip,rk3568v2-canfd.yaml
> @@ -10,13 +10,11 @@ title:
>  maintainers:
>    - Marc Kleine-Budde <mkl@pengutronix.de>
>  
> -allOf:
> -  - $ref: can-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
>        - const: rockchip,rk3568v2-canfd
> +      - const: rockchip,rk3576-canfd

Combine these 2 into an enum.

>        - items:
>            - const: rockchip,rk3568v3-canfd
>            - const: rockchip,rk3568v2-canfd
> @@ -43,6 +41,31 @@ properties:
>        - const: core
>        - const: apb
>  
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
> +
>  required:
>    - compatible
>    - reg
> @@ -72,3 +95,21 @@ examples:
>              reset-names = "core", "apb";
>          };
>      };
> +
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        can@2ac00000 {
> +            compatible = "rockchip,rk3576-canfd";
> +            reg = <0x0 0x2ac00000 0x0 0x1000>;
> +            interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
> +            clock-names = "baud", "pclk";
> +            resets = <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
> +            reset-names = "core", "apb";
> +            dmas = <&dmac0 20>;
> +            dma-names = "rx";
> +        };
> +    };
> -- 
> 2.34.1
> 

