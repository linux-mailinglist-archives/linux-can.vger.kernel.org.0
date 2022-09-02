Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9C05AA7FC
	for <lists+linux-can@lfdr.de>; Fri,  2 Sep 2022 08:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiIBGUR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Sep 2022 02:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiIBGUP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Sep 2022 02:20:15 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF32CC95
        for <linux-can@vger.kernel.org>; Thu,  1 Sep 2022 23:20:11 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-33dc345ad78so7576957b3.3
        for <linux-can@vger.kernel.org>; Thu, 01 Sep 2022 23:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=uvkTyLEOFX0BAzYj3YrLntbCGlPpDlS+W6mpI3OfWZc=;
        b=Nbb0QwJopIO5SSGxcvZ9z3HIZiz4o6hGzFQ4WojA/jo2V+Jn5WqlRysrl3CghqchgZ
         W4UGM1ReDL7fgyGL5VoPSLUnNU2GKiVoQ3A8NEZljQmoPZcvGDn/BUYfEg/VKYbiZoVn
         1bvSWv0QqWNrqmnRXNiYK+Jf3dxrETaLXj4Sw8xIW9FSRKxu1VQSekgiQMBAeLki3tCG
         ZJt/Js68Q60C/7Ge/Jk3ZVwmkZmxLY52/R6tO1zpc8JlvvtNOdwjdaREvDHb+5AgYcBg
         MtZ+3pLUmhURfJVOhUMmKxi4hPHjp45fqe91UQ11vJTa5qkSq608UmbbAXfzcp3oHE8/
         ih4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uvkTyLEOFX0BAzYj3YrLntbCGlPpDlS+W6mpI3OfWZc=;
        b=DuaYC3d8qTHhF5gkSPeh6DBHV12oZxaOvjrEo1FfjA3vOggZkDCpL2WzDHKH+66RMc
         IU6XAdqKgjYMWtPFdK8M5WCHmQ5cVYs3EeoSAz3aS9c4W2X1+dgXTYx45ZIjCOTOXqbc
         3kRfnfW8hrMhqr/JRDGLT1C7JQMLW0Pl+wTeYYIh8hpP3dUqIja77cLdT27AeD7XHPKU
         DFISZkS1+MYwxHG7Hit8vyQmYZ/JjOLttSXCj65sUumouFwY4mjgNL6DxP9fATiU1jh2
         aHlxm45keDWTzL5PPFKxbGmDsQVy2BibcBVVtvAuJXfmASzeufnLkZP1WwB00cDE8RXj
         Tayg==
X-Gm-Message-State: ACgBeo2f7zT9nKRpyLXaw2XXd+QlRLm5coShyNM1xC+bmfY1kvhCEQLO
        VHAqN0ti2Ya6p1l4afz28tDc122AgDyWeLTmjDrdWFPq9ac=
X-Google-Smtp-Source: AA6agR6IbOXgaRUqOESsfCuNdx0bHzVnH2iqdtIhgpRyTkBYXDXd7OijJIXuisWjde3boLWV6XwuXhm1ttYY9Hf6Yw0=
X-Received: by 2002:a0d:c283:0:b0:335:7a81:f61e with SMTP id
 e125-20020a0dc283000000b003357a81f61emr25775605ywd.220.1662099610638; Thu, 01
 Sep 2022 23:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220801190010.3344-1-socketcan@hartkopp.net> <20220801190010.3344-5-socketcan@hartkopp.net>
In-Reply-To: <20220801190010.3344-5-socketcan@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Fri, 2 Sep 2022 15:19:59 +0900
Message-ID: <CAMZ6RqKFNY1y9XpsLU6cjs_TmnYBjjDin6LHn5TRpm5m4w2ewg@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] can: canxl: introduce CAN XL data structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

Sorry for the late reply, I am back from holidays. My previous review
was a best effort review.

Since then, I took time to read the CiA=E2=80=99s CAN knowledge pages of CA=
N XL:
https://www.can-cia.org/can-knowledge/can/can-xl/
and have a few newer comments.

Unfortunately, I still do not have access to the full specification,
so please forgive if there are some silly remarks.

