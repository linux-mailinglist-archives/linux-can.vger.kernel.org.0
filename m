Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222522958DF
	for <lists+linux-can@lfdr.de>; Thu, 22 Oct 2020 09:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505808AbgJVHPa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Oct 2020 03:15:30 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:30507 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505807AbgJVHP3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Oct 2020 03:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603350925;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Wa93SaF+6dGiCSXa4su/yBJzVN95l5/BMy0djM/QxhA=;
        b=ayvIFZztecMWSTTlkiKg7YexAOD8FHri1fRRae0oCbi4QxEuVGK8onYGSbqbJYJg5N
        X5IGRygCxGpThc6Znq29Y9LGGMqEEMsNjSTj97sJVTy6NgIsoSVXNI3pK7qGdRjgJN0m
        6G6iiFrgZtmsFTpwYJejHy2xaNhnVYeYjGZ5fmNubIkiKtaoWsYteKnUwL4vOxJ2rrsA
        hv85ToeUzR2oUan7ieIT+/rsRboc06lyFPaipGqC0AmM/Gp75w+ElHf6CCyCTg7FK28K
        8wtH1MFZCGvtEVruFiAOJGjc+et3U7hVHlFFldUTXccY9kkP3rlTo/8yR+DnPvlCji0G
        cdVw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiO89upw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9M7FOtc2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 22 Oct 2020 09:15:24 +0200 (CEST)
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
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <0087f8a4-c77c-cc13-b17d-bd9666837ee3@hartkopp.net>
Date:   Thu, 22 Oct 2020 09:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqJ8=T8CAhYaa8PZs5-d2zhx1_15wMe7ohUZovvqTcgW0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 22.10.20 05:30, Vincent MAILHOL wrote:
> On 21.10.21 02:52, Oliver Hartkopp wrote:
>> On 21.10.20 13:55, Vincent MAILHOL wrote:
>>>> On 21.10.20 18:48, Oliver Hartkopp wrote:
>>
>>>> To be more compatible to non raw dlc CAN frame sources the tx handling
>>>> could also be like this:
>>>>
>>>> if ((can_dlc == CAN_MAX_DLEN) &&
>>>>        (raw_dlc >= CAN_MAX_DLC && raw_dlc <= CAN_MAX_RAW_DLC))
>>>> => use raw_dlc
>>>>
> 
> In addition to that, we would have to decide what to do with malformed
> frames. If can_dlc and can_raw are set to contradictory values, do we
> drop the frame, do we just ignore the raw_dlc? For example, if can_dlc
> is 8 but raw_dlc is 2, I think that we should drop.

The pseudo code is pretty clear on this: Use can_dlc.

The nice thing about testing raw_dlc to be 9..15 when can_dlc == 8 is, 
that we always have a correct CAN frame on the wire with 8 bytes of content.

Ok, the raw_dlc might be an uninitialized value - but still everything 
remains fine for operation. So why dropping frames here?

The problem of uninitialized values could be solved with a 
CAN_RAW_RAW_DLC sockopt BUT you will be always able to send a CAN frame 
with an AF_PACKET socket which has no CAN_RAW_RAW_DLC sockopt.

And then?

The above pseudo code together with CAN_CTRLMODE_RAW_DLC seems to be a 
pretty safe option to me. Even if 'legacy' applications with 
uninitialized raw_dlc send CAN frames or AF_PACKET users enable 
CAN_CTRLMODE_RAW_DLC we always end up with a proper can_dlc == 8  and a 
fitting valid raw_dlc.

> 
> If we go this direction, I would propose below logic:
> 
>   1. if raw_dlc equals can_dlc: nominal case.

Is not tested. We would start on testing can_dlc == 8

> 
>   2. if can_dlc equals 8 and raw_dlc is greater than 8: use raw_dlc
>      case, already covered in your code.

ACK

>   3. if raw_dlc is 0, then consider it as unset: overwrite raw_dlc with
>      can_dlc (so that it becomes case 1).

Is not tested like this. We would start on can_dlc == 8 - and then check 
for valid raw_dlc 9..15

> 
>   4. Other scenarios: the frame is malformed: drop it.

No dropping.

> Logic should apply for both Tx and Rx paths.

So test for can_dlc == 8 - and then check for valid raw_dlc 9..15 in the 
user space?! Fine.

Btw. we can make sure that we do not have uninitialized raw_dlc value in 
the rx path in the enabled drivers. In fact you could always use the 
raw_dlc then.

BUT it makes sense to use this test to detect cases, where someone 
forgot to switch on CAN_CTRLMODE_RAW_DLC or the driver doesn't support 
it and the programmer did not check the ctrlmode netlink return values.

