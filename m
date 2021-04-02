Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419AA352ABE
	for <lists+linux-can@lfdr.de>; Fri,  2 Apr 2021 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhDBMmf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Apr 2021 08:42:35 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:46911 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBMmc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Apr 2021 08:42:32 -0400
Received: by mail-yb1-f177.google.com with SMTP id 8so4967750ybc.13
        for <linux-can@vger.kernel.org>; Fri, 02 Apr 2021 05:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iDxqoL/eLy0OTQNjrpfUTPwzmCOZwOG7yvfuKlLZ3c=;
        b=EsDvPq5LiMBHtx8CX3IyZu5UwE5eB50rj5wIgazWfgOD48GeOt0L+uaqUeithXZ5P8
         VfAOPZ7Vp47c5iAAu2oZB2fgiGR7RPILOs+fUi4Vr2GUc4I+rEmHYfUulZmlgBCInPTa
         ZrAaSRNMcW5B0uHeKVEjegAKecQgvHe3+XXWrSkN2nyY/YmQVsXKr2PTj1628kV4ZBgL
         DduWGZWaLUp4pG7YUvGR8UX0m0o8aVnCyzvJLQiGcy1DptfrFIyEbaUX80Dr1dxZ9Z4f
         9pG3Z9n6PLJvSGt9uiuoNrYS7GXL//BsTgMaN0oLxEgkvS35txdXIczfNGuAlViPN++Y
         XRYg==
X-Gm-Message-State: AOAM531sxRqs26ytVaK7SO2ie2sIyvDgDTg1n3SNVU6JqajdkMPyazDg
        zhpBD8KxwuJHkiatpcm7opK4jPWAw8VCvAxo28RyLjWcjRM=
X-Google-Smtp-Source: ABdhPJzg0HF58ofbDl39CMZakkdShamGs3qYOXGKL2TlAZ5yQdYa3UYDniOEhtsa32zRcmf3s3RacIel9XI5UV5rVgc=
X-Received: by 2002:a25:34d2:: with SMTP id b201mr5100299yba.307.1617367351248;
 Fri, 02 Apr 2021 05:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210402102245.1512583-1-mkl@pengutronix.de>
In-Reply-To: <20210402102245.1512583-1-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 2 Apr 2021 21:42:20 +0900
Message-ID: <CAMZ6RqKYKcmcx0PFo4CsNh3d1bCCr8f=G8zLxt9gQy42E3AR2w@mail.gmail.com>
Subject: Re: [PATCH] can: skb: alloc_can{,fd}_skb(): set "cf" to NULL if skb
 allocation fails
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 2 Apr 2021 at 19:22, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> The handling of CAN bus errors typically consist of allocating a CAN
> error SKB using alloc_can_err_skb() followed by stats handling and
> filling the error details in the newly allocated CAN error SKB. Even
> if the allocation of the SKB fails the stats handling should not be
> skipped.
>
> The common pattern in CAN drivers is to allocate the skb and work on
> the struct can_frame pointer "cf", if it has been assigned by
> alloc_can_err_skb().
>
> |       skb = alloc_can_err_skb(priv->ndev, &cf);
> |
> |       /* RX errors */
> |       if (bdiag1 & (MCP251XFD_REG_BDIAG1_DCRCERR |
> |                     MCP251XFD_REG_BDIAG1_NCRCERR)) {
> |               netdev_dbg(priv->ndev, "CRC error\n");
> |
> |               stats->rx_errors++;
> |               if (cf)
> |                       cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
> |       }
>
> In case of an OOM alloc_can_err_skb() returns NULL, but doesn't set
> "cf" to NULL as well. For the above pattern to work the "cf" has to be
> initialized to NULL, which is easily forgotten.
>
> To solve this kind of problems, set "cf" to NULL if
> alloc_can_err_skb() returns NULL.
>
> Suggested-by: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/dev/skb.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 387c0bc0fb9c..61660248c69e 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -183,8 +183,11 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
>
>         skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
>                                sizeof(struct can_frame));
> -       if (unlikely(!skb))
> +       if (unlikely(!skb)) {
> +               *cf = NULL;
> +
>                 return NULL;
> +       }
>
>         skb->protocol = htons(ETH_P_CAN);
>         skb->pkt_type = PACKET_BROADCAST;
> @@ -211,8 +214,11 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
>
>         skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
>                                sizeof(struct canfd_frame));
> -       if (unlikely(!skb))
> +       if (unlikely(!skb)) {
> +               *cfd = NULL;
> +
>                 return NULL;
> +       }
>
>         skb->protocol = htons(ETH_P_CANFD);
>         skb->pkt_type = PACKET_BROADCAST;

Thanks Marc!

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
