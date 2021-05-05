Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4167E374848
	for <lists+linux-can@lfdr.de>; Wed,  5 May 2021 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhEES4I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 May 2021 14:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhEES4H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 May 2021 14:56:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C90FC061574
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 11:55:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so1713250wmi.5
        for <linux-can@vger.kernel.org>; Wed, 05 May 2021 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIs/tC+VgsKo9JdIiJQMU5ChvsmzlG6yrOvjvCbOI48=;
        b=o70N3D2oQZB5Geh+sW3Ukvd3gQ2p9QV8m5sdYQaRlJT22bBz8Oo1HHTovBxLMajJu1
         zVgDx3q78ghol1zzy0KdFthb47KplLyXjqTnlpFs6ZLQ6EZRN8hGcBuAR6wfST+mxWHU
         RaBXCj+EaUPEBqL6d0ji2EY3SV12kzX2yV2+GNvNBIIRIrScFvzpidAm6hFIcVRdyCG7
         CpXLUpOU70RpAacMfHgZd63pWTV53Io7HeX9meYmQUFYgd1NJz0v3GOdmisMr2RqMlch
         eOW/NZW5asDObu0w/tpqgcAqmJ8XNKbyycxTCCTGVAVNrIcDh2QjqCUyQfVKS1m/xjdT
         MVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIs/tC+VgsKo9JdIiJQMU5ChvsmzlG6yrOvjvCbOI48=;
        b=sXl33UkZcx0OCWD6Dqs32n99cJrAXogQSc5dt3JPAM4JW8UKnJxb3qR4AyRWAM9wL7
         1TG7SO2HJM0iLBSrulzAwlEV5kisNn3IrNi0YtxTu+dsAJhP+S6zr7dyivc11Y6+8H2u
         efgIgGU+LhUmCmc2Z4TEbJeJKdoOtApTilkKh4k+4OMGSBAvGiNDNF/pB7lS/qeb6xHo
         LifhyKhzraUdUbXOag07izrZQujbQm8hhgygdXNvV9XS3tQYxRhpTPELlG5q6JdvEhZY
         FojzbEDzdZkDnYsCCr+EhLeSFo1y1VPg6luuqb7eyr5rK++ghdtkt6K9tUuEsH58kmJX
         tInQ==
X-Gm-Message-State: AOAM532qwNuSW3k8kCjH5+4LY1jndun3v6EX1z7VPqnOmzV8OwGCDFc/
        iow6iNJR6L94Ry0GJmNA9NgXvdRXjo+BFHNkjcH8aA==
X-Google-Smtp-Source: ABdhPJyFdEYMBAKB2jBm0jle1Z+MjK12AKvNJ0zseg+ha+dA5A/dRL9jUGymN/pTWEQdPD8Wu/FTqHOOZ4aNM09boTc=
X-Received: by 2002:a1c:e409:: with SMTP id b9mr11517451wmh.189.1620240908910;
 Wed, 05 May 2021 11:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210504203546.115734-1-erik@flodin.me> <20210504203546.115734-2-erik@flodin.me>
 <cf5fdb14-47e2-2d08-0d29-c621bff7b312@hartkopp.net> <CAAMKmocxj1zOQastSqKhHmV0-9HVh3NpPmSPWf=byxj+fFPUHQ@mail.gmail.com>
 <64bf5aaf-1e8c-2f29-8263-63710a771843@hartkopp.net>
In-Reply-To: <64bf5aaf-1e8c-2f29-8263-63710a771843@hartkopp.net>
From:   Erik Flodin <erik@flodin.me>
Date:   Wed, 5 May 2021 20:54:57 +0200
Message-ID: <CAAMKmoda0U912_6Qp97fzt4BjcbUPDrE8Cy5C7C-TS5_7du31Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] can: add support for filtering own messages only
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 5 May 2021 at 11:15, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 05.05.21 10:37, Erik Flodin wrote:
>
> >>> Add a new flag to can_rx_register/unregister that, when set, requires
> >>> that the received sk_buff's owning socket matches the socket pointer
> >>> given when setting the filter. This makes it possible to set a filter
> >>> that matches all frames sent on a given socket and nothing else.
> >>
>
> (..)
>
> >>
> >> Wouldn't that already match your requirements?
> >
> > I guess that would require me to use two sockets: one for sending
> > (with RECV_ONLY_OWN_MSGS set) and one for receiving. The problem might
> > then be how to avoid the second socket seeing the frames sent from the
> > first, without disabling loopback completly?
>
> This is indeed a question of the application layout.
>
>  From what I understood your main requirement is to double check the
> outgoing traffic whether is has been sent.

