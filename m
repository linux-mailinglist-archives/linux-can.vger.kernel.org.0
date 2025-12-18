Return-Path: <linux-can+bounces-5874-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2C7CCB506
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 11:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DA703015EE1
	for <lists+linux-can@lfdr.de>; Thu, 18 Dec 2025 10:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A90A33CEA0;
	Thu, 18 Dec 2025 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee45dr8W"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61533CE8F;
	Thu, 18 Dec 2025 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052765; cv=none; b=RcvR4MPkOzfiVz1SWGWRUr7LMDTrfXckcbWz2H9BmD7vH4cb/EMg6bQi9cvybgpqZEbUafKrNooVmTKmB9LAxfxflgIZ3FRGE1EVbAwWSBE/SabStfPtQ8kbzE8g0DqoC93dMPc3PYMu2EiFiehrQU7loVOhjuGAjRlknZ61WNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052765; c=relaxed/simple;
	bh=6dOHEO/ATrDkn+942USvFxLXBlcYFHToHWASbSwab/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeIsugzOMUKqM4Ho3CCV4T7OoxI2BxXSnzhcWgW75RhoXHke4olfjFpfbLVha5L41SJSGkciHVqMdfHltQPqOsvlJJpGzewpSSFgNH2kdhrlo2BBCd1UaI/z2wew2EMr+ZY6nj9gUpAWTyN5fAP7N88wsJ+kCH04V72jW8zSaN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee45dr8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57461C4CEFB;
	Thu, 18 Dec 2025 10:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766052764;
	bh=6dOHEO/ATrDkn+942USvFxLXBlcYFHToHWASbSwab/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ee45dr8WWCZPfh7q/vH11+3IHZH4UbFXSiCss5Y/a45Q22Fy1RjBmpMAxrDRDBfjM
	 WOyWJmCu90cTRaElaHvfv6EzTwWosJHYCBZjk+rMwOTQxl3cVcIe5+vUZE89sw45v9
	 u8sACM0BsAHj8NlYxHehm1DiOyKbBBVi5RGgNET/eEsAvks2P2gr1oGnUDZmTDLA7+
	 bUnVRfSLJLhrv7pr8CapTQc8FLdQ+TSGtQE1YDkh3tPkBmLRAIwDyPUeGiVNbjlIuk
	 /7rN1Up4Y34iHCQUfNiRJQXQjleO9y+MHOsf99d9F9bW8h5RdDe3VwKpmONllYG5/6
	 Pa7jOXlzyFfdA==
Message-ID: <b7fdd6d7-fd56-4e3a-84da-191411f9edd6@kernel.org>
Date: Thu, 18 Dec 2025 11:12:40 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] dt-bindings: net: can: grcan: Convert GRCAN CAN
 controllers binding from txt to YAML
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mkl@pengutronix.de, mailhol@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-3-arun.muthusamy@gaisler.com>
 <c80ff180-b7f1-4f39-b39d-2953ef75a7ad@kernel.org>
 <13d562aa-3425-4753-a78f-dd268dd78794@gaisler.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <13d562aa-3425-4753-a78f-dd268dd78794@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/2025 11:11, Arun Muthusamy wrote:
> Hi Krzysztof,
> 
> Thank you for your thorough review. I’d like to clarify a few points 
> regarding the DT binding and get your guidance.
> 
> On 11/18/25 12:01, Krzysztof Kozlowski wrote:
>> On 18/11/2025 10:21, Arun Muthusamy wrote:
>>> +      Fallback on node name matching for systems that don't provide compatible.
>>> +    enum:
>>> +      - GAISLER_GRCAN
>>> +      - 01_03d
>>> +      - GAISLER_GRHCAN
>>> +      - "01_034"
>> This does not really work. Are you really defining here "name" property?
> 
> The driver supports two of the platforms which are LEON and NOEL 

I don't care much about driver. Please describe here hardware.

> platforms. PROM-based *LEON* systems identify uses the "node name" 
> property, while DTS based *NOEL* systems use proper "|compatible"|strings. On LEON (SPARC32), AMBA Plug & Play information creates the DT 
> properties, and drivers historically match devices based on node names.
> To reflect this, I updated the $nodename pattern to support LEON-style 
> node names: properties:
>    $nodename:
>      pattern: "^(GAISLER_GRCAN|01_03d|GAISLER_GRHCAN|01_034)$" I’d 
> appreciate any suggestions on the preferred way to describe this node 
> name for PROM-based LEON.
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
>>> +  freq:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: |
>>> +      Frequency of the external oscillator clock in Hz (the frequency of the
>>> +      amba bus in the ordinary case).
>>> +      This property should be used by systems that utilize the common clock
>>> +      framework is not supported.
>> Missing systemid. Your commit msg must explain any changes done to the
>> binding during conversion.
> 
> The driver now reads systemid directly from /ambapp0, so the property no 
> longer needs to be defined in the DTS. The previous documentation was 
> outdated and should have been updated after commit:
> 1e93ed26acf0 ("can: grcan: grcan_probe(): fix broken system id check for 
> errata workaround needs").

Read again what I wrote.

> 
>>> +  - reg
>>> +  - interrupts
>> Where is freq? It was required in the old binding. Again, you need to
>> explain the changes.
> 
> LEON: relies on the freq property
> NOEL: uses a standard clocks binding
> Because of this dual approach, the freq property is no longer required 
> in the DTS binding itself as theAMBA Plug & Play creates the DT properties.


Please read my comment carefully: you need to explain the changes. But
not to me, to everyone in the commit msg.

Best regards,
Krzysztof

