Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940D35833E9
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiG0UEn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 16:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiG0UEm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 16:04:42 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A793E5A3D2
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658952278;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ogQRDFXjJE41hq7/LfNNsOyhSpCYIB4GPmAu7Hnhy+s=;
    b=avXeTDfz+8qou4qngnjQ86r7Kxp+B4Pne+DIXMTchM8+wJmm4E4t+9n5TK7MH95zjG
    iZxPGLE23eQIY1b69VMW4WG4hQ6x6oR3c722U0fogU8iHCZ6zFngXCR623shdeyhjb0t
    ifuP/EfJ5R1482nGb0NDhEr92wS6ONc5ZtQUlGC4ANNvuOzPRTgOZkiXv1gRHVb3mH1w
    YtVIxuKVXUs7PMoOVwLfCJYTCgX84sZ10Br9E2dOaD0dnHjnZ2B4Kdno1HmTF0oqQEZY
    En8WIPMpqxA76ifAJTMnkFV/zI9Ulvr0YTbQCRu8CMMEmCo05JpJwFWFE47zzXMqFu7F
    Ko3A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y6RK4c5oh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 27 Jul 2022 22:04:38 +0200 (CEST)
Message-ID: <cdcd6e61-4c7a-4bf8-036a-ed326ec481a6@hartkopp.net>
Date:   Wed, 27 Jul 2022 22:04:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v6 5/7] can: canxl: update CAN infrastructure for CAN
 XL frames
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220724074402.117394-1-socketcan@hartkopp.net>
 <20220724074402.117394-6-socketcan@hartkopp.net>
 <20220727140431.55g5aa35rko3vt5q@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220727140431.55g5aa35rko3vt5q@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 27.07.22 16:04, Marc Kleine-Budde wrote:
> On 24.07.2022 09:44:00, Oliver Hartkopp wrote:
>> - add new ETH_P_CANXL ethernet protocol type
>> - update skb checks for CAN XL
>> - add alloc_canxl_skb() which now needs a data length parameter
>> - introduce init_can_skb_reserve() to reduce code duplication
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev/skb.c     | 72 ++++++++++++++++++++++++++---------
>>   include/linux/can/skb.h       | 23 ++++++++++-
>>   include/uapi/linux/if_ether.h |  1 +
>>   net/can/af_can.c              | 25 +++++++++++-
>>   4 files changed, 101 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
>> index ea9ea0128c48..e9e8fcbaa7be 100644
>> --- a/drivers/net/can/dev/skb.c
>> +++ b/drivers/net/can/dev/skb.c
> [...]
>> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
>> +				struct canxl_frame **cfx,
>> +				unsigned int data_len)
>> +{
>> +	struct sk_buff *skb;
>> +
>> +	if (data_len < CANXL_MIN_DLEN || data_len > CANXL_MAX_DLEN)
>> +		goto out_error;
>> +
>> +	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
>> +			       CANXL_HDR_SIZE + data_len);
>> +	if (unlikely(!skb))
>> +		goto out_error;
>> +
>> +	skb->protocol = htons(ETH_P_CANXL);
>> +	init_can_skb_reserve(skb);
>> +	can_skb_prv(skb)->ifindex = dev->ifindex;
>> +
>> +	*cfx = skb_put_zero(skb, CANXL_HDR_SIZE + data_len);
>> +
>> +	/* set CAN XL flag and length information by default */
>> +	(*cfx)->flags = CANXL_XLF;
>> +	(*cfx)->len = data_len;
>> +
>> +	return skb;
>> +
>> +out_error:
>> +		*cfx = NULL;
>> +
>> +		return NULL;
> 
> Nitpick:
> Indent with one tab only here.

Of course! Copy/paste from the if-statement where it originally was m(

Thanks for the review!

After these rounds I really feel better with the skb helpers which also 
brought some clarity to other code that needed to separate between CAN 
and CAN FD processing.

Best regards,
Oliver
