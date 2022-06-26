Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2BB55B038
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiFZIVs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Sun, 26 Jun 2022 04:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiFZIVr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 04:21:47 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5712AB3;
        Sun, 26 Jun 2022 01:21:46 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-317710edb9dso60357907b3.0;
        Sun, 26 Jun 2022 01:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ynctAWj3sb2Doj7zuTbKT66k+GKUiSPQTvRPB3/km58=;
        b=EFSFSRSNBj1Voe2lRZ1OKqGDshpE5NODidrAAjP9whvBUMcy69i2m7bYPK6/2jCg5Z
         h6tXJLaSSuerSRgeEFoeGoCBLCGdLE4JHDXHb5wSzWBeDM6zFjiOSw+0YJZjXXUzP3qD
         ph2vLPKQerpWB8WlYnkmkNwrkw+bQi0fVmLX7HzGbMJz+jg82fHPCOIH+zuNRcxxjl+R
         anjlPMhudMMFx0IGCWu+GYhIu+baiHpuVqUE7A845o+ymZEkVbtuc5fx6olQ2XW8WL8Y
         /qmPEjYy2uXXN5P5M9SzkauWtYvhxXM9GZU9+NRNMkxsoIvPdiBC8yo9PfQkyuNLZ4ZO
         ub7A==
X-Gm-Message-State: AJIora8us+7fIhWEUFuOsxdjzOWrw24TdfYnPJWlD3BThVQaaa9MOdBf
        ABvNYORujDZR30biBuMGCCHRsytW3Bt/NmEejIA=
X-Google-Smtp-Source: AGRyM1v9DQaAV35au2JmO9Ia6T0Rzvzys8tziB6G6qNpxQRzqotrcma5S4N1skFO4Hd7yDIVQYUyEHHBGBMC1jROeWY=
X-Received: by 2002:a81:4fca:0:b0:318:68fe:a20e with SMTP id
 d193-20020a814fca000000b0031868fea20emr8532028ywb.220.1656231705797; Sun, 26
 Jun 2022 01:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de> <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com> <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu> <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
 <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com> <YrLjsAOlsizMc/1c@kroah.com>
 <CAMZ6Rq+e+i0xGuWeMaGyTVyLJy=q2vQZqXjYoACws=T_B-FOGQ@mail.gmail.com>
 <YrMJ0vXR84cISTse@kroah.com> <CAMZ6RqJZKYOTtLpiM3ie3fNOBm8i7d8yr8n7S=yAm6twbuhGrQ@mail.gmail.com>
 <99ac782c-46e7-bbef-8f54-cf2fd67acdc@samsara.com>
