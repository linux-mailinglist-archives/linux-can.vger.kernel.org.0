Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EFF572629
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 21:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiGLTns (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 15:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiGLTnY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 15:43:24 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40FFA58D7
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657653888;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=2HLTqBk2Sppc++gZetjKLons5yrea5gqt7tWqBFk7pE=;
    b=L65YzlmaUzmZw4L38QfmhNE7/cclodhCTKSodhfzUVs/VcZxdhRsEGHg6TlTCyWfcy
    Kco2xTm7M9Hx1VP8DhuEkTlQ0tz8E4RYOL9vP9th8+PL3wfy8whej0JClkd58pJ6arVf
    2wSldf/Xmk0q1uCJjg/1PDicB3Ym9qsoMHIM8lQRkbQPVvCNMXMpmOC2gaYRP4CzwOVG
    Is1mdG7tThRt/2t4bDqKUppeJwLF30Hv8g2E3uEj7t7VPb/cKFiJvVY7LJuaHUXYKbX3
    KxliIeDb2CRq3FBUi3Zuh6hCUHtUeT8Owz3iq9DFy3ztxDOyI9qzcin4tlmqMaaW3jMR
    ENxw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6CJOm0KQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Jul 2022 21:24:48 +0200 (CEST)
Message-ID: <b866e05b-a548-132c-4427-7a4d21d12172@hartkopp.net>
Date:   Tue, 12 Jul 2022 21:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/5] can: canxl: introduce CAN XL data structure
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-2-socketcan@hartkopp.net>
 <CAMZ6RqLqDFqdtKsp6jGhnTtWRrf6HC5HiLuJUSCRNkDXqVfCzA@mail.gmail.com>
 <f00a4c5d-c4e6-06a2-76c0-53105d3465f2@hartkopp.net>
 <CAMZ6RqLVvYCoBF67VtqUSJHAxBHvEmK2-o8NCD7REZj1ywXf7w@mail.gmail.com>
 <521fe0a3-a9ad-60ac-3ec6-30f0da228032@hartkopp.net>
 <CAMZ6RqJhjkVgZgmfk7btYK+bLtqnbvGBYTnssy28ZWqyfyqppw@mail.gmail.com>
 <89f90d61-35a4-59a2-231b-4372d4dca25c@hartkopp.net>
 <CAMZ6Rq+LqfUhLcg6909=239a+Asm6aO-bPqpar2tQ_fs0EmiUQ@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6Rq+LqfUhLcg6909=239a+Asm6aO-bPqpar2tQ_fs0EmiUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12.07.22 16:31, Vincent Mailhol wrote:
> On Tue. 12 Jul. 2022 at 21:30, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 12.07.22 12:19, Vincent Mailhol wrote:
>>> On Tue. 12 Jul. 2022 at 18:31, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>>>>>> +/* truncated CAN XL structs must contain at least 64 data bytes */
>>>>>> +#define CANXL_MINTU    (CANXL_MTU - CANXL_MAX_DLEN + CANFD_MAX_DLEN)
>>>>>
>>>>> I did not get the concept of the "truncated CAN XL structs". The valid
>>>>> data field lengths are 1 to 2048, right? I did not get where this 64
>>>>> comes from.
>>>>> Your formula is equivalent to
>>>>> #define CANXL_MINTU    (sizeof(struct canxl_frame) + CANFD_MAX_DLEN)
>>>>
>>>> No. CANXL_MINTU becomes sizeof(struct canfd_frame) + sizeof(af)
>>>>
>>>> So I wanted some size value that is 'more than' CANFD_MTU so that you
>>>> know that you have read a CANXL frame.
>>>>
>>>> Even if the cxf->len would be 14 you would at least copy a struct
>>>> canxl_frame with data[64].
>>>
>>> OK, I finally got your point. Your concern is that if skb->len could
>>> be equal or less than CANFD_MTU, then there would be a collision.
>>>
>>> My approach here would be to stop using the MTU correlation to
>>> differentiate between CAN(-FD) and CANXL. Instead, I suggest using
>>> can{fd,xl}_frame::flags. If can{fd,xl}_frame has a CANXL flag set,
>>> then it is a CANXL frame regardless of the value of skb->len. If the
>>> CANXL flag is not set, then skb->len is used to differentiate between
>>> Classic CAN and CAN FD (so that we remain compatible with the
>>> existing). That way, no need to impose a minimum length of
>>> CANFD_MAX_DLEN.
>>
>> Hm, that sounds interesting! I like that as it looks clear and simple.
>>
>> Need to pick a coffee
> 
> Two years ago, it was a beer:
> https://lore.kernel.org/linux-can/a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net/
> 
> Now it is coffee. Seems that you change your drinking habits (just kidding) ;-)

That depends on the daytime ;-)

In Germany there's a saying:
"Kein Bier vor vier!"
(no beer before 4pm)

But a friend of my dad has a clock in his garage with only '4's on the 
watchface to make this test always return true :-D

