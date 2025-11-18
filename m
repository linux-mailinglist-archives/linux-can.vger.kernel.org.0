Return-Path: <linux-can+bounces-5492-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E32C9C68F79
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 12:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E904F368113
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FBD34EEE5;
	Tue, 18 Nov 2025 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlsEO2EG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0631E30F93D;
	Tue, 18 Nov 2025 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463689; cv=none; b=ht4GNvpJa7JA0BbkuhyJxlW5iDr3D70brF4lj3THA9nvRdIZDMGVyUnUhMN/TvStp0iqIEPAmyTtNHQKxJHAAxvMcw2D/QVAEFRyQoB5+lGZsUAhCusBKG5T2QKphIExjy3vfVsYdXOg+I8cO7JqdZ4Qo6pmJggMLGxuPoK4XmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463689; c=relaxed/simple;
	bh=uok+B2Z7XE3AZp+57kOj9hdVIWnfU4Y4NqGvngz1qdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htX83tWTT4tydISvlHYlJxmtrhSeBto0JMxieQED529tkgokYGqcNxhGZtArbo6urwE9XsBWh2mTm1u+k3lRbX2FNYPB9NbBF5JHe088LENhc0Wo1iv6GadYHVdd1TJzh8WiXEewXGAaQqbLkXhMvIYpQg3H5mgkJC8i3K7eong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlsEO2EG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B9FC4AF09;
	Tue, 18 Nov 2025 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763463688;
	bh=uok+B2Z7XE3AZp+57kOj9hdVIWnfU4Y4NqGvngz1qdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XlsEO2EG7fv1K3vRIutWVDb1QBZDeDWaXOaOphQNnnx1rx9/5/fFizMeRcBXSE2qi
	 icH+cx1XQVDvTZV5D7uqaRyOX6UFMvUsqy5x7ep2m624o86tlioa6tftAx/4Or/ZoU
	 xdc6i82qdXkW3QTqFh2wX8KMl+K0LmurUpzpsCbsFe86LuKxvAaWTEGMryATgvEGuU
	 tC4v0NaSo8GamUHBpmc4KbrcqmdfCl8wiecD6d1pXRrzONaEqkcccOR76KOQZT8yK+
	 FUwMkIOrqYsGlJRROkODoZUEVdo2V1b2tF/xHIXH/HBgDZEg6eDX6mBROnIkg86mXF
	 F/i786AIR8B8Q==
Message-ID: <c80ff180-b7f1-4f39-b39d-2953ef75a7ad@kernel.org>
Date: Tue, 18 Nov 2025 12:01:23 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] dt-bindings: net: can: grcan: Convert GRCAN CAN
 controllers binding from txt to YAML
To: Arun Muthusamy <arun.muthusamy@gaisler.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mkl@pengutronix.de,
 mailhol@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-3-arun.muthusamy@gaisler.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251118092115.3455-3-arun.muthusamy@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/11/2025 10:21, Arun Muthusamy wrote:
> Migrate device tree bindings for Gaisler GRCAN, GRHCAN
> and GRCANFD CAN controllers from a text format to YAML format.
>     - Add properties such as `compatible`, `reg`, `interrupts`

Odd indentation. Please write readable commit msgs.

Also:
1. Why? You need to explain why you are changing binding during conversion.
2. Reg was already there, so I don't understand why you need to add it.


>     and `clocks` for the CAN controllers.
>     - Removal of the old `grcan.txt` file as its contents have
>     been fully migrated to the YAML file.

Drop, that's not relevant.

>     - YAML file includes examples of device tree bindings for
>     the CAN controllers

Drop, not relevant. Please look at git history how commits are written.

> 
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  .../bindings/net/can/gaisler,grcan.yaml       | 85 +++++++++++++++++++
>  .../devicetree/bindings/net/can/grcan.txt     | 28 ------
>  2 files changed, 85 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
> new file mode 100644
> index 000000000000..521bdd89f130
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/gaisler,grcan.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  Aeroflex Gaisler GRCAN, GRHCAN and GRCANFD CAN controllers.
> +
> +description: |
> +  GRCAN, GRCANFD, GRHCAN controllers are available in the GRLIB VHDL IP core
> +  library.
> +
> +  For further information look in the documentation for the GRLIB IP library:
> +  https://download.gaisler.com/products/GRLIB/doc/grip.pdf
> +
> +maintainers:
> +  - Arun Muthusamy <arun.muthusamy@gaisler.com>
> +  - Andreas Larsson <andreas@gaisler.com>
> +
> +allOf:
> +  - $ref: can-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - gaisler,grcan
> +      - gaisler,grcanfd

Blank line

> +  name:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Fallback on node name matching for systems that don't provide compatible.
> +    enum:
> +      - GAISLER_GRCAN
> +      - 01_03d
> +      - GAISLER_GRHCAN
> +      - "01_034"

This does not really work. Are you really defining here "name" property?

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
> +  freq:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Frequency of the external oscillator clock in Hz (the frequency of the
> +      amba bus in the ordinary case).
> +      This property should be used by systems that utilize the common clock
> +      framework is not supported.

Missing systemid. Your commit msg must explain any changes done to the
binding during conversion.

> +
> +unevaluatedProperties: false

This goes after required block.

> +
> +required:

compatible as well

> +  - reg
> +  - interrupts

Where is freq? It was required in the old binding. Again, you need to
explain the changes.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    can@ff400000 {
> +        compatible = "gaisler,grcanfd";
> +        clocks = <&sysclock>;
> +        reg = <0xff400000 0x400>;
> +        interrupt-parent = <&plic0>;
> +        interrupts = <6>;
> +    };

One example is enough

> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    can@ff400000 {
> +        compatible = "gaisler,grcan";
> +        clocks = <&sysclock>;
> +        reg = <0xff400000 0x400>;
> +        interrupt-parent = <&plic0>;
> +        interrupts = <6>;
> +    };
> +  - |
> +    GAISLER_GRCAN@ff840000 {

Especially no such examples. Please read DTS coding style.

> +        reg = <0xff840000 0x400>;
> +        freq = <50000000>;
> +        interrupts = <16>;
> +    };
> diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt b/Documentation/devicetree/bindings/net/can/grcan.txt
> deleted file mode 100644
> index 34ef3498f887..000000000000
> --- a/Documentation/devicetree/bindings/net/can/grcan.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
Best regards,
Krzysztof

