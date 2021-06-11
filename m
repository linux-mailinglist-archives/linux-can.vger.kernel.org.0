Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD963A421A
	for <lists+linux-can@lfdr.de>; Fri, 11 Jun 2021 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhFKMky (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Jun 2021 08:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhFKMky (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 11 Jun 2021 08:40:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2219B613DE;
        Fri, 11 Jun 2021 12:38:54 +0000 (UTC)
Subject: Re: [PATCH 3/5] m68k: m5441x: add flexcan support
To:     Angelo Dureghello <angelo@kernel-space.org>, wg@grandegger.com,
        mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210608204542.983925-1-angelo@kernel-space.org>
 <20210608204542.983925-3-angelo@kernel-space.org>
 <30aef0c6-e1fb-63ed-5e46-a2bc14e198a2@linux-m68k.org>
 <835a0684-e4ec-00fa-4682-b9d99d3f1c56@kernel-space.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <6fdaadc0-0567-20d9-7077-d6d38453686d@linux-m68k.org>
Date:   Fri, 11 Jun 2021 22:38:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <835a0684-e4ec-00fa-4682-b9d99d3f1c56@kernel-space.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Angelo,

On 10/6/21 5:59 pm, Angelo Dureghello wrote:
> Hi Greg,
> 
> On 09/06/21 3:24 PM, Greg Ungerer wrote:
>> Hi Angelo,
>>
>> On 9/6/21 6:45 am, Angelo Dureghello wrote:
>>> Add flexcan support.
>>>
>>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>>> ---
>>>   arch/m68k/coldfire/device.c       | 31 +++++++++++++++++++++++++++++++
>>>   arch/m68k/coldfire/m5441x.c       |  8 ++++----
>>>   arch/m68k/include/asm/m5441xsim.h | 19 +++++++++++++++++++
>>>   3 files changed, 54 insertions(+), 4 deletions(-)
>>>
> 
>>> diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
>>> index 1e5259a652d1..18b152edb69c 100644
>>> --- a/arch/m68k/coldfire/m5441x.c
>>> +++ b/arch/m68k/coldfire/m5441x.c
>>> @@ -18,8 +18,8 @@
>>>   #include <asm/mcfclk.h>
>>>   DEFINE_CLK(0, "flexbus", 2, MCF_CLK);
>>> -DEFINE_CLK(0, "mcfcan.0", 8, MCF_CLK);
>>> -DEFINE_CLK(0, "mcfcan.1", 9, MCF_CLK);
>>> +DEFINE_CLK(0, "flexcan.0", 8, MCF_CLK);
>>> +DEFINE_CLK(0, "flexcan.1", 9, MCF_CLK);
>>>   DEFINE_CLK(0, "imx1-i2c.1", 14, MCF_CLK);
>>
>> Just a heads up, but this will likely conflict with Arnd's clock changes, see:
>>
>>      https://lkml.org/lkml/2021/6/8/774
>>
> 
> is this a clock naming issue ? The "mcfcan" is actually
> not referenced in any driver so naming it "flexcan"
> shouldn't be an issue.

Yeah, no problem with that. The "mcfcan" name was really just a
place holder here. Not used previously.

My comment is more that your patches and Anrd's are touching
some of the same things. Depending on whose is applied first one
or the other will need to be updated to reflect the others.
No big deal, and easy to do in this case.

Regards
Greg



> Or i should get and enable "mcfcan" clock from the driver ?
> 
>> Regards
>> Greg
>>
> 
> Thanks,
> regards,
