Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83115857E7
	for <lists+linux-can@lfdr.de>; Sat, 30 Jul 2022 04:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiG3COF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Jul 2022 22:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiG3COF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Jul 2022 22:14:05 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3571DF76
        for <linux-can@vger.kernel.org>; Fri, 29 Jul 2022 19:14:03 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z5so9119597yba.3
        for <linux-can@vger.kernel.org>; Fri, 29 Jul 2022 19:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsXRynXnb02elP22MBBQmn5+MkOk23cY/iyfTabE9s4=;
        b=hCQgl2n1C6SO6mq4QPxRvz9wJQw6XMdu/ZCcwVSluuvrNg9svREdvAF3H6IccfAzKi
         MnTQVGaxx/R3VQNRDBmLlJm7S9hPHRv1V4/wyntxj4Y9rmA2tUe2fR2+7BFsWv6RnZmM
         U7nLW3eo/sWLPOcF3/wOzoW0EHWV9elXuWeSUc/8CwNw/VpKrf8caLwzOr941gsKdCit
         bnoTBmfNpIrDAghjzAISSe+wHLftH9WKZw1U1eP3S6c5xg3WKzM5W6M3QUPDH1jx4wA+
         htAlTa8ezM8+Zz2ik+ljznAamY7Y7WNDyjjC5PYqFz98YUQ8l/u6wlkCcwQGHw9TYhyf
         /PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsXRynXnb02elP22MBBQmn5+MkOk23cY/iyfTabE9s4=;
        b=mYGyRqSzwSNvXgbDbFilUHU/M44WuPkYJ/P05G1TOQCpg+NGlSJ+YEVgiUCgNTr2f1
         QsdWkL6IaRmCNhnQahi+OqqBIyc6aC9HmuoctRmasAYY0kJcK/EzR2mcRDZRMk/IW1on
         CdJeSMIpH50WgQfoUEhRRTZpaLvaogTqGSOZPYrwhVm3NfhLFwi//CLSBzX9bhlW/fH0
         ALCYIGAzhedf6A3StKQF2D4KcBCqI4+Vh+jM6skil8wF55OwcS6pUsD+cr8ZLHWWEzFJ
         yPrJgb6kvlf3mGcUa+oBYoA4sazOrXQx9gxwdoKZ0BUegMv6PswE/rMvUGKGxfNzBgzt
         rAbA==
X-Gm-Message-State: ACgBeo0NqSntekZ4UrjS7UrhfRNqn6m6hjkagt/uFvePlBkObb+T/il5
        XIlo0R6cJUljxUch44qpKtejUqr0g6AsdDOxALtlkHD7LO6RzA==
X-Google-Smtp-Source: AA6agR5XcDh+GMvzN4smw02owNAdWN4ll2OmDH7q5eIdzZsnjiOicfRwic1Pb8ImHoboPmTUEZNMZvveHbtEJVULibY=
X-Received: by 2002:a25:fc0b:0:b0:671:77a3:e507 with SMTP id
 v11-20020a25fc0b000000b0067177a3e507mr4840787ybd.151.1659147242612; Fri, 29
 Jul 2022 19:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220729154107.1875-1-socketcan@hartkopp.net> <20220729154107.1875-5-socketcan@hartkopp.net>
In-Reply-To: <20220729154107.1875-5-socketcan@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 30 Jul 2022 11:13:51 +0900
Message-ID: <CAMZ6RqKMtoo56OtaYG7Quoky+95hvfQaiFi+nDqez=+hMUMhHg@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] can: canxl: introduce CAN XL data structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
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

On Sat. 30 Jul. 2022 at 00:42, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> This patch adds defines for data structures and length information for
> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
> byte insinde a single frame.
       ^^^^^^^
inside

