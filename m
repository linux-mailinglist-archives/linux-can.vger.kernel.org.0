Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B14857BBA1
	for <lists+linux-can@lfdr.de>; Wed, 20 Jul 2022 18:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiGTQoR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jul 2022 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGTQn7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2022 12:43:59 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE60965565
        for <linux-can@vger.kernel.org>; Wed, 20 Jul 2022 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658335436;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=w0n4ORTWdHmFHA0vJg1QqwTPL/9ucecq7uPypEp/ZW8=;
    b=EzEDkPoh5U1N2drulYvIVXA7VBmgjYvfx9Tf5YVd78mvp9MnFGyXgPzWdCRauHN8Uk
    qPEQU9j3eicqM5nwnJ1BJXTVIjMxgJP83X0Vh0OMM5at2vjkkoyV2E+njwoDsFooE7jI
    fWC/L/dJ78aXryAT87NA1Kj8pzaHXj7jL/Ua97qGlNogvtq8GcMCXPgzpeoEKsIbGNAk
    p9vbTSUrqM8JmTWURiShQw9BPNkgTcsdTalvP4E1GHnN7yPqsTPyQo4S1wfMcZL0S+vI
    Eh/6n9HgTYC9wY5UtuULFnwUjsVl7jfyGyp/JhELjcuM3n8J7BG9yAm+yx46UoKNCod8
    Lqyw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id jdcffay6KGht1Rh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 20 Jul 2022 18:43:55 +0200 (CEST)
Message-ID: <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
Date:   Wed, 20 Jul 2022 18:43:55 +0200
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
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 19.07.22 17:16, Vincent Mailhol wrote:
> On Tue 19 Jul. 2022 at 23:38, Oliver Hartkopp <socketcan@hartkopp.net> wrote:


>> No confusion.
>>
>> The API to the user space is 'truncated' option only.
>>
>> The data structure inside the kernel sizeof(struct can[|fd|xl]_frame).
>>
>> See:
>> https://lore.kernel.org/linux-can/4c79233f-1301-d5c7-7698-38d39d8702aa@hartkopp.net/
>>
>> ---8<---
>>
>> As the sk_buffs are only allocated once and are not copied inside the
>> kernel there should be no remarkable drawbacks whether we allocate
>> CAN_MTU skbs or CANXL_MTU skbs.
>>
>> AFAICS both skbs will fit into a single page.
> 
> This is true. A page is at least 4k. So the 2k + alpha will easily fit.
> But the page is not the smallest chunk that can return malloc, c.f.
> KMALLOC_MIN_SIZE:
> https://elixir.bootlin.com/linux/latest/source/include/linux/slab.h#L279
> 
> Also, more than the page size, my concern are the cache misses,
> especially when memsetting to zero the full canxl frame. As far as I
> understand, cloning an skb does not copy the payload (only increment a
> reference to it) so the echo_skb thing should not be impacted.
> That said, I am not able to tell whether or not this will have a
> noticeable impact (I have some feeling it might but can not assert
> it). If this looks good for the people who have the expertise in
> kernel performances, then I am fine.

The more I think about our discussion and your remark that we were 
somehow going back to the V2 patch set the more I wonder if this would 
be a good idea.

IMO using the struct canxl_frame (including 2048 byte) and allowing 
truncated sizes can be handled inside the kernel safely.

And with V2 we only allocate the needed size for the sk_buff - without 
any memsetting.

When user space gets a truncated frame -> fine

When the user forges some CAN XL frame where the length value does not 
match the spec and the size does not fit the length -> -EINVAL

So there is no uninitialized data also.

And even the user space side to handle a mix of CAN frame types is 
pretty simple IMO:

union {
         struct can_frame cc;
         struct canfd_frame fd;
         struct canxl_frame xl;
} can;

nbytes = read(s, &can.xl, sizeof(struct canxl_frame));
if (nbytes < 0) {
         perror("read");
         return 1;
}
printf("nbytes = %d\n", nbytes);

if (nbytes < CANXL_HDR_SZ + CANXL_MIN_DLEN) {
         fprintf(stderr, "read: no CAN frame\n");
         return 1;
}

if (can.xl.flags & CANXL_XLF) {
          if (nbytes != CANXL_HDR_SZ + can.xl.len) {
                 printf("nbytes = %d\n", nbytes);
                 perror("read canxl_frame");
                 continue;
          }
          /* process CAN XL frames */
          printf("canxl frame prio %03X len %d flags %d\n",
                  can.xl.prio, can.xl.len, can.xl.flags);
          continue;
}

if (nbytes != sizeof(struct can_frame) &&
     nbytes != sizeof(struct canfd_frame)) {
         fprintf(stderr, "read: incomplete CAN(FD) frame\n");
         return 1;
}

/* process CAN/FD frames */

Working with partially filled data structures is a known pattern for CAN 
and CAN FD.

We only optimize the transfer from/to kernel space with truncated 
read/write operations.

¯\_(ツ)_/¯

> 
> Maybe even better:
> 
>          switch(ntohs(skb->protocol)) {
>          case ETH_P_CAN:
>                 /* ... */
>          case ETH_P_CANFD:
>                 /* ... */
>          case ETH_P_CANXL:
>                  /* ... */
>          default:
>                  /* ... */
>          }

Yes ... updated my next patch.

Best regards,
Oliver
