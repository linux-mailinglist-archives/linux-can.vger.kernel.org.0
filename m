Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E496403963
	for <lists+linux-can@lfdr.de>; Wed,  8 Sep 2021 14:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhIHMCb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Sep 2021 08:02:31 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:9770 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348691AbhIHMCb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Sep 2021 08:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1631102480;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=TPlasHMZUrne5A3eLMnTycFmzUTplGb5A7CwVTPFbKc=;
    b=iwvOs6dQiOretH87By/Rlts/0PH8vDUeUWKIcZN6+SbDaeYOAiYhCHuIuTxoQR1g4A
    72JwrzksDZY1srXVzt/fuDb7XZM23Le2NbLSAx6rXyHaRmLYVgDv71MsKNrW7eJ1xdFK
    WwICz2fPcl9qkIp9HfNv3I50n/rzCOIYT+nrHV8WOMIel6JuUZUHfarf6EcHWeE9P52v
    LRoKDfd6WkDjWSlvYoWk5Qd/43MF2V+WodAuN8U9o9MdORKJpeYfT5gbazDFNN3iB11l
    9Hd0SEF2Bx/L++hKmXAbMbCcRartj5wXj3WlUnpdshcFOvBDyRuatitcnQEiqlDF6sI1
    jIkw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.33.0 AUTH)
    with ESMTPSA id i0a93fx88C1KL8p
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 8 Sep 2021 14:01:20 +0200 (CEST)
Subject: Re: Introducing packet problems to vcan interface
To:     Eric Curtin <ecurtin@redhat.com>, linux-can@vger.kernel.org
References: <CAOgh=Fz5Gs6+ouPpFs4TeQW7rL-nEU-rqsj4w99TtQw2Pikr4w@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <2a54c503-c44f-e885-45ca-2293823235e5@hartkopp.net>
Date:   Wed, 8 Sep 2021 14:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAOgh=Fz5Gs6+ouPpFs4TeQW7rL-nEU-rqsj4w99TtQw2Pikr4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Eric,


On 07.09.21 17:01, Eric Curtin wrote:

> I'm new to CAN in general, I was running the following commands
> to set up a CAN interface and send it some data to see how it
> handles undesirable scenarios.

Welcome to the CAN world ;-)

> sudo modprobe vcan
> sudo ip link add dev vcan0 type vcan
> sudo ip link set up vcan0
> sudo tc qdisc add dev vcan0 root netem loss 10%
> sudo tc qdisc add dev vcan0 root netem duplicate 10%
> sudo tc qdisc add dev vcan0 root netem corrupt 10%
> sudo tc qdisc add dev vcan0 root netem loss 10%
> 
> followed by:
> 
> ./j1939cat -i ../4M.bin vcan0:0x80 :0x90,0x12300
> 
> But the packet problems introduced by TC, seem to have no effect
> on the cat time. Does TC work with CAN, the timing to transmit the
> data is the same with TC introducing problems. Should I be
> expecting retransmissions etc. to occur?
> 

I needed to check the original documentation myself:

http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

The handling of local loopbacks (IFF_ECHO) can be done in af_can.c for 
some CAN interfaces that do not support IFF_ECHO on driver level.

This is the default setting for vcan interfaces due to performance reasons.

To change this default, the virtual CAN driver has to expose its 
IFF_ECHO capabilty. This is done by providing a module parameter:

# rmmod vcan
# modprobe vcan echo=1

The PDF says:

3.3. Qdiscs and virtual CAN interface

It is possible to use qdiscs with virtual CAN interface (vcan). This can 
be used, for example, to roughly simulate the transmission delay of the 
real CAN interfaces. One only needs to insert vcan module with echo 
parameter set to 1.

Maybe there are other interesting details for you too.

I checked your above tests with echo=1 and it worked for me.

Best regards,
Oliver

