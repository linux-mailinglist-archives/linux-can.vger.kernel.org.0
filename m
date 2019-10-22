Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4067FE0CF0
	for <lists+linux-can@lfdr.de>; Tue, 22 Oct 2019 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfJVT64 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Oct 2019 15:58:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39366 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732972AbfJVT64 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Oct 2019 15:58:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id 195so14100050lfj.6
        for <linux-can@vger.kernel.org>; Tue, 22 Oct 2019 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NR3jvIoLvk4owe/bXBwmzK3qDEbNAfGkvCvOzU6x1M=;
        b=DIPhKw3zDXV2AsqyH+yb3IVKFzmYMWA55sUhNX0ssK//Y6GGaTjvyMMI3CVJZDf6M3
         2J+1q5rbmzgbRLfO0et/E6mmWyLkdu/fy99lvIJvXG+ZmycMsH4obkmZHKC3dDEZVawI
         rIV+9q60TGW/cb0p98/TJH1jVxJ8GpltI61f6OwsqXX2MEfH76tRL/7MFYFod5yF5xXt
         zrfzMcSIlGmBAurWOS/Dk0BRBiwc1VuGEVjzgheb86j7DP/0pomJGEwctyBnOm7OGUgp
         sjaa5iizNdXp2DkmsP1yTPnN7HTpp3ihogErSU0EZcXfmjvH5g1CQBAgEv/V9w3KkKlp
         cg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NR3jvIoLvk4owe/bXBwmzK3qDEbNAfGkvCvOzU6x1M=;
        b=NJsBZMiiMRx4lu6Koyf2xbGmzkGEPFv5bzZO9nUDvg7nvcDVYr4oB7kmdkkrAiCQdw
         BuP5K/XwjD6bR+ZkhBbmVkHnz5BWosh6cNiVAA1ImfsrWvQ6LP+iNIfYQIPYRQ4VaTKA
         qUtttRgyHGJpy3T2dL9tM5ognIPCCHgx4UfpHQlG6Q3ZhREHW4CX3iTetHGQCH6FZl24
         2wUK+amM21X4/ZNZlm/MmPIGaLCFaOhXN6QYKYm5zoDf5gAl2ZMN7zKvr/h3I1KjcOit
         0sUjt0JIYfcAZoWiBO51D7/8yKlnQgxT/YP7bV+sseDkYwlIfBY1l6atCEp8A2q5qCiG
         Wm8A==
X-Gm-Message-State: APjAAAUUl40XySkA3Dtv3Obu54eMQt5W8IgH+ch3WLU9ItzOl9OYfxYJ
        ZuDAX25BjIH1CAL6+eV7vKbdgB5/qPlBtjMwdNs=
X-Google-Smtp-Source: APXvYqyv9oKQD4ZGTVjT+etuhCdVr/khRXnz6pJfb9AWngnG3QCMDx586RX5LzJXUq3VHpYQWNal6A4l6GWNIcp5h+Q=
X-Received: by 2002:a19:ae18:: with SMTP id f24mr20744438lfc.186.1571774334181;
 Tue, 22 Oct 2019 12:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHChkrv6cKgNam-znKu_wOZm-y6gNkONmGWP6RFZpiSprq5_gQ@mail.gmail.com>
 <896bd824-1149-4229-a703-d2c946acd92b@pengutronix.de> <20191017074727.GA700@x1.vandijck-laurijssen.be>
 <CAHChkrsBMQy+=dQv-0JYqp7jrg3UvmQ_4JdR9WYrjAioNxfigw@mail.gmail.com>
 <CAHChkrs8iH4+2ZiQUjaD7B9CcqjfbeRG-_3R2uT+FWGSr5kGPA@mail.gmail.com> <20191017211604.GB27587@x1.vandijck-laurijssen.be>
In-Reply-To: <20191017211604.GB27587@x1.vandijck-laurijssen.be>
From:   Elenita Hinds <ecathinds@gmail.com>
Date:   Tue, 22 Oct 2019 14:58:42 -0500
Message-ID: <CAHChkrtRD-KLct4BU1mq7MRL3N7YKfNpoDERRnN6SG9d7dzptw@mail.gmail.com>
Subject: Re: c_can/d_can driver question
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Sorry for the delay.  Responses below ..

On Thu, Oct 17, 2019 at 4:16 PM Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
>
> Hey,
>
> On do, 17 okt 2019 15:37:04 -0500, Elenita Hinds wrote:
> > I pulled in the c_can patches from the for-kurt branch (63574e9 thru
> > bf01f717) and tested on my device.
> > The number of overruns are noticeably fewer; however, the overall
> > system performance seems to have slowed down. For example,
> > the console response and Bluetooth data rate are noticeably slower.
>
> You now give more precedence to CAN and less to console etc. ?
> >
[eh]  No. The priorities are the same or however Linux handles
interrupt priorities.

> > I also noticed that while the number of overruns decreased, the number
> > of errors increased:
>
> You have an interesting setup. I suspect that the FIFO is filled, and
> does drop messages, although that is recorded in the statistics?
>
> Would you want to try branch c_can-v4.9 in github.com/kurt-vd/linux?
> I improved the reception a bit, and increased the FIFO size.

[eh]  I pulled the c_can-v4.9 changes (delta from v4.9) and the
behavior is the same --
the number of overruns is reduced (about 0.011% loss compared to about
0.32%) but the number
of errors is increased (used to be the same number as the overruns).
I still see a slight degradation
in system performance.
I also tried the c_can-more-objects branch (increased the message
objects to 64) and this also
improved CAN handling (about to 0.004% overruns).
Then I combined both IRQ-rxoffload and more-objects changes together
and the number of overruns
is further reduced (loss is close to 0%).

> Besides that, can you give more details about your system and your load?

[eh] System is similar to Beagleboard Black: TI AM335x.
From 'top', running about 0% idle, with sys about 44%, usr about 43%,
sirq about 9%.
Load average: 4.70 4.88 4.04
Let me know if you need more info.

>
> Kind regards,
> Kurt
