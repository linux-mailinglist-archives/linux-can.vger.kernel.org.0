Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C161859159F
	for <lists+linux-can@lfdr.de>; Fri, 12 Aug 2022 20:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiHLStY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Aug 2022 14:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiHLStY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Aug 2022 14:49:24 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642D5B275D
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2022 11:49:22 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 7so2862030ybw.0
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2022 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidbol-es.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=89MLYOqawB9W4poooJPyn/Aaefx7+Wl1AjLUIFjvFWw=;
        b=B1qB6FHSRUUb4buRI4b6GUEuQMy5S90zuvycSvG3s1ySlfDe6P1YifXBVlLrY0KnEo
         HqK1oIhPymW/U+ExRxRnm2dHD38CzUqqXf+b60Jp25z85Av/jjT5LjD83O4zhtzgf6lh
         v1W745qfAYXtUWdoWRc9pPQJnbG4VPcguOJBtG6JrIWXZZjC+XKF1Dq9bUrBpatgJ+GH
         VMS9gXK1Zb/7ngxEjwOkON2RsKG6QijWKgqyCXDeNWcrokgVl+UrGr5DwqSRcQXXCYwK
         ZK9ist1YXj5mVPznw9Y/d8T4p6ZNGk1p+do4M1D6A/hLaqoTxx6eXcBHSBFHfuXD5H72
         DFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=89MLYOqawB9W4poooJPyn/Aaefx7+Wl1AjLUIFjvFWw=;
        b=yIIaBqCRjOMGHwj2LCFAaJilOo9/iIQhgcyFM7IqYZrGop9xzKlfwJvNVIm/AyJxtC
         nTiyfGz+efmQT7NNmk8oueX/Lqh8TEmsXGbzQZpzFwa13Mm+Sj759aP4t8inFHKrIu8i
         DoErZtH05+lRQjRmdSsPiJH1yiqs8/PMsEc5q3WVVkyqRYKDMJ0FM42q6r9Z8VangH4U
         c5CstmRZhogk7EYDwrpp5q+KMZXn+1q5To6dRDW5IexQIxdlBHWF4imxWxH7R/Hyawff
         IfjW3u0/766E9Triw5u/79QfRZa140j7vCeuVOHD97/+kd9f2AkCOD7y1K0LNk7NBU4M
         xaGQ==
X-Gm-Message-State: ACgBeo1yNOi+tblQJXM7Wp+HDAE/6rXp4wfv7YVzu49n4oBglHD4oPSf
        8OilY0mBRoG1UZ6eQQnec1JhrgmY9G2IPjszOWZyEg==
X-Google-Smtp-Source: AA6agR6fAi/2210kITHvRQGrGfluQO2RJKLeiDqCGzOuZBSig4p8kUBU6jlu9+/iQ3/eGtpvzDU5+Uq8IBXadWJ6jOU=
X-Received: by 2002:a25:bfc3:0:b0:685:3142:ea1a with SMTP id
 q3-20020a25bfc3000000b006853142ea1amr471392ybm.331.1660330161566; Fri, 12 Aug
 2022 11:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAMgOUGpGEUQgLgAQmYbn-UdWXCkC7kRqdhW-mfg=e2gq9QfqRQ@mail.gmail.com>
 <20220810074530.or6oecnm7obmm7rh@pengutronix.de> <CAMgOUGoKHJnA5KLBE5_txgEBnC6LU3zNKkok7QEiMcrwQc0TvA@mail.gmail.com>
 <20220812123749.zqqn4kico5zai5ql@pengutronix.de>
In-Reply-To: <20220812123749.zqqn4kico5zai5ql@pengutronix.de>
From:   David Boles <me@davidbol.es>
Date:   Fri, 12 Aug 2022 11:49:10 -0700
Message-ID: <CAMgOUGrWnibVGA3UN77emGvFfz5N_pHGdhhjaQkvPgYMOGSfNw@mail.gmail.com>
Subject: Re: PCAN and SocketCAN Questions
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Tom Evans <thomasaevans@optusnet.com.au>,
        linux-can@vger.kernel.org, s.grosjean@peak-system.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

> See the code that the "-d" command line options activates :)

Ah, duh, sorry! I think I need to work on my google-fu; I hadn't come
across the SO_RXQ_OVFL option. That looks like exactly what I was
hoping for.

> We currently don't have an API for stopping/aborting CAN frames, the
> only thing you can do is ifdown/ifup the interface.

Unfortunate, but it's great to get a firm answer on that. I'll work
around it for now.

Thank you!

David

On Fri, Aug 12, 2022 at 5:37 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 11.08.2022 13:17:47, David Boles wrote:
> > Thank you Marc and Tom for your suggestions! I have a few follow-ups:
>
> I'm missing Tom's mail, seems it didn't make it to the mailing list.
>
> > # Question 1: Silently losing received frames if the socket isn't read
> > from frequently enough
> >
> > > See candump's "-d" command line option.
> >
> > Unfortunately it seems like this is happening at the layer of
> > individual sockets. Candump was already printing out messages that I
> > was "losing", and adding the -d flag doesn't affect its printout
> > (presumably since from its perspective, they haven't been dropped).
>
> See the code that the "-d" command line options activates :)
>
> | https://github.com/linux-can/can-utils/blob/master/candump.c#L650
>
> ... and add this to your app.
>
> > > Run your program at a lower NICE value
>
> You can try to receive several CAN frames with recvmmsg().
>
> > Good idea!
> >
> > > Make the queue as big as you can.
>
> I the socket drops CAN frames, this means there's not enough CPU time
> for your app to receive them all. You should look at your system and
> find out where the CPU time is lost.
>
> > Yep, that's what I'm currently doing. It's probably an acceptable
> > solution though not ideal; I'd like to be able to detect this
> > happening and fail noisily.
> >
> > # Question 2: Behavior of one-shot and presume-ack
> >
> > It sounds like one-shot doesn't retry in the event of other problems
> > (like losing arbitration) so that isn't what I want. It sounds like
> > presume-ack is what I wanted but is only supported by very few
> > devices, so I probably don't want to use it either.
> >
> > # New: Question 4
> >
> > I think the right course of action is to detect (either via
> > looped-back frames or maybe error frames, or something else) that my
> > transceiver is the only one on the bus and to stop sending messages
> > temporarily. I'd like to avoid sending excessively stale frames (e.g.
> > if a new transceiver joins the bus five minutes later, it shouldn't
> > receive a five minute old frame from me) and from my testing with
> > PCAN-USB dongles they seem to try resending a frame endlessly.
>
> We currently don't have an API for stopping/aborting CAN frames, the
> only thing you can do is ifdown/ifup the interface.
>
> > I'd
> > also like to avoid missing receiving frames transmitted by any new
> > transceivers on the bus. Is there any universal/reliable API for
> > clearing all transmit buffers for an interface, down to the device
> > itself, without affecting its ability to receive frames?
>
> No - currently there's only the down/up method.
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
