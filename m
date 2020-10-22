Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF36A295FFF
	for <lists+linux-can@lfdr.de>; Thu, 22 Oct 2020 15:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895197AbgJVN3K (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Oct 2020 09:29:10 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:13959 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443923AbgJVN3J (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Oct 2020 09:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603373344;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Kl93MtWEBBdlXacs/3uRDl0joYDSVrjypHqkqHMCd1k=;
        b=H81AcVTamvBg8h40kNBMUs2lvuloYy7V+HNRVB8Xj51Swi3JTLzKSFSw53DxBJPfqv
        VWOB4F7fG7oBqBr1rCnrQSVtM5Loq8NbZbl8ZQiMgNHHTfUOZj3O8mqyLHpO1FJPm3ZD
        BrV7NDfQlOnplZTO88e233PFjtJvDv7wmtRfKMCv1ps14d7Oim9MwJOtkZ8rPEmAmZ+8
        nvL8ruPRYTu0FvS2jnqyhSxWQpRcbxvuIj2V5DJKQXeRheKxBrvxoZ3pzwPvGMuQgzro
        RVRYDzrGB/fnmp4VKWhCyKsUDTgKHduoTfgmWayOpsLWmhZxTyl7mjNcGnGCxmmzsVIF
        5ANQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8Rrpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9MDT2vNQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 22 Oct 2020 15:29:02 +0200 (CEST)
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
 <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
 <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr>
 <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
 <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
 <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net>
 <CAMZ6RqK2RCGLFmjiHTQAxZSGn-HQaAh_nHHGwKdODanZK5oJbg@mail.gmail.com>
 <727e4845-63bd-659b-5344-97eb54121624@hartkopp.net>
 <CAMZ6RqJ8=T8CAhYaa8PZs5-d2zhx1_15wMe7ohUZovvqTcgW0w@mail.gmail.com>
 <0087f8a4-c77c-cc13-b17d-bd9666837ee3@hartkopp.net>
 <CAMZ6Rq+nHk1ZNzAGbwetEBULq8u_rsUYCd7FYj2HcQ-ejNC+Tw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d3dda30a-3f22-4824-71be-f8520b3714b2@hartkopp.net>
Date:   Thu, 22 Oct 2020 15:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6Rq+nHk1ZNzAGbwetEBULq8u_rsUYCd7FYj2HcQ-ejNC+Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 22.10.20 14:23, Vincent MAILHOL wrote:
> On 22.10.20 16:15, Oliver Hartkopp wrote:
>> On 22.10.20 05:30, Vincent MAILHOL wrote:
>>> On 22.10.20 02:52, Oliver Hartkopp wrote:
>>>> On 21.10.20 13:55, Vincent MAILHOL wrote:
>>>>>> On 21.10.20 18:48, Oliver Hartkopp wrote:
>>>>
>>>>>> To be more compatible to non raw dlc CAN frame sources the tx handling
>>>>>> could also be like this:
>>>>>>
>>>>>> if ((can_dlc == CAN_MAX_DLEN) &&
>>>>>>         (raw_dlc >= CAN_MAX_DLC && raw_dlc <= CAN_MAX_RAW_DLC))
>>>>>> => use raw_dlc
>>>>>>
>>>
>>> In addition to that, we would have to decide what to do with malformed
>>> frames. If can_dlc and can_raw are set to contradictory values, do we
>>> drop the frame, do we just ignore the raw_dlc? For example, if can_dlc
>>> is 8 but raw_dlc is 2, I think that we should drop.
>>
>> The pseudo code is pretty clear on this: Use can_dlc.
>>
>> The nice thing about testing raw_dlc to be 9..15 when can_dlc == 8 is,
>> that we always have a correct CAN frame on the wire with 8 bytes of content.
>>
>> Ok, the raw_dlc might be an uninitialized value - but still everything
>> remains fine for operation. So why dropping frames here?
> 
> If the can_dlc and raw_dlc are in contradiction, then the user is
> trying to do something not supported. After introducing raw_dlc,
> someone might want to try sending such malformed frames. If the
> operation succeeds, he then might be fooled in thinking that he
> actually send, for example, a frame of eight bytes with a DLC of 2.

??

You obviously did not read my description / pseudo code :-(

There is no contradiction.

if (can_dlc == 8) && (raw_dlc > 8 && raw_dlc <= 15)
     dlc = raw_dlc;
else
     dlc = can_dlc;

can_dlc == 8 is the entry door to write dlc values from 9..15 into the 
controller register.
Which always leads to a valid CAN frame with 8 bytes.

> In such a scenario, I think it is better to tell the user: "what you
> are doing is not supported" by returning -EINVAL (similar to what is
> currently done when an invalid skb is sent).
> 
>> The problem of uninitialized values could be solved with a
>> CAN_RAW_RAW_DLC sockopt BUT you will be always able to send a CAN frame
>> with an AF_PACKET socket which has no CAN_RAW_RAW_DLC sockopt.
>>
>> And then?
> 
> I am not competent enough on that point to comment. I was not aware of
> the possibility of using AF_PACKET to send CAN frames. Do you have a
> link to any example of such code? I would be glad to study it and come
> back to you once I understand this point.

https://github.com/linux-can/can-tests/blob/master/netlayer/tst-packet.c

>> The above pseudo code together with CAN_CTRLMODE_RAW_DLC seems to be a
>> pretty safe option to me. Even if 'legacy' applications with
>> uninitialized raw_dlc send CAN frames or AF_PACKET users enable
>> CAN_CTRLMODE_RAW_DLC we always end up with a proper can_dlc == 8  and a
>> fitting valid raw_dlc.
> 
> But what if that "fitting valid raw_dlc" is greater than 8?

This is the plan!

> The kernel

the CAN driver

> would see that frame as valid, a frame with a DLC greater than 8 will
> be sent on the wire and received by the other devices than might be
> connected on the CAN bus.

Exactly.

> 
>>>
>>> If we go this direction, I would propose below logic:
>>>
>>>    1. if raw_dlc equals can_dlc: nominal case.
>>
>> Is not tested. We would start on testing can_dlc == 8
>>
>>>
>>>    2. if can_dlc equals 8 and raw_dlc is greater than 8: use raw_dlc
>>>       case, already covered in your code.
>>
>> ACK
>>
>>>    3. if raw_dlc is 0, then consider it as unset: overwrite raw_dlc with
>>>       can_dlc (so that it becomes case 1).
>>
>> Is not tested like this. We would start on can_dlc == 8 - and then check
>> for valid raw_dlc 9..15
>>
>>>
>>>    4. Other scenarios: the frame is malformed: drop it.
>>
>> No dropping.
>>
>>> Logic should apply for both Tx and Rx paths.
>>
>> So test for can_dlc == 8 - and then check for valid raw_dlc 9..15 in the
>> user space?! Fine.
> 
> My view: users and drivers directly use raw_dlc without need to check
> for can_dlc == 8 (detailed explanation below).
> 
>> Btw. we can make sure that we do not have uninitialized raw_dlc value in
>> the rx path in the enabled drivers. In fact you could always use the
>> raw_dlc then.
> 
> My view is that if we introduce the raw_dlc field, we should always
> populate it with the DLC value as defined in ISO, even if
> CAN_CTRLMODE_RAW_DLC and CAN_RAW_RAW_DLC are not active. User could
> then benefit from this field to get the DLC value (and maximum value
> would be either CAN_MAX_DLC or CAN_MAX_DLC RAW depending on the
> context).
> 
> Rationale is that the raw_dlc field would always be visible in the
> struct can_frame. So if it is here, use it. Having it sometimes used,
> sometimes not would be confusing for the user.

I wonder if it's more confusing to fill raw_dlc without 
CAN_CTRLMODE_RAW_DLC enabled?

> Basically, that would replace the use of the can_len2dlc() function.
> 
> I also think it should be extended to CAN-FD, but no need to elaborate
> more on this at the moment: let's keep the discussion focused on
> classical CAN and tackle this later.

Why do you want this?

You get of the bike and push your bicycle for what reason?

No.

>> BUT it makes sense to use this test to detect cases, where someone
>> forgot to switch on CAN_CTRLMODE_RAW_DLC or the driver doesn't support
>> it and the programmer did not check the ctrlmode netlink return values.
> 
> My view: if the user tries to send raw_dlc bigger than 8 and
> CAN_CTRLMODE_RAW_DLC and CAN_RAW_RAW_DLC are not active, return
> -EINVAL.

raw_dlc has always to be bigger than 8. What am I explaining wrong all 
time that you don't get it?

(..)

>> Ok, let me rephrase: Filling can_dlc with something else than a plain
>> length information 0..8 ;-)
> 
> Got it :-)
> 
>  From my preliminary study, not so much changes or sanity check would
> need to be added:
> 
>    1. The current can_dlc sanity checks in can_send() and can_rcv() in
>       net/can/af_can.c definitely needs to be adjusted (but this would
>       also be the case for the raw_dlc field solution).
> 
>    2. In the kernel Rx and Tx paths: the length should not be accessed
>       directly anymore but through a getter function.
> 
>    3. In the kernel: drivers "DLC aware" need to adapt their code and
>       use the length getter function.
> 
>    4. In user land: new "DLC aware" code should always use struct
>       can_frame for classical CAN and check whether can_dlc is greater
>       that CAN_MAX_DLEN before accessing data.
> 
> That's mostly all that would have to be adjusted.
> 

