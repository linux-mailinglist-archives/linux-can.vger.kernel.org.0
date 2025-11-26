Return-Path: <linux-can+bounces-5694-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA69C8947A
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBFD7355D5A
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D3530149F;
	Wed, 26 Nov 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRzMj5sb"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C32FC865;
	Wed, 26 Nov 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152784; cv=none; b=aW5qrr0EJm8W5cjdAY5ZbeLMIEH5iigNxcj3ToHgjJulcNme0oaLOOxrP0UlQYc0ehFjcSKquxmvvP4xF6xc8X/e/dS7cEWTiBBuUnYuNu6sAgHdyhQsUgo3qgEmPi/gWsIbJfd1GqHYzMUJ6G8J6/F3+ZtNyVFp0OdxuZrR9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152784; c=relaxed/simple;
	bh=4o8AAgAX3uGYd5JwGNRXzhQ98L2e18JgO3QaTUdL4wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RD25jydYXLN2TCUSSsUGgbsEmeMp2QhQthO20DBjsvV7K9bg80gQZFTGGGEMMSvrlg8IdgdE6JU+7PlvmggmzPEoYxR65ECGQpeQhr/JXN6WMXPvXgSzvoond0lBCKYBYEJD4MHTu/DycxdCrC0QV0QMLYPolrUyuTkIzTGQlR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRzMj5sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEB0C113D0;
	Wed, 26 Nov 2025 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764152781;
	bh=4o8AAgAX3uGYd5JwGNRXzhQ98L2e18JgO3QaTUdL4wk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oRzMj5sbIAoKp/p53zan2Oe1zkj1Irq+jZWNQ+w2L9VJS3NlF2zYdVGlHw2a4YDR0
	 PwF5vVlbTVk7g9UADbmQTha2Mr7pnb1cLzGT86vmhahAtOZmH69rYm+LkdDf1/r+1K
	 TsDsUXg/tpIPnt+FL/XkDTwlQWM1F0uKEVgRwAo3bcOkFkv87ldVHmjRDBK1SW+Idu
	 bCueCTiskIyIsGbs4L7tCcq2jCXKwfLcmOmT07S4thKzngiYJd0aJpswdZ7cIES1mu
	 Kxbs/9xvNjwI4leTYkknyDjxVSXuiYvq4XtIoJjX8aSvNURT51G0xJy4L8dx2pSzGL
	 LBBaXRkQ+ko+g==
Message-ID: <b1511382-1fce-4a1b-a1c3-962a05fc07b5@kernel.org>
Date: Wed, 26 Nov 2025 11:26:17 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v2] dt-bindings: can: mpfs: document resets
To: Marc Kleine-Budde <mkl@pengutronix.de>, Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org
References: <20251121-sample-footsore-743d81772efc@spud>
 <20251126-famous-hummingbird-of-fruition-13a9ac-mkl@pengutronix.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251126-famous-hummingbird-of-fruition-13a9ac-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/11/2025 11:24, Marc Kleine-Budde wrote:
> Hello,
> 
> can I get a review from the DT people?

We don't always review each other patches, so you kind of have DT review
already. I can review, but I just did not plan to review this... less
work needed...

> 
> regards,
> Marc
> 
> On 21.11.2025 13:42:30, Conor Dooley wrote:
>> From: Conor Dooley <conor.dooley@microchip.com>
>>
>> The CAN cores on Polarfire SoC both have a reset. The platform firmware
>> brings both cores out of reset, but the linux driver must use them
>> during normal operation. The resets should have been made required, but
>> this is one of the things that can happen when the binding is written
>> without driver support.
>>
>> Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN controller")
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>> This is the second mistake in this binding, both spotted because of the
>> driver being written (although this one sat downstream for a while for
>> w/e reason). I wish I could say that I'd send the driver soon, but I am
>> busy upstreaming things I wrote and therefore understand at the moment,
>> so a driver that I'd have to go understand and review before sending is
>> low priority, sorry!
>>
>> v2: update the example too...
>>
>> CC: Conor Dooley <conor.dooley@microchip.com>
>> CC: Daire McNamara <daire.mcnamara@microchip.com>
>> CC: Marc Kleine-Budde <mkl@pengutronix.de>
>> CC: Vincent Mailhol <mailhol@kernel.org>
>> CC: Rob Herring <robh@kernel.org>
>> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> CC: linux-riscv@lists.infradead.org
>> CC: linux-can@vger.kernel.org
>> CC: devicetree@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>> ---
>>  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml      | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
>> index 1219c5cb601f..519a11fbe972 100644
>> --- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
>> +++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
>> @@ -32,11 +32,15 @@ properties:
>>        - description: AHB peripheral clock
>>        - description: CAN bus clock
>>
>> +  resets:
>> +    maxItems: 1
>> +
>>  required:
>>    - compatible
>>    - reg
>>    - interrupts
>>    - clocks
>> +  - resets
>>
>>  additionalProperties: false
>>
>> @@ -46,6 +50,7 @@ examples:
>>          compatible = "microchip,mpfs-can";
>>          reg = <0x2010c000 0x1000>;
>>          clocks = <&clkcfg 17>, <&clkcfg 37>;
>> +        resets = <&clkcfg 17>;
>>          interrupt-parent = <&plic>;
>>          interrupts = <56>;
>>      };
>> --
>> 2.51.0
>>
>>
>>
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


Best regards,
Krzysztof

