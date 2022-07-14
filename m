Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF65756A9
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 22:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiGNU7S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jul 2022 16:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGNU7R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jul 2022 16:59:17 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A9B4D4CE
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 13:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657832353;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=j8Azh0AiC4wkkNBsq6zvoAvg8rsp/Svz5NRDWh8nG3s=;
    b=gng4gV/LOjcIp//G8OFuZ8s95bHIwlS2Wx3hwIEN6+ELkCCevZVpTjSKZMCWYLt7u7
    J6o5V1STXRz8YpmaNDj8UFZoHUpn73W4J3uyvzuuKvcvMdV/iWuEduYgnf+3Svo97V44
    nroJd3p6ilNfXaVmenHRQGnF6MIjsxesDOjvkXEFyMafXyrrw0ADEXkhQ/4C3Sl95mQm
    44tYzldPvtrOzLz6z6nbZZjQ0aNB7KT/TlwdrodzoEdxwx25Dj5NySrxew4DKUxPIKcN
    aU9hXnsAXZnBxuFaEt4qxXSukQRFfbA7JLj+24TJZwF8ZaVZE+4ZkC2Y/PYliFFystKB
    woiA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6EKxD6zs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 14 Jul 2022 22:59:13 +0200 (CEST)
Message-ID: <c731143e-f476-b2f8-c08c-df66339d98f8@hartkopp.net>
Date:   Thu, 14 Jul 2022 22:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220714160541.2071-1-socketcan@hartkopp.net>
 <20220714160541.2071-4-socketcan@hartkopp.net>
 <20220714200601.mklari3b6uvb7b2e@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220714200601.mklari3b6uvb7b2e@pengutronix.de>
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



On 14.07.22 22:06, Marc Kleine-Budde wrote:
> On 14.07.2022 18:05:39, Oliver Hartkopp wrote:

(..)

>> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
>> +				struct canxl_frame **cfx,
>> +				unsigned int datalen)
>> +{
>> +	struct sk_buff *skb;
>> +
>> +	if (datalen < CANXL_MIN_DLEN || datalen > CANXL_MAX_DLEN)
>> +		goto out_error;
>> +
>> +	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
>> +			       CANXL_HEAD_SZ + datalen);
>> +	if (unlikely(!skb))
>> +		goto out_error;
>> +
>> +	skb->protocol = htons(ETH_P_CANXL);
>> +	skb->pkt_type = PACKET_BROADCAST;
>> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +
>> +	skb_reset_mac_header(skb);
>> +	skb_reset_network_header(skb);
>> +	skb_reset_transport_header(skb);
>> +
>> +	can_skb_reserve(skb);
>> +	can_skb_prv(skb)->ifindex = dev->ifindex;
>> +	can_skb_prv(skb)->skbcnt = 0;
>> +
>> +	*cfx = skb_put_zero(skb, CANXL_HEAD_SZ + datalen);
> 
> Should the CANXL_XLF be set here?

Yes, we can set that bit here directly - for convenience reasons ;-)

> I have a bad feeling if we have a struct canxl_frame with a fixed size,
> but it might not completely be backed by data.....
> 
> For example, I've updated the gs_usb driver to work with flexible arrays
> to accommodate the different USB frame length:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs_usb.c#L216
> 
> Maybe we should talk to Kees Cook what's best to use here.

I see this struct canxl_frame with 2048 byte of data more as a user 
space thing.

You can simply read() from the CAN_RAW socket into this struct (as you 
know it from CAN/CANFD) and it works safely.

That we optimize the length to the really needed length inside the skb 
and for CAN XL socket read/write operations is on another page for me.

If we *only* had the canxl data structure inside the kernel I would be 
definitely ok with flexible arrays.
The current implementation indeed never allocates space with the 
sizeof(struct canxl_frame) ...

But I tend to maintain the pattern we introduced for CAN and CAN FD for 
the user space visible data structures. That is clearer and safe to use 
by default instead of reading documentation about flexible arrays and 
how to build some data structure on your own.

Regards,
Oliver
