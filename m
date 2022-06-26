Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9656855B24B
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiFZNk1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Sun, 26 Jun 2022 09:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiFZNk0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 09:40:26 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BB6DFFE
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 06:40:25 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3176d94c236so63562067b3.3
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 06:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=10dW+HrxPtxad6H6PFb9u872CvBLCDGNVWkAK05+UNs=;
        b=TVep0ApWKuEIyr3S68eb5DtJuNxFk9/jWnd/IJ3ci4EqvPn8wGWTz3Z7ebtETO2+b+
         BhFQGrJLm400XTOxG9YqTEUe3Fhee4Xa3qFO2qU3vYih6IeNc/Jm4V7qUN4IabNEZOz9
         nVv27ivYzm1xzigVRopshCd2hP11xs+u8iFhtGp8bMplyAUjtzzD07gDBS92IBLuJA0z
         05Pn9tvUiiqWIcBafSPBC8auX3tBILEzNUBZfdhwn7/RNtQrnBVoOu44+9nOm41SNFzg
         ILEKj8zRSd0lpg8XqL2k1E17Wq+yu9aFO2l61gg9X3pBwEQE0O4Oxasrgr0e0z3nbRxG
         slmw==
X-Gm-Message-State: AJIora8uBHNfwpAdkLVpUenA1hstxPNs1BcLXir8YRlXWGYhHvByLBEF
        Xx8s87MTYiVIWAyme7VXiGJw+LGQvgdYBiFpXWY=
X-Google-Smtp-Source: AGRyM1vKgeowbKwK1sWULXJvUqtje+2EINadNCIAka/cWSk7sE46WBS+hlAJbXNs8RM0jjHYu8fY3JEp1fj6pJ+MIEc=
X-Received: by 2002:a0d:f285:0:b0:31b:c2d6:2ce9 with SMTP id
 b127-20020a0df285000000b0031bc2d62ce9mr383056ywf.172.1656250824754; Sun, 26
 Jun 2022 06:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr>
 <20220626090744.pycu3katdt6vir2l@pengutronix.de> <CAMZ6RqLVKMznm_n4j079rcYLjhj8QjmeM3=bYUeXm_rozmQNVg@mail.gmail.com>
 <20220626105525.va44sseksk3xej7j@pengutronix.de>
In-Reply-To: <20220626105525.va44sseksk3xej7j@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 26 Jun 2022 22:40:13 +0900
Message-ID: <CAMZ6Rq+NbmOA89DjA=e_EBJXaDm0T69vbFrjKD+arZivhVqEdA@mail.gmail.com>
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

On Sun. 26 Jun 2022 at 19:58, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 26.06.2022 18:54:05, Vincent MAILHOL wrote:
> > On Sun. 26 juin 2022 à 18:10, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > > On 26.06.2022 16:53:17, Vincent Mailhol wrote:
> > > > This is a simple tool I wrote in the past. It will report the time
> > > > need for a packet to travel from:
> > > >   * application TX path to kernel TX path
> > > >   * kernel TX path to kernel RX path (i.e. kernel round trip)
> > > >   * kernel RX path to application RX path
> > > >   * application TX path to application RX path (i.e application round
> > > >     trip)
> > >
> > > I'm currently playing around with hardware timestmaps in the mcp251xfd
> > > driver and the other day I stumbled over commit 741b91f1b0ea ("can: dev:
> > > can_put_echo_skb(): add software tx timestamps") and I was thinking
> > > which tool you're using to test this. :)
> > >
> > > Once the hardware timestamps are running stable, this is exactly the
> > > tool I need! Thanks for sharing this.
> >
> > Does the mcp251xfd use the host clock to do its hardware timestamp?
>
> It uses an external 40 MHz oscillator, usually each device has it's own.
>
> > (Not sure how SPI hardware works and if they have their own quartz or
> > if they share it with the host system). If it is indeed the same clock
> > you can have even more precise statistics.
>
> No, the device clock is not shared with the host system and thus drift
> apart. But you can synchronize the device's clock against the system
> clock with phc2sys of linuxptp. As soon as the code is stable I'll send
> the patches around.

This sounds really exciting. I also wanted to play with linuxptp but
never had time to start.

With the device clock synchronized, you can have decent timestamping
between different hardware (potentially of different brands).
The drawback is that you would lose a bit of precision: the hardware
timestamp have an accuracy around 1 microsecond. After using PTP, I
would expect the precision to degrade to roughly 100 microsecond
(which is still way better than what software timestamping can offer).

> > > > My ultimate goal was to add the TX timestamp feature to candump from
> > > > can-utils [3], however, I faced a blocker: the TX timestamps are sent
> > > > to the error queue of the sender's socket meaning that a listener
> > > > (such as candump) will not see those TX timestamp on his error queue
> > > > because this is a different socket as the sender. If anyone knows a
> > > > method to access the error queue of another process's socket, let me
> > > > know (I guess that you need to be root, but did not find how to do
> > > > it).
> > >
> > > I don't think there's an official way to read the TX timestamps (i.e.
> > > error queue) of a socket that's outside of your process.
> >
> > What I was thinking is that tools such as tcpdump are able to get TX
>
> Oh, I completely forgot the packet socket and tcpdump....
>
> > packets of ethernet interfaces even if not normally visible (because
> > contrary to CAN, there is no default loopback). I was wondering if the
> > same could be done with error queues, but as you can guess my research
> > did lead anywhere.
>
> What does tcpdump show on a Ethernet if you enable TX timestamps?

I never went so far.

For tcpdump, the interested flags are:
  * -J (a.k.a. --list-time-stamp-types)
  * -j tstamp_type (a.k.a. --time-stamp-type=tstamp_type)

But I never went so far to make them work. If you want to try it,
first be sure that the driver of your network interface calls
skb_tx_timestamp() in its xmit() function.

> > I also guess there is no official support but then,
> > I am wondering how hard it would be to hack the error queues to expose
> > them to the privileged processes.
>
> Maybe there's general interest of pushing error queue data via packet
> socket, too. As this is not a CAN specific issue.

I think so. This is just a niche topic, so we need to find the code
snippet which will put some light on this. I am convinced that some
solution should exist, just do not have enough time to investigate.
Studying the source code of tcpdump is probably one of the best idea I
can think of right now.


Yours sincerely,
Vincent Mailhol
