Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3753FAE5B
	for <lists+linux-can@lfdr.de>; Sun, 29 Aug 2021 22:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhH2UPm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Aug 2021 16:15:42 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:16846 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbhH2UPm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Aug 2021 16:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1630268087;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=eaqP3jXrYrQlPw4xHTer1WMz0ZQAXfI5fgG1wfbfAWY=;
    b=LzJMEp6DevjbFGsqo3UOW3Hrt04kuHMzpKUy2jLurYBb4DYNfy22Ki2pYF1wy4uzI7
    neJU2pHpFRbeSf8ZT0ViGg92XrmUxaz+a8NqrsBPlvBoKy65xzXAAqDP5LstalvnJdry
    gHU6JrBopdEUtczpldyjxaZDqNupKRZTDjOAPsT2W+Nxzwhl6ZVJu2I1FXQL/UvWbIiq
    RBkCb5xBQK7x6z6s9HHcmFSRFxvpQlxlyyKIxO9hTccge0l+TCmOu2UpSm1FJYE8ZhPk
    cooU6dKMQUW1pUsS5YVF8G95mQuPzGSjBP622LSQaecXbY8CIFOwTKiwT4DK0Ajwu7wv
    DzWw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR8J8xryV0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.31]
    by smtp.strato.de (RZmta 47.31.0 DYNA|AUTH)
    with ESMTPSA id Q09fd7x7TKEkyEw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 29 Aug 2021 22:14:46 +0200 (CEST)
Subject: Re: AW: AW: [PATCH] can: isotp: omit unintended hrtimer restart on
 socket release
To:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <20210618173713.2296-1-socketcan@hartkopp.net>
 <DB8P190MB06343614CAD6B48C3EA0EF00D9C99@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <abc23fd0-9bb1-1cc7-fc67-0a3298673b86@hartkopp.net>
 <DB8P190MB0634E1A09E060C9A5A539073D9CA9@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <fa1cac52-73aa-b092-0137-2b1ed734f0ee@hartkopp.net>
Date:   Sun, 29 Aug 2021 22:14:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <DB8P190MB0634E1A09E060C9A5A539073D9CA9@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 29.08.21 20:28, Sven Schuchmann wrote:
> Hello Oliver,
>   
>>> But I found that this patch decreases the performance of ISO-TP Stack.
>>
>> AFAICS the performance (aka throughput) of the ISO-TP stack is not
>> touched but the grace period when closing an ISO-TP socket is increased.
>>
>>> I have created two testscripts where one plays the server and the
>>> other one is running a test and measuring the time how long
>>> it takes to transfer an ISO-TP Frame with 1000 Bytes.
>>>
>>> Without this patch it takes about 35ms to transfer the frame,
>>> with this patch it takes about 145ms over vcan0.
>>>
>>> Anyone an idea on this?
>>
>> Yes. We now syncronize the removal of data structures to prevent a
>> use-after-free issue at socket close time.
>>
>> The synchronize_rcu() call does this job at specific times which leads
>> to this extended time the close() syscall needs to perform.
> 
> understood
> 
>>
>>> bring up a vcan0 interface with:
>>> sudo modprobe vcan
>>> sudo ip link add dev vcan0 type vcan
>>> sudo ifconfig vcan0 up
>>>
>>> here are the scripts:
>>> --- isotp_server.sh ---
>>> #!/bin/bash
>>> iface=vcan0
>>> echo "Wait for Messages on $iface"
>>> while true; do
>>>       exec 3< <(isotprecv -s 77E -d 714 -b F -p AA:AA $iface)
>>>       rxpid=$!
>>>       wait $rxpid
>>>       output=$(cat <&3)
>>>       echo "7F 01 11" | isotpsend -s 77E -d 714 -p AA:AA -L 16:8:0 $iface
>>> done
>>
>> IMO the issue arises with the use of isotpsend and isotprecv.
>> These tools are intended to get a hands-on impression how the isotp
>> stack works.
>>
>> This kind of use in a script leads to the creation and (now delayed)
>> *removal* of isotp sockets for *each* single PDU transfer.
> 
> Maybe I am wrong but I see something different.
> e.g. without this patch:
>   (000.000240)  canfd0  714   [8]  2B 01 01 01 01 01 01 01
>   (000.000261)  canfd0  77E   [8]  30 0F 00 AA AA AA AA AA
>   (000.000496)  canfd0  714   [8]  2C 01 01 01 01 01 01 01
> 
> and with this patch:
>   (000.000414)  canfd0  714   [8]  2B 01 01 01 01 01 01 01
>   (000.000262)  canfd0  77E   [8]  30 0F 00 AA AA AA AA AA
>   (000.001536)  canfd0  714   [8]  2C 01 01 01 01 01 01 01
> 

I'm running a 5.14.0-rc7-00011-g6e764bcd1cf7 kernel here and see this:

  (000.000001)  vcan0  714   [8]  2B 01 01 01 01 01 01 01
  (000.000015)  vcan0  77E   [8]  30 0F 00 AA AA AA AA AA
  (000.000005)  vcan0  714   [8]  2C 01 01 01 01 01 01 01

Test iso-tp with 1000 byte frames on vcan0 (data:01)
     1 / curr:   40 / min:   40 / max:   40 / avg:   40.0
     2 / curr:   30 / min:   30 / max:   40 / avg:   35.0
     3 / curr:   35 / min:   30 / max:   40 / avg:   35.0
     4 / curr:   52 / min:   30 / max:   52 / avg:   39.2
     5 / curr:   40 / min:   30 / max:   52 / avg:   39.4
(..)

when running your scripts from the initial post.

Is you canfd0 interface a real hardware?

Best regards,
Oliver

> So within one PDU transfer the first Consecutive Frame after
> a Flow Control is taking about 10ms longer (the consecutive
> frames are sent by ISO-TP Stack here, Tested against a "real" ECU.)
> So if I transfer a lot of data within one PDU,
> the more Flow Controls I have and the more "delays" after each FC,
> and this increases the time for the whole PDU.)
> 
>>
>> The better approach would be to write a C program that creates ONE
>> socket and simply read() from that socket and write() to it.
>>
>> This should boost your performance even more.
>>
> Sure, I do have this. These two scripts are only lets say a "reproducer".
> 
> 
>> Is the performance a real requirement for your use-case or is this
>> decreased socket close rate a finding which does not really affect your
>> work?
> 
> We have a application here which flashes a ECU over CAN according to VW80126.
> So transferring the data as quick as possible to the ECU is a use-case.
> 
> Sven
> 
