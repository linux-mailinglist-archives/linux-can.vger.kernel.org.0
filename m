Return-Path: <linux-can+bounces-1068-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5E942077
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 21:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F861F235F8
	for <lists+linux-can@lfdr.de>; Tue, 30 Jul 2024 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6639418C904;
	Tue, 30 Jul 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjsitjva"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259F189B97;
	Tue, 30 Jul 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367320; cv=none; b=SkGHV2e+S0qQ/EG9Burgurxiecva2qqEfP13RDRi/q1PHMIdr0SGFFexIlJu2xWY1k6LnwTkEvcxrKKhbYsAUpOjmV8VKObmbYD/+4dTQU2O7GsFT5OaDUhtyUW2CZg2ZHFff53AsqHTCUSJw61INeuTt6au6JgWBs2UdWu7tW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367320; c=relaxed/simple;
	bh=+z+uSHvXptbqQUkxjz2xHQBFc5+LBea44Cmnih2JyhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDtRwmPC3OEgBQOubVpu5iBvVCBkT112Angkpmxju81W3+xgXrUKYCgGB/b7rPuSZ2GpyLJM5GZrUr5zqdLJv+vFF2Apm+zbENGDXK828OZqYqFezPAWy6+6gkLRZYnabssQtJ35w72lDLanj6SIQOOumZiubcDFda94L+MxP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjsitjva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844B1C32782;
	Tue, 30 Jul 2024 19:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722367319;
	bh=+z+uSHvXptbqQUkxjz2xHQBFc5+LBea44Cmnih2JyhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjsitjvai+UJvADhTVoItn0LWY29Z+U4fZJHcAtyws2IZgMZE6+zAvgcmahmMEV4+
	 bieUMCkz1FBPIlJdYxeqFdWYFE8psyljSxElFLoTJhHtpz4LJ821iyp4vi5O2qVdP8
	 vfQ2hKuVKYu27eSn4sNREMwrmaHzkKk3rHqcxBq4SwKxI6HsdrZxskOyyfrRCZEg5k
	 wKT9cSlpSduIqxommeu2bUcnqHXxuLTIKx8yUvW9ISijsYnDfxlPvNjTDIjLSisvlU
	 kEhPmeA95nSZjvg9dLw3wh0YSV79d1O9gSRvVTYUWyeeqSKa7mC/6l0qkMk5BcxjlN
	 FGoWydeWRMhRQ==
Date: Tue, 30 Jul 2024 13:21:58 -0600
From: Rob Herring <robh@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	David Jander <david.jander@protonic.nl>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next 01/21] dt-bindings: can: rockchip_canfd: add
 binding for rockchip CAN-FD controller
Message-ID: <20240730192158.GA2001115-robh@kernel.org>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
 <20240729-rockchip-canfd-v1-1-fa1250fd6be3@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-rockchip-canfd-v1-1-fa1250fd6be3@pengutronix.de>

On Mon, Jul 29, 2024 at 03:05:32PM +0200, Marc Kleine-Budde wrote:
> Add the binding of the rockchip rk3568 CAN-FD controller to the device
> tree bindings documentation.

Subject line space is valuable. Don't say 'binding' twice. Or anything 
else for that matter. 

> Co-developed-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .../bindings/net/can/rockchip,canfd.yaml           | 76 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml
> new file mode 100644
> index 000000000000..85f7ea68d8b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/rockchip,canfd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  Rockchip CAN-FD controller
> +
> +maintainers:
> +  - Marc Kleine-Budde <mkl@pengutronix.de>
> +
> +allOf:
> +  - $ref: can-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: rockchip,rk3568-canfd
> +      - items:
> +          - enum:
> +              - rockchip,rk3568v2-canfd
> +              - rockchip,rk3568v3-canfd
> +          - const: rockchip,rk3568-canfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: baudclk

Just 'baud'

> +      - const: apb_pclk

apb or pclk.

> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: can
> +      - const: can-apb

They are always for 'can' so that's redundant. I guess it is fine on 
the first entry, but definitely drop on the 2nd. Or do 'core' and 'apb'.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3568-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        can0: can@fe570000 {
> +            compatible = "rockchip,rk3568-canfd";
> +            reg = <0x0 0xfe570000 0x0 0x1000>;
> +            interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
> +            clock-names = "baudclk", "apb_pclk";
> +            resets = <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
> +            reset-names = "can", "can-apb";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0a3d9e93689..d225dc39bd89 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19694,6 +19694,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
>  F:	drivers/hid/hid-roccat*
>  F:	include/linux/hid-roccat*
>  
> +ROCKCHIP CAN-FD DRIVER
> +M:	Marc Kleine-Budde <mkl@pengutronix.de>
> +R:	kernel@pengutronix.de
> +L:	linux-can@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml
> +
>  ROCKCHIP CRYPTO DRIVERS
>  M:	Corentin Labbe <clabbe@baylibre.com>
>  L:	linux-crypto@vger.kernel.org
> 
> -- 
> 2.43.0
> 
> 

