Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E130575BE0
	for <lists+linux-can@lfdr.de>; Fri, 15 Jul 2022 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiGOGvb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jul 2022 02:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGOGv3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jul 2022 02:51:29 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56495509D
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 23:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657867885;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nXuHnOcVdeBnNlW+jXsKBUWkK0Ia4+FHehNonLtnESA=;
    b=hx4V8SlB+xG2DgzqcuamZ6B5wh7d/TV5bNgBDg3m5MDmDiQJdbPlF0P4hIHwuBLOla
    J32QFzdBA158e6RDDq1Hx5QpadsJAvvmYjQKmA/hnSZhYEKrYu26CLuyE+jM6tnxEceG
    E8vM39uhzyVlfAhi73XHCDnQVWPTu1JyWUU2EzCTm0YVkAR7Q9ibcCBbMrdKQF/1MkQy
    GigBnRjAZsq1CLZpDdjLhNhjKzlMD8+OeazLtMcj1BLZ5lJ6G1j7VnIuZOyBs8BgXGlp
    Mh7A0aOnY0BBVIDDcJBS18lvGQ6zcgasBFJx/mSZ4zixU3zjTO6mtBSGZ4IkjSW+m3uz
    YE6g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6F6pP7X4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 15 Jul 2022 08:51:25 +0200 (CEST)
Message-ID: <931b0b22-dbe6-454b-8281-4f94856288a1@hartkopp.net>
Date:   Fri, 15 Jul 2022 08:51:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20220714160541.2071-1-socketcan@hartkopp.net>
 <20220714160541.2071-4-socketcan@hartkopp.net>
 <20220714200601.mklari3b6uvb7b2e@pengutronix.de>
 <c731143e-f476-b2f8-c08c-df66339d98f8@hartkopp.net>
 <CAMZ6RqJ0=PhrJUHaZR6QNWkv2vx690AiwPF2RLv1ou_JGX1qxg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqJ0=PhrJUHaZR6QNWkv2vx690AiwPF2RLv1ou_JGX1qxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 15.07.22 05:53, Vincent Mailhol wrote:
> On Fri. 15 Jul. 2022 at 06:14, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 14.07.22 22:06, Marc Kleine-Budde wrote:
>>> On 14.07.2022 18:05:39, Oliver Hartkopp wrote:
>>
>> (..)
>>
>>>> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
>>>> +                            struct canxl_frame **cfx,
>>>> +                            unsigned int datalen)
>>>> +{
>>>> +    struct sk_buff *skb;
>>>> +
>>>> +    if (datalen < CANXL_MIN_DLEN || datalen > CANXL_MAX_DLEN)
>>>> +            goto out_error;
>>>> +
>>>> +    skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
>>>> +                           CANXL_HEAD_SZ + datalen);
> 
> If usings the flexible array member, this would become:
> 
>          skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
>                                 sizeof(struct canxl_frame) + datalen);
> 
> or even:
> 
>          skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
>                                 struct_size(*cxl, data, datalen));
> 
> This is an illustration of my point that flexible data arrays are more
> idiomatic. I find it weird to have to mix sizeof(struct can_skb_priv)
> and CANXL_HEAD_SZ in the same expression...
> 
>>>> +    if (unlikely(!skb))
>>>> +            goto out_error;
>>>> +
>>>> +    skb->protocol = htons(ETH_P_CANXL);
>>>> +    skb->pkt_type = PACKET_BROADCAST;
>>>> +    skb->ip_summed = CHECKSUM_UNNECESSARY;
>>>> +
>>>> +    skb_reset_mac_header(skb);
>>>> +    skb_reset_network_header(skb);
>>>> +    skb_reset_transport_header(skb);
>>>> +
>>>> +    can_skb_reserve(skb);
>>>> +    can_skb_prv(skb)->ifindex = dev->ifindex;
>>>> +    can_skb_prv(skb)->skbcnt = 0;
>>>> +
>>>> +    *cfx = skb_put_zero(skb, CANXL_HEAD_SZ + datalen);
>>>
>>> Should the CANXL_XLF be set here?
>>
>> Yes, we can set that bit here directly - for convenience reasons ;-)
>>
>>> I have a bad feeling if we have a struct canxl_frame with a fixed size,
>>> but it might not completely be backed by data.....
> 
> I tried to think hard of what could go wrong with the
> data[CANXL_MAX_DLEN] declaration.
> 
> The worst I could think of would be some:
>          int datalen = 64; /* or anything less than CANXL_MAX_DLEN */
>          struct canxl_frame *cxl1 = malloc(CANXL_HEAD_SZ + datalen);
>          struct canxl_frame *cxl2 = malloc(CANXL_HEAD_SZ + datalen);
> 
>          memcpy(cxl1, cxl2, sizeof(*cxl1));
> 
> But that example is a bit convoluted. That's why I wrote in my
> previous message that I saw no killer arguments against it.
> 
>>> For example, I've updated the gs_usb driver to work with flexible arrays
>>> to accommodate the different USB frame length:
>>>
>>> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs_usb.c#L216
>>>
>>> Maybe we should talk to Kees Cook what's best to use here.
>>
>> I see this struct canxl_frame with 2048 byte of data more as a user
>> space thing.
>>
>> You can simply read() from the CAN_RAW socket into this struct (as you
>> know it from CAN/CANFD) and it works safely.
>>
>> That we optimize the length to the really needed length inside the skb
>> and for CAN XL socket read/write operations is on another page for me.
>>
>> If we *only* had the canxl data structure inside the kernel I would be
>> definitely ok with flexible arrays.
>> The current implementation indeed never allocates space with the
>> sizeof(struct canxl_frame) ...
>>
>> But I tend to maintain the pattern we introduced for CAN and CAN FD for
>> the user space visible data structures. That is clearer and safe to use
>> by default instead of reading documentation about flexible arrays and
>> how to build some data structure on your own.
> 
> Here, you are making the assumption that the end user will only be
> familiar with the CAN(-FD) and not with other concepts.
> 
> Building data structures on your own is fairly common, the best
> example being the struct iphdr or the struct tcphdr for TCP/IP:
>    * https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ip.h#L86
>    * https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/tcp.h#L25
> (in those examples, it is not a flexible array member but the concept
> is basically the same).

