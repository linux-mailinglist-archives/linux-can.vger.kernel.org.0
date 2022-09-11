Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00FB5B4C88
	for <lists+linux-can@lfdr.de>; Sun, 11 Sep 2022 09:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIKHuc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 11 Sep 2022 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIKHub (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 11 Sep 2022 03:50:31 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E295F32BA7
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 00:50:29 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p69so1848807yba.0
        for <linux-can@vger.kernel.org>; Sun, 11 Sep 2022 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=cxs+O1Vg4MdZf+g1zbEv7xcuTsToUymeBJPnN9pi0YU=;
        b=FN/8dfjkQCloLIQrux2KGLDB5qvURITTO9ONDpE7FN7WmNoxJwazOz7v9jNoytDB3p
         raFZa8AHKHRdHYe+x7ngXdROFDC3xGZ6E2DufYQzDAvTyayDepol9BHvV2qxJZ+W4sAq
         LoeDXQFENYWb0OlQzvphtbgjC+wIKQsrKWH/tuNoudXSxNmFptipYoseubTbD74wDPQk
         vRnY2hZwYA3wj3TOYQQItYByDlL9OZv5fvo90g3rOW3kJ6BrNbBHHLRReG1YbSBUEteS
         OO83FPS346gwFjfKZgYKP6YRaSfv/4fwYGSc5i9xBLV8WXWnaMu0pLdaZJ/WRxwQHgWM
         OHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cxs+O1Vg4MdZf+g1zbEv7xcuTsToUymeBJPnN9pi0YU=;
        b=RQgp67llv052bgSp4sU3zW+r3eATjljM7tGAIpsCaWxqydTJtvtKQRHyf2buU7qWeK
         XIbhPzYGuMKl1XbbMHHjSI5BfLV4oGB7axwN5Sv7s5zVTq3Lxu+eVRmQ5Tg+HDKBy6s6
         av5EzclExZqQsflTYIpo5koyZfLcIR9bTSyaVsvfqghjZak9H5gKdq3/jDk6q3K/paBe
         kZgjwqPTKqNGz7xl1GubZim7k06DLulQ5GkDQ/WsnsFJxKZcjuMcEVERLJ4RRuNnU1Fe
         Q129mzPUp3asYFGskWQ1mrTOp9GjpjeMepEmwrh47Qzrm7AX489GOJmkEKdEVFA4YP3Y
         wKwA==
X-Gm-Message-State: ACgBeo2/17CJTWRJmixvHBN2xcrBILP8bay7uJ1f3e2nOMTwihKNW9X5
        LiIyfPNWXyJ7LUn8OIRGxqWgvMyrwwAcIX/IoeoqCx9E
X-Google-Smtp-Source: AA6agR6r+722BjubiE9+owP23tORYa39u+SFwjyyUKGoZAJLjHjKKvjnDh2Ux2WBp+yPDfdWXhapIAzbYACkvYQx2OU=
X-Received: by 2002:a25:9888:0:b0:6ae:b84f:1004 with SMTP id
 l8-20020a259888000000b006aeb84f1004mr3711719ybo.20.1662882628796; Sun, 11 Sep
 2022 00:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220801190010.3344-1-socketcan@hartkopp.net> <20220801190010.3344-5-socketcan@hartkopp.net>
 <CAMZ6RqKFNY1y9XpsLU6cjs_TmnYBjjDin6LHn5TRpm5m4w2ewg@mail.gmail.com>
 <414e2a33-0091-11fc-70db-a87331addff8@hartkopp.net> <f79f729c-01eb-2121-e315-a240357d2eb0@hartkopp.net>
In-Reply-To: <f79f729c-01eb-2121-e315-a240357d2eb0@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sun, 11 Sep 2022 16:50:17 +0900
Message-ID: <CAMZ6RqL=ZqBUSA8xGQW1jMU8fwduz11_HJcFjerPtO8ZUAVdiw@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] can: canxl: introduce CAN XL data structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
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

On Thu. 8 Sep. 2022 at 16:24, Oliver Hartkopp <socketcan@hartkopp.net> wrot=
e:
> Hi Vincent,
>
> any update on this or are you fine with the patch set now?

