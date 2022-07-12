Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6455713DD
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 10:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiGLICc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 04:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiGLICb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 04:02:31 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579D09DECE
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 01:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657612948;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9d2bdegkFka/NfDjx7HbjQsQC+30pSen6YkNLS05vL4=;
    b=IrGi7eNHcVzfOib0V7x5Q+LNfLRXv1Y6quu/1dFmHVMiizXp2Em8KF8ycGm7c77BWj
    rPWACeH6q2KyFXTXwdXPYpPxSf6ChJGx/3DtGb/XNFybHYDT6BoooX5TNsuWUkqdArKL
    1UKJ02hjdQJdszkzn8D9SZVaJEABMb0rrlc+7cbmAotuOEu75Gian7qjdgOZimfBge1H
    09nggxah6TYMIEmpD55Zo0dlvC5XfB5OO0VNaJ6PlbDwdA37EOXEVTEHH34XIHYhs5z0
    WkVlgPhYIwZz/aeDKXwcmDOtYwU5JEVbi50RmgP+GmRFkb3QXYDtpTll9tv9lYOyFghg
    3owQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id 398cccy6C82SSi6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Jul 2022 10:02:28 +0200 (CEST)
Message-ID: <546d29ce-dca6-e171-f3ac-016025ce3e45@hartkopp.net>
Date:   Tue, 12 Jul 2022 10:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net>
 <20220711194116.ohkn7lp3o24h7rp5@pengutronix.de>
 <8a4f80f0-6088-a138-b415-f7bd0b5b5c54@hartkopp.net>
 <20220712071711.msc5aq7rjahwaia2@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220712071711.msc5aq7rjahwaia2@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12.07.22 09:17, Marc Kleine-Budde wrote:
> On 12.07.2022 09:12:49, Oliver Hartkopp wrote:
>>
>>
>> On 11.07.22 21:41, Marc Kleine-Budde wrote:
>>> On 11.07.2022 20:34:23, Oliver Hartkopp wrote:
>>>> Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethernet
>>>> protocol type ETH_P_CANXL is defined to tag skbuffs containing the CAN XL
>>>> frame data structure.
>>>>
>>>> As the length information is now a uint16 value for CAN XL a new helper
>>>> function can_get_data_len() is introduced to retrieve the data length
>>>> from all types of CAN frames.
>>>>
>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>> ---
>>>>    include/linux/can/skb.h       | 14 ++++++++++
>>>>    include/uapi/linux/if_ether.h |  1 +
>>>>    net/can/af_can.c              | 49 +++++++++++++++++++++++++++++------
>>>>    3 files changed, 56 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
>>>> index 182749e858b3..d043bc4afd6d 100644
>>>> --- a/include/linux/can/skb.h
>>>> +++ b/include/linux/can/skb.h
>>>> @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>>>>    {
>>>>    	/* the CAN specific type of skb is identified by its data length */
>>>>    	return skb->len == CANFD_MTU;
>>>>    }
>>>> +/* get data length inside of CAN frame for all frame types */
>>>> +static inline unsigned int can_get_data_len(struct sk_buff *skb)
>>>> +{
>>>> +	if(skb->len == CANXL_MTU) {
>>>> +		const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
>>>> +
>>>> +		return cfx->len;
>>>> +	} else {
>>>> +		const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>>>> +
>>>> +		return cfd->len;
>>>> +	}
>>>> +}
>>>> +
>>>>    #endif /* !_CAN_SKB_H */
>>>> diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
>>>> index d370165bc621..69e0457eb200 100644
>>>> --- a/include/uapi/linux/if_ether.h
>>>> +++ b/include/uapi/linux/if_ether.h
>>>> @@ -136,10 +136,11 @@
>>>>    #define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP frames*/
>>>>    #define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP frames */
>>>>    #define ETH_P_LOCALTALK 0x0009		/* Localtalk pseudo type 	*/
>>>>    #define ETH_P_CAN	0x000C		/* CAN: Controller Area Network */
>>>>    #define ETH_P_CANFD	0x000D		/* CANFD: CAN flexible data rate*/
>>>> +#define ETH_P_CANXL	0x000E		/* CANXL: eXtended frame Length */
>>>>    #define ETH_P_PPPTALK	0x0010		/* Dummy type for Atalk over PPP*/
>>>>    #define ETH_P_TR_802_2	0x0011		/* 802.2 frames 		*/
>>>>    #define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
>>>>    #define ETH_P_CONTROL	0x0016		/* Card specific control frames */
>>>>    #define ETH_P_IRDA	0x0017		/* Linux-IrDA			*/
>>>
>>> This file doesn't change that often I suppose. Or does it make sense to
>>> send this change mainline as soon as possible?
>>
>> AFAIK you only can reserve these values when you have a reference that uses
>> it. I don't seen any additional pressure here.
> 
> There have been added other types that are not used in the kernel (yet).
> 

Ok?!?

I remembered some discussion about PF_FLEXRAY which bounced some years ago.

But I think it should be fine if we get this small patchset discussed 
and upstreamed to net-next in this round, right?

>>>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>>>> index 1fb49d51b25d..2c9f48aa5f1f 100644
>>>> --- a/net/can/af_can.c
>>>> +++ b/net/can/af_can.c
>>>> @@ -197,31 +197,32 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
>>>>     *  -EINVAL when the skb->data does not contain a valid CAN frame
>>>>     */
>>>>    int can_send(struct sk_buff *skb, int loop)
>>>>    {
>>>>    	struct sk_buff *newskb = NULL;
>>>> -	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>>>> +	unsigned int len = can_get_data_len(skb);
>>>>    	struct can_pkg_stats *pkg_stats = dev_net(skb->dev)->can.pkg_stats;
>>>>    	int err = -EINVAL;
>>>>    	if (skb->len == CAN_MTU) {
>>>>    		skb->protocol = htons(ETH_P_CAN);
>>>> -		if (unlikely(cfd->len > CAN_MAX_DLEN))
>>>> +		if (unlikely(len > CAN_MAX_DLEN))
>>>>    			goto inval_skb;
>>>>    	} else if (skb->len == CANFD_MTU) {
>>>>    		skb->protocol = htons(ETH_P_CANFD);
>>>> -		if (unlikely(cfd->len > CANFD_MAX_DLEN))
>>>> +		if (unlikely(len > CANFD_MAX_DLEN))
>>>> +			goto inval_skb;
>>>> +	} else if (skb->len == CANXL_MTU) {
>>>> +		skb->protocol = htons(ETH_P_CANXL);
>>>> +		if (unlikely(len > CANXL_MAX_DLEN || len == 0))
>>>
>>> Do we need a helper for the > CANXL_MAX_DLEN || == 0 check?
>>
>> Some can_xl_is_valid_data_size(unsigned int len) ?
> 
> In other location you're using "canxl" not "can_xl".

I just thought about can_blablabla() as common namespace for our functions.

But canxl_whatever() is also safe ;-)

> What about: canxl_valid_data_size()

Fine for me.

Thanks,
Oliver