No, it is not.
You have to go through all protocols, e.g. raw.c, bcm.c, gw.c, j1939, 
isotp.c which get a skb to be (sometimes) cloned by them. And when they 
need to modify the can_dlc value to send it to the userspace or 
whatever, you need to modify skb->data - and then you can't clone it 
anymore but need to skbcopy() them.
HERE you will get a really big effort. Occasionally I was also thinking 
using can_dlc would be nice but then I looked into above code and your 
use-case does not justify that effort/ risk and performance impact.

>>>> The 14 year old documentation in can.h says:
>>>> @can_dlc: frame payload length in byte (0 .. 8)
>>>>
>>>> I will not break this established rule for a testing feature. The
>>>> question from Joakim clearly showed: Don't touch this!
>>>
>>> My point is this is an expert feature: if you do not understand it, do
>>> not use it and you are safe to go using the 14 years old definition.
>>
>> Full ACK - but you can't imagine what people do in the real world. Do
>> you know these 'more helps more' guys that switch everything to 'on'? :-D
> 
> Switching everything options on through an "ip link set canX up ..."
> should not cause damage. If the user is doing random setsockopt()
> without any clues of what he is doing, then he is already a lost cause
> for me...
> 
>> The approach with CAN_CTRLMODE_RAW_DLC and the described testing would
>> be even robust against unintended miss-use.
> 
> Exception: can_dlc == 8 and a non-initialed raw_dlc gets a garbage
> value between 9 and 15 from the stack (c.f. above comment).

