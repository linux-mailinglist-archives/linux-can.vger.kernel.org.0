Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB3033262F
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 14:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCINKe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 08:10:34 -0500
Received: from mail-yb1-f180.google.com ([209.85.219.180]:46236 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhCINKU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 08:10:20 -0500
Received: by mail-yb1-f180.google.com with SMTP id h82so13831336ybc.13
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 05:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAIrZl83PJJAmWLNEqy4mSYW/vf1E9jTHJNa+pb6uRw=;
        b=JwX4sTLEc5MYrOg4nR210DIvLtVozbixWx9Wu27m7XuXsp0Vp24bt3qzOj9MQ4iVaU
         3a7/HY9HAT68V8Nv0xvCWNnGoMX/9oRwznyK3rAUXKlT78Q8KfySWSiwDLkqZt50p+dd
         Z5xiKAXxxMf4BjmGisZZYpXDcoOYbIkF+jsL9yrsSttNsOFz2Z72lZ6keD34oV/NxYFp
         +JLr3X4uZwn11DckFt+kPnP6bueRXgDyg8rVX52WGcR5R99p6NCXVqQV9iaUU7pP47NC
         TyLFi+Mn58vGIZ9fIM4WuuXJXysPuKxCkFia7lW2+Ds8NbWRuqrwxigrrK7wqjZSJvql
         1mdg==
X-Gm-Message-State: AOAM5321J8YlhqZS7iA0u5rjU/aXvC3GF5rAPCqC5QGn8dgM9rY/xIVF
        8kf5kjvoWBdLBGqL4gCXtAP2hTOiD/UTYzWZ2qSFgPADsSEy4g==
X-Google-Smtp-Source: ABdhPJzVFamPJK/1jf+ye44dM/332nv1CWciO8p16VLqgCewE0Fy6GXuqUf+yIX7GwtsaoUSwHnBDEr6oNldBN5BalA=
X-Received: by 2002:a25:2d1f:: with SMTP id t31mr42407691ybt.239.1615295419386;
 Tue, 09 Mar 2021 05:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr>
 <20210308163445.103636-2-mailhol.vincent@wanadoo.fr> <2b43e72b-c561-d144-c01e-c4ea361cc932@pengutronix.de>
 <CAMZ6RqJADCFL_=uv-=hNjiNj+CZkUDNWjLTP3eV010KGj+H49A@mail.gmail.com> <20210309125708.ei75tr5vp2sanfh6@pengutronix.de>
In-Reply-To: <20210309125708.ei75tr5vp2sanfh6@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 9 Mar 2021 22:10:08 +0900
Message-ID: <CAMZ6Rq+_QTDM5R++kQAtHjUHiydaV3njcH-up+uY7Jd8dggwQA@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Tue. 9 Mar 2021 at 21:57, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 09.03.2021 21:45:58, Vincent MAILHOL wrote:
> > > On 3/8/21 5:34 PM, Vincent Mailhol wrote:
> > > > This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
> > > > ETAS GmbH (https://www.etas.com/en/products/es58x.php).
> > > >
> > > > Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > > > Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
> > > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > >
> > > I'm not sure if you're supposed to change dql.min_limit from the driver.
> >
> > One thing for sure, I am the only one to do it.
> >
> > The reason to do so is because benchmarks show me that values
> > below this threshold are not good for this device (and I try to
> > be very permissive on the values).
> >
> > USB introduces a lot of latency and the small PDU of CAN does not
> > help. The BQL is here to remediate, however, the algorithms can
> > take time to adjust, especially if there are small bursts.
> > Modifying the dql.min_limit was the only solution I found to make
> > sure that packets can be sent in bulk even during small burst
> > events.
> >
> > The BQL was not designed for USB nor was it designed for CAN
> > which probably explains why I am the first one to ever have
> > thought of using dql.min_limit like this.
>
> We can try to sneak it into the kernel or ask on the net-dev list for a
> proper interface[1] for setting sensible defaults to the min_limit.
>
> > Using dql.min_limit is a hack and I pledge guilty for it. However,
> > because this hack brings performance improvement, I would like to keep
> > it if you do not mind.
>
> Your explanation is very good and clear, what about sending new mail
> with this problem description to the netdev list? A proper solution
> might be something like dql_set_min_limit() with a static inline no-op
> of BQL is disabled.
>
> Looking at 114cf5802165 ("bql: Byte queue limits"), you want to include:
> - Tom Herbert <therbert@google.com>
> - Eric Dumazet <eric.dumazet@gmail.com>
>

Sounds good to me. I will prepare a patch to explain the issue
and try to introduce the dql_set_min_limit() function.

Meanwhile, I would be thankful if you could continue the review :)


Yours sincerely,
Vincent
