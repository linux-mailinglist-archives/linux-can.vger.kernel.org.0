Return-Path: <linux-can+bounces-5625-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B82F4C7FAA9
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 10:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 976854E1F46
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B4E2F5A2E;
	Mon, 24 Nov 2025 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="RMnZiwRB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1516298CDE;
	Mon, 24 Nov 2025 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977072; cv=none; b=mO40HiUpshP3yckypW1+p0dkENZmCJemDFFIOaFwtc4vUViZs7J54dV/SPwRmqKWfFxUjHyUeyxdCItRbecUbaWNxc4aDKJxtAN0qJ9PfWUD6nF/bl3AYkeE8MnezFMVcQauBx2LNfmhm3bEvkHc62p3d7WwMkH6Pyktaxt9wss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977072; c=relaxed/simple;
	bh=OUcqUXgGbP6eAxa1vKyXPabf+sNbu+8uQMnb93koNbQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MHGoMryv60cPDs9TK2GMnjEvTq48jKFS8/ulfPF68Wb7XW99qzCEk4PiM6xix88A0jYhrkTl1k/LtxPyS1zH3QiM3oLMalkPIfxwzinFJ273SeXHpxFICGhoLikM+G0qbJ6NASoJ3rvqNTSD57bFVnAg+qU69OayCMv+KGm445I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=RMnZiwRB reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dFLMm4mFQz1DQqj;
	Mon, 24 Nov 2025 10:37:40 +0100 (CET)
Received: from webmail.unoeuro.com (webmail.unoeuro.com [94.231.108.230])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dFLMm2JG5z1DDMw;
	Mon, 24 Nov 2025 10:37:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763977060;
	bh=0vnLtD++Kf5gEEMlvyKAgAvSHBCasjk67eNgc0nbTjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RMnZiwRBdYZtC6h0oOjCFotdHY8S5D1MMptKfgN9cjHRUlIF3AzDg+ybacd5YlAgw
	 XRa1YwN4N4/7dk5Ua7Ts4KajoKJMsx4jCZHhyYs1CmYY9Nll82aAYky+/PI7THG57t
	 f3JRJniGRWA3AaqPu4rVQdS8oOsit8rRUIGJ2yyRgpTcznUZRpVe5+n1lzoOrS2zU3
	 JjZv1aQWbgwucgIa3DTvM8D9Djlxp1/BSoyXqohRYxQihKwiT3389IZTEno5TVeH3M
	 l5gcEa8ukjxi28tkBZZIw4cYPI2YIXYtCSmSHNpLhc1zpvKkvWnAO64aCJfkdW71Vs
	 /eCamRoSvDUGQ==
Received: from h-98-128-223-123.NA.cust.bahnhof.se ([98.128.223.123])
 by webmail.simply.com
 with HTTP (HTTP/2.0 POST); Mon, 24 Nov 2025 10:37:40 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Nov 2025 10:37:40 +0100
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mkl@pengutronix.de, mailhol@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: net: can: grcan: Convert GRCAN CAN
 controllers binding from txt to YAML
In-Reply-To: <c80ff180-b7f1-4f39-b39d-2953ef75a7ad@kernel.org>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-3-arun.muthusamy@gaisler.com>
 <c80ff180-b7f1-4f39-b39d-2953ef75a7ad@kernel.org>
User-Agent: Simply.com webmail
Message-ID: <a5d8543b27adc6adf8bec2f3548f13b0@gaisler.com>
X-Sender: arun.muthusamy@gaisler.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thank you for your thorough review and insightful questions. I’d like to 
clarify a few points regarding the DT binding and get your guidance.

Node name vs. compatible matching:
SPARC systems do not use DTS files; the device tree is generated by the 
PROM. On LEON (SPARC32), AMBA Plug & Play information creates the DT 
properties, and drivers historically match devices based on node names.
For DTS-based systems such as NOEL, this patch series adds 
compatible-string matching. To reflect this, I updated the $nodename 
pattern to support LEON-style node names:
properties:
   $nodename:
     pattern: "^(GAISLER_GRCAN|01_03d|GAISLER_GRHCAN|01_034)$"
I’d appreciate any suggestions on the preferred way to describe this 
dual matching approach: node name for PROM-based LEON, compatible string 
for DTS-based NOEL.


Freq and Clocks:
The driver needs to support both LEON and NOEL platforms:
LEON: relies on the freq property
NOEL: uses a standard clocks binding
Because of this dual approach, the freq property is no longer required 
in the DTS binding itself.
It is only relevant for LEON/PROM-based systems and is handled 
internally by the driver


