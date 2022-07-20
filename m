Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A7B57B13A
	for <lists+linux-can@lfdr.de>; Wed, 20 Jul 2022 08:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiGTGtk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jul 2022 02:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGTGtk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2022 02:49:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D5E65571
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 23:49:39 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 64so30551014ybt.12
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 23:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=75BL/DG/xUutAV5ucHXAG7AwoArBfVB+E6+tIrhMPQw=;
        b=TNU2ZKmnI7LMFNgyuMdSNOud1V0oQH9y1iWFfgpQa/O8ISORto4Ny4cQU9Pe6HkLwa
         NVWbyh62V/RLpHm1yF/26maXuMeK1I9xUV5AMJbyHErApAW4lxk4WyQxm/SUPuKfsPYj
         9wU3bX+NxRmdzGnxa2o5iemEAlSdv9bG9Lmoa67mwhoeKWjbOafzvO8TL+N44GENDCEM
         DSXl1Tx0GGZMsNBHV11Ko8bP1AqRR6fyt4nyfn1mTMKtHVyDg+pMkIH9CzzXbJ2dhzY7
         aqx38RLB3Dba+2BK2LGywQhRH3Rt/Ip6CAKJSlC3eKXTAYbWOlNS+hLUZMGBwwyU+U6Z
         Uw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=75BL/DG/xUutAV5ucHXAG7AwoArBfVB+E6+tIrhMPQw=;
        b=Y0TedXHH+nYwGo4iJYlRV0/Hjx3/kiyd4emf74ZG/iJTR9wUTH3rjciyyNRmCA9vdj
         qUJ7sySFb8GYSFlsPoVpSY2aGNJkqWiDZ+ombY7ChG3x24iWCRQdlE+Qu2WKjQVraeyL
         3HkpnW+WvDeROqghX14W9Fagy3M2/ENI3bvaf6Oi6iOxNcL0uDxNkMxF6KzrFJbbpy/D
         pYDSyppbVs2jGwY8sFyYL3FpUk8FJurZaSsgykosE1cOw5uJh9AZfvRQVMCujo1p+uwX
         2ckraTEG0ExlkBB52xMOJw0orQ1UHNd1fxVwlPu/lwD6Vn7uIYamFbsCGyEEFMuB6wmq
         VkUg==
X-Gm-Message-State: AJIora8WLesafCsNSgXw9kN8J23Fz4p/p0RQ800K0oadBk01UtWPvhcO
        ECM0Vq6jmtpviFjnMIvQfjQLrZecWcfJkUJckA5A0/xy6js=
X-Google-Smtp-Source: AGRyM1sKqtAMn1RG/4juuY665YeKdd4lkgeiMYPtiWvPeGHSbbUf45jipj2k9R0bDEm9klSWilq909TVpfIcL0NDom4=
X-Received: by 2002:a25:72d4:0:b0:670:7c08:a9e8 with SMTP id
 n203-20020a2572d4000000b006707c08a9e8mr8365240ybc.423.1658299778339; Tue, 19
 Jul 2022 23:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220717132730.30295-1-socketcan@hartkopp.net> <202207181303.38060.pisa@cmp.felk.cvut.cz>
In-Reply-To: <202207181303.38060.pisa@cmp.felk.cvut.cz>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 20 Jul 2022 15:49:26 +0900
Message-ID: <CAMZ6Rq+6mnFP9kPUmx4kdzd7G3=_NUnG10owir8Fg4qPi7P46w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] can: support CAN XL
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
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

On Mon. 18 Jul. 2022 at 20:16, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
> Hello Oliver,
>
> On Sunday 17 of July 2022 15:27:25 Oliver Hartkopp wrote:
> > V2: Major rework after discussion and feedback on Linux-CAN ML
> >
> > - rework of struct canxl_frame
> > - CANXL_XLF flag is now the switch between CAN XL and CAN/CANFD
> > - variable length in r/w operations for CAN XL frames
> > - write CAN XL frame to raw socket enforces size <-> canxl_frame.len sy=
nc
>
> I generally like the idea but I would like even to extend it to process
> all CAN messages types through same API.
>
> +struct canxl_frame {
> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> +       __u8    flags; /* additional flags for CAN XL */
> +       __u8    sdt;   /* SDU (service data unit) type */
> +       __u16   len;   /* frame payload length in byte */
> +       __u32   af;    /* acceptance field */
> +       __u8    data[CANXL_MAX_DLEN];
> +};
>
> I would suggest to think about possibility to have single structure type
> for processing of all CAN frames types in usersace.

I thought about it.

The prio is 11 bits, the XLF and SEC flags are 2 bits together, the
SDT is 8 bits, the length is 12 bits (1~2048) and finally the af is 32
bits. The total is thus 11+2+8+12+32 =3D 65 bits. Arg=E2=80=A6 one bit shor=
t to
fit in the struct can(fd)_frame!
However, if we use the DLC instead, the length information can fit on
11 bits (0~2047). With this, we have just enough to squeeze in the
CAN-XL flags.

And so, let me introduce you the Frankenstein monster version of the
canxl_frame:

#include <asm/byteorder.h>

struct canxl_frame {
        union {
                canid_t can_id; /* CAN(-FD) ID */
                __u32 af; /* CAN-XL acceptance field */
        };
        union {
                struct {
                        __u8 len; /* CAN(-FD) frame length */
                        __u8 flags; /* additional flags for CAN FD */
                        __u8 __res0;  /* reserved / padding */
                        __u8 len8_dlc; /* optional Classic CAN DLC for
8 byte payload length (9 .. 15) */
                };
                struct {
#if defined(__LITTLE_ENDIAN_BITFIELD)
                        __u32 xlf:1; /* is CAN-XL frame? */
#endif
                        __u32 sec:1; /* Simple Extended Content
(security/segmentation) */
                        __u32 xl_dlc:11; /* CAN-XL data length code (0..204=
7) */
                        __u32 prio:11; /* 11 bit priority for arbitration *=
/
                        __u32 sdt:8; /* SDU (service data unit) type */
#if defined(__BIG_ENDIAN_BITFIELD)
                        __u32 xlf:1; /* is CAN-XL frame? */
#endif
                };
        };
        __u8 data[] __attribute__((aligned(8)));
};

Pretty scary, isn=E2=80=99t it?

To be honest, I am sharing this for fun. No need to disprove this
idea, I do *not* support it myself.


Yours sincerely,
Vincent Mailhol
