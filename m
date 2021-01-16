Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079482F8CCD
	for <lists+linux-can@lfdr.de>; Sat, 16 Jan 2021 11:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbhAPK1s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 16 Jan 2021 05:27:48 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:17880 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbhAPK1r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 16 Jan 2021 05:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610792631;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=QkdmVNhCI+mHRXjrIJLhRDV9jKKWZn94FMgfam9hoWQ=;
        b=noTgFNOKjpG45KLubrVeNKRYZguX/N0M7CsBWSU5Ch/piE40ycxNxRtrSLGbS7wtWA
        /i36qxH7Ce9SbV0JX8kHV+WsGYl7McBtHcIXuTAr7kvO82SEqiwyMKZOStb4wH5IqySD
        aSvYz1olJMIxOu9iw4cj5IxXtCJpQLP0JguOXy+wKj1iYoBHGODHGzhPUz7uRCyxY5Ky
        zzBucTSscWUOh01shnrWHIY0BlnTe8jtJq4yjQ2lP67tHKw1KNl14EZLATwVxi3TnWw9
        wtHUjblPIthjn7yIoTWNPBZtKejTPqOAeHLF3/AFU96/E8mF94VTq1dXiqY2bcaSUuhl
        F5sw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT5L31lTtG"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0GANnYeE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 16 Jan 2021 11:23:49 +0100 (CET)
Subject: Re: [net-next 09/17] can: length: can_fd_len2dlc(): simplify length
 calculcation
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     kernel@pengutronix.de, linux-can <linux-can@vger.kernel.org>
References: <20210113211410.917108-1-mkl@pengutronix.de>
 <20210113211410.917108-10-mkl@pengutronix.de>
 <CAMZ6Rq+Wxn_kG7rSkUrMYMqNw790SMe-UKmpUVdEA_eGcjoT+g@mail.gmail.com>
 <2f3fff1a-9a50-030b-6a29-2009c8b65b68@hartkopp.net>
 <CAMZ6RqLKYnGDePueN1ftL9a47Qf-ZR7bc4eLGwzCkncsD6ok2Q@mail.gmail.com>
 <75d3c8e9-acbd-09e9-e185-94833dbfb391@hartkopp.net>
 <CAMZ6RqKZcuJH2DPeZjgqvL2MG+LoLScHTdd4s+K9OFYDUFT2ZQ@mail.gmail.com>
 <a79041a9-a211-bd3f-42b3-35919bd12470@hartkopp.net>
 <CAMZ6RqLYnLYySQ0ZY3tvR7zk0x6BRoBmw2gh-8pf7kt-nMbQfQ@mail.gmail.com>
 <44eb1d41-a434-76a2-4c28-9aab7edb54e6@pengutronix.de>
 <CAMZ6RqK5BuGiVXjwS2p5bjUbgcRS=AfPzGC7OmwBnKfP8VvCcw@mail.gmail.com>
 <92898d61-a7fc-8aff-cb61-030873b63d71@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <69a8531e-9253-4d4d-33bc-1fc7ebb9be1c@hartkopp.net>
Date:   Sat, 16 Jan 2021 11:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <92898d61-a7fc-8aff-cb61-030873b63d71@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 15.01.21 15:50, Marc Kleine-Budde wrote:
> On 1/15/21 3:18 PM, Vincent MAILHOL wrote:
>> On Fri. 15 janv. 2021 at 22:51, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>> On 1/15/21 2:20 PM, Vincent MAILHOL wrote:
>>>> /* map the data length to an appropriate data length code */
>>>> u8 can_fd_len2dlc(u8 len)
>>>> {
>>>>      switch(len) {
>>>>      case 0 ... 8:
>>>>          return len;
>>>>      case 9 ... 12:
>>>>          return 9;
>>>>      case 13 ... 16:
>>>>          return 10;
>>>>      case 17 ... 20:
>>>>          return 11;
>>>>      case 21 ... 24:
>>>>          return 12;
>>>>      case 25 ... 32:
>>>>          return 13;
>>>>      case 33 ... 48:
>>>>          return 14;
>>>>      case 49 ... 64:
>>>>      default:
>>>>          return CANFD_MAX_DLC;
>>>>      }
>>>> }
>>>>
>>>> And we will just leave the optimizations in the hand of the compiler.
>>>
>>> I've already tried this. It results in a longer object file on ARM, even if you
>>> remove the array....
>>
>> You are right. I just checked the assembly code: it does a
>> dichotomy which means that in addition to being bigger, it is
>> also slower.
>>
>> Please forget my previous message, it wasn't really smart.
> 
> I had the same idea, as I've never used these new cases I tried it out and was
> underwhelmed. At least compared to this tightly packed array.

Yes. And for that reason I would like this patch to be completely reverted!

I'm fine with an improvement that adds some constant replacement like:

64  -> CANFD_MAX_LEN
0xF -> CANFD_MAX_DLC

But using ARRAY_SIZE() is not appropriate for a length conversion map. 
And if you want to save 16 bytes and move the sanity check to a 
functional check there has to be much more documentation in the code.

I was always happy having a generic 65 byte translation table which is 
*extremely* fast in operation and which can be used *independently* from 
can_fd_len2dlc().

There is no real need to replace that code with some error prone and 
less understandable code.

Regards,
Oliver