Sorry for the delay, a lot of personal priorities the last two weeks.

> Best regards,
> Oliver
>
> On 02.09.22 15:56, Oliver Hartkopp wrote:
> > Hi Vincent,
> >
> > On 02.09.22 08:19, Vincent Mailhol wrote:
> >> Sorry for the late reply, I am back from holidays. My previous review
> >> was a best effort review.
> >
> > Hope you had good holidays ;-)

Really great holidays, except maybe for the finale in which I caught
COVID and had to reschedule my flight back.

> >> Since then, I took time to read the CiA=E2=80=99s CAN knowledge pages =
of CAN XL:
> >> https://www.can-cia.org/can-knowledge/can/can-xl/
> >> and have a few newer comments.
> >>
> >> Unfortunately, I still do not have access to the full specification,
> >> so please forgive if there are some silly remarks.
> >
> > I think the short introduction to CAN XL from the cover letter fits
> > quite good.
> >
> > https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/ca=
nxl_intro_20210225.pdf

This page now returns error 404.

> >> On Tue. 2 Aug 2022 at 04:02, Oliver Hartkopp <socketcan@hartkopp.net>
> >> wrote:
> >>> This patch adds defines for data structures and length information fo=
r
> >>> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
> >>> byte inside a single frame.
> >>>
> >>> Notable changes from CAN FD:
> >>>
> >>> - the 11 bit arbitration field is now named 'priority' instead of
> >>> 'can_id'
> >>>    (there are no 29 bit identifiers nor RTR frames anymore)
> >>> - the data length needs a uint16 value to cover up to 2048 byte
> >>>    (the length element position is different to struct can[fd]_frame)
> >>> - new fields (SDT, AF) and a SEC bit have been introduced
> >>> - the virtual CAN interface identifier is not part if the CAN XL fram=
e
> >>>    struct as this VCID value is stored in struct skbuff (analog to
> >>> vlan id)
> >
> > Did you note this?
> >
> > Because you asked about the VCID later.
> >
> > There is an existing Kernel API to handle VLAN-like ID stuff. And we
> > should simply use that existing mechanic as it has the same intention
> > and handling for CAN XL.

ACK.
Thanks.

