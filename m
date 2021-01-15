Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE232F79DE
	for <lists+linux-can@lfdr.de>; Fri, 15 Jan 2021 13:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbhAOMmM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jan 2021 07:42:12 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:34625 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732844AbhAOMmL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jan 2021 07:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610714299;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=myA0MBfC/FVulDeSnliBgzQ9L2EPqhqku+K3juHMuXU=;
        b=nDE3kOVXQ6YxZHv5ieSV4rB7ixnQep16THckPx3zcWqKMcKGO4/cm+kOpkCyg2rSTZ
        Iv7o7Zda3UCVpoWK2y1dC/EOmdjR0wWwhj7A0bxzTN0d5ANxZd6x8pnUhqxXdFHdS9dS
        0ytrKlt8W7oDxrw0rSr3e9uasscgZnhNJabcgh7pBQe4nVNhyio6pTZtg5tdn74bQ1RT
        wxXPryxMuZD/2E2k4XZhGHv/x2LSnJ+Q+LMqaeS1z461tSaJwuJOT2jFEMQ6dBntJ6Hz
        drq7NEVRVLYSvPRjtE5GgP43NEFRzBqwhyY/o5Jp1JECF+0NjlhWP6viuCgl+w6Jt3M0
        AbmQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVJiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0FCcIWye
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 15 Jan 2021 13:38:18 +0100 (CET)
Subject: Re: [net-next 09/17] can: length: can_fd_len2dlc(): simplify length
 calculcation
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
References: <20210113211410.917108-1-mkl@pengutronix.de>
 <20210113211410.917108-10-mkl@pengutronix.de>
 <CAMZ6Rq+Wxn_kG7rSkUrMYMqNw790SMe-UKmpUVdEA_eGcjoT+g@mail.gmail.com>
 <2f3fff1a-9a50-030b-6a29-2009c8b65b68@hartkopp.net>
 <CAMZ6RqLKYnGDePueN1ftL9a47Qf-ZR7bc4eLGwzCkncsD6ok2Q@mail.gmail.com>
 <75d3c8e9-acbd-09e9-e185-94833dbfb391@hartkopp.net>
 <CAMZ6RqKZcuJH2DPeZjgqvL2MG+LoLScHTdd4s+K9OFYDUFT2ZQ@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <a79041a9-a211-bd3f-42b3-35919bd12470@hartkopp.net>
Date:   Fri, 15 Jan 2021 13:38:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqKZcuJH2DPeZjgqvL2MG+LoLScHTdd4s+K9OFYDUFT2ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

-DaveM
-Jakub
-netdev

On 15.01.21 02:57, Vincent MAILHOL wrote:

>> 48 */
>> +                            /* 49 - 64 is checked in  can_fd_len2dlc() */
> 
> Ack
> 
>>
>>    /* map the sanitized data length to an appropriate data length code */
>>    u8 can_fd_len2dlc(u8 len)
>>    {
>> -       if (unlikely(len > 64))
>> +       if (len > 48)
> 
> I personally prefer the use of macros instead of hardcoded values. 48 is the
> last index of the table, i.e. it is ARRAY_SIZE(len2dlc) - 1.

In general I'm with you here.

> For me, it is like doing this:
> for (i = 0; i <= harcoded_value_representing_last_index_of_array; i++)
> instead of this:
> for (i = 0; i < ARRAY_SIZE(array); i++)
> 
> Definitely prefer the later and (len >= ARRAY_SIZE(len2dlc)) is nothing less
> than the negation of the i < ARRAY_SIZE(array) that we usually see in a for
> loop.
> 
> I recognize below patterns to be correct:
>     i < ARRAY_SIZE(array): check that variable is inbound.
>     i >= ARRAY_SIZE(array): check that variable is outbound.
> 
> Anything which deviates from those patterns is fishy and it is actually how
> I spotted the bug.
> 
> If we don’t use ARRAY_SIZE() we lose that recognizable pattern and we need
> to be aware of the actual content of len2dlc[] to understand the code.
> (And I know that the table is just above the function and that this makes my
> argument weaker).
> 
> So IMO, checks done against the array size should use the ARRAY_SIZE() macro
> in order 1/ to make it a recognizable pattern and 2/ to make it work regardless
> of the actual size of the table (i.e. no hardcoded value).

The problem is NOT that we make sure to access this array correctly.

This particular array is no set of arbitrary values that may be extended 
later on BUT it is a 'translation map' for defined length values which 
will never change.

Therefore ARRAY_SIZE(array) hides the fact that every length value 
"greater than 48" results to a DLC of 15.

For that reason my former code was very clear:

1. It had a table that mapped 0 .. 64 to a DLC
2. It had a test for '> 64' as sanity test.

Now the sanity test is gone and mixed up with the mapping of length 
values - and finally with ARRAY_SIZE(whatever) which doesn't give a hint 
why this is checked.

We are writing code to be understandable for the reader and the 
suggested 'improvement' which saves 16 bytes does exactly the opposite.

For that reason the entire patch is broken.

An improvement could be to rename

64 -> CANFD_MAX_LEN
0xF -> CANFD_MAX_DLC

but nothing more.

> 
>>                   return 0xF;
> 
> I would also prefer to use the CANFD_MAX_DLC macro here.

Ack. Me too. Just seen that after pressing the 'send' button :-/

Regards,
Oliver
