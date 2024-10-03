Return-Path: <linux-can+bounces-1590-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B708398EBAE
	for <lists+linux-can@lfdr.de>; Thu,  3 Oct 2024 10:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62ED11F21817
	for <lists+linux-can@lfdr.de>; Thu,  3 Oct 2024 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415DC13C661;
	Thu,  3 Oct 2024 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP/9M23Q"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547213A869;
	Thu,  3 Oct 2024 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944488; cv=none; b=BgtBZHW3g4C1C/T4MjBl9DyhvhK7UXR4dJYpcr3SNZ8o6zNzbXUw1t0FidVY0m4Z+L5N1djuxaaHGYSkEq3kZLIArBAtL43rIahFhwP75NDj9mz7eXupMNuPwQZNZe7GJ5ZsWziKxcs549H9AuTqDEIBcdKhAbVkjR9UQCRmD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944488; c=relaxed/simple;
	bh=8aTsuHACr2frjXo/0NtlfWhF09Us83P33NSNYLo1kng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLIbyj6G5JAYk7JttiLI7nxa3VQw+fF6ZU8N8nIHCtNz8oruCjdJ5iLh1mHkZkO1Q73QYKxAtp1OKFt5RNXD1qJFKtmQWTAZet02Ls8JF9iT823G2C32izXb5dyZeh5UdbmjqW/27aMN+qbf9THMqxSoRq+IqP+QJzRg+6s1Sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP/9M23Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0284DC4CEC7;
	Thu,  3 Oct 2024 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727944487;
	bh=8aTsuHACr2frjXo/0NtlfWhF09Us83P33NSNYLo1kng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hP/9M23QfCL2QJicEtiHlHfYTLSTs7/IV4wJ55lhG3N7VPOYG1CGUpKr9A1nmDE8l
	 i9Qpf1F7FcLWpy6+g032wuarLiKbIsPglc27m3ZwH6Cb5F1JMZ03RbnsZPMjBB1eOD
	 s4l/ZZLB41h+yY6usQ39t3w/1MO7oUsefoSLGFZTK7trz1M4mjmrPQiS+ihjOPK266
	 s5lblsvik4I2nd1MP5vrE4wY0A6yp4eWySCUpU67zryYJOKByDZp1C/0bIOSnbmNsB
	 pgV5jaMeX2AVXaX4WOh9nWuOvOoB4CJtONTbWc5ss6BD5wOO+IynAXSb0HZqalcaUG
	 Lc7DXUK5ZXOBQ==
Date: Thu, 3 Oct 2024 10:34:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Pedumuru <charan.pedumuru@microchip.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: net: can: atmel: Convert to json schema
Message-ID: <xykmnsibdts7u73yu7b2vn3w55wx7puqo2nwhsji57th7lemym@f4l3ccxpevo4>
References: <20241003-can-v2-1-85701d3296dd@microchip.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003-can-v2-1-85701d3296dd@microchip.com>

On Thu, Oct 03, 2024 at 10:37:03AM +0530, Charan Pedumuru wrote:
> Convert atmel-can documentation to yaml format
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
> ---
> Changes in v2:
> - Renamed the title to "Microchip AT91 CAN controller"
> - Removed the unnecessary labels and add clock properties to examples
> - Removed if condition statements and made clock properties as default required properties
> - Link to v1: https://lore.kernel.org/r/20240912-can-v1-1-c5651b1809bb@microchip.com
> ---
>  .../bindings/net/can/atmel,at91sam9263-can.yaml    | 58 ++++++++++++++++++++++
>  .../devicetree/bindings/net/can/atmel-can.txt      | 15 ------
>  2 files changed, 58 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
> new file mode 100644
> index 000000000000..c818c01a718b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/atmel,at91sam9263-can.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip AT91 CAN Controller
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +
> +allOf:
> +  - $ref: can-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - atmel,at91sam9263-can
> +          - atmel,at91sam9x5-can
> +      - items:
> +          - enum:
> +              - microchip,sam9x60-can
> +          - const: atmel,at91sam9x5-can

That is not what old binding said.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: can_clk

These are new...

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names

Here the same. Each change to the binding should be explained (answer
to the: why) in commit msg.

> +
> +unevaluatedProperties: false

Best regards,
Krzysztof


