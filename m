Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0A95714DC
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 10:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiGLIkc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 04:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiGLIkY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 04:40:24 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC2A5E77
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 01:40:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 136so12787135ybl.5
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oAK+2NBQYXgMfs9aBfWvMPaDkUicdonbeHoOin2f/eA=;
        b=TEZ3PIIF3OH8YOEtjSgwJWZpNQiY2HYmzWvFcrY+20gpDVclMUfSzeyueipZqNkI9X
         /s9g00G6jK/Cc+xnN9OSmA1kQcJFhpoaGPaIhCQF5Hyio2o1xOOyIsvPh5/Jmk8vI1rW
         1g2q1wg5ExPRBEa+2Px+AsLM1ENPc0QJVRGXJ8yTZYvedQiigTCbTlDiB4HGofJOgT66
         C0UdoLe040GhlqPhP8LtARSbt+bKxiBLOW4G3KBoyqoRc53A8ZIG5vWpqvayu4PAxSUo
         N9j1cr1Fm2JhWR/dtZMLMekaPTymdtKB8y8QRcPlIsgwN6q9wZS8JPCSB3amOX9WsrGA
         QTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oAK+2NBQYXgMfs9aBfWvMPaDkUicdonbeHoOin2f/eA=;
        b=eoRCblK+IF1U5zI7tZzSI6jLJvYFZKgc/3GtzMEd91SlDKtR7+IP6VMlQ/W6D4tTY9
         w4Fl6eEDsajl/zNJ8/YN3U3jTajqbYrCYC1n2L17aCBqTTRQAtQKq5m+1I8tuhl66Ufw
         fGSb9X1sjACkx9oGzo89/B8Ri9L26zTnvlp0QWq6QtisWstT5nuXujn1Mqlmku5/L3sH
         QlE79dvAFUdum++GuQLIuqr1apRbHauNyW65fq5WCXedsIUo/xUMep0fTuBGPfWDmgca
         KFUxEXpxyekBEcRY9D25JiJ0vV8A1XA0jGpNNfNxn2OZ92dWChEEJ3hNAMfYfnNHp6eO
         sHqA==
X-Gm-Message-State: AJIora8nVnE6wsQTjE6OoW/CcxPgWCKYcvQ3LLEKhY1+Tz/mzS2HPF/F
        J4EKAnm4Llyts0Ou9VwTozehxX1fEP6BIlMAsylRmQmKRfk=
X-Google-Smtp-Source: AGRyM1tL7a3h122KEwuWKgJTuWztzfwpqnFf3EKwVTMtJhRooxepM1wHw8gpCwg8NQp+7WUqW/nIYG58OBHWLyEpcA8=
X-Received: by 2002:a5b:f88:0:b0:66e:41d9:5c with SMTP id q8-20020a5b0f88000000b0066e41d9005cmr20590914ybh.142.1657615221642;
 Tue, 12 Jul 2022 01:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-2-socketcan@hartkopp.net> <CAMZ6RqLqDFqdtKsp6jGhnTtWRrf6HC5HiLuJUSCRNkDXqVfCzA@mail.gmail.com>
 <f00a4c5d-c4e6-06a2-76c0-53105d3465f2@hartkopp.net>
In-Reply-To: <f00a4c5d-c4e6-06a2-76c0-53105d3465f2@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Tue, 12 Jul 2022 17:40:10 +0900
Message-ID: <CAMZ6RqLVvYCoBF67VtqUSJHAxBHvEmK2-o8NCD7REZj1ywXf7w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] can: canxl: introduce CAN XL data structure
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

On Tue. 12 juil. 2022 at 16:55, Oliver Hartkopp <socketcan@hartkopp.net> wr=
ote:
> On 12.07.22 02:36, Vincent Mailhol wrote:
> > On Tue. 12 Jul. 2022 at 03:44, Oliver Hartkopp <socketcan@hartkopp.net>=
 wrote:
