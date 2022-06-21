Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA355389F
	for <lists+linux-can@lfdr.de>; Tue, 21 Jun 2022 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352648AbiFUROy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 21 Jun 2022 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiFUROw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2022 13:14:52 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFFD28E3B;
        Tue, 21 Jun 2022 10:14:49 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3176d94c236so137884137b3.3;
        Tue, 21 Jun 2022 10:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0c6IWfWUCMepA0AO1NhbowQUP+BgY1Od7oT+DjrnsCg=;
        b=oSfDt4tJS/iRrN0CHHyNCBLvMUAUfTay3uPgFRbinW8smR48Xe1fNw5KzAiSFpQYF3
         cMAB06T3ZOZxZh7RuAsWVBMI2ihKbhEzoT1/2ibfMmYoxRt3vjEnTrPixh/eJ/085GRL
         5dLckx9Q/P40niEj+Y74P4nKtl5qU53MR89guaXnB4CtrsE+XY/Ox28xKcVFaUd1VyU5
         Dw6WKCA5NfnkyCIMp3u2Ikn1vNQHf2kfbhKnzlW1qkfEDjIUyOquNLU8vS4lAAKMX+Kl
         pYxjyLV90bbr31awMoaVnVcctiNZabYO26JUe0MCStd979kJiXPOdQKJ6VCJKHCGnN/2
         5G7g==
X-Gm-Message-State: AJIora9jyVpxvQynloSp8iFxVLzWjUObjfnUZgsWstx19cLH7k4iGjUU
        7LY9oul5qbYAb6DGaMEGw4VK5MHhJf+fflSnnNA=
X-Google-Smtp-Source: AGRyM1tdSwZcw8a4rMQ0Utr/y8fOjnSeNCcHKVx4kcx1Xm0P69n1RCIDSxdPOsySq7sbCyIdShLap/WJU4uoi1cdIVg=
X-Received: by 2002:a0d:f9c2:0:b0:317:e067:5104 with SMTP id
 j185-20020a0df9c2000000b00317e0675104mr10240039ywf.45.1655831688560; Tue, 21
 Jun 2022 10:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com> <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com> <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu> <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
 <YrHueipopdgnm98z@rowland.harvard.edu> <CAMZ6RqLWKQWrpwfx81dj+Oh5MNcbJ+DdbqC9UQSOEqZcuY5spQ@mail.gmail.com>
 <YrH5ImIssE/dLZln@kroah.com>
In-Reply-To: <YrH5ImIssE/dLZln@kroah.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 22 Jun 2022 02:14:37 +0900
Message-ID: <CAMZ6RqJrxoy=C4Ag7j6nzDkk+A1dh3V_q9T_VeWyUfZiuGb3nQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 22 Jun 2022 at 02:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Jun 22, 2022 at 01:40:10AM +0900, Vincent MAILHOL wrote:
> > On Wed 22 Jun 2022 at 01:15, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Wed, Jun 22, 2022 at 12:55:46AM +0900, Vincent MAILHOL wrote:
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
> > >
> > > Not necessarily.  Some drivers may behave differently from the way you
> > > expect.
> >
> > Yes, my point is not to generalise. Agree that there are exceptions.
> >
> > > > Maybe the patch only makes sense of the incoming URB. Would it make
> > > > sense to keep it but with an additional check to trigger a dmesg
> > > > warning if this is used on an outcoming endpoint and with additional
> > > > comment that the URB_FREE_COHERENT requires urb::transfer_buffer to be
> > > > the allocated size?
> > >
> > > Well, what really matters is that the transfer_buffer_length value has
> > > to be the same as the size of the buffer.  If that's true, the direction
> > > of the URB doesn't matter.  So yes, that requirement would definitely
> > > need to be documented.
> > >
> > > On the other hand, there wouldn't be any way to tell automatically if
> > > the requirement was violated.
> >
> > ACK. That's why I said "add comment" and not "check".
> >
> > > And since this function could only be
> > > used with some of the URBs you're interested in, does it make sense to
> > > add it at all?  The other URBs would still need their buffers to be
> > > freed manually.
> >
> > The rationale is that similarly to URB_FREE_BUFFER, this would be
> > optional. This is why I did not propose to reuse
> > URB_NO_TRANSFER_DMA_MAP but instead add a new flag. I propose it
> > because I think that many drivers can benefit from it.
> >
> > More than that, the real concern is that many developers forget to
> > free the DMA allocated memory. c.f. original message of this thread:
> > https://lore.kernel.org/linux-can/alpine.DEB.2.22.394.2206031547001.1630869@thelappy/T/#m2ef343d3ee708178b1e37be898884bafa7f49f2f
> >
> > And the usual fix requires to create local arrays to store references
> > to the transfer buffer and DMA addresses.
>
> Why not just free the memory in the urb completion function that is
> called when it is finished?

I thought it was a bad thing to call usb_free_coherent() in the
completion function and that the best practice was to allocate all the
DMA memory when opening the device, reuse them during runtime and free
everything when closing the device.

Especially, correct me if I am wrong, but isn't there a risk to
trigger below warning if calling usb_free_coherent() in an IRQ context
(which is the case in the completion function)?
https://elixir.bootlin.com/linux/v5.18/source/kernel/dma/mapping.c#L526


Yours sincerely,
Vincent Mailhol
