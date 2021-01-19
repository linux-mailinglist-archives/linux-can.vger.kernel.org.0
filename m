Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910D02FBDA4
	for <lists+linux-can@lfdr.de>; Tue, 19 Jan 2021 18:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbhASRa0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jan 2021 12:30:26 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:34011 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390732AbhASRIt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jan 2021 12:08:49 -0500
Received: by mail-yb1-f173.google.com with SMTP id x6so16678730ybr.1
        for <linux-can@vger.kernel.org>; Tue, 19 Jan 2021 09:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/amjSCxiEdzeoXIElkPEVr9qS0tkOIHBvyzNNOuPGk=;
        b=S8ZYm22fKZrt/yU1061f2cENslHZ4LnLlBBJub8oUCG0Ysj5hXmNEyxPydoAztvnvI
         i17CNupunBcU065q2fX4htc+wyTFFMuB2iX799T+OX3ZBJ01hrkNaInibR8v15hD5heZ
         EYjsdQC5z5ySNgNpDw7/P55HQqIQyB01/HoS5jCzmKdrKY0giBlPTrth4G3xWxfWzFwq
         he+CMaQD3QQmUeUWkmuVQs85iP8N0huIRal0yU16hJNJWNzRrjZYUnGXuk75Z8ITqvQ1
         Ub6JPxmnU/SnDx7c4i1XHZ1fbxj2xf4PV6yNMI3Actnoq+NI1Fiy5GSmZjWhQ6esvOax
         BPxw==
X-Gm-Message-State: AOAM530bkwDRtWE3EXGlGVF01SR7R1UkUMKibOCZ8oWxHm05rHL9b32o
        +u4ubTi3tehisf1E8kEzC/h8RpzTafHR9mnMvVc=
X-Google-Smtp-Source: ABdhPJzLx+zZNIvh4wCFnAs7nDqUtT18BqSutvcx8HCsYUlUwHsZRd7lfBmu46RiWllWlASc/thDR7hy5GKAaQtPipI=
X-Received: by 2002:a25:3858:: with SMTP id f85mr1780177yba.125.1611076082904;
 Tue, 19 Jan 2021 09:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20210119162512.5236-1-mailhol.vincent@wanadoo.fr> <20210119162512.5236-3-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20210119162512.5236-3-mailhol.vincent@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 20 Jan 2021 02:07:52 +0900
Message-ID: <CAMZ6RqJb=y9E3tmT+kPwAB1cYyDE2v4e5iMaoB_J17U-W+WB3w@mail.gmail.com>
Subject: Re: [PATCH 2/3] can: vxcan: vxcan_xmit: fix use after free bug
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Loris Fauster <loris.fauster@ttcontrol.com>,
        Alejandro Concepcion Rodriguez <alejandro@acoro.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 20 Jan 2021 at 01:25, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> After calling netif_rx_ni(skb), dereferencing skb is unsafe.
> Especially, the canfd_frame cfd which aliases skb memory is accessed
> after the netif_rx_ni().
>
> fixes: a8f820a380a2 ("can: add Virtual CAN Tunnel driver (vxcan)")
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>  drivers/net/can/vxcan.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index fa47bab510bb..a525ef8d19b0 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -39,6 +39,7 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
>         struct net_device *peer;
>         struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>         struct net_device_stats *peerstats, *srcstats = &dev->stats;
> +       u8 len;
>
>         if (can_dropped_invalid_skb(dev, skb))
>                 return NETDEV_TX_OK;
> @@ -61,12 +62,13 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
>         skb->dev        = peer;
>         skb->ip_summed  = CHECKSUM_UNNECESSARY;
>
> +       u8 len = cfd->len;

len = cfd->len;
Silly mistake: u8 not needed twice of course...

>         if (netif_rx_ni(skb) == NET_RX_SUCCESS) {
>                 srcstats->tx_packets++;
> -               srcstats->tx_bytes += cfd->len;
> +               srcstats->tx_bytes += len;
>                 peerstats = &peer->stats;
>                 peerstats->rx_packets++;
> -               peerstats->rx_bytes += cfd->len;
> +               peerstats->rx_bytes += len;
>         }
>
>  out_unlock:
> --
> 2.26.2
>
