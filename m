Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D952833F3
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2019 16:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfHFO3q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Aug 2019 10:29:46 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:39530 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728756AbfHFO3p (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 6 Aug 2019 10:29:45 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Aug 2019 10:29:45 EDT
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id E1D8144A009E;
        Tue,  6 Aug 2019 16:22:59 +0200 (CEST)
Date:   Tue, 6 Aug 2019 16:21:07 +0200
From:   David Jander <david@protonic.nl>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        robin@protonic.nl, linux-can@vger.kernel.org,
        kernel@pengutronix.de, wg@grandegger.com, romain.forlot@iot.bzh
Subject: Re: j1939: discussion: RX path (J1939_SOCK_RECV_OWN)
Message-ID: <20190806162107.707862c9@erd988>
In-Reply-To: <e3197f96-48de-7887-7a04-eef75fd6a6a3@pengutronix.de>
References: <20190625104315.57172f69@erd988>
        <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
        <20190625173137.GB8923@x1.vandijck-laurijssen.be>
        <20190626091524.40410c4b@erd988>
        <20190626130012.GC8923@x1.vandijck-laurijssen.be>
        <20190626160238.5d62fc15@erd988>
        <20190627093353.GA693@x1.vandijck-laurijssen.be>
        <20190627105901.GA24805@pengutronix.de>
        <20190627140849.39916a65@erd988>
        <20190722091328.GA24349@pengutronix.de>
        <20190722133723.GA17189@pengutronix.de>
        <e3197f96-48de-7887-7a04-eef75fd6a6a3@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 23 Jul 2019 10:59:07 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 7/22/19 3:37 PM, Oleksij Rempel wrote:
> > We just noticed, in current implementation J1939_SOCK_RECV_OWN doesn't
> > work anymore (for ETP). And ...naively thinking it probably makes no
> > sense to support it for different reasons:
> > 
> > - we have a better feedback mechanism via the error queue feature
> > - with RECV_OWN the socket receives the complete payload back into user
> >   space, where the error queue will give back message number at state of
> >   the message/transfer.
> > - the error queue mechanism is extendable with more information and even
> >   backwards compatible.
> > 
> > However in the current implementation you'll receive an ACK via error
> > queue if the (E)TP transfer is completed, but for simple messages, the
> > ACK is received as soon as the packet has been put into the packet
> > scheduler. It would be better to wait and send the ACK only after the
> > simple message has been send onto the wire (i.e.: after the CAN
> > controller's TX-complete interrupt).
> > 
> > We'll remove J1939_SOCK_RECV_OWN for now.

I see no real reason to use RECV_OWN here, other than for solving issues that
cannot be solved with the current UAPI. In that case, IMHO we should fix the
UAPI now, and not use RECV_OWN.
In other words, I am fine with removing it.

> > But we already noticed that this will break jacd, however we think we
> > can fix it, by using a separate socket to receive. Are there any other
> > use cases or existing applications relying on this feature?  
> 
> I think in AGL they switch on self reception of j1939 sockets by default.

Wow, I hadn't realized AGL already is including this...
But why would they enable self-reception? Probably because of the lack of a
solution to the exact problem Oleksij is trying to solve with this patch-stack?

Best Regards,

-- 
David Jander
Protonic Holland.
