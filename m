Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905AA522332
	for <lists+linux-can@lfdr.de>; Tue, 10 May 2022 19:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242543AbiEJR6w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 May 2022 13:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348453AbiEJR6v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 May 2022 13:58:51 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7891E326E
        for <linux-can@vger.kernel.org>; Tue, 10 May 2022 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652205289;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:To:From:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=4xXMfUfxcYhoS3xrNGpG9GYiHiHGIniLKOiO1lDKNeA=;
    b=cvERKFXDHsD6x40eWd0pvidt26C2QVRSWulD6QOL7H7k+uzLnMar3CAkjcA6inj3g7
    b21Povr43FTe3PYg3S5hPyl3vFzGWXFmKnkGNwMaYo1sYDAaWUwkavT9HCF8BFlY/CTc
    lajZpDWaeJt0SLoxIbTFzDDsxNgT5Q+UZdw7y9XEnzRcZQezv1U4j4DwODEr+Ap38RNT
    P0GMlvkzlAJgRnBZb5QXmuKYld3evJMDi0qn+ZHHiN9e1FT4m3tG+YJafQ0wMXFZugGG
    InLqyAEnttbsusE73bMDirQnI6wWC1amHp8clcye82VmKTgpjPbrnemtJNuqFSd4t2IA
    tugA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOug2krLFRKxw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b04::b82]
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y4AHsnvQW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 10 May 2022 19:54:49 +0200 (CEST)
Message-ID: <89069ce1-8404-fcd0-650b-9f7a60e5dbf4@hartkopp.net>
Date:   Tue, 10 May 2022 19:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Can someone point me in the right direction
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Marcel Akkermans <akkermans.m@brabofox.nl>,
        linux-can@vger.kernel.org
References: <d8571fc8-e020-841f-f20b-088c2ad440c3@brabofox.nl>
 <59e12840-befd-912f-0265-295c4fb51958@hartkopp.net>
In-Reply-To: <59e12840-befd-912f-0265-295c4fb51958@hartkopp.net>
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

No idea if this works for a RockPi 4 'B' too.

https://github.com/camarel/rockpi4

But when you would update to Debian 11 you would get a Linux 5.10 kernel ...

On 10.05.22 18:52, Oliver Hartkopp wrote:
> Hi Marcel,
> 
> On 10.05.22 18:12, Marcel Akkermans wrote:
>> I have a Raxda rockpi with waveshare 485 can Hat.
>> there are strange issues with the can-bus.
>> I need it to get it going (it's an HMI of a machine I am building)
>>
>> I have posted my test result at Raxda forum
>>
>> https://forum.radxa.com/t/rockpi-4b-canbus-fault/9784
> 
> Can you please post the output of
> 
>      ip -details link show
> 
> and
> 
>      uname -a
> 
> ?
> 
> I searched a bit on rockpi 4b and found these images:
> 
> https://github.com/radxa/rock-pi-images-released/releases
> 
> That's pretty old stuff and the mcp251x/SPI combo was not really 
> reliable in those old kernels IIRC ...
> 
>> all hardware runs fine on raspberry 3b
> 
> Where you likely used a more recent kernel too ;-)
> 
> Best regards,
> Oliver