But then you would have to name it struct canxlhdr or canxl_hdr to 
follow this pattern, right?

And this is my other problem. The struct canxl_frame should be able to 
contain a CAN XL frame (as can[fd]_frame do).

I'm fine with introducing e.g. a

struct canxl_hdr {
	canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
	__u8    flags; /* additional flags for CAN XL */
	__u8    sdt;   /* SDU (service data unit) type */
	__u16   len;   /* frame payload length in byte */
	__u32   af;    /* acceptance field */
	__u8    data[];
};

and propose the suggested use-patterns.

But I just don't feel good to give up the struct canxl_frame analogue to 
can[fd]_frame.

Best regards,
Oliver

ps. can we perhaps put canxl_frame and canxl_hdr in some union structure 
that does not look ugly?

> 
> I think it is fair to expect from a developer using Berkeley sockets
> (what SocketCAN is) to be familiar with this.
> 
> In the worst case, the developper who still completely ignore the
> documentation and just do sed "s/canfd/canxl/g" on their existing code
> base will eventually do this:
>          write(sock, &cxl, sizeof(canxl));
> And that would fail immediately (because sizeof(canxl) <
> CANXL_MIN_TU). So I think it is still safe. The real foot gun is when
> you can write incorrect code that still works (e.g. buffer overflow).
> If it directly fails, people will copy/paste the accepted answer on
> stackoverflow and will eventually do the correct:
>          write(sock, &cxl, sizeof(cxl) + cxl.len);
> 
> Finally, for both solutions, user can not do this anymore:
>          assert(read(sock, &cxl, sizeof(cxl)) == sizeof(cxl));
> But instead should do:
>          assert(read(sock, &cxl, sizeof(cxl)) >= CANXL_MINTU);
> So regardless of the solution we use, the developer needs to be aware
> to some extent of the variable size (and ignoring the return value of
> read() is a bad practice so I won't accept this as a counterargument).
> 
> The debate is really on "reusing CAN(-FD) patterns" vs. "doing
> idiomatic C". I will not veto the data[CANXL_MAX_DLEN], but I vote for
> the flexible array member for the reasons listed here.
> 
> Yours sincerely,
> Vincent Mailhol
