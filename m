Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0965E887E
	for <lists+linux-can@lfdr.de>; Sat, 24 Sep 2022 07:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiIXFRe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Sep 2022 01:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiIXFRb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Sep 2022 01:17:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D664A110B1F
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 22:17:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s6so3190305lfo.7
        for <linux-can@vger.kernel.org>; Fri, 23 Sep 2022 22:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=Jo24naqPv1gIhIS8ANi6QFCLnsuBPUOlhJGDFPnx9ak=;
        b=EsSSO3855D3DCbRVEai3nNytEsWZ4HxxSBTETYOzgVhGJcvQr1YsVhkgmNIt63kDFL
         9rx7PsLvuymlS7lOj5wWNDy2x0I1Vq1uuPwNZGyHP8bOhkU3e9X8O6UcbkDISd86wjzl
         b9NLNNJBBPodxruGrBT1OCpIyI/IonG++echTWnPTistcbLlWhLo8SPV2KCfUU4rTH2d
         QLBwNLhyMA99RfmPAFCVC+ZjXn7LSiNeypKDozqJU043EM2veELW1G7LThVjKX0LAgOH
         vnHVb0krfFv0rPfT0Ny7GwdlaLo4PepSiY//Z/jAY8cSuQWdNylECw5PnLx0RTPzr69o
         4m5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Jo24naqPv1gIhIS8ANi6QFCLnsuBPUOlhJGDFPnx9ak=;
        b=R9gIVDxoFoMEhN3DB4LLJSHVHJlBtwvhK5lrNESr18zr3w0ehUqTlwc5XwYYplnAkw
         2GnXwZj3Um1+CjBaAkOwYL9+0mWL+17lLS1911ZfujiSMjSeiN05DwcH+/5t3KTyTsai
         cp4yDTtweHLhn1X9M5fo1PNjuHbaUvqR3a6QUq3XerUuNjO4pJel6ZVOYE9EgL5XAUbI
         5eHlDn3jDKOAlcHxtTydn6lNycAMPgZseYTNB6Yuv/pI4h0kbUCXBb79L5pcZyqJfXqZ
         0SpHffD/bgXtd5MZNwriAlo5fhpX2X8If18ldkRrj4sgrsMc0YHq+TIX0V3R0rgIH+O7
         tooQ==
X-Gm-Message-State: ACrzQf0RXfkFiicGMEDw4qWyVPbZj2/NbTJlJJ2tK2Fp3X+gIYyvwFMl
        bzAIvbbQrCFhz9oV/5Hn2xA=
X-Google-Smtp-Source: AMsMyM5t99t1t6QUhrGRwE3Da/j9Cv3Vojz/cUIlEkn5TwcmzbxnWQTffzLTcRqVtcGzmx3pAOceFw==
X-Received: by 2002:a05:6512:a93:b0:49f:d52f:5d14 with SMTP id m19-20020a0565120a9300b0049fd52f5d14mr5072420lfu.359.1663996648010;
        Fri, 23 Sep 2022 22:17:28 -0700 (PDT)
Received: from [192.168.10.124] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id w4-20020ac254a4000000b0049ebc44994fsm1756508lfk.128.2022.09.23.22.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 22:17:27 -0700 (PDT)
Message-ID: <d9cf121c-de6c-b3e7-cb71-db505fc8c88f@gmail.com>
Date:   Sat, 24 Sep 2022 07:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
From:   Jacob Kroon <jacob.kroon@gmail.com>
To:     dariobin@libero.it, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <20220923113638.tjnbuvkzdq24c4as@pengutronix.de>
 <36690382.801104.1663955706569@mail1.libero.it>
 <a162f149-58ba-24eb-474f-294b9fe78e51@gmail.com>
 <8665ef57-17fb-dfd7-afa2-8e5bebceb617@gmail.com>
 <1885528784.804387.1663962304792@mail1.libero.it>
 <a843df30-f1f9-f2dc-2d3f-4302c928c34c@gmail.com>
