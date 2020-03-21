Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC44F18E31C
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2020 18:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCUREh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 21 Mar 2020 13:04:37 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:17569 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgCUREh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 13:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1584810276;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=uz96nruRQgOpnBb1/J/z2Z5JfW88Mk7AAscVCotZG7g=;
        b=LLBYkWiK2gnK8C+mcfMM8GJvxcPAvd7wE0MuZ/muKe45BJ35WTEwZL5w2UjefQVNpt
        xp469p4obQUBqQxtvuBKlC1DF0azggGFcVi4QCE8K/WfqeBPbLAiJg1UG8/xl0vz11ar
        8cQYVHPLlgBprlFFm1+On3uMYzauI7hvarnmRjD6dc0+AevxYGBUuzkUFu76M+s7E5J9
        9D60sNYtgerf+EzVgxeRc6qxQdBZTgf6mDUTI5Ct4QMCGRlO0xwqGXU+0YTISJk74hMP
        4t9AmhbgkCLHlURY7WWRWwvl+lJz5zEYjHg6/oC3B4hsiZnjBK9A/i0Q1w+7qFVLvlYr
        +e3Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGXsh6kk/L"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id R0105bw2LH4Z6tf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 21 Mar 2020 18:04:35 +0100 (CET)
Subject: Re: Need help in interpreting ip status output
To:     =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Alex Blasche <alexander.blasche@qt.io>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
 <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
 <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <fe141541-7e79-3bee-8c75-29e6f9f3bc4e@hartkopp.net>
Date:   Sat, 21 Mar 2020 18:04:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

+ Marc

Hi André,

On 21/03/2020 16.19, André Hartmann wrote:

>> On 12/03/2020 18.43, André Hartmann wrote:
>>
>>>> can someone help me interpreting the following ip output:

>> The reason for the overrun error is a notification from the CAN
>> controller itself. It tells us that the received CAN frame has not been
>> read from the controller until the next CAN frame arrived.
> 
> Ok, that's what I thought too, thanks for the confirmation.
> 
>> The dropped counter usually indicates that the CAN driver did not get a
>> skbuff data structure (e.g. out of memory condition).
>>
>> This is NOT good. What CAN hardware/setup are you using?
> 
> Actually it's not my system. The report is from a customer doing a full
> load test on an iMX8: https://bugreports.qt.io/browse/QTBUG-82610

Thanks for the link!

> I guess the customer should try a more recent Kernel than 4.14 first?

The FlexCAN driver (which is used in the IMX8 AFAIK) had a remarkable 
number of changes last year:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/can/flexcan.c

So I would definitely suggest an update.
I added Marc to this thread as he was very active on the FlexCAN 
improvements.

Best,
Oliver
