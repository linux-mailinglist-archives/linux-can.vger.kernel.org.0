Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BBE575A16
	for <lists+linux-can@lfdr.de>; Fri, 15 Jul 2022 05:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiGODxG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jul 2022 23:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGODxC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jul 2022 23:53:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75466774BB
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 20:53:01 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 6so6550604ybc.8
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 20:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jiXJvv2Fw4sLi+dAQMA12CdTPz8+4xLwTSiK/N4iQGg=;
        b=MbxRAiMWXvkTUesKY8n5FnVY9pm7lTgPBlhXefZ0VSjb/qXU1Ms2ht1OfRugpfI5yC
         8MbCrVp/6YMegryP0T1pZaeXWohVU+Q38Erly+BAuZu9me5SWhOnxDW+SSQuvXTdliCe
         57vUeaCIIOyyTXo8+ld4udyCSIGELcgkaFyoOV6QqkLNzpwWsWGKLsDf4QjFXJonKuTh
         gifaGzJBESjfL3xB5dd1h/e+FIFekHOpzjUk5HVAQNtgrsR0jRxRPIRRucSkChbyHhiY
         HRQPyLs+9fKO03NlkRfvytH2XflKyC3XBfiGM5Tm89dKtNH/5+gMEe5Eg1+ZZJfgtMYv
         /MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jiXJvv2Fw4sLi+dAQMA12CdTPz8+4xLwTSiK/N4iQGg=;
        b=Ob56YPmN1SxYSXOdBafzOm+euSnArB8m844CF7o9IqTMZaPZsH27FWmaiSRJc//LUa
         fyLXH/JB6imk9g02eApjDv4pt2Jx2J6lKFFXrM9Awz9A/++NYgWGxwZ6ofawpxzTGH0l
         amcqxYoWIDFMnZT9Z2+yzASaZoFMI/SZ1tlNM8A6Eio+sYrubPvBXq37PC4E8htgDYVl
         qc1XpCS2VHWKHDeyX3MR2WcmiDdv++eyn0vjEL5SdsD6zhNQ58VKWE0W4+XK/5mAGsAb
         qRauKCr7RKk3t96XNc1qOspMT//VNJIG43H3kbPTdn/oTFUnCrXfgMToir/yXYvV4ijq
         6SXQ==
X-Gm-Message-State: AJIora84SZZFnj2ehMuI7CdGFoCWMdtf242NsO0uBHmXRbjCxmQPiueM
        oRZ/Q9ntecgcYDVehD9dHeIZupyeCLtHSuSNAySLbB6PsJs=
X-Google-Smtp-Source: AGRyM1uC4FLrqY+kPjjhRX/NQeYcHHNB1T7uwCqswDf6dGx85PbpjgGC6h7fyMuw7H2qlcHixq3Ag6/fZ/WqAD8Flbs=
X-Received: by 2002:a25:328a:0:b0:66f:ef34:bf5c with SMTP id
 y132-20020a25328a000000b0066fef34bf5cmr728220yby.630.1657857180581; Thu, 14
 Jul 2022 20:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220714160541.2071-1-socketcan@hartkopp.net> <20220714160541.2071-4-socketcan@hartkopp.net>
 <20220714200601.mklari3b6uvb7b2e@pengutronix.de> <c731143e-f476-b2f8-c08c-df66339d98f8@hartkopp.net>
In-Reply-To: <c731143e-f476-b2f8-c08c-df66339d98f8@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 15 Jul 2022 12:53:14 +0900
Message-ID: <CAMZ6RqJ0=PhrJUHaZR6QNWkv2vx690AiwPF2RLv1ou_JGX1qxg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] can: dev: add CAN XL support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri. 15 Jul. 2022 at 06:14, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 14.07.22 22:06, Marc Kleine-Budde wrote:
> > On 14.07.2022 18:05:39, Oliver Hartkopp wrote:
>
> (..)
>
> >> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
> >> +                            struct canxl_frame **cfx,
> >> +                            unsigned int datalen)
> >> +{
> >> +    struct sk_buff *skb;
> >> +
> >> +    if (datalen < CANXL_MIN_DLEN || datalen > CANXL_MAX_DLEN)
> >> +            goto out_error;
> >> +
> >> +    skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> >> +                           CANXL_HEAD_SZ + datalen);

If usings the flexible array member, this would become:

        skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
                               sizeof(struct canxl_frame) + datalen);

