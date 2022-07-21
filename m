Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB18957C564
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 09:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiGUHgc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jul 2022 03:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGUHga (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 03:36:30 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA16E7C1AD
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658388986;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=rZVFA52B5tlmZ4K/GBeYBuJsuGCI56BJAYYyxXIQ85w=;
    b=Ru7kaXSNWU4rtztMD0TUThjwX2PbVZuYKnG2Flh9DaMaQWGYFbVQDwgKw3I0NXtExH
    S1Mt/9TlO/VF7ilTsrAuMmniAOpqfgYY+6LKCkEa0bDQBEZxU1G7Osa8N6Ux22lhsNr4
    w/Dwewm6Yz/ViuX/ps0tUPK+oNte7QBeov8ceJLlUYJgRSvPTuxoVx+crYM5froNMvI0
    19dx/84Nnpif9AShR86ov8nTj0DD7UPYzOpQ7IYK5wNjxM7ytgrTHyUrdjA53a1/z1Vd
    XTrBfSGSkKClaKXGhJiOHigFqc3KNd/ZpByP+ZEANZmxiUro1TrUZVMDBl+seX5T0bn0
    oTaQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id jdcffay6L7aQ2Y8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 21 Jul 2022 09:36:26 +0200 (CEST)
Message-ID: <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net>
Date:   Thu, 21 Jul 2022 09:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <20220719112748.3281-1-socketcan@hartkopp.net>
 <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net>
 <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
 <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 21.07.22 04:37, Vincent Mailhol wrote:
> On Wed. 21 Jul. 2022 at 01:43, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 19.07.22 17:16, Vincent Mailhol wrote:
>>> On Tue 19 Jul. 2022 at 23:38, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>>> No confusion.
>>>>
>>>> The API to the user space is 'truncated' option only.
>>>>
>>>> The data structure inside the kernel sizeof(struct can[|fd|xl]_frame).
>>>>
>>>> See:
>>>> https://lore.kernel.org/linux-can/4c79233f-1301-d5c7-7698-38d39d8702aa@hartkopp.net/
>>>>
>>>> ---8<---
>>>>
>>>> As the sk_buffs are only allocated once and are not copied inside the
>>>> kernel there should be no remarkable drawbacks whether we allocate
>>>> CAN_MTU skbs or CANXL_MTU skbs.
>>>>
>>>> AFAICS both skbs will fit into a single page.
>>>
>>> This is true. A page is at least 4k. So the 2k + alpha will easily fit.
>>> But the page is not the smallest chunk that can return malloc, c.f.
>>> KMALLOC_MIN_SIZE:
>>> https://elixir.bootlin.com/linux/latest/source/include/linux/slab.h#L279
>>>
>>> Also, more than the page size, my concern are the cache misses,
>>> especially when memsetting to zero the full canxl frame. As far as I
>>> understand, cloning an skb does not copy the payload (only increment a
>>> reference to it) so the echo_skb thing should not be impacted.
>>> That said, I am not able to tell whether or not this will have a
>>> noticeable impact (I have some feeling it might but can not assert
>>> it). If this looks good for the people who have the expertise in
>>> kernel performances, then I am fine.
>>
>> The more I think about our discussion and your remark that we were
>> somehow going back to the V2 patch set the more I wonder if this would
>> be a good idea.
> 
> I quite liked v2. My comments on the v2 were mostly to argue on the
> data[CANXL_MAX_DLEN] vs the flexible member array, but aside from
> that, it looked pretty good.
> 
>> IMO using the struct canxl_frame (including 2048 byte) and allowing
>> truncated sizes can be handled inside the kernel safely.
>>
>> And with V2 we only allocate the needed size for the sk_buff - without
>> any memsetting.
>>
>> When user space gets a truncated frame -> fine
>>
>> When the user forges some CAN XL frame where the length value does not
>> match the spec and the size does not fit the length -> -EINVAL
>>
>> So there is no uninitialized data also.
> 
> So basically, forcing the truncation everywhere (TX, RX both userland
> and kernel), correct? i.e. the skb length shall always be equal to
> CANXL_HEADER_SIZE + canxl_frame::len.

Yes!

Btw. How should we finally name the 'non data' header of CAN XL?

1. CANXL_HEADER_SIZE
2. CANXL_HEAD_SIZE
3. CANXL_HDR_SIZE
4. CANXL_HDR_SZ <- currently in the patches
5. CANXL_HD_SZ

I think it has to be 'head' and not 'header'.

In skbs we also have head and tail.

So I would vote for 2 or 5 with a tendency to 5.

> I think this is good. As I stated before, getting -EINVAL is benign.
> If developers are doing crazy things because they did not read the
> doc, it is better to fail them early. If we go for truncation then
> always truncating is the safest: less option -> less confusion.

ACK

>> And even the user space side to handle a mix of CAN frame types is
>> pretty simple IMO:
>>
>> union {
>>           struct can_frame cc;
>>           struct canfd_frame fd;
>>           struct canxl_frame xl;
>> } can;
> 
> Do you want to add this union in the kernel uapi or is it just a
> userland example?

Yes, that was just a userland example to read and write some CAN XL 
frames along with CAN/CANFD frames with the 'new' CAN_RAW socket.

I just wanted to get an impression whether it is handy to program this 
extended API or not.

>> nbytes = read(s, &can.xl, sizeof(struct canxl_frame));
>> if (nbytes < 0) {
>>           perror("read");
>>           return 1;
>> }
>> printf("nbytes = %d\n", nbytes);
> 
> Does read() guarantee atomicity? From "man 2 read":
> | It is not an error if [the return value] is smaller than the number
> | of bytes requested; this may happen for example because fewer bytes
> | are actually available right now (maybe because we were close to
> | end-of-file, or because we are reading from a pipe, or from a
> | terminal), *or because read() was interrupted by a signal*.
> 
> I think the answer is yes, but I prefer to double check (I am
> especially concerned by the signal interrupts).

Hm, we are not reading from a file but from a socket here that provide 
chunks in the form of struct can_frame in raw_recvmsg(). You only get a 
MSG_TRUNC there when you provide a (buffer)size in userspace that's to 
small.

I've never got any error reports on CAN_RAW reading (over 16 years) and 
all the examples contain a test for sizeof(struct can_frame) like this:

 >> if (nbytes != sizeof(struct can_frame) &&
 >>       nbytes != sizeof(struct canfd_frame)) {

So we either have an error or an incomplete CAN frame which becomes an 
error too.

Do you think this is still worth an investigation?

>>
>> if (nbytes < CANXL_HDR_SZ + CANXL_MIN_DLEN) {
>>           fprintf(stderr, "read: no CAN frame\n");
>>           return 1;
>> }
>>
>> if (can.xl.flags & CANXL_XLF) {
>>            if (nbytes != CANXL_HDR_SZ + can.xl.len) {
>>                   printf("nbytes = %d\n", nbytes);
>>                   perror("read canxl_frame");
> 
> ACK.

When we checked for a complete header this really seems to be simple. 
And we directly prove CANXL_MIN_DLEN and CANXL_MAX_DLEN is ensured by 
read().

> 
>>                   continue;
>>            }
>>            /* process CAN XL frames */
>>            printf("canxl frame prio %03X len %d flags %d\n",
>>                    can.xl.prio, can.xl.len, can.xl.flags);
>>            continue;
>> }
>>
>> if (nbytes != sizeof(struct can_frame) &&
>>       nbytes != sizeof(struct canfd_frame)) {
> 
> On the first read, I thought you meant "else if", then, I saw the
> "continue" on the previous line.

Yes. I just wanted to look if I got a CAN XL frame and print its attributes.

>>           fprintf(stderr, "read: incomplete CAN(FD) frame\n");
>>           return 1;
>> }
>>
>> /* process CAN/FD frames */
>>
>> Working with partially filled data structures is a known pattern for CAN
>> and CAN FD.
> 
> Except that for CAN-(FD), truncation is not possible.

Exactly. CAN/FD uses the fixed structure sizes to distinguish the frame 
types.

>> We only optimize the transfer from/to kernel space with truncated
>> read/write operations.
>>
>> ¯\_(ツ)_/¯
> 
> Yes, this full discussion is about optimizations…

Optimization and STYLE ;-)

Thanks for your feedback!

Best regards,
Oliver