What I would like to have is:
1. Be notified when a frame has been sent. I send (from user space) a
single frame and wait until I get confirmation before sending the next
to give other nodes on the bus a slot to start sending, even if their
frames have ID with lower priority.
2. I don't want to receive my own frames, except to support the use
case above. But then the kernel tells me that it's mine and I can
easily ignore it.
3. Both be able to run with receive filters set (when that makes
sense) or use the default catch-all filter in cases where I want to
receive everything and don't want to enumerate all possible CAN IDs.
4. Be able to use cansend and candump on the same host as above.

> To me it makes sense to use a
> separate socket for sending that triggers the special handling of send
> acknowledges when receiving frames (on that sending socket).
>
> And then use a separate socket to receive frames needed by the application.

To be able to use two sockets I would have to perform filtering in
user space as well in order to filter out frames sent on one socket
and received on the other. But for how long should I remember the sent
frame to be able to filter it out? It might not come at all (in the
case where there are filters set) and setting a time after which it is
forgotten, even if synchronized with the confirmation on the sending
socket, just doesn't feel rock solid.

> In both cases (even with your one-socket solution) you need to implement
> some more or less complex dispatching in user space when receiving frames.

What I do now is to keep the last sent frame around and when I get a
frame with MSG_CONFIRM set I can check that it's the one I sent,
ignore it and continue sending the next frame (if any).

// Erik

