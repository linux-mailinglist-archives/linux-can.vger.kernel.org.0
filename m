Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0BA572721
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 22:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiGLUUW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 16:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiGLUUV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 16:20:21 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B300C9210
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 13:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657657218;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EK9AsIjYHVtLr2gC4Lx9Ri5ZV6J8WO76u3WX11OudA4=;
    b=BzvPDhKv0xVrM3AOwE9aWASYNzdtbDifDcsiPrOWXa/yvlJVcPGYNHh0QtU/u9a3Ca
    MLE/Zjhri4xfAlZPZdI9wbhivCOQ1wC1v2JE/0R/N4rYSu4EoWWg5DFHDMK7zoHqTELh
    pk8DRq3QrXFXDZm0QxIuAHFjUMrYc42rsJQ3oIIlrpX5Fv0lmCSdzvUCUy7W8YQvSQBS
    7DcK2r7xPSwmeMjUJyXiX6WV4aIKq9+FnYel4JJOZuERFXjpy6bx4RnVBLNIr3koSMmT
    8YkPLqXWl+zAnVlgWefkD259yiqVAJxMcG5bh5ju7omtnY34p/bdMWHkkV403GhhlY9w
    di2g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6CKKI0Oq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Jul 2022 22:20:18 +0200 (CEST)
Message-ID: <79a8a09e-fa85-cbdc-47cd-e54d89b71728@hartkopp.net>
Date:   Tue, 12 Jul 2022 22:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 2/5] can: canxl: introduce ETH_P_CANXL ethernet
 protocol handling
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-3-socketcan@hartkopp.net>
 <CAMZ6Rq+jNEyknCWPCqPa8xEuBFdKeLBOUKmCC=pf0wZL+EG0-A@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6Rq+jNEyknCWPCqPa8xEuBFdKeLBOUKmCC=pf0wZL+EG0-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12.07.22 03:23, Vincent Mailhol wrote:
> On Tue. 12 Jul. 2022 at 03:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> Enable the PF_CAN infrastructure to handle CAN XL frames. A new ethernet
>> protocol type ETH_P_CANXL is defined to tag skbuffs containing the CAN XL
>> frame data structure.
>>
>> As the length information is now a uint16 value for CAN XL a new helper
>> function can_get_data_len() is introduced to retrieve the data length
>> from all types of CAN frames.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   include/linux/can/skb.h       | 14 ++++++++++
>>   include/uapi/linux/if_ether.h |  1 +
>>   net/can/af_can.c              | 49 +++++++++++++++++++++++++++++------
>>   3 files changed, 56 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
>> index 182749e858b3..d043bc4afd6d 100644
>> --- a/include/linux/can/skb.h
>> +++ b/include/linux/can/skb.h
>> @@ -101,6 +101,20 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
>>   {
>>          /* the CAN specific type of skb is identified by its data length */
>>          return skb->len == CANFD_MTU;
>>   }
>>
>> +/* get data length inside of CAN frame for all frame types */> +static inline unsigned int can_get_data_len(struct sk_buff *skb)
>> +{
>> +       if(skb->len == CANXL_MTU) {
>> +               const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
>> +
>> +               return cfx->len;
>> +       } else {
>> +               const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>> +
>> +               return cfd->len;
>> +       }
>> +}
> 
> What about the RTR frames?
> 
> If there are cases in which we intentionally want the declared length
> and not the actual length, it might be good to have two distinct
> helper functions.

Good idea.

> /* get data length inside of CAN frame for all frame types. For
>   * RTR frames, return zero. */
> static inline unsigned int can_get_actual_len(struct sk_buff *skb)

I would name this one can_get_data_len()

> {
>         const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
>         const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> 
>         if (skb->len == CANXL_MTU)
>                 return cfx->len;
> 
>         /* RTR frames have an actual length of zero */
>         if (skb->len == CAN_MTU && cfd->flags & CAN_RTR_FLAG)
>                 return 0;
> 
>         return cfd->len;
> }
> 
> 
> /* get data length inside of CAN frame for all frame types. For
>   * RTR frames, return requested length. */
> static inline unsigned int can_get_declared_len(struct sk_buff *skb)

I would name this one can_get_len()

> {
>         const struct canxl_frame *cfx = (struct canxl_frame *)skb->data;
>         const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
> 
>         if (skb->len == CANXL_MTU)
>                 return cfx->len;
> 
>         return cfd->len;
> }
> 

Best regards,
Oliver


