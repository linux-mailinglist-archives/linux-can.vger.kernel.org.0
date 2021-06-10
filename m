Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277E73A25FA
	for <lists+linux-can@lfdr.de>; Thu, 10 Jun 2021 09:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFJIBx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Jun 2021 04:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhFJIBx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Jun 2021 04:01:53 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33535C061574;
        Thu, 10 Jun 2021 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623311994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39V4s+sVCo1oQcEymUPlJD8SGX7KJs2jN7asEPCVDGE=;
        b=HwL9G6i+wPEFyeYrasxoj8dcHe5ntbufwQnQv/fZapWOklxTVN7Xq0+0u0Zq0Aip2MCB6R
        35XP8mJpLnuk4jAMn5WFMJNkmA9ngjMCEi3GBACVhx05FwGsax36weLSd/4HUMofpgT0Vm
        StDVez4JLSqS2xMW/Xp6MMi8/teG+Ls=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 95b3ef80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Jun 2021 07:59:54 +0000 (UTC)
Subject: Re: [PATCH 3/5] m68k: m5441x: add flexcan support
To:     Greg Ungerer <gerg@linux-m68k.org>, wg@grandegger.com,
        mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210608204542.983925-1-angelo@kernel-space.org>
 <20210608204542.983925-3-angelo@kernel-space.org>
 <30aef0c6-e1fb-63ed-5e46-a2bc14e198a2@linux-m68k.org>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <835a0684-e4ec-00fa-4682-b9d99d3f1c56@kernel-space.org>
Date:   Thu, 10 Jun 2021 09:59:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <30aef0c6-e1fb-63ed-5e46-a2bc14e198a2@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Greg,

On 09/06/21 3:24 PM, Greg Ungerer wrote:
> Hi Angelo,
> 
> On 9/6/21 6:45 am, Angelo Dureghello wrote:
>> Add flexcan support.
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>> ---
>>   arch/m68k/coldfire/device.c       | 31 +++++++++++++++++++++++++++++++
>>   arch/m68k/coldfire/m5441x.c       |  8 ++++----
>>   arch/m68k/include/asm/m5441xsim.h | 19 +++++++++++++++++++
>>   3 files changed, 54 insertions(+), 4 deletions(-)
>>

>> diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
>> index 1e5259a652d1..18b152edb69c 100644
>> --- a/arch/m68k/coldfire/m5441x.c
>> +++ b/arch/m68k/coldfire/m5441x.c
>> @@ -18,8 +18,8 @@
>>   #include <asm/mcfclk.h>
>>   DEFINE_CLK(0, "flexbus", 2, MCF_CLK);
>> -DEFINE_CLK(0, "mcfcan.0", 8, MCF_CLK);
>> -DEFINE_CLK(0, "mcfcan.1", 9, MCF_CLK);
>> +DEFINE_CLK(0, "flexcan.0", 8, MCF_CLK);
>> +DEFINE_CLK(0, "flexcan.1", 9, MCF_CLK);
>>   DEFINE_CLK(0, "imx1-i2c.1", 14, MCF_CLK);
> 
> Just a heads up, but this will likely conflict with Arnd's clock 
> changes, see:
> 
>      https://lkml.org/lkml/2021/6/8/774
> 

is this a clock naming issue ? The "mcfcan" is actually
not referenced in any driver so naming it "flexcan"
shouldn't be an issue.

Or i should get and enable "mcfcan" clock from the driver ?

> Regards
> Greg
> 

Thanks,
regards,
-- 
Angelo Dureghello
+++ kernelspace +++
+E: angelo AT kernel-space.org
+W: www.kernel-space.org
