Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E18565FB
	for <lists+linux-can@lfdr.de>; Wed, 26 Jun 2019 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfFZJzC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jun 2019 05:55:02 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:41983 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZJzC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 26 Jun 2019 05:55:02 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id C160944A00D3;
        Wed, 26 Jun 2019 11:56:44 +0200 (CEST)
Date:   Wed, 26 Jun 2019 11:55:00 +0200
From:   David Jander <david@protonic.nl>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        robin@protonic.nl, linux-can@vger.kernel.org,
        kernel@pengutronix.de, wg@grandegger.com
Subject: Re: j1939: discussion: RX path
Message-ID: <20190626115500.720ffb8e@erd988>
In-Reply-To: <20190626085035.GA30727@pengutronix.de>
References: <20190625073009.GA15948@pengutronix.de>
        <20190625104315.57172f69@erd988>
        <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
        <20190625173137.GB8923@x1.vandijck-laurijssen.be>
        <20190626091524.40410c4b@erd988>
        <fc126ad7-d90f-f012-7865-2d7cba6248ef@pengutronix.de>
        <20190626094733.7f381729@erd988>
        <20190626085035.GA30727@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 26 Jun 2019 10:50:35 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Wed, Jun 26, 2019 at 09:47:33AM +0200, David Jander wrote:
> [...]
> > > > Imagine a J1939 "server" that has 20 "clients" connected to it. It will thus
> > > > have 21 open sockets (one for the server itself (the bind()ed socket) and one
> > > > for each of the "clients" (the bind()ed and connect()ed sockets). Now imagine
> > > > the trouble of having to deal with the fact that every single message from
> > > > client A is received on all 21 sockets duplicated! You don't want that. Not
> > > > for big messages, nor for small ones.    
> > > 
> > > Every single message from client A is _not_ received on all 21 sockets.
> > > It's only recieved on the initial "server" bind()ed socket and the only
> > > one "client" bind()ed and connect()ed socket.
> > > 
> > > On the other hand the "server" socket will receive all messages that the
> > > all the 20 "client" socket will receive. And we're trying to avoid that.  
> > 
> > You are absolutely right. Sorry. So it is not really as _bad_ as I pictured it
> > here, but I hope the explanation was clear and otherwise correct.  
> 
> ACK
> 
> > Another thing is that if the server just close()es the client connection
> > socket, and the client sends more data, it will automatically get received on
> > the bind()ed server socket, and that is okay. That way a new connection can be
> > established if needed, and no data gets lost. In fact, it is the exact same
> > situation as the initial creation of the "connection" in the beginning.  
> 
> One more question regarding isolation of different sockets. Should we
> allow a bind()+connect() to the same tuple (SRC/DST/PGN) from more than
> one socket? We have to take care of Names, too...somehow.

Good question... does that have impact on the code? Is it easier to restrict
it to one instance, or is it easier to just sent duplicated data to the same
kind of sockets?

Best regards,

-- 
David Jander
Protonic Holland.
