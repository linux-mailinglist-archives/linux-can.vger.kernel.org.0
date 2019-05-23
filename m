Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0BC27D28
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 14:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfEWMuX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 08:50:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56323 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWMuX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 08:50:23 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTnAr-0006Uy-1o; Thu, 23 May 2019 14:50:21 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTnAq-0001eu-CP; Thu, 23 May 2019 14:50:20 +0200
Date:   Thu, 23 May 2019 14:50:20 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: Re: [PATCH v1 00/17] introduce socket session queue support
Message-ID: <20190523125020.vgvzp5t27gjmnjgw@pengutronix.de>
References: <20190523094139.15517-1-o.rempel@pengutronix.de>
 <20190523102025.GC2318@x1.vandijck-laurijssen.be>
 <4e068cc6-76ae-d961-ea23-b0d7b32868bc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e068cc6-76ae-d961-ea23-b0d7b32868bc@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:49:35 up 5 days, 19:07, 29 users,  load average: 0.18, 0.06, 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, May 23, 2019 at 12:54:40PM +0200, Oleksij Rempel wrote:
> On 23.05.19 12:20, Kurt Van Dijck wrote:
> > On do, 23 mei 2019 11:41:22 +0200, Oleksij Rempel wrote:
> > > This patch series is a preparation and actual session queue support.
> > >  From now, we are able to use full available wmem of the socket and
> > > queue all requests if it is needed. The stack will process
> > > all queued requests in the FIFO order and notify user space application
> > > about error or completion over the errqueue interface.
> > 
> > I don't understand why it is necessary to queue single messages into a
> > FIFO and notify user space later on?
> 
> I'm not sure I understand this question. What type of message is "single
> messages" in your case?
> 1. Notification in user space are optional and should be enabled by
> application - there are no necessity in it.
> 2. If we need to keep order of queued messages there is no way you can
> predict if user space will put one or 100 messages in it, so every message
> go through the FIFO.
> 3. The feedback mechanism is provided for every type of message since it is
> possible to drop complete queue, so we are still able to notify user space
> about doped or send messages.
> 
> > Are you sure that different sockets still send asynchronous from each
> > other as long as TP/ETP is not involved?
> 
> Yes. It is per socket queue. First message in the queue are currently activated
> independent of each other.
> As soon as different sockets have same address and trying to start or queue a transfer
> with conflicting type, address and direction, current stack implementation
> will block/prevent second transfer to start.
> 
> The next step would be to implement dequeuing mechanism for conflicting
> transfers queued in different sockets.

A bit more information about implementation.

The stack creates a new session for each new send*()/write() request, independent
of the message size. Each session is queued in to the socket sk_session_queue.
The first entry of the queue is always the active/transferring session.
If the queue is empty, the session is immediately activated (start of transmission).
Activated session is registered in the per interface list of active sessions to
avoid start of conflicting transmissions. 
After end of transfer the session will activate next session of the
parent socket, if any session is available.

ASCII art would looks as follow:
/* socket queue */
[...10K..Pending][.8B.Pending][....1M...Active session]

The challenges will start as soon as user will decide to use different sockets
with same addresses, so we will have conflicting (E)TPs in different socket queues.

Here is one possible horror scenario:
Socket 1              [...N1] [|D|xxx.........A1]
Socket 2                 [p2...B1]
Socket 3                [p1..B1]->
Socket 4             [...B1]

A1 - is currently active (E)TP session
B1 - is a queued conflicting session which is blocked by A1.
p1 and p2 are priority set for different sockets or sessions.
In this use case all 4 sockets was bind() and connect()ed to same
addresses or sessions was configured with same addresses and have conflicting
message types.
Current implementation will abort conflicting transfers. The idea was to resolve
this conflicts in stack and activate them in per time and priority order. We should
guarantee only per socket order.

The question to is, do we actually need it? With current implementation the user space
application has all needed information to avoid this kind of conflicts. And a system
with multiple applications and same address seems to be a rare use case.

What is your experience with it?

David?

Kind regards,
Oleksij Rempel



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
