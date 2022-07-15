Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD14575DE2
	for <lists+linux-can@lfdr.de>; Fri, 15 Jul 2022 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiGOIsR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jul 2022 04:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiGOIsP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jul 2022 04:48:15 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FDE820EE
        for <linux-can@vger.kernel.org>; Fri, 15 Jul 2022 01:48:02 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31c9b70c382so40901657b3.6
        for <linux-can@vger.kernel.org>; Fri, 15 Jul 2022 01:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlpiCsiJACAzGJIoXJLyZAQ/QfGwql3kZ9OFjybuRPs=;
        b=B60QkgWi6HWnMcb+AoPxv5JjbDtf3P8dquBdqgxPN+SbJHytK1zO3aQo68yHXz68L3
         qwRFXltFIU2DnUvPhm/nS7ixOdg/nDfIGYORb+deWEZeCsS+rLP0HZmrQ6YcUg7xvw4U
         qw3eO3Q5+/WxFk18ywz+n5EqqxXbhf+oBPpD+YtKbGHYcrgbGW7KucNbQOOLDfl8sloD
         MRwMF0s+fLAc3KjytAUR1YS/rR8kOYtkvBOCAkC4KygLtLNz4knekTcPX8kX/AVFqDrb
         x0oI3AnDLIPh9EF58u6JfUWjzzdGkGWrH3aVr081P5FQh5mRQEwED85sNRkGk7ozxb18
         cRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlpiCsiJACAzGJIoXJLyZAQ/QfGwql3kZ9OFjybuRPs=;
        b=Lu3PDdN8Oiu/IrYqyJc+GiGcnLdKi7XdHH+y/o4KVapYya312593zfc0RkvdLQCGDa
         sKZDsHHaoQwWWHVEtWvK7zdcDNprmltoHKG5Th1MHIBRdjVxNRGvFoRiOI75xrYSmlRl
         ptI/oCpvSGNka6M+VTAi/AcCRQ+g62Zwce0RNpsOnre0POvUYHV0ivc0M7SIiY3kcblu
         aMhX4zkmR9vS5D5+JVHIHfje3yE/e2bJzE0h+Vy+1GOrC1rjFyTjiE4SE/TpndLRMj6n
         KIcEIS+NtH0Lq6s9tV9i7fLPh++k0oJkWvxXdgWWdRfFyRJ/DiVdLU1fFSF16RmhJfoM
         3NCg==
X-Gm-Message-State: AJIora+8vtWFceAPKAd/UhYZQ/DIaGclA95+LwI7rixLVh/i1TiVftjr
        PLiJhh8L55DZz/WHbLRNE8kgKaxirY10LSyHMEWZA5eagvg=
X-Google-Smtp-Source: AGRyM1s3fJL2mi0UUua4TP0e0u40InqRweOvIYH5f7r8e8uQxSXnOZA/CO5qDnzLmmSBnQVkQUQ7rEJ+4/qlGVaNRNs=
X-Received: by 2002:a0d:f703:0:b0:31d:6e5b:20c with SMTP id
 h3-20020a0df703000000b0031d6e5b020cmr14632760ywf.78.1657874881003; Fri, 15
 Jul 2022 01:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220714160541.2071-1-socketcan@hartkopp.net> <20220714160541.2071-4-socketcan@hartkopp.net>
 <20220714200601.mklari3b6uvb7b2e@pengutronix.de> <c731143e-f476-b2f8-c08c-df66339d98f8@hartkopp.net>
 <CAMZ6RqJ0=PhrJUHaZR6QNWkv2vx690AiwPF2RLv1ou_JGX1qxg@mail.gmail.com> <20220715073728.csp4hgbrgr2q62zu@pengutronix.de>
In-Reply-To: <20220715073728.csp4hgbrgr2q62zu@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 15 Jul 2022 17:47:50 +0900
Message-ID: <CAMZ6RqLxPHc3fW3711ExZxtmWmp7b7O8QhqY34R=9A8v-v8s9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] can: dev: add CAN XL support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
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

On Fri. 15 Jul. 2022 at 16:37, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 15.07.2022 12:53:14, Vincent Mailhol wrote:
> > On Fri. 15 Jul. 2022 at 06:14, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> > > On 14.07.22 22:06, Marc Kleine-Budde wrote:
> > > > On 14.07.2022 18:05:39, Oliver Hartkopp wrote:
> > >
> > > (..)
> > >
> > > >> +struct sk_buff *alloc_canxl_skb(struct net_device *dev,
> > > >> +                            struct canxl_frame **cfx,
> > > >> +                            unsigned int datalen)
> > > >> +{
> > > >> +    struct sk_buff *skb;
> > > >> +
> > > >> +    if (datalen < CANXL_MIN_DLEN || datalen > CANXL_MAX_DLEN)
> > > >> +            goto out_error;
> > > >> +
> > > >> +    skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> > > >> +                           CANXL_HEAD_SZ + datalen);
> >
> > If usings the flexible array member, this would become:
> >
> >         skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> >                                sizeof(struct canxl_frame) + datalen);
> >
> > or even:
> >
> >         skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
> >                                struct_size(*cxl, data, datalen));
>
> ACK. I was thinking of the 2nd option with the struct_size().
>
> > This is an illustration of my point that flexible data arrays are more
> > idiomatic. I find it weird to have to mix sizeof(struct can_skb_priv)
> > and CANXL_HEAD_SZ in the same expression...
>
> > > >> +    if (unlikely(!skb))
> > > >> +            goto out_error;
> > > >> +
> > > >> +    skb->protocol = htons(ETH_P_CANXL);
> > > >> +    skb->pkt_type = PACKET_BROADCAST;
> > > >> +    skb->ip_summed = CHECKSUM_UNNECESSARY;
> > > >> +
> > > >> +    skb_reset_mac_header(skb);
> > > >> +    skb_reset_network_header(skb);
> > > >> +    skb_reset_transport_header(skb);
> > > >> +
> > > >> +    can_skb_reserve(skb);
> > > >> +    can_skb_prv(skb)->ifindex = dev->ifindex;
> > > >> +    can_skb_prv(skb)->skbcnt = 0;
> > > >> +
> > > >> +    *cfx = skb_put_zero(skb, CANXL_HEAD_SZ + datalen);
> > > >
> > > > Should the CANXL_XLF be set here?
> > >
> > > Yes, we can set that bit here directly - for convenience reasons ;-)
> > >
> > > > I have a bad feeling if we have a struct canxl_frame with a fixed size,
> > > > but it might not completely be backed by data.....
> >
> > I tried to think hard of what could go wrong with the
> > data[CANXL_MAX_DLEN] declaration.
> >
> > The worst I could think of would be some:
> >         int datalen = 64; /* or anything less than CANXL_MAX_DLEN */
> >         struct canxl_frame *cxl1 = malloc(CANXL_HEAD_SZ + datalen);
> >         struct canxl_frame *cxl2 = malloc(CANXL_HEAD_SZ + datalen);
> >
> >         memcpy(cxl1, cxl2, sizeof(*cxl1));
> >
> > But that example is a bit convoluted. That's why I wrote in my
> > previous message that I saw no killer arguments against it.
>
> It just feels wrong to have a pointer to a struct canxl_frame that's
> only backed half by memory.

