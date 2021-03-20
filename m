Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6612342C4B
	for <lists+linux-can@lfdr.de>; Sat, 20 Mar 2021 12:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhCTLfJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 20 Mar 2021 07:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCTLen (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 20 Mar 2021 07:34:43 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4CEC0617A7
        for <linux-can@vger.kernel.org>; Sat, 20 Mar 2021 03:38:14 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id o66so984011ybg.10
        for <linux-can@vger.kernel.org>; Sat, 20 Mar 2021 03:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5I5w8vnoH/Uyrv5oTnPq5KP6beEe/zmLYEBtFd+f71I=;
        b=hWu5lSQ1iftTy9n2I78tpyIds7tOqI9bvYiEM2pawhWALf1KDFhEbK6m89T0T1JUqk
         gX+zkC+w/7UleUgPJcYPKw2nUAs7M5iJGvUBGkGD0lChFKJX5FWHxt6Rt/8RIN4TVjwQ
         bKdUMBEWEq9/R4K82T4NI80An397zfStjFPSXcNveKt+dbw7/FLQHUb7H1AOLXi4GosI
         e7adqoDuhsFE2wrz4xDAoRdyBTi0wWkp5HmAQKK4gslLcZce0mYdUTlKZe/4XmvpizPo
         khwm+JzLQEkhebVsM0WTz62/tuojJ/eFkGp/zZAFZHuEZn1KArpyKjNMpvv6n6aft8yW
         a/8A==
X-Gm-Message-State: AOAM533OIr6cDG2Yzq56ZghCANTTybkw7GBwK1wHgNWdY2xgSIu+w/fd
        LXEHBHbO6aZYgVArIjIpb64Y/A+R0rSnPqBG8VXFonJkrh4ap9of
X-Google-Smtp-Source: ABdhPJxaaBI1gfD2XAz77KD2r3wN43hGZmYq87hE5gxN7icDn46E1EjabRG9pW1dyTkIBnDcEto7HkgUAtHFBH1qKaY=
X-Received: by 2002:a05:6902:4b2:: with SMTP id r18mr12261844ybs.226.1616236393728;
 Sat, 20 Mar 2021 03:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210319124141.247844-1-mkl@pengutronix.de> <20210319124141.247844-2-mkl@pengutronix.de>
 <88fc8ae5-a585-e5a7-b8c8-3f4481cea7e1@pengutronix.de>
In-Reply-To: <88fc8ae5-a585-e5a7-b8c8-3f4481cea7e1@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 20 Mar 2021 19:33:02 +0900
Message-ID: <CAMZ6RqL+n4tRy-B-W+fzW5B3QV6Bedrko57pU_0TE023Oxw_5w@mail.gmail.com>
Subject: Re: [PATCH v13 01/11] can: etas_es58x: add core support for ETAS
 ES58X CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 19 Mar 2021 at 23:57, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 3/19/21 1:41 PM, Marc Kleine-Budde wrote:
> > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > This patch adds the core support for various USB CAN interfaces from
> > ETAS GmbH (https://www.etas.com/en/products/es58x.php). The next
> > patches add the glue code drivers for the individual interfaces.
> >
> > Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> [...]
>
> > diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> > new file mode 100644
> > index 000000000000..f2dc943bb0b2
> > --- /dev/null
> > +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
>
> [...]
>
> > +/**
> > + * es58x_timestamp_to_ns() - Convert a timestamp value received from a
> > + *   ES58X device to nanoseconds.
> > + * @timestamp: Timestamp received from a ES58X device.
> > + *
> > + * The timestamp received from ES58X is expressed in multiple of 0.5
> > + * micro seconds. This function converts it in to nanoseconds.
> > + *
> > + * Return: Timestamp value in nanoseconds.
> > + */
> > +static u64 es58x_timestamp_to_ns(u64 timestamp)
> > +{
> > +     const u64 es58x_timestamp_ns_mult_coef = 500ULL;
> > +
> > +     return es58x_timestamp_ns_mult_coef * timestamp;
> > +}
> > +
> > +/**
> > + * es58x_set_skb_timestamp() - Set the hardware timestamp of an skb.
> > + * @netdev: CAN network device.
> > + * @skb: socket buffer of a CAN message.
> > + * @timestamp: Timestamp received from an ES58X device.
> > + *
> > + * Used for both received and loopback messages.
> > + *
> > + * Return: zero on success, -EFAULT if @skb is NULL.
>
> That's not correct.
>
> Please make sure to call it with skb != NULL and make it a void function.

Ack.
All calls to that function already checked that the skb was not NULL.
I will make the function void.

> Does it make sense for you to use of struct cyclecounter/struct timecounter.
> Have a look at:
>
> https://lore.kernel.org/linux-can/20210304160328.2752293-6-mkl@pengutronix.de/
>
> As your device already provides a u64 timestamp you don't need the worker.

I saw your patch but because my device already uses a 64 bit
counter, I did not see a benefit to do so.

Which problem would the struct cyclecounter/struct timecounter
solve for my driver?

> > + */
> > +static int es58x_set_skb_timestamp(struct net_device *netdev,
> > +                                struct sk_buff *skb, u64 timestamp)
> > +{
> > +     struct es58x_device *es58x_dev = es58x_priv(netdev)->es58x_dev;
> > +     struct skb_shared_hwtstamps *hwts;
> > +
> > +     hwts = skb_hwtstamps(skb);
> > +     /* Ignoring overflow (overflow on 64 bits timestamp with nano
> > +      * second precision would occur after more than 500 years).
> > +      */
> > +     hwts->hwtstamp = ns_to_ktime(es58x_timestamp_to_ns(timestamp) +
> > +                                  es58x_dev->realtime_diff_ns);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * es58x_rx_timestamp() - Handle a received timestamp.
> > + * @es58x_dev: ES58X device.
> > + * @timestamp: Timestamp received from a ES58X device.
> > + *
> > + * Calculate the difference between the ES58X device and the kernel
> > + * internal clocks. This difference will be later used as an offset to
> > + * convert the timestamps of RX and loopback messages to match the
> > + * kernel system time (e.g. convert to UNIX time).
>
> I'm not sure if we want to have the timestamp based on the kernel system time.
> The problem I see is that your clock is not synchronized to your system clock
> and will probably drift, so you might accumulate an offset.
>
> When looking at candump output, a timestamp that more or less current time gives
> a false sense of correctness, but if the timestamp is short after 01.0.1970 you
> don't expect it to be correct.
>
> But this is a different problem.....

Here, we are discussing tastes and colors. I am perfectly aware
that the two quartz used by the device and the kernel are not in
sync and will drift away from each other. However, when looking
at my traces, I like to have a hint of when an event occurs. In
the worst case, the quartz might drift away up to four seconds a day,
but the date, the hours and the minutes stay accurate.

So it is a discussion of making it convenient versus making it dummy proof.

If there is a strong consensus not to base the hardware timestamp
on the kernel, then I will remove it. But if I have the choice, I
prefer to keep it as it is.

> > + *
> > + * Return: zero on success.
> > + */
> > +int es58x_rx_timestamp(struct es58x_device *es58x_dev, u64 timestamp)
> void
> > +{
> > +     u64 ktime_real_ns = ktime_get_real_ns();
> > +     u64 device_timestamp = es58x_timestamp_to_ns(timestamp);
> > +
> > +     dev_dbg(es58x_dev->dev, "%s: request round-trip time: %llu ns\n",
> > +             __func__, ktime_real_ns - es58x_dev->ktime_req_ns);
> > +
> > +     es58x_dev->realtime_diff_ns =
> > +         (es58x_dev->ktime_req_ns + ktime_real_ns) / 2 - device_timestamp;
> > +     es58x_dev->ktime_req_ns = 0;
> > +
> > +     dev_dbg(es58x_dev->dev,
> > +             "%s: Device timestamp: %llu, diff with kernel: %llu\n",
> > +             __func__, device_timestamp, es58x_dev->realtime_diff_ns);
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * es58x_set_realtime_diff_ns() - Calculate difference between the
> > + *   clocks of the ES58X device and the kernel
> > + * @es58x_dev: ES58X device.
> > + *
> > + * Request a timestamp from the ES58X device. Once the answer is
> > + * received, the timestamp difference will be set by the callback
> > + * function es58x_rx_timestamp().
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +static int es58x_set_realtime_diff_ns(struct es58x_device *es58x_dev)
> > +{
> > +     if (es58x_dev->ktime_req_ns) {
> > +             dev_warn(es58x_dev->dev,
> > +                      "%s: Previous request to set timestamp has not completed yet\n",
> > +                      __func__);
> > +             return -EBUSY;
>
> The caller ignores the return value.

ACK.
Now the caller will check the return value.

> > +     }
> > +
> > +     es58x_dev->ktime_req_ns = ktime_get_real_ns();
> > +     return es58x_dev->ops->get_timestamp(es58x_dev);
> > +}
> > +
> > +/**
> > + * es58x_is_can_state_active() - Is the network device in an active
> > + *   CAN state?
> > + * @netdev: CAN network device.
> > + *
> > + * The device is considered active if it is able to send or receive
> > + * CAN frames, that is to say if it is in any of
> > + * CAN_STATE_ERROR_ACTIVE, CAN_STATE_ERROR_WARNING or
> > + * CAN_STATE_ERROR_PASSIVE states.
> > + *
> > + * Caution: when recovering from a bus-off,
> > + * net/core/dev.c#can_restart() will call
> > + * net/core/dev.c#can_flush_echo_skb() without using any kind of
> > + * locks. For this reason, it is critical to guaranty that no TX or
>                                                 ^^^^^^^^
> guarantee

ACK.

> > + * loopback operations (i.e. any access to priv->echo_skb[]) can be
> > + * done while this function is returning false.
> > + *
> > + * Return: true if the device is active, else returns false.
> > + */
> > +static bool es58x_is_can_state_active(struct net_device *netdev)
> > +{
> > +     return es58x_priv(netdev)->can.state < CAN_STATE_BUS_OFF;
> > +}
> > +
> > +/**
> > + * es58x_is_echo_skb_threshold_reached() - Determine the limit of how
> > + *   many skb slots can be taken before we should stop the network
> > + *   queue.
> > + * @priv: ES58X private parameters related to the network device.
> > + *
> > + * We need to save enough free skb slots in order to be able to do
> > + * bulk send. This function can be used to determine when to wake or
> > + * stop the network queue in regard to the number of skb slots already
> > + * taken if the loopback FIFO.
> > + *
> > + * Return: boolean.
> > + */
> > +static bool es58x_is_echo_skb_threshold_reached(struct es58x_priv *priv)
> > +{
> > +     unsigned long num_echo_skb =  priv->tx_head - priv->tx_tail;
> > +     unsigned long threshold = priv->can.echo_skb_max -
> > +             priv->es58x_dev->param->tx_bulk_max + 1;
>
> you're using u32 for tx_head and tail, no need for unsinged long here. better
> make all unsigned int.

I made those two u32.

> > +
> > +     return num_echo_skb >= threshold;
> > +}
> > +
> > +/**
> > + * es58x_add_skb_idx() - Increment an index of the loopback FIFO.
> > + * @priv: ES58X private parameters related to the network device.
> > + * @idx: address of the index to be incremented.
> > + * @a: the increment. Must be positive and less or equal to
> > + *   @priv->can.echo_skb_max.
> > + *
> > + * Do a modulus addition: set *@idx to (*@idx + @a) %
> > + * @priv->can.echo_skb_max.
> > + *
> > + * Rationale: the modulus operator % takes a decent amount of CPU
> > + * cycles (c.f. other division functions such as
> > + * include/linux/math64.h:iter_div_u64_rem()).
> > + */
> > +static __always_inline void es58x_add_skb_idx(struct es58x_priv *priv,
> > +                                           u16 *idx, u16 a)
> unused?

Yes, Jimmy also pointed that issue.
I will remove it.

> > +{
> > +     *idx += a;
> > +     if (*idx >= priv->can.echo_skb_max)
> > +             *idx -= priv->can.echo_skb_max;
> > +}
> > +
> > +/**
> > + * es58x_can_free_echo_skb_tail() - Remove the oldest echo skb of the
> > + *   loopback FIFO.
> > + * @netdev: CAN network device.
> > + *
> > + * Naming convention: the tail is the beginning of the FIFO, i.e. the
> > + * first skb to have entered the FIFO.
> > + */
> > +static void es58x_can_free_echo_skb_tail(struct net_device *netdev)
> > +{
> > +     struct es58x_priv *priv = es58x_priv(netdev);
> > +     u16 fifo_mask = priv->es58x_dev->param->fifo_mask;
> > +     struct sk_buff *skb = priv->can.echo_skb[priv->tx_tail & fifo_mask];
> > +
> > +     netdev_completed_queue(netdev, 1, can_skb_prv(skb)->frame_len);
> > +     can_free_echo_skb(netdev, priv->tx_tail & fifo_mask);
>
> Plese use can_free_echo_skb() from:
>
> https://lore.kernel.org/r/20210319142700.305648-1-mkl@pengutronix.de

ACK.

> > +
> > +     priv->tx_tail++;
> > +
> > +     netdev->stats.tx_dropped++;
> > +}
> > +
> > +/**
> > + * es58x_can_get_echo_skb_recovery() - Try to re-sync the loopback FIFO.
> > + * @netdev: CAN network device.
> > + * @rcv_packet_idx: Index
> > + *
> > + * This function should not be called under normal circumstances. In
> > + * the unlikely case that one or several URB packages get dropped by
> > + * the device, the index will get out of sync. Try to recover by
> > + * dropping the echo skb packets with older indexes.
> > + *
> > + * Return: zero if recovery was successful, -EINVAL otherwise.
> > + */
> > +static int es58x_can_get_echo_skb_recovery(struct net_device *netdev,
> > +                                        u32 rcv_packet_idx)
> > +{
> > +     struct es58x_priv *priv = es58x_priv(netdev);
> > +     int ret = 0;
> > +
> > +     netdev->stats.tx_errors++;
> > +
> > +     if (net_ratelimit())
> > +             netdev_warn(netdev,
> > +                         "Bad loopback packet index: %u. First index: %u, end index %u, num_echo_skb: %02u/%02u\n",
> > +                         rcv_packet_idx, priv->tx_tail, priv->tx_head,
> > +                         priv->tx_head - priv->tx_tail,
> > +                         priv->can.echo_skb_max);
> > +
> > +     if (rcv_packet_idx < priv->tx_tail) {
>
> This doesn't look wrap around safe. I think you have to do the
> subtract-cast-to-signed trick here, too.

ACK.
If a wrap around occurs, the next if catches it, but
then the wrong warning message is displayed.

I will make this also wrap around safe.

> > +             if (net_ratelimit())
> > +                     netdev_warn(netdev,
> > +                                 "Received loopback is from the past. Ignoring it\n");
> > +             ret = -EINVAL;
> > +     } else if ((s32)(rcv_packet_idx - priv->tx_head) >= 0LL) {
>
> (s32) is not LL, I think it simple 0 is ok here.

Technically, the int type is only guaranteed to be 16 bits. 0LL
is definitely overkill. 0L would be the best if we stick to the C
standard. But in the kernel, I think that it is implied that
integers are 32 bits at least so your suggestion of simply
putting 0 is fine :)

> > +             if (net_ratelimit())
> > +                     netdev_err(netdev,
> > +                                "Received loopback is from the future. Ignoring it\n");
> > +             ret = -EINVAL;
> > +     } else {
> > +             if (net_ratelimit())
> > +                     netdev_warn(netdev,
> > +                                 "Loopback recovery: dropping %u echo skb from index %u to %u\n",
> > +                                 rcv_packet_idx - priv->tx_tail,
> > +                                 priv->tx_tail, rcv_packet_idx - 1);
> > +             while (priv->tx_tail != rcv_packet_idx) {
> > +                     if (priv->tx_tail == priv->tx_head)
> > +                             return -EINVAL;
> > +                     es58x_can_free_echo_skb_tail(netdev);
> > +             }
> > +     }
> > +     return ret;
> > +}
> > +
> > +/**
> > + * es58x_can_get_echo_skb() - Get the skb from the loopback FIFO and
> > + *   loop it back locally.
> > + * @netdev: CAN network device.
> > + * @rcv_packet_idx: Index of the first packet received from the device.
> > + * @tstamps: Array of hardware timestamps received from a ES58X device.
> > + * @pkts: Number of packets (and so, length of @tstamps).
> > + *
> > + * Callback function for when we receive a self reception acknowledgment.
> > + * Retrieves the skb from the loopback FIFO, sets its hardware timestamp
> > + * (the actual time it was sent) and loops it back locally.
> > + *
> > + * The device has to be active (i.e. network interface UP and not in
> > + * bus off state or restarting).
> > + *
> > + * Packet indexes must be consecutive (i.e. index of first packet is
> > + * @rcv_packet_idx, index of second packet is @rcv_packet_idx + 1 and
> > + * index of last packet is @rcv_packet_idx + @pkts - 1).
> > + *
> > + * Return: zero on success.
> > + */
> > +int es58x_can_get_echo_skb(struct net_device *netdev, u32 rcv_packet_idx,
> > +                        u64 *tstamps, unsigned int pkts)
> > +{
> > +     struct es58x_priv *priv = es58x_priv(netdev);
> > +     unsigned int rx_total_frame_len = 0;
> > +     unsigned int num_echo_skb = priv->tx_head - priv->tx_tail;
> > +     int i;
> > +     int ret = 0;
> > +     u16 fifo_mask = priv->es58x_dev->param->fifo_mask;
> > +
> > +     if (!netif_running(netdev)) {
> > +             if (net_ratelimit())
> > +                     netdev_info(netdev,
> > +                                 "%s: %s is down, dropping %d loopback packets\n",
> > +                                 __func__, netdev->name, pkts);
> > +             netdev->stats.tx_dropped++;
> > +             return 0;
> > +     } else if (!es58x_is_can_state_active(netdev)) {
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev,
> > +                                "Bus is off or device is restarting. Ignoring %u loopback packets from index %u\n",
> > +                                pkts, rcv_packet_idx);
> > +             /* stats.tx_dropped will be (or was already)
> > +              * incremented by
> > +              * drivers/net/can/net/dev.c:can_flush_echo_skb().
> > +              */
> > +             return 0;
> > +     } else if (num_echo_skb == 0) {
> > +             if (net_ratelimit())
> > +                     netdev_warn(netdev,
> > +                                 "Received %u loopback packets from index: %u but echo skb queue is empty.\n",
> > +                                 pkts, rcv_packet_idx);
> > +             netdev->stats.tx_dropped += pkts;
> > +             return 0;
> > +     }
> > +
> > +     if (priv->tx_tail != rcv_packet_idx) {
> > +             ret = es58x_can_get_echo_skb_recovery(netdev, rcv_packet_idx);
> > +             if (ret < 0) {
> > +                     if (net_ratelimit())
> > +                             netdev_warn(netdev,
> > +                                         "Could not find echo skb for loopback packet index: %u\n",
> > +                                         rcv_packet_idx);
> > +                     return 0;
> > +             }
> > +     }
> > +     if (num_echo_skb < pkts) {
> > +             int pkts_drop = pkts - num_echo_skb;
> > +
> > +             if (net_ratelimit())
> > +                     netdev_err(netdev,
> > +                                "Received %u loopback packets but have only %d echo skb. Dropping %d echo skb\n",
> > +                                pkts, num_echo_skb, pkts_drop);
> > +             netdev->stats.tx_dropped += pkts_drop;
> > +             pkts -= pkts_drop;
> > +     }
> > +
> > +     for (i = 0; i < pkts; i++) {
> > +             unsigned int skb_idx = priv->tx_tail & fifo_mask;
> > +             struct sk_buff *skb = priv->can.echo_skb[skb_idx];
> > +             unsigned int frame_len = 0;
> > +
> > +             if (skb)
> > +                     es58x_set_skb_timestamp(netdev, skb, tstamps[i]);
>
> I think we need a nice funtion to set the timestamp of a TX echo skb. But that's
> a different patch. :D

Yes, I had the same thing in mind. But the next thing on my todo list
is the TDC.

> > +
> > +             netdev->stats.tx_bytes += can_get_echo_skb(netdev, skb_idx,
> > +                                                        &frame_len);
> > +             rx_total_frame_len += frame_len;
> > +
> > +             priv->tx_tail++;
> > +     }
> > +
> > +     netdev_completed_queue(netdev, pkts, rx_total_frame_len);
> > +     netdev->stats.tx_packets += pkts;
> > +
> > +     priv->err_passive_before_rtx_success = 0;
> > +     if (!es58x_is_echo_skb_threshold_reached(priv))
> > +             netif_wake_queue(netdev);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * es58x_can_flush_echo_skb() - Reset the loopback FIFO.
> > + * @netdev: CAN network device.
> > + *
> > + * The echo_skb array of struct can_priv will be flushed by
> > + * drivers/net/can/dev.c:can_flush_echo_skb(). This function resets
> > + * the parameters of the struct es58x_priv of our device and reset the
> > + * queue (c.f. BQL).
> > + */
> > +static void es58x_can_flush_echo_skb(struct net_device *netdev)
> > +{
> > +     struct es58x_priv *priv = es58x_priv(netdev);
> > +
> > +     priv->tx_tail = 0;
> > +     priv->tx_head = 0;
> > +     netdev_reset_queue(netdev);
> > +}
> > +
> > +/**
> > + * es58x_flush_pending_tx_msg() - Reset the buffer for transmission messages.
> > + * @netdev: CAN network device.
> > + *
> > + * es58x_start_xmit() will queue up to tx_bulk_max messages in
> > + * &tx_urb buffer and do a bulk send of all messages in one single URB
> > + * (c.f. xmit_more flag). When the device recovers from a bus off
> > + * state or when the device stops, the tx_urb buffer might still have
> > + * pending messages in it and thus need to be flushed.
> > + */
> > +static void es58x_flush_pending_tx_msg(struct net_device *netdev)
> > +{
> > +     struct es58x_priv *priv = es58x_priv(netdev);
> > +     struct es58x_device *es58x_dev = priv->es58x_dev;
> > +     int i;
> > +     u16 fifo_mask = priv->es58x_dev->param->fifo_mask;
> > +
> > +     if (priv->tx_urb) {
> > +             netdev_warn(netdev, "%s: dropping %d TX messages\n",
> > +                         __func__, priv->tx_can_msg_cnt);
> > +             netdev->stats.tx_dropped += priv->tx_can_msg_cnt;
> > +             for (i = priv->tx_head;
> > +                  i < priv->tx_head + priv->tx_can_msg_cnt; i++)
> > +                     can_free_echo_skb(netdev, i & fifo_mask);
> > +
> > +             usb_anchor_urb(priv->tx_urb, &priv->es58x_dev->tx_urbs_idle);
> > +             atomic_inc(&es58x_dev->tx_urbs_idle_cnt);
> > +             usb_free_urb(priv->tx_urb);
> > +     }
> > +     priv->tx_urb = NULL;
> > +}
> > +
> > +/**
> > + * es58x_tx_ack_msg() - Handle acknowledgment messages.
> > + * @netdev: CAN network device.
> > + * @tx_free_entries: Number of free entries in the device transmit FIFO.
> > + * @rx_cmd_ret_u32: error code as returned by the ES58X device.
> > + *
> > + * ES58X sends an acknowledgment message after a transmission request
> > + * is done. This is mandatory for the ES581.4 but is optional (and
> > + * deactivated in this driver) for the ES58X_FD family.
> > + *
> > + * Under normal circumstances, this function should never throw an
> > + * error message.
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +int es58x_tx_ack_msg(struct net_device *netdev, u16 tx_free_entries,
> > +                  enum es58x_ret_u32 rx_cmd_ret_u32)
> > +{
> > +     struct es58x_priv *priv = es58x_priv(netdev);
> > +
> > +     if (tx_free_entries <= priv->es58x_dev->param->tx_bulk_max) {
> > +             if (net_ratelimit())
> > +                     netdev_err(netdev,
> > +                                "Only %d entries left in device queue, num_echo_skb: %d/%d\n",
> > +                                tx_free_entries,
> > +                                priv->tx_head - priv->tx_tail,
> > +                                priv->can.echo_skb_max);
> > +             netif_stop_queue(netdev);
> > +     }
> > +
> > +     return es58x_rx_cmd_ret_u32(netdev, ES58X_RET_TYPE_TX_MSG,
> > +                                 rx_cmd_ret_u32);
> > +}
> > +
> > +/**
> > + * es58x_rx_can_msg() - Handle a received a CAN message.
> > + * @netdev: CAN network device.
> > + * @timestamp: Hardware time stamp (only relevant in rx branches).
> > + * @data: CAN payload.
> > + * @can_id: CAN ID.
> > + * @es58x_flags: Please refer to enum es58x_flag.
> > + * @dlc: Data Length Code (raw value).
> > + *
> > + * Fill up a CAN skb and post it.
> > + *
> > + * This function handles the case where the DLC of a classical CAN
> > + * frame is greater than CAN_MAX_DLEN (c.f. the len8_dlc field of
> > + * struct can_frame).
> > + *
> > + * Return: zero on success.
> > + */
> > +int es58x_rx_can_msg(struct net_device *netdev, u64 timestamp, const u8 *data,
> > +                  canid_t can_id, enum es58x_flag es58x_flags, u8 dlc)
> > +{
> > +     struct canfd_frame *cfd;
> > +     struct can_frame *ccf;
> > +     struct sk_buff *skb;
> > +     u8 len;
> > +     bool is_can_fd = !!(es58x_flags & ES58X_FLAG_FD_DATA);
> > +
> > +     if (dlc > CAN_MAX_RAW_DLC) {
> > +             netdev_err(netdev,
> > +                        "%s: DLC is %d but maximum should be %d\n",
> > +                        __func__, dlc, CAN_MAX_RAW_DLC);
> > +             return -EMSGSIZE;
> > +     }
> > +
> > +     if (is_can_fd) {
> > +             len = can_fd_dlc2len(dlc);
> > +             skb = alloc_canfd_skb(netdev, &cfd);
> > +     } else {
> > +             len = can_cc_dlc2len(dlc);
> > +             skb = alloc_can_skb(netdev, &ccf);
> > +             cfd = (struct canfd_frame *)ccf;
> > +     }
> > +
> > +     if (!skb) {
> > +             netdev->stats.rx_dropped++;
> > +             return -ENOMEM;
> > +     }
> > +     cfd->can_id = can_id;
> > +     if (es58x_flags & ES58X_FLAG_EFF)
> > +             cfd->can_id |= CAN_EFF_FLAG;
> > +     if (is_can_fd) {
> > +             cfd->len = len;
> > +             if (es58x_flags & ES58X_FLAG_FD_BRS)
> > +                     cfd->flags |= CANFD_BRS;
> > +             if (es58x_flags & ES58X_FLAG_FD_ESI)
> > +                     cfd->flags |= CANFD_ESI;
> > +     } else {
> > +             can_frame_set_cc_len(ccf, dlc, es58x_priv(netdev)->can.ctrlmode);
> > +             if (es58x_flags & ES58X_FLAG_RTR) {
> > +                     ccf->can_id |= CAN_RTR_FLAG;
> > +                     len = 0;
> > +             }
> > +     }
> > +     memcpy(cfd->data, data, len);
> > +     netdev->stats.rx_packets++;
> > +     netdev->stats.rx_bytes += len;
> > +
> > +     es58x_set_skb_timestamp(netdev, skb, timestamp);
> > +     netif_rx(skb);
> > +
> > +     es58x_priv(netdev)->err_passive_before_rtx_success = 0;
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * es58x_rx_err_msg() - Handle a received CAN event or error message.
> > + * @netdev: CAN network device.
> > + * @error: Error code.
> > + * @event: Event code.
> > + * @timestamp: Timestamp received from a ES58X device.
> > + *
> > + * Handle the errors and events received by the ES58X device, create
> > + * a CAN error skb and post it.
> > + *
> > + * In some rare cases the devices might get stucked alternating between
> > + * CAN_STATE_ERROR_PASSIVE and CAN_STATE_ERROR_WARNING. To prevent
> > + * this behavior, we force a bus off state if the device goes in
> > + * CAN_STATE_ERROR_WARNING for ES58X_MAX_CONSECUTIVE_WARN consecutive
> > + * times with no successful transmission or reception in between.
> > + *
> > + * Once the device is in bus off state, the only way to restart it is
> > + * through the drivers/net/can/dev.c:can_restart() function. The
> > + * device is technically capable to recover by itself under certain
> > + * circumstances, however, allowing self recovery would create
> > + * complex race conditions with drivers/net/can/dev.c:can_restart()
> > + * and thus was not implemented. To activate automatic restart, please
> > + * set the restart-ms parameter (e.g. ip link set can0 type can
> > + * restart-ms 100).
> > + *
> > + * If the bus is really instable, this function would try to send a
> > + * lot of log messages. Those are rate limited (i.e. you will see
> > + * messages such as "net_ratelimit: XXX callbacks suppressed" in
> > + * dmesg).
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +int es58x_rx_err_msg(struct net_device *netdev, enum es58x_err error,
> > +                  enum es58x_event event, u64 timestamp)
> > +{
> > +     struct es58x_priv *priv = es58x_priv(netdev);
> > +     struct can_priv *can = netdev_priv(netdev);
> > +     struct can_device_stats *can_stats = &can->can_stats;
> > +     struct can_frame *cf;
> > +     struct sk_buff *skb;
> > +
> > +     if (!netif_running(netdev)) {
> > +             if (net_ratelimit())
> > +                     netdev_info(netdev, "%s: %s is down, dropping packet\n",
> > +                                 __func__, netdev->name);
> > +             netdev->stats.rx_dropped++;
> > +             return 0;
> > +     }
> > +
> > +     if (error == ES58X_ERR_OK && event == ES58X_EVENT_OK) {
> > +             netdev_err(netdev, "%s: Both error and event are zero\n",
> > +                        __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     skb = alloc_can_err_skb(netdev, &cf);
> > +     if (!skb)
> > +             return -ENOMEM;
>
> Please do the stats handling, even if there is no skb.

ACK.

> > +
> > +     switch (error) {
> > +     case ES58X_ERR_OK:      /* 0: No error */
> > +             break;
> > +
> > +     case ES58X_ERR_PROT_STUFF:
>
> I think you can remove the ratelimiting in front of the debug output.

When the bus is really unstable, there can be hundreds of messages per second.
I really prefer to keep it here.

> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Error BITSUFF\n");
> > +             cf->data[2] |= CAN_ERR_PROT_STUFF;
> > +             break;
> > +
> > +     case ES58X_ERR_PROT_FORM:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Error FORMAT\n");
> > +             cf->data[2] |= CAN_ERR_PROT_FORM;
> > +             break;
> > +
> > +     case ES58X_ERR_ACK:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Error ACK\n");
> > +             cf->can_id |= CAN_ERR_ACK;
> > +             break;
> > +
> > +     case ES58X_ERR_PROT_BIT:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Error BIT\n");
> > +             cf->data[2] |= CAN_ERR_PROT_BIT;
> > +             break;
> > +
> > +     case ES58X_ERR_PROT_CRC:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Error CRC\n");
> > +             cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
> > +             break;
> > +
> > +     case ES58X_ERR_PROT_BIT1:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev,
> > +                                "Error: expected a recessive bit but monitored a dominant one\n");
> > +             cf->data[2] |= CAN_ERR_PROT_BIT1;
> > +             break;
> > +
> > +     case ES58X_ERR_PROT_BIT0:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev,
> > +                                "Error expected a dominant bit but monitored a recessive one\n");
> > +             cf->data[2] |= CAN_ERR_PROT_BIT0;
> > +             break;
> > +
> > +     case ES58X_ERR_PROT_OVERLOAD:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Error OVERLOAD\n");
> > +             cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
> > +             break;
> > +
> > +     case ES58X_ERR_PROT_UNSPEC:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Unspecified error\n");
> > +             cf->can_id |= CAN_ERR_PROT;
> > +             break;
> > +
> > +     default:
> > +             if (net_ratelimit())
> > +                     netdev_err(netdev,
> > +                                "%s: Unspecified error code 0x%04X\n",
> > +                                __func__, (int)error);
> > +             cf->can_id |= CAN_ERR_PROT;
> > +             break;
> > +     }
> > +
> > +     switch (event) {
> > +     case ES58X_EVENT_OK:    /* 0: No event */
> > +             break;
> > +
> > +     case ES58X_EVENT_CRTL_ACTIVE:
> > +             if (can->state == CAN_STATE_BUS_OFF) {
> > +                     netdev_err(netdev,
> > +                                "%s: state transition: BUS OFF -> ACTIVE\n",
> > +                                __func__);
>
> Your device should not go autoamtically from bus off to active. Only when it's
> restarted by the kernel (or the user).

Agree, this is why it is an error message.

CAN controllers are allowed to automatically recover under very
specific conditions (c.f. ISO 11898-1, section 10.9.4 "Bus
integration state": "Nodes that are in bus-off state shall
re-enter the bus integration state immediately after detecting
the idle condition if the bus-off recovery condition is not yet
met").

Aside from the idle condition, I do not think that the nodes are
allowed to self-recover.

But because the can_restart() function does not use locks for the
echo_skb[], I treat this scenario by printing an error message and
ignoring it.

> > +             }
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Event CAN BUS ACTIVE\n");
> > +             cf->data[1] |= CAN_ERR_CRTL_ACTIVE;
> > +             can->state = CAN_STATE_ERROR_ACTIVE;
> > +             break;
> > +
> > +     case ES58X_EVENT_CRTL_PASSIVE:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Event CAN BUS PASSIVE\n");
> > +             /* Either TX or RX error count reached passive state
> > +              * but we do not know which. Setting both flags by
> > +              * default.
> > +              */
> > +             cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
> > +             cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
> > +             if (can->state < CAN_STATE_BUS_OFF)
> > +                     can->state = CAN_STATE_ERROR_PASSIVE;
> > +             can_stats->error_passive++;
> > +             if (priv->err_passive_before_rtx_success < U8_MAX)
> > +                     priv->err_passive_before_rtx_success++;
> > +             break;
> > +
> > +     case ES58X_EVENT_CRTL_WARNING:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Event CAN BUS WARNING\n");
> > +             /* Either TX or RX error count reached warning state
> > +              * but we do not know which. Setting both flags by
> > +              * default.
> > +              */
> > +             cf->data[1] |= CAN_ERR_CRTL_RX_WARNING;
> > +             cf->data[1] |= CAN_ERR_CRTL_TX_WARNING;
> > +             if (can->state < CAN_STATE_BUS_OFF)
> > +                     can->state = CAN_STATE_ERROR_WARNING;
> > +             can_stats->error_warning++;
> > +             break;
> > +
> > +     case ES58X_EVENT_BUSOFF:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Event CAN BUS OFF\n");
> > +             netif_stop_queue(netdev);
> > +             if (can->state != CAN_STATE_BUS_OFF) {
> > +                     can->state = CAN_STATE_BUS_OFF;
> > +                     can_bus_off(netdev);
> > +             }
> > +             cf->can_id |= CAN_ERR_BUSOFF;
> > +             can_stats->bus_off++;
> > +             break;
> > +
> > +     case ES58X_EVENT_SINGLE_WIRE:
> > +             if (net_ratelimit())
> > +                     netdev_warn(netdev,
> > +                                 "Lost connection on either CAN high or CAN low\n");
> > +             /* Lost connection on either CAN high or CAN
> > +              * low. Setting both flags by default.
> > +              */
> > +             cf->data[4] |= CAN_ERR_TRX_CANH_NO_WIRE;
> > +             cf->data[4] |= CAN_ERR_TRX_CANL_NO_WIRE;
> > +             break;
> > +
> > +     default:
> > +             if (net_ratelimit())
> > +                     netdev_err(netdev,
> > +                                "%s: Unspecified event code 0x%04X\n",
> > +                                __func__, (int)event);
> > +             cf->can_id |= CAN_ERR_CRTL;
> > +             break;
> > +     }
> > +
> > +     if (cf->data[1])
> > +             cf->can_id |= CAN_ERR_CRTL;
> > +     if (cf->data[2] || cf->data[3]) {
> > +             cf->can_id |= CAN_ERR_PROT;
> > +             can_stats->bus_error++;
> > +     }
> > +     if (cf->data[4])
> > +             cf->can_id |= CAN_ERR_TRX;
> > +
> > +     /* driver/net/can/dev.c:can_restart() takes in account error
> > +      * messages in the RX stats. Doing same here for
> > +      * consistency.
> > +      */
> > +     netdev->stats.rx_packets++;
> > +     netdev->stats.rx_bytes += cf->can_dlc;
> > +
> > +     es58x_set_skb_timestamp(netdev, skb, timestamp);
> > +     netif_rx(skb);
> > +
> > +     if ((event & ES58X_EVENT_CRTL_PASSIVE) &&
> > +         priv->err_passive_before_rtx_success ==
> > +         ES58X_CONSECUTIVE_ERR_PASSIVE_MAX) {
> > +             netdev_info(netdev,
> > +                         "Got %d consecutive warning events with no successful RX or TX. Forcing bus-off\n",
> > +                         priv->err_passive_before_rtx_success);
> > +             return es58x_rx_err_msg(netdev, ES58X_ERR_OK,
> > +                                     ES58X_EVENT_BUSOFF, timestamp);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/* Human readable description of the &enum es58x_cmd_ret_type. */
> > +static const char *const es58x_cmd_ret_desc[] = {
> > +     "Set bittiming",
> > +     "Enable channel",
> > +     "Disable channel",
> > +     "Transmit message",
> > +     "Reset RX",
> > +     "Reset TX",
> > +     "Device error"
> > +};
> > +
> > +/**
> > + * es58x_rx_dev_ret_u8() - Handle return codes received from the
> > + *   ES58X device.
> > + * @dev: Device, only used for the dev_XXX() print functions.
> > + * @cmd_ret_type: Type of the command which triggered the return code.
> > + * @rx_dev_ret_u8: error code as returned by the ES58X device.
> > + *
> > + * Handles the 8 bits return code. Those are specific to the ES581.4
> > + * device. The return value will eventually be used by
> > + * es58x_handle_urb_cmd() function which will take proper actions in
> > + * case of critical issues such and memory errors or bad CRC values.
> > + *
> > + * In contrast with es58x_rx_cmd_ret_u32(), the network device is
> > + * unknown.
> > + *
> > + * Return: zero on success, return errno when any error occurs.
> > + */
> > +int es58x_rx_dev_ret_u8(struct device *dev,
> > +                     enum es58x_ret_type cmd_ret_type,
> > +                     enum es58x_ret_u8 rx_dev_ret_u8)
> > +{
> > +     const char *ret_desc = es58x_cmd_ret_desc[cmd_ret_type];
>
> Can you guarantee not to access es58x_cmd_ret_desc[] out of bounds?

Yes, I guarantee it. The cmd_ret_type does not come directly from
the device but from the glue code in es581_4 or es58x_fd. All the
calls are made with an hardcoded value (which is in bound of
course).

> A safe way to do this is:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c#L94

I like it. I will rewrite it that way :)

> > +
> > +     compiletime_assert(ARRAY_SIZE(es58x_cmd_ret_desc) ==
> > +                        ES58X_RET_TYPE_NUM_ENTRIES,
> > +                        "Size mismatch between es58x_cmd_ret_desc and enum es58x_cmd_ret_type");
> > +
> > +     switch (rx_dev_ret_u8) {
> > +     case ES58X_RET_U8_OK:
> > +             dev_dbg_ratelimited(dev, "%s: OK\n", ret_desc);
> > +             break;
> > +
> > +     case ES58X_RET_U8_ERR_UNSPECIFIED_FAILURE:
> > +             dev_err(dev, "%s: unspecified failure\n", ret_desc);
> > +             break;
> > +
> > +     case ES58X_RET_U8_ERR_NO_MEM:
> > +             dev_err(dev, "%s: device ran out of memory\n", ret_desc);
> > +             return -ENOMEM;
> > +
> > +     case ES58X_RET_U8_ERR_BAD_CRC:
> > +             dev_err(dev, "%s: CRC of previous command is incorrect\n",
> > +                     ret_desc);
> > +             return -EIO;
> > +
> > +     default:
> > +             dev_err(dev, "%s: returned unknown value: 0x%02X\n",
> > +                     ret_desc, rx_dev_ret_u8);
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * es58x_rx_dev_ret_u32() - Handle return codes received from the
> > + *   ES58X device.
> > + * @netdev: CAN network device.
> > + * @cmd_ret_type: Type of the command which triggered the return code.
> > + * @rx_cmd_ret_u32: error code as returned by the ES58X device.
> > + *
> > + * Handles the 32 bits return code. The return value will eventually
> > + * be used by es58x_handle_urb_cmd() function which will take proper
> > + * actions in case of critical issues such and memory errors or bad
> > + * CRC values.
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +int es58x_rx_cmd_ret_u32(struct net_device *netdev,
> > +                      enum es58x_ret_type cmd_ret_type,
> > +                      enum es58x_ret_u32 rx_cmd_ret_u32)
> > +{
> > +     struct es58x_priv *priv = es58x_priv(netdev);
> > +     const char *ret_desc = es58x_cmd_ret_desc[cmd_ret_type];
>
> same here

ACK.

> > +
> > +     switch (rx_cmd_ret_u32) {
> > +     case ES58X_RET_U32_OK:
> > +             switch (cmd_ret_type) {
> > +             case ES58X_RET_TYPE_ENABLE_CHANNEL:
> > +                     es58x_flush_pending_tx_msg(netdev);
> > +                     es58x_can_flush_echo_skb(netdev);
> > +                     priv->err_passive_before_rtx_success = 0;
> > +                     priv->can.state = CAN_STATE_ERROR_ACTIVE;
> > +                     netif_wake_queue(netdev);
> > +                     netdev_info(netdev,
> > +                                 "%s (Serial Number %s): CAN%d channel becomes ready\n",
> > +                                 priv->es58x_dev->udev->product,
> > +                                 priv->es58x_dev->udev->serial,
> > +                                 priv->channel_idx + 1);
> > +                     break;
> > +
> > +             case ES58X_RET_TYPE_TX_MSG:
> > +#ifdef VERBOSE_DEBUG
>
> Does this compile without the ifdef?

Yes, I will remove the #ifdef.

> > +                     if (net_ratelimit())
> > +                             netdev_vdbg(netdev, "%s: OK\n", ret_desc);
> > +#endif
> > +                     break;
> > +
> > +             default:
> > +                     netdev_dbg(netdev, "%s: OK\n", ret_desc);
> > +                     break;
> > +             }
> > +             break;
> > +
> > +     case ES58X_RET_U32_ERR_UNSPECIFIED_FAILURE:
> > +             if (cmd_ret_type == ES58X_RET_TYPE_DISABLE_CHANNEL)
> > +                     netdev_dbg(netdev,
> > +                                "%s: channel is already closed\n", ret_desc);
> > +             else
> > +                     netdev_err(netdev,
> > +                                "%s: unspecified failure\n", ret_desc);
> > +             break;
> > +
> > +     case ES58X_RET_U32_ERR_NO_MEM:
> > +             netdev_err(netdev, "%s: device ran out of memory\n", ret_desc);
> > +             return -ENOMEM;
> > +
> > +     case ES58X_RET_U32_WARN_PARAM_ADJUSTED:
> > +             netdev_warn(netdev,
> > +                         "%s: some incompatible parameters have been adjusted\n",
> > +                         ret_desc);
> > +             break;
> > +
> > +     case ES58X_RET_U32_WARN_TX_MAYBE_REORDER:
> > +             netdev_warn(netdev,
> > +                         "%s: TX messages might have been reordered\n",
> > +                         ret_desc);
> > +             break;
> > +
> > +     case ES58X_RET_U32_ERR_TIMEOUT:
> > +             netdev_err(netdev, "%s: command timed out\n", ret_desc);
> > +             break;
> > +
> > +     case ES58X_RET_U32_ERR_FIFO_FULL:
> > +             netdev_warn(netdev, "%s: fifo is full\n", ret_desc);
> > +             break;
> > +
> > +     case ES58X_RET_U32_ERR_BAD_CONFIG:
> > +             netdev_err(netdev, "%s: bad configuration\n", ret_desc);
> > +             return -EINVAL;
> > +
> > +     case ES58X_RET_U32_ERR_NO_RESOURCE:
> > +             netdev_err(netdev, "%s: no resource available\n", ret_desc);
> > +             break;
> > +
> > +     default:
> > +             netdev_err(netdev, "%s returned unknown value: 0x%08X\n",
> > +                        ret_desc, rx_cmd_ret_u32);
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> I'll review the rest later.

Thanks a lot!


Yours sincerely,
Vincent
