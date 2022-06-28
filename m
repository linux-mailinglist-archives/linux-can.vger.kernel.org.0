Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E42D55C7B1
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 14:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiF1BJd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 27 Jun 2022 21:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241375AbiF1BJ3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Jun 2022 21:09:29 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26CA237D4
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 18:09:28 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3176b6ed923so101673597b3.11
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 18:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MoMKq1/nqwYOa9g36VIe9NCfjxw2u/IcJSEJSWb2STQ=;
        b=IbeKylLgEUpGQysaW4EkLXl2dXAhKP7jcOjiU/nVbpozccUvQvPmtCX886R72q+4hq
         ZJxK1u75b2RSRn2rORxQdZ89acKorsHmOVGh71PVvITKfWnuxiRwGPrPy4Xcw6zIxsh0
         WD8y6E7602DHxuaZ7WjTJClzrzJDq1T1lAqhIfzjn7mSjRfcfprh922r2JmY4tqAS2NH
         Lw8er+n5RUsnqTMmWzzAHQwYZ48kaNLMpjyARGHOLcoZ0Us77QR8L82bHftLpNlHmV3k
         iWjNuazAHpqPZMeOLORCyCTU99cmFQ5SK7RmdiHXujlb46gg6BYNRA/zW5oS40Gzt1IV
         zOiQ==
X-Gm-Message-State: AJIora/GbDz1Q5sT8ZOnnbBonVZLPU3tDe4JXbgyehVol2k/AsFGonKs
        Ewuh4dlU5ST+K5xnVTeMBi6akICUBzE1Vx/2P6U=
X-Google-Smtp-Source: AGRyM1sotB4Jr1MtNPFUdiG/kEP8aiK0KuBqE9r8mZMjZpwQOS3TFIora5WmNn9kZRw2bUvi8O3afOA9CQJj41iy9DA=
X-Received: by 2002:a0d:f285:0:b0:31b:c2d6:2ce9 with SMTP id
 b127-20020a0df285000000b0031bc2d62ce9mr9327952ywf.172.1656378567697; Mon, 27
 Jun 2022 18:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de> <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com> <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu> <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
 <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com> <YrLjsAOlsizMc/1c@kroah.com>
 <CAMZ6Rq+e+i0xGuWeMaGyTVyLJy=q2vQZqXjYoACws=T_B-FOGQ@mail.gmail.com>
 <YrMJ0vXR84cISTse@kroah.com> <CAMZ6RqJZKYOTtLpiM3ie3fNOBm8i7d8yr8n7S=yAm6twbuhGrQ@mail.gmail.com>
 <99ac782c-46e7-bbef-8f54-cf2fd67acdc@samsara.com> <CAMZ6Rq+FSzy5ijQZhYyVJrbe86U9faD5aPFO4cezNkN9G-USzQ@mail.gmail.com>
 <337d5316-82bb-e048-2014-b0634fadf8@samsara.com>