>> to think about potential (security) effects ... ;-)
> 
> If we require a socket option as you already did (c.f.
> CAN_RAW_XL_FRAMES), I do not see a security risk.
> 
> If not using the socket option, then a user who activates CAN_XL at
> the netlink level and who runs a legacy application in which struct
> can_frame is declared on the stack and not initialised would be at
> risk. can_frame::__pad could contain garbage data which could be
> interpreted as a valid CAN_XL flag. From that point, the garbage
> values in can_frame::__res0 and can_frame::len8_dlc would be
> interpreted as an CANXL length.
> 
> The only requirement is that all applications which will use a mix of
> CANXL and non-CANXL frames shall make sure that no garbage values are
> present in can_frame::__pad or canfd_frame::flags. Coding guidelines
> such as MISRA and good static analyzers should also be able to catch
> this.

Yes. This was exactly my concern. But we can not assume that user space 
application is friendly or follows any MISRA guidelines.

Following your flexible length with CANXL_XLF idea you may forge a CAN 
XL frame inside a Classical CAN frame. But then we simply need to treat 
it as CAN XL frame any apply the other sanity checks.

>> E.g. we would need to keep skb->len and canxl_frame::len in sync now.
> 
> Not necessarily. The only strong condition is that:
>      skb_buff::len + sizeof(struct canxl_frame) < canxl_frame::len
> 
> If it is equal, then perfect, we are optimal. If greater, it just
> means that there is some garbage data. If the condition is not met, we
> just drop the skb of course.
> 
> Technically, we could remove canxl_frame::len and use below formula to
> derive the data length:
>      len = skb_buff::len - sizeof(struct canxl_frame)
> 
> In that case, the user must do all the length calculations correctly.
> This would be close to how TCP/IP frames are managed. But personally,
> I do not recommend removing canxl_frame::len.
> 
> Having both skb_buff::len and canxl_frame::len in sync is a design
> choice, not a necessity. I am still thinking of the implications and
> what is best between allowing garbage or forcing the two lengths to be
> in sync.

Ok.

(..)

>> I still would suggest to have the struct canxl_frame contain the 2048
>> byte of data (data[CANXL_MAXDLEN]) - as the entire CAN XL frame is
>> defined like this in the CAN XL spec. This would be also in common with
>> CAN/CANFD.
>>
>> E.g. when reading into the struct canxl_frame you always have a defined
>> data structure which can contain a complete CAN XL frame.
> 
> If we go this way, then I would allow the user to put garbage (i.e.
> not having the two lengths in sync).
> The rationale would be that we actually already allow such garbage
> values for CAN and CAN-FD. Also, this way, the user who has zero clues
> about the flexible array member property would simply do:
> 
>     struct canxl_frame cxl = { 0 };
>      /* ... */

(len and CANXL_XLF would have needed to be set here)

>      write(socket, &cxl, sizeof(cxl));
> 
> and it would work. 

Yes.


> The advanced user who understand what is going on
> can still do:
> 
>     struct canxl_frame cxl = { 0 };
>      /* ... */
>      write(socket, &cxl, CANXL_HEAD_SZ + cxl.len);
> 

ACK. I think this is feasible and easy to understand.

>> But if you get or send less than that size (when reading/writing) this
>> would be ok now (with your idea with CANXL_XLF set).
>>
>>
>> E.g.
>>
>> #define CANXL_MINDLEN 1
>> #define CANXL_MAXDLEN 2048
> 
> To be consistent with CAN_DLEN and CANFD_DLEN names:
> #define CANXL_DLEN 2048

You are right about the inconsistency. But it needs to be

#define CANXL_MIN_DLEN 1
#define CANXL_MAX_DLEN 2048

to fit the CAN/CANFD definitions.

>> #define CANXL_MTU sizeof(struct canxl_frame)
>> #define CANXL_HEAD_SZ (CANXL_MTU - CANXL_MAXDLEN)
>> #define CANXL_MINTU (CANXL_HEAD_SZ + CANXL_MINDLEN)
> 
> I need to think twice about all that, all the different alternatives
> (allow or not garbage, data as flexible member array vs.
> data[CANXL_DLEN]). Now it is a bit late, so I will continue to think
> about all that tomorrow.

I would suggest to not allow garbage and have skbuff::len and 
canxl_frame::len in sync.

When a userspace application writes more bytes than needed by 
canxl_frame::len, then that garbage is cropped to the needed size.

When less data is provided than required by canxl_frame::len this could 
lead to an error.

> But overall, I like the direction this thread is taking ;-)

Yep!

(..)

> Unrelated to this thread but I was wondering if you saw that my
> comments on the can_get_data_len() helper macro:
> https://lore.kernel.org/linux-can/20220711183426.96446-1-socketcan@hartkopp.net/T/#m01645d364e92681e5b889ca5d3c9f501e5d33dc3

Will answer on that thread.

Best,
Oliver
