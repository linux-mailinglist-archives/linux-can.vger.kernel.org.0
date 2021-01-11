Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEFA2F1035
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 11:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbhAKKfw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 05:35:52 -0500
Received: from mail-yb1-f180.google.com ([209.85.219.180]:44005 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbhAKKfw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 05:35:52 -0500
Received: by mail-yb1-f180.google.com with SMTP id y128so16383929ybf.10
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 02:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGqLwInZHYNYAPZq9va8++mMqklPFVMr6wNVQIr8Xj8=;
        b=oc2YNNupLp0KGU9+lWaqGkDF7qegeJJmtP2bXYqSO6fOcdTdzJgJ0t5yzL1EophAEx
         larQ3m+aVihrVlQxBgfGcHBdZCsh8s/eIHCSWqaUVRWxuZHUnbwrcwSQAoIc0kN0fbyS
         8RNJ0jxiNEsXQZ3fhSZLzijd+WHLXD+eQONGb/3kwQMwoC7ta2kMLzopL2Q2wNLPCxqK
         GGqi1/RN+JY4faMjuqja2W94CteMGbTKpC/IC3uFauhtHv5B3ujJUyvB+xkhgRsKZP+P
         Qnup0XT1sUxBWUDLFIXh2vINN0SARWCr92mkdMNUr8UJ5EIH0IuCnd0Va/ArfR4naWrm
         4+pw==
X-Gm-Message-State: AOAM531eRI4WRNTUk8HHwO2cOVEik0ZR+exKek7djQ8Q9lmHSc/sABa9
        zpgpjvr8L8sy7ZimWC/O5JsHoPBxZh14H8VYb2eu8sEWOpPnrg==
X-Google-Smtp-Source: ABdhPJx8ypMXXH1YtbpgVAl2RgKTsFaZuQFz58EhPcAuoVh9tlYDxEh1btmMlaVFrwrfHosw4Pfd20j4lzbPcBJFg78=
X-Received: by 2002:a25:76c3:: with SMTP id r186mr25313590ybc.226.1610361311471;
 Mon, 11 Jan 2021 02:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20210109174013.534145-1-mkl@pengutronix.de> <20210109174013.534145-12-mkl@pengutronix.de>
 <CAMZ6RqKfVZ-Z10EK611NZots0Q61bJ6b5TPxSgWAv3nWo0+ryg@mail.gmail.com>
 <CAMZ6RqJ23-T8doazD+=0AO38VzetfudLWO3si+pO+mqE3vSgKw@mail.gmail.com>
 <20210111061335.39983-1-mailhol.vincent@wanadoo.fr> <28ab072d-a075-ce6b-6fed-a6d623a86a52@pengutronix.de>
In-Reply-To: <28ab072d-a075-ce6b-6fed-a6d623a86a52@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 11 Jan 2021 19:35:00 +0900
Message-ID: <CAMZ6Rq+irzbsiLP+bKL=h4JRh7pNXacwc9v4YO4NK=eNqOT3ew@mail.gmail.com>
Subject: Re: [PATCH] can: dev: extend can_put_echo_skb() to handle frame_len
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 11 Jan 2021 at 18:38, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 1/11/21 7:13 AM, Vincent Mailhol wrote:
> [...]
>
> > diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> > index 568dc28f7a4e..64bd2b60febc 100644
> > --- a/drivers/net/can/dev/skb.c
> > +++ b/drivers/net/can/dev/skb.c
> > @@ -38,7 +38,7 @@ void can_flush_echo_skb(struct net_device *dev)
> >   * priv->echo_skb, if necessary.
> >   */
> >  int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> > -                  unsigned int idx)
> > +                  unsigned int idx, unsigned int frame_len)
> >  {
> >       struct can_priv *priv = netdev_priv(dev);
> >
> > @@ -62,6 +62,10 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> >               skb->ip_summed = CHECKSUM_UNNECESSARY;
> >               skb->dev = dev;
> >
> > +             /* save frame_len to reuse it when transmission is completed */
> > +             if (frame_len)
> > +                     can_skb_prv(skb)->frame_len = frame_len;
> > +
>
> I think we can assign it unconditionally?

Ack, I prepare the v2 right away and post it in answer to this
message.

Will also rename the patch subject from
"can: dev: extend can_put_echo_skb() to handle frame_len"
to
"can: dev: can_put_echo_skb(): extend to store can frame length".

This way the name is more aligned with your patch "can: dev:
can_get_echo_skb(): extend to return can frame length".


Yours sincerely,
Vincent
