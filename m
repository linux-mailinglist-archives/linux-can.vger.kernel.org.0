Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C10D341E84
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 14:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCSNjt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 09:39:49 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:33866 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCSNj3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 09:39:29 -0400
Received: by mail-yb1-f175.google.com with SMTP id o83so6321947ybg.1
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 06:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUxI71n7/3Ae9TbK+xSHsV3GPhe/HckFLoS7TMIlrww=;
        b=He+umMP+d2c98/u0DLyEINVntE8L+dZb0h1nHaA0TmDkhfDPHv5BOFqu1J/5HXO9wW
         bze7KHawVJSXm0ZmCaMzn3NqQhkCSB9xeFybzhu1A0M05LioJ/KOqwtE4WAWfadmftDa
         lCsU2+IHMhyRzM6TryRH7RlEZbiNx97PKTW0hq3Vr6gIXBOsj8HG6h9cRrldUlZawojz
         dQUpVdP8/aauhjNO7ufo0Swe93xKFUUc8It60A+VgTKLHH4Y194N+N5/g6aeLTrtHZDy
         +zciVuIf2XMXnUBOh3v+hv1p51uWRhkR/5lVAylAsA7mIxENaYYgqlYe6wUykC+92bTW
         iNhw==
X-Gm-Message-State: AOAM533/1VoAMKpYMuxLM3xs/c0CqLzyr3M+Z9sKC6Jo0Su/kClwJuuF
        DfnwBz+eVLNWfXKkaHXK0JCQArsPzPdOWsS27KhLdYn4iDNUI4YI
X-Google-Smtp-Source: ABdhPJyAniWQs0gZXLzSOGu8tuEZHAjvTWTAdOZdL9WH1506wMCSF68Ihyy06/YeV9pog70S4ngGvS0YYjfMtEoGWXk=
X-Received: by 2002:a25:9704:: with SMTP id d4mr6101126ybo.307.1616161168499;
 Fri, 19 Mar 2021 06:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210319124141.247844-1-mkl@pengutronix.de> <20210319124141.247844-6-mkl@pengutronix.de>
In-Reply-To: <20210319124141.247844-6-mkl@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 19 Mar 2021 22:39:17 +0900
Message-ID: <CAMZ6RqLhD8Dz0XZDrO8GZfeq+2QP3bxNKJtKFTnyVvv9B306Vw@mail.gmail.com>
Subject: Re: [PATCH v13 05/11] can: etas_es58x: remove setting of
 dql.min_limit for now
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 19 Mar 2021 at 21:41, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 5 -----
>  drivers/net/can/usb/etas_es58x/es58x_core.h | 3 ---
>  2 files changed, 8 deletions(-)
>
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index 89a4051afc82..d6a114a7e090 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -2150,11 +2150,6 @@ static int es58x_init_netdev(struct es58x_device *es58x_dev, int channel_idx)
>         netdev_dbg(netdev, "%s: Registered channel %s\n",
>                    es58x_dev->udev->product, netdev->name);
>
> -#ifdef CONFIG_BQL
> -       netdev_get_tx_queue(netdev, 0)->dql.min_limit =
> -           es58x_dev->param->dql_limit_min;
> -#endif
> -
>         return ret;
>  }
>
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
> index 71f278e6e85c..ba6cdb9dfcf4 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.h
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
> @@ -306,9 +306,6 @@ struct es58x_parameters {
>         u16 tx_urb_cmd_max_len;
>         u16 rx_urb_cmd_max_len;
>         u16 fifo_mask;
> -#ifdef CONFIG_BQL
> -       u16 dql_limit_min;
> -#endif
>         u8 tx_bulk_max;
>         u8 urb_cmd_header_len;
>         u8 rx_urb_max;

My current idea was to add an helper function
es58x_netdev_queue_set_dql_min_limit() as below and to remove it
the day the patch got accepted in the network devices.

Does it make sense? If you prefer to remove it for now, I will do so.

/**
 * es58x_netdev_queue_set_dql_min_limit - set dql minimum limit
 * @dev_queue: pointer to transmit queue
 * @min_limit: dql minimum limit
 *
 * Forces xmit_more() to return true until the minimum threshold
 * defined by @min_limit is reached (or until the tx queue is
 * empty). Warning: to be use with care, misuse will impact the
 * latency.
 */
static inline void es58x_netdev_queue_set_dql_min_limit(struct netdev_queue *q,
                            unsigned int min_limit)
{
#ifdef CONFIG_BQL
    q->dql.min_limit = min_limit;
#endif
}
