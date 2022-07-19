Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA557A205
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbiGSOlr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239075AbiGSOlh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:41:37 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3034AB23
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658241492;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cQnX8ZkzFnITSkRy/QSvrq78KIzI7Roi3olBkAmJIwo=;
    b=YTKW8UOEs7hSBeaR4s8ETC0PWOmm1Vk/5JnXy+TmFX1NVUdIQD9pgL78Ka8nxs8HW9
    nXTMRQEcoOo1GTDeaRo5Y374FzYk2aURBhkJpWahMBst7lSSb35A9zB3VWBO7M2FzrkL
    MpBacsogNDrZnUu5nMJ2IP5WEpf0Dem3UgO3SlqP+H22S9QgQaTT+Rdx34sf/BINjSes
    ERvPREimYpDURf7zddHUu9z/k8I0VD0EKeQ5G6j5IeqV4STIz5scNhTdPDoj9rabH8PZ
    V4UpsaXe3AKMLnCQiNAaWRnDgJOZr43pwvKkOsLseJpCOwvUvS5JHlg4j6BXawa3cDFi
    CYow==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6JEcCHOd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 19 Jul 2022 16:38:12 +0200 (CEST)
Message-ID: <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net>
Date:   Tue, 19 Jul 2022 16:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <20220719112748.3281-1-socketcan@hartkopp.net>
 <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 19.07.22 16:11, Vincent Mailhol wrote:
> On Tue. 19 Jul. 2022, 20:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> Extend the CAN device driver infrastructure to handle CAN XL frames.
>> This especially addresses the increased data length which is extended
>> to uint16 for CAN XL.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev/rx-offload.c |  2 +-
>>   drivers/net/can/dev/skb.c        | 49 ++++++++++++++++++++++++++------
>>   include/linux/can/skb.h          |  5 +++-
>>   3 files changed, 45 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
>> index a32a01c172d4..8505e547e922 100644
>> --- a/drivers/net/can/dev/rx-offload.c
>> +++ b/drivers/net/can/dev/rx-offload.c
>> @@ -245,11 +245,11 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
>>                                           unsigned int *frame_len_ptr)
>>   {
>>          struct net_device *dev = offload->dev;
>>          struct net_device_stats *stats = &dev->stats;
>>          struct sk_buff *skb;
>> -       u8 len;
>> +       unsigned int len;
>>          int err;
>>
>>          skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
>>          if (!skb)
>>                  return 0;
>> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
>> index 8bb62dd864c8..8531e0c39d1c 100644
>> --- a/drivers/net/can/dev/skb.c
>> +++ b/drivers/net/can/dev/skb.c
>> @@ -53,11 +53,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>>          BUG_ON(idx >= priv->echo_skb_max);
>>
>>          /* check flag whether this packet has to be looped back */
>>          if (!(dev->flags & IFF_ECHO) ||
>>              (skb->protocol != htons(ETH_P_CAN) &&
>> -            skb->protocol != htons(ETH_P_CANFD))) {
>> +            skb->protocol != htons(ETH_P_CANFD) &&
>> +            skb->protocol != htons(ETH_P_CANXL))) {
>>                  kfree_skb(skb);
>>                  return 0;
>>          }
>>
>>          if (!priv->echo_skb[idx]) {
>> @@ -86,12 +87,12 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>>          return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(can_put_echo_skb);
>>
>>   struct sk_buff *
>> -__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
>> -                  unsigned int *frame_len_ptr)
>> +__can_get_echo_skb(struct net_device *dev, unsigned int idx,
>> +                  unsigned int *len_ptr, unsigned int *frame_len_ptr)
>>   {
>>          struct can_priv *priv = netdev_priv(dev);
>>
>>          if (idx >= priv->echo_skb_max) {
>>                  netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
>> @@ -103,17 +104,13 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
>>                  /* Using "struct canfd_frame::len" for the frame
>>                   * length is supported on both CAN and CANFD frames.
>>                   */
>>                  struct sk_buff *skb = priv->echo_skb[idx];
>>                  struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
>> -               struct canfd_frame *cf = (struct canfd_frame *)skb->data;
>>
>>                  /* get the real payload length for netdev statistics */
>> -               if (cf->can_id & CAN_RTR_FLAG)
>> -                       *len_ptr = 0;
>> -               else
>> -                       *len_ptr = cf->len;
>> +               *len_ptr = can_skb_get_data_len(skb);
>>
>>                  if (frame_len_ptr)
>>                          *frame_len_ptr = can_skb_priv->frame_len;
>>
>>                  priv->echo_skb[idx] = NULL;
>> @@ -139,11 +136,11 @@ __can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr,
>>    */
>>   unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx,
>>                                unsigned int *frame_len_ptr)
>>   {
>>          struct sk_buff *skb;
>> -       u8 len;
>> +       unsigned int len;
>>
>>          skb = __can_get_echo_skb(dev, idx, &len, frame_len_ptr);
>>          if (!skb)
>>                  return 0;
>>
>> @@ -244,10 +241,41 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
>>
>>          return skb;
>>   }
>>   EXPORT_SYMBOL_GPL(alloc_canfd_skb);
>>
>> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
>> +                               struct canxl_frame **cfx)
>> +{
>> +       struct sk_buff *skb;
>> +
>> +       skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
>> +                              sizeof(struct canxl_frame));
> 
> I am confused. In this message:
> https://lore.kernel.org/linux-can/3dcc85f8-2c02-dfe5-de23-d022f3fc56be@hartkopp.net/
> you said that you "vote for selecting the 'truncated' option only"
> (which is OK with me). But here, you are allocating the full size. If
> we always want truncated frames, shouldn't we allocate the exact size
> frame length here?

No confusion.

The API to the user space is 'truncated' option only.

The data structure inside the kernel sizeof(struct can[|fd|xl]_frame).

See:
https://lore.kernel.org/linux-can/4c79233f-1301-d5c7-7698-38d39d8702aa@hartkopp.net/

---8<---

As the sk_buffs are only allocated once and are not copied inside the
kernel there should be no remarkable drawbacks whether we allocate
CAN_MTU skbs or CANXL_MTU skbs.

AFAICS both skbs will fit into a single page.

---8<---

It is just easier and safe.

(..)

>> @@ -302,10 +330,13 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
>>                          goto inval_skb;
>>          } else if (skb->protocol == htons(ETH_P_CANFD)) {
>>                  if (unlikely(skb->len != CANFD_MTU ||
>>                               cfd->len > CANFD_MAX_DLEN))
>>                          goto inval_skb;
>> +       } else if (skb->protocol == htons(ETH_P_CANXL)) {
> 
> Nitpick but with the growing list, I would see a switch
> (skb->protocol) rather than the cascade of if.
> 
>> +               if (unlikely(!can_is_canxl_skb(skb)))
>> +                       goto inval_skb;
>>          } else {
> 
> default:
> 
>>                  goto inval_skb;
>>          }

Yes. Good idea!

Will change that.


Best regards,
Oliver