> Notable changes from CAN FD:
>
> - the 11 bit arbitration field is now named 'priority' instead of 'can_id'
>   (there are no 29 bit identifiers nor RTR frames anymore)
> - the data length needs a uint16 value to cover up to 2048 byte
>   (the length element position is different to struct can[fd]_frame)
> - new fields (SDT, AF) and a SEC bit have been introduced
> - the virtual CAN interface identifier is not part if the CAN XL frame
>   struct as this VCID value is stored in struct skbuff (analog to vlan id)
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
> + * CAN XL DLC ranges from 0 .. 2047 => data length from 1 .. 2048 byte
> + */
> +#define CANXL_MIN_DLC 0
> +#define CANXL_MAX_DLC 2047
> +#define CANXL_MAX_DLC_MASK 0x07FF
> +#define CANXL_MIN_DLEN 1
> +#define CANXL_MAX_DLEN 2048
> +
>  /**
>   * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
>   * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
>   * @len:      CAN frame payload length in byte (0 .. 8)
>   * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
> @@ -164,12 +177,50 @@ struct canfd_frame {
>         __u8    __res0;  /* reserved / padding */
>         __u8    __res1;  /* reserved / padding */
>         __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
>  };
>
> +/*
> + * defined bits for canxl_frame.flags
> + *
> + * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_SEC
> + * and shares the relative position of the struct can[fd]_frame.len element.
> + * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL frame.
> + * As a side effect setting this bit intentionally breaks the length checks
> + * for Classical CAN and CAN FD frames.
> + *
> + * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
> + */
> +#define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
> +#define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
> +
> +/**
> + * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
> + * @flags: additional flags for CAN XL
> + * @sdt:   SDU (service data unit) type
> + * @len:   frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
> + * @af:    acceptance field
> + * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
> + *
> + * @prio shares the same position as @can_id from struct can[fd]_frame.
> + */
> +struct canxl_frame {
> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> +       __u8    flags; /* additional flags for CAN XL */
> +       __u8    sdt;   /* SDU (service data unit) type */
> +       __u16   len;   /* frame payload length in byte */
> +       __u32   af;    /* acceptance field */
> +       __u8    data[CANXL_MAX_DLEN];
> +};

I read the previous threads from the start and there is one point
which, I think, did not get enough attention.

With the current proposal, there is one pitfall on the user side. A
correct way to differentiate between the Classical CAN, CAN-FD and
CAN-XL would be, as discussed:

union {
         struct can_frame cc;
         struct canfd_frame fd;
         struct canxl_frame xl;
} can;

nbytes = read(s, &can.xl, sizeof(struct canxl_frame));

if (can.xl.flags & CANXL_XLF)
    /* Handle CAN XL frame */
else if (can.fd.flags & CANFD_FDF) /* or equivalent: if (nbytes == CANFD_MTU) */
    /* Handle CAN FD frame */
else
       /* Handle Classic CAN frame */

However, it becomes incorrect if the order is changed:

if (can.fd.flags & CANFD_FDF) /* or equivalent: if (nbytes == CANFD_MTU) */
    /* can.fd.flags can collide with can.xl.sdt,  */
    /* nbytes == CANFD_MTU would also collide if the CAN XL frame
length is 32 bytes  */
else if (can.xl.flags & CANXL_XLF)
    /* Handle CAN XL frame */
else
       /* Handle Classic CAN frame */

I see this as a big pitfall.



A solution (or rather a compromise) would be to align the flags fields
between the canfd_frame and canxl_frame.

#define CANXL_XLF 0x08 /* mandatory CAN XL frame flag (must always be set!) */
#define CANXL_SEC 0x10 /* Simple Extended Content (security/segmentation) */

struct canxl_frame {
       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
       __u8    sdt;   /* SDU (service data unit) type */
       __u8    flags; /* flags for CAN FD and CAN XL */
       __u16   len;   /* frame payload length in byte */
       __u32   af;    /* acceptance field */
       __u8    data[CANXL_MAX_DLEN];
};

This way, the check between CANFD_FDF and CANXL_XLF can be done in any
order. A side benefit is that you do not need a union anymore to check
the frame type.


I say this is a compromise because it adds back the collision between
can{fd,xl}_frame::flags and can_frame::__pad.

Existing applications are exempted from this risk: the
CAN_RAW_XL_FRAMES socket option will prevent the collision from
happening. To summarise, the collision will only occur if below
criteria are met:

  * The user allocates a can_frame without zeroing it (typical use
cases are stack declaration or malloc()).
  * The user activates the CAN_RAW_XL_FRAMES socket option.
  * Garbage value results in can_frame::__pad & CANXL_XLF being set.

So if going in that direction, we would have to update the
documentation (header files and kernel doc) to point at this pitfall
and specify that can_frame::__pad shall always be zeroed for mix
usages.

Personally, I prefer to have the can{fd,xl}_frame::flags aligned. I
foresee that misuses due to bad "if" ordering are more likely to
happen. Zeroing your stack variable is a best practice, developers
with good hygiene are safe. Requiring the two "if" checks in the
correct order is more obscure and more luckily to be misused even with
best intentions.

So here are two solutions, each of them has their benefits and
drawbacks. I vote for aligning the flags. Pick your poison.


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
> --
> 2.30.2
>
