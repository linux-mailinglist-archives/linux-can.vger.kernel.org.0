Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670AB57D8F5
	for <lists+linux-can@lfdr.de>; Fri, 22 Jul 2022 05:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiGVDUc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jul 2022 23:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGVDUb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 23:20:31 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D6E1EEFA
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 20:20:30 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31e7055a61dso35468207b3.11
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 20:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPjhgWaeNWanc+DmRM6sNmlfsWzEpx5+8t2ToH2L5hA=;
        b=kBrb+sevCibiDR/n3r3rPSiQpMbKMbacfo0jHIPu3rjdgUo6bSghx975oXW3i+Bhw2
         EK/zNxWcixhwLLda4bQqeFreIzoDntqvAWVkhlgZjU1ZK08kx6u8V36VspFSy18HJIGE
         e3P2tA8B7fAVGzqGrpR3dS0gf+sk8mdnct4pQ+yXlwCET730kIINS1fm4GV8FwHX/G3p
         6k9p/ebqe7k0WRS1HNh5/UpVbOex1b1nk4qcm84/rr/u1/AiyKJ44AKN2md3NpyiiD8B
         R142RJu5lsy+qIEYzLf66LBigumE2QZRT483uKuS9wDUrpw1VRCdVzIBPP1LqINT2HMq
         cdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPjhgWaeNWanc+DmRM6sNmlfsWzEpx5+8t2ToH2L5hA=;
        b=tNc6zhPlXEuafwNS32Vmo+vgvia1h+KDWH/LgT9n6HOEiCT422mmnh8n6NVUWmNxMT
         Mb/cyNlpGhNEaKsrMharX/ZUVaCZC89MLcDoA4vSnSHzIknvgak3uVEbIjmPR1towEsG
         zoEV1xDZMk584hiFgdwjvOy/NiSrs6pm5kcpgdzVzjVpAr2N12QzmvrPpjhGoWRZ0qUF
         gawgDtV0NZp2FDXmObJhizMsQC81J6nvQRXVi4PHZZLaV14P59s8mTuzFb3t0/0Z4w9i
         naVRx8kI3bLRfzcCgbomyJD6PugzWEwoMUCQJDlLuSweLYcm2JlLGpJ1NjPMbve7eAFl
         Ywvg==
X-Gm-Message-State: AJIora/Vb0+BCiShhr8fzy2CHnnwF8UqgPl8hzxxGjjY0zKK7WotjV3h
        GAdyQfbtAPKZEYXiDUHM6D1bJ9/ZEC8nz6fauFv0EcLnhqsPlA==
X-Google-Smtp-Source: AGRyM1vO0jQKheLNtEmeXEJQwQf38tzZjmbisZddttvupuXId0QuI+L8glNJNlLGO0AfO6X+hfi7U4Uk5lACizye/DQ=
X-Received: by 2002:a81:1e94:0:b0:31e:8e3b:f05a with SMTP id
 e142-20020a811e94000000b0031e8e3bf05amr1460091ywe.172.1658460029719; Thu, 21
 Jul 2022 20:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220719112748.3281-1-socketcan@hartkopp.net> <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net> <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net> <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net> <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
 <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com> <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net>
In-Reply-To: <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 22 Jul 2022 12:20:43 +0900
Message-ID: <CAMZ6Rq+NWFc4KmhCCpJ2LzTt8ap1U_FLrQ1L1RQgYNT0BD3w_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
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

