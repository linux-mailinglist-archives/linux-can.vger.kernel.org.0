Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1504F295E48
	for <lists+linux-can@lfdr.de>; Thu, 22 Oct 2020 14:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898044AbgJVMXd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Oct 2020 08:23:33 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35489 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897914AbgJVMXc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Oct 2020 08:23:32 -0400
Received: by mail-yb1-f193.google.com with SMTP id l15so1453438ybp.2
        for <linux-can@vger.kernel.org>; Thu, 22 Oct 2020 05:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuEQlVpSvA0MmGceWPOpPw5PuoYdSb/wZz0bZpwVxsM=;
        b=VTn+rd0g9IiXslydyu86TZaEsb8xpGhud4UsSV6I80o2BKeBUmdsTl9BYNUcvLwJ0W
         WcNSHy3bwB78ajzVFsXDLNSKYFAt0oiWC7YBOiXAeYjYwGD4xAvC/DbS6dZ5cwcQjrm3
         r9C/EjSgbPIPKqSOKLsmZO7wO7hWf5z9NNb9J0ZkGxoPj0icuXWdR8IPuWvSj4ogyiWM
         RGKqfd8XPG/pp8LJ/daERPUxbOc8tcYKZke8KiMnIJNZNvfOSCqqKo1e/fYvVmAqauo/
         7NBF32KuLekinTkaThGP5o9fPDlCC1eaTO9NlSe3olBs2QFIo0/Xe1sXGLofXDGWokNY
         qseg==
X-Gm-Message-State: AOAM530kzPmEEQ+6OMMptz5atXRdG+u14kefdw7MLnd1yA25j9lXADyo
        GEtQZA3ODLDdReqp8e9JmF/5okoeBXU/P+XLYNA=
X-Google-Smtp-Source: ABdhPJxLIWbKugrttaQaBfzaxYOUaROy90HBTz0fBu5aQf3vm1FasrqbL5Zl2trtpZ3V56pYV+v60N1AKkHdxuqwH+k=
X-Received: by 2002:a25:40c5:: with SMTP id n188mr2788509yba.514.1603369410537;
 Thu, 22 Oct 2020 05:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201019190524.1285319-1-mkl@pengutronix.de> <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net> <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr> <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr> <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
 <20201021005226.2727-1-mailhol.vincent@wanadoo.fr> <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
 <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net> <CAMZ6RqK2RCGLFmjiHTQAxZSGn-HQaAh_nHHGwKdODanZK5oJbg@mail.gmail.com>
 <727e4845-63bd-659b-5344-97eb54121624@hartkopp.net> <CAMZ6RqJ8=T8CAhYaa8PZs5-d2zhx1_15wMe7ohUZovvqTcgW0w@mail.gmail.com>
 <0087f8a4-c77c-cc13-b17d-bd9666837ee3@hartkopp.net>
In-Reply-To: <0087f8a4-c77c-cc13-b17d-bd9666837ee3@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 22 Oct 2020 21:23:19 +0900
Message-ID: <CAMZ6Rq+nHk1ZNzAGbwetEBULq8u_rsUYCd7FYj2HcQ-ejNC+Tw@mail.gmail.com>
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 22.10.20 16:15, Oliver Hartkopp wrote:
> On 22.10.20 05:30, Vincent MAILHOL wrote:
>> On 22.10.20 02:52, Oliver Hartkopp wrote:
>>> On 21.10.20 13:55, Vincent MAILHOL wrote:
>>>>> On 21.10.20 18:48, Oliver Hartkopp wrote:
>>>
>>>>> To be more compatible to non raw dlc CAN frame sources the tx handling
>>>>> could also be like this:
>>>>>
>>>>> if ((can_dlc == CAN_MAX_DLEN) &&
>>>>>        (raw_dlc >= CAN_MAX_DLC && raw_dlc <= CAN_MAX_RAW_DLC))
>>>>> => use raw_dlc
>>>>>
>>
>> In addition to that, we would have to decide what to do with malformed
>> frames. If can_dlc and can_raw are set to contradictory values, do we
>> drop the frame, do we just ignore the raw_dlc? For example, if can_dlc
>> is 8 but raw_dlc is 2, I think that we should drop.
>
> The pseudo code is pretty clear on this: Use can_dlc.
>
> The nice thing about testing raw_dlc to be 9..15 when can_dlc == 8 is,
> that we always have a correct CAN frame on the wire with 8 bytes of content.
>
> Ok, the raw_dlc might be an uninitialized value - but still everything
> remains fine for operation. So why dropping frames here?

