Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD9615A69
	for <lists+linux-can@lfdr.de>; Wed,  2 Nov 2022 04:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKBDax convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 1 Nov 2022 23:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiKBDa1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Nov 2022 23:30:27 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCC11BEA2
        for <linux-can@vger.kernel.org>; Tue,  1 Nov 2022 20:30:22 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id g62so15259205pfb.10
        for <linux-can@vger.kernel.org>; Tue, 01 Nov 2022 20:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3YLOeCY6lsIzfdV6BK0VEkrCOTpEW36+NhhNVdIVMA=;
        b=rE144JstrrYO+WGXNfe7v5Gox6mnWYqgyLeoY4WEdL6UGmjjENd16SZ2w7UKG538Pq
         q08NT9L0SttprRve+B0/eiSBlsXuN1NkaQ1t4sZsgCYjYNfJW8h4UgCTJiAPOoKxVY5S
         SIMohEeedBKnFt2bNSAg6ykFTyowPYvaXXU0yYiOFwvDjt8jxI/iSwqIryk1McLn8ulY
         JKxNuqZEplD2NNwZ2kNkDSX09Qw/5lTCVm7M9QzMknJYOBy3uJJUv36srwaHmwhaSBPw
         dHbeUzlNhMqTdgWGrFy3IzHh/1Y4W/RFRDKN8LBTziyOuVc3DlMqWPn0ORzsybDu7CQ5
         IeGw==
X-Gm-Message-State: ACrzQf3WeGN4IZroO/4kbHVn3p2DoEuuBSxI3vsacm5KtETUeKm+zBZx
        bvBxCEvXmn1imcbCttnCp36hOAm+YzZvSbm+BFM1QaufSSk=
X-Google-Smtp-Source: AMsMyM4B8bZxsXtZj5OI+qB7R2BJx7s7v4aFB6571+p6UkE1LNx5VKnPslM4zOR4f2cdCp+2mX3Xg5jVBnH10mK7cro=
X-Received: by 2002:a63:8bc2:0:b0:46f:5bbb:7370 with SMTP id
 j185-20020a638bc2000000b0046f5bbb7370mr20105673pge.70.1667359822166; Tue, 01
 Nov 2022 20:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <VE1PR04MB72623D6E81DB815700E0C475E8369@VE1PR04MB7262.eurprd04.prod.outlook.com>
 <7fa7a113-2047-0ef5-a2d7-262e2518556a@hartkopp.net>
In-Reply-To: <7fa7a113-2047-0ef5-a2d7-262e2518556a@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 2 Nov 2022 12:30:10 +0900
Message-ID: <CAMZ6RqKEC-c2c8DZqxN=A=87EtE-KHYECqDtjmHZYbC+UosAzg@mail.gmail.com>
Subject: Re: Undefined behavior in Linux Virtual CAN Tunnel
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Max Staudt <max@enpas.org>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver and Dariusz,

Thanks for the report and sorry for introducing an out of bound bug.

On Wed. 2 Nov. 2022 at 04:45, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Vincent,
>
> Dariusz thankfully reported an issue with this patch
> "can: skb: drop tx skb if in listen only mode"
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a6d190f8c7670
>
> as it accesses priv->ctrlmode even on virtual CAN interfaces like vcan
> and vxcan which are not created with alloc_candev() and
> register_candev() and therefore do not have the can_priv data structures.
> It is just an OOB read and does not crash anything but it may
> potentially lead to frame losses (especially on vxcan's).

ACK.

> I wonder if this check for (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY)
> should be moved to another separate helper function
> can_dropped_invalid_tx_skb()? which can then be called by every 'real'
> CAN driver.

I think that having a can_dropped_invalid_tx_skb() and a
can_dropped_invalid_skb() would be confusing. People will not know
which one to use without looking at the code.

If we split it in two, I would rather put more explicit names for the functions:
  * can_virtual_dropped_invalid_skb(): no CAN_CTRLMODE_LISTENONLY
check. To be used by vcan, vxcan and any other interfaces without a
can_priv member.
  * can_dropped_invalid_skb(): calls can_virtual_dropped_invalid_skb()
and checks CAN_CTRLMODE_LISTENONLY. To be used by everyone else.

> This function could perform can_dropped_invalid_skb() *and* the check
> for CAN_CTRLMODE_LISTENONLY then.
>
> The check for CAN_CTRLMODE_LISTENONLY has not really something to do
> with a correct skb and for that reason can_dropped_invalid_skb() is
> probably not the  best place for it.

Yes and no. For sure, having any of the CAN_CTRLMODE_* flag doesn’t
make an SKB not well formed. But semantically, it is still invalid to
have such SKB in the TX path. Also, I am not sure what better place
there could be for this check.

One other idea: I do not think there is a way to check whether or not
a netdev has its priv allocated. If we could do such a check, we could
use a single function for both the virtual and the ’real’ CAN drivers.
I am thinking of introducing a new flag to keep track of whether or
not priv is allocated. Something like this:

 diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 791a51e2f5d6..076818169495 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -337,8 +337,6 @@ static bool can_skb_headroom_valid(struct
net_device *dev, struct sk_buff *skb)
 /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
 bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 {
-       struct can_priv *priv = netdev_priv(dev);
-
        switch (ntohs(skb->protocol)) {
        case ETH_P_CAN:
                if (!can_is_can_skb(skb))
@@ -361,10 +359,14 @@ bool can_dropped_invalid_skb(struct net_device
*dev, struct sk_buff *skb)

        if (!can_skb_headroom_valid(dev, skb)) {
                goto inval_skb;
-       } else if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
-               netdev_info_once(dev,
-                                "interface in listen only mode,
dropping skb\n");
-               goto inval_skb;
+       } else if (netdev_has_priv(netdev)) {
+               struct can_priv *priv = netdev_priv(dev);
+
+               if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
+                       netdev_info_once(dev,
+                                        "interface in listen only
mode, dropping skb\n");
+                       goto inval_skb;
+               }
        }

        return false;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9f42fc871c3b..7658971f97a1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1693,6 +1693,7 @@ enum netdev_priv_flags {
        IFF_LIVE_RENAME_OK              = 1<<30,
        IFF_TX_SKB_NO_LINEAR            = BIT_ULL(31),
        IFF_CHANGE_PROTO_DOWN           = BIT_ULL(32),
+       IFF_HAS_PRIV                    = BIT_ULL(33),
 };

 #define IFF_802_1Q_VLAN                        IFF_802_1Q_VLAN
@@ -2518,6 +2519,11 @@ void dev_net_set(struct net_device *dev, struct net *net)
        write_pnet(&dev->nd_net, net);
 }

+static inline bool netdev_has_priv(const struct net_device *dev)
+{
+       return dev->priv_flags & IFF_HAS_PRIV;
+}
+
 /**
  *     netdev_priv - access network device private data
  *     @dev: network device
diff --git a/net/core/dev.c b/net/core/dev.c
index d66c73c1c734..be0b337c174c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10605,6 +10605,9 @@ struct net_device *alloc_netdev_mqs(int
sizeof_priv, const char *name,
        dev = PTR_ALIGN(p, NETDEV_ALIGN);
        dev->padded = (char *)dev - (char *)p;

+       if (sizeof_priv)
+               dev->priv_flags |= IFF_HAS_PRIV;
+
        ref_tracker_dir_init(&dev->refcnt_tracker, 128);
 #ifdef CONFIG_PCPU_DEV_REFCNT
        dev->pcpu_refcnt = alloc_percpu(int);


Does it make sense?

Yours sincerely,
Vincent Mailhol
