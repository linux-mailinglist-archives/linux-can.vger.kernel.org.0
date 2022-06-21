Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E755537AE
	for <lists+linux-can@lfdr.de>; Tue, 21 Jun 2022 18:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353832AbiFUQO5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 21 Jun 2022 12:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353149AbiFUQO4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2022 12:14:56 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 68D57DFA5
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2022 09:14:51 -0700 (PDT)
Received: (qmail 880438 invoked by uid 1000); 21 Jun 2022 12:14:50 -0400
Date:   Tue, 21 Jun 2022 12:14:50 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Message-ID: <YrHueipopdgnm98z@rowland.harvard.edu>
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com>
 <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu>
 <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Jun 22, 2022 at 12:55:46AM +0900, Vincent MAILHOL wrote:
> On Wed. 22 Jun 2022 at 00:13, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, Jun 21, 2022 at 11:59:16PM +0900, Vincent MAILHOL wrote:
> > > I (probably wrongly) assumed that urb::transfer_buffer_length was the
> > > allocated length and urb::actual_length was what was actually being
> > > transferred. Right now, I am just confused. Seems that I need to study
> > > a bit more and understand the real purpose of
> > > urb::transfer_buffer_length because I still fail to understand in
> > > which situation this can be different from the allocated length.
> >
> > urb->transfer_buffer_length is the amount of data that the driver wants
> > to send or expects to receive.  urb->actual_length is the amount of data
> > that was actually sent or actually received.
> >
> > Neither of these values has to be the same as the size of the buffer --
> > but they better not be bigger!
> 
> Thanks. Now things are a bit clearer.
> I guess that for the outcoming URB what I proposed made no sense. For
> incoming URB, I guess that most of the drivers want to set
> urb::transfer_buffer once for all with the allocated size and never
> touch it again.

Not necessarily.  Some drivers may behave differently from the way you 
expect.

> Maybe the patch only makes sense of the incoming URB. Would it make
> sense to keep it but with an additional check to trigger a dmesg
> warning if this is used on an outcoming endpoint and with additional
> comment that the URB_FREE_COHERENT requires urb::transfer_buffer to be
> the allocated size?

Well, what really matters is that the transfer_buffer_length value has 
to be the same as the size of the buffer.  If that's true, the direction 
of the URB doesn't matter.  So yes, that requirement would definitely 
need to be documented.

On the other hand, there wouldn't be any way to tell automatically if 
the requirement was violated.  And since this function could only be 
used with some of the URBs you're interested in, does it make sense to 
add it at all?  The other URBs would still need their buffers to be 
freed manually.

Alan Stern
