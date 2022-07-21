Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AC857C257
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 04:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiGUChN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jul 2022 22:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGUChM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2022 22:37:12 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315794C601
        for <linux-can@vger.kernel.org>; Wed, 20 Jul 2022 19:37:11 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31e64ca5161so4143757b3.1
        for <linux-can@vger.kernel.org>; Wed, 20 Jul 2022 19:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WntT4ZgU64K6q7bLfi8h92aWWZXYowWROGlKqrA8jzI=;
        b=AERlsHOE10RJAhVN2EfE1Zfe6atjhm5wbYgl/FzhtCUWqonaGaLhwRZfnXY5jalkTI
         jvAVBqY7b4OiuM8C5Y7Kp58SNLjo2826OXsHYOn+SPWx9Zf12JlxE4+0JS3R3sIjN9Nr
         YyUOi/8hPHAM6gWYU0PieceRJZYJFC6EwgxXM40ncRO+98slPoPIBMjyKLXxy8nMuNqO
         jiO4lzBVm7YHGsF6sJ+ZJwvyXLfBA2bknJZwpCogw39c7fcaNe/62jWQaQQYShzYp1dp
         C4Mb3Ay9V5OXzvF0nK7PPv/I2bQuIStR0fBhXeF+6WqtL7fzVztZixE7HBM3JCD9MREB
         6VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WntT4ZgU64K6q7bLfi8h92aWWZXYowWROGlKqrA8jzI=;
        b=bv+MmN9YX+Zx8MhTs1aWX7AdPj5fJxwjvU1oVSgTg8tGLx/VPx3sAXp7T1IP5b66+G
         cz/kB/ZPvlt4VC4IK6sNTYpOJHELaCFMTv2Ls8X0stqcrYUqVeKQ/3+Cxm9BDMXRDE76
         cWfub0frK3sdGtwCn6W5Vbunq0+U6GYNYGVz/f5CNJM08TeEvziSn6mtmOCD3ZaFTNUk
         u0V2r9VcTCHnhoaZEjp4/ZNy7yuIOTnkjvhEOvv+WTIVi0lmWu6Rk5zUtOWiJCuO15PO
         XWCIlFWsKG1o63iY+DA/9PtyR192fBkmJUokhaPeuvzQ1EZ4e9dYtkDeZ6Btqeclo/5d
         fGTQ==
X-Gm-Message-State: AJIora84XH9uNkYTff16njJmxYFOfDNlDtic7zSqVSvtH9roLWzt6Z/3
        3VWUsxdKB/TUU9+OpL2FHhQhnah4S9kYKYd96YKRpeizGDo=
X-Google-Smtp-Source: AGRyM1uEmaky2LoQRJhZSxa4FvRt7PLW0Ew0Whl3L4sFH0AzIZcu/sd4Xq5yHOLfSK52aeLMGa+fgMVNzTUtMGjar18=
X-Received: by 2002:a81:9201:0:b0:31e:4ce6:8c90 with SMTP id
 j1-20020a819201000000b0031e4ce68c90mr15230710ywg.45.1658371030376; Wed, 20
 Jul 2022 19:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220719112748.3281-1-socketcan@hartkopp.net> <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net> <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
In-Reply-To: <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 21 Jul 2022 11:37:24 +0900
Message-ID: <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 21 Jul. 2022 at 01:43, Oliver Hartkopp <socketcan@hartkopp.net> wro=
te:
> On 19.07.22 17:16, Vincent Mailhol wrote:
> > On Tue 19 Jul. 2022 at 23:38, Oliver Hartkopp <socketcan@hartkopp.net> =
wrote:
> >> No confusion.
> >>
> >> The API to the user space is 'truncated' option only.
> >>
> >> The data structure inside the kernel sizeof(struct can[|fd|xl]_frame).
> >>
> >> See:
> >> https://lore.kernel.org/linux-can/4c79233f-1301-d5c7-7698-38d39d8702aa=
@hartkopp.net/
> >>
> >> ---8<---
> >>
> >> As the sk_buffs are only allocated once and are not copied inside the
> >> kernel there should be no remarkable drawbacks whether we allocate
> >> CAN_MTU skbs or CANXL_MTU skbs.
> >>
> >> AFAICS both skbs will fit into a single page.
> >
> > This is true. A page is at least 4k. So the 2k + alpha will easily fit.
> > But the page is not the smallest chunk that can return malloc, c.f.
> > KMALLOC_MIN_SIZE:
> > https://elixir.bootlin.com/linux/latest/source/include/linux/slab.h#L27=
9
> >
> > Also, more than the page size, my concern are the cache misses,
> > especially when memsetting to zero the full canxl frame. As far as I
> > understand, cloning an skb does not copy the payload (only increment a
> > reference to it) so the echo_skb thing should not be impacted.
> > That said, I am not able to tell whether or not this will have a
> > noticeable impact (I have some feeling it might but can not assert
> > it). If this looks good for the people who have the expertise in
> > kernel performances, then I am fine.
>
> The more I think about our discussion and your remark that we were
> somehow going back to the V2 patch set the more I wonder if this would
> be a good idea.

