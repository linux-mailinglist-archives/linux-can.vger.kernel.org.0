Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5A35719FC
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiGLMag (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 08:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiGLMaf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 08:30:35 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD17A30F64
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657629032;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ltfxOaewhVxDjRWRZ5eMdDe1hjXL1SpeVIMDGZf4PD8=;
    b=GIl8DCVfQjDuFHWaiqRS01idKRq3G04zTQw+Ocl2gLv3vk325N6EYmdP7E2C/9YSr4
    qps1Ro4QUw288QdGNjSP7N3eg+NDpChvpVH936dCYTB8CAnoPB+uTnqTM/yZxL3ViCm5
    aSz8cRItbvwWxc0qzwoOa/bmPW8moc2dJCyQJIe3rnM9G1oKBwTWvKbRA/sgQkF2sd3C
    Uy62RGa5TJawB1aN20AJf4/tzOqm0pXn5xC7oL1y4+Fp2nZDaNXE9sW6dOdwBGEoni+9
    83Cn5JWeK1Ajdt+PgLG7v0pgYxh6Jq64CG5wAO5OTkowcSwc2ewW+RUDM26mbdZA4zeB
    1c3g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id 398cccy6CCUVTqN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Jul 2022 14:30:31 +0200 (CEST)
Message-ID: <89f90d61-35a4-59a2-231b-4372d4dca25c@hartkopp.net>
Date:   Tue, 12 Jul 2022 14:30:26 +0200
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
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqJhjkVgZgmfk7btYK+bLtqnbvGBYTnssy28ZWqyfyqppw@mail.gmail.com>
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



On 12.07.22 12:19, Vincent Mailhol wrote:
> On Tue. 12 Jul. 2022 at 18:31, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>>>> +/* truncated CAN XL structs must contain at least 64 data bytes */
>>>> +#define CANXL_MINTU    (CANXL_MTU - CANXL_MAX_DLEN + CANFD_MAX_DLEN)
>>>
>>> I did not get the concept of the "truncated CAN XL structs". The valid
>>> data field lengths are 1 to 2048, right? I did not get where this 64
>>> comes from.
>>> Your formula is equivalent to
>>> #define CANXL_MINTU    (sizeof(struct canxl_frame) + CANFD_MAX_DLEN)
>>
>> No. CANXL_MINTU becomes sizeof(struct canfd_frame) + sizeof(af)
>>
>> So I wanted some size value that is 'more than' CANFD_MTU so that you
>> know that you have read a CANXL frame.
>>
>> Even if the cxf->len would be 14 you would at least copy a struct
>> canxl_frame with data[64].
> 
> OK, I finally got your point. Your concern is that if skb->len could
> be equal or less than CANFD_MTU, then there would be a collision.
> 
> My approach here would be to stop using the MTU correlation to
> differentiate between CAN(-FD) and CANXL. Instead, I suggest using
> can{fd,xl}_frame::flags. If can{fd,xl}_frame has a CANXL flag set,
> then it is a CANXL frame regardless of the value of skb->len. If the
> CANXL flag is not set, then skb->len is used to differentiate between
> Classic CAN and CAN FD (so that we remain compatible with the
> existing). That way, no need to impose a minimum length of
> CANFD_MAX_DLEN.

Hm, that sounds interesting! I like that as it looks clear and simple.

Need to pick a coffee to think about potential (security) effects ... ;-)

E.g. we would need to keep skb->len and canxl_frame::len in sync now.

> 
>>>
>>> I would have just expected:
>>> #define CANXL_MINTU    (sizeof(struct canxl_frame))
>>
>> That is CANXL_MTU (max transfer unit).
> 
> I was writing while thinking that canxl_frame::data was a flexible
> array member as suggested in this thread.
> In that case canxl_frame::data counts as zero when doing sizeof(struct
> canxl_frame). And so sizeof(struct canxl_frame) == sizeof(struct
> canfd_frame) + sizeof(af).
> 
> Actually, thinking twice, the Minimum transfer unit would be:
> #define CANXL_MINLEN 1
> #define CANXL_MINTU    (sizeof(struct canxl_frame) + CANXL_MINLEN)
> 
> (I forgot that the length can not be zero anymore in CANXL...)

I still would suggest to have the struct canxl_frame contain the 2048 
byte of data (data[CANXL_MAXDLEN]) - as the entire CAN XL frame is 
defined like this in the CAN XL spec. This would be also in common with 
CAN/CANFD.

E.g. when reading into the struct canxl_frame you always have a defined 
data structure which can contain a complete CAN XL frame.

But if you get or send less than that size (when reading/writing) this 
would be ok now (with your idea with CANXL_XLF set).


E.g.

#define CANXL_MINDLEN 1
#define CANXL_MAXDLEN 2048

#define CANXL_MTU sizeof(struct canxl_frame)
#define CANXL_HEAD_SZ (CANXL_MTU - CANXL_MAXDLEN)
#define CANXL_MINTU (CANXL_HEAD_SZ + CANXL_MINDLEN)

(..)

>>> Here, you lost me. The only reference document I have is the Bosch
>>> presentation you linked in the cover letter. I would need to get a
>>> copy of the specification first to follow up on this level of details.
>>
>> There is a Special Interest Group for CAN XL at CAN in Automation
>> (can-cia.org) and these doscuments are currently under development.
> 
> I wonder how hard it is to join the group. Right now, I was thinking
> of waiting for the ISO Final Draft International Standard (FDIS) to
> deep dive in CANXL.

I'm not sure if the SDT definitions will be part of an ISO draft as 
defining the content inside a CAN XL frame is probably not ISO standard 
relevant.

The content definitions are industrial recommendations to increase 
interoperability. You are always free to put into the CAN XL frame 
whatever you want.

E.g. CAN-CiA defined the pinout of the SUB-D9 connectors for CAN (Pin 
2/7) which is not defines in ISO too.

Best regards,
Oliver

