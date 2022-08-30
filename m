Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C597D5A643C
	for <lists+linux-can@lfdr.de>; Tue, 30 Aug 2022 14:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiH3M7f (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Aug 2022 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiH3M7e (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Aug 2022 08:59:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15496F25
        for <linux-can@vger.kernel.org>; Tue, 30 Aug 2022 05:59:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w19so8301358ljj.7
        for <linux-can@vger.kernel.org>; Tue, 30 Aug 2022 05:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date;
        bh=tYCO+Xz2zIbe5ununx+qXjHZm1dC0XZjU50pvljFF28=;
        b=CR3pp9LQC3ojsbEmbfej8PcACGN8BlIbLN8sVUi7gSzzdPqbgc5NoyfVQHRS2cVbxq
         bnGTswvsoVXsoXrGz9Ue5xB/W78ZGs9AwQvLQ2JEDrJM/aEeStauK5rwBwQK3+/HxnOv
         /IU2LwtUZw5KEbnm637a6qe+q5+C7C+yBQb3j/aCkvEP8LWPidQ91WehKMMGSKynWlhE
         t6rIS2nxFI3ShOCnWsjahNXsL+Be1El8ffMpg1RFt5Np5eJx4DguSBs+zpdiVIErb0xz
         HWKrzSOtxLZiEJLu1LgqxsSaQ7gmimlSswYb4pVE88kO3uZOOxK7UWT+lRwfoYY9lohR
         Qq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tYCO+Xz2zIbe5ununx+qXjHZm1dC0XZjU50pvljFF28=;
        b=lWFx+lF/nN2gRl8iPKR6CVU96ACCEy11TGYwa0tHRVlkofcpJZCMT4fl9bNkcLhh3q
         kOeXdCvf/6i3+YrHt2YSlrQ7I5x05W0wuYrOktL6tiWiDVxGpv+odvmbh1+SKX8J1ZHC
         N2U2WxtqEYmqAsmHzdZaRuddwS56M6JlF1WmkSN1SbLu6Hx9e92SkK4zDpAZ/uAELjEq
         WrHpvdE2dUqjY2daHdqNmvVmG4Xml0fmW9ZmctIWyICV1qpxBKQ4gjj9U69Q24wvB4zs
         Y9cfVRkCweonMQR1zgB8bgsxTPlXOybwx0GuQyRmvQOnITbyboYdkUmYC/VhMvIGWpfk
         yj9Q==
X-Gm-Message-State: ACgBeo2estmiWUC5wygW7FdtGxne31sSbzIyaAjyAUwMAxc2WoR3L/5x
        0aD2vB+fNgaC1WoGTfHIbV8=
X-Google-Smtp-Source: AA6agR69HhY4nXTMr1WbDsCs3c441PEta9IqrQP4mAw+3vlwvnKs2ufH19eO/hwMaeXVLsbGqQwupg==
X-Received: by 2002:a2e:bf05:0:b0:265:e940:82cf with SMTP id c5-20020a2ebf05000000b00265e94082cfmr2193202ljr.43.1661864371309;
        Tue, 30 Aug 2022 05:59:31 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id bn38-20020a05651c17a600b0025e40eb9b3esm1778328ljb.125.2022.08.30.05.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 05:59:30 -0700 (PDT)
Message-ID: <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
Date:   Tue, 30 Aug 2022 14:59:29 +0200
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
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
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

On 8/29/22 15:53, Oliver Hartkopp wrote:
> Hi Jacob,
> 
> On 29.08.22 15:20, Jacob Kroon wrote:
>> Hi Wolfgang and Marc,
>>
>> On 8/29/22 11:14, Jacob Kroon wrote:
>>> On 8/26/22 13:24, Jacob Kroon wrote:
>>>> On 8/25/22 15:25, Jacob Kroon wrote:
>>>>> Hi,
>>>>>
>>>>> I am using a CM-ITC board 
>>>>> (https://www.compulab.com/products/computer-on-modules/cm-itc/) 
>>>>> with an application that uses the CAN interface. After a while of 
>>>>> successfully sending packets, sendto() starts returning ENOBUFS. I 
>>>>> wait a whole second and try to send, several retries, but I get 
>>>>> ENOBUFS every time. I'm using kernel 5.15.59, and I've tried both 
>>>>> the pch_can and c_can_pci driver, but both show the same error.
>>>>>
>>>>> In the console I see several of:
>>>>> can0: can_put_echo_skb: BUG! echo_skb 0 is occupied
>>>>>
>>>>> I've also tried to increase the txqueuelen to 1000, as suggested here
>>>>>
>>>>> https://stackoverflow.com/questions/40424433/write-no-buffer-space-available-socket-can-linux-can
>>>>>
>>>>> but I think that if I increase the queuelen the threads just block 
>>>>> forever in sendto() (sockets are opened in blocking mode)
>>>>>
>>>>> If I bring down the interface with
>>>>>
>>>>> ifconfig can0 down
>>>>> ifconfig can0 up
>>>>>
>>>>> the transmitting does get unblocked.
>>>>>
>>>>> Is there anything I can do to debug this further ? Any other ideas ?
>>>>>
>>>>
>>>> First I get the print:
>>>>
>>>> can_put_echo_skb: BUG! echo_skb 0 is occupied!
>>>>
>>>> then netif_stop_queue() is called from here:
>>>>
>>>> https://github.com/torvalds/linux/blob/master/drivers/net/can/c_can/c_can_main.c#L469
>>>>
>>>> and then there is no call to netif_start_queue(), so the bus hangs.
>>>>
>>>
>>> Switching back to the pch_can driver. I'm guessing here but it would 
>>> seem that the driver is not receiving the TX interrupt for 
>>> 'PCH_TX_OBJ_END' that would wake up the netif queue, since with the 
>>> changes below I can't reproduce the hang, although I'm still seeing a 
>>> lot of "echo_skb <x> is occupied!":
>>>
>>>> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
>>>> index 964c8a09226a..75ad2272d9b2 100644
>>>> --- a/drivers/net/can/pch_can.c
>>>> +++ b/drivers/net/can/pch_can.c
>>>> @@ -719,8 +720,7 @@ static void pch_can_tx_complete(struct 
>>>> net_device *ndev, u32 int_stat)
>>>>                           PCH_IF_MCONT_DLC);
>>>>         stats->tx_bytes += dlc;
>>>>         stats->tx_packets++;
>>>> -       if (int_stat == PCH_TX_OBJ_END)
>>>> -               netif_wake_queue(ndev);
>>>> +       netif_wake_queue(ndev);
>>>>  }
>>>
>>
>> Is there a recommended driver for the Intel EG20T PCH CAN controller ? 
>> pch_can or c_can_pci ?
> 
> I'm very happy that you show up with this question!
> 
> AFAIK the PCH_CAN driver was contributed by some OKI developers on 
> behalf of Intel to support their EG20T platform. This driver has not 
> been worked on for years now.
> 
> Later the C_CAN driver got its PCI support which should have made the 
> PCH_CAN driver obsolete as they are both using the C_CAN IP core.
> 
> So my suggestion would be to work with the well maintained c_can_pci and 
> mark the pch_can obsolete in the Linux kernel.
> 

Ok.

> IIRC Marc is very experienced with the C_CAN driver but he is still on 
> vacation this week.
> 
> Regarding your problem:
> "BUG! echo_skb 0 is occupied" should never show up but I wonder if you 
> probably have another CAN specific problem with your setup.
> 
> Did you set up a CAN network with at least two CAN nodes, identical 
> bitrate settings and 2x120 Ohms (== 60 Ohms) termination between CAN_L 
> and CAN_H?
> 

I have double checked that both endpoints of the network are terminated 
with 120Ohm resistors, and when I check CAN_H/CAN_L in an oscilloscope 
they look ok, and within the spec. voltage levels.

> Do you have another CAN node which can be attached to the EG20T setup 
> (e.g. some ECU or an USB CAN adapter)?

Yes I do have a CAN analyser from Microchip. I guess I can record all 
traffic with the analyzer, and compare it to what I see with "candump 
can0" on the host. Or do you have some other suggestion ?

Thanks for responding,
Jacob