Content-Language: en-US
In-Reply-To: <a843df30-f1f9-f2dc-2d3f-4302c928c34c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 9/23/22 22:27, Jacob Kroon wrote:
> Hi Dario,
> 
> On 9/23/22 21:45, dariobin@libero.it wrote:
>> Hi Jacob,
>>
>>> Il 23/09/2022 21:21 Jacob Kroon <jacob.kroon@gmail.com> ha scritto:
>>>
>>> On 9/23/22 21:03, Jacob Kroon wrote:
>>>> Hi Dario,
>>>>
>>>> On 9/23/22 19:55, dariobin@libero.it wrote:
>>>>> Hi Michael,
>>>>>
>>>>>> Il 23/09/2022 13:36 Marc Kleine-Budde <mkl@pengutronix.de> ha 
>>>>>> scritto:
>>>>>>
>>>>>> On 16.09.2022 06:14:58, Jacob Kroon wrote:
>>>>>>> What I do know is that if I revert commit:
>>>>>>>
>>>>>>> "can: c_can: cache frames to operate as a true FIFO"
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=387da6bc7a826cc6d532b1c0002b7c7513238d5f
>>>>>>>
>>>>>>> then everything looks good. I don't get any BUG messages, and the 
>>>>>>> host
>>>>>>> has been running overnight without problems, so it seems to have 
>>>>>>> fixed
>>>>>>> the network interface lockup as well.
>>>>>>
>>>>>> Jacob, after this mail, I'll send 2 patches. One tries to disable the
>>>>>> cache feature for C_CAN cores, the other shuts a potential race 
>>>>>> window.
>>>>>
>>>>> About the "can: c_can: don't cache TX messages for C_CAN cores" patch:
>>>>> Could it make sense to change the c_can_start_xmit in this way
>>>>>
>>>>> -       if (idx < c_can_get_tx_tail(tx_ring))
>>>>> -               cmd &= ~IF_COMM_TXRQST; /* Cache the message */
>>>>> +       if (idx < c_can_get_tx_tail(tx_ring)) {
>>>>> +               if (priv->type == BOSCH_D_CAN) {
>>>>> +                       cmd &= ~IF_COMM_TXRQST; /* Cache the 
>>>>> message */
>>>>> +               } else {
>>>>> +                       netif_stop_queue(priv->dev);
>>>>> +                       return NETDEV_TX_BUSY;
>>>>> +               }
>>>>> +       }
>>>>>
>>>>> without changing the c_can_get_tx_{free,busy} routines ?
>>>>>
>>>>
>>>> I can test, so you suggest only doing the above patch, or were there
>>>> other parts from Marc's patch you wanted in ?
>>>>
>>>
>>> Well I tried only the above, and the patch below
>>>
>>> diff --git a/drivers/net/can/c_can/c_can_main.c
>>> b/drivers/net/can/c_can/c_can_main.c
>>> index a7362af0babb..21d0a55ebbb3 100644
>>> --- a/drivers/net/can/c_can/c_can_main.c
>>> +++ b/drivers/net/can/c_can/c_can_main.c
>>> @@ -468,8 +468,14 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff
>>> *skb,
>>>        if (c_can_get_tx_free(tx_ring) == 0)
>>>            netif_stop_queue(dev);
>>>
>>> -    if (idx < c_can_get_tx_tail(tx_ring))
>>> -        cmd &= ~IF_COMM_TXRQST; /* Cache the message */
>>> +    if (idx < c_can_get_tx_tail(tx_ring)) {
>>> +        if (priv->type == BOSCH_D_CAN) {
>>> +            cmd &= ~IF_COMM_TXRQST; /* Cache the message */
>>> +        } else {
>>> +            netif_stop_queue(priv->dev);
>>> +            return NETDEV_TX_BUSY;
>>> +        }
>>> +    }
>>>
>>>        /* Store the message in the interface so we can call
>>>         * can_put_echo_skb(). We must do this before we enable
>>> @@ -761,7 +767,7 @@ static void c_can_do_tx(struct net_device *dev)
>>>
>>>        tail = c_can_get_tx_tail(tx_ring);
>>>
>>> -    if (tail == 0) {
>>> +    if (priv->type == BOSCH_D_CAN && tail == 0) {
>>>            u8 head = c_can_get_tx_head(tx_ring);
>>>
>>>            /* Start transmission for all cached messages */
>>>
>>>
>>> but they both seem to lockup the network.
>>>
>>
>> I didn't understand if you applied two patches separately or not.
>> This was the only patch I had thought of. Which was similar to Marc's
>> for the interrupt part but differed in the c_can_start_xmit part.
>>
>> --- a/drivers/net/can/c_can/c_can_main.c
>> +++ b/drivers/net/can/c_can/c_can_main.c
>> @@ -464,13 +464,19 @@ static netdev_tx_t c_can_start_xmit(struct 
>> sk_buff *skb,
>>                  return NETDEV_TX_BUSY;
>>          idx = c_can_get_tx_head(tx_ring);
>> +       if (idx < c_can_get_tx_tail(tx_ring)) {
>> +               if (priv->type == BOSCH_D_CAN) {
>> +                       cmd &= ~IF_COMM_TXRQST; /* Cache the message */
>> +               } else {
>> +                       netif_stop_queue(priv->dev);
>> +                       return NETDEV_TX_BUSY;
>> +               }
>> +       }
>> +
>>          tx_ring->head++;
>>          if (c_can_get_tx_free(tx_ring) == 0)
>>                  netif_stop_queue(dev);
>> -       if (idx < c_can_get_tx_tail(tx_ring))
>> -               cmd &= ~IF_COMM_TXRQST; /* Cache the message */
>> -
>>          /* Store the message in the interface so we can call
>>           * can_put_echo_skb(). We must do this before we enable
>>           * transmit as we might race against do_tx().
>> @@ -723,7 +729,6 @@ static void c_can_do_tx(struct net_device *dev)
>>          struct c_can_tx_ring *tx_ring = &priv->tx;
>>          struct net_device_stats *stats = &dev->stats;
>>          u32 idx, obj, pkts = 0, bytes = 0, pend;
>> -       u8 tail;
>>          if (priv->msg_obj_tx_last > 32)
>>                  pend = priv->read_reg32(priv, C_CAN_INTPND3_REG);
>> @@ -759,15 +764,20 @@ static void c_can_do_tx(struct net_device *dev)
>>          stats->tx_bytes += bytes;
>>          stats->tx_packets += pkts;
>> -       tail = c_can_get_tx_tail(tx_ring);
>> +       if (priv->type == BOSCH_D_CAN) {
>> +               u8 tail;
>> +
>> +               tail = c_can_get_tx_tail(tx_ring);
>> -       if (tail == 0) {
>> -               u8 head = c_can_get_tx_head(tx_ring);
>> +               if (tail == 0) {
>> +                       u8 head = c_can_get_tx_head(tx_ring);
>> -               /* Start transmission for all cached messages */
>> -               for (idx = tail; idx < head; idx++) {
>> -                       obj = idx + priv->msg_obj_tx_first;
>> -                       c_can_object_put(dev, IF_NAPI, obj, 
>> IF_COMM_TXRQST);
>> +                       /* Start transmission for all cached messages */
>> +                       for (idx = tail; idx < head; idx++) {
>> +                               obj = idx + priv->msg_obj_tx_first;
>> +                               c_can_object_put(dev, IF_NAPI, obj,
>> +                                                IF_COMM_TXRQST);
>> +                       }
>>                  }
>>          }
>>   }
>>
>> I changed it a little from the previous email because I noticed a 
>> problem.
>>
> 
> Okay, the patch above seems to be working better. I'm pretty sure
> 
> https://marc.info/?l=linux-can&m=166393304023574&w=2
> 
> is good, so I'll keep the machine running overnight with Darios patch 
> above instead.
> 

Machine is still running with CAN network traffic working, so both 
patches at

https://marc.info/?l=linux-can&m=166393304023574&w=2
https://marc.info/?l=linux-can&m=166396200108947&w=2

are working for me.

Jacob
