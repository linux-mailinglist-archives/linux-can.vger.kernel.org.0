Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE963A39
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfGIRhu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 13:37:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34981 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIRhu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 13:37:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hku3h-0001zv-OB; Tue, 09 Jul 2019 19:37:41 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hku3g-0005cH-1q; Tue, 09 Jul 2019 19:37:40 +0200
Date:   Tue, 9 Jul 2019 19:37:40 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com, robin@protonic.nl, david@protonic.nl,
        kernel@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH v1 13/34] j1939: socket: drop sanity check for ifindex
Message-ID: <20190709173740.pisuzxscqad7d76w@pengutronix.de>
References: <20190709085909.1413-1-o.rempel@pengutronix.de>
 <20190709085909.1413-13-o.rempel@pengutronix.de>
 <a680d36b-0cbd-f5a6-e3fc-786b518a62bb@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a680d36b-0cbd-f5a6-e3fc-786b518a62bb@hartkopp.net>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 19:23:44 up 52 days, 23:41, 49 users,  load average: 0.08, 0.02,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On Tue, Jul 09, 2019 at 07:03:12PM +0200, Oliver Hartkopp wrote:
> Hi Oleksij,
> 
> the topic said what this patch does - but there's no commit message that
> tells the reader why the check can be dropped.
> 
> And the removed comment in the patch leaves me even more lost ...

You right. I'll update the commit message.

Current j1939 stack implementation has one priv structure per interface.
There are no more global structures. All sockets are linked to related
priv. The can_rx call back is also configured with appropriate priv.
It means, we can't get an skb for different ifindex.

> Regards,
> Oliver
> 
> On 09/07/2019 10.58, Oleksij Rempel wrote:
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >   net/can/j1939/socket.c | 5 -----
> >   1 file changed, 5 deletions(-)
> > 
> > diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> > index 19e662574b5f..39df867cfe84 100644
> > --- a/net/can/j1939/socket.c
> > +++ b/net/can/j1939/socket.c
> > @@ -272,14 +272,9 @@ static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
> >   static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
> >   {
> >   	const struct j1939_sk_buff_cb *oskcb = j1939_skb_to_cb(oskb);
> > -	const struct can_skb_priv *oskb_prv = can_skb_prv(oskb);
> >   	struct j1939_sk_buff_cb *skcb;
> >   	struct sk_buff *skb;
> > -	if (jsk->ifindex != oskb_prv->ifindex)
> > -		/* this socket does not take packets from this iface */
> > -		return;
> > -
> >   	if (!j1939_sk_recv_match_one(jsk, oskcb))
> >   		return;
> > 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
