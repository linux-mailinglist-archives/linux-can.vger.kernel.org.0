Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C415D570EF8
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 02:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiGLAft (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jul 2022 20:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiGLAfs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jul 2022 20:35:48 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3B72B278
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 17:35:47 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c8bb90d09so65759497b3.8
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNfdC+dpoQVA6RWNlZfrGQA87Lc1QIS8xiBb5bnff0Q=;
        b=BHOPGe4fQVBuMMBSy2sC2ISEF69Is6OPdzgfhvGwJhUCSgw+masLswzsU0+BD+38Qu
         mk7S2n02WIh36acYRr7z9PM6zTFG2o8jOiJ4N0qsdj+aJZKm06XyiEhfJOE5BNxYJG/2
         dvLRDstLc3J1QVcPEdC/PptqJoe/2WkGRTtB8psvdMUDV8IoUAmh6fc/J0EyLWrKr1Dw
         /JBAfGhIZH2A72ZnJKWbAe8h4bKv6RzsoEbzNeiGp2Pmqgjud50XTATUM0T2cnj1YI5B
         Tt8huDxdZfd2RBe3Nz4g1TxXp3/YY3r+2ogaTsTPm08OGzMxrDEcotV9AnizhLlgAkbj
         2Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNfdC+dpoQVA6RWNlZfrGQA87Lc1QIS8xiBb5bnff0Q=;
        b=Udjdmem8OarOjhMWe2QjdbWDSUjpYtHMuLdSO1SYXJWdUad89mkb4N3XkGB4GL5A6i
         wTWLREslKKUZNnt5+Ul+segguEn5Fj9cTzE7gQZH/YXkETG2P5lWriiZrG2e1YGjJaos
         Ly/MIM8TB6ni9X3wS5NQYTci1LBfP/j18QHsYCqmEJpaRdW+wKvUkTHXSSPkGmJZ0WsP
         uNRx6xXIUOuUJkJK3OhIXKs8Fex0SEt2doNWoa/qCWpNg4PILndIGazj1Fyy9ZivuqPj
         v/432FnxXpbVeM/l69HIiRTdwM09y2wvRSaLG7TKzfQWx2OfQ6JePkDVr0KiPi5yVbP4
         zcAA==
X-Gm-Message-State: AJIora8iVGat+8dqtdL4LFrweX53HwX2t6WOxynYdmpZZa+CNyOmqiMf
        mDvhzODCBW6thIltaDNNB6XcHn0N5fnly45JISbuSweVIrw=
X-Google-Smtp-Source: AGRyM1sUX3bNaykgUP8DgUxy0+DPNi/6ez4sL80kv+CfCHUqyYYcdQ6hpyZX4WspV2CJ5oWFOVDMbpEVEUdb3w8uXnY=
X-Received: by 2002:a0d:f285:0:b0:31b:c2d6:2ce9 with SMTP id
 b127-20020a0df285000000b0031bc2d62ce9mr23242628ywf.172.1657586146826; Mon, 11
 Jul 2022 17:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220711183426.96446-1-socketcan@hartkopp.net> <20220711183426.96446-2-socketcan@hartkopp.net>
In-Reply-To: <20220711183426.96446-2-socketcan@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Tue, 12 Jul 2022 09:36:00 +0900
Message-ID: <CAMZ6RqLqDFqdtKsp6jGhnTtWRrf6HC5HiLuJUSCRNkDXqVfCzA@mail.gmail.com>
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

On Tue. 12 Jul. 2022 at 03:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> This patch adds defines for data structures and length information for
> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
> byte insinde a single frame.
>
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
>  include/uapi/linux/can.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 90801ada2bbe..9f97a5d06f3b 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -58,10 +58,11 @@
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
> @@ -71,10 +72,11 @@
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
> @@ -89,10 +91,18 @@ typedef __u32 can_err_mask_t;
>
>  /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
>  #define CANFD_MAX_DLC 15
>  #define CANFD_MAX_DLEN 64
>
> +/*
> + * CAN XL payload length and DLC definitions according to ISO 11898-1
> + * CAN XL DLC ranges from 0 .. 2047 => data length from 1 .. 2048 byte
> + */
> +#define CANXL_MAX_DLC 2047
> +#define CANXL_MAX_DLC_MASK 0x07FF
> +#define CANXL_MAX_DLEN 2048
> +
>  /**
>   * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
>   * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
>   * @len:      CAN frame payload length in byte (0 .. 8)
>   * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
> @@ -141,14 +151,20 @@ struct can_frame {
>   * When this is done the former differentiation via CAN_MTU / CANFD_MTU gets
>   * lost. CANFD_FDF allows programmers to mark CAN FD frames in the case of
>   * using struct canfd_frame for mixed CAN / CAN FD content (dual use).
>   * N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside of
>   * struct canfd_frame therefore the CANFD_FDF flag is disregarded by Linux.
> + * Same applies to the CANXL_XLF bit.
> + *
> + * For CAN XL the SEC bit has been added to the flags field which shares the
> + * same position in struct can[fd|xl]_frame.
>   */
>  #define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
>  #define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
>  #define CANFD_FDF 0x04 /* mark CAN FD for dual use of struct canfd_frame */
> +#define CANXL_XLF 0x08 /* mark CAN XL for dual use of struct canfd_frame */
> +#define CANXL_SEC 0x10 /* Simple Extended Content (security/segmentation) */
>
>  /**
>   * struct canfd_frame - CAN flexible data rate frame structure
>   * @can_id: CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
>   * @len:    frame payload length in byte (0 .. CANFD_MAX_DLEN)
> @@ -164,12 +180,34 @@ struct canfd_frame {
>         __u8    __res0;  /* reserved / padding */
>         __u8    __res1;  /* reserved / padding */
>         __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
>  };
>
> +/**
> + * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
> + * @sdt:   SDU (service data unit) type
> + * @flags: additional flags for CAN XL
> + * @len:   frame payload length in byte (1 .. CANXL_MAX_DLEN)
> + * @af:    acceptance field
> + * @data:  CAN XL frame payload (up to CANXL_MAX_DLEN byte)
> + *
> + * @prio shares the same position as @can_id from struct canfd_frame.
> + * Same applies to the relative position and length of @flags.
> + */
> +struct canxl_frame {
> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> +       __u8    sdt;   /* SDU (service data unit) type */
> +       __u8    flags; /* additional flags for CAN XL */
> +       __u16   len;   /* frame payload length in byte */
> +       __u32   af;    /* acceptance field */
> +       __u8    data[CANXL_MAX_DLEN];

__u8 data[];

2 kilobytes start to be a significant size. Would it make sense to use
a flexible array member to minimize the copies? A bit like the TCP/IP
stack where you do not have to allocate the MTU but just what is
actually needed for the headers and your payload.

Of course this is a tradeoff. It will add some complexity. The first
impact is that the skb's data length might be smaller than the MTU and
thus any logic using the MTU to differentiate between Classic CAN,
CAN-FD or CAN XL would have to be adjusted.

Also, are we fine to drop the __attribute__((aligned(8)))? If I
understand correctly, we moved from a 8 bytes alignment in struct
can(fd)_frame to a 4 bytes alignment in struct canxl_frame.

>
> +};
> +
>  #define CAN_MTU                (sizeof(struct can_frame))
>  #define CANFD_MTU      (sizeof(struct canfd_frame))
> +#define CANXL_MTU      (sizeof(struct canxl_frame))

#define CANXL_MTU      (sizeof(struct canxl_frame) + CANXL_MAX_DLEN)

>  /* particular protocols of the protocol family PF_CAN */
>  #define CAN_RAW                1 /* RAW sockets */
>  #define CAN_BCM                2 /* Broadcast Manager */
>  #define CAN_TP16       3 /* VAG Transport Protocol v1.6 */


Yours sincerely,
Vincent Mailhol
