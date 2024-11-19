Return-Path: <linux-can+bounces-2109-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F069D2238
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 10:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A1D282251
	for <lists+linux-can@lfdr.de>; Tue, 19 Nov 2024 09:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01671B4F1C;
	Tue, 19 Nov 2024 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPlVJLAl"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A419D072;
	Tue, 19 Nov 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007440; cv=none; b=Xi/m0jZ0lKyqUH/4yf9P/fu0osFzTJiLbDfMknE/sGFu+a4XQYvnQk5PTSQtfVJwU1T1UC4RmFqkvUZ2q763WkpDJAVryPN8fTk0pfJc2ZHUeJOXQNTVsgICSuf6V8jENeQWFg2sCON0agKbvSmB3wiLAwYg0xm0JLHkc45g+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007440; c=relaxed/simple;
	bh=klvYqdvZj+RbuOlNJ198QZqAWt60/GPJdcJ4YVksHnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkxP9sGIRW4QoBS/uYZK4ZJqRkLdm+cOgXPf0zfbcJXgf3aoq703FNHGzYydhlByPnJIemh0DYOJVRYJdsn9G7C6sqJFr8Hr1dg5DMbNtzWxvlrxeTOtgfiG0NIywMi+IcnaWGIX5yB0oZgcWJ9EnrukSY+iQlPb3ZOANM5MSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPlVJLAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E930BC4CECF;
	Tue, 19 Nov 2024 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732007439;
	bh=klvYqdvZj+RbuOlNJ198QZqAWt60/GPJdcJ4YVksHnQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SPlVJLAlOgxCWtJQzSHwjCN209bg88x6pc9XD+FZ3rykPebtUGROkz4itBCBac1zP
	 H/i4n/yQpQGl1uhOJx1YNNBu2zeE8pJsVNtRZ0PsdXs0w8LWLM9NvQ31c5pXYv6qj9
	 dWg86DnZQt13T0rixVzazJXTBqkFkxS93NyHkQNX+7UTLQeyEoLKZm1qH0EQDk/BAY
	 1L5S32NdHcvQoNDV6cgJpUlSj0LKTOO6SuPcYy/Yn07LnZV0fuUP5nQMROHe642tP1
	 6M0PQuviMBUGsDmdic9JAuX7p12PzRzQdTByfh0p44s03nCNL6fcPZfzOHBrxmKq2c
	 jUYxkiKVtlcKg==
Message-ID: <81ab828c-3584-491d-8ce7-0d309758457a@kernel.org>
Date: Tue, 19 Nov 2024 10:10:31 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: can: atmel: Convert to json schema
To: Charan.Pedumuru@microchip.com
Cc: mkl@pengutronix.de, mailhol.vincent@wanadoo.fr, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241003-can-v2-1-85701d3296dd@microchip.com>
 <xykmnsibdts7u73yu7b2vn3w55wx7puqo2nwhsji57th7lemym@f4l3ccxpevo4>
 <cd3a9342-3863-4a81-9b09-db7b8da1d561@microchip.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <cd3a9342-3863-4a81-9b09-db7b8da1d561@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 06:30, Charan.Pedumuru@microchip.com wrote:
> On 03/10/24 14:04, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On Thu, Oct 03, 2024 at 10:37:03AM +0530, Charan Pedumuru wrote:
>>> Convert atmel-can documentation to yaml format
>>>
>>> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
>>> ---
>>> Changes in v2:
>>> - Renamed the title to "Microchip AT91 CAN controller"
>>> - Removed the unnecessary labels and add clock properties to examples
>>> - Removed if condition statements and made clock properties as default required properties
>>> - Link to v1: https://lore.kernel.org/r/20240912-can-v1-1-c5651b1809bb@microchip.com
>>> ---
>>>   .../bindings/net/can/atmel,at91sam9263-can.yaml    | 58 ++++++++++++++++++++++
>>>   .../devicetree/bindings/net/can/atmel-can.txt      | 15 ------
>>>   2 files changed, 58 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
>>> new file mode 100644
>>> index 000000000000..c818c01a718b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/can/atmel,at91sam9263-can.yaml
>>> @@ -0,0 +1,58 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/can/atmel,at91sam9263-can.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Microchip AT91 CAN Controller
>>> +
>>> +maintainers:
>>> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
>>> +
>>> +allOf:
>>> +  - $ref: can-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - enum:
>>> +          - atmel,at91sam9263-can
>>> +          - atmel,at91sam9x5-can
>>> +      - items:
>>> +          - enum:
>>> +              - microchip,sam9x60-can
>>> +          - const: atmel,at91sam9x5-can
>> That is not what old binding said.
> 
> Apologies for the late reply, the driver doesn't have compatible with 
> "microchip,sam9x60-can",
> so I made "atmel,at91sam9x5-can" as fallback driver

Any changes to the binding must be clearly expressed in the commit msg,
with appropriate reasoning.

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
>>> +  clock-names:
>>> +    items:
>>> +      - const: can_clk
>> These are new...
> 
> These were already defined in the previous revision.

Any changes to the binding must be clearly expressed in the commit msg,
with appropriate reasoning.


> 
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +  - clock-names
>> Here the same. Each change to the binding should be explained (answer
>> to the: why) in commit msg.
> 
> Sure, I will include the reason for changes in commit message for the 
> next revision.
> 

Why am I repeating myself...


Best regards,
Krzysztof


