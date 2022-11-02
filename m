Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DD8615D9E
	for <lists+linux-can@lfdr.de>; Wed,  2 Nov 2022 09:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKBIZi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Nov 2022 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiKBIZe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2022 04:25:34 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251B22515
        for <linux-can@vger.kernel.org>; Wed,  2 Nov 2022 01:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667377531;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ofeAVsB4Eh4Xl5k4+CvjHK9XeNgWRqUgVHY/AMUhPDY=;
    b=Qe2XZTX4StEJMp7FEhlXU+Fy7IynzmZViNfXhwKsbgOUErfxwnmh8BrD1EQPnbh7U6
    7PU7Xj1hTUEWkdGyuHyFYf2DOHWt4DvTErTLFI603wzQvpsLtZTQeoFJajENS8wUEkAm
    D4Niyv5KdOTEb4WnaC1rHcRwc/dek6Ql1Ua9sSycob67BsR5xaSFZqcQgX54sXK3hQvk
    BAYoqHl9n3WFXQ1XVt/QIbXmIc2ETu67SFkg5OgnHPTIM/RzpO43pIfnJ6GsEZa4g0qG
    cQrtFuaIyEEwzzaGTwtyaQY3GWPGr+HsW30h4QGw78mHi2Dtb63EyhL/3uyrcTJyRUO4
    LVVg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6hfz3Vg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::923]
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id Dde783yA28PUIHa
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 2 Nov 2022 09:25:30 +0100 (CET)
Message-ID: <41ebf2d2-651c-2325-5005-20b24f5261d2@hartkopp.net>
Date:   Wed, 2 Nov 2022 09:25:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Undefined behavior in Linux Virtual CAN Tunnel
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Max Staudt <max@enpas.org>,
        linux-can <linux-can@vger.kernel.org>
References: <VE1PR04MB72623D6E81DB815700E0C475E8369@VE1PR04MB7262.eurprd04.prod.outlook.com>
 <7fa7a113-2047-0ef5-a2d7-262e2518556a@hartkopp.net>
 <CAMZ6RqKEC-c2c8DZqxN=A=87EtE-KHYECqDtjmHZYbC+UosAzg@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKEC-c2c8DZqxN=A=87EtE-KHYECqDtjmHZYbC+UosAzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 02.11.22 04:30, Vincent MAILHOL wrote:

>> I wonder if this check for (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY)
>> should be moved to another separate helper function
>> can_dropped_invalid_tx_skb()? which can then be called by every 'real'
>> CAN driver.
> 
> I think that having a can_dropped_invalid_tx_skb() and a
> can_dropped_invalid_skb() would be confusing. People will not know
> which one to use without looking at the code.
> 
> If we split it in two, I would rather put more explicit names for the functions:
>    * can_virtual_dropped_invalid_skb(): no CAN_CTRLMODE_LISTENONLY
> check. To be used by vcan, vxcan and any other interfaces without a
> can_priv member.
>    * can_dropped_invalid_skb(): calls can_virtual_dropped_invalid_skb()
> and checks CAN_CTRLMODE_LISTENONLY. To be used by everyone else.

IMO this makes it even more confusing. Especially with the 'virtual' naming.

The can_dropped_invalid_skb() function is implemented in skb.c and 
should (only) handle skb-related stuff.

The fact whether a CAN device is in CAN_CTRLMODE_LISTENONLY mode or not 
is nothing skb-specific and IMO including linux/can/netlink.h in skb.c 
does not fit at all.

The comment for can_dropped_invalid_skb() states:
/* Drop a given socketbuffer if it does not contain a valid CAN frame. */

And not: "Make sure that the skb is allowed to be sent on this interface 
according to its configuration"

I would rather suggest to completely revert the current patch content 
and add a new (inline) helper in include/linux/can/dev.h for real CAN 
interfaces that do both tests.

>> This function could perform can_dropped_invalid_skb() *and* the check
>> for CAN_CTRLMODE_LISTENONLY then.
>>
>> The check for CAN_CTRLMODE_LISTENONLY has not really something to do
>> with a correct skb and for that reason can_dropped_invalid_skb() is
>> probably not the  best place for it.
> 
> Yes and no. For sure, having any of the CAN_CTRLMODE_* flag doesn’t
> make an SKB not well formed. But semantically, it is still invalid to
> have such SKB in the TX path. 

Yes. But it mixes things up IMO.

> Also, I am not sure what better place
> there could be for this check.

See above.

> One other idea: I do not think there is a way to check whether or not
> a netdev has its priv allocated. If we could do such a check, we could
> use a single function for both the virtual and the ’real’ CAN drivers.
> I am thinking of introducing a new flag to keep track of whether or
> not priv is allocated. Something like this:

Not sure whether this would help, as a vcan and vxcan have some priv 
size too - but no can_priv with all the CAN device netlink stuff.

Best regards,
Oliver


> 
>   diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 791a51e2f5d6..076818169495 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -337,8 +337,6 @@ static bool can_skb_headroom_valid(struct
> net_device *dev, struct sk_buff *skb)
>   /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
>   bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
>   {
> -       struct can_priv *priv = netdev_priv(dev);
> -
>          switch (ntohs(skb->protocol)) {
>          case ETH_P_CAN:
>                  if (!can_is_can_skb(skb))
> @@ -361,10 +359,14 @@ bool can_dropped_invalid_skb(struct net_device
> *dev, struct sk_buff *skb)
> 
>          if (!can_skb_headroom_valid(dev, skb)) {
>                  goto inval_skb;
> -       } else if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
> -               netdev_info_once(dev,
> -                                "interface in listen only mode,
> dropping skb\n");
> -               goto inval_skb;
> +       } else if (netdev_has_priv(netdev)) {
> +               struct can_priv *priv = netdev_priv(dev);
> +
> +               if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
> +                       netdev_info_once(dev,
> +                                        "interface in listen only
> mode, dropping skb\n");
> +                       goto inval_skb;
> +               }
>          }
> 
>          return false;
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 9f42fc871c3b..7658971f97a1 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1693,6 +1693,7 @@ enum netdev_priv_flags {
>          IFF_LIVE_RENAME_OK              = 1<<30,
>          IFF_TX_SKB_NO_LINEAR            = BIT_ULL(31),
>          IFF_CHANGE_PROTO_DOWN           = BIT_ULL(32),
> +       IFF_HAS_PRIV                    = BIT_ULL(33),
>   };
> 
>   #define IFF_802_1Q_VLAN                        IFF_802_1Q_VLAN
> @@ -2518,6 +2519,11 @@ void dev_net_set(struct net_device *dev, struct net *net)
>          write_pnet(&dev->nd_net, net);
>   }
> 
> +static inline bool netdev_has_priv(const struct net_device *dev)
> +{
> +       return dev->priv_flags & IFF_HAS_PRIV;
> +}
> +
>   /**
>    *     netdev_priv - access network device private data
>    *     @dev: network device
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d66c73c1c734..be0b337c174c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10605,6 +10605,9 @@ struct net_device *alloc_netdev_mqs(int
> sizeof_priv, const char *name,
>          dev = PTR_ALIGN(p, NETDEV_ALIGN);
>          dev->padded = (char *)dev - (char *)p;
> 
> +       if (sizeof_priv)
> +               dev->priv_flags |= IFF_HAS_PRIV;
> +
>          ref_tracker_dir_init(&dev->refcnt_tracker, 128);
>   #ifdef CONFIG_PCPU_DEV_REFCNT
>          dev->pcpu_refcnt = alloc_percpu(int);
> 
> 
> Does it make sense?
> 
> Yours sincerely,
> Vincent Mailhol
