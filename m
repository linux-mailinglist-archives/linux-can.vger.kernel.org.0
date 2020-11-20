Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB52BB4CD
	for <lists+linux-can@lfdr.de>; Fri, 20 Nov 2020 20:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgKTTE0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Nov 2020 14:04:26 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:12079 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgKTTE0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Nov 2020 14:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1605899063;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=jmZFvYD9ifl4qTFlpAHqNreMFQtqxqXHs8SJDWzhAIo=;
        b=EjiRTiSUg5JiZWOjcnoFReIbVUf/if5RmpdvS3tbNR+HRMuzFqyHNMj07Fge2rD6iw
        d0V8Mj8OkK3M+Sk8Fxx6ZTyU32mp/GwQO9UHq2OosrE8sPi1gtzmvEbm1GGfMIcYZba1
        QZyvPvzYVDgXJEuewozmj/xRx4B5a8/Ioq2wIIhboUqf/MP24QMNVLB6UXqWv+9RhE9m
        +/BxqXDzx4/JE3Jh1+N40wUZZnYS4wKtIhfiNvT05dpD5iD3XGi/QsY75CDcI/ORQfVk
        gzszo70aGzKpECLpSJfH0q13UuotREQLnJW36fSNDbcbDSAWenHMSuAWjQtlFE7Wh225
        07uA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKONebStI="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwAKJ4IYH0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 20 Nov 2020 20:04:18 +0100 (CET)
Subject: Re: Question on CAN FD Driver for mcp251xfd
To:     Jin Park <jpark@enphaseenergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <DM6PR19MB3673FBAAA7A80E458659666EB1FF0@DM6PR19MB3673.namprd19.prod.outlook.com>
 <f168b9a4-79ae-7a8b-b074-632f86e8596b@pengutronix.de>
 <DM6PR19MB36739C691B6C35B4AD7DF77AB1FF0@DM6PR19MB3673.namprd19.prod.outlook.com>
 <032472ae-fb99-3c6f-ff3c-4e7b2d900980@hartkopp.net>
 <DM6PR19MB36730DFFB7BC34494EFA0DA3B1FF0@DM6PR19MB3673.namprd19.prod.outlook.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <1a822611-c7cd-5d91-2ad4-30f942de063f@hartkopp.net>
Date:   Fri, 20 Nov 2020 20:04:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB36730DFFB7BC34494EFA0DA3B1FF0@DM6PR19MB3673.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 20.11.20 19:57, Jin Park wrote:
> Hello Oliver,
> 
> It works!

Great!

Yes, a CAN FD controller is unhappy if only parts of the needed 
configuration is applied ;-)

https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev.c#L897

Have fun!

Oliver