Systemid:
The driver now reads systemid directly from /ambapp0, so the property no 
longer needs to be defined in the DTS. The previous documentation was 
outdated and should have been updated after commit:
1e93ed26acf0 ("can: grcan: grcan_probe(): fix broken system id check for 
errata workaround needs")


Thanks,

-- 
BR,

Arun Muthusamy
Software Engineer
Frontgrade Gaisler
T : +46 (0) 700 558 528
arun.muthusamy@gaisler.com

Frontgrade Gaisler AB, Kungsgatan 12, SE-411 19 GÖTEBORG, Sweden.
+46 (0) 31 775 8650, www.gaisler.com

On 18.11.2025 12:01, Krzysztof Kozlowski wrote:
> On 18/11/2025 10:21, Arun Muthusamy wrote:
>> Migrate device tree bindings for Gaisler GRCAN, GRHCAN
>> and GRCANFD CAN controllers from a text format to YAML format.
>>     - Add properties such as `compatible`, `reg`, `interrupts`
> 
> Odd indentation. Please write readable commit msgs.
> 
> Also:
> 1. Why? You need to explain why you are changing binding during 
> conversion.
> 2. Reg was already there, so I don't understand why you need to add it.
> 
> 
>>     and `clocks` for the CAN controllers.
>>     - Removal of the old `grcan.txt` file as its contents have
>>     been fully migrated to the YAML file.
> 
> Drop, that's not relevant.
> 
>>     - YAML file includes examples of device tree bindings for
>>     the CAN controllers
> 
> Drop, not relevant. Please look at git history how commits are written.
> 
>> 
>> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
>> ---
>>  .../bindings/net/can/gaisler,grcan.yaml       | 85 
>> +++++++++++++++++++
>>  .../devicetree/bindings/net/can/grcan.txt     | 28 ------
>>  2 files changed, 85 insertions(+), 28 deletions(-)
>>  create mode 100644 
>> Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
>>  delete mode 100644 
>> Documentation/devicetree/bindings/net/can/grcan.txt
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml 
>> b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
>> new file mode 100644
>> index 000000000000..521bdd89f130
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
>> @@ -0,0 +1,85 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/can/gaisler,grcan.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title:
>> +  Aeroflex Gaisler GRCAN, GRHCAN and GRCANFD CAN controllers.
>> +
>> +description: |
>> +  GRCAN, GRCANFD, GRHCAN controllers are available in the GRLIB VHDL 
>> IP core
>> +  library.
>> +
>> +  For further information look in the documentation for the GRLIB IP 
>> library:
>> +  https://download.gaisler.com/products/GRLIB/doc/grip.pdf
>> +
>> +maintainers:
>> +  - Arun Muthusamy <arun.muthusamy@gaisler.com>
>> +  - Andreas Larsson <andreas@gaisler.com>
>> +
>> +allOf:
>> +  - $ref: can-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - gaisler,grcan
>> +      - gaisler,grcanfd
> 
> Blank line
> 
>> +  name:
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +      Fallback on node name matching for systems that don't provide 
>> compatible.
>> +    enum:
>> +      - GAISLER_GRCAN
>> +      - 01_03d
>> +      - GAISLER_GRHCAN
>> +      - "01_034"
> 
> This does not really work. Are you really defining here "name" 
> property?
> 
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
>> +      Frequency of the external oscillator clock in Hz (the frequency 
>> of the
>> +      amba bus in the ordinary case).
>> +      This property should be used by systems that utilize the common 
>> clock
>> +      framework is not supported.
> 
> Missing systemid. Your commit msg must explain any changes done to the
> binding during conversion.
> 
>> +
>> +unevaluatedProperties: false
> 
> This goes after required block.
> 
>> +
>> +required:
> 
> compatible as well
> 
>> +  - reg
>> +  - interrupts
> 
> Where is freq? It was required in the old binding. Again, you need to
> explain the changes.
> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    can@ff400000 {
>> +        compatible = "gaisler,grcanfd";
>> +        clocks = <&sysclock>;
>> +        reg = <0xff400000 0x400>;
>> +        interrupt-parent = <&plic0>;
>> +        interrupts = <6>;
>> +    };
> 
> One example is enough
> 
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    can@ff400000 {
>> +        compatible = "gaisler,grcan";
>> +        clocks = <&sysclock>;
>> +        reg = <0xff400000 0x400>;
>> +        interrupt-parent = <&plic0>;
>> +        interrupts = <6>;
>> +    };
>> +  - |
>> +    GAISLER_GRCAN@ff840000 {
> 
> Especially no such examples. Please read DTS coding style.
> 
>> +        reg = <0xff840000 0x400>;
>> +        freq = <50000000>;
>> +        interrupts = <16>;
>> +    };
>> diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt 
>> b/Documentation/devicetree/bindings/net/can/grcan.txt
>> deleted file mode 100644
>> index 34ef3498f887..000000000000
>> --- a/Documentation/devicetree/bindings/net/can/grcan.txt
>> +++ /dev/null
>> @@ -1,28 +0,0 @@
> Best regards,
> Krzysztof

