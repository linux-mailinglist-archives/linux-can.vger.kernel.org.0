Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856AB6D23EE
	for <lists+linux-can@lfdr.de>; Fri, 31 Mar 2023 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjCaP0w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Mar 2023 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCaP0v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Mar 2023 11:26:51 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DE51CBBB
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 08:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680276400; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lwYeGNeRjNaJ2f272Q5j+MrqIvHLQEdKvNyP4/4PFfVxmic1rekiFxsxGsXOz5c02d
    BofhLWgfSA8DZq0hMLWE6cv/fp/c9RyjRpRbzGN8NlP3PhcV6QwG5z742Zc/QjFQCSZo
    29vOAK06SSzyn3j6om73u5zdjv6ldPBpUODNPE6v56dx2WS9jirOkZouMF/9jM0Eefre
    /xoDfSnY2LMPgp+fyVtIZe+yoXJpCm9uxUdZ4CUODnbJv+4FKHu1C0hnF9YXgY1Ukq1d
    PWa6UAL/Tqh+nl1+was74eJnzzu00famBZvZepr0/S4TW4+LfNaoo4GUbHtABJkkDuFk
    aX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680276400;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6xqVUMCNbkmZUIx5Bfhyaz90659QaAmLq+zX3Vuu+2U=;
    b=GpFKUIztrFRfvHoXh49GXrNSInwdmQbqg3VOSHRdYKS5Fe5ElFVRySXG9enJSgDB4/
    JsugWcwLmR7wi7p5uY0rtB1uMkS2XkvLDrp/SGprfMEGs7KsPlMVsdv7kGLwvhRK7wA7
    Do2oYTYzHMdygzbXFONk8Sn1DITsN/oCtWA5l9khQve2Vf9F/OdoEfP6jz+/xSbArC7r
    8f7YAFpBejMLI9mT0d3X2bwdTfnaZigKGbLnRkqkLqz5FBOP5hDzr5RpTQvOTZ4YksD3
    L3h9TBayNl5MUBYzs8sBHCgxl7s74c7PY9m+NXsBZRen3xnpFHAKzf6RkP+jbfLrMNoZ
    yuFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680276400;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6xqVUMCNbkmZUIx5Bfhyaz90659QaAmLq+zX3Vuu+2U=;
    b=g8FHYeo1VFJTYL2BmA4sqm6E8JqRLD8F7ICXKJchyfyGDUtqRIWBoqc82FHvuraGk+
    qkxJquznDFSlQqFNODk4RVzN3M6qiU8cKIk8mAmw47FUJwRdzQIb4rzcwJLsoKCsqInN
    WCgcj56H6VfI4d3tXUmVkGdddWDNJ6i3tLn3slQsTRAoZdiudbJyDE6TvMx8cRs+mFtF
    NF+OZoOMpWiJX0SbmhVFcPUS+OuLU32Njb5l0aaET4IRsc0KaFCae9UhQQhDotvRTYrX
    YunbptWIldWxWNBSsfLqNHGihbMiUc/KDwjWw42F5+mhhizmxstoDJyoGqqb44SlE9jy
    BdDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2VFQejll
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 31 Mar 2023 17:26:40 +0200 (CEST)
Message-ID: <a3d6f5b6-c830-6d2b-5cfa-10fe3e567909@hartkopp.net>
Date:   Fri, 31 Mar 2023 17:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] can: isotp: fix race between isotp_sendsmg() and
 isotp_release()
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     linux-can@vger.kernel.org, Hillf Danton <hdanton@sina.com>
References: <20230331102114.15164-1-socketcan@hartkopp.net>
 <ZCbM0mTZFgfyWndH@dragonet>
 <bb365ad4-815f-4dac-6e40-83b7197b5033@hartkopp.net>
 <CACsK=jdYFQATbs_u-AQr8ota4he17xVY--t3jFAx5y5WW-qqxg@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CACsK=jdYFQATbs_u-AQr8ota4he17xVY--t3jFAx5y5WW-qqxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 31.03.23 15:37, Dae R. Jeong wrote:
> On Fri, Mar 31, 2023 at 9:23 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> Hi Dae,
>>
> (...)
>>
>> /* wait for complete transmission of current pdu */
>> while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) ==
>> 0 &&
>>          cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE);
> 
> I'm not sure, but your intention in this condition is probably
> while (wait_event_interruptible() != 0 || cmpxchg() != ISOTP_IDLE)?
> So, release() can get out of the loop only if
> wait_event_interruptible() returns 0 and cmpxchg() successes?

No it is the other way around.

When wait_event_interruptible() returns 0 the state has been properly 
set to ISOTP_IDLE (the good case).

And THEN we try to grab the tx.state to be ISOTP_SHUTDOWN.

The while() statement is left when either the tx.state is ISOTP_SHUTDOWN 
(after it was ISOTP_IDLE) 'OR' when a signal occurred which terminated 
wait_event_interruptible().

In the latter case we do not know the value from tx.state.

Therefore I set the tx.state to ISOTP_IDLE/ISOTP_SHUTDOWN in the V4 
patch after checking each wait_event_interruptible() return value:

https://lore.kernel.org/linux-can/20230331131935.21465-1-socketcan@hartkopp.net/

I think this is the best way to handle the signal interrupt case for 
wait_event_interruptible() ?!?

Best regards,
Oliver

> 
>> /* force state machines to be idle also when a signal occurred */
>> so->tx.state = ISOTP_SHUTDOWN;
>> so->rx.state = ISOTP_IDLE;
>>
>> When wait_event_interruptible() does not return '0' we can neither rely
>> on tx.state to be ISOTP_IDLE nor on anybody else taking care for that.
>>
>> So I would suggest to continue removing the socket.
>>
>>> Thank you for your hard work!
>>
>> Thanks for the review and the request to take an additional look at the
>> code!
>>
>> Best regards,
>> Oliver
> 
> Best regards,
> Dae R. Jeong
