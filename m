Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5C955B251
	for <lists+linux-can@lfdr.de>; Sun, 26 Jun 2022 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiFZNYF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 26 Jun 2022 09:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbiFZNYE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Jun 2022 09:24:04 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF153B84
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 06:24:03 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id i15so12507921ybp.1
        for <linux-can@vger.kernel.org>; Sun, 26 Jun 2022 06:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heBBb/PuRqrLxxpBN7RYtSYE8E/RBT+A4qjB2sHqE68=;
        b=fqXRTmC5ZrRfAcYfr2e9Z9JLVMmWUXQgVN2yE0B5H5Lrwz319vuTH7OcvqUmENIJbL
         SbNA0O3JVKkI3HPUXmJoFmhDzfujAxZqqVqipzUFg63klQs/gfjRUtWA0/VgEBgi2HWB
         +DoMuhj9xzmfeFBElXdo4uJ3RzfiMCOw+ukvU8zFvJ4UvZyP35uNVGzXKt+t5YUjck39
         iqyMpDLfzikVCQoC0t3kIPNVjvybnFyX0dIyfthILtQytv4hOFJ9nqAXNsg3y+U6rsdC
         8mgnmu7OkIO905sjWqnQMzEoSOR0EVL276NlC+JbntEnrIi4uNuD7h8Gspwo/AezpLOR
         I56Q==
X-Gm-Message-State: AJIora8AEsYzt6R7wYmfkoa0i8EOs+tBoEr512O46K+KKQJBcze95g98
        I1ey6d9U6xKul9Y3yMrfGga0JB8ya6OJZ3smVbo=
X-Google-Smtp-Source: AGRyM1sarKAG0y1R1tkc73lxKUgCjvSe5PLAWB9XPJ0byEfFm/ff3SjXGXbZwY1YNYf9u1OYouX3WItl68imEIJUQi0=
X-Received: by 2002:a25:3145:0:b0:64e:ac9a:eb27 with SMTP id
 x66-20020a253145000000b0064eac9aeb27mr8488417ybx.630.1656249843003; Sun, 26
 Jun 2022 06:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220626075317.746535-1-mailhol.vincent@wanadoo.fr>
 <20220626090744.pycu3katdt6vir2l@pengutronix.de> <CAMZ6RqLVKMznm_n4j079rcYLjhj8QjmeM3=bYUeXm_rozmQNVg@mail.gmail.com>
 <7640a651-80c8-cfe8-c6bd-0b0d60ee3c2a@hartkopp.net> <20220626105749.hlnvv57yfwbjrto6@pengutronix.de>
In-Reply-To: <20220626105749.hlnvv57yfwbjrto6@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 26 Jun 2022 22:23:51 +0900
Message-ID: <CAMZ6RqJuwhst8Siq_nUZwqge=nWSAYpyADCen1y8f6JnpbbudQ@mail.gmail.com>
Subject: Re: [RFC PATCH] can-roundtrip-stats: a tool to benchmark transmission time
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org,
        Rhett Aultman <rhett.aultman@samsara.com>
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

On Sun. 26 Jun 2022 at 19:57, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 26.06.2022 12:31:59, Oliver Hartkopp wrote:
> > > What I was thinking is that tools such as tcpdump are able to get TX
> > > packets of ethernet interfaces even if not normally visible (because
> > > contrary to CAN, there is no default loopback). I was wondering if the
> > > same could be done with error queues, but as you can guess my research
> > > did lead anywhere. I also guess there is no official support but then,
> > > I am wondering how hard it would be to hack the error queues to expose
> > > them to the privileged processes.
> >
> > I wonder whether error queues are the right mechanism or if control messages
> > needed to be extended here - like for (hardware) rx timestamps.
>
> I think error queues are the official way for TX timestamps. Nonetheless
> tcpdump support for TX timestamps would be interesting.

Yes, the error queues are the only official method. If we were to do
it in a non standard way, the easiest would be to put it in the second
entry of struct scm_timestamping which used to hold
SOF_TIMESTAMPING_SYS_HARDWARE but which is now deprecated. c.f.
https://docs.kernel.org/networking/timestamping.html#timestamp-reporting

Yours sincerely,
Vincent Mailhol