I follow you on this feeling. But have no concrete bad examples of how
the data[CANXL_MAX_DLEN] could be misused.

> I haven't followed the flex array discussion
> in great detail, but it opens a whole class of errors if arbitrary
> kernel memory can be accessed with struct canxl_frame::data using
> seemingly valid array indices.

The point in the previous discussion is that the kernel should always
crop the returned frames. If implemented correctly, such memory leaks
should not occur.

> > > > For example, I've updated the gs_usb driver to work with flexible arrays
> > > > to accommodate the different USB frame length:
> > > >
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs_usb.c#L216
> > > >
> > > > Maybe we should talk to Kees Cook what's best to use here.
> > >
> > > I see this struct canxl_frame with 2048 byte of data more as a user
> > > space thing.
> > >
> > > You can simply read() from the CAN_RAW socket into this struct (as you
> > > know it from CAN/CANFD) and it works safely.
> > >
> > > That we optimize the length to the really needed length inside the skb
> > > and for CAN XL socket read/write operations is on another page for me.
> > >
> > > If we *only* had the canxl data structure inside the kernel I would be
> > > definitely ok with flexible arrays.
>
> We don't have to use the same data structure in user space and in the
> kernel.
>
> > > The current implementation indeed never allocates space with the
> > > sizeof(struct canxl_frame) ...
> > >
> > > But I tend to maintain the pattern we introduced for CAN and CAN FD for
> > > the user space visible data structures. That is clearer and safe to use
> > > by default instead of reading documentation about flexible arrays and
> > > how to build some data structure on your own.
> >
> > Here, you are making the assumption that the end user will only be
> > familiar with the CAN(-FD) and not with other concepts.
> >
> > Building data structures on your own is fairly common, the best
> > example being the struct iphdr or the struct tcphdr for TCP/IP:
> >   * https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ip.h#L86
> >   * https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/tcp.h#L25
> > (in those examples, it is not a flexible array member but the concept
> > is basically the same).
>
> struct_size() is not exported to user space, but I think this could be
> changed.

Good luck with that!

struct_size() as-is can not be exported as-is because it will break
existing programs which already have the same declaration. So we would
need to declare a __struct_size(). I would absolutely love to see this
exported but I would be surprised if such discussion did not already
occured in the past.

> > I think it is fair to expect from a developer using Berkeley sockets
> > (what SocketCAN is) to be familiar with this.
> >
> > In the worst case, the developper who still completely ignore the
> > documentation and just do sed "s/canfd/canxl/g" on their existing code
> > base will eventually do this:
> >         write(sock, &cxl, sizeof(canxl));
> > And that would fail immediately (because sizeof(canxl) <
> > CANXL_MIN_TU). So I think it is still safe. The real foot gun is when
> > you can write incorrect code that still works (e.g. buffer overflow).
> > If it directly fails, people will copy/paste the accepted answer on
> > stackoverflow and will eventually do the correct:
> >         write(sock, &cxl, sizeof(cxl) + cxl.len);
> >
> > Finally, for both solutions, user can not do this anymore:
> >         assert(read(sock, &cxl, sizeof(cxl)) == sizeof(cxl));
> > But instead should do:
> >         assert(read(sock, &cxl, sizeof(cxl)) >= CANXL_MINTU);
> > So regardless of the solution we use, the developer needs to be aware
> > to some extent of the variable size (and ignoring the return value of
> > read() is a bad practice so I won't accept this as a counterargument).
> >
> > The debate is really on "reusing CAN(-FD) patterns" vs. "doing
> > idiomatic C". I will not veto the data[CANXL_MAX_DLEN], but I vote for
> > the flexible array member for the reasons listed here.
>
> How are raw Ethernet frames handled in user space?

The first example of a "iphdr c example" in Google gives me:
https://github.com/joshlong/interesting-native-code-examples/blob/master/packet_sniffer.c#L133

(I am not saying this is the best example, but have a clear example of
buffer size manipulation).

Another example of flexible array member:
  * kernel definition:
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ethtool.h#L1163
  * userland code:
https://kernel.googlesource.com/pub/scm/network/ethtool/ethtool/+/refs/heads/ethtool-3.4.y/ethtool.c#2989

Yours sincerely,
Vincent Mailhol
