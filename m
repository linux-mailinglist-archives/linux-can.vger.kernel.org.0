Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF9A554635
	for <lists+linux-can@lfdr.de>; Wed, 22 Jun 2022 14:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbiFVJlK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 22 Jun 2022 05:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiFVJlJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Jun 2022 05:41:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08039B89;
        Wed, 22 Jun 2022 02:41:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7955E61A24;
        Wed, 22 Jun 2022 09:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B13EC34114;
        Wed, 22 Jun 2022 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655890867;
        bh=5qL692Hd5cSKHv7J4arhKFpWyRo3BGQULOjXUTJmhbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xIJq5jKEvIHOYk1djc74zijvgHMXenJy3jSVbG2xHY30mFCI0Qdn/s8zWzfGKszJD
         qeYK+4gniyvwrkmkaqSVweozt3xw9XL0n1hcpGiPvC4gCYNWwN3VTqgFg9Gz8He4/4
         RQTDPYfyue96WgvFjxu6NdwRLJlV/+0AGhy3qHmc=
Date:   Wed, 22 Jun 2022 11:41:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Vincent MAILHOL' <mailhol.vincent@wanadoo.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <YrLjsAOlsizMc/1c@kroah.com>
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com>
 <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu>
 <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
 <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Jun 22, 2022 at 09:22:12AM +0000, David Laight wrote:
> From: Vincent MAILHOL
> > Sent: 21 June 2022 16:56
> > 
> > On Wed. 22 Jun 2022 at 00:13, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Tue, Jun 21, 2022 at 11:59:16PM +0900, Vincent MAILHOL wrote:
> > > > I (probably wrongly) assumed that urb::transfer_buffer_length was the
> > > > allocated length and urb::actual_length was what was actually being
> > > > transferred. Right now, I am just confused. Seems that I need to study
> > > > a bit more and understand the real purpose of
> > > > urb::transfer_buffer_length because I still fail to understand in
> > > > which situation this can be different from the allocated length.
> > >
> > > urb->transfer_buffer_length is the amount of data that the driver wants
> > > to send or expects to receive.  urb->actual_length is the amount of data
> > > that was actually sent or actually received.
> > >
> > > Neither of these values has to be the same as the size of the buffer --
> > > but they better not be bigger!
> > 
> > Thanks. Now things are a bit clearer.
> > I guess that for the outcoming URB what I proposed made no sense. For
> > incoming URB, I guess that most of the drivers want to set
> > urb::transfer_buffer once for all with the allocated size and never
> > touch it again.
> > 
> > Maybe the patch only makes sense of the incoming URB. Would it make
> > sense to keep it but with an additional check to trigger a dmesg
> > warning if this is used on an outcoming endpoint and with additional
> > comment that the URB_FREE_COHERENT requires urb::transfer_buffer to be
> > the allocated size?
> 
> IIRC urb are pretty big.

What exactly do you mean by "pretty big" here?  And what is wrong with
that, I have never seen any issues with the current size of that
structure in any benchmark or performance results.  All USB bottlenecks
that I know of are either in the hardware layer, or in the protocol
layer itself (i.e. usb-storage protocol).

> You'd be unlucky if adding an extra field to hold the allocated
> size would ever need more memory.
> So it might just be worth saving the allocated size.

Maybe, yes, then we could transition to allocating the urb and buffer at
the same time like we do partially for iso streams in an urb.  But that
still might be overkill for just this one driver.  I'm curious as to why
a slow and tiny protocol like CAN needs to use usb_alloc_coherent() for
its buffers in the first place.

thanks,

greg k-h