> 1) I set it 1Mbps for arbitration phase and 4Mbps for data phase as bit rate switching like below.
> ip link set can0 up type can bitrate 1000000 sample-point 0.75 dbitrate 4000000 dsample-point 0.8 fd on
> 
> 2) Send CAN FD data
> cansend can0 123##1122334455667788991011121314151617181920
> 
> 3) I got the data through CAN bus.
> ID=291,Type=F,Length=32,Data=11223344556677889910111213141516171819202122232425
> 
> It solved!
> 
> Many Thanks,
> Jin
> 
> -----Original Message-----
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Sent: Friday, November 20, 2020 10:34 AM
> To: Jin Park <jpark@enphaseenergy.com>; Marc Kleine-Budde <mkl@pengutronix.de>; manivannan.sadhasivam@linaro.org
> Cc: linux-can@vger.kernel.org
> Subject: Re: Question on CAN FD Driver for mcp251xfd
> 
> EXTERNAL EMAIL - Use caution when responding, clicking, and/or downloading attachments.
> 
> 
> 
> 
> 
> On 20.11.20 18:14, Jin Park wrote:
>> Hello Marc,
>>
>> Here are my answers.
>> VAR-SOM-MX8M-Nano board drives MCP2517FD/MCP2518FD (CAN FD controller) and TCAN332G (CAN FD Transceiver) for CAN FD communication.
>>
>> 1) Which commands have you tried?
>> 2) What are the error messages?
>> Please see below a), b), c), and d).
>>
>>        a) Based on Bit Rate Switching feature in CAN FD, the bit rate at data phase and arbitration phase (or nominal phase) can be set in CAN FD protocol.
>> So, I tried below.
>> - command
>> ip link set can0 type can dbitrate 1000000
>>
>> - error message
>> RTNETLINK answers: Operation not supported
>>
>>
> 
> You need to apply both bitrates at the same time, e.g.
> 
> $ ip link set can0 up type can bitrate 500000 sample-point 0.75 dbitrate
> 4000000 dsample-point 0.8 fd on
> 
> See at:
> 
> https://www.kernel.org/doc/Documentation/networking/can.txt
> 
> Regards,
> Oliver
> 
>>
>>        b) To turn on FD mode, I tried below.
>> - command
>> ip link set can0 type can fd on
>>
>> - error message
>> RTNETLINK answers: Operation not supported
>>
>>
>>
>>        c) To send CAN FD message, I tried below. Th
>> - command
>> cansend can0 123##1
>>
>> - error message
>> CAN interface is not CAN FD capable - sorry.
>>
>> - help text for cansend
>>       <can_id>#{R|data}          for CAN 2.0 frames
>>       <can_id>##<flags>{data}    for CAN FD frames
>>
>> <can_id> can have 3 (SFF) or 8 (EFF) hex chars {data} has 0..8 (0..64
>> CAN FD) ASCII hex-values (optionally separated by '.') <flags> a
>> single ASCII Hex value (0 .. F) which defines canfd_frame.flags
>>
>> e.g. 5A1#11.2233.44556677.88 / 123#DEADBEEF / 5AA# / 123##1 / 213##311
>>        1F334455#1122334455667788 / 123#R for remote transmission request.
>>
>>
>>
>>
>>
>>        d) TCAN332G (CAN FD Transceiver) can support 5Mbps at data phase in CAN FD mode.
>> Current supported maximum bitrate in the driver is now 1Mbps at nominal rate.
>> (FYI, bit rate in data phase at CAN FD protocol is up to 8Mbps)
>>           Where: BITRATE  := { 1..1000000 }
>>                     SAMPLE-POINT  := { 0.000..0.999 }
>>                     TQ            := { NUMBER }
>>                     PROP-SEG      := { 1..8 }
>>                     PHASE-SEG1    := { 1..8 }
>>                     PHASE-SEG2    := { 1..8 }
>>                     SJW           := { 1..4 }
>>                     RESTART-MS    := { 0 | NUMBER }
>>
>>
>>
>> 3) What doesn't work exactly?
>>
>> I would like to send and receive messages in CAN FD with Bit Rate Switching (Arbitration phase: 1Mbps, Data phase: 5Mbps).
>> So far, CAN FD mode doesn't turn on with above commands.
>>
>> Thanks,
>> Jin
>>
>>
>> -----Original Message-----
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>> Sent: Thursday, November 19, 2020 11:11 PM
>> To: Jin Park <jpark@enphaseenergy.com>;
>> manivannan.sadhasivam@linaro.org
>> Subject: Re: Question on CAN FD Driver for mcp251xfd
>>
>> Hello Jin Park,
>>
>> please use the linux-can mailing list (linux-can@vger.kernel.org) for community question. There are other people interested in these question, please add list on Cc.
>>
>> On 11/20/20 4:03 AM, Jin Park wrote:
>>> I am using MCP251XFD SPI-CAN Network Driver with VAR-SOM-MX8M-NANO
>>> board now and would like to ask whether it can support CAN FD features as well.
>>
>> Yes it does support CAN-FD.
>>
>>> I tried to command with CAN FD features in terminal and it didn’t
>>> work with CAN FD commands.
>>
>> Which commands have you tried?
>> What are the error messages?
>> What doesn't work exactly?
>>
>>> Is there any plan to release CAN FD Linux Driver in the future, if
>>> you have worked on CAN FD?
>>
>> It should be working.
>>
>> Marc
>>
