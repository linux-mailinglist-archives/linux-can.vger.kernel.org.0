Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21935224BE
	for <lists+linux-can@lfdr.de>; Tue, 10 May 2022 21:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiEJT2p (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 May 2022 15:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243829AbiEJT2a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 May 2022 15:28:30 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21FC37BDD
        for <linux-can@vger.kernel.org>; Tue, 10 May 2022 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652210890;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7jBRppHDCwNxpXHEvHO0zb9bzCtnU7DthXPDhOFN4/4=;
    b=lpyvG9bXPgjV9UhwH1jMrBdPeJQKH5c5I1xF5/DU12138wDPMM1ZMEJCupC4+Ezz6J
    P8HDJT8uEF8n2qHqH/dhW4nDpyo4R+27aqhDeYVGphZc6Ad6gmh1VnCc8/ZeZxjo1dTx
    4pnwKe1hZO+7sgJ8XX1zKZ0A0OiG/osLG7JDC77SIui70eLS+UpH0tpV/O56RCfBfsmF
    PVcbH+GCJxBlBgg7c+/sgg1PawasVhFOMOSf+M/cOhyiFZ/KOKs6oSg1vYvylkBDt0u8
    O8nSj5A6/+43vh9mnGYmoYoaK3YCzzu2Ds40vT87U5qKRYoYZloixJsqYdsWfouHadF8
    CvUw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOug2krLFRKxw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b04::b82]
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y4AJSAvX2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 10 May 2022 21:28:10 +0200 (CEST)
Message-ID: <03ac64dd-2332-3eb1-bd81-0f29244d774b@hartkopp.net>
Date:   Tue, 10 May 2022 21:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Can someone point me in the right direction
Content-Language: en-US
To:     Marcel Akkermans <akkermans.m@brabofox.nl>
References: <d8571fc8-e020-841f-f20b-088c2ad440c3@brabofox.nl>
 <59e12840-befd-912f-0265-295c4fb51958@hartkopp.net>
 <11745085-d9a6-c658-ab8a-f1e3dc91b175@brabofox.nl>
Cc:     linux-can <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <11745085-d9a6-c658-ab8a-f1e3dc91b175@brabofox.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 10.05.22 20:29, Marcel Akkermans wrote:
> Hello Oliver,
> 
> Here are the output of the commands
> 
> rock@rockpi4b:~$  uname -a
> Linux rockpi4b 4.4.154-116-rockchip-g86a614bc15b3 #1 SMP Mon Jan 10 
 > 12:03:08 UTC 2022 aarch64 aarch64 aarch64 GNU/Linux

Well ... Linux 4.4.154 as expected.

You probably should give this a try:

https://github.com/camarel/rockpi4

to finally upgrade to Linux 5.10

Best,
Oliver

> rock@rockpi4b:~$ sudo ip link set can0 up type can bitrate 250000
> [sudo] password for rock:
> rock@rockpi4b:~$ ip -details link show
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode 
> DEFAULT group default qlen 1
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00 promiscuity 0 
> addrgenmode eui64 numtxqueues 1 numrxqueues 1
> 2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel 
> state DOWN mode DEFAULT group default qlen 1000
>      link/ether 8a:46:ca:10:55:d9 brd ff:ff:ff:ff:ff:ff promiscuity 0 
> addrgenmode none numtxqueues 1 numrxqueues 1
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc fq_codel state UNKNOWN 
> mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can state ERROR-ACTIVE restart-ms 0
>            bitrate 250000 sample-point 0.833
>            tq 333 prop-seg 4 phase-seg1 5 phase-seg2 2 sjw 1
>            mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
>            clock 6000000 numtxqueues 1 numrxqueues 1
> 4: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel 
> state UP mode DORMANT group default qlen 1000
>      link/ether 20:50:e7:d5:2a:2a brd ff:ff:ff:ff:ff:ff promiscuity 0 
> addrgenmode none numtxqueues 1 numrxqueues 1
> rock@rockpi4b:~$
> 
> Greeting Marcel
> 
> Op 10-May-22 om 6:52 PM schreef Oliver Hartkopp:
>> Hi Marcel,
>>
>> On 10.05.22 18:12, Marcel Akkermans wrote:
>>> I have a Raxda rockpi with waveshare 485 can Hat.
>>> there are strange issues with the can-bus.
>>> I need it to get it going (it's an HMI of a machine I am building)
>>>
>>> I have posted my test result at Raxda forum
>>>
>>> https://forum.radxa.com/t/rockpi-4b-canbus-fault/9784
>>
>> Can you please post the output of
>>
>>     ip -details link show
>>
>> and
>>
>>     uname -a
>>
>> ?
>>
>> I searched a bit on rockpi 4b and found these images:
>>
>> https://github.com/radxa/rock-pi-images-released/releases
>>
>> That's pretty old stuff and the mcp251x/SPI combo was not really 
>> reliable in those old kernels IIRC ...
>>
>>> all hardware runs fine on raspberry 3b
>>
>> Where you likely used a more recent kernel too ;-)
>>
>> Best regards,
>> Oliver
> 
> 
