Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078F72DAF84
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 15:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgLOO4E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 09:56:04 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:11337 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgLOOzu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 09:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608043915;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=fJ0XOrXdI/c/SIoZ5bWvlUG1MwJNluEl9AAq+B7LZYg=;
        b=G5yECnOLXPrSxca5LpNaKccwrS7qGgJYlgoZMTIjzpmNi858pWvYDaET9AJWbHeUna
        5k2xUvzeysrNVgmw4aGPYs/3Ozz2tJVswu/VW8S4IyQCtEsCpD3YMvxfP74XObAhk0AG
        5JxclQSPAnlXfG0jDbISwdbEbNTKyLHxuQtizqPu8i5lq7BVfMy2rnSMa2EcHUNVC8Aq
        rGYTN2ORBGhT9k7VKnP6ihuxaVfx0nzQRyGurwtGDmD/1pwf/rcqE58o+PG40MRcTxUE
        wlaCRFe6uxf0Y5kaM4Xc/tc2LtVSZUUBou8hUQKmBw0+/9WFpz8UurvdH4/hhYFoBumr
        BgbQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVJiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.8.3 DYNA|AUTH)
        with ESMTPSA id d0af4dwBFEpr4qX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 15 Dec 2020 15:51:53 +0100 (CET)
Subject: Re: [PATCH 1/2] can: dev: add can_len2dll_len()
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <20201215125549.540918-1-mkl@pengutronix.de>
 <CAMZ6Rq+0oreKdMLTS-U0L+6PBTyXHVikk=jT5+9n7H7pAG4Z+Q@mail.gmail.com>
 <f187798d-8145-f1d7-5e4a-b5fcf7c4c110@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <da843e0e-c1b1-691d-1da2-1b65b90812ec@hartkopp.net>
Date:   Tue, 15 Dec 2020 15:51:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <f187798d-8145-f1d7-5e4a-b5fcf7c4c110@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 15.12.20 14:41, Marc Kleine-Budde wrote:
> On 12/15/20 2:36 PM, Vincent MAILHOL wrote:
>> On Mar 15 Dec. 2020 at 21:55, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>
>>> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>   drivers/net/can/dev.c   | 21 +++++++++++++++++++++
>>>   include/linux/can/dev.h |  3 +++
>>>   2 files changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>>> index 68f37ac54327..fa81e3067b3b 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -60,6 +60,27 @@ u8 can_len2dlc(u8 len)
>>>   }
>>>   EXPORT_SYMBOL_GPL(can_len2dlc);
>>>
>>> +static const u8 len2dll_len[] = {
>>> +       0, 1, 2, 3, 4, 5, 6, 7, 8,      /* 0 - 8 */
>>> +       12, 12, 12, 12,                 /* 9 - 12 */
>>> +       16, 16, 16, 16,                 /* 13 - 16 */
>>> +       20, 20, 20, 20,                 /* 17 - 20 */
>>> +       24, 24, 24, 24,                 /* 21 - 24 */
>>> +       32, 32, 32, 32, 32, 32, 32, 32, /* 25 - 32 */
>>> +       40, 40, 40, 40, 40, 40, 40, 40, /* 33 - 40 */
>>> +       48, 48, 48, 48, 48, 48, 48, 48  /* 41 - 48 */
>>> +};
>>
>> I totally misunderstood what you wanted to do in my previous
>> email. I thought that the numbers were placeholders and that
>> the final goal was to take into account the CRC as you previously
>> mentioned in your first email.
> 
> Sorry, should have been clearer about functionality of that table/function.
> 
>> This function is just here to sanitize the data length, right?
>> Then we could simply name it can_fd_sanitize_len().
> 
> sanitized_len sounds good.

Yes and once you are a it:

Won't it make more sense to use

return can_fd_dlc2len(can_fd_len2dlc(len));

instead of creating a new table telling the same as the existing static 
const u8 len2dlc[] table?

Regards,
Oliver
