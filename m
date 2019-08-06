Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42FEE835A9
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2019 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfHFPuO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Aug 2019 11:50:14 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:39867 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728041AbfHFPuO (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 6 Aug 2019 11:50:14 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id F220744A0065;
        Tue,  6 Aug 2019 17:52:05 +0200 (CEST)
Date:   Tue, 6 Aug 2019 17:50:13 +0200
From:   David Jander <david@protonic.nl>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        robin@protonic.nl, linux-can@vger.kernel.org,
        kernel@pengutronix.de, wg@grandegger.com, romain.forlot@iot.bzh
Subject: Re: j1939: discussion: RX path (J1939_SOCK_RECV_OWN)
Message-ID: <20190806175013.779a6799@erd988>
In-Reply-To: <20190806125245.GA30994@pengutronix.de>
References: <20190625173137.GB8923@x1.vandijck-laurijssen.be>
        <20190626091524.40410c4b@erd988>
        <20190626130012.GC8923@x1.vandijck-laurijssen.be>
        <20190626160238.5d62fc15@erd988>
        <20190627093353.GA693@x1.vandijck-laurijssen.be>
        <20190627105901.GA24805@pengutronix.de>
        <20190627140849.39916a65@erd988>
        <20190722091328.GA24349@pengutronix.de>
        <20190722133723.GA17189@pengutronix.de>
        <e3197f96-48de-7887-7a04-eef75fd6a6a3@pengutronix.de>
        <20190806125245.GA30994@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 6 Aug 2019 14:52:45 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi all,
> 
> On Tue, Jul 23, 2019 at 10:59:07AM +0200, Marc Kleine-Budde wrote:
> > On 7/22/19 3:37 PM, Oleksij Rempel wrote:  
> > > We just noticed, in current implementation J1939_SOCK_RECV_OWN doesn't
> > > work anymore (for ETP). And ...naively thinking it probably makes no
> > > sense to support it for different reasons:
> > > 
> > > - we have a better feedback mechanism via the error queue feature
> > > - with RECV_OWN the socket receives the complete payload back into user
> > >   space, where the error queue will give back message number at state of
> > >   the message/transfer.
> > > - the error queue mechanism is extendable with more information and even
> > >   backwards compatible.
> > > 
> > > However in the current implementation you'll receive an ACK via error
> > > queue if the (E)TP transfer is completed, but for simple messages, the
> > > ACK is received as soon as the packet has been put into the packet
> > > scheduler. It would be better to wait and send the ACK only after the
> > > simple message has been send onto the wire (i.e.: after the CAN
> > > controller's TX-complete interrupt).
> > > 
> > > We'll remove J1939_SOCK_RECV_OWN for now.
> > > 
> > > But we already noticed that this will break jacd, however we think we
> > > can fix it, by using a separate socket to receive. Are there any other
> > > use cases or existing applications relying on this feature?  
> > 
> > I think in AGL they switch on self reception of j1939 sockets by default.  
> 
> I have implemented missing functionality to monitor and "ACK" simple
> (<9 byte) packages. Users space will get same kind of notifications over
> the error queue:
> - SCHED - means, the packages was scheduled and will be soon taken over
>   by hardware for transmission to the CAN bus.
> - ACK - CAN HW transmitted the package and send the echo signal back to
>   the J1939 stack.
> - ABORT - we was no able to schedule the package or receive the
>   transmit confirmation.

Does that mean that for every message sent by user-space, user-space will get
woken up two more times?
This sounds like a lot of context switching overhead to me... I hope SCHED
and/or ACK can be disabled?

> In current kernel implementation, ABORT can be not 100% true. In case
> CAN bus is open and get "fixed"/closed after some time, ABORTed packages
> still may be transmitted to the bus. With current J1939 implementation
> we are able to detect it. In kernel log you will see:
> flexcan 2090000.flexcan can0: j1939_simple_recv: Received already
> invalidated message
> 
> This issue can be fixed, at least for some drivers or hardware, in the CAN
> framework (not in J1939 stack).
> 
> Since this problem was present with previous J1939 stack version and
> no good way to track transmitted packages, I don't see it as a regression.
> 
> The jacd needed a 3 line change to make it work without
> J1939_SOCK_RECV_OWN flag. So, probably other projects, we be able to fix
> it as well.

Best regards,

-- 
David Jander
Protonic Holland.
