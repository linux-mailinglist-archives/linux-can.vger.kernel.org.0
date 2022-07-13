Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E8C573DCE
	for <lists+linux-can@lfdr.de>; Wed, 13 Jul 2022 22:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiGMU1Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jul 2022 16:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGMU1Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jul 2022 16:27:24 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A01286E1
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657744041;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dXqOd+ftIIK0Eoj7YN5NJzVkTwH6EYOMyh67EBa3fNg=;
    b=fNhSQCo+eGAhYV1h+WoUUQxyQNoV1m/IKfmgXU4TjX6F9MMBMwkf2myG+giE0kcmpY
    o5ZKuuZyskRUpSP2oV41OMxhpP/0toOabv3GTGMdYNFq0nTJXgXQJq6iSyUwzskqhWHL
    6fDZDyK8Zw8O6O1DLN1yvPpMhqkL7GbOsy3TfEkY1WyDf/twgy+kRaGRQj4EqSGIGCfb
    pMy1cIfGMLWU39DZMPnaSHD2L+7m7avsL3ntgGQ60TVp7+pTpP4pn2DSVIGGUl+A38NE
    /jtToAPHeQ0Py6gCDNidSZtE5ZHlLH/wXrlfr6L+/oea8F96xToNb5cxRdON0OQxKhR9
    bVUQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6DKRK3fi
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 13 Jul 2022 22:27:20 +0200 (CEST)
Message-ID: <f039d26b-7142-a713-0597-dd21876959f2@hartkopp.net>
Date:   Wed, 13 Jul 2022 22:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net>
 <CAMZ6Rq+jNEyknCWPCqPa8xEuBFdKeLBOUKmCC=pf0wZL+EG0-A@mail.gmail.com>
 <79a8a09e-fa85-cbdc-47cd-e54d89b71728@hartkopp.net>
 <CAMZ6RqJMJEjYaokH798a=GqPPDGps1_x=hMtCijkWs8dMrfNPQ@mail.gmail.com>
 <20220713070201.lzih3zqwxdjcyh2p@pengutronix.de>
 <CAMZ6RqJYaG_ZRXaZPQwJUecY53O1HBOWK-fHSvv7ougA_8qUZQ@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqJYaG_ZRXaZPQwJUecY53O1HBOWK-fHSvv7ougA_8qUZQ@mail.gmail.com>
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



On 13.07.22 09:15, Vincent Mailhol wrote:
> On Wed. 13 Jul. 2022 at 16:02, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> On 13.07.2022 08:58:26, Vincent Mailhol wrote:
>>> On Wed. 13 Jul. 2022 at 05:20, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>>> On 12.07.22 03:23, Vincent Mailhol wrote:
>>>>> On Tue. 12 Jul. 2022 at 03:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>>>>> Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethernet
>>>>>> protocol type ETH_P_CANXL is defined to tag skbuffs containing the CAN XL
>>>>>> frame data structure.
>>>>>>
>>>>>> As the length information is now a uint16 value for CAN XL a new helper
>>>>>> function can_get_data_len() is introduced to retrieve the data length
>>>>>> from all types of CAN frames.
>>>>>>
>>>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>>>> ---
>>>>>>    include/linux/can/skb.h       | 14 ++++++++++
>>>>>>    include/uapi/linux/if_ether.h |  1 +
>>>>>>    net/can/af_can.c              | 49 +++++++++++++++++++++++++++++------
>>>>>>    3 files changed, 56 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
>>>>>> index 182749e858b3..d043bc4afd6d 100644
>>>>>> --- a/include/linux/can/skb.h
>>>>>> +++ b/include/linux/can/skb.h
>>>>>> @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>>>>>>    {
>>>>>>           /* the CAN specific type of skb is identified by its data length */
>>>>>>           return skb->len == CANFD_MTU;
>>>>>>    }
>>>>>>
>>>>>> +/* get data length inside of CAN frame for all frame types */> +static inline unsigned int can_get_data_len(struct sk_buff *skb)
>>>>>> +{
>>>>>> +       if(skb->len == CANXL_MTU) {
>>>>>> +               const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
>>>>>> +
>>>>>> +               return cfx->len;
>>>>>> +       } else {
>>>>>> +               const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>>>>>> +
>>>>>> +               return cfd->len;
>>>>>> +       }
>>>>>> +}
>>>>>
>>>>> What about the RTR frames?
>>>>>
>>>>> If there are cases in which we intentionally want the declared length
>>>>> and not the actual length, it might be good to have two distinct
>>>>> helper functions.
>>>>
>>>> Good idea.
>>>>
>>>>> /* get data length inside of CAN frame for all frame types. For
>>>>>    * RTR frames, return zero. */
>>>>> static inline unsigned int can_get_actual_len(struct sk_buff *skb)
>>>>
>>>> I would name this one can_get_data_len()
>>>
>>> ACK.
> 
> So, according to Marc's comments (c.f. below):
> can_skb_get_data_len()
> 
>>>>> {
>>>>>          const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
>>>>>          const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>>>>>
>>>>>          if (skb->len == CANXL_MTU)
>>>>>                  return cfx->len;
>>>>>
>>>>>          /* RTR frames have an actual length of zero */
>>>>>          if (skb->len == CAN_MTU && cfd->flags & CAN_RTR_FLAG)
>>>>>                  return 0;
>>>>>
>>>>>          return cfd->len;
>>>>> }
>>>>>
>>>>>
>>>>> /* get data length inside of CAN frame for all frame types. For
>>>>>    * RTR frames, return requested length. */
>>>>> static inline unsigned int can_get_declared_len(struct sk_buff *skb)
>>>>
>>>> I would name this one can_get_len()
>>>
>>> I anticipate that most of the time, developers do not want to get the
>>> RTR length but the actual length (e.g. to memcpy data[] or to increase
>>> statistics). People will get confused between can_get_data_len() and
>>> can_get_len() due to the similar names. So I would suggest a more
>>> explicit name to point out that this one is probably not the one you
>>> want to use.
>>> Candidates name I can think of:
>>>   * can_get_raw_len()
>>>   * can_get_advertised_len()
>>>   * can_get_rtr_len()

But these three functions still bconfuse me.

IMO we need two values:

- the data byte length (RTR aware)
- the (raw) length value

My suggestion for a naming would be:

- can_skb_get_data_len()
- can_skb_get_len_value()

This also fits to the existing
can_skb_get_frame_len().

> So according to Marc's comments (c.f. below), candidates become:
>    * can_skb_get_raw_len()
>    * can_skb_get_advertised_len()
>    * can_skb_get_rtr_len()

Right.

>>> The only time you want to access the raw len (with real RTR value) is
>>> in the TX path when you fill your device's structures. But here the
>>> can_get_cc_dlc() is a better helper function which is already RTR
>>> aware.
>>
>> There also is
>>
>> | unsigned int can_skb_get_frame_len(const struct sk_buff *skb)
> 
> I totally forgot about that one, despite the fact that I co-developed
> it with you.
> 
>> It gives the length of the frame on the wire in bytes. We should use a
>> common naming scheme. Let's always use can_skb_ as a prefix or drop the
>> skb_ from this function.
> 
> You are right. The idea was to use the can_skb_ prefix because the
> argument of the function was a struct skb_buff. Same applies here.

Yes, that's fine!

Best regards,
Oliver
