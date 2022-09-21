Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0230F5BF928
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiIUI1U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 04:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiIUI0n (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 04:26:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44D882859
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 01:26:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a3so7932528lfk.9
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3OCg6v3fksVNjxThvESNTBvzqCVgbKfg2tKe2p7UZM4=;
        b=Rphj5wNE2YUTgZWggys2dwL/RXo20ZCZmSt4zYCr7o9FDsFIro4yLkW9OvXO/FVeQA
         DjewJ5tey3JKaNDCFUG8Cdo8riv+pBVInzaRoQ3g3/1Dpc6IzN/gXkR40z2ToibnG2fn
         +CqILIJZvjDFY4ygZtJ1dsu5Y9G6tV0Bb9NzZpgzTijkbFd4Y09CbqTiY5a11wRxN2hQ
         v6EGwAqpRMZkZX/Lwwqmp7Wg4DdUVIH898pJRQ7TFGKj5fTRpDClpw0DTdpaT5E/bQrs
         +VhIqNZQsOk1H0OF2YxM6PhXPByXNxyPvwFTRC91Zfc6WmhI4pWlc4NQU8QOWZC46dir
         UP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3OCg6v3fksVNjxThvESNTBvzqCVgbKfg2tKe2p7UZM4=;
        b=NM9xwUfM4+eYttYStmlnWIM8lf7obqh1GUrqv1XqWCE/o+iVcHIy2LRo7/MX0CIQfz
         KGpTTTkkKfRULvbZUoCJGMDUDUvWPn7SPOqMIbfRQ5/9l61Igj5z4TW0ROE8helSDPmG
         D78XUh0qLKPXnfMcn4/XnsYGpNkO/2gUyhc0+nvkEe8Yz0ADPDbSJ6m2nJF5c5dZSIRB
         K4kVD2+OiJYG2k6YcigtVl6H96lbtcoohdQnpEjMkgQmlhY75R0vphzVqLsEy9oU0j5v
         yW1o11QO7iHCka3DN+QqVfIRKvB9nV+QQ9H0p+6GkjGrbyzQWqxswmkSFdU93mgopRef
         34rA==
X-Gm-Message-State: ACrzQf0mfyBp6pNxelyMcqPfzy9mHT7/oHuGd40IFf7fMro5ElQEjYiQ
        Ik31uf6gmdVTNbayX+FBgWM+ef6TBo09hw==
X-Google-Smtp-Source: AMsMyM4KRksdHiF46sVTW0XJ6G0odz1xUMlC/pgjoTV00kIYUc3tvffD4kEVq3Vt0SVQ8bBn2PSVFQ==
X-Received: by 2002:a05:6512:2242:b0:49d:7f0e:eb4b with SMTP id i2-20020a056512224200b0049d7f0eeb4bmr9212678lfu.128.1663748789925;
        Wed, 21 Sep 2022 01:26:29 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id c9-20020a056512324900b00492dba3c85asm329189lfr.220.2022.09.21.01.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:26:29 -0700 (PDT)
Message-ID: <38461fb2-0806-f187-da2c-33650950bee4@gmail.com>
Date:   Wed, 21 Sep 2022 10:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
To:     Marc Kleine-Budde <mkl@pengutronix.de>, dariobin@libero.it
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
References: <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
 <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
 <541998938.482927.1663745141832@mail1.libero.it>
 <20220921074741.admuodnlv4yexfwr@pengutronix.de>
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <20220921074741.admuodnlv4yexfwr@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc and Dario,

On 9/21/22 09:47, Marc Kleine-Budde wrote:
> On 21.09.2022 09:25:41, dariobin@libero.it wrote:
>>> On 9/16/22 06:14, Jacob Kroon wrote:
>>> ...> What I do know is that if I revert commit:
>>>>
>>>> "can: c_can: cache frames to operate as a true FIFO"
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=387da6bc7a826cc6d532b1c0002b7c7513238d5f
>>>>
>>>> then everything looks good. I don't get any BUG messages, and the host
>>>> has been running overnight without problems, so it seems to have fixed
>>>> the network interface lockup as well.
>>
>> Here's what I think:
>> If one or more messages are cached, the controller has to transmit more frames
>> in the unit of time when they can be transmitted (IF_COMM_TXRQST), different from
>> when the transmission occurs directly on request from the user space. In the case
>> of cached data transmission I therefore think that the controller is more heavily
>> loaded. Can this shift the balance ?
>>
>>>
>>> I ran the kernel *with* the commit above, and also with the following patch:
>>>
>>>> diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
>>>> index 52671d1ea17d..4375dc70e21f 100644
>>>> --- a/drivers/net/can/c_can/c_can_main.c
>>>> +++ b/drivers/net/can/c_can/c_can_main.c
>>>> @@ -1,3 +1,4 @@
>>>> +#define DEBUG
>>>>   /*
>>>>    * CAN bus driver for Bosch C_CAN controller
>>>>    *
>>>> @@ -469,8 +470,15 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
>>>>   	if (c_can_get_tx_free(tx_ring) == 0)
>>>>   		netif_stop_queue(dev);
>>>>   
>>>> -	if (idx < c_can_get_tx_tail(tx_ring))
>>>> +	netdev_dbg(dev, "JAKR:%d:%d:%d:%d\n", idx,
>>>> +	                                      c_can_get_tx_head(tx_ring),
>>>> +	                                      c_can_get_tx_tail(tx_ring),
>>>> +	                                      c_can_get_tx_free(tx_ring));
>>>> +
>>>> +	if (idx < c_can_get_tx_tail(tx_ring)) {
>>>>   		cmd &= ~IF_COMM_TXRQST; /* Cache the message */
>>>> +		netdev_dbg(dev, "JAKR:Caching messages\n");
>>>> +	}
>>>>   
>>>>   	/* Store the message in the interface so we can call
>>>>   	 * can_put_echo_skb(). We must do this before we enable
>>>
>>> and I've uploaded the entire log I could capture from /dev/kmsg, right
>>> up to the hang, here:
>>>
>>> https://pastebin.com/6hvAcPc9
>>>
>>> What looks odd to me right from the start is that sometimes when idx
>>> rolls over to 0, and *only* when it rolls over to 0, the CAN frame gets
>>> cached because "idx < c_can_get_tx_tail(tx_ring)".
>>
>> If the message were not stored but transmitted, the order of transmission
>> would not be respected.
>>
>>>
>>> Is it possible there is some difference between c_can and d_can in how
>>> the HW buffers are working, which breaks the driver on my particular HW
>>> setup ?
>>>
>>
>> I tested the patch on a beaglebone board without encountering any problems.
>> There is also a version of the driver I submitted to Xenomai running on a custom
>> board without problems. But surely the setup and context is different from yours.
>>
>> What compatible are you using in your device tree?
>> I used "ti,am3352-d_can".
> 
> I think Jacob's board has a c_can core, while the beagle bone uses a
> d_can. Maybe there's a subtle difference between these cores?
> 
> Dario, do you have access to a real c_can core to test?
> 
> As reverting 387da6bc7a82 ("can: c_can: cache frames to operate as a
> true FIFO") helps to fix Jacob's problem, a temporary solution might be
> to only cache frames on d_can cores.
> 

Yes, mine is c_can, my hardware is

https://www.compulab.com/products/computer-on-modules/cm-itc/

which has a Intel Platform Controller Hub (PCH) EG20T that includes the 
CAN bus. A quick Google list the datasheet here:

https://www.versalogic.com/wp-content/themes/vsl-new/assets/resources/support/pdf/Intel_PCH_EG20T_Datasheet.pdf

Regards,
Jacob
