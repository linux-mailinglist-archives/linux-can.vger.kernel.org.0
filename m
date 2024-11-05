Return-Path: <linux-can+bounces-1897-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056F99BCC04
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 12:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B850C281621
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDBE1D4351;
	Tue,  5 Nov 2024 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azAmcMDv"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1F1D4171;
	Tue,  5 Nov 2024 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806815; cv=none; b=TG+M+Zj+MbYvV8Na1kJmMJlWMrK9zhHs+GjRkeH9JBWBoZQSkvwGtf9CwXpAscMnbO60IvPToXhLj8dnIfh8g6JgbPe/bFpDWyYgKm/+lLZ7j8eX3WnA0EvfdY4t7LyBUI8jBThuWw8QiHfJM9kx5UMJnAl4zJ4tSJJJJEOmhC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806815; c=relaxed/simple;
	bh=J3JUWji1lzhXNZ909b7vGT3K5a5v4u3Z0AszD2xrX5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfD4wsLCnSAwTJqi8KFKRt7mCCS4i3ED5jwe/t8DGMZ6jSYv6luWQC4VUeVEN0A90+Bx9JRy5DStQDPenp8dwkwaN1BjMzRixVd8QB0hLBX3t3dC9sTWoO3ykoETgCN5RrCOoy5M9fnqLg0f9vnx8naS8US9t3CTk1pjoKbrLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azAmcMDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C142C4CECF;
	Tue,  5 Nov 2024 11:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730806815;
	bh=J3JUWji1lzhXNZ909b7vGT3K5a5v4u3Z0AszD2xrX5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=azAmcMDvyqPkxkZH3h+e/yezEfINUULXLBvj5DfrhJNTl0KxEgV8EEmrKxBolXhXH
	 llTlDeQMDtHKz1+gQ4y0cw6x6V6vMpMarLwNGxrZ8r6w7mXnMbwhbr72H3JloSYhOZ
	 1371qqRqNDJKGZOG1jmplwHNTlsg0vo0Tb6wTRQhlPI6+pOCfZsXS++Zhe/E14uepg
	 d2AN8V0owYUIuRUcm6zzw22HNU76cnV8IWWngXJXjCJD8AwFxZ1dmglfxhdxsaG2Cn
	 nxGsR547Usct4pM/7bXrADoR1wVP/RS9ueAVkdjhPrmCwUGZoVWi/b7kY55vAF+SCu
	 k64ViflKiyrDQ==
Message-ID: <60901c39-b649-4a20-a06a-7faa7ddc9346@kernel.org>
Date: Tue, 5 Nov 2024 12:40:07 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241104125342.1691516-1-sean@geanix.com>
 <dq36jlwfm7hz7dstrp3bkwd6r6jzcxqo57enta3n2kibu3e7jw@krwn5nsu6a4d>
 <wdn2rtfahf3iu6rsgxm6ctfgft7bawtp6vzhgn7dffd54i72lu@r4v5lizhae57>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <wdn2rtfahf3iu6rsgxm6ctfgft7bawtp6vzhgn7dffd54i72lu@r4v5lizhae57>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/11/2024 11:33, Sean Nyekjaer wrote:
> On Tue, Nov 05, 2024 at 10:16:30AM +0100, Krzysztof Kozlowski wrote:
>> On Mon, Nov 04, 2024 at 01:53:40PM +0100, Sean Nyekjaer wrote:
>>> Convert binding doc tcan4x5x.txt to yaml.
>>>
>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>> ---
>>> Changes since rfc:
>>
>> That's a v2. RFC was v1. *ALWAYS*.
>> Try by yourself:
>> b4 diff 20241104125342.1691516-1-sean@geanix.com
>>
>> Works? No. Should work? Yes.
>>
>>
> 
> Ok. Good to know RFC cannot be used...
> Next version would need to be? In order to fix this?
> 
> I have enrolled my patch into b4, next verison will be v2 ;)
> 

ok