If the can_dlc and raw_dlc are in contradiction, then the user is
trying to do something not supported. After introducing raw_dlc,
someone might want to try sending such malformed frames. If the
operation succeeds, he then might be fooled in thinking that he
actually send, for example, a frame of eight bytes with a DLC of 2.

In such a scenario, I think it is better to tell the user: "what you
are doing is not supported" by returning -EINVAL (similar to what is
currently done when an invalid skb is sent).

> The problem of uninitialized values could be solved with a
> CAN_RAW_RAW_DLC sockopt BUT you will be always able to send a CAN frame
> with an AF_PACKET socket which has no CAN_RAW_RAW_DLC sockopt.
>
> And then?

I am not competent enough on that point to comment. I was not aware of
the possibility of using AF_PACKET to send CAN frames. Do you have a
link to any example of such code? I would be glad to study it and come
back to you once I understand this point.

> The above pseudo code together with CAN_CTRLMODE_RAW_DLC seems to be a
> pretty safe option to me. Even if 'legacy' applications with
> uninitialized raw_dlc send CAN frames or AF_PACKET users enable
> CAN_CTRLMODE_RAW_DLC we always end up with a proper can_dlc == 8  and a
> fitting valid raw_dlc.

But what if that "fitting valid raw_dlc" is greater than 8? The kernel
would see that frame as valid, a frame with a DLC greater than 8 will
be sent on the wire and received by the other devices than might be
connected on the CAN bus.

>>
>> If we go this direction, I would propose below logic:
>>
>>   1. if raw_dlc equals can_dlc: nominal case.
>
> Is not tested. We would start on testing can_dlc == 8
>
>>
>>   2. if can_dlc equals 8 and raw_dlc is greater than 8: use raw_dlc
>>      case, already covered in your code.
>
> ACK
>
>>   3. if raw_dlc is 0, then consider it as unset: overwrite raw_dlc with
>>      can_dlc (so that it becomes case 1).
>
> Is not tested like this. We would start on can_dlc == 8 - and then check
> for valid raw_dlc 9..15
>
>>
>>   4. Other scenarios: the frame is malformed: drop it.
>
> No dropping.
>
>> Logic should apply for both Tx and Rx paths.
>
> So test for can_dlc == 8 - and then check for valid raw_dlc 9..15 in the
> user space?! Fine.

My view: users and drivers directly use raw_dlc without need to check
for can_dlc == 8 (detailed explanation below).

> Btw. we can make sure that we do not have uninitialized raw_dlc value in
> the rx path in the enabled drivers. In fact you could always use the
> raw_dlc then.

My view is that if we introduce the raw_dlc field, we should always
populate it with the DLC value as defined in ISO, even if
CAN_CTRLMODE_RAW_DLC and CAN_RAW_RAW_DLC are not active. User could
then benefit from this field to get the DLC value (and maximum value
would be either CAN_MAX_DLC or CAN_MAX_DLC RAW depending on the
context).

Rationale is that the raw_dlc field would always be visible in the
struct can_frame. So if it is here, use it. Having it sometimes used,
sometimes not would be confusing for the user.

Basically, that would replace the use of the can_len2dlc() function.

I also think it should be extended to CAN-FD, but no need to elaborate
more on this at the moment: let's keep the discussion focused on
classical CAN and tackle this later.

> BUT it makes sense to use this test to detect cases, where someone
> forgot to switch on CAN_CTRLMODE_RAW_DLC or the driver doesn't support
> it and the programmer did not check the ctrlmode netlink return values.

My view: if the user tries to send raw_dlc bigger than 8 and
CAN_CTRLMODE_RAW_DLC and CAN_RAW_RAW_DLC are not active, return
-EINVAL.

