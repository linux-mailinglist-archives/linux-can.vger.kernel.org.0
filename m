Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4405915B8
	for <lists+linux-can@lfdr.de>; Fri, 12 Aug 2022 21:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiHLTAW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Aug 2022 15:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbiHLTAR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Aug 2022 15:00:17 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EFC30F
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2022 12:00:15 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id k12so2843230ybk.6
        for <linux-can@vger.kernel.org>; Fri, 12 Aug 2022 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidbol-es.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mZirgoP3hBmjCEZe/Dg5Qw+YiUMP9piDgRTUkjnI8s4=;
        b=sfHmGKyN0OKklZKDPa82jzXHtQBtemDOAsdBKZ5djyzYcafgxRw/ufY6beI4vx68gh
         /k2rQUZuQN5sXxBhGw+8NyKSwMvOyaaV36LA+xcGJayjdRSQaXXmCNO1fIS3WRHPuh7N
         5lVHxBmfibq7siWWYRcJP4ngBc/Hi8rw7cQxc7od58W+NHk7BMIqxMP8u+fTt5iKq41X
         H3wsaJCTN+iFJEyl+e6AGzbC16HpMILwtm+KvSe80U0vlCGQhRg6bLnJCnC6lUYyQQig
         itDO26F1lC/D8j+QCHzVNHKhzgvthYV5BiOPLo4S5c6wmQJVGukNqv5dZotsWOt2nSta
         f0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mZirgoP3hBmjCEZe/Dg5Qw+YiUMP9piDgRTUkjnI8s4=;
        b=B6c2z5z4Mpfdc7Xg05j4X1h3CdLEZhHAy9QDo+tRwLG/2Uf7c/aAnLlwZIcaQZDQU4
         mSJgTtwhqI4vCUo3AFpZzDcDVEROqJy0J9Tjilu29qj8Oi9LLHwW/aIym8AXFKZwovbH
         Ds5Q0o6Pjuihb+PBa7qzLSRz8vesdzHtHM+IBMfHEg74fR9ip4XwRiH0TPQPLnZzBLfV
         PUUKQmvleluIG7mcae4y7iULgmdEACkg/guXlliOYr2EFeomPLYhhTC2fn141miRKOeF
         3xCVl9iG/pnwzA8CgsvRWq2NlB3SyeP/t8zOsP1GYlUXM5/gqZ8G2YRfXgcBYsZbqgd9
         spgw==
X-Gm-Message-State: ACgBeo3hTYEuolPPFAef+NlGHifnSaZF8iNqc6LBdyrrJ8IqbtXFGyIb
        D70nxYdTgflA9I7a9tcxEy3aljVSkhr/fF8QKcqlYWSKgI2BeQ==
X-Google-Smtp-Source: AA6agR7P5OCw/vtmvpsj4q8vo8ZC4tTMwDvITx9Xkh3YJ8hheeGjRhybKwXBv8l/zi8fwHy68PdsFz9DXrMdsdeauZE=
X-Received: by 2002:a5b:591:0:b0:66d:edde:4ca with SMTP id l17-20020a5b0591000000b0066dedde04camr4460861ybp.641.1660330815130;
 Fri, 12 Aug 2022 12:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAMgOUGpGEUQgLgAQmYbn-UdWXCkC7kRqdhW-mfg=e2gq9QfqRQ@mail.gmail.com>
 <20220810074530.or6oecnm7obmm7rh@pengutronix.de> <CAMgOUGoKHJnA5KLBE5_txgEBnC6LU3zNKkok7QEiMcrwQc0TvA@mail.gmail.com>
 <20220812123749.zqqn4kico5zai5ql@pengutronix.de> <86dffcf2-e79d-e32a-bdcf-404ee8f7dd22@hartkopp.net>
In-Reply-To: <86dffcf2-e79d-e32a-bdcf-404ee8f7dd22@hartkopp.net>
From:   David Boles <me@davidbol.es>
Date:   Fri, 12 Aug 2022 12:00:04 -0700
Message-ID: <CAMgOUGrT0V2hdUSj-1ktP_JZPLWnpWzTUTjmaTOr-gCoraw_yg@mail.gmail.com>
Subject: Re: PCAN and SocketCAN Questions
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Tom Evans <thomasaevans@optusnet.com.au>,
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

Hi Oliver,

> Can you probably tell me more about your use-case?

> The last time I had your described issues, I was routing CAN frames via
> userspace - which finally led to the implementation of the can-gw module ;-)

Yep! Excellent guess :D For a few different reasons, that's basically
what I'm hoping to do. If it doesn't work out, I'll definitely dig
into your suggestions.

> All these measures seem to be the last solution when nothing else helped.

Fortunately I haven't actually had a problem with keeping up with
receiving frames, I was just hoping for something a little more robust
than "configure a large buffer and assume that your program is keeping
up because it has before". SO_RXQ_OVFL sounds like the correct answer
for me.

Thank you!

David

On Fri, Aug 12, 2022 at 6:01 AM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hello David,
>
> On 12.08.22 14:37, Marc Kleine-Budde wrote:
> > On 11.08.2022 13:17:47, David Boles wrote:
>
> >> Unfortunately it seems like this is happening at the layer of
> >> individual sockets. Candump was already printing out messages that I
> >> was "losing", and adding the -d flag doesn't affect its printout
> >> (presumably since from its perspective, they haven't been dropped).
> >
> > See the code that the "-d" command line options activates :)
> >
> > | https://github.com/linux-can/can-utils/blob/master/candump.c#L650
> >
> > ... and add this to your app.
> >
> >>> Run your program at a lower NICE value
> >
> > You can try to receive several CAN frames with recvmmsg().
> >
> >> Good idea!
> >>
> >>> Make the queue as big as you can.
> >
> > I the socket drops CAN frames, this means there's not enough CPU time
> > for your app to receive them all. You should look at your system and
> > find out where the CPU time is lost.
>
> All these measures seem to be the last solution when nothing else helped.
>
> Can you probably tell me more about your use-case?
>
> 1. e.g. when you are using the CAN_RAW socket: Do you set CAN filters to
> pass only needed content into userspace?
>
> When you drop 50% of the CAN IDs in userspace you still have to transfer
> them from kernelspace to userspace and check if you should drop them.
>
> 2. when you need to filter for updates in specific content in the CAN
> frames data[] section the CAN_BCM socket is your friend. Especially for
> cyclic sent CAN messages e.g. in automotive use-cases.
>
> 3. When you need to forward and/or modify CAN frames between CAN
> interfaces there is a special netlink-based in-kernel CAN-Gateway which
> can be controlled by the 'cangw' tool.
>
> The last time I had your described issues, I was routing CAN frames via
> userspace - which finally led to the implementation of the can-gw module ;-)
>
> Best regards,
> Oliver
>
>