On Tue. 2 Aug 2022 at 04:02, Oliver Hartkopp <socketcan@hartkopp.net> wrote=
:
> This patch adds defines for data structures and length information for
> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
> byte inside a single frame.
>
> Notable changes from CAN FD:
>
> - the 11 bit arbitration field is now named 'priority' instead of 'can_id=
'
>   (there are no 29 bit identifiers nor RTR frames anymore)
> - the data length needs a uint16 value to cover up to 2048 byte
>   (the length element position is different to struct can[fd]_frame)
> - new fields (SDT, AF) and a SEC bit have been introduced
> - the virtual CAN interface identifier is not part if the CAN XL frame
>   struct as this VCID value is stored in struct skbuff (analog to vlan id=
)
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/uapi/linux/can.h | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 7b23eeeb3273..dd645ea72306 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -46,10 +46,11 @@
>  #ifndef _UAPI_CAN_H
>  #define _UAPI_CAN_H
>
>  #include <linux/types.h>
>  #include <linux/socket.h>
> +#include <linux/stddef.h> /* for offsetof */
>
>  /* controller area network (CAN) kernel definitions */
>
>  /* special address description flags for the CAN_ID */
>  #define CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
> @@ -58,10 +59,11 @@
>
>  /* valid bits in CAN ID for frame formats */
>  #define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
>  #define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
>  #define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
> +#define CANXL_PRIO_MASK CAN_SFF_MASK /* 11 bit priority mask */
>
>  /*
>   * Controller Area Network Identifier structure
>   *
>   * bit 0-28    : CAN identifier (11/29 bit)
> @@ -71,10 +73,11 @@
>   */
>  typedef __u32 canid_t;
>
>  #define CAN_SFF_ID_BITS                11
>  #define CAN_EFF_ID_BITS                29
> +#define CANXL_PRIO_BITS                CAN_SFF_ID_BITS
>
>  /*
>   * Controller Area Network Error Message Frame Mask structure
>   *
>   * bit 0-28    : error class mask (see include/uapi/linux/can/error.h)
> @@ -89,10 +92,20 @@ typedef __u32 can_err_mask_t;
>
>  /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
>  #define CANFD_MAX_DLC 15
>  #define CANFD_MAX_DLEN 64
>
> +/*
> + * CAN XL payload length and DLC definitions according to ISO 11898-1
> + * CAN XL DLC ranges from 0 .. 2047 =3D> data length from 1 .. 2048 byte
> + */
> +#define CANXL_MIN_DLC 0
> +#define CANXL_MAX_DLC 2047
> +#define CANXL_MAX_DLC_MASK 0x07FF
> +#define CANXL_MIN_DLEN 1
> +#define CANXL_MAX_DLEN 2048
> +
>  /**
>   * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
>   * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t defi=
nition
>   * @len:      CAN frame payload length in byte (0 .. 8)
>   * @can_dlc:  deprecated name for CAN frame payload length in byte (0 ..=
 8)
> @@ -164,12 +177,50 @@ struct canfd_frame {
>         __u8    __res0;  /* reserved / padding */
>         __u8    __res1;  /* reserved / padding */
>         __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
>  };
>
> +/*
> + * defined bits for canxl_frame.flags
> + *
> + * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_S=
EC
> + * and shares the relative position of the struct can[fd]_frame.len elem=
ent.
> + * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL f=
rame.
> + * As a side effect setting this bit intentionally breaks the length che=
cks
> + * for Classical CAN and CAN FD frames.
> + *
> + * Undefined bits in canxl_frame.flags are reserved and shall be set to =
zero.
> + */
> +#define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be se=
t!) */
> +#define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation=
) */

Are we sure that no other flags are needed? The CiA can-knowledge
mentions a FTYP (frame type) flag. Do you know what it is?

> +
> +/**
> + * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structu=
re
> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
> + * @flags: additional flags for CAN XL
> + * @sdt:   SDU (service data unit) type
> + * @len:   frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLE=
N)
> + * @af:    acceptance field
> + * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
> + *
> + * @prio shares the same position as @can_id from struct can[fd]_frame.
> + */
> +struct canxl_frame {
> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */

Does it make sense to keep the canid_t? The addressing is done through
both the prio and the af fields. Also, the CAN_EFF_FLAG, CAN_RTR_FLAG
and CAN_ERR_FLAG flags do not apply anymore. Finally, the prio is only
11 bits, no need to reserve 32 bits for it.

Of course, if we declare it as 16 bits, we need to add some padding so
that the other flags remain at the same offset.

> +       __u8    flags; /* additional flags for CAN XL */
> +       __u8    sdt;   /* SDU (service data unit) type */
> +       __u16   len;   /* frame payload length in byte */
> +       __u32   af;    /* acceptance field */
> +       __u8    data[CANXL_MAX_DLEN];
> +};

The CiA CAN knowledge also mentions a VCID (virtual CAN network ID).
Is this not needed?

> +
>  #define CAN_MTU                (sizeof(struct can_frame))
>  #define CANFD_MTU      (sizeof(struct canfd_frame))
> +#define CANXL_MTU      (sizeof(struct canxl_frame))
> +#define CANXL_HDR_SIZE (offsetof(struct canxl_frame, data))
> +#define CANXL_MIN_MTU  (CANXL_HDR_SIZE + 64)
> +#define CANXL_MAX_MTU  CANXL_MTU
>
>  /* particular protocols of the protocol family PF_CAN */
>  #define CAN_RAW                1 /* RAW sockets */
>  #define CAN_BCM                2 /* Broadcast Manager */
>  #define CAN_TP16       3 /* VAG Transport Protocol v1.6 */

CAN XL has a resXL flag, suggesting that there may be a fourth
generation of the CAN protocol. One issue in the initial socket CAN
design is that we never reserved a flag for future versions. Here, we
are lucky that the bit 0x80 of the length field is never set.
Back to CAN XL, I would like to discuss how we will distinguish the
CAN GEN4 frames from the CAN XL ones so that we do not find ourselves
stuck in a couple of years because no bits are left to differentiate
things.

One solution would be to set the two most significant bit:
#define CAN_GEN4 0xC0

and the test would be:
if (cf.flags & CAN_GEN4 =3D=3D CAN_GEN4)

Does anyone have a better idea?


Yours sincerely,
Vincent Mailhol
