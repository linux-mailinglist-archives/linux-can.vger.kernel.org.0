Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9181172B5
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 18:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfLIR0n (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 12:26:43 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43292 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIR0n (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2019 12:26:43 -0500
Received: by mail-yw1-f67.google.com with SMTP id s187so6077950ywe.10
        for <linux-can@vger.kernel.org>; Mon, 09 Dec 2019 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=discretecat-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=jNRDtmJ9GhELbzAenn2jxRWsVQ9mnWt4fjnJykF0R2k=;
        b=awMS+v3/OnxueHMPKXo3DFj+1TM5qLtMxPmS7GBTYC43706Izo/GP6YW0sC/8uFyql
         NqPj6teSk1oJj/e8jpMKyV/26tkXD7ERk+KqCyd80jiEN3y1FZ2bS+LD4ro3IYE26nHN
         nh1b8tQaVKCeprNDvksA6vAap1OxY6s5ykkmpZNizVoOJdXJdk3ZM6sXndQbNdURbTI/
         AkFrDXr0/RItLD2wQ7/OGpjkeJaCsktCJ7CqMfJZiawJp11HIoHni94px8ZsS9NcxsLq
         SLvMfyQM0b9wwZu74UW2C/VawxRMYGHzRoMf/3SdTrBYAgdztKslfU5OepZeIbTgM6Ir
         2khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=jNRDtmJ9GhELbzAenn2jxRWsVQ9mnWt4fjnJykF0R2k=;
        b=GhFB6YndR9dskwZZoKHaNhAbLHPI4ygwehaQGXVVt3uKcWlfFDKTqyHhubpDmA8cQi
         xVl5bbcXyKE6px8HvAbxtQykKMgIIX8HABCluKGeuCM0yuLjxkKbA0uoEng5V7rx0LaV
         uyybnttwuRVzzwLO4lQwzqDSoa4wSbBKjzlYKJp4uWCBxVG0trfYLmqtJ1/h3n1IJU8u
         2iOPlnluOfhzGXkYE3k+/8Mx+kzn6VYtHui7TO7w2hwX/pvkxQF3GzyBoLKi9cZXDrIG
         CDWSU56zlLhKhVlGpEpMi3Na3aVUMZTOX6+gFtHWRjsPcfT2zDK5LAWxqeWfwdhnUFse
         c40Q==
X-Gm-Message-State: APjAAAW9qAdAUayp2dohsMhtooPL4eJWx3lDXUV+eP1lTHcQO87JttIv
        XiEax6PGwf64DdU5brrM5s4XooT64UOCLTNpARhCq/mN50k=
X-Google-Smtp-Source: APXvYqxIG+rTSlb30a98qkwbQ6a2n8NDfgsKMfM0XiyjpocKX47Ue0KEpj8AtJpiL45oF5i1DzXn+awdPzdQQdD5V3M=
X-Received: by 2002:a0d:d817:: with SMTP id a23mr15742729ywe.76.1575912401816;
 Mon, 09 Dec 2019 09:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20191209084808.908116-1-sean@geanix.com> <20191209084808.908116-2-sean@geanix.com>
In-Reply-To: <20191209084808.908116-2-sean@geanix.com>
From:   Tom Prohaszka <tommy@discretecat.com>
Date:   Mon, 9 Dec 2019 12:26:37 -0500
Message-ID: <CACXUjBzBVkqk1kwtEE9SG=25P897PdG_brZwUCtS-0AxukeQiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] can: m_can: tcan4x5x: reset device before register access
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

unsubscribe linux-can

On Mon, Dec 9, 2019 at 3:48 AM Sean Nyekjaer <sean@geanix.com> wrote:
>
> It's a good idea to reset a ip-block/spi device before using it,
> this patch will reset the device.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/net/can/m_can/tcan4x5x.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
> index 7f26c2d53f8c..dd812d40d475 100644
> --- a/drivers/net/can/m_can/tcan4x5x.c
> +++ b/drivers/net/can/m_can/tcan4x5x.c
> @@ -361,14 +361,15 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>
>                 tcan4x5x_disable_wake(cdev);
>         }
> -
>         tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
> -                                                      GPIOD_OUT_LOW);
> +                                                      GPIOD_OUT_HIGH);
>         if (IS_ERR(tcan4x5x->reset_gpio))
>                 tcan4x5x->reset_gpio = NULL;
>
>         usleep_range(700, 1000);
>
> +       gpiod_set_value(tcan4x5x->reset_gpio, 0);
> +
>         tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
>                                                               "device-state",
>                                                               GPIOD_IN);
> --
> 2.24.0
>
