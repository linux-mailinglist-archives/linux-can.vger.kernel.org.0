Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967C3569E8
	for <lists+linux-can@lfdr.de>; Wed, 26 Jun 2019 15:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfFZNAR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jun 2019 09:00:17 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:39564 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZNAR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jun 2019 09:00:17 -0400
X-ASG-Debug-ID: 1561554013-0a88186e23fac80001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.103.163.adsl.dyn.edpnet.net [77.109.103.163]) by relay-b03.edpnet.be with ESMTP id 2CGwkxkJOMf0fFuy; Wed, 26 Jun 2019 15:00:13 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Apparent-Source-IP: 77.109.103.163
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id A6BE18CED47;
        Wed, 26 Jun 2019 15:00:13 +0200 (CEST)
Date:   Wed, 26 Jun 2019 15:00:12 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     David Jander <david@protonic.nl>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de, wg@grandegger.com
Subject: Re: j1939: discussion: RX path
Message-ID: <20190626130012.GC8923@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: j1939: discussion: RX path
Mail-Followup-To: David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de, wg@grandegger.com
References: <20190625073009.GA15948@pengutronix.de>
 <20190625104315.57172f69@erd988>
 <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
 <20190625173137.GB8923@x1.vandijck-laurijssen.be>
 <20190626091524.40410c4b@erd988>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626091524.40410c4b@erd988>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Start-Time: 1561554013
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 7490
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73144
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On wo, 26 jun 2019 09:15:24 +0200, David Jander wrote:
> Dear Kurt,
> 
> On Tue, 25 Jun 2019 19:31:37 +0200
> Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> wrote:
> 
> > On di, 25 jun 2019 10:54:55 +0200, Oleksij Rempel wrote:
> > > On 25.06.19 10:43, David Jander wrote:  
> > > >On Tue, 25 Jun 2019 09:30:09 +0200
> > > >Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > > >  
> > > >>Hello all,
> > > >>
> > > >>We already had a discussion about the J1939 use case for server
> > > >>implementation. Short description of the challenge will looks as follow:
> > > >>- main socket is listening on DST address and PGN.
> > > >>- as soon as connection was requested from peer the server will
> > > >>   create new connect()ed socket with SRC, DST addresses and PGN.
> > > >>
> > > >>With current stack implementation both sockets (main and connected) will
> > > >>receive same packages. At least with huge packages it will start to be
> > > >>not really good :).
> > > >>
> > > >>To solve this issue we have following variants:
> > > >>variant a:
> > > >>  - all sockets can receive everything (as currently implemented)
> > > >>variant b:
> > > >>  - only one socket will receive specific tuple. In this case kernel
> > > >>    should calculate RX "priority". Only highest priority will RX packet.
> > > >>    - all sockets with same priority will receive the matching packet
> > > >>    - socket option promisc == same priority as exact match  
> > > >
> > > >How is this "priority" determined?
> > > >Something like this:
> > > >
> > > >  for each socket:
> > > >	 prio = 0
> > > >	 listening on same DST or PGN ==> prio++
> > > >	 listening on same DST and PGN ==> prio++
> > > >	 connect()ed to same SRC ==> prio++
> > > >  deliver frame to socket(s) with highest prio.

more than 1 socket may have equal highest priority

> > > >
> > > >Is that what you mean?  
> > > 
> > > ACK.  
> > 
> > I don't like any of these.
> > 
> > The problem you try to solve is 'huge packet duplication where it is
> > probably not required'.
> > Your proposed solution puts a policy in the kernel that goes in serious
> > conflict with a multiuser system. It is driven by a typical
> > implementation, but did not address the problem you try to solve.
> > 
> > In order to avoid receiving huge packets where we suspect it is not
> > really wanted, we should not try to guess what 'a' program wants, nor
> > implement rules that apply to 1 specific case.
> > Instead, we should protect sockets from receiving huge packets.
> > 
> > Why not add a socket option, that implements a ceiling on the
> > size of received packets.
> > If that defaults to, let's say, 1785 bytes, so anyone will out of the
> > box receive all TP sessions, but no ETP session, then the user will not
> > be really supprised, and we need to make only 1 clear decision during delivery.
> > 
> > I honestly think that my proprosal puts way less decision policy in the
> > kernel code, and effectively addresses the problem you tried to solve,
> > without adding unnecessary multi-user restrictions.
> > 
> > What's your thought?
> 
> Thanks for your feedback. I understand it may sound counter-intuitive, but it
> really isn't. What we are trying to accomplish is for SocketCAN with J1939 to
> behave much like a network adapter with TCP/IP.