> >>
> >> This patch adds defines for data structures and length information for
> >> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
> >> byte insinde a single frame.
> >>
> >> Notable changes from CAN FD:
> >>
> >> - the 11 bit arbitration field is now named 'priority' instead of 'can=
_id'
> >>    (there are no 29 bit identifiers nor RTR frames anymore)
> >> - the data length needs a uint16 value to cover up to 2048 byte
> >>    (the length element position is different to struct can[fd]_frame)
> >> - new fields (SDT, AF) and a SEC bit have been introduced
> >> - the virtual CAN interface identifier is not part if the CAN XL frame
> >>    struct as this VCID value is stored in struct skbuff (analog to vla=
n id)
> >>
> >> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >> ---
> >>   include/uapi/linux/can.h | 38 ++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 38 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> >> index 90801ada2bbe..9f97a5d06f3b 100644
> >> --- a/include/uapi/linux/can.h
> >> +++ b/include/uapi/linux/can.h
> >> @@ -58,10 +58,11 @@
> >>
> >>   /* valid bits in CAN ID for frame formats */
> >>   #define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
> >>   #define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
> >>   #define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
> >> +#define CANXL_PRIO_MASK CAN_SFF_MASK /* 11 bit priority mask */
> >>
> >>   /*
> >>    * Controller Area Network Identifier structure
> >>    *
> >>    * bit 0-28    : CAN identifier (11/29 bit)
> >> @@ -71,10 +72,11 @@
> >>    */
> >>   typedef __u32 canid_t;
> >>
> >>   #define CAN_SFF_ID_BITS                11
> >>   #define CAN_EFF_ID_BITS                29
> >> +#define CANXL_PRIO_BITS                CAN_SFF_ID_BITS
> >>
> >>   /*
> >>    * Controller Area Network Error Message Frame Mask structure
> >>    *
> >>    * bit 0-28    : error class mask (see include/uapi/linux/can/error.=
h)
> >> @@ -89,10 +91,18 @@ typedef __u32 can_err_mask_t;
> >>
> >>   /* CAN FD payload length and DLC definitions according to ISO 11898-=
7 */
> >>   #define CANFD_MAX_DLC 15
> >>   #define CANFD_MAX_DLEN 64
> >>
> >> +/*
> >> + * CAN XL payload length and DLC definitions according to ISO 11898-1
> >> + * CAN XL DLC ranges from 0 .. 2047 =3D> data length from 1 .. 2048 b=
yte
> >> + */
> >> +#define CANXL_MAX_DLC 2047
> >> +#define CANXL_MAX_DLC_MASK 0x07FF
> >> +#define CANXL_MAX_DLEN 2048
> >> +
> >>   /**
> >>    * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
> >>    * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t =
definition
> >>    * @len:      CAN frame payload length in byte (0 .. 8)
> >>    * @can_dlc:  deprecated name for CAN frame payload length in byte (=
0 .. 8)
> >> @@ -141,14 +151,20 @@ struct can_frame {
> >>    * When this is done the former differentiation via CAN_MTU / CANFD_=
MTU gets
> >>    * lost. CANFD_FDF allows programmers to mark CAN FD frames in the c=
ase of
> >>    * using struct canfd_frame for mixed CAN / CAN FD content (dual use=
).
> >>    * N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content in=
side of
> >>    * struct canfd_frame therefore the CANFD_FDF flag is disregarded by=
 Linux.
> >> + * Same applies to the CANXL_XLF bit.
> >> + *
> >> + * For CAN XL the SEC bit has been added to the flags field which sha=
res the
> >> + * same position in struct can[fd|xl]_frame.
> >>    */
> >>   #define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payloa=
d data) */
> >>   #define CANFD_ESI 0x02 /* error state indicator of the transmitting =
node */
> >>   #define CANFD_FDF 0x04 /* mark CAN FD for dual use of struct canfd_f=
rame */
> >> +#define CANXL_XLF 0x08 /* mark CAN XL for dual use of struct canfd_fr=
ame */
> >> +#define CANXL_SEC 0x10 /* Simple Extended Content (security/segmentat=
ion) */
> >>
> >>   /**
> >>    * struct canfd_frame - CAN flexible data rate frame structure
> >>    * @can_id: CAN ID of the frame and CAN_*_FLAG flags, see canid_t de=
finition
> >>    * @len:    frame payload length in byte (0 .. CANFD_MAX_DLEN)
> >> @@ -164,12 +180,34 @@ struct canfd_frame {
> >>          __u8    __res0;  /* reserved / padding */
> >>          __u8    __res1;  /* reserved / padding */
> >>          __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
> >>   };
> >>
> >> +/**
> >> + * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame stru=
cture
> >> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
> >> + * @sdt:   SDU (service data unit) type
> >> + * @flags: additional flags for CAN XL
> >> + * @len:   frame payload length in byte (1 .. CANXL_MAX_DLEN)
> >> + * @af:    acceptance field
> >> + * @data:  CAN XL frame payload (up to CANXL_MAX_DLEN byte)
> >> + *
> >> + * @prio shares the same position as @can_id from struct canfd_frame.
> >> + * Same applies to the relative position and length of @flags.
> >> + */
> >> +struct canxl_frame {
> >> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> >> +       __u8    sdt;   /* SDU (service data unit) type */
> >> +       __u8    flags; /* additional flags for CAN XL */
> >> +       __u16   len;   /* frame payload length in byte */
> >> +       __u32   af;    /* acceptance field */
> >> +       __u8    data[CANXL_MAX_DLEN];
> >
> > __u8 data[];
> >
> > 2 kilobytes start to be a significant size. Would it make sense to use
> > a flexible array member to minimize the copies? A bit like the TCP/IP
> > stack where you do not have to allocate the MTU but just what is
> > actually needed for the headers and your payload.
> >
> > Of course this is a tradeoff. It will add some complexity. The first
> > impact is that the skb's data length might be smaller than the MTU and
> > thus any logic using the MTU to differentiate between Classic CAN,
> > CAN-FD or CAN XL would have to be adjusted.
>
> Yes, I've thought about that myself but I wanted a simple start for our
> discussion to think about improvements in the team.
>
> I implemented this first:
>
>   /* Drop a given socketbuffer if it does not contain a valid CAN frame. =
*/
>   bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *sk=
b)
>   {
> -       const struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data=
;
> +       unsigned int len =3D can_get_data_len(skb);

It is premature to use can_get_data_len() here. You have not yet
confirmed the skb=E2=80=99s length so this could be an out of band read.

>          struct can_priv *priv =3D netdev_priv(dev);
>
>          if (skb->protocol =3D=3D htons(ETH_P_CAN)) {
>                  if (unlikely(skb->len !=3D CAN_MTU ||
> -                            cfd->len > CAN_MAX_DLEN))
> +                            len > CAN_MAX_DLEN))
>                          goto inval_skb;
>          } else if (skb->protocol =3D=3D htons(ETH_P_CANFD)) {
>                  if (unlikely(skb->len !=3D CANFD_MTU ||
> -                            cfd->len > CANFD_MAX_DLEN))
> +                            len > CANFD_MAX_DLEN))
> +                       goto inval_skb;
> +       } else if (skb->protocol =3D=3D htons(ETH_P_CANXL)) {
> +               if (unlikely(skb->len < CANXL_MINTU ||
> +                            skb->len > CANXL_MTU ||
> +                            len > CANXL_MAX_DLEN || len =3D=3D 0))
>                          goto inval_skb;
>          } else {
>                  goto inval_skb;
>          }