On Fri. 22 Jul. 2022 at 04:10, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 21.07.22 10:14, Vincent Mailhol wrote:
> > On Thu. 21 Jul. 2022 at 16:53, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> >> On 21.07.2022 09:36:21, Oliver Hartkopp wrote:
> >>> Btw. How should we finally name the 'non data' header of CAN XL?
> >>>
> >>> 1. CANXL_HEADER_SIZE
> >>> 2. CANXL_HEAD_SIZE
> >>> 3. CANXL_HDR_SIZE
> >>> 4. CANXL_HDR_SZ <- currently in the patches
> >>> 5. CANXL_HD_SZ
> >>>
> >>> I think it has to be 'head' and not 'header'.
> >>
> >> Header! Header is in front of data.
> >
> > I am also part of the header team! By analogy with:
> > https://en.wikipedia.org/wiki/IPv4#Header
> >
> >>> In skbs we also have head and tail.
> >>
> >> Yes, but they point at the head or tail of the buffer allocated with the
> >> skb.
> >>
> >>> So I would vote for 2 or 5 with a tendency to 5.
> >>
> >> 3, 1, 4
> >
> > My top vote goes to:
> > 6. No macro, instead use flexible array member and do sizeof(struct canxl_frame)
>
> This is no sizeof(struct canxl_frame) anymore with the use of a flexible
> array because a valid "CAN XL frame" has data (at least one byte and up
> to 2048 byte).
>
> You might name it
>
> struct canxl_header {
>          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>          __u8    flags; /* additional flags for CAN XL */
>          __u8    sdt;   /* SDU (service data unit) type */
>          __u16   len;   /* frame payload length in byte */
>          __u32   af;    /* acceptance field */
>          __u8    data[];
> };
>
> But then you can't build a struct canxl_frame anymore in the way that
> you can access the elements as you can do it today:
>
> struct canxl_frame {
>           struct canxl_header xldhr;
>           data[CANXL_MAX_DLEN];
> };
>
> struct canxl_frame cfx;
>
> => cfx.xlhdr.len
>
> Which is not cfx.len anymore what is a known pattern from struct
> can[fd]_frame from CAN application programmers and simple to use.
>
> The only new thing is the possibility to handle a truncated data[]
> section. That should be feasible to learn.

I do not buy your argument that you can not do sizeof(struct
canxl_frame) because of naming.

With a flexible array member, I can do:

struct canxl_frame {
         canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
         __u8    flags; /* additional flags for CAN XL */
         __u8    sdt;   /* SDU (service data unit) type */
         __u16   len;   /* frame payload length in byte */
         __u32   af;    /* acceptance field */
         __u8    data[];
};

void foo (int s)
{
         struct canxl_frame cxl_hdr = { 0 };
         struct canxl_frame *cxl1, *cxl2;
         size_t cxl2_data_len, cxl2_frame_len;

         /* read header */
         assert(read(s, &cxl_hdr, sizeof(cxl_hdr)) == sizeof(cxl_hdr));
         cxl1 = malloc(sizeof(*cxl1) + cxl_hdr.len);
         memcpy(cxl1, &cxl_hdr, sizeof(cxl_hdr));
         /* read remaining data */
         assert(read(s, cxl1->data, cxl1->len) == cxl1->len);

         cxl2_data_len = 512; /* arbitrary value for the example */
         cxl2_frame_len = sizeof(*cxl2) + cxl2_data_len;
         cxl2 = malloc(cxl2_frame_len);
         memset(cxl2, cxl2_frame_len, 0);
         cxl2->len = cxl2_data_len;
         cxl2->flags = CANXL_XLF;
         /* fill prio, data, ect... */
         assert(write(s, cxl2, cxl2_frame_len) == cxl2_frame_len);
}

This is not a fantasy from myself. Flexible array members are used a
lot in the uapi and do not define a XXX_HDR_SIZE macro.

I can send again the exemple from ethtool which I shared before:
  * kernel definition:
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ethtool.h#L1163
  * userland code:
https://kernel.googlesource.com/pub/scm/network/ethtool/ethtool/+/refs/heads/ethtool-3.4.y/ethtool.c#2989

In the userland code of the above example, you can see that the same
structure (without a "header" suffix) is used to manage both headers
and full messages. Extract:
struct ethtool_rxfh_indir indir_head;
struct ethtool_rxfh_indir *indir;

Even the ones which add the "header" suffix do not declare the
XXX_HDR_SIZE macro. Example: struct ip_auth_hdr from linux/ip.h:
https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ip.h#L109
Furthermore, in this struct ip_auth_hdr, the auth_data field is
specified to be at least 4 bytes, which clearly contradict your
argument that "This is no sizeof(struct canxl_frame) anymore with the
use of a flexible array because a valid CAN XL frame has data".

The flexible array member is the standard method to handle structure
of variable length. And by standard, I literally mean so (c.f. ISO
C99, section 6.7.2.1 paragraph 16). And people have been happily using
sizeof(struct foo) to get the header size for decades. I do not see
why canxl_frame should be different.

This is basically what I meant by saying that the flexible array
members are more idiomatic. It is closer to what other people have
been doing in the uapi so far. As you said, CANXL is closer to
Ethernet than CAN. So I do not see the point to force some
similarities between the struct can(fd)_frame and the struct
canxl_frame.

I looked for counterexamples in the uapi headers that would prove me
wrong, but didn't find any.


Yours sincerely,
Vincent Mailhol
