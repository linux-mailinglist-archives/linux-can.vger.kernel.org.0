Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2625A934F
	for <lists+linux-can@lfdr.de>; Thu,  1 Sep 2022 11:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIAJih (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Sep 2022 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiIAJig (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Sep 2022 05:38:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7254D1321D1
        for <linux-can@vger.kernel.org>; Thu,  1 Sep 2022 02:38:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j14so13229843lfu.4
        for <linux-can@vger.kernel.org>; Thu, 01 Sep 2022 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MDaRz0Ln6ZQmXGDRx23i30xwzAByHNxOScFkyA14Rf4=;
        b=bALLrTrqRnvWdld/60ZBbJqIlkrSHtU5910CziMBSz0+R9srrj3lpyXfMCQVxmtUlr
         S4vRiWCFKHKXn4fELOzUKqsVdE15pcQzDzizF+BJsPF3PovZED87PyZQCMIjogIb6DF9
         E1MiOq1ZOnFfhh0cHF1A0IjQJfsmXfPmvmNS1w1ZBQTanvSAVdNFjsRx+FunmC+Ump2/
         L1Xl32emK8PUj1xXeQ5vIi5a6bjF3GTeDzRuitRbodnuamHnKCqidySSY3Z2tM/GbMgq
         dtZY/LUb+SCRfmxqwZh4w4Vdj+ZMFHgob9apd6ZtxtiJp5d2tAMVBfL0OZE+0iq6H6Qp
         bu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MDaRz0Ln6ZQmXGDRx23i30xwzAByHNxOScFkyA14Rf4=;
        b=efD3hio4JGHrhqknczBLe6EitKx9v8Lhhutfif/XdnaWEutiBHyZJeZsW1bkOZzIGg
         pnA7Vh29zYlJX7CSe/TJl2SM1U+NfmP7TRUUGOlzL9kmbOx+2zscr4l26Gdjp5frFcAy
         aChd6GahegxboO9GfIriaX4ZRa5c+/YaToB7PfVxxqyNA3wxkNXtYnXeQpQCWbuiCs2i
         C3LE/0EW8Wd6ENGlIWkt97zDH0gyw8lM2QxTkOx3qYUVgeZj8dJsn6m1SnaYKtgBpODl
         KASGejBlii1zvCH+VkvroKsFNOGYvyxdcg3xn3cPPMicWTLGZdEpjbiPIuZUOAympBi8
         gcqQ==
X-Gm-Message-State: ACgBeo2m4ILUZXY/j98Ai32e8zr3S0/Z820jg8horyPoMfzlMaN27sPp
        mBfitHGm923zGcragcTLldI=
X-Google-Smtp-Source: AA6agR5E4QZmzKwFuU0C5EtprRLhJMv3J+JzC+FD8M7bReX/ed/diBG5H6U6zVZBusdEMBrc45mq9A==
X-Received: by 2002:a05:6512:2117:b0:494:65f0:28c5 with SMTP id q23-20020a056512211700b0049465f028c5mr7020985lfr.538.1662025113623;
        Thu, 01 Sep 2022 02:38:33 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id bk37-20020a05651c23a500b00261ca006158sm1178086ljb.54.2022.09.01.02.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 02:38:32 -0700 (PDT)
Message-ID: <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
Date:   Thu, 1 Sep 2022 11:38:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Language: en-US
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/30/22 21:15, Oliver Hartkopp wrote:
> Hi Jacob,
> 
> On 30.08.22 14:59, Jacob Kroon wrote:
> 
>> On 8/29/22 15:53, Oliver Hartkopp wrote:
> 
>>> Regarding your problem:
>>> "BUG! echo_skb 0 is occupied" should never show up but I wonder if 
>>> you probably have another CAN specific problem with your setup.
>>>
>>> Did you set up a CAN network with at least two CAN nodes, identical 
>>> bitrate settings and 2x120 Ohms (== 60 Ohms) termination between 
>>> CAN_L and CAN_H?
>>>
>>
>> I have double checked that both endpoints of the network are 
>> terminated with 120Ohm resistors, and when I check CAN_H/CAN_L in an 
>> oscilloscope they look ok, and within the spec. voltage levels.
> 
> https://www.compulab.com/wp-content/uploads/2011/08/CM-iTC-Reference-Guide.pdf
> 
> "it is necessary to add transceiver
> hardware (see the SB-iTC reference schematic)"
> 
> I assume you have a transceiver, right? ;-)
> 

Yes,, all nodes are using a TJA1050 transceiver
(https://www.nxp.com/docs/en/data-sheet/TJA1050.pdf)

> What is the other endpoint? The EG20T and another (automotive) ECU?

Currently I have 4 nodes in the network, EG20T is in one end.

> 
>>> Do you have another CAN node which can be attached to the EG20T setup 
>>> (e.g. some ECU or an USB CAN adapter)?
>>
>> Yes I do have a CAN analyser from Microchip. I guess I can record all 
>> traffic with the analyzer, and compare it to what I see with "candump 
>> can0" on the host. Or do you have some other suggestion ?
> 
> Yes, please add the CAN analyzer from Microchip too!
> 
> The problem with only two nodes is that you have to be very precise with 
> bitrate settings and sampling points so that the receiving node needs to 
> properly set the ACK to acknowlege the CAN frame.
> 
> I had been working with a MSCAN system some time ago and that wasn't 
> able to talk to a commercial CAN tool until I added another node (from 
> another CAN tool provider).
> 
> Maybe you can make the other node talk to the Microchip CAN analyzer and 
> let the EG20T receive that traffic first.
> 

I used "candump can0 -l" on the EG20T host to capture the traffic, and 
then connected an CAN USB analyzer to the network and used that to 
capture the traffic. One thing sticks out. This is the log from the CAN 
USB analyzer:

> ...
> 505.7052;RX;0x464;3;0x01;0x01;0x00;;;;;;
> 505.7052;RX;0x464;3;0x00;0x00;0x00;;;;;;
> 505.7063;RX;0x65;64;;;;;;;;;
> 505.7662;RX;0x440;3;0x32;0x20;0xFA;;;;;;
> 505.7912;RX;0x44C;3;0x35;0x20;0xFA;;;;;;
> 505.9632;RX;0x464;3;0x00;0x00;0x00;;;;;;
> 505.9632;RX;0x464;3;0x01;0x01;0x00;;;;;;
> 505.9752;RX;0x468;3;0x51;0x20;0xFA;;;;;;
> 506.0362;RX;0x440;3;0x32;0x20;0xFA;;;;;;
> 506.0622;RX;0x44C;3;0x35;0x20;0xFA;;;;;;
> 506.2112;RX;0x464;3;0x00;0x00;0x00;;;;;;
> 506.2112;RX;0x464;3;0x00;0x00;0x00;;;;;;
> 506.2462;RX;0x468;3;0x51;0x20;0xFA;;;;;;
> 506.3072;RX;0x440;3;0x32;0x20;0xFA;;;;;;
> 506.3322;RX;0x44C;3;0x35;0x20;0xFA;;;;;;
> 506.4572;RX;0x464;3;0x00;0x00;0x00;;;;;;
> 506.4580;RX;0x464;3;0x00;0x00;0x00;;;;;;
> 506.5162;RX;0x468;3;0x51;0x20;0xFA;;;;;;
> 522.7203;RX;0x1E;1;0xFF;;;;;;;;
> ...

Note the third message from the top. This is what "candump" on the host 
logs:

> ...
> (1662022485.638794) can0 464#010100
> (1662022485.638940) can0 464#000000
> (1662022485.699405) can0 440#3220FA
> (1662022485.725166) can0 44C#3520FA
> (1662022485.896858) can0 464#000000
> (1662022485.897382) can0 464#010100
> (1662022485.909042) can0 468#5120FA
> (1662022485.970036) can0 440#3220FA
> (1662022485.995596) can0 44C#3520FA
> (1662022486.144685) can0 464#000000
> (1662022486.144768) can0 464#000000
> (1662022486.179595) can0 468#5120FA
> (1662022486.240561) can0 440#3220FA
> (1662022486.266274) can0 44C#3520FA
> (1662022486.391248) can0 464#000000
> (1662022486.391469) can0 464#000000
> (1662022486.450115) can0 468#5120FA
> (1662022502.662035) can0 01E#FF
> ...

It fails to see the 3rd message from the previous log. What would that 
indicate ? The CAN analyzer sees the message, but the EG20T doesn't.

Jacob
