Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6D75A4E9C
	for <lists+linux-can@lfdr.de>; Mon, 29 Aug 2022 15:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiH2NxP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Aug 2022 09:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiH2NxO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Aug 2022 09:53:14 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B5296FCE
        for <linux-can@vger.kernel.org>; Mon, 29 Aug 2022 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1661781188;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Ai6ZT6JKGY2LVNTVxvryf5e3dCs8YovnXox8/McnKJI=;
    b=jkU5rmwINZ81viWtskC++ImDi7kmG/vv/vz55nQmthFQiGWBj5c3IiyqbEO0LQBX6e
    uvwTMHOcbnyhrCjW2FTN4ACwnlFUPjD1zWMFiH9owFofguvGR5bfgCQ0HMp3Jy5jAXvh
    47A57NsY/wB2oql8MRImdttSdFlkgdf3ASlGhGh5YA9CD8Nho0NVFTBKkGWeNrnjtu5t
    OgJSvM7tFwQF5le6LwjPSAfEw5lKNO0rhGnqUNSoPEwhciwTOe5mUhdYYq9AvPWjRFDU
    vgZmeaxWrAqXMmKBBuWktyIas0SHkzuYJuFe6GGR0jF9yLM3ERYqNp04T+JMMvJMXHa6
    uOeg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y7TDr7MOR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 Aug 2022 15:53:07 +0200 (CEST)
Message-ID: <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
Date:   Mon, 29 Aug 2022 15:53:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
Content-Language: en-US
To:     Jacob Kroon <jacob.kroon@gmail.com>, linux-can@vger.kernel.org,
        wg@grandegger.com, mkl@pengutronix.de
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Jacob,

On 29.08.22 15:20, Jacob Kroon wrote:
> Hi Wolfgang and Marc,
> 
> On 8/29/22 11:14, Jacob Kroon wrote:
>> On 8/26/22 13:24, Jacob Kroon wrote:
>>> On 8/25/22 15:25, Jacob Kroon wrote:
>>>> Hi,
>>>>
>>>> I am using a CM-ITC board 
>>>> (https://www.compulab.com/products/computer-on-modules/cm-itc/) with 
>>>> an application that uses the CAN interface. After a while of 
>>>> successfully sending packets, sendto() starts returning ENOBUFS. I 
>>>> wait a whole second and try to send, several retries, but I get 
>>>> ENOBUFS every time. I'm using kernel 5.15.59, and I've tried both 
>>>> the pch_can and c_can_pci driver, but both show the same error.
>>>>
>>>> In the console I see several of:
>>>> can0: can_put_echo_skb: BUG! echo_skb 0 is occupied
>>>>
>>>> I've also tried to increase the txqueuelen to 1000, as suggested here
>>>>
>>>> https://stackoverflow.com/questions/40424433/write-no-buffer-space-available-socket-can-linux-can 
>>>>
>>>>
>>>> but I think that if I increase the queuelen the threads just block 
>>>> forever in sendto() (sockets are opened in blocking mode)
>>>>
>>>> If I bring down the interface with
>>>>
>>>> ifconfig can0 down
>>>> ifconfig can0 up
>>>>
>>>> the transmitting does get unblocked.
>>>>
>>>> Is there anything I can do to debug this further ? Any other ideas ?
>>>>
>>>
>>> First I get the print:
>>>
>>> can_put_echo_skb: BUG! echo_skb 0 is occupied!
>>>
>>> then netif_stop_queue() is called from here:
>>>
>>> https://github.com/torvalds/linux/blob/master/drivers/net/can/c_can/c_can_main.c#L469 
>>>
>>>
>>> and then there is no call to netif_start_queue(), so the bus hangs.
>>>
>>
>> Switching back to the pch_can driver. I'm guessing here but it would 
>> seem that the driver is not receiving the TX interrupt for 
>> 'PCH_TX_OBJ_END' that would wake up the netif queue, since with the 
>> changes below I can't reproduce the hang, although I'm still seeing a 
>> lot of "echo_skb <x> is occupied!":
>>
>>> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
>>> index 964c8a09226a..75ad2272d9b2 100644
>>> --- a/drivers/net/can/pch_can.c
>>> +++ b/drivers/net/can/pch_can.c
>>> @@ -719,8 +720,7 @@ static void pch_can_tx_complete(struct net_device 
>>> *ndev, u32 int_stat)
>>>                           PCH_IF_MCONT_DLC);
>>>         stats->tx_bytes += dlc;
>>>         stats->tx_packets++;
>>> -       if (int_stat == PCH_TX_OBJ_END)
>>> -               netif_wake_queue(ndev);
>>> +       netif_wake_queue(ndev);
>>>  }
>>
> 
> Is there a recommended driver for the Intel EG20T PCH CAN controller ? 
> pch_can or c_can_pci ?

I'm very happy that you show up with this question!

AFAIK the PCH_CAN driver was contributed by some OKI developers on 
behalf of Intel to support their EG20T platform. This driver has not 
been worked on for years now.

Later the C_CAN driver got its PCI support which should have made the 
PCH_CAN driver obsolete as they are both using the C_CAN IP core.

So my suggestion would be to work with the well maintained c_can_pci and 
mark the pch_can obsolete in the Linux kernel.

IIRC Marc is very experienced with the C_CAN driver but he is still on 
vacation this week.

Regarding your problem:
"BUG! echo_skb 0 is occupied" should never show up but I wonder if you 
probably have another CAN specific problem with your setup.

Did you set up a CAN network with at least two CAN nodes, identical 
bitrate settings and 2x120 Ohms (== 60 Ohms) termination between CAN_L 
and CAN_H?

Do you have another CAN node which can be attached to the EG20T setup 
(e.g. some ECU or an USB CAN adapter)?

Best regards,
Oliver
