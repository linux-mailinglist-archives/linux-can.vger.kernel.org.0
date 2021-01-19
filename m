Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED28C2FC2C0
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 22:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbhASVjy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 16:39:54 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:24819 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbhASVie (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jan 2021 16:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611092078;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=szSf/fv/ZmtKjy6LNU3aUDR+VYBcZ5uxizTWwHfjSVE=;
        b=adl8iqHiY/t1Kh7R6Qb0L+JZkhhLD24wonn3Wr87LaGqzwfeA7AvRnYqwlNyQ2Hn/D
        3x9rxk0dw8hqXHb5wab0FW/65hTzyAaWqS4kzLE7mV5PQJiedBmVaxUhVeUCX+iIR/0j
        /9phIdB/Y7b2NAtbou3GZ/wFB0X3k+bvWumcsa73MSuGg2cc3XnYLypBoQUthO1Ye7gE
        HBra6jX8IxcuurGjvwVEDPo4CDRFSN4YtkqKEsYNKuIcxs3RdsFs5VOOKHji1VwlMx/f
        1EXgqiq6w5d/gSCnt09gGhl1AUGprCbZuBffNfdG9l/09PNkCf7pLIyQLlByhFhM39PU
        Oyjw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOMtqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.177]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0JLYVhaY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 19 Jan 2021 22:34:31 +0100 (CET)
Subject: Re: [LTP] [PATCH v2 4/6] can_recv_own_msgs: Convert to new library
To:     Marc Kleine-Budde <mkl@pengutronix.de>, rpalethorpe@suse.de
Cc:     Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
        linux-can@vger.kernel.org
References: <20210119093143.17222-1-rpalethorpe@suse.com>
 <20210119093143.17222-5-rpalethorpe@suse.com>
 <322f1056-0a73-65e6-531a-3275029df256@pengutronix.de>
 <YAb1Wncn2/x6LBYj@yuki.lan>
 <3277a88e-0301-7f3d-b024-c728e1041092@pengutronix.de>
 <87bldkq41l.fsf@suse.de>
 <85d808dd-c8c3-1216-ee6e-94d63ddf0f2b@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <29fef223-bb59-bc88-8e3c-6e63de0af210@hartkopp.net>
Date:   Tue, 19 Jan 2021 22:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <85d808dd-c8c3-1216-ee6e-94d63ddf0f2b@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 19.01.21 17:39, Marc Kleine-Budde wrote:
> On 1/19/21 5:34 PM, Richard Palethorpe wrote:
>> Hello All,
>>
>> Marc Kleine-Budde <mkl@pengutronix.de> writes:
>>
>>> On 1/19/21 4:06 PM, Cyril Hrubis wrote:
>>>> Hi!
>>>>>>   /*
>>>>>> - * tst-rcv-own-msgs.c
>>>>>> - *
>>>>>> - * Copyright (c) 2010 Volkswagen Group Electronic Research
>>>>>> - * All rights reserved.
>>>>>> - *
>>>>>> - * Redistribution and use in source and binary forms, with or without
>>>>>> - * modification, are permitted provided that the following conditions
>>>>>> - * are met:
>>>>>> - * 1. Redistributions of source code must retain the above copyright
>>>>>> - *    notice, this list of conditions and the following disclaimer.
>>>>>> - * 2. Redistributions in binary form must reproduce the above copyright
>>>>>> - *    notice, this list of conditions and the following disclaimer in the
>>>>>> - *    documentation and/or other materials provided with the distribution.
>>>>>> - * 3. Neither the name of Volkswagen nor the names of its contributors
>>>>>> - *    may be used to endorse or promote products derived from this software
>>>>>> - *    without specific prior written permission.
>>>>>
>>>>> IANAL, I think you're missing this license. Is looks like some sort
>>>>> of BSD to me.
>>
>> Ufff, thanks, I should pay more attention when it is a test imported
>> from elsewhere.
>>
>>>>>
>>>>>> - *
>>>>>> - * Alternatively, provided that this notice is retained in full, this
>>>>>> - * software may be distributed under the terms of the GNU General
>>>>>> - * Public License ("GPL") version 2, in which case the provisions of the
>>>>>> - * GPL apply INSTEAD OF those given above.
>>>>>
>>>>> It doesn't say "or later".
>>>>
>>>> Looks like we cannot just remove this license. So what about moving this
>>>> text into a separate COPYING file and changing the SPDX to GPL-v2.0?
>>>
>>> This file is dual licensed, better keep it dual licensed.
>>>
>>> regards,
>>> Marc
>>
>> HHmm, this appears to be the BSD-3-Clause license with the following
>> text inserted in the middle:
>>
>>   * Alternatively, provided that this notice is retained in full, this
>>   * software may be distributed under the terms of the GNU General
>>   * Public License ("GPL") version 2, in which case the provisions of the
>>   * GPL apply INSTEAD OF those given above.
>>   *
>>   * The provided data structures and external interfaces from this code
>>   * are not restricted to be used by modules with a GPL compatible license.
>>
>> I don't see any corresponding SPDX identifier or exception for this. It
>> is probably easiest and safest just to keep it as-is.
> 
> I think the Linux kernel uses:
> 
> /* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR
> BSD-3-Clause) */
> 
> e.g.:
> 
> https://elixir.bootlin.com/linux/v5.10/source/include/uapi/linux/can/gw.h
> 

Thanks Marc!

Yes, indeed it is a GPLv2 / BSD3 dual license to use it in both 
environments.

Regards,
Oliver
