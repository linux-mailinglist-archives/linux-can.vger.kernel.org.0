Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670355A4DD7
	for <lists+linux-can@lfdr.de>; Mon, 29 Aug 2022 15:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiH2NYM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Aug 2022 09:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiH2NXv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Aug 2022 09:23:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3414291D11
        for <linux-can@vger.kernel.org>; Mon, 29 Aug 2022 06:20:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q7so11112106lfu.5
        for <linux-can@vger.kernel.org>; Mon, 29 Aug 2022 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=o3ESCE8NwkORqbW8M6OfAHip/x7eg1zgkCYttB6K+3c=;
        b=p/hLNY7+5EpTdQT4UHK3mex92d89h3S9aRI8jyecYpfpCzYaSPXTFvuA4qWdRVdqk3
         P3Jc6bvU6+eRKR5uYgmu3ey/Hvt1O2x9cVqlRsCZWbCfFIsMJeWJ8Ihv2osJllOI3wL+
         WoXauqBVFCYjn8cxHXxCsXYzHk0xG/iVlKWjBeeaZWOf73Wkgk0aBPL2IXNigbxngiOL
         se2WWYvnGxSVAfHcuOHlLm4tzC/zSL3y8y75l8j7R0jGYMJtxsDXtpLWrehJr4sRs0F5
         xO/wKsRLmFtxAuWSBk7Ton6rS5krC8LGKChAAvxJEmmV5pJhUT0gQWfn26K4h+TQDp0d
         ZjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=o3ESCE8NwkORqbW8M6OfAHip/x7eg1zgkCYttB6K+3c=;
        b=VAi4xlXZDrdItJyoU5bAsqDKMuAj4P1sgmSdhdKaY6PhZIOELvzuO+vAfd5btHdm2I
         s5cU7sMo+uEGq9CPt9WCC28m3sxUzOzzVHnyQWBcAIHKqcGfTzpiXHm9mNMsJDAtgNPG
         XW3EsZHSWPrhtY6noSLDdCxEoIymEMAWv+yjakxRbbZq1fEQ1Xr1N4SDxyUakoTyJu3s
         nf2VSb6jSC62v1ZKRcOoHwGigsjiD+qPj0t6NNVk5vzhydatK+TkKyiQ4sGLPglOqcYu
         tsK03Ksn/5HEYDr6dP69az9bHSnaqhKRM/aHkn3zDna1Q0h10x4SjS81MrYsm83JdIKn
         Z6CQ==
X-Gm-Message-State: ACgBeo0ggf37CWNQzA/1bVtLvn2WZI5AE49KBMY6+9MkCz8V/h3V/60y
        aeS8AihW2xWeVmgKMwUA51iGiEVvQ6IuoQ==
X-Google-Smtp-Source: AA6agR5DKpFGt2unbpK0KgUMnDeIu4UjHNq0rbdyzEyggZ6f82+sUQ/XKV9WoZ7xw4oQ0E1JNqY9kQ==
X-Received: by 2002:a05:6512:3f06:b0:492:f6b6:ad8b with SMTP id y6-20020a0565123f0600b00492f6b6ad8bmr6144973lfa.544.1661779211758;
        Mon, 29 Aug 2022 06:20:11 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id e14-20020a2e984e000000b0025e57b40009sm1351119ljj.89.2022.08.29.06.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 06:20:09 -0700 (PDT)
Message-ID: <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
Date:   Mon, 29 Aug 2022 15:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
To:     linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
In-Reply-To: <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
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

Hi Wolfgang and Marc,

On 8/29/22 11:14, Jacob Kroon wrote:
> On 8/26/22 13:24, Jacob Kroon wrote:
>> On 8/25/22 15:25, Jacob Kroon wrote:
>>> Hi,
>>>
>>> I am using a CM-ITC board 
>>> (https://www.compulab.com/products/computer-on-modules/cm-itc/) with 
>>> an application that uses the CAN interface. After a while of 
>>> successfully sending packets, sendto() starts returning ENOBUFS. I 
>>> wait a whole second and try to send, several retries, but I get 
>>> ENOBUFS every time. I'm using kernel 5.15.59, and I've tried both the 
>>> pch_can and c_can_pci driver, but both show the same error.
>>>
>>> In the console I see several of:
>>> can0: can_put_echo_skb: BUG! echo_skb 0 is occupied
>>>
>>> I've also tried to increase the txqueuelen to 1000, as suggested here
>>>
>>> https://stackoverflow.com/questions/40424433/write-no-buffer-space-available-socket-can-linux-can
>>>
>>> but I think that if I increase the queuelen the threads just block 
>>> forever in sendto() (sockets are opened in blocking mode)
>>>
>>> If I bring down the interface with
>>>
>>> ifconfig can0 down
>>> ifconfig can0 up
>>>
>>> the transmitting does get unblocked.
>>>
>>> Is there anything I can do to debug this further ? Any other ideas ?
>>>
>>
>> First I get the print:
>>
>> can_put_echo_skb: BUG! echo_skb 0 is occupied!
>>
>> then netif_stop_queue() is called from here:
>>
>> https://github.com/torvalds/linux/blob/master/drivers/net/can/c_can/c_can_main.c#L469
>>
>> and then there is no call to netif_start_queue(), so the bus hangs.
>>
> 
> Switching back to the pch_can driver. I'm guessing here but it would 
> seem that the driver is not receiving the TX interrupt for 
> 'PCH_TX_OBJ_END' that would wake up the netif queue, since with the 
> changes below I can't reproduce the hang, although I'm still seeing a 
> lot of "echo_skb <x> is occupied!":
> 
>> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
>> index 964c8a09226a..75ad2272d9b2 100644
>> --- a/drivers/net/can/pch_can.c
>> +++ b/drivers/net/can/pch_can.c
>> @@ -719,8 +720,7 @@ static void pch_can_tx_complete(struct net_device 
>> *ndev, u32 int_stat)
>>                           PCH_IF_MCONT_DLC);
>>         stats->tx_bytes += dlc;
>>         stats->tx_packets++;
>> -       if (int_stat == PCH_TX_OBJ_END)
>> -               netif_wake_queue(ndev);
>> +       netif_wake_queue(ndev);
>>  }
> 

Is there a recommended driver for the Intel EG20T PCH CAN controller ? 
pch_can or c_can_pci ?

Jacob
