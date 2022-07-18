Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF79577C3E
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiGRHQB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 03:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiGRHQA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 03:16:00 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01438175AF
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658128555;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QsTr2OAP2z+aNi8S1Zcwuj2HSJISwg45NQthJfP7Y08=;
    b=d7nRIQ1oFUFQWzjcUCEWeHoxDoW8owwghfw6Pn1dYE4hZn21pUImMrVUBVE96WDWXk
    hQDsX4TAA5L9n0av6j4vVzb6q3ZGp92ffcolgc1KxZpC0+InJjazJxbduA+VpawC39Mm
    h0ncSwpW0fnrdKfK6O5mZBAZ6Ld5us8eIdWC6JOrd3VjgxpEsEffmrg7YLlzqyI3iNQ4
    v82v+0Rc1TQph/6cwhKce8YPzFFWt1CDB8b8jz/qlrn/APtJZMbRN0HZJL041b4gixqd
    BRU0nTaAedqgHSahtgxyI6v6GrXwZ8ZLXEqKKJywWFsjQ7XG5T8305YMm0FvfYLF/hON
    uGFg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6I7FtC7s
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 18 Jul 2022 09:15:55 +0200 (CEST)
Message-ID: <aa5a6196-7e0a-25a8-c967-415857741bb2@hartkopp.net>
Date:   Mon, 18 Jul 2022 09:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/5] can: slcan: extend supported features (step 2)
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
References: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
 <507b5973-d673-4755-3b64-b41cb9a13b6f@hartkopp.net>
 <CABGWkvokcOW2G+CAH4Lna_pRa1ck-zKRpSifjGj-VX_cb9xP5A@mail.gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CABGWkvokcOW2G+CAH4Lna_pRa1ck-zKRpSifjGj-VX_cb9xP5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 18.07.22 08:59, Dario Binacchi wrote:
> Hello Oliver,
> 
> On Sun, Jul 17, 2022 at 4:13 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> Hello Dario,
>>
>> I have been maintaining the slcan.c driver for a long time and I'm still
>> in the MODULE_AUTHOR() macro.
>>
>> As you are very committed to the slcan driver and its extensions it
>> probably makes sense to take over the maintainer-ship and add yourself
>> to the MODULE_AUTHOR() macro.
>>
>> Analogue to the CAN FD driver from the CTU you could also provide a
>> similar patch for the MAINTAINER file:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=cfdb2f365cb9d
>>
> 
> I am happy and honored. I hope I am adequate for the task.

I think so ;-)

And with all your new enhancements and clean-ups that get away from the 
slow-moving slip.c I would be happy to get out of the line of fire when 
something breaks :-D

Many thanks!

Oliver

> Thanks and regards,
> 
> Dario
> 
>> Best regards,
>> Oliver
>>
>>
>> On 16.07.22 19:00, Dario Binacchi wrote:
>>> With this series I try to finish the task, started with the series [1],
>>> of completely removing the dependency of the slcan driver from the
>>> userspace slcand/slcan_attach applications.
>>>
>>> The series, however, still lacks a patch for sending the bitrate setting
>>> command to the adapter:
>>>
>>> slcan_attach -b <btr> <dev>
>>>
>>> Without at least this patch the task cannot be considered truly completed.
>>>
>>> The idea I got is that this can only happen through the ethtool API.
>>> Among the various operations made available by this interface I would
>>> have used the set_regs (but only the get_regs has been developed), or,
>>> the set_eeprom, even if the setting would not be stored in an eeprom.
>>> IMHO it would take a set_regs operation with a `struct ethtool_wregs'
>>> parameter similar to `struct ethtool_eeprom' without the magic field:
>>>
>>> struct ethtool_wregs {
>>>        __u32   cmd;
>>>        __u32   offset;
>>>        __u32   len;
>>>        __u8    data[0];
>>> };
>>>
>>> But I am not the expert and if there was an alternative solution already
>>> usable, it would be welcome.
>>>
>>> The series also contains patches that remove the legacy stuff (slcan_devs,
>>> SLCAN_MAGIC, ...) and do some module cleanup.
>>>
>>> The series has been created on top of the patches:
>>>
>>> can: slcan: convert comments to network style comments
>>> can: slcan: slcan_init() convert printk(LEVEL ...) to pr_level()
>>> can: slcan: fix whitespace issues
>>> can: slcan: convert comparison to NULL into !val
>>> can: slcan: clean up if/else
>>> can: slcan: use scnprintf() as a hardening measure
>>> can: slcan: do not report txerr and rxerr during bus-off
>>> can: slcan: do not sleep with a spin lock held
>>>
>>> applied to linux-next.
>>>
>>> [1] https://lore.kernel.org/all/20220628163137.413025-1-dario.binacchi@amarulasolutions.com/
>>>
>>>
>>> Dario Binacchi (5):
>>>     can: slcan: remove useless header inclusions
>>>     can: slcan: remove legacy infrastructure
>>>     can: slcan: change every `slc' occurrence in `slcan'
>>>     can: slcan: use the generic can_change_mtu()
>>>     can: slcan: send the listen-only command to the adapter
>>>
>>>    drivers/net/can/slcan/slcan-core.c | 465 +++++++++--------------------
>>>    1 file changed, 134 insertions(+), 331 deletions(-)
>>>
> 
> 
> 
