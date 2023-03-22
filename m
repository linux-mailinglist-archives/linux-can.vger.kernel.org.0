Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0F06C5325
	for <lists+linux-can@lfdr.de>; Wed, 22 Mar 2023 18:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCVR7J (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 22 Mar 2023 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjCVR7J (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Mar 2023 13:59:09 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B7C3BC72
        for <linux-can@vger.kernel.org>; Wed, 22 Mar 2023 10:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679507944; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MrzHEX6jUo0h+PchHzoU3kXRMj+6wJKYv0+lbutpYwX9LjKDgkrWV4tfwhGaJJ7M2G
    LObCbjCt7wZP5X0ryPODCE0RabLtwno8zUdeUBp0hz+XJqOZ1A4pTIjCKUfHsn2rKGAN
    pQabdLCYc4g0f/9Mw10UKjWfGKE+UneWDvb0NSyGy4jBMvhP0yFp++BSopc0WJ1qc2r4
    Rt0jCe/shbNj+USzO8G5wrzHasr+QNbnytgoGGZ7gl5/yGg8kjLSRToceKXlUG96ZfOm
    pZIgJgK//YjE6oUcXC3MG5RxoLg7zvbmsQEuLkzbLcaQxGSwzdS3wVR+Kt16g1Dl95z0
    IKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679507944;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=y7mH3fyNlh7zWQ3LO7JNB08Y7u4fhFEEdP7bAywjo3w=;
    b=Wqr146dEJbQK6IxdBYw/5r/bsBYAmRmKToZ4D67IhPwilolWNQdJXpiA9NcP9i13vp
    /w8QrJvGnedymfXC5AeZdya30y1LfPyUp+0I1Iaa0Y+12L8J2APwjSBs6UahEqWUr7ls
    CPiVbJqywyj3UC81NO6bqY0UCglmDEIqQEiuEL3KZtKKOruCfQYmioHNEo0ppVSZBD4n
    vNrtg/b1FU/ikC3V2efiwizO02eiX9qkqeGlggvZOOrjTri2cUosilNnlCm3BrtyN/i0
    PSG4j0rUBl2QrNncm9+IG4krfGm/04CC0tfVFzRLsevubF7dF0nxc9l8f9CQEvNFU4z+
    32Lg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679507944;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=y7mH3fyNlh7zWQ3LO7JNB08Y7u4fhFEEdP7bAywjo3w=;
    b=LkC1ex6FzYO+5LosaCLpSCBe0b3YRH2+zGWctpRbmBurOEszXQunnhu5aqZk6IlyQt
    VpWdOcF+rmlPDC5+tlASE5tO2enLPwZYC0R8C2Gm9FgDQZIsdOlvMWSgnuLUr/ZiaSMM
    OKtt0NuBy5nTxgQ+bj/HWoZqyVRmROxYP4OgRdLqvnhJLpJ8ue/+q5a5+1fx62xqJjj5
    0ny6q6fhUmMAS92rmHQXAvMan0MqmEVdARub9UlwHQ5GjAtHeG+hGVr7lmo9z0wBReU3
    zfra3xCk46je7xfqMzIvNtwSpcmnqsjfK3w3I3tIXe+Ns8jZb2tdOJcP82i5QitppG6H
    d/ig==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2MHx4KJx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 22 Mar 2023 18:59:04 +0100 (CET)
Message-ID: <a91369b3-9615-4300-a617-e3edbb2c628c@hartkopp.net>
Date:   Wed, 22 Mar 2023 18:59:04 +0100
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
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230322085633.zwxip56fyr7qqguu@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 22.03.23 09:56, Marc Kleine-Budde wrote:
> On 20.03.2023 22:07:56, Oliver Hartkopp wrote:

>>
>>> Why are you allocating the max_pdu_size, not rx.len?
>>
>> There is one upper limit which is selected when the 8300 bytes (99,9% of
>> isotp use-cases) are not enough.
>>
>> I intentionally did not want to handle re-allocations for every increase of
>> received PDU size on this socket.
>>
>> Just for simplicity reasons.
> 
> Hmmm. The worst case would be ~1MiB of contiguous kernel memory used, if
> a 8301 bytes message would be send. That puts a lot of pressure on the
> kernel memory for IMHO no good reason.

No, that's not the plan.

The max_pdu_size is a module parameter that simplifies the process, when 
someone needs unusually long PDUs without changing the static buffer 
size in the kernel code.

When you have the use-case to transfer PDUs with 128 kByte you would set 
the max_pdu_size to 128 kByte.

If you need 8301 bytes you set it to 8301.

It is very likely that only one or two isotp socket instances would ever 
allocate this extended buffer on one system at one time.

All other isotp sockets stay with the static buffer of 8300 bytes.

>>> This patch is also taken if the kmalloc() fails, right?
>>
>> s/patch/path/ ?!
> 
> doh!
> 
>> Yes. At the end even the extended buffer might be too small. And when we
>> don't have enough space - either with our without kmalloc() - it throws and
>> error.
>>
>> For that reason a failed kmalloc() does not create any stress. We just stay
>> on the default buffer.
> 
> Just out of interest: How does ISOTP handle this situation? Is an error
> message forwarded to the sender?
> 
>>>>    		/* send FC frame with overflow status */
>>>>    		isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);

Yes. As you can see here the receiver sends and "overflow" error message 
to the sender, when the receive buffer can not handle the PDU size 
announced in the "first frame" of the PDU transmission.

The PDU transmission failure is therefore detected by the sender.

This is also implemented on the sender side where the flow control with 
ISOTP_FC_OVFLW leads to -EMSGSIZE as return value

https://elixir.bootlin.com/linux/v6.2/source/net/can/isotp.c#L419


>> I've been thinking about some sendfile() implementation too. But this again
>> would bloat the code and would not solve the rx side.
> 
> I'm not talking about sendfile. Have a look at j1939's
> j1939_sk_send_loop();
> 
> | https://elixir.bootlin.com/linux/v6.2/source/net/can/j1939/socket.c#L1114
> 

This does not work for isotp like this as you have to handle different 
block sizes in the flow control message.

>>> what about: ARRAY_SIZE(so->rx.sbuf)
>>>
>>
>> Looks good. I was just unsure which macro to use ;-)
> 
> You can also use sizeof(so->rx.sbuf).
> 
> ARRAY_SIZE would cause a compile error if you convert so->rx.sbuf to a
> pointer to dynamically allocated mem, while sizeof() still compiles.

so->rx.sbuf is always a static buffer.

Only so->rx.buf can point to either so->rx.sbuf or to a dynamically 
allocated memory.

But when sizeof() is always safe it would take this for the v3 patch.

Best regards,
Oliver

> 
>>
>>>> +	so->tx.buflen = DEFAULT_MAX_PDU_SIZE;
>>>> +
>>
>> here too. This would use the DEFAULT_MAX_PDU_SIZE at one single point. No
>> chance to get these values out of sync.
> 
> ACK
> 
> Marc
> 
