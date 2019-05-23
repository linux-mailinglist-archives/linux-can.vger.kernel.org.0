Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1434427EC3
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfEWNvR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 09:51:17 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:33178 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730323AbfEWNvR (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 May 2019 09:51:17 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id DFE2544A0026;
        Thu, 23 May 2019 15:52:52 +0200 (CEST)
Date:   Thu, 23 May 2019 15:51:15 +0200
From:   David Jander <david@protonic.nl>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl
Subject: Re: [PATCH v1 00/17] introduce socket session queue support
Message-ID: <20190523155115.3f0955e6@erd988>
In-Reply-To: <20190523125020.vgvzp5t27gjmnjgw@pengutronix.de>
References: <20190523094139.15517-1-o.rempel@pengutronix.de>
        <20190523102025.GC2318@x1.vandijck-laurijssen.be>
        <4e068cc6-76ae-d961-ea23-b0d7b32868bc@pengutronix.de>
        <20190523125020.vgvzp5t27gjmnjgw@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 23 May 2019 14:50:20 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Thu, May 23, 2019 at 12:54:40PM +0200, Oleksij Rempel wrote:
> > On 23.05.19 12:20, Kurt Van Dijck wrote:  
> > > On do, 23 mei 2019 11:41:22 +0200, Oleksij Rempel wrote:  
> > > > This patch series is a preparation and actual session queue support.
> > > >  From now, we are able to use full available wmem of the socket and
> > > > queue all requests if it is needed. The stack will process
> > > > all queued requests in the FIFO order and notify user space application
> > > > about error or completion over the errqueue interface.  
> > > 
> > > I don't understand why it is necessary to queue single messages into a
> > > FIFO and notify user space later on?  
> > 
> > I'm not sure I understand this question. What type of message is "single
> > messages" in your case?
> > 1. Notification in user space are optional and should be enabled by
> > application - there are no necessity in it.
> > 2. If we need to keep order of queued messages there is no way you can
> > predict if user space will put one or 100 messages in it, so every message
> > go through the FIFO.
> > 3. The feedback mechanism is provided for every type of message since it is
> > possible to drop complete queue, so we are still able to notify user space
> > about doped or send messages.
> >   
> > > Are you sure that different sockets still send asynchronous from each
> > > other as long as TP/ETP is not involved?  
> > 
> > Yes. It is per socket queue. First message in the queue are currently activated
> > independent of each other.
> > As soon as different sockets have same address and trying to start or queue a transfer
> > with conflicting type, address and direction, current stack implementation
> > will block/prevent second transfer to start.
> > 
> > The next step would be to implement dequeuing mechanism for conflicting
> > transfers queued in different sockets.  
> 
> A bit more information about implementation.
> 
> The stack creates a new session for each new send*()/write() request, independent
> of the message size. Each session is queued in to the socket sk_session_queue.
> The first entry of the queue is always the active/transferring session.
> If the queue is empty, the session is immediately activated (start of transmission).
> Activated session is registered in the per interface list of active sessions to
> avoid start of conflicting transmissions. 
> After end of transfer the session will activate next session of the
> parent socket, if any session is available.
> 
> ASCII art would looks as follow:
> /* socket queue */
> [...10K..Pending][.8B.Pending][....1M...Active session]
> 
> The challenges will start as soon as user will decide to use different sockets
> with same addresses, so we will have conflicting (E)TPs in different socket queues.
> 
> Here is one possible horror scenario:
> Socket 1              [...N1] [|D|xxx.........A1]
> Socket 2                 [p2...B1]
> Socket 3                [p1..B1]->
> Socket 4             [...B1]
> 
> A1 - is currently active (E)TP session
> B1 - is a queued conflicting session which is blocked by A1.
> p1 and p2 are priority set for different sockets or sessions.
> In this use case all 4 sockets was bind() and connect()ed to same
> addresses or sessions was configured with same addresses and have conflicting
> message types.
> Current implementation will abort conflicting transfers. The idea was to resolve
> this conflicts in stack and activate them in per time and priority order. We should
> guarantee only per socket order.
> 
> The question to is, do we actually need it? With current implementation the user space
> application has all needed information to avoid this kind of conflicts. And a system
> with multiple applications and same address seems to be a rare use case.
> 
> What is your experience with it?
> 
> David?

Like I explained previously, scenarios I can come up with are related to
possibly an IsoBus file-server and -clients. If a file-server has more than one
client connected, we can have a situation where the server sends two (E)TP
sessions simultaneously to two different clients each, while also at the same
time broadcast status messages at a fixed interval (so in-between the two
(E)TP sessions).
The big question is: how to accomplish that exactly? Some possibilities:

 1.- Server bind()s to his NAME and client-to-server PGN. Each request he
 receives from a client is replied with a send_to() on that socket. The above
 solution, AFAICS, would not allow that, because replies to two different
 clients could not be sent simultaneously if there is one queue per socket.

 2.- Server bind()s to his NAME and client-to-server PGN. When a request from
 a new client comes in, a new socket is opened and connect()ed to that client
 with the server-to-client PGN. This socket is kept open as long as the client
 connection lasts. The connection is defined to last as long as there is no
 time-out on the periodic "Client Connection Maintenance" messages incoming
 from the client. So this might work with the proposed queueing. The server
 would possess as many open socket as there are clients connected plus one
 (for broadcast messages (status) and incoming data). AFAICS this is pretty
 similar to how a TCP/IP server would do this also, except for the
 listen/accept part, and the fact that on TCP/IP one receives data on the same
 socket as one sends, right?

Option 2 above brings me to another question:
What happens when said server bind()s to the client-to-server PGN on more than
one socket? Which one will receive incoming data? Both? Or is this not allowed?

As for a use-case of simultaneous TP + ETP from the same source to the same
destination, I don't have a use-case right now, but since it is _technically_
possible according to the standard, I still believe that it is desirable to
have that possibility in the kernel implementation.

Best regards,

-- 
David Jander
Protonic Holland.
