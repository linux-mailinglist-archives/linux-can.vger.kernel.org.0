Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB09332E40
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 19:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCIS0k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 9 Mar 2021 13:26:40 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:42338 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhCIS0Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 13:26:24 -0500
Received: by mail-yb1-f177.google.com with SMTP id n195so14953115ybg.9
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 10:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aS99F6wsyZ+OH8LrhLwfK0hXrDzy8Tatm3jXreStxmw=;
        b=nbPfINEpCY2e55BzpqKfUtdNyHgYQLvtwxi1H7kDE969+oWlCwwKlTIkUA5sdXALP+
         yK7PLB2CpOvLYH3w1s+oxWYNh8sIduEjb6drxpqokfyJSPjTStyCMZ7pKkvuAiC66En/
         q/PDhZMqBps/eZ7+WGS5V7VhrYBo8DPONLljydsrS2VFmjCGUJq0/2pYa4GVHeUt5eAm
         LUq2WiMn7UohqoxZBclM9WTgzU2/NlfQMVGoBY/Q2CJ0Rj7SMTAhMUaAcBagEAsUh/J8
         JbZ1SN3DBl7g9zVITzSXU6xJpuut1rsZdgEp6Ug7i3DTzhQDxRJXaK8G68G0KHmFGJAA
         vzSQ==
X-Gm-Message-State: AOAM5306VfhMrizdxMT13qg78xn2u/6wvR9CFJWRAdYRtg3y8heIkvDK
        SBogjNKgj8p0D2ZGIaV4AdSvU0Dt9a2deiPBAqU=
X-Google-Smtp-Source: ABdhPJzVt3/Wz6ZSl5r0b8C4WYxF0vf5cgEn4jzrSbwW/9U70GP5yMwVXjRB847VF8ChZ6yDPck12brK9OdgnoEv7nc=
X-Received: by 2002:a25:2d1f:: with SMTP id t31mr44516561ybt.239.1615314383358;
 Tue, 09 Mar 2021 10:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr>
 <20210308163445.103636-2-mailhol.vincent@wanadoo.fr> <2b43e72b-c561-d144-c01e-c4ea361cc932@pengutronix.de>
 <CAMZ6RqJADCFL_=uv-=hNjiNj+CZkUDNWjLTP3eV010KGj+H49A@mail.gmail.com>
 <20210309125708.ei75tr5vp2sanfh6@pengutronix.de> <CAMZ6Rq+_QTDM5R++kQAtHjUHiydaV3njcH-up+uY7Jd8dggwQA@mail.gmail.com>
 <20210309153547.q7zspf46k6terxqv@pengutronix.de> <CAMZ6Rq+bKzRqAg9egg6NL_mJHTwY02em2dR+O33OGe6xqt-nqg@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+bKzRqAg9egg6NL_mJHTwY02em2dR+O33OGe6xqt-nqg@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 10 Mar 2021 03:26:12 +0900
Message-ID: <CAMZ6RqKR3HYrJvc+=rXK40Yq=L3pgvTWwgC=reYWSN9XdQ4ksg@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Le mer. 10 mars 2021 à 02:54, Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> a écrit :
>
> On Wed. 10 Mar 2021 at 00:35, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >
> > On 09.03.2021 22:10:08, Vincent MAILHOL wrote:
> > > Sounds good to me. I will prepare a patch to explain the issue
> > > and try to introduce the dql_set_min_limit() function.
> > >
> > > Meanwhile, I would be thankful if you could continue the review :)
> >
> > Thanks for the mail, looks good.
> >
> > One note for the patch, though:
> >
> > > diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
> > > index 407c2f281b64..32437f168a35 100644
> > > --- a/include/linux/dynamic_queue_limits.h
> > > +++ b/include/linux/dynamic_queue_limits.h
> > > @@ -103,6 +103,9 @@ void dql_reset(struct dql *dql);
> > >  /* Initialize dql state */
> > >  void dql_init(struct dql *dql, unsigned int hold_time);
> > >
> > > +/* Set the dql minimum limit */
> > #ifdef CONFIG_DQL
> > > +void dql_set_min_limit(struct dql *dql, unsigned int min_limit);
> > #else
> > static inline void dql_set_min_limit(struct dql *dql, unsigned int min_limit)
> > {
> > }
> > #endif
> > > +
> > >  #endif /* _KERNEL_ */
> > >
> > >  #endif /* _LINUX_DQL_H */
> > > diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
> > > index fde0aa244148..8b6ad1e0a2e3 100644
> > > --- a/lib/dynamic_queue_limits.c
> > > +++ b/lib/dynamic_queue_limits.c
> >
> > This file is only compiled if CONFIG_DQL is set, see lib/Makefile:
> >
> > | obj-$(CONFIG_DQL) += dynamic_queue_limits.o
>
> Got it.
>
> > > @@ -136,3 +136,11 @@ void dql_init(struct dql *dql, unsigned int hold_time)
> > >       dql_reset(dql);
> > >  }
> > >  EXPORT_SYMBOL(dql_init);
> > > +
> > > +void dql_set_min_limit(struct dql *dql, unsigned int min_limit)
> > > +{
> > > +#ifdef CONFIG_BQL
> >
> > remove this ifdef
> >
> > > +     dql->min_limit = min_limit;
> > > +#endif
> > > +}
> > > +EXPORT_SYMBOL(dql_set_min_limit);
>
> Actually, after doing a few more tests, this is a bit more complicated
> than anticipated.
> The dql member of struct netdev_queue is also guarded by a #ifdef CONFIG_BQL:
> https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h#L629
>
> This means that under the current idea, we would also need to guard
> the call to dql_set_min_limit():
> #ifdef CONFIG_BQL
>     dql_set_min_limit(&netdev_get_tx_queue(netdev, 0)->dql,
>               es58x_dev->param->dql_limit_min);
> #ifdef CONFIG_BQL
>
> This kills the initial intent of not using the #ifdef CONFIG_BQL to
> set the value.
>
> This leads to the need to do:
> void netdev_queue_set_dql_min_limit(struct netdev_queue *q, unsigned int min_limit)

Of course, I meant:
static inline void netdev_queue_set_dql_min_limit(struct netdev_queue
*q, unsigned int min_limit)

> {
> #ifdef CONFIG_BQL
>     q->dql.min_limit = min_limit;
> #endif
> }
> which would probably be inside /include/linux/netdevice.h.
>
> Does it make sense?
