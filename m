Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6057970133
	for <lists+linux-can@lfdr.de>; Mon, 22 Jul 2019 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfGVNh3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Jul 2019 09:37:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53789 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbfGVNh3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jul 2019 09:37:29 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hpYVJ-0001jg-90; Mon, 22 Jul 2019 15:37:25 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hpYVH-0002ga-Ta; Mon, 22 Jul 2019 15:37:23 +0200
Date:   Mon, 22 Jul 2019 15:37:23 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        robin@protonic.nl, linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de, wg@grandegger.com
Subject: j1939: discussion: RX path (J1939_SOCK_RECV_OWN)
Message-ID: <20190722133723.GA17189@pengutronix.de>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722091328.GA24349@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:46:40 up 59 days, 18:49, 177 users,  load average: 2.41, 2.82,
 2.55
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We just noticed, in current implementation J1939_SOCK_RECV_OWN doesn't
work anymore (for ETP). And ...naively thinking it probably makes no
sense to support it for different reasons:

- we have a better feedback mechanism via the error queue feature
- with RECV_OWN the socket receives the complete payload back into user
  space, where the error queue will give back message number at state of
  the message/transfer.
- the error queue mechanism is extendable with more information and even
  backwards compatible.

However in the current implementation you'll receive an ACK via error
queue if the (E)TP transfer is completed, but for simple messages, the
ACK is received as soon as the packet has been put into the packet
scheduler. It would be better to wait and send the ACK only after the
simple message has been send onto the wire (i.e.: after the CAN
controller's TX-complete interrupt).

We'll remove J1939_SOCK_RECV_OWN for now.

But we already noticed that this will break jacd, however we think we
can fix it, by using a separate socket to receive. Are there any other
use cases or existing applications relying on this feature?

Oleksij & Marc

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