Right, and what would be the effect of this?

You know the answer: Nothing breaks.

> 
>>>> At the end it would have made more sense to call it can_frame.len in the
>>>> first place. But this first came into our mind when CAN FD showed up.
>>>> The discussion about the can_dlc meaning can be closed IMO. It is a
>>>> plain length from 0..8 which is unfortunately named can_dlc.
>>>
>>> I agree that it should have been named len from the beginning, but as
>>> a matter of fact it has been named "can_dlc". For me as a user, I
>>> expect can_dlc to follow the DLC definition in ISO and so I *prefer*
>>> to opt for the compromise of losing the plain length property rather
>>> than losing the semantic meaning.
>>
>> I don't think you can claim to be a standard user. You are an expert for
>> security testing and digged into the ISO standard and intentionally
>> write DLC values >8 into controller registers. Users don't do things
>> like this ;-)
> 
> You get a point :-)
> 
> Whatever the output of our discussion is, I have one strong
> request. The linux kernel has a huge audience and has such, I think it
> is our duty to be technically accurate even in small details.

But we failed to do so by naming the plain data length can_dlc. We have 
to deal with that legacy.
You can not fix that anymore.

> I would like to add a comment in the struct can_frame to acknowledge
> the discrepancy with the ISO. Some people who do not have access to
> the ISO standard might refer instead to the SocketCAN documentation to
> learn and understand the protocol and those people might use this
> knowledge to program on other platforms (e.g. bare-metal
> microcontrollers). Using the DLC as a plain length on those systems
> might results in vulnerabilities in production and potentially safety
> hazard.
> 
> That's also why I would like to see the Socket CAN DLC be used
> according to ISO: so that we raise awareness on that issue and so that
> users can transfer their knowledge to other platforms.

Vincent, stop discussing about having in can_dlc anything else then a 
plain length from 0..8.
I'm really getting tired on this after the 6th or whatever round.

Read and understand my mails.

Regards,
Oliver

