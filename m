Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3109E332DE8
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 19:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhCISMK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 13:12:10 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:45034 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhCISLj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 13:11:39 -0500
Received: by mail-yb1-f173.google.com with SMTP id f4so14907567ybk.11;
        Tue, 09 Mar 2021 10:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sjbq9+/8hVqDZ3bO/IAy9KZ0xs8BMr+ba6+tsc8IWfY=;
        b=X0SLhXPA2gpzgp5idZWsZ0Y7tMod/Iyhat06Syt7owKrUxsUtHqgCUw6Ws6Vj6FV+1
         zNghd+z3voBfq7dpy7+84pHcbL6xYHu1PPHhMqiHcgtk3ofHV109A/AobjsGePRJlWmy
         91MgMbGf4G3Ev4an6AGHkUcobHlOw3IH6TFJFQyEC2dJx7HoQgiK1+/3lFdi5DtADgEO
         gwKUEcGZCoxOmaWG3C/aNcY9oln1eh1maNOJoaEDSPjqNyJJb5WEWaYQ1AYhnITsGXAn
         P0j0yYW1ArpL02dZu76IYaqwfR/B2h6fdRLzmeddQ5mmeQo8FQ14Jcl4KgnPsVSZ4ePI
         N8lQ==
X-Gm-Message-State: AOAM5338e4NFByMIYRYhTF30RcUWO/iyRYolmWAkqpIvhV37O958IhXK
        wmSw5SzuKV3ZehZtqSkyTKXlizTyKCZZYRIb9G8=
X-Google-Smtp-Source: ABdhPJyuopxP9AGuv9yGualtZJ8a3OYqVT0TdqeRATVgOl+eHUEGZnB+UAQaNxtkQmZRBjos1wyjJJvamM9wZguGb2w=
X-Received: by 2002:a05:6902:4b2:: with SMTP id r18mr43543395ybs.226.1615313499159;
 Tue, 09 Mar 2021 10:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20210309120946.1640-1-mailhol.vincent@wanadoo.fr>
 <20210309120946.1640-2-mailhol.vincent@wanadoo.fr> <45c0b0cc-bfd6-5180-7ad9-51eebc9de3c9@gmail.com>
In-Reply-To: <45c0b0cc-bfd6-5180-7ad9-51eebc9de3c9@gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 10 Mar 2021 03:11:28 +0900
Message-ID: <CAMZ6RqJ8j0yqw1Sa1dbLpakBSuKie5xpYMpg6oQFG_MuE3sWkw@mail.gmail.com>
Subject: Re: [RESEND v12] can: usb: etas_es58X: add support for ETAS ES58X CAN
 USB interfaces
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        open list <linux-kernel@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 10 Mar 2021 at 02:27, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
>
> Hi Vincent,
>
> On 2021-03-09 13:09, Vincent Mailhol wrote:
> > This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
> > ETAS GmbH (https://www.etas.com/en/products/es58x.php).
> ...
> > diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> > new file mode 100644
> > index 000000000000..31f907a7b75f
> > --- /dev/null
> > +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> ...
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
>
> Never used?

Indeed, this is a leftover. Should have been removed in v11 when I
made the device FIFO size a power of two.
I was not warned by the compiler, probably because this is an inline function.

> ...
> > +/**
> > + * es58x_get_product_info() - Get the product information and print them.
> > + * @es58x_dev: ES58X device.
> > + *
> > + * Do a synchronous call to get the product information.
> > + *
> > + * Return: zero on success, errno when any error occurs.
> > + */
> > +static int es58x_get_product_info(struct es58x_device *es58x_dev)
> > +{
> > +     struct usb_device *udev = es58x_dev->udev;
> > +     const int es58x_prod_info_idx = 6;
> > +     /* Empirical tests show a prod_info length of maximum 83,
> > +      * below should be more than enough.
> > +      */
> > +     const size_t prod_info_len = 127;
> > +     char *prod_info;
> > +     int ret;
> > +
> > +     prod_info = kmalloc(prod_info_len, GFP_KERNEL);
> > +     if (!prod_info)
> > +             return -ENOMEM;
> > +
> > +     ret = usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
> > +     if (ret < 0) {
> > +             dev_err(es58x_dev->dev,
> > +                     "%s: Could not read the product info: %pe\n",
> > +                     __func__, ERR_PTR(ret));
>
> Missing free

Absolutely!

> > +             return ret;
> > +     } else if (ret >= prod_info_len - 1) {
> > +             dev_warn(es58x_dev->dev,
> > +                      "%s: Buffer is too small, result might be truncated\n",
> > +                      __func__);
> > +     }
> > +     dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);
> > +     kfree(prod_info);
> > +
> > +     return 0;
> > +}

Thanks for the two findings, both will be fixed in v13.


Yours sincerely,
Vincent
