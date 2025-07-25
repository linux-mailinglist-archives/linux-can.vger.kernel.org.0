Return-Path: <linux-can+bounces-4146-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8595EB11ED8
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 14:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CAD1CE4332
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1222EBDC9;
	Fri, 25 Jul 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5+c4i90"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F892EBB80;
	Fri, 25 Jul 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447183; cv=none; b=di2YbGxGeh3CbCS38grhTN4thdTC2VuKU8wOWrPx6U2hr64a8e8bsK9Ae/PBcI9UXVAI9wiHC3LODx+JCEj46OnXNmkI45Jo6TfPyOP29k9d1SYRnU2RlBRxlRJaRYut6ngCxoj9id3a6RExhy/7qdAk15utU1cAcsKImGntpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447183; c=relaxed/simple;
	bh=PU8jxNdlyHOWPaTq8T0o4bVvfRiJB5fDz6xUvMrVv6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHCumxcWyqjdX7jjOn9hzuUk76VVlRib5bF1WPcx19q9ampbWxqiIJ51UUX5p1cg0PfOUbBMdT/S0yh3OcRxePVuJuNG10VCgFkpwbWTFEm2vi4nLnwVQCa/z+KRA+U3BQ26WuYU84v1YHkR4gfvrQrZsl1NS4uQ4RyVvnk8gAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5+c4i90; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so18142591fa.0;
        Fri, 25 Jul 2025 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753447180; x=1754051980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JN2ivuhljKzLFWe0MvjwcxrDNR4GqFN61OIq2ilMzLw=;
        b=H5+c4i90uaeAtYl43/C+57k5a+J9r1FmezinhVkU4+a6R0BOUqdJExWx9P8ENzIlUV
         TBvHQ5CFlMFz+fr4pf63hweSrNEDWOCDs+92TKRZjm2Sd3a9sCyYgAbm6YXZKKENTsTz
         vqrcPSPoA5Ymd1o9a3ygz98TGNB6Phy2qn9h/icS7bPiBL84LWUddpy1NazitgOAOQBK
         +IqoHz53AQL9T53NEvjSYBFgCDTePPE+tAHhsam5W2ToeMKO8MUOHZ98BlZPQFyrm+no
         Gn1m90e550liZuQy3z0U+xTTl8ORQm9fiZz3iJZd7LLc+mPSSWzXcMZriS73XLiWwjIe
         Gb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447180; x=1754051980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JN2ivuhljKzLFWe0MvjwcxrDNR4GqFN61OIq2ilMzLw=;
        b=HULdrB3URuoq7nNDJAg9VFubbXzyQfEJDD+CY9SXU+GpdOpHc13E95dS65cTQedT5Z
         E39X7wKbexpo28GbWNtI6ec4OVU3rKSa9JFuO87/bKQteKrGdjtBYsWRZVRYWWBqO3HU
         WFI0QS1jk6h9YQGsKvNO/LGH4yIgBx8/ZubJ7Qr2u7QF2Ta2dy8LewIb0jCvU8kl72fv
         7YjZFzRIR7NQlH3EerCY0TE0ZyJSy0TnWZhfhds31QjSl+x3QbBlGB8iY4VNGeySzGXf
         L/Sau1/LJ+7160c+ybBif/8BoSGLyVtj3oUnOQjRo5GUoKOl4gD7E0qhGHsaYPdEQn2C
         zmQw==
X-Forwarded-Encrypted: i=1; AJvYcCWkwBJjI8SZ4ZidITChhRStbxvv7C0GJ0cmY3x+GtzjjbbJGuA+TPFxmP767Yq6arjLiMSyhLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Da68mI1JG/dkx7NpUGctGzEAMMq8AStm5FN/1nzwGsjaeO/C
	nhxdXmYhfIJJvuX3QGACOs6iAa4VoRXQbnvMPE1YlKhC0MdtSMRumtKE
X-Gm-Gg: ASbGnct3upPGOLOOACyz7Dv5eDy6HWyUglGodWDpdYqzOfPwOxm9mUGKzAwNQPIvaKv
	xNQ9TPOzgX/yopqH2Zy2OJrVJE9MzvWVCOo6IrF6hqRTgxt2rGdJ3q8GFCR1su8Tqe6/c25iriN
	lRpi7waN5/M8cqJd/leE6XESmXLe3A5ZoZ/fLnrRibgf0hxxT+rNyMgVYiq1tmvnQWiM5X2y9Ri
	D81t2yuV5M65ktTIvFXX7PtHfcVzTZlP485/7C5Gr/aD2luQPsK5VsN/fxXlvLRRkL8OYbTbocn
	3jD7SlsrcqTYE12LWEcWGlgyjlfWCmQT7LSiLXUI8MagoZwuaN0qkT0VBnTmZkSkOeaRynjVCLt
	piZ7ExBJLuEfjfJjHdsC3+CWK6XMXD4BbnXNIkBTF40xc8C0OXNiZPUeHzio61mP546ImA1BaTq
	Ab
X-Google-Smtp-Source: AGHT+IGPcH999lkOf64IeBZvVPYzxnMdGrpLSM6aThjm2ALpphK9DknXowr8Y55TygUqOJd76KhN+g==
X-Received: by 2002:a05:651c:889:b0:32a:7d61:ded0 with SMTP id 38308e7fff4ca-331ee7c5762mr5925501fa.19.1753447179864;
        Fri, 25 Jul 2025 05:39:39 -0700 (PDT)
Received: from [192.168.66.199] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-331e0912287sm7151741fa.77.2025.07.25.05.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:39:39 -0700 (PDT)
Message-ID: <96b9da59-bf24-460a-bccf-5761b8c2e87a@gmail.com>
Date: Fri, 25 Jul 2025 14:39:38 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] can: kvaser_pciefd: Expose device firmware
 version via devlink info_get()
To: Simon Horman <horms@kernel.org>, Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, netdev@vger.kernel.org
References: <20250724073021.8-1-extja@kvaser.com>
 <20250724073021.8-9-extja@kvaser.com>
 <20250724135224.GA1266901@horms.kernel.org>
Content-Language: en-US
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <20250724135224.GA1266901@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 3:52 PM, Simon Horman wrote:
> On Thu, Jul 24, 2025 at 09:30:19AM +0200, Jimmy Assarsson wrote:
> 
> ...
> 
>> diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
>> index 8145d25943de..4e4550115368 100644
>> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
>> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
>> @@ -4,7 +4,33 @@
>>    * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
>>    */
>>   
>> +#include "kvaser_pciefd.h"
>> +
>>   #include <net/devlink.h>
> 
> Hi Jimmy,
> 
> Please consider squashing the two-line change above into
> the previous patch in this series to avoid the following
> transient Sparse warning.
> 
>    .../kvaser_pciefd_devlink.c:9:26: warning: symbol 'kvaser_pciefd_devlink_ops' was not declared. Should it be static?
> 
> Thanks!

Hi Simon!

Sure, I'll fix it in v4.
Thanks for reviewing!

Best regards,
jimmy

