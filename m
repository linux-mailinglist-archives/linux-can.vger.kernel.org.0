Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508B252DD12
	for <lists+linux-can@lfdr.de>; Thu, 19 May 2022 20:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242476AbiESSvF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 May 2022 14:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbiESSvA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 May 2022 14:51:00 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC72B18F
        for <linux-can@vger.kernel.org>; Thu, 19 May 2022 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652986254;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=AYSpaU4e2wkrmNXvCGj4B0yxzgoceFX0HXzVlG+U6CY=;
    b=Lr40XABEgfrgMa6eUdQ4ZWy3qVy+gItgAnjfzA3suQFFHBPXqbmQFKzXIc7gaddwyk
    lmtGReS8478ghCVDM9C1mg/mdPvFf1HfNKqld/d3xSg8Rln1G+0EBxKbJInyr9pW63+B
    g+2VJil7YryusEoWCb0FNJ2uuZszWKLqKsh/serXeVjX1uO61MEJ3caA9d1KyPg1sOgS
    viso//kcJYb04zUDO0EOJgpKoR5vRPWn8iKHVN66Qg0t6ZHmse7dXlTO6XI1JaEoBraT
    kunl7k5awrna0/4xCf24a/iDj/l+U2yssnbq/x5MxwvdV/emjHi+dNAqnn6L8gJ39WfX
    7lTw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOug2krLFRKxw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b04::b82]
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id R0691fy4JIosMIb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 19 May 2022 20:50:54 +0200 (CEST)
Message-ID: <b0b224b7-f454-e579-b80a-9d6c0cadc6d3@hartkopp.net>
Date:   Thu, 19 May 2022 20:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: can, m_can, tcan4x5x : big jitter between the packets by sending
Content-Language: en-US
To:     anochin@photo-meter.com
References: <9e431f19-897e-7bff-68bb-7ac7bb9fd757@photo-meter.com>
 <f6d6522e-e63c-ea0f-e554-ea1cfc1b27a4@hartkopp.net>
 <1259c8f0-9a2d-b28c-fad3-3b7459161a1d@photo-meter.com>
Cc:     linux-can <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <1259c8f0-9a2d-b28c-fad3-3b7459161a1d@photo-meter.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Michael,

On 19.05.22 18:56, Michael Anochin wrote:

>> How does this application implement this 10ms interval?
> 
> I use epiktimer https://wiki.lazarus.freepascal.org/EpikTimer
> (https://github.com/graemeg/epiktimer) for freepascal compiler. It calls 
> fpsend (like "send" in c) very periodically to put the can_fd msg to the 
> buffer. No doubt on this. I think, the lag is in a m_can implementation. 

Ok.

> The interrupts are switched off briefly in m_can_isr 
> (m_can_disable_all_interrupts), may be one of IRQs goes lost or 
> something like this.

Hm. Do you plan to test the Linux 5.17 kernel to make use of the latest 
SPI improvements then?

>>> Can you check  cangen -g 10 -f -I 123 -L 64 can0
> Yes, I will do it tomorrow and report.

Good.

>>>      candump -td can0
> I see even greater jitter with candump -td. That's why I took the 
> separate CAN adapter for sniffing.

Ok.

>>> What is the use-case for this 10ms cyclic transmission? 
> The use-case is in the communication with car light (automotive sector).

Aah - I have a rough idea ;-)

>>> Maybe the CAN_BCM could bring an improvement 
> Unfortunately, the format of a broadcast message cannot be taken. There 
> is a package counter in each message, wich sould be incremented each time.

In fact the CAN_BCM is also capable to send a sequence(!) of CAN(FD) frames.

The nframes element in the struct bcm_msg_head can be e.g. 16 (4 bit 
counter) or even 256 (8 bit counter) so that you can create (or modify) 
a bigger array of CAN(FD) frames including the counter value or some 
checksums.

And then this array can be (asynchronously) pushed to the BCM socket for 
content updates while the cycle time for the proper and precise 
transmission is maintained in the kernel.

You should give it a try ;-)

Best regards,
Oliver


> 
> Am 19.05.2022 um 18:26 Oliver Hartkopp:
>> Hi Michael,
>>
>> On 19.05.22 17:52, Michael Anochin wrote:
>>
>>> my application continuously sends 64 bytes CANFD packets with 1MBit/s 
>>> at the 10ms interval.
>>
>> How does this application implement this 10ms interval?
>>
>> Can you check whether
>>
>>      cangen -g 10 -f -I 123 -L 64 can0
>>
>> has the same problems?
>>
>> With
>>
>>      candump -td can0
>>
>> you should be able to see some timestamp gaps around 10ms.
>>
>>> I use tcan4450 on the RPI4 with 5.10.103 Kernel and raspbian. No 
>>> other significant processes load the CPU.
>>>
>>> When I monitor the traffic with a PCAN adapter on a Windows PC, I 
>>> notice that the packets sometimes arrive with a delay of 5-9ms. But 
>>> the next following packet arrive faster as 10ms. My desired interval 
>>> of 10ms is kept at the jitter of +/- 9ms.
>>>
>>> Running the App on only one CPU core using tasksel improve the jitter 
>>> somewhat.
>>
>> What is the use-case for this 10ms cyclic transmission? Maybe the 
>> CAN_BCM (which uses in-kernel highres timers) could bring an 
>> improvement for you.
>>
>>> Am I the only one who observes such large jitter or is the m_can 
>>> implementation at Perepherie (spi) not so fast from the throughput 
>>> and is completely normal.
>>>
>>> Maybe I should switch to 5.17 kernel? On 5.17 there are bulk 
>>> read/write function for spi regmap.
>>
>> I don't answer to this as I don't have the required SPI knowledge ... 
>> but if you could upgrade to a newer kernel this is always a good 
>> approach ;-)
>>
>> Best regards,
>> Oliver
