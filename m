Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A207C6375F3
	for <lists+linux-can@lfdr.de>; Thu, 24 Nov 2022 11:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKXKJ3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Nov 2022 05:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKXKJ3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Nov 2022 05:09:29 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABB9B9498
        for <linux-can@vger.kernel.org>; Thu, 24 Nov 2022 02:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1669284565;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=pJeoHDTbJwXOg0E0zLY0l0wk7A/EKJGFN4PDuczh4MM=;
    b=l51sbnjAfFcz3/R868D1f1kd/oshGkPqVqRC85cpUuNk/CNf5Dx9dQm8bEU5v3bh/J
    KxappgzC0YeGewhza8hXgYxv8Z2d+Wx1Y5lBQvtnv8wQTug9uGtB1oFSb9zltidwToc0
    EmOxxd7k8z5hs5i8SauFEOgddiMFvyhw2skeLAiuEaTVUUquljwL9L0FJ8G8sVsBDxT6
    7e1GwrnLKe/9ipOZtsG+y50aORQwyKX0Ib5DFQToCk4bSwhnXsFo/okrZdy2X01BVeJt
    fXJ+gJvqBXunfT8/Ktwz8M+gIP6plMNCy9n2dOFb2F1PeNGdJW1Qoy4O5AF5OMz4olaF
    3wNw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6hfz3Vg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::923]
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id Dde783yAOA9PHHh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 24 Nov 2022 11:09:25 +0100 (CET)
Message-ID: <5a309931-ca81-5433-b437-5c8ec23c4d85@hartkopp.net>
Date:   Thu, 24 Nov 2022 11:09:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] can: mcba_usb: Fix termination command argument
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= 
        <remigiusz.kollataj@mobica.com>,
        Yasushi SHOJI <yashi@spacecubics.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
References: <20221123194406.80575-1-yashi@spacecubics.com>
 <20221123223410.sg2ixkaqg4dpe7ew@pengutronix.de>
 <CAELBRWJoQjLD9UaFUmqnFWT9HkPMNb4kKF+1EZwcfrn_WBwBYw@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAELBRWJoQjLD9UaFUmqnFWT9HkPMNb4kKF+1EZwcfrn_WBwBYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 24.11.22 10:50, Yasushi SHOJI wrote:
> Hi,
> 
> On Thu, Nov 24, 2022 at 7:34 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>
>> Let's take the original driver author into the loop.
>>
>> On 24.11.2022 04:44:06, Yasushi SHOJI wrote:
>>> Microchip USB Analyzer can be set with termination setting ON or OFF.
>>> As I've observed, both with my oscilloscope and USB packet capture
>>> below, you must send "0" to turn it ON, and "1" to turn it OFF.
>>>
>>> Reverse the argument value to fix this.
>>>
>>> These are the two commands sequence, ON then OFF.
>>>
>>>> No.     Time           Source                Destination           Protocol Length Info
>>>>        1 0.000000       host                  1.3.1                 USB      46     URB_BULK out
>>>>
>>>> Frame 1: 46 bytes on wire (368 bits), 46 bytes captured (368 bits)
>>>> USB URB
>>>> Leftover Capture Data: a80000000000000000000000000000000000a8
>>>>
>>>> No.     Time           Source                Destination           Protocol Length Info
>>>>        2 4.372547       host                  1.3.1                 USB      46     URB_BULK out
>>>>
>>>> Frame 2: 46 bytes on wire (368 bits), 46 bytes captured (368 bits)
>>>> USB URB
>>>> Leftover Capture Data: a80100000000000000000000000000000000a9
>>
>> Is this the USB data after applying the patch?
> 
> That's not from Linux.
> 
>> Can you measure the resistance between CAN-H and CAN-L to verify that
>> your patch fixes the problem?
> 
> Sure.  The command I'm using on my Linux is:
> 
>      sudo ip link set can0 up type can bitrate 100000 termination X
> 
> where X is either 0 or 120.
> 
> With Debian Sid stock kernel: linux-image-6.0.0-4-amd64
>    - termination 0: 135.4 Ohms
>    - termination 120: 17.82 Ohms
> 
> With my patch on v6.1-rc6
>    - termination 0: 22.20 Ohms
>    - termination 120: 134.2 Ohms
> 

Hugh!

What does "termination 0" mean here?

I assumed "termination 0" results in "termination off" (=> no 
termination => very high resistor value) but in fact it gets around 20 
Ohms, which is a pretty heavy termination for a CAN bus.

Best regards,
Oliver


>>> Signed-off-by: Yasushi SHOJI <yashi@spacecubics.com>
>>> ---
>>>   drivers/net/can/usb/mcba_usb.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
>>> index 218b098b261d..67beff1a3876 100644
>>> --- a/drivers/net/can/usb/mcba_usb.c
>>> +++ b/drivers/net/can/usb/mcba_usb.c
>>> @@ -785,9 +785,9 @@ static int mcba_set_termination(struct net_device *netdev, u16 term)
>>>        };
>>>
>>>        if (term == MCBA_TERMINATION_ENABLED)
>>> -             usb_msg.termination = 1;
>>> -     else
>>>                usb_msg.termination = 0;
>>> +     else
>>> +             usb_msg.termination = 1;
>>>
>>>        mcba_usb_xmit_cmd(priv, (struct mcba_usb_msg *)&usb_msg);
>>
>> What about the static void mcba_usb_process_ka_usb() function? Do you
>> need to convert this, too?
> 
> Ah, yes. Thanks.
> Attaching a compressed patch.
> 
> Let me know if I need to resend it as an email.
> 
> Best,
> --
>            yashi
