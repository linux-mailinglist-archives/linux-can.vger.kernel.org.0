Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2851F902B
	for <lists+linux-can@lfdr.de>; Mon, 15 Jun 2020 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgFOHnK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 Jun 2020 03:43:10 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:47165 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgFOHnK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Jun 2020 03:43:10 -0400
X-ASG-Debug-ID: 1592206987-0a7b8d5f4212503a0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be ([213.219.130.186]) by relay-b02.edpnet.be with ESMTP id 6RI1LaFyxu65wNbt; Mon, 15 Jun 2020 09:43:07 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[213.219.130.186]
X-Barracuda-Apparent-Source-IP: 213.219.130.186
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id DD358F5A6B5;
        Mon, 15 Jun 2020 09:43:00 +0200 (CEST)
Date:   Mon, 15 Jun 2020 09:42:57 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     David Jander <david@protonic.nl>, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de
Subject: Re: j1939: root requirements for messages with the priorities 0 & 1
Message-ID: <20200615074257.GA15385@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: j1939: root requirements for messages with the priorities 0 & 1
Mail-Followup-To: Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de
References: <20190625173137.GB8923@x1.vandijck-laurijssen.be>
 <20190626091524.40410c4b@erd988>
 <20190626130012.GC8923@x1.vandijck-laurijssen.be>
 <20190626160238.5d62fc15@erd988>
 <20190627093353.GA693@x1.vandijck-laurijssen.be>
 <20190627105901.GA24805@pengutronix.de>
 <20190627140849.39916a65@erd988>
 <20190722091328.GA24349@pengutronix.de>
 <20190722133723.GA17189@pengutronix.de>
 <20200612100320.u7tixjjcb2dxmo4d@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200612100320.u7tixjjcb2dxmo4d@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: UNKNOWN[213.219.130.186]
X-Barracuda-Start-Time: 1592206987
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1761
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5013 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82561
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On vr, 12 jun 2020 12:03:20 +0200, Oleksij Rempel wrote:
> Hello all,
> 
> We have following issues reported on can-utils:
> https://github.com/linux-can/can-utils/issues/217
> ===============================================================================
> This is a follow-up of the issue #159 .
> 
> When testing the priorities, I noticed, that for the priorities 0 and 1,
> the message occurs, that setting the priority is not permitted:
> 
>   ./testj1939 -B -s -p3 vcan0:0x80 :,0x0200
> 
> Works ok.
> 
>   ./testj1939 -B -s -p1 vcan0:0x80 :,0x0200
>   testj1939: set priority 1: Operation not permitted
> 
>   ./testj1939 -B -s -p0 vcan0:0x80 :,0x0200
>    testj1939: set priority 0: Operation not permitted
> 
> I am not aware that the priorities 0 & 1 are not permitted.
> 
> > Originally posted by @marckleinebudde in #159 (comment):
> > Priorities 0 and 1 are only permitted for root or users with
> > capable(CAP_NET_ADMIN), see:
> 
> > https://elixir.bootlin.com/linux/latest/source/net/can/j1939/socket.c#L705
> 
> > I think this limit is arbitrary and we can discuss if
> > this makes sense at all or add this to the
> > documentation.

If I remember well, there is a similar restriction for ethernet or IP
priorities.
It's true that this limit is arbritrary.
It's based on me never having seen intended prio 0 or 1 messages on a bus,
but only as a result of 'we forgot to set the priority'.

The goal is to avoid people using 0 as a default without further attention.
I think that this could be replaced by some kind of setsockopt call,
that sets the highest allowed priority, without ever requiring root.
The initial default would then be 2 (or any other value, but 2 seems
feasible to me).

Kurt
