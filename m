Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C9B559CA2
	for <lists+linux-can@lfdr.de>; Fri, 24 Jun 2022 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiFXOpx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Jun 2022 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiFXOpG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Jun 2022 10:45:06 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AB60F6DB35
        for <linux-can@vger.kernel.org>; Fri, 24 Jun 2022 07:43:35 -0700 (PDT)
Received: (qmail 34626 invoked by uid 1000); 24 Jun 2022 10:43:34 -0400
Date:   Fri, 24 Jun 2022 10:43:34 -0400
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
Message-ID: <YrXNltWSYbplstPx@rowland.harvard.edu>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <YrSjRvb8rIIayGlg@Sun>
 <143b863d-c86b-6678-44e6-38799391fa36@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143b863d-c86b-6678-44e6-38799391fa36@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Jun 23, 2022 at 11:45:13AM -0600, Shuah Khan wrote:
> On 6/23/22 11:30 AM, Hongren Zenithal Zheng wrote:
> > On Fri, Jun 10, 2022 at 05:33:35PM -0400, Rhett Aultman wrote:
> > > 
> > > In order to have all the flags in numerical order, URB_DIR_IN is
> > > renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
> > > value 0x0200.
> > 
> > >   #define URB_FREE_BUFFER		0x0100	/* Free transfer buffer with the URB */
> > > +#define URB_FREE_COHERENT	0x0200  /* Free DMA memory of transfer buffer */
> > >   /* The following flags are used internally by usbcore and HCDs */
> > > -#define URB_DIR_IN		0x0200	/* Transfer from device to host */
> > > +#define URB_DIR_IN		0x0400	/* Transfer from device to host */
> > >   #define URB_DIR_OUT		0
> > >   #define URB_DIR_MASK		URB_DIR_IN
> > > -- 
> > > 2.30.2
> > > 
> > 
> > I'm afraid this is a change of uapi as this field is, unfortunately,
> > exported by usbip to userspace as TCP packets.
> > 
> > This may also cause incompatibility (surprisingly not for this case,
> > detailed below) between usbip server and client
> > when one kernel is using the new flags and the other one is not.
> > 
> > If we do change this, we may need to bump usbip protocol version
> > accordingly.
> > 
> 
> 
> > A copy of Alan Stern's suggestion here for reference
> > > I don't see anything wrong with this, except that it would be nice to keep
> > > the flag values in numerical order.  In other words, set URB_FREE_COHERENT
> > > to 0x0200 and change URB_DIR_IN to 0x0400.
> > > 
> > > Alan Stern
> 
> Thank you Alan for this detailed analysis of uapi impacts and
> usbip host side and vhci incompatibilities. Userspace is going
> to be affected. In addition to the usbip tool in the kernel repo,
> there are other versions floating around that would break if we
> were to change the flags.
> 
> > One way to solve this issue for usbip
> > is to add some boilerplate transform
> > from URB_* to USBIP_FLAGS_*
> > as it is de facto uapi now.
> 
> It doesn't sound like a there is a compelling reason other than
> "it would be nice to keep the flag values in numerical order".
> 
> I would not recommend this option. I am not seeing any value to adding
> change URB_* to USBIP_FLAGS_* layer without some serious techinical
> concerns.
> 
> > 
> > Another way is to use 0x0400 for FREE_COHERENT.
> > usbip will not take care of this bit as
> > it would be masked.
> > 
> 
> I would go with this option adding a clear comment with link to this
> discussion.
> 
> > Cc Shuah Khan here since she is the maintainer
> > on usbip.
> > 
> 
> Thank you adding me to the discussion.

I can see this causing more problems in the future.  There's no hint in 
include/linux/usb.h that any of the values it defines are part of a user 
API.  If they are, they should be moved to include/uapi/linux/usb/.

In general, if a user program depends on kernel details that are not 
designed to be part of a user API, you should expect that the program 
will sometimes break from one kernel version to another.

Yes, I know Linus insists that kernel changes should not cause 
regressions in userspace, but the line has to be drawn somewhere.  
Otherwise the kernel could never change at all.

Alan Stern
