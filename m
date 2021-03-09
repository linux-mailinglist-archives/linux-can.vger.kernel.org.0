Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55630332D9A
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhCIRyu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 12:54:50 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:35751 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhCIRy0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 12:54:26 -0500
Received: by mail-yb1-f173.google.com with SMTP id p186so14899735ybg.2
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 09:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbusjPHkIFuKE/DlSmfAKSWYjOXQOkFjuU8KPwjErWw=;
        b=Minn5waGrNUQ11c4vUC7NDlvZPSAWxJOHObQcNv2KjZrqn8oRbYJFD+RA/rsgQwEay
         4eAqI+vRtA2V+z64UB2I67BmE3vbLIDYx89FBatEc6sqJRgMgKdb1Mzc/oYcO7GalnKX
         x+Ejb9KWNrNndcSOCHutMSrUF6KQlRzQFhYOcmI0qVVMKeqcX8+lrNdVgg+t1NjJ7XSg
         FKAKJZWaqQseD6Dq5guZkQNtYsM5zcjy8tUFNuGD1EYq7b8YwpRMX4Wjy4BuMPFS/JHQ
         9fUd4T4fDz/BqfKigSEKexUnm0+UfabwcFXSSzxnJ3HpeSFlrh/uXN/9x7ccuzKghyON
         QSRA==
X-Gm-Message-State: AOAM533DWjY49RdVki2V2ePXg7W5GprWg7utQ1x3FmwgtaudW41zBPDE
        /VRaEkl1EM/RGU1NNV6GDBv/4bKruTfMyQwtc1c=
X-Google-Smtp-Source: ABdhPJwqNfLjLnTCVKCFIoiQT2p1RykyvKoZl1g8nf9Vz/nk5ukKVD0aLrbM65ngTuvMWz1zK/6OX4+v52hReXtfqao=
X-Received: by 2002:a25:2c96:: with SMTP id s144mr25338603ybs.487.1615312465774;
 Tue, 09 Mar 2021 09:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr>
 <20210308163445.103636-2-mailhol.vincent@wanadoo.fr> <2b43e72b-c561-d144-c01e-c4ea361cc932@pengutronix.de>
 <CAMZ6RqJADCFL_=uv-=hNjiNj+CZkUDNWjLTP3eV010KGj+H49A@mail.gmail.com>
 <20210309125708.ei75tr5vp2sanfh6@pengutronix.de> <CAMZ6Rq+_QTDM5R++kQAtHjUHiydaV3njcH-up+uY7Jd8dggwQA@mail.gmail.com>
 <20210309153547.q7zspf46k6terxqv@pengutronix.de>
In-Reply-To: <20210309153547.q7zspf46k6terxqv@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 10 Mar 2021 02:54:14 +0900
Message-ID: <CAMZ6Rq+bKzRqAg9egg6NL_mJHTwY02em2dR+O33OGe6xqt-nqg@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 10 Mar 2021 at 00:35, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 09.03.2021 22:10:08, Vincent MAILHOL wrote:
> > Sounds good to me. I will prepare a patch to explain the issue
> > and try to introduce the dql_set_min_limit() function.
> >
> > Meanwhile, I would be thankful if you could continue the review :)
>
> Thanks for the mail, looks good.
>
> One note for the patch, though:
>
> > diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic_queue_limits.h
> > index 407c2f281b64..32437f168a35 100644
> > --- a/include/linux/dynamic_queue_limits.h
> > +++ b/include/linux/dynamic_queue_limits.h
> > @@ -103,6 +103,9 @@ void dql_reset(struct dql *dql);
> >  /* Initialize dql state */
> >  void dql_init(struct dql *dql, unsigned int hold_time);
> >
> > +/* Set the dql minimum limit */
> #ifdef CONFIG_DQL
> > +void dql_set_min_limit(struct dql *dql, unsigned int min_limit);
> #else
> static inline void dql_set_min_limit(struct dql *dql, unsigned int min_limit)
> {
> }
> #endif
> > +
> >  #endif /* _KERNEL_ */
> >
> >  #endif /* _LINUX_DQL_H */
> > diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
> > index fde0aa244148..8b6ad1e0a2e3 100644
> > --- a/lib/dynamic_queue_limits.c
> > +++ b/lib/dynamic_queue_limits.c
>
> This file is only compiled if CONFIG_DQL is set, see lib/Makefile:
>
> | obj-$(CONFIG_DQL) += dynamic_queue_limits.o

Got it.

> > @@ -136,3 +136,11 @@ void dql_init(struct dql *dql, unsigned int hold_time)
> >       dql_reset(dql);
> >  }
> >  EXPORT_SYMBOL(dql_init);
> > +
> > +void dql_set_min_limit(struct dql *dql, unsigned int min_limit)
> > +{
> > +#ifdef CONFIG_BQL
>
> remove this ifdef
>
> > +     dql->min_limit = min_limit;
> > +#endif
> > +}
> > +EXPORT_SYMBOL(dql_set_min_limit);

Actually, after doing a few more tests, this is a bit more complicated
than anticipated.
The dql member of struct netdev_queue is also guarded by a #ifdef CONFIG_BQL:
https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h#L629

This means that under the current idea, we would also need to guard
the call to dql_set_min_limit():
#ifdef CONFIG_BQL
    dql_set_min_limit(&netdev_get_tx_queue(netdev, 0)->dql,
              es58x_dev->param->dql_limit_min);
#ifdef CONFIG_BQL

This kills the initial intent of not using the #ifdef CONFIG_BQL to
set the value.

This leads to the need to do:
void netdev_queue_set_dql_min_limit(struct netdev_queue *q, unsigned
int min_limit)
{
#ifdef CONFIG_BQL
    q->dql.min_limit = min_limit;
#endif
}
which would probably be inside /include/linux/netdevice.h.

Does it make sense?


Yours sincerely,
Vincent
