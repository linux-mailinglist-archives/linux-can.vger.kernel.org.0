Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 283217CEB6
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2019 22:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfGaUgf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 31 Jul 2019 16:36:35 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:35316 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfGaUge (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 31 Jul 2019 16:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1564605392;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:Cc:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=TbBBpZzTRS68q/B8BiUwW2bmmzRpwgmwTUVOcRSqJ/c=;
        b=kL/njHrqWKpdPVYwHjYCMNY4oBK67rRWqH4ffge1OX1lFXnlVYfssgQTWgFmysRyQc
        xXkqNDCqMHk401OUIj8Di38ZNZhHYZVbjhCHE7uDchX5I8kcrb2E36e4mBSH9x1fupio
        nm4ouW2k91Q8CygjvfjfBO1d7MHoFqm2segVRQP1vs53ADxTgkhhPPzDukNeERXZJ4A9
        +WydnFk18ZRCNXD7E99hjapV7OEaxFi9OKljrKpP+zez4QBraipW64lPamjHhEFpCwGz
        FLbIW8b5gLCVfd740U0mXjMtzgW7du7kBiYRixlUTwRap2M9qazMzc3A3Sf2u/FRVsN+
        QaXQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMb16TD7DezTSFqw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.76]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6VKaJ2zV
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 31 Jul 2019 22:36:19 +0200 (CEST)
Subject: Re: Disable Network Statistics - CAN
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Martin Sperl <kernel@martin.sperl.org>
References: <CANRGksgbzcwt+XYNbZNrRMy=MXrT4WjXXW814=xYUgiJG+9twA@mail.gmail.com>
 <e4b4d4ea-735c-fa26-3c19-369b1e19b9f7@hartkopp.net>
 <4a7e43fc-dce5-218c-6ebf-85e48ee42936@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Tom Prohaszka <tprohaszka@capp-tech.com>, linux-can@vger.kernel.org
Message-ID: <15161cba-0831-cda8-b773-88880e72a6ec@hartkopp.net>
Date:   Wed, 31 Jul 2019 22:36:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4a7e43fc-dce5-218c-6ebf-85e48ee42936@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

+ Martin

On 31/07/2019 16.16, Marc Kleine-Budde wrote:
> On 7/31/19 3:38 PM, Oliver Hartkopp wrote:
>> Hi all,
>>
>> On 31/07/2019 03.49, Tom Prohaszka wrote:
>>> We are using the MCP25xxfd driver.  A comment in the code indicated
>>> that during testing, the network statistics were disabled to achieve
>>> high utilization of the CAN bus.  Another comment indicated that when
>>> network statistics were re-enabled, a 60% decrease in throughput
>>> occurred.
> 
> Can you point me to these comments?
> 
>>> My question is, how can we disable the network statistics for CAN, and
>>> if not possible for CAN, globally.
>>
>> there seem to be tons of MCP25XXFD_DEBUGFS_STATS_*() macros.
> 
> I'm not sure that incrementing some counters will cause a performace
> degration of 60%.
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tree/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c?h=mcp25xxfd&id=9b2ffbb925a0c32ea064c0a91b6bacb33d5e877a#n131
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tree/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_debugfs.h?h=mcp25xxfd&id=9b2ffbb925a0c32ea064c0a91b6bacb33d5e877a
>>
>> We had to purge all the debug stuff when mainlining the CAN subsystem
>> and I wonder if this is really NEEDED.
>>
>> When the driver is in mainline Linux we can assume it to work - and not
>> to be debugged anymore.
>>
>> Additionally the CAN_DEBUG_DEVICES Kconfig option could have been used
>> to debug potential pitfalls.
>>
>> IMO the debugfs stuff should be removed completely.
> 
> Or at least make it a per driver option.

Looking at

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tree/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_priv.h?h=mcp25xxfd&id=9b2ffbb925a0c32ea064c0a91b6bacb33d5e877a#n134

the driver logs extensively almost everything what the CAN controller 
offers.

At least this debugging output should depend on

CAN_DEBUG_DEVICES && CONFIG_DEBUG_FS

but I still wonder if you need u64 tx_brs_count or
u8 brs[MCP25XXFD_CAN_RX_DLC_HISTORY_SIZE]

These are statistics about CAN frame content. Why would we need this in 
normal operation or even in debugging cases?

Regards,
Oliver
