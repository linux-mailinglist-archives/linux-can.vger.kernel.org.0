Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241025AB53D
	for <lists+linux-can@lfdr.de>; Fri,  2 Sep 2022 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiIBPc0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Sep 2022 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiIBPbv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Sep 2022 11:31:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A934E2E
        for <linux-can@vger.kernel.org>; Fri,  2 Sep 2022 08:13:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id br21so3831316lfb.0
        for <linux-can@vger.kernel.org>; Fri, 02 Sep 2022 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date;
        bh=MGqucpVw2uIA8AVHNsuBgm4dwW4sgPsiMMejzYNiaTE=;
        b=AY4uI4+12EaCOhQN/CJNpxrLwQzJS0I/jk3rR2YXcrV6HERBsTSba1fNLYXi7qUQv3
         D8j9Q0JOETZVCiZJ03N0yh2ouFMHmR4FobRrpl7CR/PzYUAuOOPuC2ZjNyBboxCEPVpY
         IM2kRblPpWn8SSBMfJn/TwZKbKlILgfFs7S09m6hGQIHZwD+G8v+yNwfAlvvwcP4OeOU
         S6R12dnhe8hHkQ8MSu4eGrNdjr6HrnuCzisS/kmxNxnCbV2EYu01dS3W9vSVPdiqsv+8
         AF1pb558X/zIsixcvAXkx8EAv+Yap7CBqHZ1FSwYcRtCiwar5FYxTHgKh48FqB/yvv7m
         qczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MGqucpVw2uIA8AVHNsuBgm4dwW4sgPsiMMejzYNiaTE=;
        b=oEk3QKHT139GY20T54kelmxTaKLihb+bn0wKIBLO8qHycih/dHH9zKWKkSG5oFQX+D
         9TJqvs1EgWDQUgW2pduVma9Fi+ZHxhH2erhis0J4MJ26Zu80nLde6D8du1wZoD3Js+P9
         pA8hrASBV4GSfz7YTmWC0Z9HuVzK/s9AllHjx/YG9vuNKyuQvx0/ICbV8vnplwJrGv8W
         83iNyKpM2qPzXOL1vHMMyMKg6BHL7gwDs11Zhpqy8ZjXtnZDLtKZNrJA3KT4zbujXUs1
         ymrIaQ86u6JcLzExhr8W0jVuEZDRYHt7ksBgwGSCxaY+ZhXJNOS3ouNIWnVYBOSSsdR3
         dQxw==
X-Gm-Message-State: ACgBeo2vUlMdNClK9rPYddv6FK94whnV8FVKAxCIrbX0LlFexBrU63Qs
        FjauvAhbXQ+Laf4YWbs+f0o=
X-Google-Smtp-Source: AA6agR5YMoh8UxxxM+GoSFz3SKxgjydUdYncMggAnzw3nGdxL5PjsMwTEl4GWTzkCUJ0TsRePqmiyQ==
X-Received: by 2002:a05:6512:1395:b0:48d:81b:4955 with SMTP id p21-20020a056512139500b0048d081b4955mr11847332lfa.307.1662131628328;
        Fri, 02 Sep 2022 08:13:48 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id i3-20020a2e0743000000b00261ccf566e3sm211434ljd.65.2022.09.02.08.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 08:13:47 -0700 (PDT)
Message-ID: <c1c8bbbe-4282-1dc4-db20-a21b55eecc14@gmail.com>
Date:   Fri, 2 Sep 2022 17:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <68dd96fb-69e7-d82f-75b3-610afe9ae0b8@hartkopp.net>
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <68dd96fb-69e7-d82f-75b3-610afe9ae0b8@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On 9/1/22 18:35, Oliver Hartkopp wrote:
> Hi Jacob,
> 
> On 01.09.22 11:38, Jacob Kroon wrote:
>> On 8/30/22 21:15, Oliver Hartkopp wrote:
> 
>>> I assume you have a transceiver, right? ;-)
>>>
>>
>> Yes,, all nodes are using a TJA1050 transceiver
>> (https://www.nxp.com/docs/en/data-sheet/TJA1050.pdf)
> 
> Good!
> 
>>> What is the other endpoint? The EG20T and another (automotive) ECU?
>>
>> Currently I have 4 nodes in the network, EG20T is in one end.
>>
> 
> Ok, that's a good base for testing.
> 
>>>>> Do you have another CAN node which can be attached to the EG20T 
>>>>> setup (e.g. some ECU or an USB CAN adapter)?
>>>>
>>>> Yes I do have a CAN analyser from Microchip. I guess I can record 
>>>> all traffic with the analyzer, and compare it to what I see with 
>>>> "candump can0" on the host. Or do you have some other suggestion ?
>>>
>>> Yes, please add the CAN analyzer from Microchip too!
>>>
>>> The problem with only two nodes is that you have to be very precise 
>>> with bitrate settings and sampling points so that the receiving node 
>>> needs to properly set the ACK to acknowlege the CAN frame.
>>>
>>> I had been working with a MSCAN system some time ago and that wasn't 
>>> able to talk to a commercial CAN tool until I added another node 
>>> (from another CAN tool provider).
>>>
>>> Maybe you can make the other node talk to the Microchip CAN analyzer 
>>> and let the EG20T receive that traffic first.
>>>
>>
>> I used "candump can0 -l" on the EG20T host to capture the traffic, and 
>> then connected an CAN USB analyzer to the network and used that to 
>> capture the traffic. One thing sticks out. This is the log from the 
>> CAN USB analyzer:
>>
>>> ...
>>> 505.7052;RX;0x464;3;0x01;0x01;0x00;;;;;;
>>> 505.7052;RX;0x464;3;0x00;0x00;0x00;;;;;;
>>> 505.7063;RX;0x65;64;;;;;;;;;
> 
> What should this be?
> 
> A length of 64 and no data ??
> 
> This is no valid CAN frame.
> 
>>> 505.7662;RX;0x440;3;0x32;0x20;0xFA;;;;;;
> (..)
> 
>>
>> Note the third message from the top. This is what "candump" on the 
>> host logs:
>>
>>> ...
>>> (1662022485.638794) can0 464#010100
>>> (1662022485.638940) can0 464#000000
>>> (1662022485.699405) can0 440#3220FA
> 
> The correct CAN frames are displayed correctly.
> 
>>> ...
>>
>> It fails to see the 3rd message from the previous log. What would that 
>> indicate ? The CAN analyzer sees the message, but the EG20T doesn't.
> 
> Don't know if this is an error on the CAN bus. You can also print error 
> messages of detected CAN bus problems with adding an error message filter.
> 
> See 'candump -h' :
> 
> candump -l any,0:0,#FFFFFFFF
>           (log error frames and also all data frames)
> 
> 

Thank you Oliver for all the good hints.

I've done some more logging, but there are no error frames being logged.

I can see that both pch_can and c_can_pci drivers call 
can_put_echo_skb() in their ndo_start_xmit functions, but neither checks 
the return value whether it succeeded or not. Shouldn't both these 
return NETDEV_TX_BUSY if there are no echo slots available ?

One reason I ask is because whenever I strace the application, it would 
seem the problem goes away, and I'm guessing strace:ing will slow down 
my application.

Regards
Jacob
