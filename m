Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4199C6D2017
	for <lists+linux-can@lfdr.de>; Fri, 31 Mar 2023 14:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjCaMXP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 31 Mar 2023 08:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjCaMXM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Mar 2023 08:23:12 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66C21F7B7
        for <linux-can@vger.kernel.org>; Fri, 31 Mar 2023 05:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680265298; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fQsxJ5SxqIoz5oHdMDYD1aWKvTsU+NIy9ZG68iHFVNaDYKrALVwW0PriaZe+ad07ei
    oMEYPartnPltJ85ANHy8+VItcOlOAD9wFk3ixhTiQBBpoG5l4dSQjO+pz6x5c9wJbqBA
    zbwUxfE/1Zl4dffnVoyKJwGtj3yz6GV/VDmNozZbBIorTRUO/6DVQHxWiBPtVQStUKdF
    NhpARz81hBQKNPif/J7s2VwUKOzbPiKa/HWGeqtExMU8p4nxj1XqVnOtF71tiS8/LJrR
    pjwMqx1UV6MCYB4cZmZEHK9ahq5axGCydH4NVZ4k9GQvNJuSX/ytS3Nk1B1jQ8/QbbVo
    YOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680265298;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BoOtSa5XkP6NK5YQb/4Cbvm/vF6mNnC8QGlUgK9r07k=;
    b=QwKAG71UJDUAIypbJcfXFFN2cXh+tvklW63q4zvOiHItL+bJgPf37lO2joy30Hb/sI
    BwUbALGPquWtY187W1+ep3kYn4zdwqH/3IkuWvCMXpg8L8DDM+yKN8Ov++5Yso9pxdgp
    6DNjv52JcUAFrx41OACsTWUi1Gb/NBhZcTopjzguGuT1HOfhD3IESEQbgQpWfdsXJ403
    ZBjlrMBp62QU9vLvc3cj4E5r1O1Gu5lbuSxrLe+ovpz5irUaWPtXSPdVSUDdup+aDohu
    F5v0XKjaCHFkKmLOuKeSQ1LIduPk0ftWW1RHTP/6y9HqbihP9W1eHA2DT3OuZ+HHMzNh
    Ue+A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680265298;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BoOtSa5XkP6NK5YQb/4Cbvm/vF6mNnC8QGlUgK9r07k=;
    b=ASVcFfJSX7YnuxUrOPq/zoNWmgq/+zC4KdLaV7m22G7NleoOajZ2fGIxQ6woFcpL4q
    WFEPjE260yvJjHvZR/0Y801KjeQPjsV+HrcQHnUriNdgkyD+kSrbynxaysaFE+9hb61m
    Ihgt3itY+b9mNoweNOaYo/MzcMnox/qAd6N1iS4z0Gym/r92J89o1VvrzEBFQTCKt2KE
    qlKEwOwRl3yRB/KDv5kpa0ra9LsGeRwdRxRIhO13Fm4X/jxDTzVeIduWsCNIvfqCAjJQ
    im0gQajd6kp6yla53P0mVQRuUasMeQBKuKfUG+dW5DuQcRLBGsfMCQUxiWnXPF5oZQTd
    PB2g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2VCLbjFD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 31 Mar 2023 14:21:37 +0200 (CEST)
Message-ID: <bb365ad4-815f-4dac-6e40-83b7197b5033@hartkopp.net>
Date:   Fri, 31 Mar 2023 14:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] can: isotp: fix race between isotp_sendsmg() and
 isotp_release()
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     linux-can@vger.kernel.org, Hillf Danton <hdanton@sina.com>
References: <20230331102114.15164-1-socketcan@hartkopp.net>
 <ZCbM0mTZFgfyWndH@dragonet>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <ZCbM0mTZFgfyWndH@dragonet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Dae,

On 31.03.23 14:06, Dae R. Jeong wrote:
> On Fri, Mar 31, 2023 at 12:21:14PM +0200, Oliver Hartkopp wrote:
>> As discussed with Dae R. Jeong and Hillf Danton here [1] the sendmsg()
>> function in isotp.c might get into a race condition when restoring the
>> former tx.state from the old_state. This patch removes the old_state
>> concept and implements a proper locking for ISOTP_IDLE transitions in
>> isotp_sendmsg() inspired by a simplification idea from Hillf Danton.
>> Additionally a new tx.state ISOTP_SHUTDOWN has been introduced to use
>> the same locking mechanism from isotp_release() which resolves a
>> potential race between isotp_sendsmg() and isotp_release().
>>
>> [1] https://lore.kernel.org/linux-can/ZB%2F93xJxq%2FBUqAgG@dragonet/
>>

(..)

>>   
>> +wait_transmission_finish:
>>   	/* wait for complete transmission of current pdu */
>>   	wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
>>   
>> +	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE)
>> +		goto wait_transmission_finish;
>> +
>>   	/* force state machines to be idle also when a signal occurred */
>> -	so->tx.state = ISOTP_IDLE;
>>   	so->rx.state = ISOTP_IDLE;
>>   
>>   	spin_lock(&isotp_notifier_lock);
>>   	while (isotp_busy_notifier == so) {
>>   		spin_unlock(&isotp_notifier_lock);
>> -- 
>> 2.30.2
>>
> 
> All looks good for me. I tried to figure out abnormal thread
> interleavings regarding the changes in sendmsg() and release(), but I
> couldn't.

I'm still unsure whether a multi-threaded code could send messages and 
close the socket at the same time. But I think the above change would 
fix a potential race here.

Looking at the code I was wondering if I should also check the return 
value of wait_event_interruptible() in isotp_release() and I changed the 
code which also removes the goto statement:

/* wait for complete transmission of current pdu */
while (wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 
0 &&
        cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SHUTDOWN) != ISOTP_IDLE);

/* force state machines to be idle also when a signal occurred */
so->tx.state = ISOTP_SHUTDOWN;
so->rx.state = ISOTP_IDLE;

When wait_event_interruptible() does not return '0' we can neither rely 
on tx.state to be ISOTP_IDLE nor on anybody else taking care for that.

So I would suggest to continue removing the socket.

> Thank you for your hard work!

Thanks for the review and the request to take an additional look at the 
code!

Best regards,
Oliver
