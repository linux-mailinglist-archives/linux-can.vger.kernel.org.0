Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74E3352929
	for <lists+linux-can@lfdr.de>; Fri,  2 Apr 2021 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhDBJ4r (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Apr 2021 05:56:47 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:36419 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBJ4q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Apr 2021 05:56:46 -0400
Received: by mail-yb1-f177.google.com with SMTP id w8so4637588ybt.3
        for <linux-can@vger.kernel.org>; Fri, 02 Apr 2021 02:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dFFk2OqSokELL84drYGWUwnL5RAkbZ4BDvwRuHU0nc=;
        b=tbu0eMuLFLfrqAxaygh3dirjYGa4uYADKn4Y1szy8s+mHdFTpusYV6T7NhJ+4ToOGM
         9BsFdGKgrlLwy5OhwSR+kwrtC6vAp9d2Z0ucmrtJdjL6l4RZo3DkjLe3yhf4be6XHVHg
         F49AH9po6tkLVzxddYMAPuUpIXE2L0WyhqnKM2530mm4ce6rXxjPGRB8d4tnQZck+4QI
         pOmfdwon/38MyJXowqdi3ryxL6ZSbJz/pvlHp65PUaQ8yB3fOE+blYnX5Ln1qTLiJ3n3
         mfQm4sm0VYP3YclDDIr6jiY1JO7j8j8/wlg3xHc9W+vnhrndX1WbY0myOg79ZJFX3ofY
         5Ntg==
X-Gm-Message-State: AOAM531p5IcX9J2QscuRDyBjIGGBdj4vyBsvJ4+uBHQ+yhpy3DOv4BsL
        dRZs48J0s9CBJm/UEDA3pLOOTS0RpMGfdH0AJQo=
X-Google-Smtp-Source: ABdhPJz6QkbNIclPaJCGQTWNrlKFSoiyNVyJDLPCpJaSBOuWtEzBVmLJVeS09/ml8n855x1ilIW2AK7vlF8IoLRRsv8=
X-Received: by 2002:a25:7a02:: with SMTP id v2mr16941417ybc.514.1617357404913;
 Fri, 02 Apr 2021 02:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210321104103.213308-1-mailhol.vincent@wanadoo.fr>
 <20210321104103.213308-2-mailhol.vincent@wanadoo.fr> <20210329123636.5xrgzdxyt54y7coe@pengutronix.de>
In-Reply-To: <20210329123636.5xrgzdxyt54y7coe@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 2 Apr 2021 18:56:33 +0900
Message-ID: <CAMZ6RqKeEoNGN0iZUfEG8x=FMHu4d2ZE=0QPiOxSXTrXFjg9rg@mail.gmail.com>
Subject: Re: [PATCH v14 1/4] can: etas_es58x: add core support for ETAS ES58X
 CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Mon. 29 Mar 2021 at 21:36, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 21.03.2021 19:41:00, Vincent Mailhol wrote:
> > This patch adds the core support for various USB CAN interfaces from
> > ETAS GmbH (https://www.etas.com/en/products/es58x.php). The next
> > patches add the glue code drivers for the individual interfaces.
> >
> > Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> [...]
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
> > + * In some rare cases the devices might get stuck alternating between
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
>
> = NULL;
>
> So that the if (cf) properly works...

I actually expected cfto be set to NULL when an error
occurred (same as skb).

But indeed, cf is not initialised if the allocation fails. I was
wondering if it would not be better to make both alloc_can_skb()
and and alloc_canfd_skb() set cf to NULL. That would remove a
pitfall.

If you like the idea, I can submit a patch.

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
> > +
> > +     switch (error) {
> > +     case ES58X_ERR_OK:      /* 0: No error */
> > +             break;
> > +
> > +     case ES58X_ERR_PROT_STUFF:
> > +             if (net_ratelimit())
> > +                     netdev_dbg(netdev, "Error BITSUFF\n");
> > +             if (cf)
>
> ..like here.

ACK.

> > +                     cf->data[2] |= CAN_ERR_PROT_STUFF;
> > +             break;
>
> [...]
>
> > +/**
> > + * es58x_flush_cmd_buf() - Reset the buffer for URB commands.
> > + * @es58x_dev: ES58X device.
> > + */
> > +static void es58x_flush_cmd_buf(struct es58x_device *es58x_dev)
> > +{
> > +     memset(&es58x_dev->rx_cmd_buf, 0, es58x_dev->param->rx_urb_cmd_max_len);
>
> I think you can skip the memset, as you're overwriting the data anyways
> and account the valid length.

The idea was that this buffer might contain confidential
data (e.g. an UDS seed and key pair or a VIN) so I cleared it out
of precaution.

I recognize that this is useless as an attacker can just retrieve
the information from a candump, no need to look into some kernel
temporary buffer for that...

I will remove it.

> > +     es58x_dev->rx_cmd_buf_len = 0;
> > +}
> > +
>
> [...]
>
> > +/**
> > + * es58x_split_urb() - Cut the received URB in individual URB commands.
> > + * @es58x_dev: ES58X device.
> > + * @urb: last urb buffer received.
> > + *
> > + * The device might send urb in bulk format (i.e. several URB commands
> > + * concatenated together). This function will split all the commands
> > + * contained in the urb.
> > + *
> > + * Return:
> > + * number of bytes consumed from @urb if successful.
> > + *
> > + * -ENODATA if the URB command is still incomplete.
> > + *
> > + * -EBADMSG if the URB command is incorrect.
> > + */
> > +static signed int es58x_split_urb(struct es58x_device *es58x_dev,
> > +                               struct urb *urb)
> > +{
> > +     const u8 es58x_is_alive = 0x11;
>
> We usually use #defines for this

ACK.

> > +     union es58x_urb_cmd *urb_cmd;
> > +     u8 *raw_cmd = urb->transfer_buffer;
> > +     ssize_t raw_cmd_len = urb->actual_length;
>
> urb->actual_length is an u32

Below, I test that (raw_cmd_len > 0) in a while loop. I want to
make this variable signed to avoid an infinite loop in case of an
off by one error (which should not occur, see this as a safety
net).

I will make this a s32.

Also, the size is represented by a u16 on the device so s32 is
more than enough.

> > +     int ret;
> > +
> > +     if (es58x_dev->rx_cmd_buf_len != 0) {
> > +             ret = es58x_handle_incomplete_cmd(es58x_dev, urb);
> > +             if (ret != -ENODATA)
> > +                     es58x_flush_cmd_buf(es58x_dev);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             raw_cmd += ret;
> > +             raw_cmd_len -= ret;
> > +     }
> > +
> > +     while (raw_cmd_len > 0) {
> > +             if (raw_cmd[0] == es58x_is_alive) {
> > +                     raw_cmd++;
> > +                     raw_cmd_len--;
> > +                     continue;
> > +             }
> > +             urb_cmd = (union es58x_urb_cmd *)raw_cmd;
> > +             ret = es58x_check_rx_urb(es58x_dev, urb_cmd, raw_cmd_len);
> > +             if (ret > 0) {
>
> Here the length field in the usb_cmd is valid, it lies within the total
> length of the rx'ed urb.
>
> > +                     es58x_handle_urb_cmd(es58x_dev, urb_cmd);
>
> As far as I see you're checking in ops->handle_urb_cmd() if the
> urb_cmd's length is long enough for the command that's currently
> processed, right?

The check of the urb_cmd's length occurs in es58x_check_rx_urb():
    if (urb_cmd_len > param->rx_urb_cmd_max_len) {
In that same function, I then check that urb_cmd's length is long enough:
    } else if (urb_actual_len < urb_cmd_len) {
If it is not long enough, the not-yet-consumed data of the urb
is buffered and once a new urb comes up, those are concatenated.

After that, ops->handle_urb_cmd() will dispatch the command
depending on the cmd_id and additional checks will be done on the
size of the payload.

> > +             } else if (ret == -ENODATA) {
> > +                     es58x_copy_to_cmd_buf(es58x_dev, raw_cmd, raw_cmd_len);
> > +                     return -ENODATA;
> > +             } else if (ret < 0) {
> > +                     ret = es58x_split_urb_try_recovery(es58x_dev, raw_cmd,
> > +                                                        raw_cmd_len);
> > +                     if (ret < 0)
> > +                             return ret;
> > +             }
> > +             raw_cmd += ret;
> > +             raw_cmd_len -= ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
>
> [...]
>
> > +/**
> > + * es58x_open() - Open and start network device.
> > + * @netdev: CAN network device.
> > + *
> > + * Called when the network transitions to the up state.
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +static int es58x_open(struct net_device *netdev)
> > +{
> > +     int ret;
> > +
> > +     ret = open_candev(netdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = es58x_enable_channel(netdev);
> > +     if (ret)
> > +             return ret;
>
> Please do an as complete as possible reset and configuration during
> open(). If there is any error a ifdown/ifup should fix it. Here on a USB
> device with multiple interfaces it's not as easy as on devices with only
> one CAN interface.

ACK.

I will use a function as below to check if all interfaces are
down.

static bool es58x_are_all_channels_closed(struct es58x_device *es58x_dev)
{
    int i;

    for (i = 0; i < es58x_dev->num_can_ch; i++) {
        struct can_priv *can_priv = netdev_priv(es58x_dev->netdev[i]);
        if (can_priv->state != CAN_STATE_STOPPED)
            return false;
    }
    return true;
}

I will modify both es58x_open() and es58x_close().

> > +
> > +     netif_start_queue(netdev);
> > +
> > +     return ret;
> > +}
>
> [...]
>
> > +/**
> > + * es58x_start_xmit() - Transmit an skb.
> > + * @skb: socket buffer of a CAN message.
> > + * @netdev: CAN network device.
> > + *
> > + * Called when a packet needs to be transmitted.
> > + *
> > + * This function relies on Byte Queue Limits (BQL). The main benefit
> > + * it to increase the throughput by allowing bulk transfers
> > + * (c.f. xmit_more flag).
> > + *
> > + * Queues up to tx_bulk_max messages in &tx_urb buffer and does
> > + * a bulk send of all messages in one single URB.
> > + *
> > + * Return:
> > + * NETDEV_TX_OK if we could manage the @skb (either transmit it or
> > + * drop it)
> > + *
> > + * NETDEV_TX_BUSY if the device is busy (this is a bug, the network
> > + * device stop/wake management should prevent this return code to
> > + * occur).
> > + */
> > +static netdev_tx_t es58x_start_xmit(struct sk_buff *skb,
> > +                                 struct net_device *netdev)
> > +{
> > +     struct es58x_priv *priv = es58x_priv(netdev);
> > +     struct es58x_device *es58x_dev = priv->es58x_dev;
> > +     unsigned int packet_idx, frame_len;
> > +     int ret;
> > +
> > +     if (can_dropped_invalid_skb(netdev, skb)) {
> > +             if (priv->tx_urb)
> > +                     goto xmit_commit;
> > +             return NETDEV_TX_OK;
> > +     }
> > +
> > +     if (!priv->tx_urb) {
> > +             priv->tx_urb = es58x_get_tx_urb(es58x_dev);
> > +             if (!priv->tx_urb) {
> > +                     ret = -ENOMEM;
> > +                     goto drop_skb;
> > +             }
> > +             memset(priv->tx_urb->transfer_buffer, 0,
> > +                    es58x_dev->param->tx_urb_cmd_max_len);
>
> Is this memset() needed?

In current state, it is, but a small modification should be
enough to have it removed.

> > +             priv->tx_urb->transfer_buffer_length =
> > +                 es58x_dev->param->urb_cmd_header_len;
> > +             priv->tx_can_msg_cnt = 0;
> > +             priv->tx_can_msg_is_fd = can_is_canfd_skb(skb);
> > +     } else if (priv->tx_can_msg_is_fd != can_is_canfd_skb(skb)) {
> > +             /* Can not do bulk send with mixed CAN and CAN FD frames. */
> > +             ret = es58x_xmit_commit(netdev);
> > +             if (ret)
> > +                     goto drop_skb;
> > +             return es58x_start_xmit(skb, netdev);
>
> In the kernel the stack is limited, does it make sense to re-arrange
> this to avoid recursion?

This is a tail recursion so with the good optimisation, it will
not increase the stack. And also, the recursive call occurs one
time max. So I thought it was acceptable.

Regardless, rearranging the code is trivial, so I will remove
this recursion.

> > +     }
> > +
> > +     ret = es58x_dev->ops->tx_can_msg(priv, skb);
> > +     if (ret)
> > +             goto drop_skb;
> > +
> > +     frame_len = can_skb_get_frame_len(skb);
> > +     netdev_sent_queue(netdev, frame_len);
> > +     packet_idx = priv->tx_head + priv->tx_can_msg_cnt;
> > +     ret = can_put_echo_skb(skb, netdev,
> > +                            packet_idx & es58x_dev->param->fifo_mask,
> > +                            frame_len);
> > +     if (ret)
> > +             goto xmit_failure;
>
> In case can_put_echo_skb() fails, there will be no echo skb, so your
> cleanup will miss the last skb put into netdev_sent_queue(). I think its
> best to move the netdev_sent_queue() after the can_put_echo_skb().

ACK.

> > +
> > +     priv->tx_can_msg_cnt++;
> > +
> > + xmit_commit:
> > +     if (!es58x_xmit_more(priv)) {
> > +             ret = es58x_xmit_commit(netdev);
> > +             if (ret)
> > +                     goto xmit_failure;
> > +     }
> > +
> > +     return NETDEV_TX_OK;
> > +
> > + drop_skb:
> > +     dev_kfree_skb(skb);
> > +     netdev->stats.tx_dropped++;
> > + xmit_failure:
> > +     netdev->stats.tx_errors++;
> > +     es58x_flush_pending_tx_msg(netdev);
> > +     netdev_warn(netdev, "%s: send message failure: %pe\n",
> > +                 __func__, ERR_PTR(ret));
> > +     return NETDEV_TX_OK;
> > +}
> > +
> > +static const struct net_device_ops es58x_netdev_ops = {
> > +     .ndo_open = es58x_open,
> > +     .ndo_stop = es58x_stop,
> > +     .ndo_start_xmit = es58x_start_xmit
> > +};
> > +
> > +/**
> > + * es58x_set_bittiming() - Configure all the nominal bit timing
> > + *   parameters.
> > + * @netdev: CAN network device.
> > + *
> > + * Only relevant for ES581.4 (the ES58X FD family sets the bittiming
> > + * parameters at the same time as the channel gets enabled).
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +static int es58x_set_bittiming(struct net_device *netdev)
>
> There's no need to implement this callback, you can configure the
> bitiming during open().

ACK. Will remove both es58x_set_bittiming() and
es58x_set_data_bittiming().

> > +{
> > +     struct es58x_priv *priv = es58x_priv(netdev);
> > +     struct es58x_device *es58x_dev = priv->es58x_dev;
> > +     int ret;
> > +
> > +     /* Make sure that channel is closed before sending configuration. */
> > +     ret = es58x_dev->ops->disable_channel(priv);
> > +     if (ret)
> > +             netdev_err(netdev, "%s: Could not disable the channel: %pe\n",
> > +                        __func__, ERR_PTR(ret));
> > +     ret = es58x_dev->ops->set_bittiming(priv);
> > +     if (ret)
> > +             netdev_err(netdev, "%s: Could not set bittiming: %pe\n",
> > +                        __func__, ERR_PTR(ret));
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * es58x_set_data_bittiming() - Configure all the data bit timing parameters.
> > + * @netdev: CAN network device.
> > + *
> > + * Dummy function: ES58X FD family sets the bittiming
> > + * parameters at the same time as the channel gets enabled.
> > + *
> > + * Return: zero.
> > + */
> > +static int es58x_set_data_bittiming(struct net_device *netdev)
> > +{
>
> no need to implement a no-op here.

ACK.

> > +     return 0;
> > +}
> > +
>
> [...]
>
> > +/**
> > + * es58x_set_mode() - Change network device mode.
> > + * @netdev: CAN network device.
> > + * @mode: either %CAN_MODE_START, %CAN_MODE_STOP or %CAN_MODE_SLEEP
> > + *
> > + * This function is used by drivers/net/can/dev.c:can_restart() to
> > + * recover from a bus off state. Thus only the only value expected for
> > + * @mode is %CAN_MODE_START. None the less, other modes were
> > + * implemented as well.
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +static int es58x_set_mode(struct net_device *netdev, enum can_mode mode)
> > +{
> > +     struct can_priv *can = netdev_priv(netdev);
> > +
> > +     switch (mode) {
> > +     case CAN_MODE_START:
> > +             switch (can->state) {
> > +             case CAN_STATE_BUS_OFF:
> > +                     return es58x_reset(netdev);
>
> If you shutdown the channel in case of a bus off, this get easier. See
> bittiming comments below, too.

Noted. I will disable the channel in es58x_rx_err_msg() when an error occurs.
With this, I will also remove es58x_reset() which will not be needed anymore.

> > +
> > +             case CAN_STATE_STOPPED:
> > +             case CAN_STATE_SLEEPING:
> > +                     netif_wake_queue(netdev);
> > +                     can->state = CAN_STATE_ERROR_ACTIVE;
> > +                     return 0;
> > +
> > +             case CAN_STATE_ERROR_ACTIVE:
> > +             case CAN_STATE_ERROR_WARNING:
> > +             case CAN_STATE_ERROR_PASSIVE:
> > +             default:
> > +                     return 0;
> > +             }
> > +
> > +     case CAN_MODE_STOP:
> > +     case CAN_MODE_SLEEP:
> > +             netif_stop_queue(netdev);
> > +             if (mode == CAN_MODE_STOP)
> > +                     can->state = CAN_STATE_STOPPED;
> > +             else
> > +                     can->state = CAN_STATE_SLEEPING;
> > +             return 0;
> > +
> > +     default:
> > +             netdev_err(netdev, "%s: Invalid can_mode value: %d\n",
> > +                        __func__, mode);
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +/**
> > + * es58x_init_priv() - Initialize private parameters.
> > + * @es58x_dev: ES58X device.
> > + * @priv: ES58X private parameters related to the network device.
> > + * @channel_idx: Index of the network device.
> > + */
> > +static void es58x_init_priv(struct es58x_device *es58x_dev,
> > +                         struct es58x_priv *priv, int channel_idx)
> > +{
> > +     const struct es58x_parameters *param = es58x_dev->param;
> > +     struct can_priv *can = &priv->can;
> > +
> > +     priv->es58x_dev = es58x_dev;
> > +     priv->channel_idx = channel_idx;
> > +     priv->tx_urb = NULL;
> > +     priv->tx_can_msg_cnt = 0;
> > +
> > +     can->bittiming_const = param->bittiming_const;
> > +     can->do_set_bittiming = es58x_set_bittiming;
>
> Can you keep the channels and/or devices disabled while the interface(s)
> are down? You don't need to implement this callback, it's sufficient to
> set the bittiming during the ndo_open() callback.

ACK.

> > +     if (param->ctrlmode_supported & CAN_CTRLMODE_FD) {
> > +             can->data_bittiming_const = param->data_bittiming_const;
> > +             can->tdc_const = param->tdc_const;
> > +             can->do_set_data_bittiming = es58x_set_data_bittiming;
>
> no need to provide this callback.

ACK.

> > +     }
> > +     can->bitrate_max = param->bitrate_max;
> > +     can->clock = param->clock;
> > +     can->state = CAN_STATE_STOPPED;
> > +     can->ctrlmode_supported = param->ctrlmode_supported;
> > +     can->do_set_mode = es58x_set_mode;
> > +}
> > +
> > +/**
> > + * es58x_init_netdev() - Initialize the network device.
> > + * @es58x_dev: ES58X device.
> > + * @channel_idx: Index of the network device.
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +static int es58x_init_netdev(struct es58x_device *es58x_dev, int channel_idx)
> > +{
> > +     struct net_device *netdev;
> > +     struct device *dev = es58x_dev->dev;
> > +     int ret;
> > +
> > +     netdev = alloc_candev(sizeof(struct es58x_priv),
> > +                           es58x_dev->param->fifo_mask + 1);
> > +     if (!netdev) {
> > +             dev_err(dev, "Could not allocate candev\n");
> > +             return -ENOMEM;
> > +     }
> > +     SET_NETDEV_DEV(netdev, dev);
> > +     es58x_dev->netdev[channel_idx] = netdev;
> > +     es58x_init_priv(es58x_dev, es58x_priv(netdev), channel_idx);
> > +
> > +     netdev->netdev_ops = &es58x_netdev_ops;
> > +     netdev->flags |= IFF_ECHO;      /* We support local echo */
> > +
> > +     ret = register_candev(netdev);
> > +     if (ret)
> > +             return ret;
> > +     netdev_dbg(netdev, "%s: Registered channel %s\n",
> > +                es58x_dev->udev->product, netdev->name);
>
> In this function and in the following ones there are a lot of
> netdev_dbg(), please have a look if you can remove some of those.

ACK, I will make the driver less verbose in debug mode.

> [...]
>
> > +/**
> > + * struct es58x_priv - All information specific to a CAN channel.
> > + * @can: struct can_priv must be the first member (Socket CAN relies
> > + *   on the fact that function netdev_priv() returns a pointer to
> > + *   a struct can_priv).
> > + * @es58x_dev: pointer to the corresponding ES58X device.
> > + * @tx_urb: Used as a buffer to concatenate the TX messages and to do
> > + *   a bulk send. Please refer to es58x_start_xmit() for more
> > + *   details.
> > + * @tx_tail: Index of the oldest packet still pending for
> > + *   completion. @tx_tail & echo_skb_mask represents the beginning
> > + *   of the echo skb FIFO, i.e. index of the first element.
> > + * @tx_head: Index of the next packet to be sent to the
> > + *   device. @tx_head & echo_skb_mask represents the end of the
> > + *   echo skb FIFO plus one, i.e. the first free index.
>
> Is this the description 100% correct? In xmit() you're using tx_head +
> tx_can_msg_cnt to address the next packet to be send.
>
> >> +    packet_idx = priv->tx_head + priv->tx_can_msg_cnt;
>
> But in xmit_more() you're not taking tx_can_msg_cnt into account.

The idea was that in es58x_start_xmit() and es58x_xmit_more(),
the changes were not yet committed and thus tx_head not yet
updated.

After a bit more thinking, it seems better to directly update
tx_head each time a packet is queued in can_echo_skb[]. I will
keep above description and modify the code.

> > + * @tx_can_msg_cnt: Number of messages in @tx_urb.
> > + * @tx_can_msg_is_fd: false: all messages in @tx_urb are Classical
> > + *   CAN, true: all messages in @tx_urb are CAN FD. Rationale:
> > + *   ES58X FD devices do not allow to mix Classical CAN and FD CAN
> > + *   frames in one single bulk transmission.
> > + * @err_passive_before_rtx_success: The ES58X device might enter in a
> > + *   state in which it keeps alternating between error passive
> > + *   and active states. This counter keeps track of the number of
> > + *   error passive and if it gets bigger than
> > + *   ES58X_CONSECUTIVE_ERR_PASSIVE_MAX, es58x_rx_err_msg() will
> > + *   force the status to bus-off.
> > + * @channel_idx: Channel index, starts at zero.
> > + */
> > +struct es58x_priv {
> > +     struct can_priv can;
> > +     struct es58x_device *es58x_dev;
> > +     struct urb *tx_urb;
> > +
> > +     u32 tx_tail;
> > +     u32 tx_head;
> > +
> > +     u8 tx_can_msg_cnt;
> > +     bool tx_can_msg_is_fd;
> > +
> > +     u8 err_passive_before_rtx_success;
> > +
> > +     u8 channel_idx;
> > +};

Yours sincerely,
Vincent
