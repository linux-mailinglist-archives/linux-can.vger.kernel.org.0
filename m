Return-Path: <linux-can+bounces-1890-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E509BC8E5
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 10:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A2BB23E90
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AFF1CEEB8;
	Tue,  5 Nov 2024 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv9G6haA"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F118132A;
	Tue,  5 Nov 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798195; cv=none; b=M8gBYASl/MCPgWDYZyxtsmPhhN6LwBVqMGc4me2Q8zBGgvGmyDlw/g+HGAtEeU8lmfcaorSfqXhtAl9iZGvxwmYRo2KBmAXd/tFXF8V3Y6xlsqmO9JhCfLAMrrBVeL/+G8zc0njkWy/5P9jmU/hwhuy+zMlVaBUdTUaQoRLo98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798195; c=relaxed/simple;
	bh=WcZMe9/VfUeI82nF/gy6lNIFFjy2UM0JuNhq+6rR4XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As4KEpDWIigWRBVPkat8isg7kacJXZHklGneuTMluqjjF0TPisK0tMN7vRiXLJ9w+0MX+D56kmiedDigv71fTuOkLJqyB9kICn9MSnLANfE+udscoJcBAo1nI3lN99dB4ZF7Pd+wD4wGJ8VmOGxUEJHdBhUHKOaWtibctrjiSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv9G6haA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1D8C4CECF;
	Tue,  5 Nov 2024 09:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730798194;
	bh=WcZMe9/VfUeI82nF/gy6lNIFFjy2UM0JuNhq+6rR4XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yv9G6haAugRVNUqDmDVNm9Zt+aj3atfwiskZQiuFtO2Rln71uUQcIi6iK2xqbB/gY
	 T6GsnAiaaGRwSMIXK3UENS41UL889E7z4/Rw1v+OyGr6JUk9DxWdiaIhzpmct9rRSZ
	 JqBfnr7HYhudu8njRT5qJHGlIQZrgn+47ELxcKRjnSoykYzEXyVNSu5iMp0/PCbu9e
	 M6f/xwXl6CWa/hSr1FMTvRgxMttAKQwChSoLDcMnrg3qJRs55PIL7tzZmrC9BLRQBl
	 sjo3SXwXC/CHd9Z8oyGm8EEk8WFzpKR9pXcol5bmRsdG/17Y1i+OqN+EFIqkdWlEnv
	 bDLfVRxjK59ig==
Date: Tue, 5 Nov 2024 10:16:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
Message-ID: <dq36jlwfm7hz7dstrp3bkwd6r6jzcxqo57enta3n2kibu3e7jw@krwn5nsu6a4d>
References: <20241104125342.1691516-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104125342.1691516-1-sean@geanix.com>

On Mon, Nov 04, 2024 at 01:53:40PM +0100, Sean Nyekjaer wrote:
> Convert binding doc tcan4x5x.txt to yaml.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since rfc:

That's a v2. RFC was v1. *ALWAYS*.
Try by yourself:
b4 diff 20241104125342.1691516-1-sean@geanix.com

Works? No. Should work? Yes.


>   - Tried to re-add ti,tcan4x5x wildcard
>   - Removed xceiver and vdd supplies (copy paste error)
>   - Corrected max SPI frequency
>   - Copy pasted bosch,mram-cfg from bosch,m_can.yaml
>   - device-state-gpios and device-wake-gpios only available for tcan4x5x

...

> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,tcan4552
> +          - const: ti,tcan4x5x
> +      - items:
> +          - enum:
> +              - ti,tcan4553

Odd syntax. Combine these two into one enum.

> +          - const: ti,tcan4x5x
> +      - items:

Drop items.

> +          - enum:

... and drop enum. That's just const or do you already plan to add here
entries?

> +              - ti,tcan4x5x
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: The GPIO parent interrupt.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: Hardwired output GPIO. If not defined then software reset.
> +    maxItems: 1
> +
> +  device-state-gpios:
> +    description: |

Do not need '|' unless you need to preserve formatting.

Didn't you get this comment alerady?