> >>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>> ---
> >>>   include/uapi/linux/can.h | 51 +++++++++++++++++++++++++++++++++++++=
+++
> >>>   1 file changed, 51 insertions(+)
> >>>
> >>> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> >>> index 7b23eeeb3273..dd645ea72306 100644
> >>> --- a/include/uapi/linux/can.h
> >>> +++ b/include/uapi/linux/can.h
> >>> @@ -46,10 +46,11 @@
> >>>   #ifndef _UAPI_CAN_H
> >>>   #define _UAPI_CAN_H
> >>>
> >>>   #include <linux/types.h>
> >>>   #include <linux/socket.h>
> >>> +#include <linux/stddef.h> /* for offsetof */
> >>>
> >>>   /* controller area network (CAN) kernel definitions */
> >>>
> >>>   /* special address description flags for the CAN_ID */
> >>>   #define CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
> >>> @@ -58,10 +59,11 @@
> >>>
> >>>   /* valid bits in CAN ID for frame formats */
> >>>   #define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
> >>>   #define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
> >>>   #define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
> >>> +#define CANXL_PRIO_MASK CAN_SFF_MASK /* 11 bit priority mask */
> >>>
> >>>   /*
> >>>    * Controller Area Network Identifier structure
> >>>    *
> >>>    * bit 0-28    : CAN identifier (11/29 bit)
> >>> @@ -71,10 +73,11 @@
> >>>    */
> >>>   typedef __u32 canid_t;
> >>>
> >>>   #define CAN_SFF_ID_BITS                11
> >>>   #define CAN_EFF_ID_BITS                29
> >>> +#define CANXL_PRIO_BITS                CAN_SFF_ID_BITS
> >>>
> >>>   /*
> >>>    * Controller Area Network Error Message Frame Mask structure
> >>>    *
> >>>    * bit 0-28    : error class mask (see include/uapi/linux/can/error=
.h)
> >>> @@ -89,10 +92,20 @@ typedef __u32 can_err_mask_t;
> >>>
> >>>   /* CAN FD payload length and DLC definitions according to ISO
> >>> 11898-7 */
> >>>   #define CANFD_MAX_DLC 15
> >>>   #define CANFD_MAX_DLEN 64
> >>>
> >>> +/*
> >>> + * CAN XL payload length and DLC definitions according to ISO 11898-=
1
> >>> + * CAN XL DLC ranges from 0 .. 2047 =3D> data length from 1 .. 2048 =
byte
> >>> + */
> >>> +#define CANXL_MIN_DLC 0
> >>> +#define CANXL_MAX_DLC 2047
> >>> +#define CANXL_MAX_DLC_MASK 0x07FF
> >>> +#define CANXL_MIN_DLEN 1
> >>> +#define CANXL_MAX_DLEN 2048
> >>> +
> >>>   /**
> >>>    * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
> >>>    * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t
> >>> definition
> >>>    * @len:      CAN frame payload length in byte (0 .. 8)
> >>>    * @can_dlc:  deprecated name for CAN frame payload length in byte
> >>> (0 .. 8)
> >>> @@ -164,12 +177,50 @@ struct canfd_frame {
> >>>          __u8    __res0;  /* reserved / padding */
> >>>          __u8    __res1;  /* reserved / padding */
> >>>          __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
> >>>   };
> >>>
> >>> +/*
> >>> + * defined bits for canxl_frame.flags
> >>> + *
> >>> + * The canxl_frame.flags element contains two bits CANXL_XLF and
> >>> CANXL_SEC
> >>> + * and shares the relative position of the struct can[fd]_frame.len
> >>> element.
> >>> + * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN
> >>> XL frame.
> >>> + * As a side effect setting this bit intentionally breaks the length
> >>> checks
> >>> + * for Classical CAN and CAN FD frames.
> >>> + *
> >>> + * Undefined bits in canxl_frame.flags are reserved and shall be set
> >>> to zero.
> >>> + */
> >>> +#define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always
> >>> be set!) */
> >>> +#define CANXL_SEC 0x01 /* Simple Extended Content
> >>> (security/segmentation) */
> >>
> >> Are we sure that no other flags are needed? The CiA can-knowledge
> >> mentions a FTYP (frame type) flag. Do you know what it is?
> >
> > The LLC frame fields in
> > https://www.can-cia.org/can-knowledge/can/can-xl/ are a mix(!) of
> > Classical CAN, CAN FD and CAN XL content (e.g. ESI is only CAN FD).
> >
> > The frame type flags an abstraction of
> > (none) -> Classical CAN
> > (FDF) -> CAN FD
> > (XLF) -> CAN XL

Now, I am curious how the LLC frame format will be able to
differentiate between three types (Classic, FD, XL) using a single
bit. But noted for the explanation.
But this doesn't impact Linux SocketCAN.

> >>> +
> >>> +/**
> >>> + * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame
> >>> structure
> >>> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
> >>> + * @flags: additional flags for CAN XL
> >>> + * @sdt:   SDU (service data unit) type
> >>> + * @len:   frame payload length in byte (CANXL_MIN_DLEN ..
> >>> CANXL_MAX_DLEN)
> >>> + * @af:    acceptance field
> >>> + * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN by=
te)
> >>> + *
> >>> + * @prio shares the same position as @can_id from struct can[fd]_fra=
me.
> >>> + */
> >>> +struct canxl_frame {
> >>> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) *=
/
> >>
> >> Does it make sense to keep the canid_t? The addressing is done through
> >> both the prio and the af fields. Also, the CAN_EFF_FLAG, CAN_RTR_FLAG
> >> and CAN_ERR_FLAG flags do not apply anymore. Finally, the prio is only
> >> 11 bits, no need to reserve 32 bits for it.
> >
> > The CAN-ID was (due to its arbitration nature) always also a priority
> > field.

The CAN-(FD) ID holds two roles: priority and ID. For CAN XL, it is
only ID. While I agree that both have the priority attributes, my
concerns are on the semantics. The type is canid_t, not canprio_t. I
just want to point that it is weird to had ID in the type when that
field doesn't have an ID property anymore.

