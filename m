Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6693C30ED85
	for <lists+linux-can@lfdr.de>; Thu,  4 Feb 2021 08:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhBDHjm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Feb 2021 02:39:42 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:48530 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbhBDHjm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Feb 2021 02:39:42 -0500
X-ASG-Debug-ID: 1612424336-15c43457eb169890001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.126.125.adsl.dyn.edpnet.net [77.109.126.125]) by relay-b01.edpnet.be with ESMTP id EUvP0CTQFEIYVuYJ; Thu, 04 Feb 2021 08:38:56 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.126.125.adsl.dyn.edpnet.net[77.109.126.125]
X-Barracuda-Apparent-Source-IP: 77.109.126.125
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id E131D1242EC0;
        Thu,  4 Feb 2021 08:38:55 +0100 (CET)
Date:   Thu, 4 Feb 2021 08:38:39 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [Question] Sending CAN error frames
Message-ID: <20210204073839.GA24787@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [Question] Sending CAN error frames
Mail-Followup-To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        linux-can <linux-can@vger.kernel.org>
References: <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de>
 <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net>
 <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
 <ac8c4d3c-4261-8909-3481-abcd1d3bf43e@hartkopp.net>
 <CAMZ6RqKkeV6WRtfh65mDsYthuG1S+LD=kexAdcx=DeShf0T0YQ@mail.gmail.com>
 <d7584992-78a0-4be7-6b31-0bc1e4adfeca@hartkopp.net>
 <707944b7-f202-edb1-cb67-beedaeedfda0@gmail.com>
 <CAMZ6RqK_McbYNMqdb+zynH-CGaERFv5j5MgNd9X7MJBqu1f4Xw@mail.gmail.com>
 <20210203200614.GB23073@x1.vandijck-laurijssen.be>
 <CAMZ6RqLHGapeEk4oK2mTOZAa4fwMDNP_WVZbRRYBOh50eLU4Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLHGapeEk4oK2mTOZAa4fwMDNP_WVZbRRYBOh50eLU4Bg@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.126.125.adsl.dyn.edpnet.net[77.109.126.125]
X-Barracuda-Start-Time: 1612424336
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 4371
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.87735
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 04 Feb 2021 13:13:18 +0900, Vincent MAILHOL wrote:
> Hi Kurt,
> 
> On Tues 4 Feb. 2021 at 05:06, Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
> > On Wed, 03 Feb 2021 17:26:11 +0900, Vincent MAILHOL wrote:
> > > On Wed. 3 Feb 2021 at 15:42, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
> > > > >
> > > > > Of course we might also provide some pump gun mode which just sends an error flag at some (any) time.
> > > >
> > > > As above.
> > > >
> > > > > But for what reason?
> > > >
> > > > Testing purpose, e.g if you develop software where you want to keep track of bus errors, this makes it possible to test such software in a controlled way.
> > > > We also use this ourselves when testing the transitions ERROR_ACTIVE <-> ERROR_WARNING <-> ERROR_PASSIVE, for Rx.
> > >
> > > I think that there are two axes in this discussion: the attacker
> > > point of view and the functional testing point of view.
> > >
> > > From the attacker point of view, you are mostly interested in
> > > destroying the transmitter frames.
> > >
> > > For the functional testing, it is about covering the all the
> > > aspects of the standard: make sure that all the TX and RX counters
> > > are correctly incremented, test the transitions between the
> > > different states and that for all offsets. And to confirm all
> > > aspects, you might want to inject both the active and the passive
> > > error flags and do it at all possible positions.
> > >
> > > That said, my vision on functional testing is an uneducated
> > > guess. I never worked on that and my personal focus is more the
> > > attacker point of view.
> >
> > Looking back to it, my first interest would be to fire N error frames,
> > so to control other nodes' rx error counters.
> 
> It is slightly more complex.
> 
> Let's consider three nodes all on the same bus.
> 
> A: Test node, sends error flags
> B: Normal node, send normal frames
> C: Normal node, only receiving
> 
>    ___            ___            ___
>   | _ |          | _ |          | _ |
>   ||A||          ||B||          ||C||
>   |___|          |___|          |___|
>     |              |              |
>     | Sends        | Sends        | Only
>     | error           | normal       | receives
>     | flags        | frames       |
>     |              |              |
>   --------------------------------------- CAN bus
> 
> A waits for B to start sending its frame and trigger the error
> flag. This error flag will eventually overwrite one of B's recessive
> bit into a dominant one and thus B has his TX error count increased.t
> 
> C who is a spectator will just have its RX error count increased.

Right, I understand. I was too quick with my conclusion.
Thanks for explaining.

[...]

> > The attacker point of view indeed could require a more elaborate API,
> > but I still doubt we can deliver what is required for attacking.
> 
> This is interesting because we have an opposite view of the attacker
> and functional testing approaches.
> 
> For the attacker, I am thinking of:
> https://youtu.be/oajtDFw_t3Q
> In a nutshell, it is an elaborate technique in which you first DoS the
> target node by increasing its TX counter until it gets in bus-off
> state. Once done, the attacker can send messages in place of
> the genuine node. This way, contrary to an simple injection attack
> on which the bus contains both the genuine and the attacker frames,
> here, only the attacker speaks on the bus.
> This attack does not really care when the error flag occurs as long as
> the error counter increases.

Yep, I see.

I tend to program the nodes to recover from bus-off in 10msec
magnitude. The scenario you describe, if I understand well, is hard to
implement you need to repeat it every 10msec.

Am I mistaken?
Or is 10msec order rather stupid to recover and does everyone apply much
longer delays before recovery?

> 
> My vision of the functional testing is more: does the controller
> react correctly in all situations? You could imagine an implementation
> issue that would cause the error count to not correctly behave only on
> a specific field. How would you test for such implementation issues
> other than injecting the error flag at each offset of the frame?

ok

> 
> 
> Yours sincerely,
> Vincent
