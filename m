Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7A1577659
	for <lists+linux-can@lfdr.de>; Sun, 17 Jul 2022 15:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiGQNXP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Jul 2022 09:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGQNXO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Jul 2022 09:23:14 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7AF15FC6
        for <linux-can@vger.kernel.org>; Sun, 17 Jul 2022 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658064190;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YSaKjuiwMsKnnnHTkaBoQG70b2a7SuBsOQN9IExLmC8=;
    b=Auh2kebVgztD/PL6X5s5WslH41tI7ndcJc7ZNgvQhgwQszFsdHeo1OeADBkp9ajkOE
    1ZFy/wBjTB3KZWPVvrpmDLsnPfvakTnvSZ4IdAzns7HAqI9hpEUkfKvB4tRhEHbclW9P
    LwXOEfzAeLnGGxmPbibD/hWU9uJInyi4YEZ15eYM65H5Lm2Fr3p7NNrQUyK691F6E4K6
    jy20EfFAtut4fB6/YZow4hxi9g0YiFwc5JjcsLt1V8kzJ8/Fn8JhpSsgB9ShhQmeIODJ
    TuZANFrloZPST52hpa5H0iU5qK7WW8RGSL0m4fQAVNl5nbSSkuDPfwNV0ZmiZHmi3bfA
    J7Zw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6HDNAB7g
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 17 Jul 2022 15:23:10 +0200 (CEST)
Message-ID: <4c79233f-1301-d5c7-7698-38d39d8702aa@hartkopp.net>
Date:   Sun, 17 Jul 2022 15:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220714160541.2071-1-socketcan@hartkopp.net>
 <20220714160541.2071-4-socketcan@hartkopp.net>
 <20220714200601.mklari3b6uvb7b2e@pengutronix.de>
 <c731143e-f476-b2f8-c08c-df66339d98f8@hartkopp.net>
 <CAMZ6RqJ0=PhrJUHaZR6QNWkv2vx690AiwPF2RLv1ou_JGX1qxg@mail.gmail.com>
 <20220715073728.csp4hgbrgr2q62zu@pengutronix.de>
 <CAMZ6RqLxPHc3fW3711ExZxtmWmp7b7O8QhqY34R=9A8v-v8s9Q@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLxPHc3fW3711ExZxtmWmp7b7O8QhqY34R=9A8v-v8s9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 15.07.22 10:47, Vincent Mailhol wrote:
> On Fri. 15 Jul. 2022 at 16:37, Marc Kleine-Budde <mkl@pengutronix.de> wrote:

>>> But that example is a bit convoluted. That's why I wrote in my
>>> previous message that I saw no killer arguments against it.
>>
>> It just feels wrong to have a pointer to a struct canxl_frame that's
>> only backed half by memory.
> 
> I follow you on this feeling. But have no concrete bad examples of how
> the data[CANXL_MAX_DLEN] could be misused.
> 
>> I haven't followed the flex array discussion
>> in great detail, but it opens a whole class of errors if arbitrary
>> kernel memory can be accessed with struct canxl_frame::data using
>> seemingly valid array indices.
> 
> The point in the previous discussion is that the kernel should always
> crop the returned frames. If implemented correctly, such memory leaks
> should not occur.

I prepared a V3 patch set for that discussion.

It ended up with the fixed struct canxl_frame analogue to the 
CAN[fd]_frame's.

So whenever we have an enabled CAN XL netdevice we create a sk_buff in 
raw.c which can potentially hold a struct canxl_frame.

Even when we send a CAN/CANFD frame to that CAN XL interface.

The distinction inside the kernel remains with skb->len being 
CAN[|FD|XL]_MTU.

But the CAN_RAW socket read/write operations can be switched to a 
dynamic (cropped) size or to a complete sizeof(struct canxl_frame) via 
enhanced sockopt().

As the sk_buffs are only allocated once and are not copied inside the 
kernel there should be no remarkable drawbacks whether we allocate 
CAN_MTU skbs or CANXL_MTU skbs.

AFAICS both skbs will fit into a single page.

Best regards,
Oliver
