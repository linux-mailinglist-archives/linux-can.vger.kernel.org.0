Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDBC4B27C3
	for <lists+linux-can@lfdr.de>; Fri, 11 Feb 2022 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbiBKOXZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Feb 2022 09:23:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiBKOXY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 11 Feb 2022 09:23:24 -0500
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E7A2188
        for <linux-can@vger.kernel.org>; Fri, 11 Feb 2022 06:23:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 562DCFF837;
        Fri, 11 Feb 2022 14:23:22 +0000 (UTC)
Date:   Fri, 11 Feb 2022 15:23:19 +0100
From:   Max Staudt <max@enpas.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Oliver Neukum <oneukum@suse.com>, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220211152319.7745598b.max@enpas.org>
In-Reply-To: <YgYl9nwKwG2iY6MO@kroah.com>
References: <20220210171315.87796-1-max@enpas.org>
        <YgVOOmi929pd0/M5@kroah.com>
        <20220210212047.589c2f3d.max@enpas.org>
        <YgYl9nwKwG2iY6MO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, 11 Feb 2022 10:01:42 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Feb 10, 2022 at 09:20:47PM +0100, Max Staudt wrote:
> > I'll hardcode the driver to be more lenient - i.e.
> > accept_flaky_uart=1. Whoever relies on it for critical systems
> > likely hasn't read the disclaimer anyway :)
> > 
> > 
> > How about inverting the option, thus having a debug_extra_strict
> > module option for debugging purposes, so users can more easily see
> > if their adapter is at fault?  
> 
> Will anyone really do that?  And if so, what can they do about it?
> The kernel's job is to work around broken hardware, so we might as
> well just deal with it :(

True, let's hardcode a behaviour.

I've thought about it a bit more and flipped the switch though :)

The rationale is as follows:

1) In my latest tests, my hardware behaved just fine, so I likely had
an EMI problem in my setup when I wrote that option years ago.

2) The errors I was working around were random insertions and bitflips.
Which can lead to incorrect rather than dropped data. The driver can
report obvious errors, but there is no way to detect a bitflip in those
places where it really hurts (i.e. the data packets). If the driver has
reason to believe there is a problem, I'd rather it avoid forwarding
possibly incorrect data to the user.

3) If the driver's users DO wish for a change, it's always easier to
make the driver more lenient rather than more strict. The only thing it
can do then is to restart the device anyway...

So, I'll kick the option out and keep the driver strict.


> > Maybe
> >   #define N_DEVELOPMENT 29
> > or something like that?
> > 
> > And then from this point onwards, NR_LDISCS needs only be
> > incremented once a new ldisc is actually upstreamed.  
> 
> That would work, want to send a patch right now for that?

Just did:

  Message-Id: <20220211141036.6403-1-max@enpas.org>


Max
