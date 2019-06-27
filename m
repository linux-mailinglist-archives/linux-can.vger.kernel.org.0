Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9DB858107
	for <lists+linux-can@lfdr.de>; Thu, 27 Jun 2019 12:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0K7H (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 27 Jun 2019 06:59:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45953 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0K7H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 Jun 2019 06:59:07 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hgS7K-0000KJ-4M; Thu, 27 Jun 2019 12:59:02 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hgS7J-00048E-Bl; Thu, 27 Jun 2019 12:59:01 +0200
Date:   Thu, 27 Jun 2019 12:59:01 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     David Jander <david@protonic.nl>, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de, wg@grandegger.com
Subject: Re: j1939: discussion: RX path
Message-ID: <20190627105901.GA24805@pengutronix.de>
References: <20190625073009.GA15948@pengutronix.de>
 <20190625104315.57172f69@erd988>
 <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
 <20190625173137.GB8923@x1.vandijck-laurijssen.be>
 <20190626091524.40410c4b@erd988>
 <20190626130012.GC8923@x1.vandijck-laurijssen.be>
 <20190626160238.5d62fc15@erd988>
 <20190627093353.GA693@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627093353.GA693@x1.vandijck-laurijssen.be>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:16:40 up 34 days, 16:19, 167 users,  load average: 0.68, 1.56,
 3.27
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Jun 27, 2019 at 11:33:53AM +0200, Kurt Van Dijck wrote:
> > > > Thanks for your feedback. I understand it may sound counter-intuitive, but it
> > > > really isn't. What we are trying to accomplish is for SocketCAN with J1939 to
> > > > behave much like a network adapter with TCP/IP.  
> > > 
> > > J1939 is a datagram system, so more like UDP/IP.
> > 
> > In some aspects it is more like UDP, but unlike UDP, J1939 does have have
> > handshaking (in hardware) and is considered reliable.

You probably mean the way the CAN bus works, which is not specific to
J1939.

> > Also the transport protocol implements handshakes and reliability for bigger
> > "datagrams".
> 
> There is no handshaking, and by far not in hardware.

I think David means the collision avoid on the CAN bus...

> The only handshaking that exists is for non-broadcast TP.

Yes, on the J1939 level, there's only handshaking inclusive RTS/CTS/EOMA
for (E)TP.

> Broadcast TP and <=8byte datagrams are sent unreliably, just as regular
> CAN.

It's fire and forget, but the most (?) people consider the underlying
CAN bus reliable (enough). :)

> > On top of that, many applications (like the ISObus fileserver, or the ISObus
> > VT) behave much more like a connection-oriented server, thus benefiting more
> > from the TCP/IP server analogy. I.e. there is a "client" who establishes a
> > connection with a "server" and from then on they semantically communicate over
> > a point to point channel, akin to a connected TCP/IP socket.
> 
> If you create a server where different sockets are used for different
> DST+PGNs, and you want to avoid receiving the same thing in your own
> sockets, then you should be more precise in your applied filters.

Yes, but...

For David's use case you want to receive the initial message by the
client, the you create a new socket()/bind()/connect() it. While the
newly created socket is active, you don't want to receive any messages
from that client on the server socket. This might be done by modifying
the filters. As soon as you close the dedicated client socket, you have
to modify the filers again. These are two separate operations, thus
racy by design. If you do it right, you don't loose any messages, but
receive them in both sockets. (Which makes user space handling more
complex).

> Unlike TCP and UDP, most J1939 applications are not designed with
> 1 or few PGNs in mind, but use a huge range of PGN's. That is why
> filter lists are common in CAN / J1939 and not in TCP / UDP.
> The 'server' example is the exception, not the standard.

We'd like to have an API that supports the whole spectrum of use cases.

> > True. But like I said above, in ISObus there are use-cases where a
> > connection-oriented approach is used, even though there is no formal
> > handshaking of the establishment and closing of a connection in the link layer.
> 
> A 'server' socket that 'listens' for new 'connections' need not
> listening to all PGNs, does it? IMHO, it needs 1 or a few PGNs, and the
> point-to-point socket needs the rest.

The server socket may listen on as many PGNs as it wants to. The
dedicated socket to the client uses one tuple only (SRC/DST/PGN), which
is a point-to-point connection.

> So, worst cast, the point-to-point socket receives also the packets that
> trigger connection construction/destruction for 1 specific destination,
> and more specifically, it needs those in order to close your virtual
> 'connection'.

ACK

> If this is not feasible, then adapt your listening socket's filters
> accordingly.

I don't like this, due to the raciness of the approach.

We just prototyped a sock option for "server" sockets. The options is
disabled by default, when enabled all packets that are received in a
connect()ed socket are ignored on this socket.

> > > I'm not aware of the complexity that has been added recently for the
> > > ETP, but that should not break multiuser operation, i.e.,
> > > if I write 'a' program, then that program should receive the same thing
> > > regardless of the presence of other sockets on the local system, with or
> > > withing the same process.
> > > I would not plan to violate that rule.
> > > I seriously would not.
> > 
> > That rule is not violated as long as these processes have their own address
> > (and NAME). If they share the same address and NAME, they are part of the same
> > control-function. In that case, as long as they do not connect() and only use
> > sendto() and recvfrom() that rule also holds true.
> > It is only when you use connect() to establish a 1:1 connection with another
> > peer. The only difference with TCP/IP sockets in that case is that you use
> > connect() on both ends instead of listen()/accept(), and the
> > establishment/tear-down of the connection is thus left to the application.
> 
> Then you must redesign/redefine the filters because they are no more
> coherent.

regards,
Oleksij & Marc

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
