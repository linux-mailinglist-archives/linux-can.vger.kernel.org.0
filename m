Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8995712CA
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 09:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiGLHIP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 03:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLHIO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 03:08:14 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4048F1D0EA
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657609691;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xGYVrLo9IlhEEwB7+buqcbQAWRHw3LAfiiaB8Y2irtU=;
    b=D+VtaI+RXCeLjWeh41vB1cZOwmwq6i3lTbl1qKxLl2G8YW3L46WAPbCBrY8l87mP9o
    3SHEJ5ckNo/E7brYfJCEiwYyt2hsMij/vET0GP/Ho8Z+uJQ0oU5AtTANV+Fp3j5MkQgU
    DaXKGEYxR7Q/Oal6M0ohR6oTJycGFkXmACk0und6Hd8Xrys+ui6w1NrVVuWtXoXmAe+d
    FIQhf5SmVhgMrl1r3ZUBm5ufiYfImbVNrolr25JZnsKLw/Iep0xMInWMAnHS9cKFAaQB
    9Olo8G3S9+pjGuvhQDTNxeP7EPrav40Wgi42Myx3/01Rq9u5wGQTPGPVZfJk+A48XKds
    JNBA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id 398cccy6C78BSQo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Jul 2022 09:08:11 +0200 (CEST)
Message-ID: <34c15995-9785-9a69-fa7a-ccccc8fdc9da@hartkopp.net>
Date:   Tue, 12 Jul 2022 09:08:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-4-socketcan@hartkopp.net>
 <20220711194601.fvwvrcvlxkcvgbsh@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220711194601.fvwvrcvlxkcvgbsh@pengutronix.de>
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



On 11.07.22 21:46, Marc Kleine-Budde wrote:
> On 11.07.2022 20:34:24, Oliver Hartkopp wrote:
>> Extend the CAN device driver infrastructure to handle CAN XL frames.
>> This especially addresses the increased data length which is extended
>> to uint16 for CAN XL.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev/rx-offload.c |  2 +-
>>   drivers/net/can/dev/skb.c        | 53 +++++++++++++++++++++++++++-----
>>   include/linux/can/skb.h          |  3 +-
>>   3 files changed, 48 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
>> index a32a01c172d4..8505e547e922 100644
>> --- a/drivers/net/can/dev/rx-offload.c
>> +++ b/drivers/net/can/dev/rx-offload.c
>> @@ -245,11 +245,11 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
>>   					 unsigned int *frame_len_ptr)
>>   {
>>   	struct net_device *dev = offload->dev;
>>   	struct net_device_stats *stats = &dev->stats;
>>   	struct sk_buff *skb;
>> -	u8 len;
>> +	unsigned int len;
>>   	int err;
>>   
>>   	skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
>>   	if (!skb)
>>   		return 0;
>> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
>> index 8bb62dd864c8..a849f503dcff 100644
>> --- a/drivers/net/can/dev/skb.c
>> +++ b/drivers/net/can/dev/skb.c
>> @@ -53,11 +53,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>>   	BUG_ON(idx >= priv->echo_skb_max);
>>   
>>   	/* check flag whether this packet has to be looped back */
>>   	if (!(dev->flags & IFF_ECHO) ||
>>   	    (skb->protocol != htons(ETH_P_CAN) &&
>> -	     skb->protocol != htons(ETH_P_CANFD))) {
>> +	     skb->protocol != htons(ETH_P_CANFD) &&
>> +	     skb->protocol != htons(ETH_P_CANXL))) {
>>   		kfree_skb(skb);
>>   		return 0;
>>   	}
>>   
>>   	if (!priv->echo_skb[idx]) {
>> @@ -86,12 +87,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(can_put_echo_skb);
>>   
>>   struct sk_buff *
>> -__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
>> -		   unsigned int *frame_len_ptr)
>> +__can_get_echo_skb(struct net_device *dev, unsigned int idx,
>> +		   unsigned int *len_ptr, unsigned int *frame_len_ptr)
>>   {
>>   	struct can_priv *priv = netdev_priv(dev);
>>   
>>   	if (idx >= priv->echo_skb_max) {
>>   		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
>> @@ -104,16 +105,17 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
>>   		 * length is supported on both CAN and CANFD frames.
>>   		 */
>>   		struct sk_buff *skb = priv->echo_skb[idx];
>>   		struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
>>   		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
>> +		unsigned int len = can_get_data_len(skb);
>>   
>>   		/* get the real payload length for netdev statistics */
>>   		if (cf->can_id & CAN_RTR_FLAG)
>>   			*len_ptr = 0;
>>   		else
>> -			*len_ptr = cf->len;
>> +			*len_ptr = len;
>>   
>>   		if (frame_len_ptr)
>>   			*frame_len_ptr = can_skb_priv->frame_len;
>>   
>>   		priv->echo_skb[idx] = NULL;
>> @@ -139,11 +141,11 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
>>    */
>>   unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx,
>>   			      unsigned int *frame_len_ptr)
>>   {
>>   	struct sk_buff *skb;
>> -	u8 len;
>> +	unsigned int len;
>>   
>>   	skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
>>   	if (!skb)
>>   		return 0;
>>   
>> @@ -244,10 +246,41 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
>>   
>>   	return skb;
>>   }
>>   EXPORT_SYMBOL_GPL(alloc_canfd_skb);
>>   
>> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
>> +				struct canxl_frame **cfx)
> 
> The prototype has to be added to a header file

Yes! Seen that when looking through the patches on the mailing list once 
more m(

:-D

Will add it to skb.h

Best,
Oliver
