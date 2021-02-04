Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83AB30EFDB
	for <lists+linux-can@lfdr.de>; Thu,  4 Feb 2021 10:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhBDJnN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Feb 2021 04:43:13 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:36615 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhBDJnL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Feb 2021 04:43:11 -0500
Received: by mail-yb1-f177.google.com with SMTP id c3so2563302ybi.3
        for <linux-can@vger.kernel.org>; Thu, 04 Feb 2021 01:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qouW9G/Cd0UVop1LnGxEcMi73zBn6g+Q8IR9ZlzNgMM=;
        b=NzMa9YfNzSyg0mtzERT67choclMdp7fJhoX5uXj8ca5JiZUGdKoJbCaEU+sFLjmAyN
         asgzkCh5ElcTMYddNCzbyJpgiDoYz8c8Q2ea3zN64j6K42kwl95prShxbVyIDlMl9dKc
         1MTl4B7C28d2uw7Fcqyr1UPqrYXc6Amdhzr+e85+zVUGIju9JUTakIPb2H6RT16WdYwN
         KxuTy44x5A8SNGIUIGWh3CiN1oPVWSUAs8WHn9WVhoF+Wcri5cbYXk899DA+dupWSKxz
         StRQSASAGEBz7X4RHCyMWvY4eNECM6LbRI4l86My4XlZPYoDojU1BpPSIeexnh/ld9W3
         qhew==
X-Gm-Message-State: AOAM531DOwYB0BpOrEp9Rtn9uugTCnc8Uily+v5Krho6/TTyQHNXaZpE
        +xOZlqgNr0/VINlp6A01LNkXr9VK50adx76ee94=
X-Google-Smtp-Source: ABdhPJzcp0IJTkavuihejU0Si9Kni+FQuj8IvGCk7WhDFguxbjUfsvyzoHqGoNB1PFE7h6q42cOtm1iPlJcPoY2QAMA=
X-Received: by 2002:a25:84cc:: with SMTP id x12mr10574394ybm.487.1612431750494;
 Thu, 04 Feb 2021 01:42:30 -0800 (PST)
MIME-Version: 1.0
References: <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de>
 <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net> <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
 <ac8c4d3c-4261-8909-3481-abcd1d3bf43e@hartkopp.net> <CAMZ6RqKkeV6WRtfh65mDsYthuG1S+LD=kexAdcx=DeShf0T0YQ@mail.gmail.com>
 <d7584992-78a0-4be7-6b31-0bc1e4adfeca@hartkopp.net> <707944b7-f202-edb1-cb67-beedaeedfda0@gmail.com>
 <CAMZ6RqK_McbYNMqdb+zynH-CGaERFv5j5MgNd9X7MJBqu1f4Xw@mail.gmail.com>
 <20210203200614.GB23073@x1.vandijck-laurijssen.be> <CAMZ6RqLHGapeEk4oK2mTOZAa4fwMDNP_WVZbRRYBOh50eLU4Bg@mail.gmail.com>
 <20210204073839.GA24787@x1.vandijck-laurijssen.be>
In-Reply-To: <20210204073839.GA24787@x1.vandijck-laurijssen.be>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 4 Feb 2021 18:42:19 +0900
Message-ID: <CAMZ6Rq+kea0sP7H1tRa83dNruWwoD-74W0U_FgUdYv35ejCuUw@mail.gmail.com>
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