> >>>
> >>> Signed-off-by: Erik Flodin <erik@flodin.me>
> >>> ---
> >>>    include/linux/can/core.h |  4 ++--
> >>>    net/can/af_can.c         | 50 ++++++++++++++++++++++------------------
> >>>    net/can/af_can.h         |  1 +
> >>>    net/can/bcm.c            |  9 +++++---
> >>>    net/can/gw.c             |  7 +++---
> >>>    net/can/isotp.c          |  8 +++----
> >>>    net/can/j1939/main.c     |  4 ++--
> >>>    net/can/proc.c           | 11 +++++----
> >>>    net/can/raw.c            | 10 ++++----
> >>>    9 files changed, 58 insertions(+), 46 deletions(-)
> >>>
> >>> diff --git a/include/linux/can/core.h b/include/linux/can/core.h
> >>> index 5fb8d0e3f9c1..7ee68128dc10 100644
> >>> --- a/include/linux/can/core.h
> >>> +++ b/include/linux/can/core.h
> >>> @@ -48,12 +48,12 @@ extern int  can_proto_register(const struct can_proto *cp);
> >>>    extern void can_proto_unregister(const struct can_proto *cp);
> >>>
> >>>    int can_rx_register(struct net *net, struct net_device *dev,
> >>> -                 canid_t can_id, canid_t mask,
> >>> +                 canid_t can_id, canid_t mask, bool match_sk,
> >>>                    void (*func)(struct sk_buff *, void *),
> >>>                    void *data, char *ident, struct sock *sk);
> >>>
> >>>    extern void can_rx_unregister(struct net *net, struct net_device *dev,
> >>> -                           canid_t can_id, canid_t mask,
> >>> +                           canid_t can_id, canid_t mask, bool match_sk,
> >>>                              void (*func)(struct sk_buff *, void *),
> >>>                              void *data);
> >>>
> >>> diff --git a/net/can/af_can.c b/net/can/af_can.c
> >>> index cce2af10eb3e..7b639c121653 100644
> >>> --- a/net/can/af_can.c
> >>> +++ b/net/can/af_can.c
> >>> @@ -414,6 +414,7 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
> >>>     * @dev: pointer to netdevice (NULL => subscribe from 'all' CAN devices list)
> >>>     * @can_id: CAN identifier (see description)
> >>>     * @mask: CAN mask (see description)
> >>> + * @match_sk: match socket pointer on received sk_buff (see description)
> >>>     * @func: callback function on filter match
> >>>     * @data: returned parameter for callback function
> >>>     * @ident: string for calling module identification
> >>> @@ -428,6 +429,9 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
> >>>     *  The filter can be inverted (CAN_INV_FILTER bit set in can_id) or it can
> >>>     *  filter for error message frames (CAN_ERR_FLAG bit set in mask).
> >>>     *
> >>> + *  If match_sk is true, the received sk_buff's owning socket must also match
> >>> + *  the given socket pointer.
> >>> + *
> >>>     *  The provided pointer to the sk_buff is guaranteed to be valid as long as
> >>>     *  the callback function is running. The callback function must *not* free
> >>>     *  the given sk_buff while processing it's task. When the given sk_buff is
> >>> @@ -440,8 +444,9 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
> >>>     *  -ENODEV unknown device
> >>>     */
> >>>    int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
> >>> -                 canid_t mask, void (*func)(struct sk_buff *, void *),
> >>> -                 void *data, char *ident, struct sock *sk)
> >>> +                 canid_t mask, bool match_sk,
> >>> +                 void (*func)(struct sk_buff *, void *), void *data,
> >>> +                 char *ident, struct sock *sk)
> >>>    {
> >>>        struct receiver *rcv;
> >>>        struct hlist_head *rcv_list;
> >>> @@ -468,6 +473,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
> >>>
> >>>        rcv->can_id = can_id;
> >>>        rcv->mask = mask;
> >>> +     rcv->match_sk = match_sk;
> >>>        rcv->matches = 0;
> >>>        rcv->func = func;
> >>>        rcv->data = data;
> >>> @@ -503,6 +509,7 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
> >>>     * @dev: pointer to netdevice (NULL => unsubscribe from 'all' CAN devices list)
> >>>     * @can_id: CAN identifier
> >>>     * @mask: CAN mask
> >>> + * @match_sk: match socket pointer on received sk_buff
> >>>     * @func: callback function on filter match
> >>>     * @data: returned parameter for callback function
> >>>     *
> >>> @@ -510,8 +517,8 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
> >>>     *  Removes subscription entry depending on given (subscription) values.
> >>>     */
> >>>    void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
> >>> -                    canid_t mask, void (*func)(struct sk_buff *, void *),
> >>> -                    void *data)
> >>> +                    canid_t mask, bool match_sk,
> >>> +                    void (*func)(struct sk_buff *, void *), void *data)
> >>>    {
> >>>        struct receiver *rcv = NULL;
> >>>        struct hlist_head *rcv_list;
> >>> @@ -535,7 +542,8 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
> >>>         */
> >>>        hlist_for_each_entry_rcu(rcv, rcv_list, list) {
> >>>                if (rcv->can_id == can_id && rcv->mask == mask &&
> >>> -                 rcv->func == func && rcv->data == data)
> >>> +                 rcv->match_sk == match_sk && rcv->func == func &&
> >>> +                 rcv->data == data)
> >>>                        break;
> >>>        }
> >>>
> >>> @@ -546,8 +554,8 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
> >>>         * a warning here.
> >>>         */
> >>>        if (!rcv) {
> >>> -             pr_warn("can: receive list entry not found for dev %s, id %03X, mask %03X\n",
> >>> -                     DNAME(dev), can_id, mask);
> >>> +             pr_warn("can: receive list entry not found for dev %s, id %03X, mask %03X%s\n",
> >>> +                     DNAME(dev), can_id, mask, match_sk ? " (match sk)" : "");
> >>>                goto out;
> >>>        }
> >>>
> >>> @@ -569,10 +577,14 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
> >>>    }
> >>>    EXPORT_SYMBOL(can_rx_unregister);
> >>>
> >>> -static inline void deliver(struct sk_buff *skb, struct receiver *rcv)
> >>> +static inline int deliver(struct sk_buff *skb, struct receiver *rcv)
> >>>    {
> >>> -     rcv->func(skb, rcv->data);
> >>> -     rcv->matches++;
> >>> +     if (!rcv->match_sk || skb->sk == rcv->sk) {
> >>> +             rcv->func(skb, rcv->data);
> >>> +             rcv->matches++;
> >>> +             return 1;
> >>> +     }
> >>> +     return 0;
> >>>    }
> >>>
> >>>    static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buff *skb)
> >>> @@ -589,8 +601,7 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
> >>>                /* check for error message frame entries only */
> >>>                hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_ERR], list) {
> >>>                        if (can_id & rcv->mask) {
> >>> -                             deliver(skb, rcv);
> >>> -                             matches++;
> >>> +                             matches += deliver(skb, rcv);
> >>>                        }
> >>>                }
> >>>                return matches;
> >>> @@ -598,23 +609,20 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
> >>>
> >>>        /* check for unfiltered entries */
> >>>        hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_ALL], list) {
> >>> -             deliver(skb, rcv);
> >>> -             matches++;
> >>> +             matches += deliver(skb, rcv);
> >>>        }
> >>>
> >>>        /* check for can_id/mask entries */
> >>>        hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_FIL], list) {
> >>>                if ((can_id & rcv->mask) == rcv->can_id) {
> >>> -                     deliver(skb, rcv);
> >>> -                     matches++;
> >>> +                     matches += deliver(skb, rcv);
> >>>                }
> >>>        }
> >>>
> >>>        /* check for inverted can_id/mask entries */
> >>>        hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_INV], list) {
> >>>                if ((can_id & rcv->mask) != rcv->can_id) {
> >>> -                     deliver(skb, rcv);
> >>> -                     matches++;
> >>> +                     matches += deliver(skb, rcv);
> >>>                }
> >>>        }
> >>>
> >>> @@ -625,15 +633,13 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
> >>>        if (can_id & CAN_EFF_FLAG) {
> >>>                hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx_eff[effhash(can_id)], list) {
> >>>                        if (rcv->can_id == can_id) {
> >>> -                             deliver(skb, rcv);
> >>> -                             matches++;
> >>> +                             matches += deliver(skb, rcv);
> >>>                        }
> >>>                }
> >>>        } else {
> >>>                can_id &= CAN_SFF_MASK;
> >>>                hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx_sff[can_id], list) {
> >>> -                     deliver(skb, rcv);
> >>> -                     matches++;
> >>> +                     matches += deliver(skb, rcv);
> >>>                }
> >>>        }
> >>>
> >>> diff --git a/net/can/af_can.h b/net/can/af_can.h
> >>> index 7c2d9161e224..ea98b10d93e7 100644
> >>> --- a/net/can/af_can.h
> >>> +++ b/net/can/af_can.h
> >>> @@ -52,6 +52,7 @@ struct receiver {
> >>>        struct hlist_node list;
> >>>        canid_t can_id;
> >>>        canid_t mask;
> >>> +     bool match_sk;
> >>>        unsigned long matches;
> >>>        void (*func)(struct sk_buff *skb, void *data);
> >>>        void *data;
> >>> diff --git a/net/can/bcm.c b/net/can/bcm.c
> >>> index 909b9e684e04..d89dd82c2178 100644
> >>> --- a/net/can/bcm.c
> >>> +++ b/net/can/bcm.c
> >>> @@ -729,7 +729,8 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
> >>>    {
> >>>        if (op->rx_reg_dev == dev) {
> >>>                can_rx_unregister(dev_net(dev), dev, op->can_id,
> >>> -                               REGMASK(op->can_id), bcm_rx_handler, op);
> >>> +                               REGMASK(op->can_id), false, bcm_rx_handler,
> >>> +                               op);
> >>>
> >>>                /* mark as removed subscription */
> >>>                op->rx_reg_dev = NULL;
> >>> @@ -775,6 +776,7 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
> >>>                                can_rx_unregister(sock_net(op->sk), NULL,
> >>>                                                  op->can_id,
> >>>                                                  REGMASK(op->can_id),
> >>> +                                               false,
> >>>                                                  bcm_rx_handler, op);
> >>>
> >>>                        list_del(&op->list);
> >>> @@ -1193,6 +1195,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
> >>>                                err = can_rx_register(sock_net(sk), dev,
> >>>                                                      op->can_id,
> >>>                                                      REGMASK(op->can_id),
> >>> +                                                   false,
> >>>                                                      bcm_rx_handler, op,
> >>>                                                      "bcm", sk);
> >>>
> >>> @@ -1202,7 +1205,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
> >>>
> >>>                } else
> >>>                        err = can_rx_register(sock_net(sk), NULL, op->can_id,
> >>> -                                           REGMASK(op->can_id),
> >>> +                                           REGMASK(op->can_id), false,
> >>>                                              bcm_rx_handler, op, "bcm", sk);
> >>>                if (err) {
> >>>                        /* this bcm rx op is broken -> remove it */
> >>> @@ -1500,7 +1503,7 @@ static int bcm_release(struct socket *sock)
> >>>                        }
> >>>                } else
> >>>                        can_rx_unregister(net, NULL, op->can_id,
> >>> -                                       REGMASK(op->can_id),
> >>> +                                       REGMASK(op->can_id), false,
> >>>                                          bcm_rx_handler, op);
> >>>
> >>>                bcm_remove_op(op);
> >>> diff --git a/net/can/gw.c b/net/can/gw.c
> >>> index ba4124805602..5dbc7b85e0fc 100644
> >>> --- a/net/can/gw.c
> >>> +++ b/net/can/gw.c
> >>> @@ -567,14 +567,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
> >>>    static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
> >>>    {
> >>>        return can_rx_register(net, gwj->src.dev, gwj->ccgw.filter.can_id,
> >>> -                            gwj->ccgw.filter.can_mask, can_can_gw_rcv,
> >>> -                            gwj, "gw", NULL);
> >>> +                            gwj->ccgw.filter.can_mask, false,
> >>> +                            can_can_gw_rcv, gwj, "gw", NULL);
> >>>    }
> >>>
> >>>    static inline void cgw_unregister_filter(struct net *net, struct cgw_job *gwj)
> >>>    {
> >>>        can_rx_unregister(net, gwj->src.dev, gwj->ccgw.filter.can_id,
> >>> -                       gwj->ccgw.filter.can_mask, can_can_gw_rcv, gwj);
> >>> +                       gwj->ccgw.filter.can_mask, false, can_can_gw_rcv,
> >>> +                       gwj);
> >>>    }
> >>>
> >>>    static int cgw_notifier(struct notifier_block *nb,
> >>> diff --git a/net/can/isotp.c b/net/can/isotp.c
> >>> index 9f94ad3caee9..44d943bbe0b1 100644
> >>> --- a/net/can/isotp.c
> >>> +++ b/net/can/isotp.c
> >>> @@ -1029,7 +1029,7 @@ static int isotp_release(struct socket *sock)
> >>>                        if (dev) {
> >>>                                can_rx_unregister(net, dev, so->rxid,
> >>>                                                  SINGLE_MASK(so->rxid),
> >>> -                                               isotp_rcv, sk);
> >>> +                                               false, isotp_rcv, sk);
> >>>                                dev_put(dev);
> >>>                        }
> >>>                }
> >>> @@ -1111,7 +1111,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
> >>>        if (do_rx_reg)
> >>>                can_rx_register(net, dev, addr->can_addr.tp.rx_id,
> >>>                                SINGLE_MASK(addr->can_addr.tp.rx_id),
> >>> -                             isotp_rcv, sk, "isotp", sk);
> >>> +                             false, isotp_rcv, sk, "isotp", sk);
> >>>
> >>>        dev_put(dev);
> >>>
> >>> @@ -1122,7 +1122,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
> >>>                        if (dev) {
> >>>                                can_rx_unregister(net, dev, so->rxid,
> >>>                                                  SINGLE_MASK(so->rxid),
> >>> -                                               isotp_rcv, sk);
> >>> +                                               false, isotp_rcv, sk);
> >>>                                dev_put(dev);
> >>>                        }
> >>>                }
> >>> @@ -1323,7 +1323,7 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
> >>>                if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST)))
> >>>                        can_rx_unregister(dev_net(dev), dev, so->rxid,
> >>>                                          SINGLE_MASK(so->rxid),
> >>> -                                       isotp_rcv, sk);
> >>> +                                       false, isotp_rcv, sk);
> >>>
> >>>                so->ifindex = 0;
> >>>                so->bound  = 0;
> >>> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> >>> index da3a7a7bcff2..466a20c76fb6 100644
> >>> --- a/net/can/j1939/main.c
> >>> +++ b/net/can/j1939/main.c
> >>> @@ -177,7 +177,7 @@ static int j1939_can_rx_register(struct j1939_priv *priv)
> >>>
> >>>        j1939_priv_get(priv);
> >>>        ret = can_rx_register(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
> >>> -                           j1939_can_recv, priv, "j1939", NULL);
> >>> +                           false, j1939_can_recv, priv, "j1939", NULL);
> >>>        if (ret < 0) {
> >>>                j1939_priv_put(priv);
> >>>                return ret;
> >>> @@ -191,7 +191,7 @@ static void j1939_can_rx_unregister(struct j1939_priv *priv)
> >>>        struct net_device *ndev = priv->ndev;
> >>>
> >>>        can_rx_unregister(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
> >>> -                       j1939_can_recv, priv);
> >>> +                       false, j1939_can_recv, priv);
> >>>
> >>>        j1939_priv_put(priv);
> >>>    }
> >>> diff --git a/net/can/proc.c b/net/can/proc.c
> >>> index d1fe49e6f16d..d312077832a6 100644
> >>> --- a/net/can/proc.c
> >>> +++ b/net/can/proc.c
> >>> @@ -191,11 +191,12 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
> >>>
> >>>        hlist_for_each_entry_rcu(r, rx_list, list) {
> >>>                char *fmt = (r->can_id & CAN_EFF_FLAG)?
> >>> -                     "   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
> >>> -                     "   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
> >>> +                     "   %-5s  %08x  %08x   %c   %pK  %pK  %8ld  %s\n" :
> >>> +                     "   %-5s     %03x    %08x   %c   %pK  %pK  %8ld  %s\n";
> >>>
> >>>                seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
> >>> -                             r->func, r->data, r->matches, r->ident);
> >>> +                             r->match_sk ? '*' : ' ', r->func, r->data,
> >>> +                             r->matches, r->ident);
> >>>        }
> >>>    }
> >>>
> >>> @@ -206,9 +207,9 @@ static void can_print_recv_banner(struct seq_file *m)
> >>>         *                 .......          0  tp20
> >>>         */
> >>>        if (IS_ENABLED(CONFIG_64BIT))
> >>> -             seq_puts(m, "  device   can_id   can_mask      function          userdata       matches  ident\n");
> >>> +             seq_puts(m, "  device   can_id   can_mask  own      function          userdata       matches  ident\n");
> >>>        else
> >>> -             seq_puts(m, "  device   can_id   can_mask  function  userdata   matches  ident\n");
> >>> +             seq_puts(m, "  device   can_id   can_mask  own  function  userdata   matches  ident\n");
> >>>    }
> >>>
> >>>    static int can_stats_proc_show(struct seq_file *m, void *v)
> >>> diff --git a/net/can/raw.c b/net/can/raw.c
> >>> index 139d9471ddcf..acfbae28d451 100644
> >>> --- a/net/can/raw.c
> >>> +++ b/net/can/raw.c
> >>> @@ -187,13 +187,13 @@ static int raw_enable_filters(struct net *net, struct net_device *dev,
> >>>
> >>>        for (i = 0; i < count; i++) {
> >>>                err = can_rx_register(net, dev, filter[i].can_id,
> >>> -                                   filter[i].can_mask,
> >>> +                                   filter[i].can_mask, false,
> >>>                                      raw_rcv, sk, "raw", sk);
> >>>                if (err) {
> >>>                        /* clean up successfully registered filters */
> >>>                        while (--i >= 0)
> >>>                                can_rx_unregister(net, dev, filter[i].can_id,
> >>> -                                               filter[i].can_mask,
> >>> +                                               filter[i].can_mask, false,
> >>>                                                  raw_rcv, sk);
> >>>                        break;
> >>>                }
> >>> @@ -209,7 +209,7 @@ static int raw_enable_errfilter(struct net *net, struct net_device *dev,
> >>>
> >>>        if (err_mask)
> >>>                err = can_rx_register(net, dev, 0, err_mask | CAN_ERR_FLAG,
> >>> -                                   raw_rcv, sk, "raw", sk);
> >>> +                                   false, raw_rcv, sk, "raw", sk);
> >>>
> >>>        return err;
> >>>    }
> >>> @@ -222,7 +222,7 @@ static void raw_disable_filters(struct net *net, struct net_device *dev,
> >>>
> >>>        for (i = 0; i < count; i++)
> >>>                can_rx_unregister(net, dev, filter[i].can_id,
> >>> -                               filter[i].can_mask, raw_rcv, sk);
> >>> +                               filter[i].can_mask, false, raw_rcv, sk);
> >>>    }
> >>>
> >>>    static inline void raw_disable_errfilter(struct net *net,
> >>> @@ -233,7 +233,7 @@ static inline void raw_disable_errfilter(struct net *net,
> >>>    {
> >>>        if (err_mask)
> >>>                can_rx_unregister(net, dev, 0, err_mask | CAN_ERR_FLAG,
> >>> -                               raw_rcv, sk);
> >>> +                               false, raw_rcv, sk);
> >>>    }
> >>>
> >>>    static inline void raw_disable_allfilters(struct net *net,
> >>>
