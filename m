Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA1E30EB7C
	for <lists+linux-can@lfdr.de>; Thu,  4 Feb 2021 05:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBDEOM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Feb 2021 23:14:12 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:39596 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhBDEOL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Feb 2021 23:14:11 -0500
Received: by mail-yb1-f178.google.com with SMTP id k4so1873662ybp.6
        for <linux-can@vger.kernel.org>; Wed, 03 Feb 2021 20:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LXc0u53yIDqSCi9ewFG1CvB/2tGQsD3fWeT0oYFt59o=;
        b=uBWHoQN6KMQkVKyd3BkouIy6plz2xxQGH0zcXpKy3RcxRKEdDoR1N7t5CIpT5lsMbb
         7fftQIZv08Pkj47c4w7FH92GE47yXeWOIeZBVo5NfBTh4Foo+9kErFwmXu9Fb5QOySSH
         MfXUL/cox00qcVyDtf7r9KblOIk91O4Wf0gxV/q/D37jf1dvzUBo19lM02QmUznshRcU
         /kKS+GfewSDRX6MpOAKLygVoz3FFxcUsRyOXtrsHXuxDLLvmu6jO/IcgoxXrSVkBhf3f
         uNrgjwC+qkovrB+KcPDmo7bnf4ZhbM7IdpKm8q5sC5Op7mTeHZ5ApJOgmMbzzosbIG+p
         oA3g==
X-Gm-Message-State: AOAM5334ND8di0Zf/jzP5lTpPVJA5OGmzIbyDZnTsgCTBolUysQt6qQa
        f+znPqY6YeKhc1Kpl3o/MBG+LLEv7e4SwMOutA4=
X-Google-Smtp-Source: ABdhPJz9Au8jZv0z/grXE1XGetqhyKDQRkLyTts0IXgpITS8g7bfgfWjiJElybusJAqAA8+2mjqEwYquz/S+gic1mFQ=
X-Received: by 2002:a25:160a:: with SMTP id 10mr9234123ybw.226.1612412010045;
 Wed, 03 Feb 2021 20:13:30 -0800 (PST)
MIME-Version: 1.0
References: <8050d433-591c-2d1f-f0c7-ffa92e33032d@pengutronix.de>
 <cac31b51-514d-462b-fe48-4c3bea8b28fd@hartkopp.net> <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de>
 <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net> <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
 <ac8c4d3c-4261-8909-3481-abcd1d3bf43e@hartkopp.net> <CAMZ6RqKkeV6WRtfh65mDsYthuG1S+LD=kexAdcx=DeShf0T0YQ@mail.gmail.com>
 <d7584992-78a0-4be7-6b31-0bc1e4adfeca@hartkopp.net> <707944b7-f202-edb1-cb67-beedaeedfda0@gmail.com>
 <CAMZ6RqK_McbYNMqdb+zynH-CGaERFv5j5MgNd9X7MJBqu1f4Xw@mail.gmail.com> <20210203200614.GB23073@x1.vandijck-laurijssen.be>
In-Reply-To: <20210203200614.GB23073@x1.vandijck-laurijssen.be>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 4 Feb 2021 13:13:18 +0900
Message-ID: <CAMZ6RqLHGapeEk4oK2mTOZAa4fwMDNP_WVZbRRYBOh50eLU4Bg@mail.gmail.com>
Subject: Re: [Question] Sending CAN error frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Kurt,

On Tues 4 Feb. 2021 at 05:06, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
> On Wed, 03 Feb 2021 17:26:11 +0900, Vincent MAILHOL wrote:
> > On Wed. 3 Feb 2021 at 15:42, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
> > > >
> > > > Of course we might also provide some pump gun mode which just sends an error flag at some (any) time.
> > >
> > > As above.
> > >
> > > > But for what reason?
> > >
> > > Testing purpose, e.g if you develop software where you want to keep track of bus errors, this makes it possible to test such software in a controlled way.
> > > We also use this ourselves when testing the transitions ERROR_ACTIVE <-> ERROR_WARNING <-> ERROR_PASSIVE, for Rx.
> >
> > I think that there are two axes in this discussion: the attacker
> > point of view and the functional testing point of view.
> >
> > From the attacker point of view, you are mostly interested in
> > destroying the transmitter frames.
> >
> > For the functional testing, it is about covering the all the
> > aspects of the standard: make sure that all the TX and RX counters
> > are correctly incremented, test the transitions between the
> > different states and that for all offsets. And to confirm all
> > aspects, you might want to inject both the active and the passive
> > error flags and do it at all possible positions.
> >
> > That said, my vision on functional testing is an uneducated
> > guess. I never worked on that and my personal focus is more the
> > attacker point of view.
>
> Looking back to it, my first interest would be to fire N error frames,
> so to control other nodes' rx error counters.

It is slightly more complex.

Let's consider three nodes all on the same bus.

A: Test node, sends error flags
B: Normal node, send normal frames
C: Normal node, only receiving

   ___            ___            ___
  | _ |          | _ |          | _ |
  ||A||          ||B||          ||C||
  |___|          |___|          |___|
    |              |              |
    | Sends        | Sends        | Only
    | error           | normal       | receives
    | flags        | frames       |
    |              |              |
  --------------------------------------- CAN bus

A waits for B to start sending its frame and trigger the error
flag. This error flag will eventually overwrite one of B's recessive
bit into a dominant one and thus B has his TX error count increased.t

C who is a spectator will just have its RX error count increased.

The error count of node A is kind of undefined because the standard
does not expect you to generate your own errors. By default, I think
node A should *not* increase its counter if the error flag is generated
by itself on purpose so that it is free to mess on the bus as much as it
wants without going bus-off.

So sending error frames can increment either the TX or RX error
counters depending if the node is in transmitting or receiving at the
moment the error flag occurs.

> Controlling your own tx error counter makes less sense, I assume that if
> your chip is capable of triggering error frames on demand, then I also
> assume that the tx error counter detection is done right.

Any use cases toward your own chip (e.g. increasing your own TX
counter) is also not my interest. My idea of injecting the error flags
on your own frame is just to cover the error passive flag use cases in
order to see if *other* frames correctly handle the error passive
flag.

Passive error flags are indeed an edge case and if there is a
consensus that this feature is not needed (which seems to be the
case), I have no objection to not having it.

> destroying specific CAN frames sounds much like functional testing,
> and can be done much simpler by modifying the node that sends it and add
> some very ad-hoc test code to not send specific can frames at all.
>
> The attacker point of view indeed could require a more elaborate API,
> but I still doubt we can deliver what is required for attacking.

This is interesting because we have an opposite view of the attacker
and functional testing approaches.

For the attacker, I am thinking of:
https://youtu.be/oajtDFw_t3Q
In a nutshell, it is an elaborate technique in which you first DoS the
target node by increasing its TX counter until it gets in bus-off
state. Once done, the attacker can send messages in place of
the genuine node. This way, contrary to an simple injection attack
on which the bus contains both the genuine and the attacker frames,
here, only the attacker speaks on the bus.
This attack does not really care when the error flag occurs as long as
the error counter increases.

My vision of the functional testing is more: does the controller
react correctly in all situations? You could imagine an implementation
issue that would cause the error count to not correctly behave only on
a specific field. How would you test for such implementation issues
other than injecting the error flag at each offset of the frame?


Yours sincerely,
Vincent
