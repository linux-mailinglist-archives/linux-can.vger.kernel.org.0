Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7BB564EA
	for <lists+linux-can@lfdr.de>; Wed, 26 Jun 2019 10:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfFZIul (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jun 2019 04:50:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37471 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfFZIul (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Jun 2019 04:50:41 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hg3dU-0005zj-2B; Wed, 26 Jun 2019 10:50:36 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hg3dT-00012I-Dz; Wed, 26 Jun 2019 10:50:35 +0200
Date:   Wed, 26 Jun 2019 10:50:35 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        robin@protonic.nl, linux-can@vger.kernel.org,
        kernel@pengutronix.de, wg@grandegger.com
Subject: Re: j1939: discussion: RX path
Message-ID: <20190626085035.GA30727@pengutronix.de>
References: <20190625073009.GA15948@pengutronix.de>
 <20190625104315.57172f69@erd988>
 <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
 <20190625173137.GB8923@x1.vandijck-laurijssen.be>
 <20190626091524.40410c4b@erd988>
 <fc126ad7-d90f-f012-7865-2d7cba6248ef@pengutronix.de>
 <20190626094733.7f381729@erd988>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626094733.7f381729@erd988>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:26:45 up 33 days, 14:29, 169 users,  load average: 2.08, 5.74,
 5.15
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Jun 26, 2019 at 09:47:33AM +0200, David Jander wrote:
[...]
> > > Imagine a J1939 "server" that has 20 "clients" connected to it. It will thus
> > > have 21 open sockets (one for the server itself (the bind()ed socket) and one
> > > for each of the "clients" (the bind()ed and connect()ed sockets). Now imagine
> > > the trouble of having to deal with the fact that every single message from
> > > client A is received on all 21 sockets duplicated! You don't want that. Not
> > > for big messages, nor for small ones.  
> > 
> > Every single message from client A is _not_ received on all 21 sockets.
> > It's only recieved on the initial "server" bind()ed socket and the only
> > one "client" bind()ed and connect()ed socket.
> > 
> > On the other hand the "server" socket will receive all messages that the
> > all the 20 "client" socket will receive. And we're trying to avoid that.
> 
> You are absolutely right. Sorry. So it is not really as _bad_ as I pictured it
> here, but I hope the explanation was clear and otherwise correct.

ACK

> Another thing is that if the server just close()es the client connection
> socket, and the client sends more data, it will automatically get received on
> the bind()ed server socket, and that is okay. That way a new connection can be
> established if needed, and no data gets lost. In fact, it is the exact same
> situation as the initial creation of the "connection" in the beginning.

One more question regarding isolation of different sockets. Should we
allow a bind()+connect() to the same tuple (SRC/DST/PGN) from more than
one socket? We have to take care of Names, too...somehow.

Oleksij & Marc

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
