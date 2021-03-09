Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80873332E14
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 19:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCISTH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 13:19:07 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:35499 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhCISTF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 13:19:05 -0500
Received: by mail-yb1-f178.google.com with SMTP id p186so14984363ybg.2;
        Tue, 09 Mar 2021 10:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5e+TdSdVNPIU4ahZflol/g+wKmqi90+UgljIBVqbKQ=;
        b=RuwMETu+HHPOC4sOzIE7AAgsiZwEvWW92kyEwHMrfMKhj6cPQceu0L5pFtyNNgT9FU
         PaJDOqQMy72cIFsYmdVzzPfzBaG310bV9kTP7vyxcHKhxWh58lhNIm/mFq2nPELEWuo9
         DH6BUuoehK0zz1k9IGiEaRAX54TB6wsXj84HjX6UA97p06hPUqyBxfV9QS9sTCPJzkWd
         kynaFaBn+Bf4uPM2mMG6Zm81wA0TiLrKLkfGB2mcjNmbTC6McffMZdcomDlSdS/qgdDF
         0FvWK6izsViICfjGcvYfgiRVJMQQrGquyH6jVjSz+TBh3jAU14Y9PrgpIWwmnFpMLURF
         en0g==
X-Gm-Message-State: AOAM533t0141kWh5miw+0C5sA2HRBHjln/5Q00W3mIFjc7pIcmAoeItw
        HGXHCEfvQ3aeT2MZaiH29LJwToxyhS72uhSqDKA=
X-Google-Smtp-Source: ABdhPJwADrymzS32Y4E2MTY/fV5tFgeE/xb8q0dhQZw5aN48jd58+Z+6W9vaPY2VkCWyXa5oWxZdNYGdDwJIct8Z0VA=
X-Received: by 2002:a25:2c96:: with SMTP id s144mr25507702ybs.487.1615313944659;
 Tue, 09 Mar 2021 10:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20210309120946.1640-1-mailhol.vincent@wanadoo.fr>
 <20210309120946.1640-2-mailhol.vincent@wanadoo.fr> <45c0b0cc-bfd6-5180-7ad9-51eebc9de3c9@gmail.com>
 <CAMZ6RqJ8j0yqw1Sa1dbLpakBSuKie5xpYMpg6oQFG_MuE3sWkw@mail.gmail.com>
In-Reply-To: <CAMZ6RqJ8j0yqw1Sa1dbLpakBSuKie5xpYMpg6oQFG_MuE3sWkw@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 10 Mar 2021 03:18:53 +0900
Message-ID: <CAMZ6Rq+xJv+NVHAUYjT+-MLeO+Owoo03T2hzaA9tOKLstxU0uA@mail.gmail.com>
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

On Wed. 10 Mar 2021 at 03:11, Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
>
> On Wed. 10 Mar 2021 at 02:27, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
> >
> > Hi Vincent,
> >
> > On 2021-03-09 13:09, Vincent Mailhol wrote:
> > > This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
> > > ETAS GmbH (https://www.etas.com/en/products/es58x.php).
> > ...
> > > diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> > > new file mode 100644
> > > index 000000000000..31f907a7b75f
> > > --- /dev/null
> > > +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> > ...
> > > +/**
> > > + * es58x_add_skb_idx() - Increment an index of the loopback FIFO.
> > > + * @priv: ES58X private parameters related to the network device.
> > > + * @idx: address of the index to be incremented.
> > > + * @a: the increment. Must be positive and less or equal to
> > > + *   @priv->can.echo_skb_max.
> > > + *
> > > + * Do a modulus addition: set *@idx to (*@idx + @a) %
> > > + * @priv->can.echo_skb_max.
> > > + *
> > > + * Rationale: the modulus operator % takes a decent amount of CPU
> > > + * cycles (c.f. other division functions such as
> > > + * include/linux/math64.h:iter_div_u64_rem()).
> > > + */
> > > +static __always_inline void es58x_add_skb_idx(struct es58x_priv *priv,
> > > +                                           u16 *idx, u16 a)
> >
> > Never used?
>
> Indeed, this is a leftover. Should have been removed in v11 when I
> made the device FIFO size a power of two.
> I was not warned by the compiler, probably because this is an inline function.
>
> > ...
> > > +/**
> > > + * es58x_get_product_info() - Get the product information and print them.
> > > + * @es58x_dev: ES58X device.
> > > + *
> > > + * Do a synchronous call to get the product information.
> > > + *
> > > + * Return: zero on success, errno when any error occurs.
> > > + */
> > > +static int es58x_get_product_info(struct es58x_device *es58x_dev)
> > > +{
> > > +     struct usb_device *udev = es58x_dev->udev;
> > > +     const int es58x_prod_info_idx = 6;
> > > +     /* Empirical tests show a prod_info length of maximum 83,
> > > +      * below should be more than enough.
> > > +      */
> > > +     const size_t prod_info_len = 127;
> > > +     char *prod_info;
> > > +     int ret;
> > > +
> > > +     prod_info = kmalloc(prod_info_len, GFP_KERNEL);
> > > +     if (!prod_info)
> > > +             return -ENOMEM;
> > > +
> > > +     ret = usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
> > > +     if (ret < 0) {
> > > +             dev_err(es58x_dev->dev,
> > > +                     "%s: Could not read the product info: %pe\n",
> > > +                     __func__, ERR_PTR(ret));
> >
> > Missing free
>
> Absolutely!
>
> > > +             return ret;
> > > +     } else if (ret >= prod_info_len - 1) {
> > > +             dev_warn(es58x_dev->dev,
> > > +                      "%s: Buffer is too small, result might be truncated\n",
> > > +                      __func__);
> > > +     }
> > > +     dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);
> > > +     kfree(prod_info);
> > > +
> > > +     return 0;
> > > +}
>
> Thanks for the two findings, both will be fixed in v13.

Out of curiosity, did you find the two issues throughout a code
review or did you use any kind of static analysis tool?
