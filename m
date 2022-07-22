Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6A157DC69
	for <lists+linux-can@lfdr.de>; Fri, 22 Jul 2022 10:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiGVIdW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jul 2022 04:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiGVIdV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jul 2022 04:33:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A639EC42
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 01:33:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p132so6909051yba.3
        for <linux-can@vger.kernel.org>; Fri, 22 Jul 2022 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmRkh8ix17CaVQOf9xS7MnfRpeJ6sBK2sCrNVLfRo0E=;
        b=F+xBkpFazc4S7IrCtrMNvNjsjk6w7BPzND+DQy3aZXdVImfHSHdQBr7MNwIOx3dPRu
         X9X6pIU8nEKSzKua/dLIVzzdVM5PmjWKRIcsHsXSGNouxyep4GVyU9PkEb2c1uzJdBan
         ulrdEdOpnPHqRinkXYuf2Y7C2BlhQvX/ZqE4l1mntiUu8vioway5wcify++ItFEElo5O
         J/FUg3G7c2GuWbnMNCNjcxeIslIgf2P1kZrOp4fUV5VT85ekF0GxyV1nJPnuz4lcm5Qg
         i9iOADCl0Br/aG/8dOOh6VJuitJUF6v3Kt/yZb1dwvgvjWNdUpw5SgIdVdqPznKfbDrY
         VQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmRkh8ix17CaVQOf9xS7MnfRpeJ6sBK2sCrNVLfRo0E=;
        b=ZHsPqPd+PIcMy0dNKgAgCSrkYtN9uCs/oeTGZqCC6yULaw4v2oc/fdN6IhbUxSr/8C
         KIQnvWz9cy9DnUDU36LSaD6uvAQPJDDvnMAsqTIo0J5e49dRYEb+p3t063MrXpzs+CAy
         18xy8fF+CfqtZ+R1NbJLkTPrewLAhBbLbAERtKdICKFdxzOiNJmvQhbxAR/hWsnaeJB8
         46t1TWmzH86pj3ll/Vix6kRdiVgn+pi22/oxr/cuqmz1mOFyJjEpoahgislUp881aGOQ
         WIyWeb3dZabhTAyWezNqtOBKpd7q7qDjF4RBHPEiaF9PnJiVmHzDCfyRTE62VYZkHPLt
         AIdA==
X-Gm-Message-State: AJIora8lHiR6rtB/8hlexOm195UBZXObxMIDKYS99U61qx1wZkSmWLF8
        LT1LvdpW93Wu8JMCidwQhF5OlbgdnD2Z86tAqOW3wvMfmHs=
X-Google-Smtp-Source: AGRyM1vCZZf7FzPvwoEUuP9whb4NVNob05ZWulcvS49uDHSo68TIHmVa7DBMSbQm46mgk59Rf2wJOVjhwtUCURblVxk=
X-Received: by 2002:a25:946:0:b0:670:ccc5:774a with SMTP id
 u6-20020a250946000000b00670ccc5774amr1882724ybm.381.1658478800002; Fri, 22
 Jul 2022 01:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net> <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net> <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <cee555a2-2883-9dab-5740-62849e9ee3ab@hartkopp.net> <20220721075309.l6uusnyk7xjkqd4g@pengutronix.de>
 <CAMZ6RqJTZ4o3dsaYG2s9boJ4By7QC55-N+0RszT9LNxRp3bYuA@mail.gmail.com>
 <ea8ffea6-1065-8526-4774-16d088ec7bf1@hartkopp.net> <CAMZ6Rq+NWFc4KmhCCpJ2LzTt8ap1U_FLrQ1L1RQgYNT0BD3w_Q@mail.gmail.com>
 <20220722072731.s3s7bkfn33zzzeni@pengutronix.de>
In-Reply-To: <20220722072731.s3s7bkfn33zzzeni@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 22 Jul 2022 17:33:08 +0900
Message-ID: <CAMZ6RqJcUtSyYbYnqAE87hrwL1G+cxGLKAZ_E4kvSW3Mq43tYg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
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

On Fri. 22 Jul. 2022 at 16:27, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 22.07.2022 12:20:43, Vincent Mailhol wrote:
> > I do not buy your argument that you can not do sizeof(struct
> > canxl_frame) because of naming.
> >
> > With a flexible array member, I can do:
> >
> > struct canxl_frame {
> >          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> >          __u8    flags; /* additional flags for CAN XL */
> >          __u8    sdt;   /* SDU (service data unit) type */
> >          __u16   len;   /* frame payload length in byte */
> >          __u32   af;    /* acceptance field */
> >          __u8    data[];
> > };
> >
> > void foo (int s)
> > {
> >          struct canxl_frame cxl_hdr = { 0 };
> >          struct canxl_frame *cxl1, *cxl2;
> >          size_t cxl2_data_len, cxl2_frame_len;
> >
> >          /* read header */
> >          assert(read(s, &cxl_hdr, sizeof(cxl_hdr)) == sizeof(cxl_hdr));
> >          cxl1 = malloc(sizeof(*cxl1) + cxl_hdr.len);
> >          memcpy(cxl1, &cxl_hdr, sizeof(cxl_hdr));
> >          /* read remaining data */
> >          assert(read(s, cxl1->data, cxl1->len) == cxl1->len);
>
> For performance reasons you probable don't want to split the read of a
> single CAN frame over 2 read() syscalls.

ACK. I wrote the code to illustrate how to do header manipulations.
The goal of this example was not to be optimal but to show off how
sizeof(struct canxl_frame) could be used. Sorry if the example was not
natural and a bit too forced.

> Also the CAN_RAW doesn't
> support "split"-read now, but could be extended.

Interesting! I naively thought that split read() was handled at a
higher level of the socket API. I did not know that it was per
protocol.

It could make sense to allow such split read() for CANXL. One example
I can directly think of is the Packet API. Correct me if I am wrong
but if writing generic code to dump packets on any interfaces, you do
not know in advance the MTU. And so, I guess you have to provide a
buffer of an arbitrary size. A generic program using a buffer of, let
say, 2048 bytes (one page) will not be enough to get a CANXL frame in
one single shot.

Yours sincerely,
Vincent Mailhol
