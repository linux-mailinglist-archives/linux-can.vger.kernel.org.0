Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA7F2D5542
	for <lists+linux-can@lfdr.de>; Thu, 10 Dec 2020 09:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbgLJIWa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Dec 2020 03:22:30 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:14039 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387872AbgLJIWV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2020 03:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607588300;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=CbZPcQMHdnV+l+BKxAk5G6u/6yYt/P8rZq+5MTDxXlg=;
        b=pRyezqP3v+ClzkfbBvSf8KIgOohQeBy+j0ufKFrEK34/YKcBSYvYenm1Ztl2PhXvi+
        XvMfMCI++x0S2ScLeVkn1oqXGUQPqo9h6YnXBRg/C17YYRY5gZas/MXzM7lk1ECeClmO
        i2xZs5NYGc9hhPKCbx/EBaC1oa5Qj4UMpYREzAMLA4v4moZXaT4sYWJTukzDXYn7OhtN
        Q8+4QkoJMQvzUZlwiDWf11rgz0eVQv5l9k7IFWZHzvZpuRj/YIY5C/P/pR1iPWXusP+B
        tm3LoF8iI1/Mt3AK5TA4STlyUxDemT1cM2k1jxFSg0iCpppAk4NraOEKmXYVgBLz03OR
        0xNg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.6.2 DYNA|AUTH)
        with ESMTPSA id 302891wBA8II8HI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 10 Dec 2020 09:18:18 +0100 (CET)
Subject: Re: [net 3/3] can: isotp: add SF_BROADCAST support for functional
 addressing
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Thomas Wagner <thwa1@web.de>, linux-can@vger.kernel.org
References: <20201204133508.742120-1-mkl@pengutronix.de>
 <20201204133508.742120-4-mkl@pengutronix.de>
 <20201204194435.0d4ab3fd@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <b4acc4eb-aff6-9d20-b8a9-d1c47213cefd@hartkopp.net>
 <eefc4f80-da1c-fed5-7934-11615f1db0fc@pengutronix.de>
 <20201205123300.34f99141@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <ce547683-925d-6971-6566-a0b54146090a@pengutronix.de>
 <20201205130904.3d81b0dc@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <752c8838-b478-43da-620b-e15bcc690518@hartkopp.net>
 <20201208100718.5ed008dc@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <20e31c74-eb50-072c-1212-a58eb8da704b@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <68a8f0b2-f3c6-23df-f41b-f52edd826cf9@hartkopp.net>
Date:   Thu, 10 Dec 2020 09:18:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20e31c74-eb50-072c-1212-a58eb8da704b@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

On 09.12.20 08:45, Marc Kleine-Budde wrote:
> On 12/8/20 7:07 PM, Jakub Kicinski wrote:
>> On Tue, 8 Dec 2020 13:54:28 +0100 Oliver Hartkopp wrote:
>>> On 05.12.20 22:09, Jakub Kicinski wrote:
>>>> On Sat, 5 Dec 2020 21:56:33 +0100 Marc Kleine-Budde wrote:
>>>>> On 12/5/20 9:33 PM, Jakub Kicinski wrote:
>>>>>>> What about the (incremental?) change that Thomas Wagner posted?
>>>>>>>
>>>>>>> https://lore.kernel.org/r/20201204135557.55599-1-thwa1@web.de
>>>>>>
>>>>>> That settles it :) This change needs to got into -next and 5.11.
>>>>>
>>>>> Ok. Can you take patch 1, which is a real fix:
>>>>>
>>>>> https://lore.kernel.org/linux-can/20201204133508.742120-2-mkl@pengutronix.de/
>>>>
>>>> Sure! Applied that one from the ML (I assumed that's what you meant).
>>>
>>> I just double-checked this mail and in fact the second patch from Marc's
>>> pull request was a real fix too:
>>>
>>> https://lore.kernel.org/linux-can/20201204133508.742120-3-mkl@pengutronix.de/
>>
>> Ack, I thought it was a fix to some existing code but it's a fix to
>> ISO-TP so we should probably get it in before someone start depending
>> on existing behavior - Marc should I apply that one directly, too?
> 
> Yes, please take that patch directly.

The fix is in the net-tree.

Do you take this patch

https://lore.kernel.org/linux-can/20201206144731.4609-1-socketcan@hartkopp.net/T/#u

via linux-can-next then as it is neither in can-next and net-next now ... ?

And net-next will be closed soon, I assume.

Thanks,
Oliver
