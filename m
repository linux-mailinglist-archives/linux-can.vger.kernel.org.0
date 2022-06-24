Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B921655A04C
	for <lists+linux-can@lfdr.de>; Fri, 24 Jun 2022 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiFXSHH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Jun 2022 14:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFXSHG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Jun 2022 14:07:06 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B6B6C77FFE
        for <linux-can@vger.kernel.org>; Fri, 24 Jun 2022 11:07:05 -0700 (PDT)
Received: (qmail 40361 invoked by uid 1000); 24 Jun 2022 14:07:04 -0400
Date:   Fri, 24 Jun 2022 14:07:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Hongren Zenithal Zheng <i@zenithal.me>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <YrX9SBpxp1E2cOyI@rowland.harvard.edu>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <YrSjRvb8rIIayGlg@Sun>
 <143b863d-c86b-6678-44e6-38799391fa36@linuxfoundation.org>
 <YrXNltWSYbplstPx@rowland.harvard.edu>
 <aaf64d6c-1893-67ed-013e-67d21c8be152@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf64d6c-1893-67ed-013e-67d21c8be152@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Jun 24, 2022 at 10:31:06AM -0600, Shuah Khan wrote:
> On 6/24/22 8:43 AM, Alan Stern wrote:
> > > It doesn't sound like a there is a compelling reason other than
> > > "it would be nice to keep the flag values in numerical order".
> > > 
> > > I would not recommend this option. I am not seeing any value to adding
> > > change URB_* to USBIP_FLAGS_* layer without some serious techinical
> > > concerns.
> > > 
> > > > 
> > > > Another way is to use 0x0400 for FREE_COHERENT.
> > > > usbip will not take care of this bit as
> > > > it would be masked.
> > > > 
> > > 
> > > I would go with this option adding a clear comment with link to this
> > > discussion.
> > > 
> > > > Cc Shuah Khan here since she is the maintainer
> > > > on usbip.
> > > > 
> > > 
> > > Thank you adding me to the discussion.
> > 
> > I can see this causing more problems in the future.  There's no hint in
> > include/linux/usb.h that any of the values it defines are part of a user
> > API.  If they are, they should be moved to include/uapi/linux/usb/.
> > 
> 
> Please elaborate on more problems in the future.

In the future people will want to make other changes to 
include/linux/usb.h and they will not be aware that those changes will 
adversely affect usbip, because there is no documentation saying that 
the values defined in usb.h are part of a user API.  That will be a 
problem, because those changes may be serious and important ones, not 
just decorative or stylistic as in this case.

> > In general, if a user program depends on kernel details that are not
> > designed to be part of a user API, you should expect that the program
> > will sometimes break from one kernel version to another.
> > 
> > Yes, I know Linus insists that kernel changes should not cause
> > regressions in userspace, but the line has to be drawn somewhere.
> > Otherwise the kernel could never change at all.
> > 
> 
> I have had to change the usbip sysfs interface api in the past to
> address security bugs related to information leaks. I am not saying
> no. I am asking if there is a good reason to do this. So far I haven't
> heard one.

I agree with Hongren that values defined in include/linux/ should not be 
part of a user API.  There are two choices:

	Move the definitions into include/uapi/linux/, or

	Add code to translate the values between the numbers used in 
	userspace and the numbers used in the kernel.  (This is what
	was done for urb->transfer_flags in devio.c:proc_do_submiturb() 
	near line 1862.)

Alan Stern