> > So nothing changed here. There is no RTR and no 29-bit priority anymore
> > now. The RTR flag has already been disabled for CAN FD (see presentatio=
n
> > at the end of this mail).
> >
> > Therefore it makes sense to handle the SFF 11-bit prio analogue to the
> > former CAN-ID - and also use canid_t to simply keep the entire CAN
> > filter handling in af_can.c !

This is a good argument to keep using the canid_t. If we make it a
u16, we lose the alignment (unless we add dirty endianness
preprocessing macros).

> > The new idea in CAN XL is to split the priority from the content
> > identification which has been named 'acceptance field' (AC).
> >
> > The functionality of AC depends on SDT. Don't know how this will work
> > out in the future and if we would provide some AF-specific filtering
> > inside the kernel.

Thanks for the explanation, ACK.

> >>
> >> Of course, if we declare it as 16 bits, we need to add some padding so
> >> that the other flags remain at the same offset.
> >
> > Answered above.
> >
> >>> +       __u8    flags; /* additional flags for CAN XL */
> >>> +       __u8    sdt;   /* SDU (service data unit) type */
> >>> +       __u16   len;   /* frame payload length in byte */
> >>> +       __u32   af;    /* acceptance field */
> >>> +       __u8    data[CANXL_MAX_DLEN];
> >>> +};
> >>
> >> The CiA CAN knowledge also mentions a VCID (virtual CAN network ID).
> >> Is this not needed?
> >
> > Answered above.

ACK.

> >>> +
> >>>   #define CAN_MTU                (sizeof(struct can_frame))
> >>>   #define CANFD_MTU      (sizeof(struct canfd_frame))
> >>> +#define CANXL_MTU      (sizeof(struct canxl_frame))
> >>> +#define CANXL_HDR_SIZE (offsetof(struct canxl_frame, data))
> >>> +#define CANXL_MIN_MTU  (CANXL_HDR_SIZE + 64)
> >>> +#define CANXL_MAX_MTU  CANXL_MTU
> >>>
> >>>   /* particular protocols of the protocol family PF_CAN */
> >>>   #define CAN_RAW                1 /* RAW sockets */
> >>>   #define CAN_BCM                2 /* Broadcast Manager */
> >>>   #define CAN_TP16       3 /* VAG Transport Protocol v1.6 */
> >>
> >> CAN XL has a resXL flag, suggesting that there may be a fourth
> >> generation of the CAN protocol. One issue in the initial socket CAN
> >> design is that we never reserved a flag for future versions. Here, we
> >> are lucky that the bit 0x80 of the length field is never set.
> >> Back to CAN XL, I would like to discuss how we will distinguish the
> >> CAN GEN4 frames from the CAN XL ones so that we do not find ourselves
> >> stuck in a couple of years because no bits are left to differentiate
> >> things.
> >>
> >> One solution would be to set the two most significant bit:
> >> #define CAN_GEN4 0xC0
> >>
> >> and the test would be:
> >> if (cf.flags & CAN_GEN4 =3D=3D CAN_GEN4)
> >
> > Please do not mix up (incompatible) extensions that have been
> > implemented in the CAN protocol through the 'wandering' reserved bit
> > (r0, now resXL) with the CAN(FD/XL) data structure.
> >
> > The first suggestion for a CAN frame data structure representation in
> > IEEE 1722 contained the entire bitstream definition including the IDE
> > bit. That splitted the 11 and 18 bits of the CAN ID inside the data
> > structure :-D
> >
> > I really think, that the journey is ending with CAN XL and when there
> > would be really a new improvement, we will take a look at it. E.g. by
> > extending the CAN XL flags from the top down (as you suggested with 0xC=
0).
> >
> > But who knows how much of the CAN XL frame layout would be re-used by
> > CAN XY ?? =C2=AF\_(=E3=83=84)_/=C2=AF
> >
> > Btw. I uploaded a presentation which shows the way from classical CAN t=
o
> > CAN XL which might depict some relations of the bits in a clearer way:
> >
> > https://github.com/linux-can/can-doc/blob/master/presentations/CAN-XL-I=
ntro.pdf

Thanks. With the Bosch PDF now returning error 404, I suggest
replacing the link in the cover letter with your link (or the CIA
knowledge page).


Yours sincerely,
Vincent Mailhol
