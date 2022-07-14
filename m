Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341CE574A2D
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 12:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiGNKKl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jul 2022 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiGNKKk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jul 2022 06:10:40 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AB64E85F
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657793437;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eoOfkOoccpqONUexv05rHuZjpvP6RHuheBvRmFVFlpo=;
    b=sJx9yDx9uKMlRskoPWTvpMK+JvE3CP+xhWjCX0rw43ohEc5Y4CJMnzuIHNpLiqxz1N
    xbtRrZdT3Ed9f33m2/sOlRMJBzihXv3bnBWnbV3iPm/y9IQpuIj0U5/A8kMC+ZHOHXrG
    37u3Y7D6yOt2x1EGqspEVE5ASX7hBtguHcZNc/LB66p/ZNJJnX/mrI8Oy56HJ3wZRvIi
    s0E/zDZkz/jxZ5WFq9a2/UPZTkY/KyLQiZt5lt9TcAWFjxJpEIK0EeyAZ8gZNm/00Z0f
    w0/nrM5SZI9CaJ5qQ47PhLAvhjuvNUL+2ioa6Yt8fkQnqjVFxF4pIxzVNSSGrAYqgoZi
    yo5w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6EAAb5Kw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 14 Jul 2022 12:10:37 +0200 (CEST)
Message-ID: <f73cdc76-c422-572e-1ef7-89f34c06051f@hartkopp.net>
Date:   Thu, 14 Jul 2022 12:10:30 +0200
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
 <b866e05b-a548-132c-4427-7a4d21d12172@hartkopp.net>
 <CAMZ6RqLGWB-afDmZfV+qJU2g=XUycFS1o9j6EwqRVg_dyf4eOw@mail.gmail.com>
 <16457321-6a4f-4830-17aa-d6efd7a39555@hartkopp.net>
 <CAMZ6RqLSHAdB-ocj7=74zJqWbv-EH9x8X5ARPK6Gv+FFiTZ7Lg@mail.gmail.com>
 <ae995ec1-8dbd-7484-a250-28d8637eb6ff@hartkopp.net>
 <CAMZ6RqLtUKja1dzvN9Wj8zRXigbeXW43jzpST-tZP9RmLHhVFg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLtUKja1dzvN9Wj8zRXigbeXW43jzpST-tZP9RmLHhVFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 14.07.22 11:12, Vincent Mailhol wrote:
> On Thu. 14 Jul. 2022 at 15:11, Oliver Hartkopp <socketcan@hartkopp.net> wrote:



>> I would suggest the following:
>>
>> #define CANXL_XLF 0x80 /* mark CAN XL frame (must be set) */
>> #define CANXL_SEC 0x40 /* Simple Extended Content (security/segmentation) */
> 
> OK. Having CANXL_SEC on the most significant bit (0x40) or instead of
> the least significant bit (0x01) works for me.

Hm. This is a really iterative process ;-)

Maybe

#define CANXL_XLF 0x80 /* mark CAN XL frame (must be set) */
#define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */

looks even more natural:

The MSB is set and the other bits start from LSB as usual.

>> And the rest of the bits are reserved (shall be set to zero).
> 
> ACK.
> 
>> This way the CAN_XLF value would make the former 'len' element 128 -
>> which is a proper distinction for CAN XL frames as such length value
>> surely bounces on CAN/CANFD frames.
> 
> The purpose of the CAN_XLF is still unclear to me. In your initial
> patch, you wrote that CAN_XLF was to "mark CAN XL for dual use of
> struct canfd_frame". So are we really OK to specify that CAN_XLF is
> always set? How are we going to tag dual use?

I think the dual-use pattern does not make sense anymore as either the 
flags element and the len element have been moved away from the struct 
can[fd]_frame layout.

There is no layout match between CAN XL and CAN/CANFD anymore.

> But my main point was to always set 0x80 to differentiate between
> CAN(-FD) and CANXL, and we are aligned on this. :D

ACK.

IMO this 0x80 bit at this specific position is an excellent flag to 
introduce CAN XL frames and to provide a proper break with CAN/CANFD 
data structures.

> The last topic remaining is the data[] vs. data[CANXL_MAX_DLEN]. I
> thought about it but can not find any killer arguments for either
> solution.
> The biggest difference is that for data[] we can do sizeof(struct
> canxl_frame) to get the header file whereas for data[CANXL_MAX_DLEN],
> we need to introduce the CANXL_HEADER_SIZE macro.
> My preference still goes toward the data[] because I see flexible
> member arrays as being more idiomatic C. But it is more for personal
> taste than anything else…

I see it as a practical thing for programmers (also in userspace) to 
allocate sizeof(struct canxl_frame) and do all the checks and operations 
similar to struct can[fd]_frame (and the ISO CAN Spec).

It just makes it very clear what we are talking about.

The fact that we can reduce the content size whenever we transfer 
content from/to kernel space or inside the kernel is just a nice 
optimization IMO.

> Yours sincerely,
> Vincent Mailhol

Thanks for your feedback! I think I'll post an updated patch set later 
today to continue the discussion on a new code basis.

Best regards,
Oliver
