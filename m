Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3342B554A03
	for <lists+linux-can@lfdr.de>; Wed, 22 Jun 2022 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiFVMX7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 22 Jun 2022 08:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353361AbiFVMXv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Jun 2022 08:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A204E2A259;
        Wed, 22 Jun 2022 05:23:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD1D6190E;
        Wed, 22 Jun 2022 12:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B68AC34114;
        Wed, 22 Jun 2022 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655900629;
        bh=3Kg9nFlakGr/PSRaWbQsMv5Lns/PbxON5UeoyDZ+s+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MByGwcZp8/4rCN1qV1ZbQZQAVwFWJpbhkq7VLT7OxDnbGGZN6S4FLKbzSLLvtIr8v
         FB6a+73GixwU4IxkKxxr67Zz4Mi3Rgx7YG0Ivfk9Yx/87dBme5DTXNA8ZMNWG1GZw0
         c5by9zZuE78tsRWRmoUuzR5lbzbNbevRF602UeXY=
Date:   Wed, 22 Jun 2022 14:23:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     David Laight <David.Laight@aculab.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <YrMJ0vXR84cISTse@kroah.com>
References: <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com>
 <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu>
 <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
 <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com>
 <YrLjsAOlsizMc/1c@kroah.com>
 <CAMZ6Rq+e+i0xGuWeMaGyTVyLJy=q2vQZqXjYoACws=T_B-FOGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+e+i0xGuWeMaGyTVyLJy=q2vQZqXjYoACws=T_B-FOGQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Jun 22, 2022 at 07:34:57PM +0900, Vincent MAILHOL wrote:
> On Wed. 22 Jun 2022 at 18:44, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Wed, Jun 22, 2022 at 09:22:12AM +0000, David Laight wrote:
> > > From: Vincent MAILHOL
> > > > Sent: 21 June 2022 16:56
> > > >
> > > > On Wed. 22 Jun 2022 at 00:13, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > > On Tue, Jun 21, 2022 at 11:59:16PM +0900, Vincent MAILHOL wrote:
> > > > > > I (probably wrongly) assumed that urb::transfer_buffer_length was the
> > > > > > allocated length and urb::actual_length was what was actually being
> > > > > > transferred. Right now, I am just confused. Seems that I need to study
> > > > > > a bit more and understand the real purpose of
> > > > > > urb::transfer_buffer_length because I still fail to understand in
> > > > > > which situation this can be different from the allocated length.
> > > > >
> > > > > urb->transfer_buffer_length is the amount of data that the driver wants
> > > > > to send or expects to receive.  urb->actual_length is the amount of data
> > > > > that was actually sent or actually received.
> > > > >
> > > > > Neither of these values has to be the same as the size of the buffer --
> > > > > but they better not be bigger!
> > > >
> > > > Thanks. Now things are a bit clearer.
> > > > I guess that for the outcoming URB what I proposed made no sense. For
> > > > incoming URB, I guess that most of the drivers want to set
> > > > urb::transfer_buffer once for all with the allocated size and never
> > > > touch it again.
> > > >
> > > > Maybe the patch only makes sense of the incoming URB. Would it make
> > > > sense to keep it but with an additional check to trigger a dmesg
> > > > warning if this is used on an outcoming endpoint and with additional
> > > > comment that the URB_FREE_COHERENT requires urb::transfer_buffer to be
> > > > the allocated size?
> > >
> > > IIRC urb are pretty big.
> >
> > What exactly do you mean by "pretty big" here?  And what is wrong with
> > that, I have never seen any issues with the current size of that
> > structure in any benchmark or performance results.  All USB bottlenecks
> > that I know of are either in the hardware layer, or in the protocol
> > layer itself (i.e. usb-storage protocol).
> >
> > > You'd be unlucky if adding an extra field to hold the allocated
> > > size would ever need more memory.
> > > So it might just be worth saving the allocated size.
> >
> > Maybe, yes, then we could transition to allocating the urb and buffer at
> > the same time like we do partially for iso streams in an urb.  But that
> > still might be overkill for just this one driver.
> 
> Well, I wouldn't have proposed the patch if it only applied to a
> single driver. If we add a urb::allocated_transfer_size as suggested
> by David, I believe that the majority of the drivers using DMA memory
> will be able to rely on that URB_FREE_COHERENT flag for the garbage
> collection.
> 
> The caveat, as you pointed before, is that the developper still needs
> to be aware of the limitations of DMA and that it should not be freed
> in an IRQ context. e.g. no call to usb_kill_anchored_urbs() or other
> functions that would lead to urb_destroy().
> 
> > I'm curious as to why
> > a slow and tiny protocol like CAN needs to use usb_alloc_coherent() for
> > its buffers in the first place.
> 
> The CAN protocol, in its latest revision, allows for transfer speed up
> to ~5Mbits. For low performance CPUs, this starts to be a significant
> load. Also, the CAN PDU being small (0 to 64 bytes), many small
> transfers occur.

And is the memcpy the actual issue here?  Even tiny cpus can do large
and small memcopy very very very fast.

> Unfortunately I did not do any benchmark myself so I won't be able to
> back my explanation with numbers.

That might be the simplest solution here :)

thanks,

greg k-h
