Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A1C36A7BA
	for <lists+linux-can@lfdr.de>; Sun, 25 Apr 2021 16:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDYORA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Apr 2021 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhDYORA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Apr 2021 10:17:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1601C061574
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 07:16:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p6-20020a05600c3586b029014131bbe5c7so460804wmq.3
        for <linux-can@vger.kernel.org>; Sun, 25 Apr 2021 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flodin-me.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jEHbT2HPU07YWp8UIpvxV0HKIyl8Sn3Z1db3mhpjS4=;
        b=Ot6WOmtm/69oaFZX0wjMQfJ2sx/lD+5YRiLSkyHDqkPn//qLX5oRVlSV6aUi/63fyF
         GTsO1Xu9iCa81pxXYuhl42cNlSlMzOff2IzfBqWfzUr54ihaDO+hw4MNxy86Fehnw2ix
         GevCs6aFgwukTpl5easln80WvfjLXLtWgK6g6u4ginkwzgjbfJ4w2SDoH9auDAchHmiA
         GojwaJAKttPQkouLBOybtbavQxv2c24FMd/cpODrOHyCqE4zSNgm+Ff9fkAORN+RhCU7
         0XxWru7EGVbFhdhNtS8OutwFnoO0mqCrYj5wba2NEsWzI0qHYcVQfcRKLey0U1ojPDNJ
         kOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jEHbT2HPU07YWp8UIpvxV0HKIyl8Sn3Z1db3mhpjS4=;
        b=hMmGQI6OKV+jFtMJeyC89bvFgUUSFMj5MmaLteFMxCD8LXeG3VkluS/Es2JNIg3kk6
         rRNSX0ZhsW1gb1uhSqdkc6K067ykI3Q/OACRT+6D8UDE322COkzWGPJo1Z3F0LNZSkpl
         ETKo9F6+qOiS8JfXDiv379P4rSGWqXSuKKxAPkwT4+NlrgTLvtWSqZx49sfMPpPWQn/D
         /EACWpWvoM5b0wQLoVulLLS0knEpZvmwKicSmUmQK2tGjPznbmFNHM2238bYDAxvgoK0
         xK1W0WVwCj1jXhm0Ib8w3seyDO1391uUx2qmPL7NJ50715PiyNfLpwWnndTC5z1M7Fjr
         3G9Q==
X-Gm-Message-State: AOAM533840b1yWUGRwrWnkRECHXdxqY4qiHytZp73OxMaK2XHdDwwu8t
        yqlupUSgn/a/ustS6Ocdp/9ySZvesduA+iNyHspRHg==
X-Google-Smtp-Source: ABdhPJx4DBUvbpkKeXuR8l7ZvZxnyRIpkd/fdESWjROrRlTUb9N7zU7ISNw3RLEjxk1i1gSXxoESGOHrz5JkpJPziFk=
X-Received: by 2002:a1c:3587:: with SMTP id c129mr14232332wma.80.1619360177569;
 Sun, 25 Apr 2021 07:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210425095249.177588-1-erik@flodin.me> <20210425122222.223839-1-erik@flodin.me>
 <20210425122701.qbalhfsbybip2fci@pengutronix.de>
In-Reply-To: <20210425122701.qbalhfsbybip2fci@pengutronix.de>
From:   Erik Flodin <erik@flodin.me>
Date:   Sun, 25 Apr 2021 16:16:06 +0200
Message-ID: <CAAMKmofSsfP4SZ_At4VqGYVfo7-i+q1Hqrxdfmk79kS+tjtsvg@mail.gmail.com>
Subject: Re: [PATCH v3] can: proc: fix rcvlist_* header alignment on 64-bit system
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On Sun, 25 Apr 2021 at 14:27, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 25.04.2021 14:22:12, Erik Flodin wrote:
> > Before this fix, the function and userdata columns weren't aligned:
> >   device   can_id   can_mask  function  userdata   matches  ident
> >    vcan0  92345678  9fffffff  0000000000000000  0000000000000000         0  raw
> >    vcan0     123    00000123  0000000000000000  0000000000000000         0  raw
> >
> > After the fix they are:
> >   device   can_id   can_mask      function          userdata       matches  ident
> >    vcan0  92345678  9fffffff  0000000000000000  0000000000000000         0  raw
> >    vcan0     123    00000123  0000000000000000  0000000000000000         0  raw
> >
> > Signed-off-by: Erik Flodin <erik@flodin.me>
> > ---
> >  net/can/proc.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/can/proc.c b/net/can/proc.c
> > index 5ea8695f507e..35b6c7512785 100644
> > --- a/net/can/proc.c
> > +++ b/net/can/proc.c
> > @@ -205,8 +205,11 @@ static void can_print_recv_banner(struct seq_file *m)
> >        *                  can1.  00000000  00000000  00000000
> >        *                 .......          0  tp20
> >        */
> > -     seq_puts(m, "  device   can_id   can_mask  function"
> > -                     "  userdata   matches  ident\n");
> > +#ifdef CONFIG_64BIT
> > +     seq_puts(m, "  device   can_id   can_mask      function          userdata       matches  ident\n");
> > +#else
> > +     seq_puts(m, "  device   can_id   can_mask  function  userdata   matches  ident\n");
> > +#endif
>
> Please use "if (IS_ENABLED(CONFIG_64BIT))" as in your example in your
> previous mail.

Ok. I've sent a new patch, but of course I forgot to add -v4. Sorry about that.

// Erik
