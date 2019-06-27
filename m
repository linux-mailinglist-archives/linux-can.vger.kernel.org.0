Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB48E57F63
	for <lists+linux-can@lfdr.de>; Thu, 27 Jun 2019 11:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfF0JeA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 27 Jun 2019 05:34:00 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:55931 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0JeA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 Jun 2019 05:34:00 -0400
X-ASG-Debug-ID: 1561628035-0a7b8d0c9f1cb060001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.103.163.adsl.dyn.edpnet.net [77.109.103.163]) by relay-b02.edpnet.be with ESMTP id EpegEA60XxihpYCW; Thu, 27 Jun 2019 11:33:55 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Apparent-Source-IP: 77.109.103.163
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 4ED0E8D1597;
        Thu, 27 Jun 2019 11:33:55 +0200 (CEST)
Date:   Thu, 27 Jun 2019 11:33:53 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     David Jander <david@protonic.nl>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de, wg@grandegger.com
Subject: Re: j1939: discussion: RX path
Message-ID: <20190627093353.GA693@x1.vandijck-laurijssen.be>
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
 <20190626130012.GC8923@x1.vandijck-laurijssen.be>
 <20190626160238.5d62fc15@erd988>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626160238.5d62fc15@erd988>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Start-Time: 1561628035
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 6209
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5040 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73184
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On wo, 26 jun 2019 16:02:38 +0200, David Jander wrote:
> > > > On di, 25 jun 2019 10:54:55 +0200, Oleksij Rempel wrote:  
> > > > > On 25.06.19 10:43, David Jander wrote:    
> > > > > >On Tue, 25 Jun 2019 09:30:09 +0200
> > > > > >Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > > > > >    
> > > > > >>Hello all,
> > > > > >>
> > > > > >>We already had a discussion about the J1939 use case for server
> > > > > >>implementation. Short description of the challenge will looks as follow:
> > > > > >>- main socket is listening on DST address and PGN.
> > > > > >>- as soon as connection was requested from peer the server will
> > > > > >>   create new connect()ed socket with SRC, DST addresses and PGN.
> > > > > >>
> > > > > >>With current stack implementation both sockets (main and connected) will
> > > > > >>receive same packages. At least with huge packages it will start to be
> > > > > >>not really good :).
> > > > > >>
> > > > > >>To solve this issue we have following variants:
> > > > > >>variant a:
> > > > > >>  - all sockets can receive everything (as currently implemented)
> > > > > >>variant b:
> > > > > >>  - only one socket will receive specific tuple. In this case kernel
> > > > > >>    should calculate RX "priority". Only highest priority will RX packet.
> > > > > >>    - all sockets with same priority will receive the matching packet
> > > > > >>    - socket option promisc == same priority as exact match    
[...]
> > > > 
> > > > I don't like any of these.
> > > > 
> > > > The problem you try to solve is 'huge packet duplication where it is
> > > > probably not required'.
> > > > Your proposed solution puts a policy in the kernel that goes in serious
> > > > conflict with a multiuser system. It is driven by a typical
> > > > implementation, but did not address the problem you try to solve.
> > > > 
> > > > In order to avoid receiving huge packets where we suspect it is not
> > > > really wanted, we should not try to guess what 'a' program wants, nor
> > > > implement rules that apply to 1 specific case.
> > > > Instead, we should protect sockets from receiving huge packets.
> > > > 
> > > > Why not add a socket option, that implements a ceiling on the
> > > > size of received packets.
> > > > If that defaults to, let's say, 1785 bytes, so anyone will out of the
> > > > box receive all TP sessions, but no ETP session, then the user will not
> > > > be really supprised, and we need to make only 1 clear decision during delivery.
> > > > 
> > > > I honestly think that my proprosal puts way less decision policy in the
> > > > kernel code, and effectively addresses the problem you tried to solve,
> > > > without adding unnecessary multi-user restrictions.
> > > > 
> > > > What's your thought?  
> > > 
> > > Thanks for your feedback. I understand it may sound counter-intuitive, but it
> > > really isn't. What we are trying to accomplish is for SocketCAN with J1939 to
> > > behave much like a network adapter with TCP/IP.  
> > 
> > J1939 is a datagram system, so more like UDP/IP.
> 
> In some aspects it is more like UDP, but unlike UDP, J1939 does have have
> handshaking (in hardware) and is considered reliable.
> Also the transport protocol implements handshakes and reliability for bigger
> "datagrams".

There is no handshaking, and by far not in hardware.
The only handshaking that exists is for non-broadcast TP.

Broadcast TP and <=8byte datagrams are sent unreliably, just as regular
CAN.

> On top of that, many applications (like the ISObus fileserver, or the ISObus
> VT) behave much more like a connection-oriented server, thus benefiting more
> from the TCP/IP server analogy. I.e. there is a "client" who establishes a
> connection with a "server" and from then on they semantically communicate over
> a point to point channel, akin to a connected TCP/IP socket.

If you create a server where different sockets are used for different
DST+PGNs, and you want to avoid receiving the same thing in your own
sockets, then you should be more precise in your applied filters.

Unlike TCP and UDP, most J1939 applications are not designed with
1 or few PGNs in mind, but use a huge range of PGN's. That is why
filter lists are common in CAN / J1939 and not in TCP / UDP.
The 'server' example is the exception, not the standard.

> True. But like I said above, in ISObus there are use-cases where a
> connection-oriented approach is used, even though there is no formal
> handshaking of the establishment and closing of a connection in the link layer.

A 'server' socket that 'listens' for new 'connections' need not
listening to all PGNs, does it? IMHO, it needs 1 or a few PGNs, and the
point-to-point socket needs the rest.
So, worst cast, the point-to-point socket receives also the packets that
trigger connection construction/destruction for 1 specific destination,
and more specifically, it needs those in order to close your virtual
'connection'.

If this is not feasible, then adapt your listening socket's filters
accordingly.

> > I'm not aware of the complexity that has been added recently for the
> > ETP, but that should not break multiuser operation, i.e.,
> > if I write 'a' program, then that program should receive the same thing
> > regardless of the presence of other sockets on the local system, with or
> > withing the same process.
> > I would not plan to violate that rule.
> > I seriously would not.
> 
> That rule is not violated as long as these processes have their own address
> (and NAME). If they share the same address and NAME, they are part of the same
> control-function. In that case, as long as they do not connect() and only use
> sendto() and recvfrom() that rule also holds true.
> It is only when you use connect() to establish a 1:1 connection with another
> peer. The only difference with TCP/IP sockets in that case is that you use
> connect() on both ends instead of listen()/accept(), and the
> establishment/tear-down of the connection is thus left to the application.

Then you must redesign/redefine the filters because they are no more
coherent.

Kind regards,
Kurt