I suggest this:

  /* Drop a given socket buffer if it does not contain a valid CAN frame. *=
/
  bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
  {
         const struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
+        const struct canxl_frame *cxl =3D (struct canxl_frame *)skb->data;
         struct can_priv *priv =3D netdev_priv(dev);

         if (skb->protocol =3D=3D htons(ETH_P_CAN)) {
                 if (unlikely(skb->len !=3D CAN_MTU ||
                              cfd->len > CAN_MAX_DLEN))
                         goto inval_skb;
         } else if (skb->protocol =3D=3D htons(ETH_P_CANFD)) {
                 if (unlikely(skb->len !=3D CANFD_MTU ||
                              cfd->len > CANFD_MAX_DLEN))
                         goto inval_skb;
+       } else if (skb->protocol =3D=3D htons(ETH_P_CANXL)) {
+               if (unlikely(skb->len < sizeof(struct canxl_frame) ||
+                            skb->len > CANXL_MTU ||
+                            cxl->len > CANXL_MAX_DLEN || cxl->len =3D=3D 0=
))
+                        goto inval_skb;
         } else {
                 goto inval_skb;
         }

Once can_dropped_invalid_skb() succeeds, calls to can_get_data_len()
will be safe.

> +/* truncated CAN XL structs must contain at least 64 data bytes */
> +#define CANXL_MINTU    (CANXL_MTU - CANXL_MAX_DLEN + CANFD_MAX_DLEN)

