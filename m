Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2FD5221C8
	for <lists+linux-can@lfdr.de>; Tue, 10 May 2022 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbiEJQ4i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 May 2022 12:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347696AbiEJQ4h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 May 2022 12:56:37 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621727D027
        for <linux-can@vger.kernel.org>; Tue, 10 May 2022 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652201556;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=odw+NWgFDkTAtSrHFg5Bgq9bjyL9tYwsIMtSy+HnokI=;
    b=j/BzTa/t3AjckGPNJrAy/XcvXXbcFsH5Vi4a2KCHuDKgWUuP6VtGnuv120xUmw2Bgm
    HLJ/TDqu6H9PfbM1lQ3saqfE/GK+y6Fv2GMKROdnBrEPt6yH2DwqLQT/EvaPGCU3h/Xm
    4HXHk0JT4GkBVbT8fc7PjneuvE7lA358tImpPyYw8A5YPjpHOsx7Q3WYubzQH+EuZ0mu
    Zm8ltdjCo5DVQu/dUB31YGi/3LJKX1RWI47Zu0DepzbFBU+kDh3ifmJxJiNpkPjEZBNX
    grdvgdaI1gx1O4Y3GOqjxMkIiewWtw8zskiaZ0HepAbkwhR764/VvpBeVHsz3FjhOoWc
    hjiw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOug2krLFRKxw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b04::b82]
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y4AGqZvLp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 10 May 2022 18:52:35 +0200 (CEST)
Message-ID: <59e12840-befd-912f-0265-295c4fb51958@hartkopp.net>
Date:   Tue, 10 May 2022 18:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Can someone point me in the right direction
Content-Language: en-US
To:     Marcel Akkermans <akkermans.m@brabofox.nl>,
        linux-can@vger.kernel.org
References: <d8571fc8-e020-841f-f20b-088c2ad440c3@brabofox.nl>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <d8571fc8-e020-841f-f20b-088c2ad440c3@brabofox.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marcel,

On 10.05.22 18:12, Marcel Akkermans wrote:
> I have a Raxda rockpi with waveshare 485 can Hat.
> there are strange issues with the can-bus.
> I need it to get it going (it's an HMI of a machine I am building)
> 
> I have posted my test result at Raxda forum
> 
> https://forum.radxa.com/t/rockpi-4b-canbus-fault/9784

Can you please post the output of

	ip -details link show

and

	uname -a

?

I searched a bit on rockpi 4b and found these images:

https://github.com/radxa/rock-pi-images-released/releases

That's pretty old stuff and the mcp251x/SPI combo was not really 
reliable in those old kernels IIRC ...

> all hardware runs fine on raspberry 3b

Where you likely used a more recent kernel too ;-)

Best regards,
Oliver