>> Then, the drivers/users would only have to manage scenarios 1 and 2
>> (and 2 can be ignored if CAN_CTRLMODE_RAW_DLC is not advertised).
>>
>>>>
>>>> If I understand well, the idea would be not to use a setsockopt() but
>>>> instead rely on some logic on the can_dlc and raw_dlc to determine
>>>> which one to use.
>>>>
>>>> Unfortunately, this approach has one issue in the TX path that could
>>>> break existing applications.
>>>>
>>>> Consider below code (which I think is fairly realistic):
>>>>
>>>> void send_frame (int soc, canid_t can_id, char *data, size_t len)
>>>> {
>>>>       struct can_frame cf;
>>>>       size_t dlc = len > sizeof(cf.data) ? sizeof(cf.data) : len;
>>>>
>>>>       cf.can_id = can_id;
>>>>       cf.can_dlc = dlc;
>>>>       memcpy(cf.data, data, dlc);
>>>>
>>>>       write(soc, &cf, sizeof(cf));
>>>> }
>>>>
>>>> Here, the user did not initialize the can frame (cf) but assigned all
>>>> the relevant fields manually. Because cf is not initialized, the newly
>>>> introduced cf.dlc_raw field would have any of the values which was
>>>> present on the stack at the moment (rationale: the C standard does not
>>>> guarantee zero initialization). If 9 <= raw_dlc <= 15, the can frame
>>>> will be transmitted with a bad DLC value. If raw_dlc > 15, the can
>>>> frame will be discarded.
>>>
>>> No, this is not what I wrote. With my suggestion you need to populate
>>> both dlc elements to use the new "raw dlc" feature.
>>>
>>> if (can_dlc == 8) && (9 <= raw_dlc <= 15)
>>> => put raw_dlc value into the controller register
>>> else
>>> => put can_dlc value into the controller register
>>>
>>> When you have a test system to make security tests and you enable
>>> CAN_CTRLMODE_RAW_DLC on a specific CAN interface - which applications
>>> would you run to send CAN frames on this interface?
>>>
>>> I assume only the test application which is really aware of setting
>>> can_dlc and raw_dlc correctly.
>>
>> My point is that this assumption is dangerous.
>>
>> I do not think I made myself clear. I am speaking about old "non-DLC
>> aware" code running in CAN_CTRLMODE_RAW_DLC context.
>>
>> Consider two applications: the first application is a test application
>> which is "DLC aware", the second is a legacy application which
>> contains the code which I presented in my previous message.
>>
>> A user who wants to run both in parallel sets CAN_CTRLMODE_RAW_DLC at
>> netlink level. First application works fine, second application which
>> contains the legacy code gets impacted as explained previously and
>> stops behaving as intended.
>>
>> Newly introduced option should not break existing code regardless
>> why. In opposition, we can introduce new rules if these are strictly
>> tied to the new option.
>
> Yes but it doesn't help you with AF_PACKET.
>
>> In my mind, imposing a rule that old code should not be used in
>> CAN_CTRLMODE_RAW_DLC context would create a huge pitfall and would
>> violate the "don't break userland" principle.
>
> CAN_RAW_RAW_DLC could help in the case of legacy code only when they are
> using CAN_RAW sockets. But nothing more.
>
> Therefore we need the robustness on driver level with the checking of
> can_dlc == 8.

Will comment when I have a better understanding of AF_PACKET.

>>>> For userland, I think that this is acceptable because the very instant
>>>> the user calls setsockopt() with the CAN_RAW_RAW_DLC, he should be
>>>> aware of the consequences and should resign to use can_dlc field as a
>>>> plain length.
>>>
>>> Not filling can_dlc would cause tons of changes for sanity checks and
>>> feature switches.
>>
>> I never spoke about "not filling can_dlc". My point is to not use it
>> as a length but use it as a DLC according to ISO definition. In my
>> approach, can_dlc should always be filled with the raw DLC value.
>
> Ok, let me rephrase: Filling can_dlc with something else than a plain
> length information 0..8 ;-)

Got it :-)

