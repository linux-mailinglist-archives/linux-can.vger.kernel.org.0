Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8545740EC
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 03:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiGNBXl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Jul 2022 21:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiGNBXk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Jul 2022 21:23:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4D62DED
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 18:23:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id n74so806154yba.3
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 18:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/57g+qRQfIDBG8vAIJjS2BU9eO7ZHFecbGaIA9xEcM=;
        b=Pyzl2ROPLrQemzthD8pw5c0ohxEx4kfdJ62It2cxg0nsKWyXTKtRrzuOomQykLdU87
         nntpz/Sn9GdHDpMKdgTbLu3RmUFAnosk5a28/+feHmsu8B03G33DFQ/OA3wuhOeFo72T
         PwLWjlXXJ8XzVwsYl0hZPiXrmwGISAxvcDP6se1Ib4BocakrCd36nww01FDcg7sUeE9X
         0T29jwZnUSFtDandDd87MfeQN+y6L9fZejoLRDBzqoxTzU5LvOcQ9c+G6ahO0gttLVj6
         3uPDP3/RkeNuRcvllaQ9ZFU3mqM9rYxKkp8JgYfG4dWx4omzSHL3yHICvG7iBJM/pW8M
         DyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/57g+qRQfIDBG8vAIJjS2BU9eO7ZHFecbGaIA9xEcM=;
        b=Erl1sLzkWdfAD+52F3qzoVj090GeX8te+VVygDShtcCjANkSBzfImiIpYPdO0mRzto
         7ISXuSfvM/7K1EVpugt/pV1ir7pSKQN6VWUzGYvvaduq7dZP51F0FAbpqebv/ACS+kFy
         6VlNNMv9AfY4SJFbD6zkZzSgj3Fl+QLkXgy1kZMDBi4RCOcQ0/c8gPtMOhImhiN4ForE
         j0K4oARUPD/YtNWOvcnWbv7iYB6x4V/xw5PyWUEfPfkeHE8C/wvAqq88mvHSq+Dym4lA
         ewpS2ELjbhVMm3/V3d+n1zQcr+SfcUTVUNfsHfenk5KgWFfdKu7c6uhlziDWwRMacFlG
         fgeA==
X-Gm-Message-State: AJIora+XL9U4o71eOydnHBUQZ/+IIzSWPM94hPOoObK2ZCzNyfhHjiHN
        m9zxdNA3QnCyG9VecCUIw6w/DsAL7aHQ2i1/KeIvQBSXD1k=
X-Google-Smtp-Source: AGRyM1tmuO8zkBJPYJVsCZ1JtOqZU8334t3KJehU2DFwAnag7oiXv+AsZodikG1E1Gzkg14Vf0ecLDbdbrWYbx8eAN0=
X-Received: by 2002:a05:6902:4d0:b0:66e:4fef:cc3f with SMTP id
 v16-20020a05690204d000b0066e4fefcc3fmr6085807ybs.20.1657761814956; Wed, 13
 Jul 2022 18:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-2-socketcan@hartkopp.net> <CAMZ6RqLqDFqdtKsp6jGhnTtWRrf6HC5HiLuJUSCRNkDXqVfCzA@mail.gmail.com>
 <f00a4c5d-c4e6-06a2-76c0-53105d3465f2@hartkopp.net> <CAMZ6RqLVvYCoBF67VtqUSJHAxBHvEmK2-o8NCD7REZj1ywXf7w@mail.gmail.com>
 <521fe0a3-a9ad-60ac-3ec6-30f0da228032@hartkopp.net> <CAMZ6RqJhjkVgZgmfk7btYK+bLtqnbvGBYTnssy28ZWqyfyqppw@mail.gmail.com>
 <89f90d61-35a4-59a2-231b-4372d4dca25c@hartkopp.net> <CAMZ6Rq+LqfUhLcg6909=239a+Asm6aO-bPqpar2tQ_fs0EmiUQ@mail.gmail.com>
 <b866e05b-a548-132c-4427-7a4d21d12172@hartkopp.net> <CAMZ6RqLGWB-afDmZfV+qJU2g=XUycFS1o9j6EwqRVg_dyf4eOw@mail.gmail.com>
 <16457321-6a4f-4830-17aa-d6efd7a39555@hartkopp.net>
In-Reply-To: <16457321-6a4f-4830-17aa-d6efd7a39555@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 14 Jul 2022 10:23:48 +0900
Message-ID: <CAMZ6RqLSHAdB-ocj7=74zJqWbv-EH9x8X5ARPK6Gv+FFiTZ7Lg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] can: canxl: introduce CAN XL data structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
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

On Thu. 14 Jul. 2022 at 05:02, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 13.07.22 03:07, Vincent Mailhol wrote:
> > On Wed. 13 Jul. 2022 at 04:24, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> > Well, if we document than can_frame::__pad shall be zero for mix
> > usages (i.e. comments in struct can_frame and updated kernel doc),
> > then we would have done our due diligence. From that point, if people
> > ignore the documentation *and* do not follow best practices for safety
> > application development, I wouldn't cry.
>
> Right. As long as we did not enable CAN_XL we do not need to take care.
> And introducing the restriction to set __pad to zero together with the
> new CAN_XL option seems legit.

