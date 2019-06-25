Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19553555EF
	for <lists+linux-can@lfdr.de>; Tue, 25 Jun 2019 19:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfFYRbt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jun 2019 13:31:49 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:41687 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfFYRbs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Jun 2019 13:31:48 -0400
X-ASG-Debug-ID: 1561483899-0a88186e2255400001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.103.163.adsl.dyn.edpnet.net [77.109.103.163]) by relay-b03.edpnet.be with ESMTP id aY0KvRTgfXujeEU2; Tue, 25 Jun 2019 19:31:39 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Apparent-Source-IP: 77.109.103.163
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 35F578CCB12;
        Tue, 25 Jun 2019 19:31:39 +0200 (CEST)
Date:   Tue, 25 Jun 2019 19:31:37 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     David Jander <david@protonic.nl>, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de, wg@grandegger.com
Subject: Re: j1939: discussion: RX path
Message-ID: <20190625173137.GB8923@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: j1939: discussion: RX path
Mail-Followup-To: Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de, wg@grandegger.com
References: <20190625073009.GA15948@pengutronix.de>
 <20190625104315.57172f69@erd988>
 <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Start-Time: 1561483899
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 3037
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5724 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73108
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 25 jun 2019 10:54:55 +0200, Oleksij Rempel wrote:
> On 25.06.19 10:43, David Jander wrote:
> >On Tue, 25 Jun 2019 09:30:09 +0200
> >Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> >>Hello all,
> >>
> >>We already had a discussion about the J1939 use case for server
> >>implementation. Short description of the challenge will looks as follow:
> >>- main socket is listening on DST address and PGN.
> >>- as soon as connection was requested from peer the server will
> >>   create new connect()ed socket with SRC, DST addresses and PGN.
> >>
> >>With current stack implementation both sockets (main and connected) will
> >>receive same packages. At least with huge packages it will start to be
> >>not really good :).
> >>
> >>To solve this issue we have following variants:
> >>variant a:
> >>  - all sockets can receive everything (as currently implemented)
> >>variant b:
> >>  - only one socket will receive specific tuple. In this case kernel
> >>    should calculate RX "priority". Only highest priority will RX packet.
> >>    - all sockets with same priority will receive the matching packet
> >>    - socket option promisc == same priority as exact match
> >
> >How is this "priority" determined?
> >Something like this:
> >
> >  for each socket:
> >	 prio = 0
> >	 listening on same DST or PGN ==> prio++
> >	 listening on same DST and PGN ==> prio++
> >	 connect()ed to same SRC ==> prio++
> >  deliver frame to socket(s) with highest prio.
> >
> >Is that what you mean?
> 
> ACK.

I don't like any of these.

The problem you try to solve is 'huge packet duplication where it is
probably not required'.
Your proposed solution puts a policy in the kernel that goes in serious
conflict with a multiuser system. It is driven by a typical
implementation, but did not address the problem you try to solve.

In order to avoid receiving huge packets where we suspect it is not
really wanted, we should not try to guess what 'a' program wants, nor
implement rules that apply to 1 specific case.
Instead, we should protect sockets from receiving huge packets.

Why not add a socket option, that implements a ceiling on the
size of received packets.
If that defaults to, let's say, 1785 bytes, so anyone will out of the
box receive all TP sessions, but no ETP session, then the user will not
be really supprised, and we need to make only 1 clear decision during delivery.

I honestly think that my proprosal puts way less decision policy in the
kernel code, and effectively addresses the problem you tried to solve,
without adding unnecessary multi-user restrictions.

What's your thought?
Kurt

> 
> Kind regards,
> Oleksij Rempel
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