I did not get the concept of the "truncated CAN XL structs". The valid
data field lengths are 1 to 2048, right? I did not get where this 64
comes from.
Your formula is equivalent to
#define CANXL_MINTU    (sizeof(struct canxl_frame) + CANFD_MAX_DLEN)

I would have just expected:
#define CANXL_MINTU    (sizeof(struct canxl_frame))

Or maybe no macro at all, the sizeof is more explicit to me.

> So the idea was to define a CAN XL skb->len which is clearly above
> CANFD_MTU to distinguish it from the other CAN MTUs.
>
> But as the skbuff is zerocopy inside the kernel,

Inside the kernel yes, but there is still one copy between userspace
and kernel land with the full width.

> it probably makes sense
> to stay with the full CANXL_MTU inside the kernel and allow to crop the
> data structure for CAN_RAW socket interactions from/to user space down
> to CANXL_MINTU ?!?

My guts would tell me to crop it from the initial malloc in userland.
Not sure what would be the impact in terms of performances.

> > Also, are we fine to drop the __attribute__((aligned(8)))? If I
> > understand correctly, we moved from a 8 bytes alignment in struct
> > can(fd)_frame to a 4 bytes alignment in struct canxl_frame.
>
> Yes. I hassled with the alignment too.
>
> The big cool thing about the 64 bit alignment was the filter and
> modification efficiency in bcm.c and gw.c
>
> I wonder if this is still a relevant use case with CAN XL.
>
> Currently the SDU type SDT=3D0x03 defines a Classical CAN and CAN FD
> 'tunneling' for CAN XL (in CiA 611-1 document).
>
> For this SDT=3D0x03 the CAN ID (and EFF/RTR/FD flags) are placed in the A=
F
> element.
>
> And then the first data[0] byte will contain ESI/BRS/DLC and starting
> with data[1] the CAN frame data content will start.
>
> So at least this spec will horribly break and 64 bit access to CAN data
> content.
>
> I've been thinking about creating a 'normal' Classical CAN / CAN FD
> virtual CAN interface that feels for the user like a standard CAN
> interface with struct can[fd]_frame - but inside interacts with CAN XL
> frames with SDT=3D0x03 ...

Here, you lost me. The only reference document I have is the Bosch
presentation you linked in the cover letter. I would need to get a
copy of the specification first to follow up on this level of details.

> Don't know if users really will need such stuff with CAN XL as there are
> other PDU tunneling mechanics already specified.
>
> For that reason I would not take the 64 bit alignment as a strong
> requirement. With the current struct canxl_frame layout the data[] will
> start at a 32 bit boundary.

ACK. The 32 bit alignment is totally acceptable I think. In the worst
case, on 64 bits architecture, when the payload is a perfect multiple
of 64 bits, we might lose a couple of assembly instructions but I
think that would be acceptable.

> At the end I would see CAN XL as some Ethernet implementation with a
> cool arbitration concept from CAN that assures CSMA/C[AR] instead of
> CSMA/CD ;-)
>
> Best regards,
> Oliver
>
> >
> >>
> >> +};
> >> +
> >>   #define CAN_MTU                (sizeof(struct can_frame))
> >>   #define CANFD_MTU      (sizeof(struct canfd_frame))
> >> +#define CANXL_MTU      (sizeof(struct canxl_frame))
> >
> > #define CANXL_MTU      (sizeof(struct canxl_frame) + CANXL_MAX_DLEN)
> >
> >>   /* particular protocols of the protocol family PF_CAN */
> >>   #define CAN_RAW                1 /* RAW sockets */
> >>   #define CAN_BCM                2 /* Broadcast Manager */
> >>   #define CAN_TP16       3 /* VAG Transport Protocol v1.6 */
> >
> >
> > Yours sincerely,
> > Vincent Mailhol
