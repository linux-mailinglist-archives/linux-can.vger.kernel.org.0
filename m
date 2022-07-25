Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B49A5800E4
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 16:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiGYOlf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiGYOlb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 10:41:31 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A501837D
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 07:41:29 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31f1b271dcbso21290957b3.10
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 07:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCLMTH0lqcGUy86z1lfPBGHz4ECkOwcjsjXvwZQXcN8=;
        b=0rOEhRr5AQkk4nNTY8xnibbUH4TrGVLhO7cAEEG5bDo/ey7/Ttf9gG5v5RA9MHGzf0
         gwOmfLsiDerQn9JHGQLzCG3F1DB/XFagOFhtjsSTQ/V84CAOsqWgM6Y7ojZURRLV8VJS
         ueqvYv2y+Wr7C8VRVLpmQESkfBCAG3RMzfSHTdCh2s2ZtQgU6v41+l1J9uyhMCgtdcw7
         gi09kz0BC0PBUtuVg3xlSP4fM9ziM3/N11euO1BRgswWEfyC9rjwWe+57w24krg3LLPn
         C+E6VsGc1MuUV4h2ABOd1IK9oOy/2Wsf2qdNOOxtk2zsNqTBlb/+U0SiKTlQIiyNfjm1
         NIjw==
X-Gm-Message-State: AJIora/PKVqg83Hd36IuhikmM/qvayxLUpbQq00ZzVdXxMvAmuS9Z0Z1
        muTyuUVV1RI/zW4focXge4R380g9oUi/XMLMDNyhB8N3ykSWXA==
X-Google-Smtp-Source: AGRyM1sUAecefBig7HlBUz4WTuiDhV0LKw5COxsXEwIRTJfXx1h9FaNPZi50VhBIy2UUQ+ujehs5bg2kuss/A6zi7/Y=
X-Received: by 2002:a0d:fe44:0:b0:31f:1b47:9e6f with SMTP id
 o65-20020a0dfe44000000b0031f1b479e6fmr2777742ywf.392.1658760088755; Mon, 25
 Jul 2022 07:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725133208.432176-19-mailhol.vincent@wanadoo.fr> <20220725142215.ww7hktoizjgskkpl@pengutronix.de>
In-Reply-To: <20220725142215.ww7hktoizjgskkpl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 25 Jul 2022 23:41:17 +0900
Message-ID: <CAMZ6Rq+YVgX72Aj2WDRx4nkOg9BRE7XyCSOo0pPBdhb3jDMtZA@mail.gmail.com>
Subject: Re: [PATCH v1 18/24] can: dev: add generic function can_eth_ioctl_hwts()
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 25 juil. 2022 at 23:31, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 25.07.2022 22:32:02, Vincent Mailhol wrote:
> > Tools based on libpcap (such as tcpdump) expect the SIOCSHWTSTAMP
> > ioctl call to be supported. This is also specified in the kernel doc
> > [1]. The purpose of this ioctl is to toggle the hardware timestamps.
> >
> > Currently, CAN devices which support hardware timestamping have those
> > always activated. can_eth_ioctl_hwts() is a dumb function that will
> > always succeed when requested to set tx_type to HWTSTAMP_TX_ON or
> > rx_filter to HWTSTAMP_FILTER_ALL.
> >
> > [1] Kernel doc: Timestamping, section 3.1 "Hardware Timestamping
> > Implementation: Device Drivers"
> > Link: https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-implementation-device-drivers
> >
> > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > ---
> >  drivers/net/can/dev/dev.c | 29 +++++++++++++++++++++++++++++
> >  include/linux/can/dev.h   |  1 +
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> > index 7ad56d31cec9..750dc7cae9d4 100644
> > --- a/drivers/net/can/dev/dev.c
> > +++ b/drivers/net/can/dev/dev.c
> > @@ -322,6 +322,35 @@ int can_change_mtu(struct net_device *dev, int new_mtu)
> >  }
> >  EXPORT_SYMBOL_GPL(can_change_mtu);
> >
> > +/* generic implementation of netdev_ops::ndo_eth_ioctl for CAN devices
> > + * supporting hardware RX timestamps
> > + */
> > +int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd)
> > +{
> > +     struct hwtstamp_config hwts_cfg = { 0 };
> > +
> > +     switch (cmd) {
> > +     case SIOCSHWTSTAMP: /* set */
> > +             if (copy_from_user(&hwts_cfg, ifr->ifr_data, sizeof(hwts_cfg)))
> > +                     return -EFAULT;
> > +             if (hwts_cfg.tx_type == HWTSTAMP_TX_ON &&
> > +                 hwts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
> > +                     return 0;
>
> I have a WIP hwts patch series for the mcp251xfd. IIRC the driver is
> allowed to add RX timestamps to more packages than requested without
> failing, so the relevant code my WIP patches looks like this:
>
> +       switch (config.tx_type) {
> +       case HWTSTAMP_TX_OFF:
> +               break;
> +       default:
> +               return -ERANGE;
> +       }
> +
> +       switch (config.rx_filter) {
> +       case HWTSTAMP_FILTER_NONE:
> +               clear_bit(MCP251XFD_FLAGS_TIMESTAMP_RX, priv->flags);
> +               break;
> +       default:
> +               set_bit(MCP251XFD_FLAGS_TIMESTAMP_RX, priv->flags);
> +               config.rx_filter = HWTSTAMP_FILTER_ALL;
> +       }

What is the default value for rx_filter? Currently, candump -H
implicitly expects rx_filter to be HWTSTAMP_FILTER_ALL. Defaulting to
HWTSTAMP_FILTER_NONE would break the current versions of candump. so I
was wondering if it would be better for CAN to start with hardware
timestamps as active (in my series, I assume that HWTSTAMP_FILTER_NONE
is not supported and thus avoid this problem).

Moving forward, should I keep mcp251xfd in this series or should I
remove it and let you take care of it?


Yours sincerely,
Vincent Mailhol
