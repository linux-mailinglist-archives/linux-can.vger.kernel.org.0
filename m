Return-Path: <linux-can+bounces-3825-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 480F9AD707A
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 14:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333471886213
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2CF19D8BC;
	Thu, 12 Jun 2025 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="GEzH/xP+"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-15.smtpout.orange.fr [193.252.22.15])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D626AF3;
	Thu, 12 Jun 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731510; cv=none; b=AFyr53aj67EuwAi0tOE/cN32D/u75ZQqNF1cydhVjEa5FkwuyYyGJpX/Ft3Cn1qHnhMPPEslc+rss6z2KFXOPpmtthx6/MBPfg7/ea4XKFZLthq4qKSucLfWRbJ/xqeiPxC06vYnKMZgCOeJx4XiIgORVHXgGm9FZwxlz3AVUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731510; c=relaxed/simple;
	bh=RbHu+Mrg3PKCKYZqr/f2DZSc32uOM7Ygmq3rRxKjgzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0VrotX5jKfONxwEP6ChkbRNfQujDtLlizigXAAbyfB8V+2FAHJ4g6AXrxkUPVNE0xcCq03PHCo6LXkQUOCJOmDnE8lTDQdH0sKKKJTo/5+P31J2i94HIs8x1jJK/yO3RZDDBFYu7uYQI53aXSCXm1Mjuoo/3D6JWUhyttw3+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=GEzH/xP+; arc=none smtp.client-ip=193.252.22.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id Ph5muZu6TvsHFPh5nu7qwc; Thu, 12 Jun 2025 14:31:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1749731503;
	bh=bnwuXERF3JDSg5Su/yPkiBJBRUZgRY0nJ6QB7Y6IK78=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=GEzH/xP+SjBbTe6VW/8WK27Wp1qterPCq/ah2AA1tOZFqhhr0xhX0UdS1qfKUccrK
	 SJ6uKRrypqP67BpWTGeZeOVXCVuUeT3m7uwlA5CviYxuGRZelAW28VJdLelPF/s7j4
	 2omTwuVfh9lcnBIRkRVOInBFgSxSJHOJFSbn1eZ2JVeeUPcG5M7u4PSCWsrqDv7ZC2
	 6/01jAapTsPGSSKVixdpz9n2TDDhKf/fA0xiCzNsyIkeuYoOCWOw9X2/4BDaSAJWV4
	 O7ai+HQr5Hrr8THg5moww9se4/HBzCkp6H4FmCXfTmevsFWkC4EyMnQE8kEr6x/o7i
	 F05zzBmVGXzfg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 12 Jun 2025 14:31:43 +0200
X-ME-IP: 124.33.176.97
Message-ID: <7fe53bc6-5e4d-4caf-9c1c-8fed1703d58b@wanadoo.fr>
Date: Thu, 12 Jun 2025 21:31:38 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] can: rcar_canfd: Repurpose f_dcfg base for other
 registers
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <cover.1749655315.git.geert+renesas@glider.be>
 <75c8197c849fc9e360a75d4fa55bc01c1d850433.1749655315.git.geert+renesas@glider.be>
 <420d37b1-5648-4209-8d6f-1ac9d780eea2@wanadoo.fr>
 <CAMuHMdWdEtjbAjeaDxxZuQeJg5GByhpoZXpZ0Gydjk60pMkN6w@mail.gmail.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <CAMuHMdWdEtjbAjeaDxxZuQeJg5GByhpoZXpZ0Gydjk60pMkN6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/06/2025 at 20:33, Geert Uytterhoeven wrote:
> Hi Vincent,
> 
> On Thu, 12 Jun 2025 at 06:00, Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
>> On 12/06/2025 at 00:37, Geert Uytterhoeven wrote:
>>> Reuse the existing Channel Data Bitrate Configuration Register offset
>>> member in the register configuration as the base offset for all related
>>> channel-specific registers.
>>> Rename the member and update the (incorrect) comment to reflect this.
>>> Replace the function-like channel-specific register offset macros by
>>> inline functions.
>>>
>>> This fixes the offsets of all other (currently unused) channel-specific
>>> registers on R-Car Gen4 and RZ/G3E, and allows us to replace
>>> RCANFD_GEN4_FDCFG() by the more generic rcar_canfd_f_cfdcfg().
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>> ---
>>> v2:
>>>   - Add Reviewed-by.
>>>   - Replace function-like macros by inline functions,
>>
>> Thanks!
> 
>> Thinking of your code, you are still using some magic numbers, e.g.
>>
>>   0x04 + 0x20 * ch
>>
>> to access your registers. But at the end those magic numbers are just describing
>> a memory layout.
>>
>> I think this can be describe as a C structure. This is what I have in mind:
>>
>> --------------8<--------------
>> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
>> index 1e559c0ff038..487f40320c20 100644
>> --- a/drivers/net/can/rcar/rcar_canfd.c
>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>> @@ -560,10 +560,21 @@ struct rcar_canfd_channel {
>>         spinlock_t tx_lock;                     /* To protect tx path */
>>  };
>>
>> +struct rcar_canfd_f {
>> +       u32 dcfg;
>> +       u32 cfdcfg;
>> +       u32 cfdctr;
>> +       u32 cfdsts;
>> +       u32 cfdcrc;
>> +       u32 padding[3];
>> +};
>> +static_assert(sizeof(struct rcar_canfd_f) == 0x20);
> 
> Is that really needed?

It is needed to counterbalance my lack of confidence on whether I am able to
count up to 8 :)

It is just for debug, you can remove. Similarly, feel free to adjust the names.
I just wanted to convey my idea, and a piece of code was easier than a long
paragraph for that.

>> @@ -883,8 +883,7 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
>>
>>                 for_each_set_bit(ch, &gpriv->channels_mask,
>>                                  gpriv->info->max_channels)
>> -                       rcar_canfd_set_bit(gpriv->base,
>> -                                          rcar_canfd_f_cfdcfg(gpriv, ch), val);
>> +                       rcar_canfd_set_bit_reg(&gpriv->cbase[ch].cfdcfg, val);

I was wondering if there was some kind of helper function to do that? If not,
maybe adding a

  io_set_bitl(void __iomem *addr, val);

and so on into linux/io.h could be a good idea?

> Nice!
> 
>> To be honnest, I am happy to accept your patch as it is now, but what
>> do you think of the above? I think that this approach works with your
>> other macro as well.
> 
> Please take this as-is, so we can move forward.

@Marc, review is done, the series is ready for pick-up.

> I will create a proper patch (with your Suggested-by) later,
> I have more CAN-FD items on my TODO list...

No problem, take your time! My only wish is to not see more complexity added the
the function-like macros. Any other refactor is just a bonus!


Yours sincerely,
Vincent Mailhol


