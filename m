Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A706C9416
	for <lists+linux-can@lfdr.de>; Sun, 26 Mar 2023 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCZMCr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Mar 2023 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZMCq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Mar 2023 08:02:46 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FA040F0
        for <linux-can@vger.kernel.org>; Sun, 26 Mar 2023 05:02:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679832163; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qDJLBheXkk/nNaV9yL4ke2LvU4wIZEIpZRIMLYCr7aIjJkmupm4fLwD5wA1I5pcKm3
    TRfcQhU4oTfLMYPqRWiCDoecxZ+WpvW+TOjiZpn0Frlfdo1vn3or/fssncm+tJu8gsiS
    OyZSkzKOELg9pCjCNZTkNJVe4rQpNeOtZ/iiScDEbroiFEFp6e7UO0kX2e+Jfb2lDxRh
    wIu+zDNRwaKHdmlEKP7Fk+jcqWHSC+laB1ALxDLIXR5sPwxWBm+FAruB3a47cM36JpOw
    XKd3yabfK6Dsi0NLpAMvYSfVtNSB/wjTOYkbmOeiJdN2Cwruv+SNEQFu/aalhkeqv1ef
    wE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679832163;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZVq2pUoGpQzfRmiLXGmqxquWs3xrdVZKppG7Ctl1UR4=;
    b=DoTtnh40iUPPg5grfyu0YxBoRevIg6pq6YUeVSB8ZPiwjfJM8p1mBRh7N6/7cdTHc7
    +8D3k3YZEya+DBAIL6eUBFS0XZxweXtSmIyFD+RioMV8dz1chW3olMyhI44eoQcYFIne
    Z72dUo8UcQ9m04JbuyAmj8fIgEhMBOE77XRik/wzJiL2xS6tGIcsU7g9Y1rwm3JjitfL
    mbLKS4HOrfdgLKOVPaG609ZrRl14uI4ym7IZSfeh3sIb4lvoRtwrpZEgCCoIA1jTxTLu
    ZIyDRUN8t0g0L2Fc4jDRdD70B0+TJBUUucma/2idr/P5lB5YwUhov8uNLWXZi7mWu+tM
    4s4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679832163;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZVq2pUoGpQzfRmiLXGmqxquWs3xrdVZKppG7Ctl1UR4=;
    b=pNSs2RhDRAljE/F25ThEbbWV0b9hcIXHygBrqTzH5/hgvdDEmiVvks0HlkSFYsFqlR
    uVKji/K2xqxOF0YFwpDhcJQ0lWNtA2CFJPdzVxNs0EvrN+vXXpuDyjCIeuhSYixH8HBt
    /TcLHptZM2HTT6UYAdYw4XeEcGN6bDVQXVu+SYJdKJDVSqCLoAB4CZWZhaZ26wDZ+E+8
    Lho6IbdimxbgJDOgEJn3R0PgF6u+HhhdvUB3TpbX18uWdo+WZ0JIMyVrLWLQzCMmy1a0
    ZgvfZwqANytgo9JI7UgBB5fHMvX0QnqmIeOPVfnFO9/Ym75MLs19teliOQWHZcCVKxul
    yPhg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2QC2hSG0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 26 Mar 2023 14:02:43 +0200 (CEST)
Message-ID: <38aabf68-e062-a3dc-c168-6a87d1febdb4@hartkopp.net>
Date:   Sun, 26 Mar 2023 14:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v2] can: isotp: add module parameter for maximum pdu
 size
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20230313172510.3851-1-socketcan@hartkopp.net>
 <20230320162406.5mkbvcmyx7nyqvjc@pengutronix.de>
 <c5451b95-5732-b3ed-38f5-1b09e74c0541@hartkopp.net>
 <20230322085633.zwxip56fyr7qqguu@pengutronix.de>
 <a91369b3-9615-4300-a617-e3edbb2c628c@hartkopp.net>
 <20230324172951.3zvcujiof7xnh3u7@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230324172951.3zvcujiof7xnh3u7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 24.03.23 18:29, Marc Kleine-Budde wrote:
> On 22.03.2023 18:59:04, Oliver Hartkopp wrote:
> .> > > I've been thinking about some sendfile() implementation too. But this again
>>>> would bloat the code and would not solve the rx side.
>>>
>>> I'm not talking about sendfile. Have a look at j1939's
>>> j1939_sk_send_loop();
>>>
>>> | https://elixir.bootlin.com/linux/v6.2/source/net/can/j1939/socket.c#L1114
>>>
>>
>> This does not work for isotp like this as you have to handle different block
>> sizes in the flow control message.
> 
> Let this be a task for future us. :)

Let's see if there would be really a use-case that would justify an 
additional complexity.

So far I don't see the need for that.

>>>>> what about: ARRAY_SIZE(so->rx.sbuf)
>>>>>
>>>>
>>>> Looks good. I was just unsure which macro to use ;-)
>>>
>>> You can also use sizeof(so->rx.sbuf).
>>>
>>> ARRAY_SIZE would cause a compile error if you convert so->rx.sbuf to a
>>> pointer to dynamically allocated mem, while sizeof() still compiles.
>>
>> so->rx.sbuf is always a static buffer.
> 
> Yes, in the current code. I was showing the difference between
> ARRAY_SIZE() and sizeof(). ARRAY_SIZE has a bit of type checking, while
> sizeof() doesn't - this becomes important once you change the code.
> 

ACK

>> Only so->rx.buf can point to either so->rx.sbuf or to a dynamically
>> allocated memory.
>>
>> But when sizeof() is always safe it would take this for the v3 patch.
> 
> Use ARRAY_SIZE().

Done. Sent a V3 patch a minute ago.

Many thanks,
Oliver

