Return-Path: <linux-can+bounces-5856-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED8CB577F
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 11:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2620A30173B7
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 10:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B792FE06C;
	Thu, 11 Dec 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="cP0XU75m"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46B2F5A0D;
	Thu, 11 Dec 2025 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447882; cv=none; b=pmHmhFPfjLfVJ7BDCbHd2EqqIH6ndNVERnk61yFSB4D2PxqV5IUMLr092CwvoxOhPaMGR5lRLBg68yUxtdkugyA7/qFbdW8i1E/Ln0mrJ1sJDnnFt+h/N6gtNu0JnfcC5k6iOJ22KK/S0B2aKCIoXLGJ09FzOG5MfhBGWTNGGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447882; c=relaxed/simple;
	bh=u7mfOzFflvlmdugnRuTbOtY+B85m2Y0zNY6dWa5DwpQ=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=WgJ6bgm8AmGieR38x6CKl4eAxpE7Gz7lxQGjtN8ZxNt8a9kDpzSajYv06nAN6fLEInnxP468zIO/oOgZHW5deaDXT7plmfA0wPgRdw86faqhFU0dhtUOhow3zbmExp+aIO2anUgViB4AEs8AC7wnehx//hQNW8B+RbFkvTPnhOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=cP0XU75m reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dRpJj0kHFz1FDXb;
	Thu, 11 Dec 2025 11:11:17 +0100 (CET)
Received: from [192.168.0.5] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4dRpJh3VZwz1DQrn;
	Thu, 11 Dec 2025 11:11:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1765447876;
	bh=IrA8Rt8OM9kn2f8ZmSosLYepoEWZ+S7sOHvBlYVY+AU=;
	h=Date:Subject:References:From:To:Cc:In-Reply-To;
	b=cP0XU75m0Zbaz/9xumZh2UTvebk8L+SJ1IQaK0an6xWBX8xqqeCTBKtVtEedRi7p+
	 vZZoZQZKjNDXnLbS3uYDouWtp2SVufzm0fk2mDdwXTk38PIYykb/S4J7nI2b3aKe/0
	 rTAvlx6e1GJltn95OA+Za2IZOrZITR4av7MeXB5Qfk+uK4/FgF6+yLtauBJxAIjXUl
	 rHc7T2mcL9foA90VbQz0N8x15W0bqJCIkXv3Ct7rvYPxLG9kGSOXLqT+WWcmtWO8ba
	 VA7+ayAhXfONI+n3lqyMc9Rn9N0xw+Hsygy73NT6HUVe4c56bGWHFyQOynxeDG3ui0
	 c8cJUCvkUTkQA==
Message-ID: <13d562aa-3425-4753-a78f-dd268dd78794@gaisler.com>
Date: Thu, 11 Dec 2025 11:11:16 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] dt-bindings: net: can: grcan: Convert GRCAN CAN
 controllers binding from txt to YAML
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-3-arun.muthusamy@gaisler.com>
 <c80ff180-b7f1-4f39-b39d-2953ef75a7ad@kernel.org>
Content-Language: en-US
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mkl@pengutronix.de, mailhol@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
In-Reply-To: <c80ff180-b7f1-4f39-b39d-2953ef75a7ad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thank you for your thorough review. I’d like to clarify a few points 
regarding the DT binding and get your guidance.

On 11/18/25 12:01, Krzysztof Kozlowski wrote:
> On 18/11/2025 10:21, Arun Muthusamy wrote:
>> +      Fallback on node name matching for systems that don't provide compatible.
>> +    enum:
>> +      - GAISLER_GRCAN
>> +      - 01_03d
>> +      - GAISLER_GRHCAN
>> +      - "01_034"
> This does not really work. Are you really defining here "name" property?

The driver supports two of the platforms which are LEON and NOEL 
platforms. PROM-based *LEON* systems identify uses the "node name" 
property, while DTS based *NOEL* systems use proper "|compatible"|strings. On LEON (SPARC32), AMBA Plug & Play information creates the DT 
properties, and drivers historically match devices based on node names.
To reflect this, I updated the $nodename pattern to support LEON-style 
node names: properties:
   $nodename:
     pattern: "^(GAISLER_GRCAN|01_03d|GAISLER_GRHCAN|01_034)$" I’d 
appreciate any suggestions on the preferred way to describe this node 
name for PROM-based LEON.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  freq:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Frequency of the external oscillator clock in Hz (the frequency of the
>> +      amba bus in the ordinary case).
>> +      This property should be used by systems that utilize the common clock
>> +      framework is not supported.
> Missing systemid. Your commit msg must explain any changes done to the
> binding during conversion.

The driver now reads systemid directly from /ambapp0, so the property no 
longer needs to be defined in the DTS. The previous documentation was 
outdated and should have been updated after commit:
1e93ed26acf0 ("can: grcan: grcan_probe(): fix broken system id check for 
errata workaround needs").

>> +  - reg
>> +  - interrupts
> Where is freq? It was required in the old binding. Again, you need to
> explain the changes.

LEON: relies on the freq property
NOEL: uses a standard clocks binding
Because of this dual approach, the freq property is no longer required 
in the DTS binding itself as theAMBA Plug & Play creates the DT properties.


Thanks,

-- 
BR,

Arun Muthusamy
Software Engineer
Frontgrade Gaisler
T : +46 (0) 700 558 528
arun.muthusamy@gaisler.com

Frontgrade Gaisler AB, Kungsgatan 12, SE-411 19 GÖTEBORG, Sweden.
+46 (0) 31 775 8650,www.gaisler.com <http://www.gaisler.com/>



