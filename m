Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC005BD951
	for <lists+linux-can@lfdr.de>; Tue, 20 Sep 2022 03:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiITBXs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Sep 2022 21:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiITBXr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Sep 2022 21:23:47 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D64F3B9
        for <linux-can@vger.kernel.org>; Mon, 19 Sep 2022 18:23:46 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3450990b0aeso9818017b3.12
        for <linux-can@vger.kernel.org>; Mon, 19 Sep 2022 18:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1HAw0InI71XoFyys6ogjktEoVgcOMt7AtUPe8FLjUdk=;
        b=de0LHRyVpjsiDag/yDdcyqXaA1dLWID3sQ5pl/CAeFroQtJXD5eHEy2pVbrU2N7lsV
         p/Qc5GGb2z2XgD+r7ep07Ga7z+5MSHhU8tDsZN2dafuk79X7y2SLuciV2BbwqG7M3Vme
         wWGf1Z+x3A/K7duoaDXuE39VhenhpPQoRTH62bZeZ+pDUlHvoV+bsBvoDIeHInUm77m9
         4+ciNhOf4cPFTxFF7+l/OkJBEqNkyF2DFF34JRMP56Nvn5kbcNp6742V5Y5zWy642ZFV
         Z+DA4woIKi3FpKyEd5K/g5D3Mrn9zqL1E0lemfGgfLxP4msj0ug3dTJOVGGxevTsSU8I
         p7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1HAw0InI71XoFyys6ogjktEoVgcOMt7AtUPe8FLjUdk=;
        b=Jr2j08GPIW0o7sFpx+dnTNOofMv06E+AYLQp/ydqnWH9/roeg48i47L1ISSMhWO0YA
         Ly5xjRBZDdpKqte2xCBXuw3B+FN+/pCtqJY/pAgZO5UujB9zfFFjiFdnFceqbIDwyWLO
         GSQb+1gmCgRg1Fj8/92EgB3H8M+MX/+kRtPyyV8GcALLXCt/XbqVSj+o61ddQotW5Q9w
         snHTe4Crz4Z82FfOc9ShI/gAF7kRy40qWm7eYg3Odz1z14tE/mM8R2JrGFY8wbCi1v+X
         UhpPu4z8WmYGRfWVpCUV9pibiPc4MS2GU+jPvFVIY7l7Ky6yh53fpQjqAVkbiPctlneq
         i9Kg==
X-Gm-Message-State: ACrzQf1yrAaDYoerP48+Av0reQx4m+1qlC/jS8FUkyk+AqPulYOiJkx1
        nn5KpLuVB0zK4YfO6JlLgNaFQQJe/wGUoT2Ww+s=
X-Google-Smtp-Source: AMsMyM6mbKMXragh/zEQFKArsNvAXxsYRoaIQiuzBLO9Ut1ROgxOFfx2vNfvDvPw4SXaapt1ZQfzEcYvPoCTi4iDmMM=
X-Received: by 2002:a81:63c4:0:b0:349:543f:99f3 with SMTP id
 x187-20020a8163c4000000b00349543f99f3mr17382786ywb.392.1663637025137; Mon, 19
 Sep 2022 18:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com> <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com> <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com> <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com> <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
 <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com> <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
In-Reply-To: <02aeeca7-5958-60f1-3011-fa3aae4ef6b5@gmail.com>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Tue, 20 Sep 2022 10:23:33 +0900
Message-ID: <CAMZ6RqJPo4t_J+OTqVSX_1-+81-j6LAF-NNxwBNeSAyqHGFBsg@mail.gmail.com>
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
To:     Jacob Kroon <jacob.kroon@gmail.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, dariobin@libero.it,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue. 20 Sep. 2022 at 08:43, Jacob Kroon <jacob.kroon@gmail.com> wrote:
> Hi Marc and Dario,
>
> On 9/16/22 06:14, Jacob Kroon wrote:
> ...> What I do know is that if I revert commit:
> >
> > "can: c_can: cache frames to operate as a true FIFO"
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=387da6bc7a826cc6d532b1c0002b7c7513238d5f
> >
> > then everything looks good. I don't get any BUG messages, and the host
> > has been running overnight without problems, so it seems to have fixed
> > the network interface lockup as well.
>
> I ran the kernel *with* the commit above, and also with the following patch:
>
> > diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
> > index 52671d1ea17d..4375dc70e21f 100644
> > --- a/drivers/net/can/c_can/c_can_main.c
> > +++ b/drivers/net/can/c_can/c_can_main.c
> > @@ -1,3 +1,4 @@
> > +#define DEBUG
> >  /*
> >   * CAN bus driver for Bosch C_CAN controller
> >   *
> > @@ -469,8 +470,15 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
> >       if (c_can_get_tx_free(tx_ring) == 0)
> >               netif_stop_queue(dev);
> >
> > -     if (idx < c_can_get_tx_tail(tx_ring))
> > +     netdev_dbg(dev, "JAKR:%d:%d:%d:%d\n", idx,
> > +                                           c_can_get_tx_head(tx_ring),
> > +                                           c_can_get_tx_tail(tx_ring),
> > +                                           c_can_get_tx_free(tx_ring));
> > +
> > +     if (idx < c_can_get_tx_tail(tx_ring)) {
> >               cmd &= ~IF_COMM_TXRQST; /* Cache the message */
> > +             netdev_dbg(dev, "JAKR:Caching messages\n");
> > +     }
> >
> >       /* Store the message in the interface so we can call
> >        * can_put_echo_skb(). We must do this before we enable
>
> and I've uploaded the entire log I could capture from /dev/kmsg, right
> up to the hang, here:
>
> https://pastebin.com/6hvAcPc9
>
> What looks odd to me right from the start is that sometimes when idx
> rolls over to 0, and *only* when it rolls over to 0, the CAN frame gets
> cached because "idx < c_can_get_tx_tail(tx_ring)".

This looks like a classic integer wraparound issue. A cast to s32
should do the trick:
  (s32)idx - c_can_get_tx_tail(tx_ring) < 0

This is not tested. I let you double check. You can refer to this
function for an example:
https://elixir.bootlin.com/linux/v5.19/source/drivers/net/can/usb/etas_es58x/es58x_core.c#L336

Yours sincerely,
Vincent Mailhol
