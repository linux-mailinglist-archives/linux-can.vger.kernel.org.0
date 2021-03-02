Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20B732AE9E
	for <lists+linux-can@lfdr.de>; Wed,  3 Mar 2021 03:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhCBXum (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Mar 2021 18:50:42 -0500
Received: from mail-yb1-f172.google.com ([209.85.219.172]:43625 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbhCBBlN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Mar 2021 20:41:13 -0500
Received: by mail-yb1-f172.google.com with SMTP id u75so19026223ybi.10
        for <linux-can@vger.kernel.org>; Mon, 01 Mar 2021 17:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJUOwh+fuwSPSyV0KoTHyvs3Bj3K3UG7mvp0oQ6jXRU=;
        b=sMwB00xplcZ/Hp7XLn2NbXnfPqco908EtYWouBQguWbTAi27WynwwZI7/qq66u2V/F
         7rcyiZeN/rDVoxofoguHNmwhtk9SI/BIrhbguDoPu6TUJcAJ1ak8RgdFhZon396lc+7s
         delPRNjBAqk8akXcQG3peC1jWoN+OoNtv6gnoPRmWa7VNI9dofeOpNyEp9KM1GzSoN0C
         klkjpNW53tEbYQsLeW5pN72k6rej/XHw6+aa6Ewya6lxJg7HwN0Xl5F8c7mivjISsmgL
         l2yeey4h5JuKDKaicoYmT1sZRSr3pGxBUAyKEBOP9urLDJK+y47XkAiyQApMuuU/RpJ/
         e8tQ==
X-Gm-Message-State: AOAM530oTKhcFUxrdGv/5EDO8dj2X3VQiBbkhuGgg8Mw9xfCqSAPGdzT
        sBMbvCMx3MrX+qWHKj768q+v3/U4P8KmLLkwdDeUgDalg74=
X-Google-Smtp-Source: ABdhPJzEysZZT+v+RHcobK0Zw/ulJLfFKNa6aWLV9EXznq3cPCrFjjIsdf3nHzvfN2nZPatCREoc+3EkrmvdNQKM3VI=
X-Received: by 2002:a25:3853:: with SMTP id f80mr26088582yba.514.1614649232433;
 Mon, 01 Mar 2021 17:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20210301165856.37gvqkomvjkjvbj2@pengutronix.de>
In-Reply-To: <20210301165856.37gvqkomvjkjvbj2@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 2 Mar 2021 10:40:21 +0900
Message-ID: <CAMZ6RqKfXR9cHxjvnPwxjWHWEuxYNV9V4qLSd0ZQGP0JOMKX0w@mail.gmail.com>
Subject: Re: mcp251x hangs during ifup
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        =?UTF-8?B?VGltbyBTY2hsw7zDn2xlcg==?= <schluessler@krause.de>
Cc:     ukrfoil@gmail.com, linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Tue. 2 Mar 2021 at 01:58, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> Hello,
>
> in the armbian forum a problem with the mcp215x was reported:
>
> https://forum.armbian.com/topic/14909-orange-pi-mcp2515-ip-up-freezes/
>
> In the last comment (Posted Saturday at 10:05 PM) Aleksey posted a
> mcp251x.c with a workaround. After cleanup the diff looks like this:
>
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index f69fb4238a65..6d5fcf5a19a2 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -1221,7 +1221,7 @@ static int mcp251x_open(struct net_device *net)
>         INIT_WORK(&priv->tx_work, mcp251x_tx_work_handler);
>         INIT_WORK(&priv->restart_work, mcp251x_restart_work_handler);
> -       ret = mcp251x_hw_wake(spi);
> +       ret = mcp251x_hw_reset(spi);
>         if (ret)
>                 goto out_free_wq;
>         ret = mcp251x_setup(net, spi);
>
> Vincent, it seems the gpio support has broken the driver on some
> platforms. Do you have an idea?

This mcp251x_hw_wake() function was introduced in below commit:
8ce8c0abcba3 ("can: mcp251x: only reset hardware as required")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8ce8c0abcba314e1fe954a1840f6568bf5aef2ef

The GPIO support was then introduced later on in below commit:
2d52dabbef60 ("can: mcp251x: add GPIO support")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d52dabbef60da91b72617519495fe77b621e6b8

I am adding Timo to the loop. He is the author of the two commits above.
I think he will be of better support than me here :)

> Is RUNTIME_PM support now mandatory? So that mcp251x_can_suspend() and
> mcp251x_can_resume() are now always called, does the driver break if
> those functions are not compiled into the kernel?
