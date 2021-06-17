Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE073AAD6E
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 09:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhFQH0P (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 03:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFQH0O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 03:26:14 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21874C061574;
        Thu, 17 Jun 2021 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623914644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQxXExXt4CV+zG+Z0qsZFTAEVbV3uAghRwzhiGw5e/0=;
        b=q6xjl6U+gm1Uv745AUmdeOOhojeNcxj0oHIHkt7N852kXgYyTNF2v1Mgh0iLm5vBqOIa8T
        xSNIZmBDmXslB6CPRg0SY6la9MM398hCtqJylVZEWyb0+6juxVC7mcZPTZ3/rxf6fqC5pQ
        1Fulqnndbn+FEuyI/RHxiJQRYetKkFs=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id ce2b3305 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Jun 2021 07:24:04 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] can: flexcan: add platform data for ColdFire
To:     Greg Ungerer <gerg@linux-m68k.org>, wg@grandegger.com,
        mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <3f74ce4f-b4c5-d622-7cba-b4ce070fd967@linux-m68k.org>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <93a5c017-a538-af84-fe7d-a152dec0bd07@kernel-space.org>
Date:   Thu, 17 Jun 2021 09:23:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3f74ce4f-b4c5-d622-7cba-b4ce070fd967@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Greg,

On 17/06/21 2:17 AM, Greg Ungerer wrote:
> Hi Angelo,
> 
> On 17/6/21 9:16 am, Angelo Dureghello wrote:
>> Add platform data object for ColdFire architecture.
>>
>> ---
>> Changes for v2:
>> - move header file in more proper location
>> - remove irq defines
>> - change variable types to match driver types
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>> ---
>>   include/linux/can/platform/mcf5441x.h | 28 +++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>   create mode 100644 include/linux/can/platform/mcf5441x.h
>>
>> diff --git a/include/linux/can/platform/mcf5441x.h 
>> b/include/linux/can/platform/mcf5441x.h
>> new file mode 100644
>> index 000000000000..6866f0f60caf
>> --- /dev/null
>> +++ b/include/linux/can/platform/mcf5441x.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Flexcan options for ColdFire family
>> + *
>> + * Copyright (C) 2021  Angelo Dureghello <angelo@kernel-space.org>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef _PLAT_FLEXCAN_MCF_H
>> +#define _PLAT_FLEXCAN_MCF_H
>> +
>> +struct mcf_flexcan_platform_data {
>> +    u8 clk_src;
>> +    u32 clock_frequency;
>> +    bool big_endian;
>> +};
>> +
>> +#define FLEXCAN_MCF5411X_MB_CNT_MCF    16
>> +
>> +#endif /* _PLAT_FLEXCAN_MCF_H */
> 
> Is this actually specific to the ColdFire M5411x SoC?
> I thought a number of other ColdFire parts also have canbus support.
> Are they not all the same underlying hardware block?
> 
> So should this be more generic, say flexcan.h or mcf_flexcan.h or 
> something like that?


yes, the file can be reused for all mcf, they have similar
hardware blocks (flexcan) but with small differences, like i.e.
number of buffers, so the define guards are named generic (MCF),
with specific defines as needed,

Will rename it to mcf_flexcan.h.

> 
> Regards
> Greg

Thanks !

Regards,
angelo
> 


