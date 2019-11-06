Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D843DF18F3
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 15:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfKFOnG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 6 Nov 2019 09:43:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51807 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKFOnG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Nov 2019 09:43:06 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iSMWW-0006gX-BQ; Wed, 06 Nov 2019 15:43:04 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iSMWV-0008AX-U5; Wed, 06 Nov 2019 15:43:03 +0100
Date:   Wed, 6 Nov 2019 15:43:03 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     =?utf-8?Q?Cl=C3=A9ment?= VIEL <vielclement@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: synchronization problem on old version of j1939 stack
Message-ID: <20191106144303.GA8323@pengutronix.de>
References: <CAN1pBYmvcxFoM_zPZYeoUociEJBYHEfMmnspLfSL2=BKiu4Wbg@mail.gmail.com>
 <20191106100715.GA10500@pengutronix.de>
 <CAN1pBYnQBsNrSxuB3Ety08_ecQtZLpQAE-MN9BtwZ4HtnMiuUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAN1pBYnQBsNrSxuB3Ety08_ecQtZLpQAE-MN9BtwZ4HtnMiuUw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:35:45 up 56 days,  3:23, 292 users,  load average: 26.38, 20.23,
 19.54
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Nov 06, 2019 at 02:29:29PM +0100, Clément VIEL wrote:
> Hi Oleksij
> >
> > Hi Clément,
> >
> > On Wed, Nov 06, 2019 at 10:32:48AM +0100, Clément VIEL wrote:
> > > Hi all,
> > >
> > > I am currently using a very old version of the j1939 stack. It was
> > > forked in 2014 and now running on a custom 3.10.17 kernel. We are
> > > experiencing a lot of synchronization problem that cause kernel
> > > panics.
> > > Doing diffs with the mainline version shows that the whole stack has
> > > changed a lot, I noticed, this first mail concerning j1939 on this
> > > mailing list is from 2018.
> > >  My question is very simple. Did synchronization problems were
> > > encountered and corrected before the j1939 entered the mainline ?
> >
> > What do you mean with synchronization problem? Do you have a tests case
> > for your issue?
> 
> By synchronization I mean that in the old version of j1939 it seems
> that the some functions
> and pointers are not fully protected by locks whereas in the mainline
> version it seems that there are more
> locking.
> 
> I give you an example. In the mainline version, there is a function
> named j1939_ecu_get_by_name that calls ecu_find_by_name_locked
> whereas in our version there just a function named j1939_ecu_find_by_name.
> 
> In the mailine, there is a lot of lock protection that lacks in our version.
> 
> I do not have test case because its a client that feeds  us with these
> kernel panics and they cannot tell what manipulation they did.
> 
> I hope its more clear now.

In the latest stack the resource management was mostly reworked. In my
tests setups I was not able to reproduce any j1939_ecu_find_by_name
related issues any more. On other hand google started to tests this
stack with syzbot and found lots new bugs. 

In any case, I would recommend you to update the kernel. Some fixed issues
were not directly in j1939. Drivers and CAN framework need fixes as well.

UAPI was changed and you application will need some rework. Since this
UAPI is upstream now, we should keep it compatible with coming kernel
versions. So, you should be safe now by using it.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