or even:

        skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
                               struct_size(*cxl, data, datalen));

This is an illustration of my point that flexible data arrays are more
idiomatic. I find it weird to have to mix sizeof(struct can_skb_priv)
and CANXL_HEAD_SZ in the same expression...

> >> +    if (unlikely(!skb))
> >> +            goto out_error;
> >> +
> >> +    skb->protocol = htons(ETH_P_CANXL);
> >> +    skb->pkt_type = PACKET_BROADCAST;
> >> +    skb->ip_summed = CHECKSUM_UNNECESSARY;
> >> +
> >> +    skb_reset_mac_header(skb);
> >> +    skb_reset_network_header(skb);
> >> +    skb_reset_transport_header(skb);
> >> +
> >> +    can_skb_reserve(skb);
> >> +    can_skb_prv(skb)->ifindex = dev->ifindex;
> >> +    can_skb_prv(skb)->skbcnt = 0;
> >> +
> >> +    *cfx = skb_put_zero(skb, CANXL_HEAD_SZ + datalen);
> >
> > Should the CANXL_XLF be set here?
>
> Yes, we can set that bit here directly - for convenience reasons ;-)
>
> > I have a bad feeling if we have a struct canxl_frame with a fixed size,
> > but it might not completely be backed by data.....

I tried to think hard of what could go wrong with the
data[CANXL_MAX_DLEN] declaration.

The worst I could think of would be some:
        int datalen = 64; /* or anything less than CANXL_MAX_DLEN */
        struct canxl_frame *cxl1 = malloc(CANXL_HEAD_SZ + datalen);
        struct canxl_frame *cxl2 = malloc(CANXL_HEAD_SZ + datalen);

        memcpy(cxl1, cxl2, sizeof(*cxl1));

But that example is a bit convoluted. That's why I wrote in my
previous message that I saw no killer arguments against it.

> > For example, I've updated the gs_usb driver to work with flexible arrays
> > to accommodate the different USB frame length:
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs_usb.c#L216
> >
> > Maybe we should talk to Kees Cook what's best to use here.
>
> I see this struct canxl_frame with 2048 byte of data more as a user
> space thing.
>
> You can simply read() from the CAN_RAW socket into this struct (as you
> know it from CAN/CANFD) and it works safely.
>
> That we optimize the length to the really needed length inside the skb
> and for CAN XL socket read/write operations is on another page for me.
>
> If we *only* had the canxl data structure inside the kernel I would be
> definitely ok with flexible arrays.
> The current implementation indeed never allocates space with the
> sizeof(struct canxl_frame) ...
>
> But I tend to maintain the pattern we introduced for CAN and CAN FD for
> the user space visible data structures. That is clearer and safe to use
> by default instead of reading documentation about flexible arrays and
> how to build some data structure on your own.

Here, you are making the assumption that the end user will only be
familiar with the CAN(-FD) and not with other concepts.

Building data structures on your own is fairly common, the best
example being the struct iphdr or the struct tcphdr for TCP/IP:
  * https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ip.h#L86
  * https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/tcp.h#L25
(in those examples, it is not a flexible array member but the concept
is basically the same).

I think it is fair to expect from a developer using Berkeley sockets
(what SocketCAN is) to be familiar with this.

In the worst case, the developper who still completely ignore the
documentation and just do sed "s/canfd/canxl/g" on their existing code
base will eventually do this:
        write(sock, &cxl, sizeof(canxl));
And that would fail immediately (because sizeof(canxl) <
CANXL_MIN_TU). So I think it is still safe. The real foot gun is when
you can write incorrect code that still works (e.g. buffer overflow).
If it directly fails, people will copy/paste the accepted answer on
stackoverflow and will eventually do the correct:
        write(sock, &cxl, sizeof(cxl) + cxl.len);

Finally, for both solutions, user can not do this anymore:
        assert(read(sock, &cxl, sizeof(cxl)) == sizeof(cxl));
But instead should do:
        assert(read(sock, &cxl, sizeof(cxl)) >= CANXL_MINTU);
So regardless of the solution we use, the developer needs to be aware
to some extent of the variable size (and ignoring the return value of
read() is a bad practice so I won't accept this as a counterargument).

The debate is really on "reusing CAN(-FD) patterns" vs. "doing
idiomatic C". I will not veto the data[CANXL_MAX_DLEN], but I vote for
the flexible array member for the reasons listed here.

Yours sincerely,
Vincent Mailhol
