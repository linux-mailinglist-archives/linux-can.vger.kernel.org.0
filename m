Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E248055D02C
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 15:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiF1A4R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 27 Jun 2022 20:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiF1A4R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Jun 2022 20:56:17 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684F71D0DC
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 17:56:13 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id p136so13421275ybg.4
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 17:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KxIJGsuZXlSHNGn8w8kRs2clSvA9PEMum+t1Bb1hlxw=;
        b=rIY0+O96KJMKGFiXxny1Pan0xSUMkgrgrhrBXXNtfQkRpeJbf/Vs5mh9uH8rrZawzE
         YV8ntjPiGSvI5qkFSWSBjEjn4HUOcHYq9TycPUz3kHJEKr5fS4eWUFhV0m1GxtkMV64N
         4zSwWDROmaBVnj1pN5ZvQjS85ArSt47nDV9Vyiby3oOOoqUDkBs4J3C3JAy9sbVNt9gi
         r+egTTsylU9RxVNvnlkI8h3DNsduAk2MxcXUmRmpMf17yOuUOfUayo1kzer+cP3Xi2tv
         j5OMYxCEAEeCan5SapQqSqsb+otrJMo0uyH2ZAUZ7i5jVatuYd4uqredWIOSNnQzSesH
         pr/g==
X-Gm-Message-State: AJIora8ZIXQFUBGzA3941Y11/9AY74Arz4nFkvnHi3e2+A9r8oE3rtH2
        t1ttuWXUsk5QghybnACeTBtQ/5OLNoZzlg6phOs=
X-Google-Smtp-Source: AGRyM1tvR5GrOc3SK0oZOs+JTsiUInUqhXU2B7pHBVuXm5+4vlENpWHoC32NFvs0o2X8b01eVzXEhzszodK9s+GSbic=
X-Received: by 2002:a5b:b52:0:b0:669:b5a0:ac98 with SMTP id
 b18-20020a5b0b52000000b00669b5a0ac98mr17618894ybr.142.1656377772610; Mon, 27
 Jun 2022 17:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr>
 <20220626090744.pycu3katdt6vir2l@pengutronix.de> <CAMZ6RqLVKMznm_n4j079rcYLjhj8QjmeM3=bYUeXm_rozmQNVg@mail.gmail.com>
 <20220626105525.va44sseksk3xej7j@pengutronix.de> <CAMZ6Rq+NbmOA89DjA=e_EBJXaDm0T69vbFrjKD+arZivhVqEdA@mail.gmail.com>
 <20220626151506.bzg7wqua572zswag@pengutronix.de>
In-Reply-To: <20220626151506.bzg7wqua572zswag@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 28 Jun 2022 09:56:03 +0900
Message-ID: <CAMZ6RqK+BUWd=4+vga5se6obKJgYCwZp7Emc7UAQbtQ1n4z1Kw@mail.gmail.com>
Subject: Re: [RFC PATCH] can-roundtrip-stats: a tool to benchmark transmission time
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Rhett Aultman <rhett.aultman@samsara.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>
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

+CC: Richard Cochran <richardcochran@gmail.com>

On Mon. 27 Jun. 2022 at 00:34, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 26.06.2022 22:40:13, Vincent MAILHOL wrote:
> > > > > I'm currently playing around with hardware timestmaps in the mcp251xfd
> > > > > driver and the other day I stumbled over commit 741b91f1b0ea ("can: dev:
> > > > > can_put_echo_skb(): add software tx timestamps") and I was thinking
> > > > > which tool you're using to test this. :)
> > > > >
> > > > > Once the hardware timestamps are running stable, this is exactly the
> > > > > tool I need! Thanks for sharing this.
> > > >
> > > > Does the mcp251xfd use the host clock to do its hardware timestamp?
> > >
> > > It uses an external 40 MHz oscillator, usually each device has it's own.
> > >
> > > > (Not sure how SPI hardware works and if they have their own quartz or
> > > > if they share it with the host system). If it is indeed the same clock
> > > > you can have even more precise statistics.
> > >
> > > No, the device clock is not shared with the host system and thus drift
> > > apart. But you can synchronize the device's clock against the system
> > > clock with phc2sys of linuxptp. As soon as the code is stable I'll send
> > > the patches around.
> >
> > This sounds really exciting. I also wanted to play with linuxptp but
> > never had time to start.
>
> I started with adding the basic callback for /dev/ptpX to show up and
> "work", i.e. not crash :). What probably most CAN devices lack is the
> possibility to fine tune the oscillator, but I figured out, there is a
> ptp clock multiplexer in the kernel that does the fine tuning in
> software. I ported that code and now I can run phc2sys on the mcp251xfd.
>
> What does phc2sys do? It's used to synch a PTP Clock to the Linux system
> clock or vice versa. The only sensible use case of this all is to sync
> from the Linux system clock to the mcp251xfd device clock. This way the
> hardware timestamps are within µs of the Linux system clock.
>
> > With the device clock synchronized, you can have decent timestamping
> > between different hardware (potentially of different brands).
>
> So far I only synchronize the Linux system clock into the mcp251xfd
> clock. I could synchronize a 2nd CAN adapter implementing a /dev/ptp on
> the same system, too.
>
> > The drawback is that you would lose a bit of precision: the hardware
> > timestamp have an accuracy around 1 microsecond. After using PTP, I
> > would expect the precision to degrade to roughly 100 microsecond
> > (which is still way better than what software timestamping can offer).
>
> Synchronizing time via CAN between different systems would be the next
> logical step. But linuxptp needs code to map the PTP messages to CAN
> frames. This will not work with raw CAN, as the messages are too long.
> Maybe CAN-FD or ISO-TP can help. But I haven't looked into this.

This is already a solved problem. I suggest having a look at the
existing standards.

My top recommendation would be AUTOSAR Classic Platform’s Time
Synchronization over CAN:
https://www.autosar.org/fileadmin/user_upload/standards/classic/21-11/AUTOSAR_SWS_TimeSyncOverCAN.pdf
(I haven't studied it so I am not yet able to explain).

Another candidate would be PTP over DeviceNET over CAN from Annex G of
IEEE 1588, c.f.
https://lore.kernel.org/all/20210112021420.GA18703@hoboy.vegasvil.org/
(I never used DeviceNET and never read IEEE 1588, I just recalled this
message from Richard)

> > > What does tcpdump show on a Ethernet if you enable TX timestamps?
> >
> > I never went so far.
> >
> > For tcpdump, the interested flags are:
> >   * -J (a.k.a. --list-time-stamp-types)
> >   * -j tstamp_type (a.k.a. --time-stamp-type=tstamp_type)
> >
> > But I never went so far to make them work. If you want to try it,
> > first be sure that the driver of your network interface calls
> > skb_tx_timestamp() in its xmit() function.
>
> I think some interfaces on our compile cluster support PTP.
>
> > > > I also guess there is no official support but then,
> > > > I am wondering how hard it would be to hack the error queues to expose
> > > > them to the privileged processes.
> > >
> > > Maybe there's general interest of pushing error queue data via packet
> > > socket, too. As this is not a CAN specific issue.
> >
> > I think so. This is just a niche topic, so we need to find the code
> > snippet which will put some light on this. I am convinced that some
> > solution should exist, just do not have enough time to investigate.
> > Studying the source code of tcpdump is probably one of the best idea I
> > can think of right now.
>
> sound like the right direction

Another interesting tools for network interface timestamps is:
        ethtool -T

But I guess you already started to use it in mcp251xfd because you
will need it to advertise the PTP hardware clock.


Yours sincerely,
Vincent Mailhol
