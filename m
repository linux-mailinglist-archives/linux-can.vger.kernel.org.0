Return-Path: <linux-can+bounces-1870-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E59BB3D6
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 12:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CB3B25D8C
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F301B21AF;
	Mon,  4 Nov 2024 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjYy3U1A"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AA185B4D;
	Mon,  4 Nov 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720253; cv=none; b=ChZAH+98QLq9Rqo5ZmUSrBbtrX9tsuyDb+UtXQx5Osp68rCBLDp8bDIGWKmmdcOV/mv44PEInPbJQjzTTYpwr8Ic6uORzecgsm/XPZoQBp2VFtn5F++XKvEVGSszjhC8OOAmn+L9t3jUFmiJXkrkiRPnUZo8OlAeBuby9Ts8my8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720253; c=relaxed/simple;
	bh=r0F7WWieVy3G1VNWPIWM2T4e1JEAK4pK6vQsE3LT8/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICz+ZuixrW3cP6Pjsjj3/HleLwiJwCn6NqCtGheW+ErDs8WGGn0SQlZYef9BNbIxhQcn0Sdnma6VAwGM7OotwoI52YsEYn3/M0GgExDD+gdln9J2eJbQ575Utx/1jfil/UXr0NSu6+JTjWUFhWpBcPjCiviM/0WJnZeurnl52Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjYy3U1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F67C4CECE;
	Mon,  4 Nov 2024 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730720252;
	bh=r0F7WWieVy3G1VNWPIWM2T4e1JEAK4pK6vQsE3LT8/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WjYy3U1AobPrUtwdAIEqkg0GLwohYbqHHLLiXv53qNDF1oik49YeZmX9T9naY3H2s
	 AsHCzYY2Ld/iRPoOcVGt1I4QvsweQZqnDDPRjmrDg3ysXuZS+jTAEU6lo/la0zecLt
	 6iuPYlPtY0GoVff5TGjm712paAM61lqNRs8WIrfcC9LI3//pWHFWeEQ8Mz8lkq4BHo
	 bYKqxtMSL86VC/Nr81+YaFNaxhoWo0HBSIufAFXHq/yPPp1LB9Bz9qpVp47grgE5Ij
	 KzVM8PhfXg4V9UTUPSPvwxoX0Ot6sfYvbmYvBV0yNoy5Fvp0F5mYPsECmym5UZEpJk
	 4qMDnFLMGPTWg==
Message-ID: <ff191ee3-bacc-48ed-86a8-2e60ebecc391@kernel.org>
Date: Mon, 4 Nov 2024 12:37:24 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241104085616.469862-1-sean@geanix.com>
 <ee47c6d7-4197-4f5d-b39e-aab70a9337d6@kernel.org>
 <2mx3fpwo5miho3tdhfbt7ogwnifnhe7qlvjs3zjb2y2iifgjwo@23mxoxvwsogy>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <2mx3fpwo5miho3tdhfbt7ogwnifnhe7qlvjs3zjb2y2iifgjwo@23mxoxvwsogy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2024 11:54, Sean Nyekjaer wrote:
> 
> diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> index 9ff52b8b3063..0fc37b10e899 100644
> --- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> +++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> @@ -50,7 +50,7 @@ properties:
>      maxItems: 1
> 
>    bosch,mram-cfg:
> -    $ref: bosch,m_can.yaml#
> +    $ref: /schemas/net/can/bosch,m_can.yaml#/properties/bosch,mram-cfg
> 
>    spi-max-frequency:
>      description:
> 
> Still results in:
> % make dt_binding_check DT_SCHEMA_FILES=ti,tcan4x5x.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   Documentation/devicetree/bindings
> Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml: properties:bosch,mram-cfg: 'anyOf' conditional failed, one must be fixed:
>         'description' is a dependency of '$ref'
>         '/schemas/net/can/bosch,m_can.yaml#/properties/bosch,mram-cfg' does not match 'types.yaml#/definitions/'
>                 hint: A vendor property needs a $ref to types.yaml
>         '/schemas/net/can/bosch,m_can.yaml#/properties/bosch,mram-cfg' does not match '^#/(definitions|\\$defs)/'
>                 hint: A vendor property can have a $ref to a a $defs schema
>         hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
>         from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

Yeah, probably not much benefits of referencing other schema. Just copy
the property.

> 
>>
>>>
>>> Any hints to share a property?
>>>
>>>  .../devicetree/bindings/net/can/tcan4x5x.txt  | 48 ---------
>>>  .../bindings/net/can/ti,tcan4x5x.yaml         | 97 +++++++++++++++++++
>>>  2 files changed, 97 insertions(+), 48 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>>  create mode 100644 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
>>>
>>
>> ...
>>
>>> diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
>>> new file mode 100644
>>> index 000000000000..62c108fac6b3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
>>> @@ -0,0 +1,97 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Texas Instruments TCAN4x5x CAN Controller
>>> +
>>> +maintainers:
>>> +  - Marc Kleine-Budde <mkl@pengutronix.de>
>>> +
>>> +allOf:
>>> +  - $ref: can-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - enum:
>>> +          - ti,tcan4552
>>> +          - ti,tcan4553
>>> +          - ti,tcan4x5x
>>
>> That's not really what old binding said.
>>
>> It said for example:
>> "ti,tcan4552", "ti,tcan4x5x"
>>
>> Which is not allowed above. You need list. Considering there are no
>> in-tree users of ti,tcan4x5x alone, I would allow only lists followed by
>> ti,tcan4x5x. IOW: disallow ti,tcan4x5x alone.
>>
>> Mention this change to the binding in the commit message.
>>
>>
> 
> I would prefer to not change anything other that doing the conversion to
> DT schema.

Well, above you changed a lot :/, but fine - wildcard can stay. But
anyway compatible list has to be fixed.

> 
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  vdd-supply:
>>> +    description: Regulator that powers the CAN controller.
>>> +
>>> +  xceiver-supply:
>>> +    description: Regulator that powers the CAN transceiver.
>>
>> You need to mention all changes done to the binding in the commit msg.
>>
> Is this a change? It existed in the old doc aswell...

Where? I pointed out that this is a change. I cannot find it. If you
disagree, please point to the patch. And it's tricky for me to prove my
point - to show that such thing did not exist...


Two more comments below:

> 
>>> +
>>> +  reset-gpios:
>>> +    description: Hardwired output GPIO. If not defined then software reset.
>>> +    maxItems: 1
>>> +
>>> +  device-state-gpios:
>>> +    description: Input GPIO that indicates if the device is in a sleep state or if the device is active.

Please wrap code according to coding style (checkpatch is not a coding
style description, but only a tool).


>>> +      Not available with tcan4552/4553.

Then you need if:then: inside allOf: block disallowing it for this variant.
https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L223



Best regards,
Krzysztof


