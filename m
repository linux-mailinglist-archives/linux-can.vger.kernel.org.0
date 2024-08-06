Return-Path: <linux-can+bounces-1150-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B719495E1
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 18:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62104288A83
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2E63C08A;
	Tue,  6 Aug 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcgeYhJB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43E3A8CB;
	Tue,  6 Aug 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963021; cv=none; b=LicFH5sMEhw/dS/EdXjI9w0smGz52csYl9vmDG0+05OnyEGyjoZ2hqTRzoihdFtpe7z41xoa18r0vY6cqnRAsz1nyCw1Q3QDWySKl7kgNQtKV+9zEVlFs/Uzq1elTPjWPmdPC0Ff8X9Y4VojRgbur9HR4ilgRAV9u0DDexuuHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963021; c=relaxed/simple;
	bh=FFxPz+Zq4k0dEWsAFdsdPEf4umMD6s9dToAnn3i5Faw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvXZtLVyee4Jcuhn6B4mL8WFhlPgX4+7aieLSAu20nJq/3+41ODYPSEzLip9AMm/zozcoeczM4G2IToAOCtn0DHpZ0OKgRLYMjSsbrW2gEO1dkXVsIJw7jjOHz2ThmnbfKX4epH74aSQlkACgKyAjNiW5EAAKdmnF+z8NUpR1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcgeYhJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E010C32786;
	Tue,  6 Aug 2024 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722963021;
	bh=FFxPz+Zq4k0dEWsAFdsdPEf4umMD6s9dToAnn3i5Faw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcgeYhJBrYlbH3M0m57xTjrf6egz6fWtJY+YBSjefW7/YuRYVTLxhQEkVH0MyuI21
	 YKWnqXkNZZB7UhNgxe+l6a1elFtLIVeZgEhtrT5kztvvbRqx3a3e6JsowRnjzd8zkI
	 uaAszT420F5Z9WWIZ7xv7yIEWIWHeZ9CUy8EyfZslnzvCs383StpYSkfnoqrn16MYL
	 +5O+t/lHdaSyIGoAf9Ii7NPK7Msqf4BLoJ+8dCH7cjCH+zi8mC54ekEkSVjPnOGHs8
	 HVFbmxaqrrbCSfO1mTMLI9GVD0M0BhlB6V8rIOyuIRSmqsvNtCoDkP7Sl+yQUD7CKz
	 W978rCKWWeQnQ==
Date: Tue, 6 Aug 2024 10:50:20 -0600
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
	David Jander <david.jander@protonic.nl>,
	Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next v2 01/20] dt-bindings: can: rockchip_canfd: add
 rockchip CAN-FD controller
Message-ID: <20240806165020.GA1664499-robh@kernel.org>
References: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
 <20240731-rockchip-canfd-v2-1-d9604c5b4be8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-rockchip-canfd-v2-1-d9604c5b4be8@pengutronix.de>

On Wed, Jul 31, 2024 at 11:37:03AM +0200, Marc Kleine-Budde wrote:
> Add documentation for the rockchip rk3568 CAN-FD controller.
> 
> Co-developed-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .../bindings/net/can/rockchip,canfd.yaml           | 76 ++++++++++++++++++++++

rockchip,rk3568-canfd.yaml

>  MAINTAINERS                                        |  7 ++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml
> new file mode 100644
> index 000000000000..444269f630f4
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

Given you already know there are differences in the versions to handle 
and there's no existing driver supporting the fallback, I don't know 
that a fallback is too useful here.

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
> +      - const: baud
> +      - const: pclk
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: core
> +      - const: apb
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

Drop unused labels.

> +            compatible = "rockchip,rk3568-canfd";
> +            reg = <0x0 0xfe570000 0x0 0x1000>;
> +            interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
> +            clock-names = "baud", "pclk";
> +            resets = <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
> +            reset-names = "core", "apb";
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

