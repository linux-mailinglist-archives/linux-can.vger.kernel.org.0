Return-Path: <linux-can+bounces-5626-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 269A5C7FB36
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 10:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5A67345336
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B8264A74;
	Mon, 24 Nov 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="nty36YTi"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457EF24B28;
	Mon, 24 Nov 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977607; cv=none; b=kS8kkJ+tlMQ6oxaZbFTuxVNugVaypKGsbNmLYP0DfVziN0io3ly3m5ovihM83AXcLNYjRMdz7KAQcd3QUQyV9PMLDnQ1mxiFTlzzX7bnoMIKk3+qcUzurbAGlreZ6jab8CjvrcOfiOBAEoR+rDaWmTgJjEiv5TzgLU3XDSOR5OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977607; c=relaxed/simple;
	bh=ImApdLVTbj3k2UWHCQ8xG7/FJtbQCEGckuYv0MmoJDg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GZVcCFG5Xh4HC1Kf7O+GnKD1mWhDbrh1WfG3zHoWztXbLu2mGgYa9YuSsSq5d6NVCzTX/AyXOYJPCJ1Kg/YZretYfZAeH5r/N3gb9SBX8Qz7DxaqszRM0oMY2yBj/8pePW0p5kAwmNenGfvBd+0OZBbDdwDJMzyoeY8DfQv5R+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=nty36YTi reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dFLZC3J8Zz1DHbn;
	Mon, 24 Nov 2025 10:46:43 +0100 (CET)
Received: from webmail.unoeuro.com (webmail.unoeuro.com [94.231.108.230])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dFLZC0FFJz1DDTg;
	Mon, 24 Nov 2025 10:46:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763977603;
	bh=pa63EyjJ5sZOWS5JBNDVSwA70GTNYplZLtjIqi6BKzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nty36YTiU2n8e0vWR7GZ4jzz0LfyTvseXSE04uqKVKoyBjOcdORiN2zcOzgB1hdZY
	 7LxXchXVFMgZwkMx9mAewKWXhYVvUZm3bA9p5Ba8RnZ88X7NEPhr0Z9SMPgtIFwJEt
	 PSlOkWkF+0TEybK1EOaUoNP1AScqee6vlmSns3/DWns0WJSfBRN0xrxV2IJkDldkX7
	 NO4D5jOBoja1skdns48t+48fb58tcFiTZ2sAUOjEXhyqphVluxgn6VI4j6VjfCVliR
	 sHjbikS4PGbl11YyGgoG8hChRRQFj0/WJQO5j13SXzET1pYuI4qLn+ts4Vt6Cojvc6
	 PRbxJOqFCxmgQ==
Received: from h-98-128-223-123.NA.cust.bahnhof.se ([98.128.223.123])
 by webmail.simply.com
 with HTTP (HTTP/2.0 POST); Mon, 24 Nov 2025 10:46:43 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Nov 2025 10:46:43 +0100
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mkl@pengutronix.de, mailhol@kernel.org, Cc <devicetree@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Daniel Hellstrom
 <daniel@gaisler.com>
Subject: Re: [PATCH 04/10] can: grcan: Add clock handling
In-Reply-To: <bd81118a-5ee3-476e-a7bc-61684a362eea@kernel.org>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-5-arun.muthusamy@gaisler.com>
 <bd81118a-5ee3-476e-a7bc-61684a362eea@kernel.org>
User-Agent: Simply.com webmail
Message-ID: <43591fac5bf0df7c6c7c5426f00a2437@gaisler.com>
X-Sender: arun.muthusamy@gaisler.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thank you for your thorough review. I wanted to get your guidance 
regarding the clock property in the DT binding.

In the binding, I included the clocks property with maxItems: 1 to 
indicate that a clock should be described. The driver calls:

clk = devm_clk_get(dev, NULL);

Since we pass NULL, the driver always requests the first (and only) 
clock from the clocks property.

I want to ensure the binding is fully compliant with the Linux DT ABI. 
Could you advise the preferred way to document the clocks and 
clock-names properties in this scenario? Specifically:

Do we still need a clock-names entry even if the driver never uses it by 
name?
For LEON systems, the driver relies on the "freq" property, while NOEL 
systems use a standard "clocks" binding. Given this dual approach, 
should the clocks property be marked as optional or required in the 
binding?

Thank you for your time and help.

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
>> From: Daniel Hellstrom <daniel@gaisler.com>
>> 
>> Add clock handling and add error messages for missing 'freq' DT 
>> property.
>> 
>> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
>> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>> ---
>>  drivers/net/can/grcan.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
>> index 3b1b09943436..538a9b4f82ab 100644
>> --- a/drivers/net/can/grcan.c
>> +++ b/drivers/net/can/grcan.c
>> @@ -34,7 +34,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/of.h>
>>  #include <linux/of_irq.h>
>> -
>> +#include <linux/clk.h>
>>  #include <linux/dma-mapping.h>
>> 
>>  #define DRV_NAME	"grcan"
>> @@ -1644,6 +1644,7 @@ static int grcan_probe(struct platform_device 
>> *ofdev)
>>  {
>>  	struct device_node *np = ofdev->dev.of_node;
>>  	struct device_node *sysid_parent;
>> +	struct clk *clk;
>>  	u32 sysid, ambafreq;
>>  	int irq, err;
>>  	void __iomem *base;
>> @@ -1663,8 +1664,20 @@ static int grcan_probe(struct platform_device 
>> *ofdev)
>> 
>>  	err = of_property_read_u32(np, "freq", &ambafreq);
>>  	if (err) {
>> -		dev_err(&ofdev->dev, "unable to fetch \"freq\" property\n");
>> -		goto exit_error;
>> +		clk = devm_clk_get(&ofdev->dev, NULL);
> 
> Nope, your binding said there is no clock... you cannot add 
> undocumented
> ABI.
> 
> 
> Best regards,
> Krzysztof