>>>   - Tried to re-add ti,tcan4x5x wildcard
>>>   - Removed xceiver and vdd supplies (copy paste error)
>>>   - Corrected max SPI frequency
>>>   - Copy pasted bosch,mram-cfg from bosch,m_can.yaml
>>>   - device-state-gpios and device-wake-gpios only available for tcan4x5x
>>
>> ...
>>
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - ti,tcan4552
>>> +          - const: ti,tcan4x5x
>>> +      - items:
>>> +          - enum:
>>> +              - ti,tcan4553
>>
>> Odd syntax. Combine these two into one enum.
>>
>>> +          - const: ti,tcan4x5x
>>> +      - items:
>>
>> Drop items.
>>
>>> +          - enum:
>>
>> ... and drop enum. That's just const or do you already plan to add here
>> entries?
> 
> Honestly I'm struggling a bit with the syntax and I feel the feedback is containing
> a lot of implicit terms :)
> 
> Something like:
> properties:
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - ti,tcan4552
>               - ti,tcan4x5x
>       - items:
>           - enum:
>               - ti,tcan4553
>               - ti,tcan4x5x

No, this won't work. Just use enum for the first entry. enum stands for
enumerate, kind of like C enum, so one of many.

>       - const: ti,tcan4x5x
> 
> Gives:
> /linux/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.example.dtb: can@0: compatible: ['ti,tcan4x5x'] is valid under each of {'items': [{'enum': ['ti,tcan4553', 'ti,tcan4x5x']}], 'type': 'array', 'minItems': 1, 'maxItems': 1}, {'items': [{'const': 'ti,tcan4x5x'}], 'type': 'array', 'minItems': 1, 'maxItems': 1}, {'items': [{'enum': ['ti,tcan4552', 'ti,tcan4x5x']}], 'type': 'array', 'minItems': 1, 'maxItems': 1}
>         from schema $id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#
> /linux/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.example.dtb: can@0: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['ti,tcan4552', 'ti,tcan4x5x'] is too long
>         'ti,tcan4552' is not one of ['ti,tcan4553', 'ti,tcan4x5x']
>         'ti,tcan4x5x' was expected
>         from schema $id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#
> 
> I can understand the original binding is broken.
> I kinda agree with Marc that we cannot break things for users of this.

Hm? Absolutely nothing would get broken for users. I don't understand
these references or false claims.