J1939 is a datagram system, so more like UDP/IP.

> 
> The solution you propose is not enough. The problem really is not restricted
> to "big" messages.
I see.
> If there are a lot of small frames coming from one client,
> you really do not want all the unnecessary interruptions to other sockets, but
> only the one that is connected to that client. That is actually one of the
> main reasons to have J1939 in the kernel as opposed to a user-space
> implementation... besides of course the obvious gains related to (E)TP.

The main reason for J1939 in kernel is address claiming and Transport
Protocol is impossible for a multiuser (or multi-process) system to be
handled decently.
If that was not the case, CAN_RAW was good enough.

> 
> The underlying problem here is that we are trying to have the same sort of
> "connection oriented" sockets as in TCP/IP, but on a J1939-CAN network there is
> no way of initiating nor terminating a connection, and bigger data "streams"
> are artificially encapsulated in these (E)TP sessions. The semantics of J1939
> and ISObus nevertheless are very similar to TCP/IP: There are servers that
> bind() to an address and port number (NAME and PGN), and clients that
> connect() to a server from a source address and -port number (client-NAME and
> client-PGN).

Again, J1939 has UDP semantics, and you're right that it's similar.
That's why I chose to stick to BSD socket model that close.

> 
> The problem is that in the "server" case, just as in TCP/IP you would want a
> new socket to be created (as is done with the accept() system call in TCP/IP)
> for each new client that connect()s.

Now you're going off the road (what a choice of words, isn't protronic
in agriculture too?).

A UDP server opens 1 socket, and does not require a socket per
connection, since the connection does not exist.
A UDP 'connected client' does only exist at application level, and
whenever the 'server' needs to send, it uses sendto() with destination
address of the client.

> For TCP/IP there is a defined sequence of TCP messages (SYN/ACK/FIN/...) that
> initiates and terminates a "connection". Such a stateful protocol inherently
> requires time-outs on the connection level to work. Probably one of the
> reasons why J1939 is much simpler and stateless, due to it's real-time
> requirements. Anyway, since the notion of a "connection" is a lot more vague
> in J1939, there is some cooperation needed from user-space in order to decide
> when a connection is established, and when it is closed. We cannot have an
> accept() system call for J1939 unfortunately. Instead of that, the user-space
> application needs to open a new socket that does bind() and then connect() to
> the client's NAME and PGN. At that point (same as with an accept()ed TCP/IP
> connection) all traffic coming from that specific NAME and PGN to the "server"
> should be delivered only on that socket. And exactly this is what we are
> trying to accomplish now, while we only have a bunch of sockets owned by one
> application and no stateful information of the connection state of each of
> those sockets.

Why would you apply STREAM semantics on a DATAGRAM network?

> 
> Imagine a J1939 "server" that has 20 "clients" connected to it. It will thus
> have 21 open sockets (one for the server itself (the bind()ed socket) and one
> for each of the "clients" (the bind()ed and connect()ed sockets). Now imagine
> the trouble of having to deal with the fact that every single message from
> client A is received on all 21 sockets duplicated! You don't want that. Not
> for big messages, nor for small ones.

I don't even want those 20 sockets for Datagrams.

I'm not aware of the complexity that has been added recently for the
ETP, but that should not break multiuser operation, i.e.,
if I write 'a' program, then that program should receive the same thing
regardless of the presence of other sockets on the local system, with or
withing the same process.
I would not plan to violate that rule.
I seriously would not.

Kurt