ACK. I draw the line between the already existing applications and the
yet to be written ones. If we are safe for the existing ones, then I
think we are good to go.

> > If we absolutely want to prevent struct can_frame to be interpreted as
> > a canxl_frame due to some stack garbage, we can add one
> > padding/reserved field like that:
> >
> > struct canxl_frame {
> >          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> >          __u8    sdt;   /* SDU (service data unit) type */
> >          __u8    flags; /* additional flags for CAN XL */
> >          __u16   len;   /* frame payload length in byte */
> >          __u32   af;    /* acceptance field */
> >          __u32 __res; /* reserved field. Shall be zero */
> >          __u8    data[] __attribute__((aligned(8)));
> > };
> >
> > This way, the minimum transfer unit of CANXL is 17 bytes (16 for
> > header and 1 for data) which is exactly one byte more than can_frame
> > (and we get back the 8 bytes alignment \o/)
> >
> > This would only leave the risk of having some garbage in
> > canfd_frame::flags, e.g. if user does:
> >
> >          struct canfd_frame cfd; /* declared on the stack and not initialized */
> >          cfd.flags |= <some_flags> /* use |= instead of = */
> >
> > But this is already risky for plain CAN-FD.
>
> Hm, this brings me to an even more weird idea:
>
> struct canxl_frame {
>          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>          __u8    sec:1, /* SEC bit */
>                  xltag:7; /* all bits set */
>          __u8    sdt;   /* SDU (service data unit) type */
>          __u16   len;   /* frame payload length in byte */
>          __u32   af;    /* acceptance field */
>          __u8    data[CANXL_MAX_DLEN];
> };
>
> We could set the first byte (former len element) to a value of 0x7F and
> define the SEC bit as 0x80.

Beware! You just stepped in the realm of undefined behaviours! The
order of the bitfields is implementation specific...

Ref: ISO/IEC 9899:1999 section 6.7.2.1 "Structure and union
specifiers" paragraph 10:

| The order of allocation of bit-fields within a unit (high-order to
| low-order or low-order to high-order) is implementation-defined.

Example, on my x86_64 machine, this code:

/*********** begin **********/
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

union foo {
        struct {
                uint8_t sec:1, /* SEC bit */
                        xltag:7; /* all bits set */
        };
        uint8_t raw;
};

int main()
{
        union foo foo;

        foo.sec = 1;
        printf("foo.raw: 0x%x\n", foo.raw);

        return EXIT_SUCCESS;
}
/*********** end ************/

will return: "foo.raw: 0x1" instead of the expected 0x80.

The correct declaration is:

/*********** begin **********/
#include <asm/byteorder.h>

struct canxl_frame {
        canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
#if defined(__LITTLE_ENDIAN_BITFIELD)
        __u8    xltag:7, /* all bits set */
                sec:1; /* SEC bit */
#else /* __BIG_ENDIAN_BITFIELD */
        __u8    sec:1, /* SEC bit */
                xltag:7; /* all bits set */
#endif
        __u8    sdt;   /* SDU (service data unit) type */
        __u16   len;   /* frame payload length in byte */
        __u32   af;    /* acceptance field */
        __u8    data[CANXL_MAX_DLEN];
};
/*********** end ************/

And this starts to be a really convoluted solution.

> This would mean that we use the former length element to indicate the
> CAN XL frame as no CAN/CANFD frame can have a length of 127 and above.
>
> Not sure if it makes sense to define some bits as depicted above, or if
> we should define a __u8 xlsec ?

If we follow your idea, use __u8 xlsec in order to avoid undefined behaviours.

> Where we define
>
> #define CANXL_TAG 0x7F

Here, you "burn" all the flags for future usage.
FYI, this doesn't have to be 0x7F. It could be any of the length
values not allowed by CAN-FD, namely (in decimal): 9-11, 13-15, 17-19,
21-23, 25-31, 33-47, 49-63

> #define CANXL_SEC 0x80

I did not get why CANXL_XLF isn't needed anymore.

> which has to be set in the xlsec element then.
>
> With this move we get rid of any flags problems (we only need the SEC
> bit anyway) and define a clear 'escape value' in the former length element.

If I try to bounce on your idea, I will propose:

/*********** begin **********/
struct canxl_frame {
        canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
        __u8    flags; /* additional flags for CAN XL. MSB must be set */
        __u8    sdt;   /* SDU (service data unit) type */
        __u16   len;   /* frame payload length in bytes */
        __u32   af;    /* acceptance field */
        __u8    data[];
};

#define CANXL_XLF 0x01 /* mark CAN XL for dual use of struct canfd_frame */
#define CANXL_SEC 0x02 /* Simple Extended Content (security/segmentation) */
#define CANXL_DISCRIMINATOR 0x80; /* Mandatory to distinguish between
CAN(-FD) and XL frames */
/*********** end ************/

This has no undefined behaviour and we still have five flags (0x04 to
0x40) for future use.


Yours sincerely,
Vincent Mailhol
