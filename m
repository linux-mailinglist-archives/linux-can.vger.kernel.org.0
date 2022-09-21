Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5F5BFBCA
	for <lists+linux-can@lfdr.de>; Wed, 21 Sep 2022 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIUJ4N (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Sep 2022 05:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIUJ4J (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Sep 2022 05:56:09 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3949395
        for <linux-can@vger.kernel.org>; Wed, 21 Sep 2022 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663754165;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4Uqo9SmVDBD8qvDuwEu3XBEc/XfNnFQSSauhzLG6szo=;
    b=DrMp62hj6dCyolwLLs2fnhjPIoUMTHhKOr8cqqF4OJ1ubo9tL8ZumTKfbtFyzpjVSW
    4ZbbWN1EAgxysrTbT/PYVJJ2b+thxNpy+XDUoAr5HepVU0nHBpIfCCl957jo+X8bjECu
    Zr8iFsgoZHBpqlXek+/qcy09MwxqSQCd/z4QJMPI7NRZEoB/QLNvdMPb+U/0d8cdKF7w
    g7c67HAyhskZxuwFrgwPmbK6iYwew7twouu0/UUZDWNQSCy2lpgo6Eh9Au5s9OBRbeHW
    nILVyzNEo93Rc2UyZT08ukR90JoHSxzOQR9vwCpJCTShY/LpyzJMcWvQkPMd6rVvpb4y
    cbAA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6hfz3Vg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::923]
    by smtp.strato.de (RZmta 48.1.1 AUTH)
    with ESMTPSA id 0e791ay8L9u53Q7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 21 Sep 2022 11:56:05 +0200 (CEST)
Message-ID: <fb1f38e6-c95c-5847-2ebf-16fd8bc2db94@hartkopp.net>
Date:   Wed, 21 Sep 2022 11:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, dariobin@libero.it
Cc:     Jacob Kroon <jacob.kroon@gmail.com>, linux-can@vger.kernel.org,
        wg@grandegger.com
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
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220921074741.admuodnlv4yexfwr@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 21.09.22 09:47, Marc Kleine-Budde wrote:
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

Btw. I uploaded the 'latest' C_CAN manuals on

https://github.com/linux-can/can-doc

... as it could only be found on archive.org :-/

Unfortunately I was not able to find any (latest?) D_CAN manual anymore, 
which was originally hosted at 
http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/can/d_can_users_manual_111.pdf

Archive.org did not crawl this PDF ;-(

If someone still has this D_CAN PDF please send a URL or the PDF itself 
to me, so that I can put it there too.

Thanks,
Oliver
