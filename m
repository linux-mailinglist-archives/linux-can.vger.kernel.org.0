Return-Path: <linux-can+bounces-1863-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B319BAFA2
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 10:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4515F1C2113C
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 09:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13711AF0CA;
	Mon,  4 Nov 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECss2UuK"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675181AF0C1;
	Mon,  4 Nov 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712431; cv=none; b=Zb7Ln9KI4i5OvV8F8xEQpXbhSIzCMe6zRGkQcriP4i2cMsXmlgmPetSl5egaCjGOCL52JalPS3vTaVpNQ/HHuwTydckylNUqEU1PXUDimcYcRcttlomUZVeFvkRbCStReMb3jn45WZT2zCimqjZ/Dkjor71wZDmXQr9k4Fb2SMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712431; c=relaxed/simple;
	bh=RmAf5WVXMgeReQ9nyzDoW0ADU9Q9iVypsXAJmIMnRSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C55RMnIlF3aZ8rTLENcjxECDZihrm4DPo9DY84RuUFA+cXO05RGmmLl2sbyLEB+ilLnNv8VGsbQgj0yEh4O/rH6GlTnwvHdUJqNCibgldJJnEQ+pidmw690BCY4mQgbsHySWKmn6yA+XXj0IUhdjxwZmV3f3KfhtSe9lglmWcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECss2UuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FE4C4CECE;
	Mon,  4 Nov 2024 09:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730712430;
	bh=RmAf5WVXMgeReQ9nyzDoW0ADU9Q9iVypsXAJmIMnRSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ECss2UuKA5lrpWqkg+uiOcbfQZpkwKNRZ5bjTLNWn0fHdNvgdoVuz3YFFnu1bJOGA
	 6Vd+s/cJuRwREmdNLI9SThmlsf5KOYbQMN4H/3ZevDW6DGePtttv9MgX7Ku/I9t2Lw
	 DfS6YM3t7A4RgwEwbciSE9h3MkuGnw5ryOF3qh5babvniyjrktmBXx0zKgYY6Rn+NS
	 kJgrisuHbIIWlEeXEMHYasPEGiwUy0kGZaOtG69g+mvbEjOi/JZkD/gziSxx8uaDf0
	 XJ3WnoJ2vwNWw/Yr++TvXk2T7qutTdn7puaTqnKGjKh7Mmc0EVpzdMijDQvoZuQdX2
	 7BoZ3qgTRXbwQ==
Message-ID: <ee47c6d7-4197-4f5d-b39e-aab70a9337d6@kernel.org>
Date: Mon, 4 Nov 2024 10:27:04 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
To: Sean Nyekjaer <sean@geanix.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241104085616.469862-1-sean@geanix.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <20241104085616.469862-1-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2024 09:56, Sean Nyekjaer wrote:
> Convert binding doc tcan4x5x.txt to yaml.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> 
> Can we somehow reference bosch,mram-cfg from the bosch,m_can.yaml?
> I have searched for yaml files that tries the same, but it's usually
> includes a whole node.
> 
> I have also tried:
> $ref: /schema/bosch,m_can.yaml#/properties/bosch,mram-cfg

Yes, this would work just with full path, so /schemas/net/can/...

See:
Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml

But you can also just copy it. Ideally this should be moved to common
schema or replaced with more generic property, but these do not have to
be part of this conversion.

> 
> Any hints to share a property?
> 
>  .../devicetree/bindings/net/can/tcan4x5x.txt  | 48 ---------
>  .../bindings/net/can/ti,tcan4x5x.yaml         | 97 +++++++++++++++++++
>  2 files changed, 97 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>  create mode 100644 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> 

...

> diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> new file mode 100644
> index 000000000000..62c108fac6b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TCAN4x5x CAN Controller
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
> +      - enum:
> +          - ti,tcan4552
> +          - ti,tcan4553
> +          - ti,tcan4x5x

That's not really what old binding said.

It said for example:
"ti,tcan4552", "ti,tcan4x5x"

Which is not allowed above. You need list. Considering there are no
in-tree users of ti,tcan4x5x alone, I would allow only lists followed by
ti,tcan4x5x. IOW: disallow ti,tcan4x5x alone.

Mention this change to the binding in the commit message.


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
> +  vdd-supply:
> +    description: Regulator that powers the CAN controller.
> +
> +  xceiver-supply:
> +    description: Regulator that powers the CAN transceiver.

You need to mention all changes done to the binding in the commit msg.

> +
> +  reset-gpios:
> +    description: Hardwired output GPIO. If not defined then software reset.
> +    maxItems: 1
> +
> +  device-state-gpios:
> +    description: Input GPIO that indicates if the device is in a sleep state or if the device is active.
> +      Not available with tcan4552/4553.
> +    maxItems: 1
> +
> +  device-wake-gpios:
> +    description: Wake up GPIO to wake up the TCAN device. Not available with tcan4552/4553.
> +    maxItems: 1
> +
> +  bosch,mram-cfg:
> +    $ref: bosch,m_can.yaml#
> +
> +  spi-max-frequency:
> +    description:
> +      Must be half or less of "clocks" frequency.
> +    maximum: 10000000

Old binding said 18 MHz?

> +
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enable CAN remote wakeup.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - bosch,mram-cfg
> +

Missing allOf: with $ref to spi-peripheral-props. See other SPI devices.


> +additionalProperties: false

And this becomes unevaluatedProperties: false

Best regards,
Krzysztof


