Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6467F57D9D1
	for <lists+linux-can@lfdr.de>; Fri, 22 Jul 2022 07:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiGVFkV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jul 2022 01:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFkU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jul 2022 01:40:20 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB0B1571C
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 22:40:18 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31e560aa854so37403047b3.6
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 22:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrOR+UMZHJMP3md+O3PbxrFRR9k8I0wZrGljlnPYqio=;
        b=Ubl1IO3My/FO4poDtiEqBwi+lecuoaH2g+H/2KKI+Ysp66wzxwOutRtzGsE4ZQOEOh
         AuDldkxtUMhNDHIrA9O8xKTDef6v1ZR22h78FuELkCXigS9g0ExgbW5Z/TAyhAxq9d2z
         9h/LKwQWwQLXxDiUBtlg2oTJOZbSdLrWcc3YUTeXO9cLlhfcjWQ4+YjcJEn/SAEwNE4Y
         SDlFpiCvtO8gavwmZImLKXk6VBevmTmI+TEjc1eHkycCZXWhaQCAgamqXa2iCCUeyB99
         46UIGHoynv2p1ku+CGoerSHWIiPK7TgE3vS0qUw6qBfNd21wyauvksJGfmsP2LsynoI7
         ZRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrOR+UMZHJMP3md+O3PbxrFRR9k8I0wZrGljlnPYqio=;
        b=62H70dyluACYk1IcQ3nZcNV/l4Gg7N3aQBVzeuxZyU+ruupv27PU9E66oOaCa7SnaZ
         kq8s2R/SnPIYDEpZGIT6ZmWxsDKZ8HJgsBMnn3euI0LYK97cHg+OvdNGeF/7jSQatLYo
         eVA1UM9kLjrBXbZIcauTtEPu8iliyPprDDR0PeGjPUj2MTLxEbGbYyEe91ev6yvYeAZG
         DuoXDG9VaY+xUyK1LTp5LW6/Yd3h/CbuWd3ccBXkVtMmKUTA2SI9UnKdQZjCEe/W3eiG
         /BJZBdTWx46OERD2UAJOwMBr+xN/36XpUR4McUy6NTzNPtbxo8MmmjUy2tqdaZpufMou
         pMiQ==
X-Gm-Message-State: AJIora9lsyIVMrLR0/2LD9v56j/radODl4Di6usulaHQ8y+4CaCLv7zt
        NEcwE1rxZ/FjqSdF3poE967GdQfA2MhtiEFDENAnGne9QtY=
X-Google-Smtp-Source: AGRyM1vGVstenWSKZ+qXYO+M590iL++0RlsAKWG0nX76ET0gzZZy6ikDLwZvelnnQGe6WzkJYEWiezqcA69Ncg77er8=
X-Received: by 2002:a81:a42:0:b0:31e:562a:eaab with SMTP id
 63-20020a810a42000000b0031e562aeaabmr1736124ywk.392.1658468417974; Thu, 21
 Jul 2022 22:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220719112748.3281-1-socketcan@hartkopp.net> <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net> <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net> <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <CAMZ6RqKex6DwpFrs6pYe5UnSSHhu6TCcGi4xW1WcpKM8F=oS=A@mail.gmail.com> <cdb2d8cb-a0ab-a4f6-267a-0a574823a8a9@hartkopp.net>
In-Reply-To: <cdb2d8cb-a0ab-a4f6-267a-0a574823a8a9@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 22 Jul 2022 14:40:31 +0900
Message-ID: <CAMZ6RqK4ETSr2qhFQYfM1iXGSr=gKGbG5sM2JJsx5TowzGCE_A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
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