> Then, the drivers/users would only have to manage scenarios 1 and 2
> (and 2 can be ignored if CAN_CTRLMODE_RAW_DLC is not advertised).
> 
>>>
>>> If I understand well, the idea would be not to use a setsockopt() but
>>> instead rely on some logic on the can_dlc and raw_dlc to determine
>>> which one to use.
>>>
>>> Unfortunately, this approach has one issue in the TX path that could
>>> break existing applications.
>>>
>>> Consider below code (which I think is fairly realistic):
>>>
>>> void send_frame (int soc, canid_t can_id, char *data, size_t len)
>>> {
>>>       struct can_frame cf;
>>>       size_t dlc = len > sizeof(cf.data) ? sizeof(cf.data) : len;
>>>
>>>       cf.can_id = can_id;
>>>       cf.can_dlc = dlc;
>>>       memcpy(cf.data, data, dlc);
>>>
>>>       write(soc, &cf, sizeof(cf));
>>> }
>>>
>>> Here, the user did not initialize the can frame (cf) but assigned all
>>> the relevant fields manually. Because cf is not initialized, the newly
>>> introduced cf.dlc_raw field would have any of the values which was
>>> present on the stack at the moment (rationale: the C standard does not
>>> guarantee zero initialization). If 9 <= raw_dlc <= 15, the can frame
>>> will be transmitted with a bad DLC value. If raw_dlc > 15, the can
>>> frame will be discarded.
>>
>> No, this is not what I wrote. With my suggestion you need to populate
>> both dlc elements to use the new "raw dlc" feature.
>>
>> if (can_dlc == 8) && (9 <= raw_dlc <= 15)
>> => put raw_dlc value into the controller register
>> else
>> => put can_dlc value into the controller register
>>
>> When you have a test system to make security tests and you enable
>> CAN_CTRLMODE_RAW_DLC on a specific CAN interface - which applications
>> would you run to send CAN frames on this interface?
>>
>> I assume only the test application which is really aware of setting
>> can_dlc and raw_dlc correctly.
> 
> My point is that this assumption is dangerous.
> 
> I do not think I made myself clear. I am speaking about old "non-DLC
> aware" code running in CAN_CTRLMODE_RAW_DLC context.
> 
> Consider two applications: the first application is a test application
> which is "DLC aware", the second is a legacy application which
> contains the code which I presented in my previous message.
> 
> A user who wants to run both in parallel sets CAN_CTRLMODE_RAW_DLC at
> netlink level. First application works fine, second application which
> contains the legacy code gets impacted as explained previously and
> stops behaving as intended.
> 
> Newly introduced option should not break existing code regardless
> why. In opposition, we can introduce new rules if these are strictly
> tied to the new option.

Yes but it doesn't help you with AF_PACKET.

> In my mind, imposing a rule that old code should not be used in
> CAN_CTRLMODE_RAW_DLC context would create a huge pitfall and would
> violate the "don't break userland" principle.

CAN_RAW_RAW_DLC could help in the case of legacy code only when they are 
using CAN_RAW sockets. But nothing more.

Therefore we need the robustness on driver level with the checking of 
can_dlc == 8.

(..)

>>> For userland, I think that this is acceptable because the very instant
>>> the user calls setsockopt() with the CAN_RAW_RAW_DLC, he should be
>>> aware of the consequences and should resign to use can_dlc field as a
>>> plain length.
>>
>> Not filling can_dlc would cause tons of changes for sanity checks and
>> feature switches.
> 
> I never spoke about "not filling can_dlc". My point is to not use it
> as a length but use it as a DLC according to ISO definition. In my
> approach, can_dlc should always be filled with the raw DLC value.

Ok, let me rephrase: Filling can_dlc with something else than a plain 
length information 0..8 ;-)

(..)

>> The 14 year old documentation in can.h says:
>> @can_dlc: frame payload length in byte (0 .. 8)
>>
>> I will not break this established rule for a testing feature. The
>> question from Joakim clearly showed: Don't touch this!
> 
> My point is this is an expert feature: if you do not understand it, do
> not use it and you are safe to go using the 14 years old definition.

Full ACK - but you can't imagine what people do in the real world. Do 
you know these 'more helps more' guys that switch everything to 'on'? :-D

The approach with CAN_CTRLMODE_RAW_DLC and the described testing would 
be even robust against unintended miss-use.

>> At the end it would have made more sense to call it can_frame.len in the
>> first place. But this first came into our mind when CAN FD showed up.
>> The discussion about the can_dlc meaning can be closed IMO. It is a
>> plain length from 0..8 which is unfortunately named can_dlc.
> 
> I agree that it should have been named len from the beginning, but as
> a matter of fact it has been named "can_dlc". For me as a user, I
> expect can_dlc to follow the DLC definition in ISO and so I *prefer*
> to opt for the compromise of losing the plain length property rather
> than losing the semantic meaning.

I don't think you can claim to be a standard user. You are an expert for 
security testing and digged into the ISO standard and intentionally 
write DLC values >8 into controller registers. Users don't do things 
like this ;-)

Clean-up and renaming typically ends when it breaks APIs and commonly 
followed rules. There are many examples in Linux where these clean-up 
attempts have been canceled for these reasons.

I would have liked to rename can_dlc to len too.
But now that we have a compatible canfd_frame which can contain a 
can_frame this is somehow settled: can_dlc == len.

> I would like to conclude by saying that I do necessarily think that
> your approach of raw_dlc field is bad (if used in combination with the
> setsockopt()). It has its pros and cons. However, if you ask me for
> feedback, *my answer* is that *I prefer* to use can_dlc as a DLC. But
> at the end of the day, I would be happy if the feature gets
> implemented, regardless how, so that I can do my testing :-)

So let's see how we can get there best :-)

Best regards,
Oliver