In-Reply-To: <99ac782c-46e7-bbef-8f54-cf2fd67acdc@samsara.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 26 Jun 2022 17:21:34 +0900
Message-ID: <CAMZ6Rq+FSzy5ijQZhYyVJrbe86U9faD5aPFO4cezNkN9G-USzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu. 23 Jun 2022 at 03:13, Rhett Aultman <rhett.aultman@samsara.com> wrote:
> On Thu, 23 Jun 2022, Vincent MAILHOL wrote:
> > On Wed. 22 Jun 2022 at 21:24, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Wed, Jun 22, 2022 at 07:34:57PM +0900, Vincent MAILHOL wrote:
> > > > On Wed. 22 Jun 2022 at 18:44, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Wed, Jun 22, 2022 at 09:22:12AM +0000, David Laight wrote:
> > > > > > From: Vincent MAILHOL
> > > > > > > Sent: 21 June 2022 16:56
> > > > > > >
> > > > > > > On Wed. 22 Jun 2022 at 00:13, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > > > > > On Tue, Jun 21, 2022 at 11:59:16PM +0900, Vincent MAILHOL wrote:
> > > > > > > > > I (probably wrongly) assumed that urb::transfer_buffer_length was the
> > > > > > > > > allocated length and urb::actual_length was what was actually being
> > > > > > > > > transferred. Right now, I am just confused. Seems that I need to study
> > > > > > > > > a bit more and understand the real purpose of
> > > > > > > > > urb::transfer_buffer_length because I still fail to understand in
> > > > > > > > > which situation this can be different from the allocated length.
> > > > > > > >
> > > > > > > > urb->transfer_buffer_length is the amount of data that the driver wants
> > > > > > > > to send or expects to receive.  urb->actual_length is the amount of data
> > > > > > > > that was actually sent or actually received.
> > > > > > > >
> > > > > > > > Neither of these values has to be the same as the size of the buffer --
> > > > > > > > but they better not be bigger!
> > > > > > >
> > > > > > > Thanks. Now things are a bit clearer.
> > > > > > > I guess that for the outcoming URB what I proposed made no sense. For
> > > > > > > incoming URB, I guess that most of the drivers want to set
> > > > > > > urb::transfer_buffer once for all with the allocated size and never
> > > > > > > touch it again.
> > > > > > >
> > > > > > > Maybe the patch only makes sense of the incoming URB. Would it make
> > > > > > > sense to keep it but with an additional check to trigger a dmesg
> > > > > > > warning if this is used on an outcoming endpoint and with additional
> > > > > > > comment that the URB_FREE_COHERENT requires urb::transfer_buffer to be
> > > > > > > the allocated size?
> > > > > >
> > > > > > IIRC urb are pretty big.
> > > > >
> > > > > What exactly do you mean by "pretty big" here?  And what is wrong with
> > > > > that, I have never seen any issues with the current size of that
> > > > > structure in any benchmark or performance results.  All USB bottlenecks
> > > > > that I know of are either in the hardware layer, or in the protocol
> > > > > layer itself (i.e. usb-storage protocol).
> > > > >
> > > > > > You'd be unlucky if adding an extra field to hold the allocated
> > > > > > size would ever need more memory.
> > > > > > So it might just be worth saving the allocated size.
> > > > >
> > > > > Maybe, yes, then we could transition to allocating the urb and buffer at
> > > > > the same time like we do partially for iso streams in an urb.  But that
> > > > > still might be overkill for just this one driver.
> > > >
> > > > Well, I wouldn't have proposed the patch if it only applied to a
> > > > single driver. If we add a urb::allocated_transfer_size as suggested
> > > > by David, I believe that the majority of the drivers using DMA memory
> > > > will be able to rely on that URB_FREE_COHERENT flag for the garbage
> > > > collection.
> > > >
> > > > The caveat, as you pointed before, is that the developper still needs
> > > > to be aware of the limitations of DMA and that it should not be freed
> > > > in an IRQ context. e.g. no call to usb_kill_anchored_urbs() or other
> > > > functions that would lead to urb_destroy().
> > > >
> > > > > I'm curious as to why
> > > > > a slow and tiny protocol like CAN needs to use usb_alloc_coherent() for
> > > > > its buffers in the first place.
> > > >
> > > > The CAN protocol, in its latest revision, allows for transfer speed up
> > > > to ~5Mbits. For low performance CPUs, this starts to be a significant
> > > > load. Also, the CAN PDU being small (0 to 64 bytes), many small
> > > > transfers occur.
> > >
> > > And is the memcpy the actual issue here?  Even tiny cpus can do large
> > > and small memcopy very very very fast.
> > >
> > > > Unfortunately I did not do any benchmark myself so I won't be able to
> > > > back my explanation with numbers.
> > >
> > > That might be the simplest solution here :)
> >
> > Yes, this would give a clear answer whether or not DMA was needed in
> > the first place. But I do not own that gs_usb device to do the
> > benchmark myself (and to be honest I do not have time to dedicate for
> > this at the moment, maybe I will do it later on some other devices).
> >
> > Has anyone from the linux-can mailing list ever done such a benchmark?
> > Else, is there anyone who would like to volunteer?
>
> I have access to a couple of gs_usb devices but I am afraid I have no
> experience performing this sort of benchmarking and also would have to
> squeeze it in as a weekend project or something similar.  That said, if
> someone's willing to help step me through it, I can see if it's feasible
> for me to do.

I can throw a few hints which might be helpful.

First, you should obviously prepare two versions of the gs_usb driver:
one using usb_alloc_coherent() (the current one), the other using
kmalloc() and compare the two.

Right now, I can think of two relevant benchmarks: transmission
latency and CPU load.

For the transmission latency, I posted one on my tools:
https://lore.kernel.org/linux-can/20220626075317.746535-1-mailhol.vincent@wanadoo.fr/T/#u

For the CPU load, I suggest to put the bus on full load, for example using:
| cangen -g0 -p1 can0
(you might also want to play with other parameters such as the length using -L)
Then use an existing tool to get the CPU load figures. I don't know
for sure which tool is a good one to benchmark CPU usage in kernel
land so you will have to research that part. If anyone has a
suggestion…

> That said, the gs_usb driver is mostly following along a very well
> established pattern for writing USB CAN devices.  Both the pattern
> followed that created the memory leak, as well as the pattern I followed
> to resolve the memory leak, were also seen in the esd2 USB CAN driver as
> well, and likely others are following suit.  So, I don't know that we'd
> need to keep it specific to gs_usb to gain good information here.

Yes, I looked at the log, the very first CAN USB driver is ems_usb and
was using DMA memory from the beginning. From that point on, nearly
all the drivers copied the trend (the only exception I am aware of is
peak_usb).

I agree that the scope is wider than the gs_can (thus my proposal to
fix it at API level).


Yours sincerely,
Vincent Mailhol