On Fri. 22 Jul. 2022 at 05:26, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 21.07.22 05:13, Vincent Mailhol wrote:
> > On Thu. 21 juil. 2022 at 11:37, Vincent Mailhol
> > <vincent.mailhol@gmail.com> wrote:
> >> On Wed. 21 Jul. 2022 at 01:43, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
>
> >>> And even the user space side to handle a mix of CAN frame types is
> >>> pretty simple IMO:
> >>>
> >>> union {
> >>>           struct can_frame cc;
> >>>           struct canfd_frame fd;
> >>>           struct canxl_frame xl;
> >>> } can;
> >>
> >> Do you want to add this union in the kernel uapi or is it just a
> >> userland example?
> >
> > More brainstorming. If we want to introduce a generic can structure in
> > linux/can.h, we could  do:
> >
> > struct canxl_frame {
> >          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> >          __u8    xl_flags; /* additional flags for CAN XL */
> >          __u8    fd_flags; /* CAN(-FD) flags */
> >          __u16   len;   /* frame payload length in byte */
> >          __u32   af;    /* acceptance field */
> >          __u8    sdt;   /* SDU (service data unit) type */
> >          __u8    __res0;  /* reserved / padding */
> >          __u8    __res1;  /* reserved / padding */
> >          __u8    __res2;  /* reserved / padding */
> >          __u8    data[CANXL_MAX_DLEN] __attribute__((aligned(8)));
> > };
> >
> > union can_generic_frame {
> >           struct {
> >                  union {
> >                         canid_t can_id;
> >                         canid_t prio;
> >                  };
> >                  union {
> >                          __u16 type;
> >                           struct {
> >                                  __u8 xl_flags;
> >                                  __u8 fd_flags;
> >                          } __attribute__((packed));
> >                  } __attribute__((packed));
> >           };
> >           struct can_frame cc;
> >           struct canfd_frame fd;
> >           struct canxl_frame xl;
> > };
> >
> > #define CANXL_XLF 0x80 /* apply to canxl_frame::xl_flags */
> >
> > #define CAN_TYPE_CC 0
> > #ifdef __LITTLE_ENDIAN
> > #define CAN_TYPE_FD (CANFD_FDF << 8)
> > #define CAN_TYPE_XL (CANXL_XLF)
> > #else /* __BIG_ENDIAN */
> > #define CAN_TYPE_FD (CANFD_FDF)
> > #define CAN_TYPE_XL (CANXL_XLF << 8)
> > #endif
> >
> > #define CAN_TYPE_MASK (CAN_TYPE_FD | CAN_TYPE_XL)
> >
> > Because can_generic_frame::type overlaps with the can(fd)_frame::len,
> > it will contain garbage and thus it is necessary to mask it with
> > CAN_TYPE_MASK.
> > The CANFD_FDF is only set in the rx path. In the tx path it is simply
> > ignored. This done, we can use it as below when *receiving* can
> > frames:
>
> No problem to set CANFD_FDF in raw_sendmsg() when we process a CAN FD
> frame in the tx path ...

ACK.

> >
> > int foo()
> > {
> >    union can_generic_frame can;
> >
> >    /* receive a frame */
> >
> >    switch (can.type & CAN_TYPE_MASK) {
> >    case CAN_TYPE_CC:
> >      printf("Received classical CAN Frame\n");
> >      break;
> >
> >    case CAN_TYPE_FD:
> >      printf("Received CAN FD Frame\n");
> >      break;
> >
> >    case CAN_TYPE_XL:
> >      printf("Received CAN XL Frame\n");
> >      break;
> >
> >    default:
> >      fprintf(stderr, "Unknown type: %x\n", can.type & CAN_TYPE_MASK);
> >    }
> >
> >    return EXIT_SUCCESS;
> > }
> >
>
> If you just want to get rid of the nbytes checking and we make sure
> CANFD_FDF is properly set in the future we are not far from such an easy
> check - even without moving the sdt element or endian magic:

ACK. I did not like the mix between the CANXL_XLF and the CAN*_MTU
checks. Would be great to have a consistent method to check the type.

>
> if (can.xl_flags & CANXL_XLF) {
>      printf("Received CAN XL Frame\n");
> } else if (can.fd_flags & CANFD_FDF) {
>      printf("Received CAN FD Frame\n");
> } else {
>      printf("Received classical CAN Frame\n");
> }

ACK. I like this approach :)