> +      Input GPIO that indicates if the device is in a sleep state or if the
> +      device is active. Not available with tcan4552/4553.
> +    maxItems: 1
> +
> +  device-wake-gpios:
> +    description: |
> +      Wake up GPIO to wake up the TCAN device.
> +      Not available with tcan4552/4553.
> +    maxItems: 1
> +
> +  bosch,mram-cfg:
> +    description: |
> +      Message RAM configuration data.
> +      Multiple M_CAN instances can share the same Message RAM
> +      and each element(e.g Rx FIFO or Tx Buffer and etc) number
> +      in Message RAM is also configurable, so this property is
> +      telling driver how the shared or private Message RAM are
> +      used by this M_CAN controller.
> +
> +      The format should be as follows:
> +      <offset sidf_elems xidf_elems rxf0_elems rxf1_elems rxb_elems txe_elems txb_elems>
> +      The 'offset' is an address offset of the Message RAM where
> +      the following elements start from. This is usually set to
> +      0x0 if you're using a private Message RAM. The remain cells
> +      are used to specify how many elements are used for each FIFO/Buffer.
> +
> +      M_CAN includes the following elements according to user manual:
> +      11-bit Filter	0-128 elements / 0-128 words
> +      29-bit Filter	0-64 elements / 0-128 words
> +      Rx FIFO 0		0-64 elements / 0-1152 words
> +      Rx FIFO 1		0-64 elements / 0-1152 words
> +      Rx Buffers	0-64 elements / 0-1152 words
> +      Tx Event FIFO	0-32 elements / 0-64 words
> +      Tx Buffers	0-32 elements / 0-576 words
> +
> +      Please refer to 2.4.1 Message RAM Configuration in Bosch
> +      M_CAN user manual for details.
> +    $ref: /schemas/types.yaml#/definitions/int32-array
> +    items:
> +      - description: The 'offset' is an address offset of the Message RAM where
> +          the following elements start from. This is usually set to 0x0 if
> +          you're using a private Message RAM.
> +        default: 0
> +      - description: 11-bit Filter 0-128 elements / 0-128 words
> +        minimum: 0
> +        maximum: 128
> +      - description: 29-bit Filter 0-64 elements / 0-128 words
> +        minimum: 0
> +        maximum: 64
> +      - description: Rx FIFO 0 0-64 elements / 0-1152 words
> +        minimum: 0
> +        maximum: 64
> +      - description: Rx FIFO 1 0-64 elements / 0-1152 words
> +        minimum: 0
> +        maximum: 64
> +      - description: Rx Buffers 0-64 elements / 0-1152 words
> +        minimum: 0
> +        maximum: 64
> +      - description: Tx Event FIFO 0-32 elements / 0-64 words
> +        minimum: 0
> +        maximum: 32
> +      - description: Tx Buffers 0-32 elements / 0-576 words
> +        minimum: 0
> +        maximum: 32
> +    minItems: 1
> +
> +  spi-max-frequency:
> +    description:
> +      Must be half or less of "clocks" frequency.
> +    maximum: 18000000
> +
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Enable CAN remote wakeup.
> +
> +allOf:
> +  - $ref: can-controller.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tcan4552
> +              - ti,tcan4553
> +    then:
> +      properties:
> +        device-state-gpios: false
> +        device-wake-gpios: false

Heh, this is a weird binding. It should have specific compatibles for
all other variants because above does not make sense. For 4552 one could
skip front compatible and use only fallback, right? And then add these
properties bypassing schema check. I commented on this already that
original binding is flawed and should be fixed, but no one cares then I
also don't care.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - bosch,mram-cfg
> +
> +additionalProperties: false

Implement feedback. Nothing changed here.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        can@0 {
> +            compatible = "ti,tcan4x5x";
> +            reg = <0>;
> +            clocks = <&can0_osc>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&can0_pins>;
> +            spi-max-frequency = <10000000>;
> +            bosch,mram-cfg = <0x0 0 0 16 0 0 1 1>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
> +            device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +            device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +            reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
> +            wakeup-source;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        can@0 {
> +            compatible = "ti,tcan4552","ti,tcan4x5x";

Missing space after ,.

Best regards,
Krzysztof


