Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E60553403
	for <lists+linux-can@lfdr.de>; Tue, 21 Jun 2022 15:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345600AbiFUNvy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 21 Jun 2022 09:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiFUNvx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2022 09:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D12E0BF;
        Tue, 21 Jun 2022 06:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 019286160D;
        Tue, 21 Jun 2022 13:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3431AC3411C;
        Tue, 21 Jun 2022 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655819511;
        bh=4IevcmVifiYxJwwWuX2Wh2QeaRSnAhsRk0vlmdpTTBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOpKHbGF0He1d+bfu/6FO2fxoH7NXzM5bK/nXg7AZt5TJin8ZqxDroupfziD8qV5N
         ONrpCb3Sst6fu7/mmxs5IBj3ODZViZ95q+iwMWiO9wGwjcc1/CO8Elwi3RLeMvsFK1
         63Fe43tnGZKOL7vlRP99dLm6fJLQ51rq7JQvEbQ4=
Date:   Tue, 21 Jun 2022 15:51:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <YrHM8mqG3WVVesk4@kroah.com>
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, Jun 12, 2022 at 01:06:37AM +0900, Vincent MAILHOL wrote:
> On Sun. 12 juin 2022 at 00:31, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > On 10.06.2022 17:33:35, Rhett Aultman wrote:
> > > From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > >
> > > When allocating URB memory with kmalloc(), drivers can simply set the
> > > URB_FREE_BUFFER flag in urb::transfer_flags and that way, the memory
> > > will be freed in the background when killing the URB (for example with
> > > usb_kill_anchored_urbs()).
> > >
> > > However, there are no equivalent mechanism when allocating DMA memory
> > > (with usb_alloc_coherent()).
> > >
> > > This patch adds a new flag: URB_FREE_COHERENT. Setting this flag will
> > > cause the kernel to automatically call usb_free_coherent() on the
> > > transfer buffer when the URB is killed, similarly to how
> > > URB_FREE_BUFFER triggers a call to kfree().
> > >
> > > In order to have all the flags in numerical order, URB_DIR_IN is
> > > renumbered from 0x0200 to 0x0400 so that URB_FREE_COHERENT can reuse
> > > value 0x0200.
> > >
> > > Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > Co-developed-by: Rhett Aultman <rhett.aultman@samsara.com>
> > > Signed-off-by: Rhett Aultman <rhett.aultman@samsara.com>
> > > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > FWIW:
> > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >
> > This patch probably goes upstream via USB. Once this is in net I'll take
> > the 2nd patch.
> 
> Question to Greg: can this first patch also be applied to the stable
> branches? Technically, this is a new feature but it will be used to
> solve several memory leaks on existing drivers (the gs_usb is only one
> example).

We take in dependent patches into the stable trees all the time when
needed, that's not an issue here.

What is an issue here is that this feels odd as other USB developers
said previously.

My big objection here is what validates that the size of the transfer
buffer here is really the size of the buffer to be freed?  Is that
always set properly to be the length that was allocated?  That might
just be the size of the last transfer using this buffer, but there is no
guarantee that I can see of that says this really is the length of the
allocated buffer, which is why usb_free_coherent() requires a size
parameter.

If that guarantee is always right, then we should be able to drop the
size option in usb_free_coherent(), and I don't think that's really
possible.

thanks,

greg k-h