I quite liked v2. My comments on the v2 were mostly to argue on the
data[CANXL_MAX_DLEN] vs the flexible member array, but aside from
that, it looked pretty good.

> IMO using the struct canxl_frame (including 2048 byte) and allowing
> truncated sizes can be handled inside the kernel safely.
>
> And with V2 we only allocate the needed size for the sk_buff - without
> any memsetting.
>
> When user space gets a truncated frame -> fine
>
> When the user forges some CAN XL frame where the length value does not
> match the spec and the size does not fit the length -> -EINVAL
>
> So there is no uninitialized data also.

So basically, forcing the truncation everywhere (TX, RX both userland
and kernel), correct? i.e. the skb length shall always be equal to
CANXL_HEADER_SIZE + canxl_frame::len.

I think this is good. As I stated before, getting -EINVAL is benign.
If developers are doing crazy things because they did not read the
doc, it is better to fail them early. If we go for truncation then
always truncating is the safest: less option -> less confusion.

> And even the user space side to handle a mix of CAN frame types is
> pretty simple IMO:
>
> union {
>          struct can_frame cc;
>          struct canfd_frame fd;
>          struct canxl_frame xl;
> } can;

Do you want to add this union in the kernel uapi or is it just a
userland example?

> nbytes =3D read(s, &can.xl, sizeof(struct canxl_frame));
> if (nbytes < 0) {
>          perror("read");
>          return 1;
> }
> printf("nbytes =3D %d\n", nbytes);

Does read() guarantee atomicity? From "man 2 read":

| It is not an error if [the return value] is smaller than the number
| of bytes requested; this may happen for example because fewer bytes
| are actually available right now (maybe because we were close to
| end-of-file, or because we are reading from a pipe, or from a
| terminal), *or because read() was interrupted by a signal*.

I think the answer is yes, but I prefer to double check (I am
especially concerned by the signal interrupts).

>
> if (nbytes < CANXL_HDR_SZ + CANXL_MIN_DLEN) {
>          fprintf(stderr, "read: no CAN frame\n");
>          return 1;
> }
>
> if (can.xl.flags & CANXL_XLF) {
>           if (nbytes !=3D CANXL_HDR_SZ + can.xl.len) {
>                  printf("nbytes =3D %d\n", nbytes);
>                  perror("read canxl_frame");

ACK.

>                  continue;
>           }
>           /* process CAN XL frames */
>           printf("canxl frame prio %03X len %d flags %d\n",
>                   can.xl.prio, can.xl.len, can.xl.flags);
>           continue;
> }
>
> if (nbytes !=3D sizeof(struct can_frame) &&
>      nbytes !=3D sizeof(struct canfd_frame)) {

On the first read, I thought you meant "else if", then, I saw the
"continue" on the previous line.

>          fprintf(stderr, "read: incomplete CAN(FD) frame\n");
>          return 1;
> }
>
> /* process CAN/FD frames */
>
> Working with partially filled data structures is a known pattern for CAN
> and CAN FD.

Except that for CAN-(FD), truncation is not possible.

> We only optimize the transfer from/to kernel space with truncated
> read/write operations.
>
> =C2=AF\_(=E3=83=84)_/=C2=AF

Yes, this full discussion is about optimizations=E2=80=A6

> >
> > Maybe even better:
> >
> >          switch(ntohs(skb->protocol)) {
> >          case ETH_P_CAN:
> >                 /* ... */
> >          case ETH_P_CANFD:
> >                 /* ... */
> >          case ETH_P_CANXL:
> >                  /* ... */
> >          default:
> >                  /* ... */
> >          }
>
> Yes ... updated my next patch.
>
> Best regards,
> Oliver
