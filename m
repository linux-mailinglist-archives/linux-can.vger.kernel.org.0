Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBCF2F061A
	for <lists+linux-can@lfdr.de>; Sun, 10 Jan 2021 09:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbhAJI4l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 10 Jan 2021 03:56:41 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:34647 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbhAJI4l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 10 Jan 2021 03:56:41 -0500
Received: by mail-yb1-f177.google.com with SMTP id v67so13929536ybi.1
        for <linux-can@vger.kernel.org>; Sun, 10 Jan 2021 00:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkwRezGJtvciVMmKYsLY/eiw0Gzs1YYgAgxPk1Z4bmQ=;
        b=rzDK1/IzZME9hhsZd1yqIGtc31fbFM1xdmTuBHjY0G5Y+eubRqeHUvbbebV9qG6XMK
         zErgf7iRXFAF8cmiu1aMs5B8NS01piVVqlCqgeULvJDNbWyS3jHuohZtHub8mQJLz9v7
         NHDKqh+P1oIURFYKzTKsqzhnEOj42V9+sNVJ3hAeTWbt5BaqAdmhRDgdiwGLV2mPvsKM
         hRbR+J+HyysT8y4j5OmVOEYhHAIhrK0/YLpgH/bHKH7yJR+AaUoigXHIJ7LZH+x2fY5G
         4o+h/qECZOPXcw7P71Slw1lFoJ3lpGzHXqJzIrjAxG+crsPKv6Jm5U+nmtCBg/M5c/6K
         RbYw==
X-Gm-Message-State: AOAM532MOLAfypNop4s/HaGi++KNvZcR+iNqc7itw83et9MSEF5ZI+pQ
        r4xLJGtiChLbNGCSuB4IumJJhlMBhkT8Pfd7buM=
X-Google-Smtp-Source: ABdhPJzmuP+la1XW1XNadeRRfgyIxqXka7rA60FTJCA/6m+giPljG8fKn3lG7qGGZwKgKUesbwXWr5swfAzTupg8T8c=
X-Received: by 2002:a25:287:: with SMTP id 129mr15904401ybc.145.1610268960184;
 Sun, 10 Jan 2021 00:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20210109174013.534145-1-mkl@pengutronix.de>
In-Reply-To: <20210109174013.534145-1-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 10 Jan 2021 17:55:49 +0900
Message-ID: <CAMZ6RqJ-4rmFDzmzBeHvjw1-_pen4=yhnvnoRvybEtY5fqEQoQ@mail.gmail.com>
Subject: Re: [net-next 00/13] can: dev: cleanup and add CAN frame length
 handling support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun. 10 Jan 2021 at 02:40, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Hello,
>
> this series splits the CAN driver related infrastructure into several files
> (patches 1...6), followed by some cleanup patches (7, 8), and support for
> CAN frame length handling (9...13).
>
> I took the path and put the calculated frame length into the struct
> can_skb_priv and extended the can_get_echo_skb() and
> can_rx_offload_get_echo_skb() to optionally return the CAN frame length.
>
> This patch illustrated how the new code can be used. I'll send mcp251xfd BQL
> support in a separate series, once details about this code have settled.
>
> @@ -1352,7 +1357,9 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
>         }
>
>         for (i = 0; i < len; i++) {
> -               err = mcp251xfd_handle_tefif_one(priv, &hw_tef_obj[i]);
> +               unsigned int frame_len;
> +
> +               err = mcp251xfd_handle_tefif_one(priv, &hw_tef_obj[i], &frame_len);
>                 /* -EAGAIN means the Sequence Number in the TEF
>                  * doesn't match our tef_tail. This can happen if we
>                  * read the TEF objects too early. Leave loop let the
> @@ -1362,6 +1369,8 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
>                         goto out_netif_wake_queue;
>                 if (err)
>                         return err;
> +
> +               total_frame_len += frame_len;
>         }
>
>   out_netif_wake_queue:
> @@ -1393,6 +1402,7 @@ static int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
>                         return err;
>
>                 tx_ring->tail += len;
> +               netdev_completed_queue(priv->ndev, len, total_frame_len);
>
>                 err = mcp251xfd_check_tef_tail(priv);
>                 if (err)
> @@ -2433,6 +2443,7 @@ static bool mcp251xfd_tx_busy(const struct mcp251xfd_priv *priv,
>  static netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
>                                         struct net_device *ndev)
>  {
> +       struct can_skb_priv *can_skb_priv = can_skb_prv(skb);
>         struct mcp251xfd_priv *priv = netdev_priv(ndev);
>         struct mcp251xfd_tx_ring *tx_ring = priv->tx;
>         struct mcp251xfd_tx_obj *tx_obj;
> @@ -2455,6 +2466,8 @@ static netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
>                 netif_stop_queue(ndev);
>
>         can_put_echo_skb(skb, ndev, tx_head);
> +       can_skb_priv->frame_len = can_skb_get_frame_len(skb);
> +       netdev_sent_queue(priv->ndev, can_skb_priv->frame_len);
>
>         err = mcp251xfd_tx_obj_write(priv, tx_obj);
>         if (err)
>
> regards,
> Marc
>

Did you test it after the occurence of a can_bus_off() event?

When the device restarts, you normally have to call
netdev_reset_queue(netdev) in order to reset all the BQL
statistics.
