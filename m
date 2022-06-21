Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839B1553850
	for <lists+linux-can@lfdr.de>; Tue, 21 Jun 2022 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbiFURA2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 21 Jun 2022 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343787AbiFURAZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2022 13:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CA248CC;
        Tue, 21 Jun 2022 10:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A22426155D;
        Tue, 21 Jun 2022 17:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87163C3411C;
        Tue, 21 Jun 2022 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655830822;
        bh=0rMyK2K+/EqKh2GM81HpGDCaeBFZDmcKKmXPJ49Hw6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzykcWcZ7GGQpkoGomUoQcwTYfFgiy/SYiT3K6sB/paWNpNUUS2d4RMy7BWuh34xh
         yiDb9EMJwVUZHB1LADCgfHRWB44osfhzkIDYhjxlkHYXvmR1ka6rmlBPpAOlLVOLlJ
         n7tJM3FxBQMeMkhbX43GQnUUOY2nX2t/N3vEMhUs=
Date:   Tue, 21 Jun 2022 19:00:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <YrH5ImIssE/dLZln@kroah.com>
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com>
 <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu>
 <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
 <YrHueipopdgnm98z@rowland.harvard.edu>
 <CAMZ6RqLWKQWrpwfx81dj+Oh5MNcbJ+DdbqC9UQSOEqZcuY5spQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLWKQWrpwfx81dj+Oh5MNcbJ+DdbqC9UQSOEqZcuY5spQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Jun 22, 2022 at 01:40:10AM +0900, Vincent MAILHOL wrote:
> On Wed 22 Jun 2022 at 01:15, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Wed, Jun 22, 2022 at 12:55:46AM +0900, Vincent MAILHOL wrote:
> > > On Wed. 22 Jun 2022 at 00:13, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > On Tue, Jun 21, 2022 at 11:59:16PM +0900, Vincent MAILHOL wrote:
> > > > > I (probably wrongly) assumed that urb::transfer_buffer_length was the
> > > > > allocated length and urb::actual_length was what was actually being
> > > > > transferred. Right now, I am just confused. Seems that I need to study
> > > > > a bit more and understand the real purpose of
> > > > > urb::transfer_buffer_length because I still fail to understand in
> > > > > which situation this can be different from the allocated length.
> > > >
> > > > urb->transfer_buffer_length is the amount of data that the driver wants
> > > > to send or expects to receive.  urb->actual_length is the amount of data
> > > > that was actually sent or actually received.
> > > >
> > > > Neither of these values has to be the same as the size of the buffer --
> > > > but they better not be bigger!
> > >
> > > Thanks. Now things are a bit clearer.
> > > I guess that for the outcoming URB what I proposed made no sense. For
> > > incoming URB, I guess that most of the drivers want to set
> > > urb::transfer_buffer once for all with the allocated size and never
> > > touch it again.
> >
> > Not necessarily.  Some drivers may behave differently from the way you
> > expect.
> 
> Yes, my point is not to generalise. Agree that there are exceptions.
> 
> > > Maybe the patch only makes sense of the incoming URB. Would it make
> > > sense to keep it but with an additional check to trigger a dmesg
> > > warning if this is used on an outcoming endpoint and with additional
> > > comment that the URB_FREE_COHERENT requires urb::transfer_buffer to be
> > > the allocated size?
> >
> > Well, what really matters is that the transfer_buffer_length value has
> > to be the same as the size of the buffer.  If that's true, the direction
> > of the URB doesn't matter.  So yes, that requirement would definitely
> > need to be documented.
> >
> > On the other hand, there wouldn't be any way to tell automatically if
> > the requirement was violated.
> 
> ACK. That's why I said "add comment" and not "check".
> 
> > And since this function could only be
> > used with some of the URBs you're interested in, does it make sense to
> > add it at all?  The other URBs would still need their buffers to be
> > freed manually.
> 
> The rationale is that similarly to URB_FREE_BUFFER, this would be
> optional. This is why I did not propose to reuse
> URB_NO_TRANSFER_DMA_MAP but instead add a new flag. I propose it
> because I think that many drivers can benefit from it.
> 
> More than that, the real concern is that many developers forget to
> free the DMA allocated memory. c.f. original message of this thread:
> https://lore.kernel.org/linux-can/alpine.DEB.2.22.394.2206031547001.1630869@thelappy/T/#m2ef343d3ee708178b1e37be898884bafa7f49f2f
> 
> And the usual fix requires to create local arrays to store references
> to the transfer buffer and DMA addresses.

Why not just free the memory in the urb completion function that is
called when it is finished?

thanks,

greg k-h
