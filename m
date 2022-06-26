Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BEB55B0F1
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiFZJyT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Sun, 26 Jun 2022 05:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiFZJyS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 05:54:18 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0375E0D0
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 02:54:16 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3178acf2a92so60768927b3.6
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 02:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ka88LzsS0sKNReTMMaT2hj5yoY10XgvQzOxM0gIK/Wo=;
        b=xTw+J7VWL49dSLuvTdorVioCRDvUu9KPOBkniyzuspEe21o1h7Xj1/2L5BM5m8lZ/s
         6x57plj9YUabouW/pD2n35dQWpPVTBw8CtHvbV9s6aDjniiRtPRxzljaKiDahGVdGcaj
         rqCQ4gfZnriYdIr7eOGCCGh7S2bwppeD3B6UwjjxedQ3VC7UQUOwI/HK1l8XtUKkWMaK
         lgLY2ii/fNW98MgzL4UpqgeB6J/tBr5wlqxKHw9kQx/+46u8S0eOtb1QuHLPSAiP5V5P
         JLB5GZl1W0xeqnVnH4FAzCQKVXntsn5Dp13RZ8ghPBUdjDd2lSS3mqG9VOyRqzczaXwX
         D36A==
X-Gm-Message-State: AJIora8HLyxmfmDBCzVopJh+lais2StG416odICrkzGdyyWkIi5k6hst
        YUUru+uJmxI9V3No5zvqVsdXSbbNkh0rKXI6sT4=
X-Google-Smtp-Source: AGRyM1uPxmdlTKPV0UrQu8DvSxpBqRalHrNhB8fbfMO8NowtwdaOhOYyVQtpXmG1njTYCXOBJueW7tPj/FPD47WReAc=
X-Received: by 2002:a0d:dfd5:0:b0:317:f0d4:505b with SMTP id
 i204-20020a0ddfd5000000b00317f0d4505bmr8441229ywe.518.1656237256164; Sun, 26
 Jun 2022 02:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr> <20220626090744.pycu3katdt6vir2l@pengutronix.de>
In-Reply-To: <20220626090744.pycu3katdt6vir2l@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 26 Jun 2022 18:54:05 +0900
Message-ID: <CAMZ6RqLVKMznm_n4j079rcYLjhj8QjmeM3=bYUeXm_rozmQNVg@mail.gmail.com>
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

On Sun. 26 juin 2022 à 18:10, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 26.06.2022 16:53:17, Vincent Mailhol wrote:
> > This is a simple tool I wrote in the past. It will report the time
> > need for a packet to travel from:
> >   * application TX path to kernel TX path
> >   * kernel TX path to kernel RX path (i.e. kernel round trip)
> >   * kernel RX path to application RX path
> >   * application TX path to application RX path (i.e application round
> >     trip)
>
> I'm currently playing around with hardware timestmaps in the mcp251xfd
> driver and the other day I stumbled over commit 741b91f1b0ea ("can: dev:
> can_put_echo_skb(): add software tx timestamps") and I was thinking
> which tool you're using to test this. :)
>
> Once the hardware timestamps are running stable, this is exactly the
> tool I need! Thanks for sharing this.

Does the mcp251xfd use the host clock to do its hardware timestamp?
(Not sure how SPI hardware works and if they have their own quartz or
if they share it with the host system). If it is indeed the same clock
you can have even more precise statistics.

> > This tool is useful to benchmark latency on software and hardware. It
> > can be used to, for example:
> >   * compare performances of two CAN controllers (by using the kernel
> >     round trip information)
> >   * compare the different CAN queue disciplines (by using the
> >     application TX path to kernel TX path information)
> >
> > I am sharing it as-is. Please see this message as an FYI. I do not
> > consider this mature enough and I am not expecting anyone to pick that
> > patch. Everything is hard coded, I did not put effort to make it
> > configurable.
> >
> > The tool requires the TX timestamps (which I previously added to the
> > kernel in [1] and [2]).
> >
> > To use it:
> > | $make
> > | ./can-roundtrip-stats
> >
> > My ultimate goal was to add the TX timestamp feature to candump from
> > can-utils [3], however, I faced a blocker: the TX timestamps are sent
> > to the error queue of the sender's socket meaning that a listener
> > (such as candump) will not see those TX timestamp on his error queue
> > because this is a different socket as the sender. If anyone knows a
> > method to access the error queue of another process's socket, let me
> > know (I guess that you need to be root, but did not find how to do
> > it).
>
> I don't think there's an official way to read the TX timestamps (i.e.
> error queue) of a socket that's outside of your process.

What I was thinking is that tools such as tcpdump are able to get TX
packets of ethernet interfaces even if not normally visible (because
contrary to CAN, there is no default loopback). I was wondering if the
same could be done with error queues, but as you can guess my research
did lead anywhere. I also guess there is no official support but then,
I am wondering how hard it would be to hack the error queues to expose
them to the privileged processes.

> > Because I did not manage to add the feature to candump, I am sharing
> > instead this standalone tool, hoping someone might find it useful.
>
> I'm not sure which is the best tool to add this to...cangen,
> cansequence. Maybe evolve these tools into some kind of CAN ping
> command.
>
> > At the moment, I am not planning to invest more time in the
> > foreseeable future. If someone want to take over and make is a bit
> > more sexy so that it can reach can-utils, go ahead. I think that it
> > basically misses a command line interface in the same fashion of
> > cangen to make is configurable.
>
> I've added it to a branch of my can-utils:
>
> https://github.com/marckleinebudde/can-utils/tree/can-roundtrip-stats

Thanks!
I also see you did a quick cleanup.


Yours sincerely,
Vincent Mailhol
