Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B182F12A6
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 13:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbhAKM5o (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 07:57:44 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:36351 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbhAKM5o (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 07:57:44 -0500
Received: by mail-yb1-f170.google.com with SMTP id y4so16791526ybn.3
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 04:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmMvH+4GUEt24AlNKJi20O8G6MDIKCKMsDH2Ob6jlDU=;
        b=UUnTaerHqRsL1823WqgY1nDCb3d/4+ifAD7ddJq1Hkqk+Z7bBs93YBOg9hNkxhXppt
         3BGH7yyWLA4XoOypZga1FoQPe04X1lybud2mq5wO1ac8OGoN2olpOYz9nhoVExOxrS+1
         phuxE7fmRzToRgLCZCSfYKCge38I51TOOTJQ2LiFUflwVzndJwGAkybKO9Ly2AhC6wlf
         66tlUNVW4h3+l8Sqd39ttm+RzVzXnC8LBICW69viQEH4kdTnQMXkHfVmsTZkIjr7sGDR
         CXqNwJeRNZd4XF/dLFD7/Cp8X8ZVBhqeO7zACvBJ1pVn37TIcknUHGl5NUTdmKrjZQ4/
         I/eA==
X-Gm-Message-State: AOAM531RnaOYOxSGZiuCvreje2JItiCaLwkXY8QZlY8HFRHElkdUC8te
        YTeR6Czitpqp3eP8AoAdCQJ6RPtl37ZGH8U7ywg=
X-Google-Smtp-Source: ABdhPJxwXyJy3Nfpe90pveaRN2geZmXC/D7AIznoN9QdCyKY+NOnO2SDReodjRNQQ1kVe/WJEvmZbX1qZYyJiEIIS6U=
X-Received: by 2002:a25:287:: with SMTP id 129mr22331193ybc.145.1610369823075;
 Mon, 11 Jan 2021 04:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20210111104529.657057-1-mkl@pengutronix.de> <20210111104529.657057-16-mkl@pengutronix.de>
In-Reply-To: <20210111104529.657057-16-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 11 Jan 2021 21:56:52 +0900
Message-ID: <CAMZ6RqK6ZgGVu46R+5XJzgAnz44jFd6rvyaYbKVQS_bMudovxw@mail.gmail.com>
Subject: Re: [net-next v2 15/15] can: dev: add software tx timestamps
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 11 Jan 2021 at 19:45, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
> Call skb_tx_timestamp() within can_put_echo_skb() so that a software
> tx timestamp gets attached on the skb.
>
> There two main reasons to include this call in can_put_echo_skb():
>
>   * It easily allow to enable the tx timestamp on all devices with
>     just one small change.
>
>   * According to Documentation/networking/timestamping.rst, the tx
>     timestamps should be generated in the device driver as close as
>     possible, but always prior to passing the packet to the network
>     interface. During the call to can_put_echo_skb(), the skb gets
>     cloned meaning that the driver should not dereference the skb
>     variable anymore after can_put_echo_skb() returns. This makes
>     can_put_echo_skb() the very last place we can use the skb without
>     having to access the echo_skb[] array.
>
> Remarks:
>
>   * By default, skb_tx_timestamp() does nothing. It needs to be
>     activated by passing the SOF_TIMESTAMPING_TX_SOFTWARE flag either
>     through socket options or control messages.
>
>   * The hardware rx timestamp of a local loopback message is the
>     hardware tx timestamp. This means that there are no needs to
>     implement SOF_TIMESTAMPING_TX_HARDWARE for CAN sockets.
>
> References:
>
> Support for the error queue in CAN RAW sockets (which is needed for tx
> timestamps) was introduced in:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eb88531bdbfaafb827192d1fc6c5a3fcc4fadd96
>
> Put the call to skb_tx_timestamp() just before adding it to the array:
> https://lkml.org/lkml/2021/1/10/54
>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Link: https://lore.kernel.org/r/20210110124903.109773-2-mailhol.vincent@wanadoo.fr
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/skb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 53683d4312f1..f858f994cd49 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -61,6 +61,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>                 skb->pkt_type = PACKET_BROADCAST;
>                 skb->ip_summed = CHECKSUM_UNNECESSARY;
>                 skb->dev = dev;
> +               skb_tx_timestamp(skb);
>
>                 /* save frame_len to reuse it when transmission is completed */
>                 can_skb_prv(skb)->frame_len = frame_len;
> --
> 2.29.2
>
>

A small detail, I would prefer to see the call to
skb_tx_timestamp() at the bottom just before we put the skb in
the array. The reason is that the later we do the timestamp, the
better it is.

        /* make settings for echo to reduce code in irq context */
        skb->pkt_type = PACKET_BROADCAST;
        skb->ip_summed = CHECKSUM_UNNECESSARY;
        skb->dev = dev;

        /* save frame_len to reuse it when transmission is completed */
        can_skb_prv(skb)->frame_len = frame_len;

+        skb_tx_timestamp(skb);

        /* save this skb for tx interrupt echo handling */
        priv->echo_skb[idx] = skb;

But it does not really matter.


Yours sincerely,
Vincent