In-Reply-To: <337d5316-82bb-e048-2014-b0634fadf8@samsara.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 28 Jun 2022 10:09:16 +0900
Message-ID: <CAMZ6Rq+hPC4N=_jGioUyaG0ezTE2qM8gDZic3ETESm0P=vkU9Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Rhett Aultman <rhett.aultman@samsara.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 28 Jun 2022 at 04:37, Rhett Aultman <rhett.aultman@samsara.com> wrote:
> On Sun, 26 Jun 2022, Vincent MAILHOL wrote:
> > On Thu. 23 Jun 2022 at 03:13, Rhett Aultman <rhett.aultman@samsara.com> wrote:
> > > On Thu, 23 Jun 2022, Vincent MAILHOL wrote:
> > > > On Wed. 22 Jun 2022 at 21:24, Greg Kroah-Hartman
> > > > Yes, this would give a clear answer whether or not DMA was needed in
> > > > the first place. But I do not own that gs_usb device to do the
> > > > benchmark myself (and to be honest I do not have time to dedicate for
> > > > this at the moment, maybe I will do it later on some other devices).
> > > >
> > > > Has anyone from the linux-can mailing list ever done such a benchmark?
> > > > Else, is there anyone who would like to volunteer?
> > >
> > > I have access to a couple of gs_usb devices but I am afraid I have no
> > > experience performing this sort of benchmarking and also would have to
> > > squeeze it in as a weekend project or something similar.  That said, if
> > > someone's willing to help step me through it, I can see if it's feasible
> > > for me to do.
> >
> > I can throw a few hints which might be helpful.
> >
> > First, you should obviously prepare two versions of the gs_usb driver:
> > one using usb_alloc_coherent() (the current one), the other using
> > kmalloc() and compare the two.
> >
> > Right now, I can think of two relevant benchmarks: transmission
> > latency and CPU load.
> >
> > For the transmission latency, I posted one on my tools:
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dcan_20220626075317.746535-2D1-2Dmailhol.vincent-40wanadoo.fr_T_-23u&d=DwIFaQ&c=5cz3ZESzsFPW6Kn30oD8Yg&r=yZeJccB4JMhCRfLQXCMV_s56v3-BAi0tMrD3qzCwGTk&m=E5qqM5zYANpQqfZ0c8AHYrd-lkJZsS6-u-Jj2iTfHIjLle6JxCMRuTlmC_3bH8oA&s=sqvGqOvbtLqlZGMC-9q6gY1nF3203MT7gJIIqbKEXUM&e=
> >
> > For the CPU load, I suggest to put the bus on full load, for example using:
> > | cangen -g0 -p1 can0
> > (you might also want to play with other parameters such as the length using -L)
> > Then use an existing tool to get the CPU load figures. I don't know
> > for sure which tool is a good one to benchmark CPU usage in kernel
> > land so you will have to research that part. If anyone has a
> > suggestion…
> >
> > > That said, the gs_usb driver is mostly following along a very well
> > > established pattern for writing USB CAN devices.  Both the pattern
> > > followed that created the memory leak, as well as the pattern I followed
> > > to resolve the memory leak, were also seen in the esd2 USB CAN driver as
> > > well, and likely others are following suit.  So, I don't know that we'd
> > > need to keep it specific to gs_usb to gain good information here.
> >
> > Yes, I looked at the log, the very first CAN USB driver is ems_usb and
> > was using DMA memory from the beginning. From that point on, nearly
> > all the drivers copied the trend (the only exception I am aware of is
> > peak_usb).
> >
> > I agree that the scope is wider than the gs_can (thus my proposal to
> > fix it at API level).
>
> (removed the USB mailing list since this is CAN driver related
> specifically)
>
> I appreciate these pointers and I can look into making the time for this.
> As I mentioned, I do have a gs_usb device (a Canable using the Candlelight
> firmware) which can help shed some light on this question.  I do
> understand the ideas being expressed in these pointers.  I do want to
> bring up some practical matters around it.
>
> First, it seems there's a pretty strong set of permutations to consider,
> given that this memory allocation scheme is common to so many drivers.  I
> only have a gs_usb device (a Canable using its CandleLight firmware).  I
> also cannot rule out the possibility that the underlying hardware of the
> host matters here.  For example, I discovered this leak in the first place
> because I work with a specific ARM platform where it's easy to exhaust the
> DMA memory.
>
> Secondly, this sort of benchmarking work will require lab setup time and
> my locating adequate free time in which to do it.  This isn't exactly
> labor covered under the original mandate from my employer, so I'm going to
> have to figure out how to work it in.

There is no rush. If this is interesting for you, go ahead, but I
won’t blame you if you prefer to give up for lack of time or
motivation.

> In light of this, while I remain committed to helping work the problem, I
> can't help but wonder if it's worth it to consider my original patch in a
> new light?

Yes, it makes sense to take your initial patch. I will reiterate that
I do not like the way it is done but you are fixing a memory leak and
delaying the fix furthermore is not good.

I am curious to see the benchmark results but at the same time, I do
not want to force anyone to do it.

If Marc agrees, I think we should just take your initial patch as is.
And later we can reconsider those two options:
  * apply the URB_FREE_COHERENT flag if the flag gets accepted (not
sure anymore that would be the case).
  * change from DMA memory to normal kmalloc()ed memory depending on
the benchmark result

Personally, I will try to push a bit more for the inclusion of the
URB_FREE_COHERENT flag.

> The code is less elegant than it otherwise could be, but it's
> consistent with practices found in the other drivers and it does resolve
> the original issue of leaking DMA memory.  I'd hate to see a long-standing
> issue continue to languish because I struggle to find adequate time to
> devote to the benchmarking needed to reach a decision about the USB API
> changes we've proposed.


Yours sincerely,
Vincent Mailhol