From my preliminary study, not so much changes or sanity check would
need to be added:

  1. The current can_dlc sanity checks in can_send() and can_rcv() in
     net/can/af_can.c definitely needs to be adjusted (but this would
     also be the case for the raw_dlc field solution).

  2. In the kernel Rx and Tx paths: the length should not be accessed
     directly anymore but through a getter function.

  3. In the kernel: drivers "DLC aware" need to adapt their code and
     use the length getter function.

  4. In user land: new "DLC aware" code should always use struct
     can_frame for classical CAN and check whether can_dlc is greater
     that CAN_MAX_DLEN before accessing data.

That's mostly all that would have to be adjusted.

>>> The 14 year old documentation in can.h says:
>>> @can_dlc: frame payload length in byte (0 .. 8)
>>>
>>> I will not break this established rule for a testing feature. The
>>> question from Joakim clearly showed: Don't touch this!
>>
>> My point is this is an expert feature: if you do not understand it, do
>> not use it and you are safe to go using the 14 years old definition.
>
> Full ACK - but you can't imagine what people do in the real world. Do
> you know these 'more helps more' guys that switch everything to 'on'? :-D

Switching everything options on through an "ip link set canX up ..."
should not cause damage. If the user is doing random setsockopt()
without any clues of what he is doing, then he is already a lost cause
for me...

> The approach with CAN_CTRLMODE_RAW_DLC and the described testing would
> be even robust against unintended miss-use.

Exception: can_dlc == 8 and a non-initialed raw_dlc gets a garbage
value between 9 and 15 from the stack (c.f. above comment).

>>> At the end it would have made more sense to call it can_frame.len in the
>>> first place. But this first came into our mind when CAN FD showed up.
>>> The discussion about the can_dlc meaning can be closed IMO. It is a
>>> plain length from 0..8 which is unfortunately named can_dlc.
>>
>> I agree that it should have been named len from the beginning, but as
>> a matter of fact it has been named "can_dlc". For me as a user, I
>> expect can_dlc to follow the DLC definition in ISO and so I *prefer*
>> to opt for the compromise of losing the plain length property rather
>> than losing the semantic meaning.
>
> I don't think you can claim to be a standard user. You are an expert for
> security testing and digged into the ISO standard and intentionally
> write DLC values >8 into controller registers. Users don't do things
> like this ;-)

You get a point :-)

Whatever the output of our discussion is, I have one strong
request. The linux kernel has a huge audience and has such, I think it
is our duty to be technically accurate even in small details.

I would like to add a comment in the struct can_frame to acknowledge
the discrepancy with the ISO. Some people who do not have access to
the ISO standard might refer instead to the SocketCAN documentation to
learn and understand the protocol and those people might use this
knowledge to program on other platforms (e.g. bare-metal
microcontrollers). Using the DLC as a plain length on those systems
might results in vulnerabilities in production and potentially safety
hazard.

That's also why I would like to see the Socket CAN DLC be used
according to ISO: so that we raise awareness on that issue and so that
users can transfer their knowledge to other platforms.

Updated comments would be something as below (rough draft):

@can_dlc: frame payload length in byte (0 .. 8). If the frame is a
      remote transmission request (RTR) @can_dlc represents the
      requested length and the actual payload length is 0
      bytes. ISO 11898-1 section 8.4.2.4 "DLC field" do allows DLC
      values from 0 to 15, however <TBD: will depend on the final
      output of this discussion>.

> Clean-up and renaming typically ends when it breaks APIs and commonly
> followed rules. There are many examples in Linux where these clean-up
> attempts have been canceled for these reasons.
>
> I would have liked to rename can_dlc to len too.
> But now that we have a compatible canfd_frame which can contain a
> can_frame this is somehow settled: can_dlc == len.
>
>> I would like to conclude by saying that I do necessarily think that
>> your approach of raw_dlc field is bad (if used in combination with the
>> setsockopt()). It has its pros and cons. However, if you ask me for
>> feedback, *my answer* is that *I prefer* to use can_dlc as a DLC. But
>> at the end of the day, I would be happy if the feature gets
>> implemented, regardless how, so that I can do my testing :-)
>
> So let's see how we can get there best :-)

Absolutely!


Yours sincerely,
Vincent Mailhol
