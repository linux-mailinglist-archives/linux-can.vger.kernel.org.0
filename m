Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB4F4B16DD
	for <lists+linux-can@lfdr.de>; Thu, 10 Feb 2022 21:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiBJUUv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Feb 2022 15:20:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiBJUUv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Feb 2022 15:20:51 -0500
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF5D72724
        for <linux-can@vger.kernel.org>; Thu, 10 Feb 2022 12:20:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 34EE0FF9CA;
        Thu, 10 Feb 2022 20:20:50 +0000 (UTC)
Date:   Thu, 10 Feb 2022 21:20:47 +0100
From:   Max Staudt <max@enpas.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Oliver Neukum <oneukum@suse.com>, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220210212047.589c2f3d.max@enpas.org>
In-Reply-To: <YgVOOmi929pd0/M5@kroah.com>
References: <20220210171315.87796-1-max@enpas.org>
        <YgVOOmi929pd0/M5@kroah.com>
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

Thanks Greg for your quick feedback!

I'll include it and send a new version after waiting for more comments.

A few questions/suggestions below.



On Thu, 10 Feb 2022 18:41:14 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Feb 10, 2022 at 06:13:15PM +0100, Max Staudt wrote:
> > +/* If this is enabled, we'll try to make the best of the situation
> > + * even if we receive unexpected characters on the line.
> > + * No guarantees.
> > + * Handle with care, it's likely your hardware is unreliable!
> > + */
> > +static bool accept_flaky_uart;
> > +module_param_named(accept_flaky_uart, accept_flaky_uart, bool,
> > 0444); +MODULE_PARM_DESC(accept_flaky_uart, "Don't bail at the
> > first invalid character. Behavior undefined.");  
> 
> Module parameters are from the 1990's, please no.  This is a per-code
> setting, when you want it to be a per-device setting, right?  Please
> just drop this.

Agreed.

Ideally, this option would be part of the ldattach moment. But that ABI
for ldattach doesn't exist.

I'll hardcode the driver to be more lenient - i.e. accept_flaky_uart=1.
Whoever relies on it for critical systems likely hasn't read the
disclaimer anyway :)


How about inverting the option, thus having a debug_extra_strict module
option for debugging purposes, so users can more easily see if their
adapter is at fault?


> > diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
> > index a58deb3061eb..4d3ad2569641 100644
> > --- a/include/uapi/linux/tty.h
> > +++ b/include/uapi/linux/tty.h
> > @@ -39,5 +39,6 @@
> >  #define N_SPEAKUP	26	/* Speakup communication with
> > synths */ #define N_NULL		27	/* Null ldisc
> > used for error handling */ #define N_MCTP		28
> > /* MCTP-over-serial */ +#define N_ELMCAN	29	/* Serial
> > / USB serial OBD-II Interfaces */  
> 
> We are now full, no more new ones to ever add!  :)
> 
> This looks fine, we can always bump up the number if we want more.

Phew! :)

May I suggest increasing NR_LDISCS right now, while we're at it?

Also, I could set N_ELMCAN to 30 and leave #29 free for out-of-tree
uses. It was quite handy having an unused ldisc number while developing
this driver, and I assume there are other users out there.

#29 is the highest number available for the last eons, so people are
bound to have used it, and (unknowingly) expect it to work even after
forward porting their out-of-tree modules to v5.17's ldisc API. Things
could break in ugly unexpected ways for people who have been using #29
internally and have it hardcoded in scripts using ldattach.

Maybe
  #define N_DEVELOPMENT 29
or something like that?

And then from this point onwards, NR_LDISCS needs only be incremented
once a new ldisc is actually upstreamed.



Thanks,

Max