> 
>>
>>> +              - ti,tcan4x5x
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +    description: The GPIO parent interrupt.
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  reset-gpios:
>>> +    description: Hardwired output GPIO. If not defined then software reset.
>>> +    maxItems: 1
>>> +
>>> +  device-state-gpios:
>>> +    description: |
>>
>> Do not need '|' unless you need to preserve formatting.
>>
>> Didn't you get this comment alerady?
>>
> 
> No, but I have removed the '|'
> 
>>> +      Input GPIO that indicates if the device is in a sleep state or if the
>>> +      device is active. Not available with tcan4552/4553.
>>> +    maxItems: 1
>>> +
>>> +  device-wake-gpios:
>>> +    description: |
>>> +      Wake up GPIO to wake up the TCAN device.
>>> +      Not available with tcan4552/4553.
>>> +    maxItems: 1
>>> +
>>> +  bosch,mram-cfg:
>>> +    description: |
>>> +      Message RAM configuration data.
>>> +      Multiple M_CAN instances can share the same Message RAM
>>> +      and each element(e.g Rx FIFO or Tx Buffer and etc) number
>>> +      in Message RAM is also configurable, so this property is
>>> +      telling driver how the shared or private Message RAM are
>>> +      used by this M_CAN controller.
>>> +
>>> +      The format should be as follows:
>>> +      <offset sidf_elems xidf_elems rxf0_elems rxf1_elems rxb_elems txe_elems txb_elems>
>>> +      The 'offset' is an address offset of the Message RAM where
>>> +      the following elements start from. This is usually set to
>>> +      0x0 if you're using a private Message RAM. The remain cells
>>> +      are used to specify how many elements are used for each FIFO/Buffer.
>>> +
>>> +      M_CAN includes the following elements according to user manual:
>>> +      11-bit Filter	0-128 elements / 0-128 words
>>> +      29-bit Filter	0-64 elements / 0-128 words
>>> +      Rx FIFO 0		0-64 elements / 0-1152 words
>>> +      Rx FIFO 1		0-64 elements / 0-1152 words
>>> +      Rx Buffers	0-64 elements / 0-1152 words
>>> +      Tx Event FIFO	0-32 elements / 0-64 words
>>> +      Tx Buffers	0-32 elements / 0-576 words
>>> +
>>> +      Please refer to 2.4.1 Message RAM Configuration in Bosch
>>> +      M_CAN user manual for details.
>>> +    $ref: /schemas/types.yaml#/definitions/int32-array
>>> +    items:
>>> +      - description: The 'offset' is an address offset of the Message RAM where
>>> +          the following elements start from. This is usually set to 0x0 if
>>> +          you're using a private Message RAM.
>>> +        default: 0
>>> +      - description: 11-bit Filter 0-128 elements / 0-128 words
>>> +        minimum: 0
>>> +        maximum: 128
>>> +      - description: 29-bit Filter 0-64 elements / 0-128 words
>>> +        minimum: 0
>>> +        maximum: 64
>>> +      - description: Rx FIFO 0 0-64 elements / 0-1152 words
>>> +        minimum: 0
>>> +        maximum: 64
>>> +      - description: Rx FIFO 1 0-64 elements / 0-1152 words
>>> +        minimum: 0
>>> +        maximum: 64
>>> +      - description: Rx Buffers 0-64 elements / 0-1152 words
>>> +        minimum: 0
>>> +        maximum: 64
>>> +      - description: Tx Event FIFO 0-32 elements / 0-64 words
>>> +        minimum: 0
>>> +        maximum: 32
>>> +      - description: Tx Buffers 0-32 elements / 0-576 words
>>> +        minimum: 0
>>> +        maximum: 32
>>> +    minItems: 1
>>> +
>>> +  spi-max-frequency:
>>> +    description:
>>> +      Must be half or less of "clocks" frequency.
>>> +    maximum: 18000000
>>> +
>>> +  wakeup-source:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description: |
>>
>> Do not need '|' unless you need to preserve formatting.
>>
> 
> OK
> 
>>> +      Enable CAN remote wakeup.
>>> +
>>> +allOf:
>>> +  - $ref: can-controller.yaml#
>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - ti,tcan4552
>>> +              - ti,tcan4553
>>> +    then:
>>> +      properties:
>>> +        device-state-gpios: false
>>> +        device-wake-gpios: false
>>
>> Heh, this is a weird binding. It should have specific compatibles for
>> all other variants because above does not make sense. For 4552 one could
>> skip front compatible and use only fallback, right? And then add these
>> properties bypassing schema check. I commented on this already that
>> original binding is flawed and should be fixed, but no one cares then I
>> also don't care.
> 
> To me it looks like the example you linked:
> https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L223

Yes, it looks, that's not the point.

> 
> If you use fallback for a 4552 then it would enable the use of the
> optional pins device-state-gpios and device-wake-gpios. But the chip
> doesn't have those so the hw guys would connect them and they won't
> be in the DT.
> 
> Honestly I'm confused :/

What stops anyone to use tcan4x5x ALONE for 4552? Nothing. And that's
the problem here.


> 
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +  - bosch,mram-cfg
>>> +
>>> +additionalProperties: false
>>
>> Implement feedback. Nothing changed here.
>>
> 
> Uh? feedback?

Yeah, CAREFULLY previous review and respond to all comments or implement
all of them (or any combination). If you leave one comment ignored, it
will mean reviewer has to do same work twice. That's very discouraging
and wasteful of my time.


Best regards,
Krzysztof