On Thu. 4 Feb 2021 at 16:38, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
>
> On Thu, 04 Feb 2021 13:13:18 +0900, Vincent MAILHOL wrote:
> > Hi Kurt,
> >
> > On Tues 4 Feb. 2021 at 05:06, Kurt Van Dijck
> > <dev.kurt@vandijck-laurijssen.be> wrote:
> > > On Wed, 03 Feb 2021 17:26:11 +0900, Vincent MAILHOL wrote:
> > > > On Wed. 3 Feb 2021 at 15:42, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
> > > > > >
> > > > > > Of course we might also provide some pump gun mode which just sends an error flag at some (any) time.
> > > > >
> > > > > As above.
> > > > >
> > > > > > But for what reason?
> > > > >
> > > > > Testing purpose, e.g if you develop software where you want to keep track of bus errors, this makes it possible to test such software in a controlled way.
> > > > > We also use this ourselves when testing the transitions ERROR_ACTIVE <-> ERROR_WARNING <-> ERROR_PASSIVE, for Rx.
> > > >
> > > > I think that there are two axes in this discussion: the attacker
> > > > point of view and the functional testing point of view.
> > > >
> > > > From the attacker point of view, you are mostly interested in
> > > > destroying the transmitter frames.
> > > >
> > > > For the functional testing, it is about covering the all the
> > > > aspects of the standard: make sure that all the TX and RX counters
> > > > are correctly incremented, test the transitions between the
> > > > different states and that for all offsets. And to confirm all
> > > > aspects, you might want to inject both the active and the passive
> > > > error flags and do it at all possible positions.
> > > >
> > > > That said, my vision on functional testing is an uneducated
> > > > guess. I never worked on that and my personal focus is more the
> > > > attacker point of view.
> > >
> > > Looking back to it, my first interest would be to fire N error frames,
> > > so to control other nodes' rx error counters.
> >
> > It is slightly more complex.
> >
> > Let's consider three nodes all on the same bus.
> >
> > A: Test node, sends error flags
> > B: Normal node, send normal frames
> > C: Normal node, only receiving
> >
> >    ___            ___            ___
> >   | _ |          | _ |          | _ |
> >   ||A||          ||B||          ||C||
> >   |___|          |___|          |___|
> >     |              |              |
> >     | Sends        | Sends        | Only
> >     | error           | normal       | receives
> >     | flags        | frames       |
> >     |              |              |
> >   --------------------------------------- CAN bus
> >
> > A waits for B to start sending its frame and trigger the error
> > flag. This error flag will eventually overwrite one of B's recessive
> > bit into a dominant one and thus B has his TX error count increased.t
> >
> > C who is a spectator will just have its RX error count increased.
>
> Right, I understand. I was too quick with my conclusion.
> Thanks for explaining.
>
> [...]
>
> > > The attacker point of view indeed could require a more elaborate API,
> > > but I still doubt we can deliver what is required for attacking.
> >
> > This is interesting because we have an opposite view of the attacker
> > and functional testing approaches.
> >
> > For the attacker, I am thinking of:
> > https://youtu.be/oajtDFw_t3Q
> > In a nutshell, it is an elaborate technique in which you first DoS the
> > target node by increasing its TX counter until it gets in bus-off
> > state. Once done, the attacker can send messages in place of
> > the genuine node. This way, contrary to an simple injection attack
> > on which the bus contains both the genuine and the attacker frames,
> > here, only the attacker speaks on the bus.
> > This attack does not really care when the error flag occurs as long as
> > the error counter increases.
>
> Yep, I see.
>
> I tend to program the nodes to recover from bus-off in 10msec
> magnitude. The scenario you describe, if I understand well, is hard to
> implement you need to repeat it every 10msec.
>
> Am I mistaken?
> Or is 10msec order rather stupid to recover and does everyone apply much
> longer delays before recovery?

I can not comment on what is the best bus-off reset value. I never had
the opportunity to build my own FPGA and to try those kinds of
attacks. I know more about the theory than the practice.

Also, I do not know what kind of bus-off reset values are used by
OEMs in their production vehicles.

That said, if you are building a safety critical network, my
recommendation is to enforce message authentication. This is
typically achieved with Autosar Secure Onboard
communication (SecOC).
That way, an attacker might still DoS your ECU but he or she will not
be able to inject messages.

For me, the bus-off reset is a safety topic. Using it for security
design is not something I recommend.

> > My vision of the functional testing is more: does the controller
> > react correctly in all situations? You could imagine an implementation
> > issue that would cause the error count to not correctly behave only on
> > a specific field. How would you test for such implementation issues
> > other than injecting the error flag at each offset of the frame?
>
> ok

Let me try to recenter the discussion.

In the light of everyone comments, I now propose the
CAN_CTRLMODE_TX_ERR API to be as below:

  - allow to inject error active flags only (by consensus, error
    passive flags are not needed).

  - allow to inject error flags during either bus idle state or while
    other nodes are transmitting (but not be able to inject error
    flags while it is itself transmitting).

  - allow to target a specific CAN ID. The filtering option does not
    need to be complex. I propose to just match the CAN ID (including
    EFF flag).

  - allow to inject the flag at one specific offset in the frame.

  - when generating error flags, the device does not increase its
    tx/rx error count.

Thanks for your comments!


Yours sincerely,
Vincent
