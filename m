Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 107ED567B2
	for <lists+linux-can@lfdr.de>; Wed, 26 Jun 2019 13:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZLfO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jun 2019 07:35:14 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:42398 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbfFZLfO (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 26 Jun 2019 07:35:14 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id ACA9144A00D3;
        Wed, 26 Jun 2019 13:36:56 +0200 (CEST)
Date:   Wed, 26 Jun 2019 13:35:12 +0200
From:   David Jander <david@protonic.nl>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        robin@protonic.nl, linux-can@vger.kernel.org,
        kernel@pengutronix.de, wg@grandegger.com
Subject: Re: j1939: discussion: RX path
Message-ID: <20190626133512.11f887ec@erd988>
In-Reply-To: <8d0a2f79-cefe-0d00-a326-344db84d695c@pengutronix.de>
References: <20190625073009.GA15948@pengutronix.de>
        <20190625104315.57172f69@erd988>
        <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
        <20190625173137.GB8923@x1.vandijck-laurijssen.be>
        <20190626091524.40410c4b@erd988>
        <fc126ad7-d90f-f012-7865-2d7cba6248ef@pengutronix.de>
        <20190626094733.7f381729@erd988>
        <20190626085035.GA30727@pengutronix.de>
        <20190626115500.720ffb8e@erd988>
        <8d0a2f79-cefe-0d00-a326-344db84d695c@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 26 Jun 2019 12:08:47 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 6/26/19 11:55 AM, David Jander wrote:
> >> One more question regarding isolation of different sockets. Should we
> >> allow a bind()+connect() to the same tuple (SRC/DST/PGN) from more than
> >> one socket? We have to take care of Names, too...somehow.  
> > 
> > Good question... does that have impact on the code? Is it easier to restrict
> > it to one instance, or is it easier to just sent duplicated data to the same
> > kind of sockets?  
> 
> For now we receive the whole (E)TP in kernel and dump the whole message
> into all matching sockets. So it doesn't make any difference here.
> 
> We were also having incremental recv() in the back of our heads, it's
> probably easier with only one socket.

I agree. Can we say then, that data should be delivered on one socket only,
and that it is never duplicated (except for un-connect()ed sockets maybe)?

> However it probably only makes sense on connect()ed sockets, as an
> ongoing huge ETP will block every small packet. And huge ETP transfers
> can take up to an hour...

Small interleaved single-frame messages will then be recv()ed on the
bind()ed-only socket?
If a client sends me (the server) a huge ETP and in between single-frame
real-time messages, will that work correctly? I'd expect to receive all the
single-frame messages in real-time and the ETP message at the end...

Best regards,

-- 
David Jander
Protonic Holland.
