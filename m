Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D79585A90
	for <lists+linux-can@lfdr.de>; Sat, 30 Jul 2022 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiG3NQs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 30 Jul 2022 09:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiG3NQr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 30 Jul 2022 09:16:47 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6B315FD1
        for <linux-can@vger.kernel.org>; Sat, 30 Jul 2022 06:16:45 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31d85f82f0bso73813007b3.7
        for <linux-can@vger.kernel.org>; Sat, 30 Jul 2022 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=If72mUF4LjPrHl2ARfADa/iDXDiW7ufBs9/wmqhoQ6w=;
        b=p15qzBX7zYWazSDL25AyyJdpcXxXONlK2rQ2/x4pBnkBIgEb5iEdxuDfXGR1Sc29WN
         lLdSNDAcfiJJ8Nqpyz2RLhTExu1XR9xfkcjuuBUFvJ+kbMNQWl7lS4ZxCReRJlqsf+4F
         7JCOuIrl38Xii351Jdw3BoYGJZCco+sPrYlycYZ4t/dy8KSZvliZjl7lWEw6rSmBKkbQ
         TMKVHZohVduM5WggTSr5mBHfoihQrEZnQckIjLYou4ZWdEYoygqeqOliwD8ljc56DGTr
         M9Dg6iGdybGX2yjwFxVOYZ5/AuRru/F5Wc0ccRHmVAI5QfyHeFggr6sKsJJXolpi8nN4
         DkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=If72mUF4LjPrHl2ARfADa/iDXDiW7ufBs9/wmqhoQ6w=;
        b=onV7tEgptqdmjw8KW4lM51nV6AY8/O4Kr3nD9Q6CMgY2nRoAxp5geOk8dzo2b84h4r
         os9XKjQOTV2sn3B+tE3z59D4TkbAYdlSrhlZrw07f/I42HvCG97EbhC6tTtQTdeUshfx
         T9abe+Pbqn7ckSvR1QPcE7OEatTaUWD70CIW/tICUIjMyhPPnxwp7WOrdTrjqSW+M2+u
         yFSkxXLeYTXcNYmgmtZ29XTgTamIhCbBZ8ZsH0Ix1RI61VKuHZAxVTYSie43jO3nA71u
         biorFYhOA5qxXLy55NcesAmdrqm7/qVl7WYPQS2SCVs+cdFVG+idjqjT8QP9y9urssIw
         WH7Q==
X-Gm-Message-State: ACgBeo0+MwxydJqNeJQHB8xGoAzCi5NPhJS7I4hDZVPbuc5wM1LkRbZP
        LcA/t4GY4IudXYuaEDbldUHb5lzKJJ9ta5Egap0tJsM5iYhHIg==
X-Google-Smtp-Source: AA6agR7Sli1q5biI8y1v8CFOWgRV5fdYIOQ8dsBu3yDlsGSGWH+v4ljtiv40EGMACSvVx8aHrMuE2C8poer7BRVrUaU=
X-Received: by 2002:a81:5043:0:b0:323:d0ef:9184 with SMTP id
 e64-20020a815043000000b00323d0ef9184mr6925545ywb.78.1659187004927; Sat, 30
 Jul 2022 06:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220729154107.1875-1-socketcan@hartkopp.net> <20220729154107.1875-5-socketcan@hartkopp.net>
 <CAMZ6RqKMtoo56OtaYG7Quoky+95hvfQaiFi+nDqez=+hMUMhHg@mail.gmail.com> <c2bf9e37-3c52-559a-a76c-b1cf99b0d698@hartkopp.net>
In-Reply-To: <c2bf9e37-3c52-559a-a76c-b1cf99b0d698@hartkopp.net>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 30 Jul 2022 22:16:33 +0900
Message-ID: <CAMZ6RqL5_WxgT4iJy5tKW1PUBGSCr9R+YbMqVxrTiGSRV+7bCg@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] can: canxl: introduce CAN XL data structure
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
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

On Sat. 30 juil. 2022 at 21:06, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Vincent,
>
> On 30.07.22 04:13, Vincent Mailhol wrote:
> > On Sat. 30 Jul. 2022 at 00:42, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >> This patch adds defines for data structures and length information for
> >> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
> >> byte insinde a single frame.
> >         ^^^^^^^
> > inside
>
> ok. Thx.
>
> @Marc: Should I send an updated series or would you fix this typo while
> committing the patch?
>
> >
> >> Notable changes from CAN FD:
> >>
> >> - the 11 bit arbitration field is now named 'priority' instead of 'can_id'
> >>    (there are no 29 bit identifiers nor RTR frames anymore)
> >> - the data length needs a uint16 value to cover up to 2048 byte
> >>    (the length element position is different to struct can[fd]_frame)
> >> - new fields (SDT, AF) and a SEC bit have been introduced
> >> - the virtual CAN interface identifier is not part if the CAN XL frame
> >>    struct as this VCID value is stored in struct skbuff (analog to vlan id)
> >>
> >> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >> ---
> >>   include/uapi/linux/can.h | 51 ++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 51 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> >> index 7b23eeeb3273..dd645ea72306 100644
> >> --- a/include/uapi/linux/can.h
> >> +++ b/include/uapi/linux/can.h
> >> @@ -46,10 +46,11 @@
> >>   #ifndef _UAPI_CAN_H
> >>   #define _UAPI_CAN_H
> >>
> >>   #include <linux/types.h>
> >>   #include <linux/socket.h>
> >> +#include <linux/stddef.h> /* for offsetof */
> >>
> >>   /* controller area network (CAN) kernel definitions */
> >>
> >>   /* special address description flags for the CAN_ID */
> >>   #define CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
> >> @@ -58,10 +59,11 @@
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
> >> @@ -71,10 +73,11 @@
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
> >>    * bit 0-28    : error class mask (see include/uapi/linux/can/error.h)
> >> @@ -89,10 +92,20 @@ typedef __u32 can_err_mask_t;
> >>
> >>   /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
> >>   #define CANFD_MAX_DLC 15
> >>   #define CANFD_MAX_DLEN 64
> >>
> >> +/*
> >> + * CAN XL payload length and DLC definitions according to ISO 11898-1
> >> + * CAN XL DLC ranges from 0 .. 2047 => data length from 1 .. 2048 byte
> >> + */
> >> +#define CANXL_MIN_DLC 0
> >> +#define CANXL_MAX_DLC 2047
> >> +#define CANXL_MAX_DLC_MASK 0x07FF
> >> +#define CANXL_MIN_DLEN 1
> >> +#define CANXL_MAX_DLEN 2048
> >> +
> >>   /**
> >>    * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
> >>    * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
> >>    * @len:      CAN frame payload length in byte (0 .. 8)
> >>    * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
> >> @@ -164,12 +177,50 @@ struct canfd_frame {
> >>          __u8    __res0;  /* reserved / padding */
> >>          __u8    __res1;  /* reserved / padding */
> >>          __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
> >>   };
> >>
> >> +/*
> >> + * defined bits for canxl_frame.flags
> >> + *
> >> + * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_SEC
> >> + * and shares the relative position of the struct can[fd]_frame.len element.
> >> + * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL frame.
> >> + * As a side effect setting this bit intentionally breaks the length checks
> >> + * for Classical CAN and CAN FD frames.
> >> + *
> >> + * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
> >> + */
> >> +#define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
> >> +#define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
> >> +
> >> +/**
> >> + * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
> >> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
> >> + * @flags: additional flags for CAN XL
> >> + * @sdt:   SDU (service data unit) type
> >> + * @len:   frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
> >> + * @af:    acceptance field
> >> + * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
> >> + *
> >> + * @prio shares the same position as @can_id from struct can[fd]_frame.
> >> + */
> >> +struct canxl_frame {
> >> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> >> +       __u8    flags; /* additional flags for CAN XL */
> >> +       __u8    sdt;   /* SDU (service data unit) type */
> >> +       __u16   len;   /* frame payload length in byte */
> >> +       __u32   af;    /* acceptance field */
> >> +       __u8    data[CANXL_MAX_DLEN];
> >> +};
> >
> > I read the previous threads from the start and there is one point
> > which, I think, did not get enough attention.
> >
> > With the current proposal, there is one pitfall on the user side. A
> > correct way to differentiate between the Classical CAN, CAN-FD and
> > CAN-XL would be, as discussed:
> >
> > union {
> >           struct can_frame cc;
> >           struct canfd_frame fd;
> >           struct canxl_frame xl;
> > } can;
> >
> > nbytes = read(s, &can.xl, sizeof(struct canxl_frame));
> >
> > if (can.xl.flags & CANXL_XLF)
> >      /* Handle CAN XL frame */
> > else if (can.fd.flags & CANFD_FDF) /* or equivalent: if (nbytes == CANFD_MTU) */
> >      /* Handle CAN FD frame */
> > else
> >         /* Handle Classic CAN frame */
> >
> > However, it becomes incorrect if the order is changed:
> >
> > if (can.fd.flags & CANFD_FDF) /* or equivalent: if (nbytes == CANFD_MTU) */
>
> No. The point is, that you might have a CAN XL frame with a data length
> of 60 which becomes (when adding the CANXL_HDR_SIZE) 72 which is CANFD_MTU.
>
> For that reason the distinction for CAN XL frames (and the 'old' stuff) is
>
>      if (can.xl.flags & CANXL_XLF) {}
>
> in the first place.

When I write "it becomes incorrect if..." the following example is
obviously incorrect. No need to point out that my misuse illustration
is a misuse.

I fully understand the nuance as I am the one who initially proposed
to use the 0x80 flag to differentiate between CAN XL and CAN(-FD):
https://lore.kernel.org/linux-can/CAMZ6RqLSHAdB-ocj7=74zJqWbv-EH9x8X5ARPK6Gv+FFiTZ7Lg@mail.gmail.com/
(The only difference was that I proposed to name it
CANXL_DISCRIMINATOR instead of CANXL_XLF)

But will all the users understand this nuance? What if someone doesn't
put the CANXL_XLF check in the first place? It is a bug.

> >      /* can.fd.flags can collide with can.xl.sdt,  */
> >      /* nbytes == CANFD_MTU would also collide if the CAN XL frame
> > length is 32 bytes  */
              ^^
Here, I meant 60 bytes.
> > else if (can.xl.flags & CANXL_XLF)
> >      /* Handle CAN XL frame */
> > else
> >         /* Handle Classic CAN frame */
> >
> > I see this as a big pitfall.
> >
> >
> >
> > A solution (or rather a compromise) would be to align the flags fields
> > between the canfd_frame and canxl_frame.
> >
> > #define CANXL_XLF 0x08 /* mandatory CAN XL frame flag (must always be set!) */
> > #define CANXL_SEC 0x10 /* Simple Extended Content (security/segmentation) */
> >
> > struct canxl_frame {
> >         canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> >         __u8    sdt;   /* SDU (service data unit) type */
> >         __u8    flags; /* flags for CAN FD and CAN XL */
> >         __u16   len;   /* frame payload length in byte */
> >         __u32   af;    /* acceptance field */
> >         __u8    data[CANXL_MAX_DLEN];
> > };
> >
> > This way, the check between CANFD_FDF and CANXL_XLF can be done in any
> > order. A side benefit is that you do not need a union anymore to check
> > the frame type.
>
> This has no impact on the union. When you write code that is able to
> cope with all three CAN frame types you need this kind of union, right?

I am thinking of this:

void handle_cxl(canxl_frame *cxl)
{
    /* ... */
}

void handle_cfd(canfd_frame *cfd)
{
    /* ... */
}

void handle_cc(can_frame *cc)
{
    /* ... */
}

int main()
{
    /* ... */

    if (cxl.flags & CANXL_XLF)
        handle_cxl(&cxl);
    else if (cxl.flags & CANFD_FDF)
        handle_cfd((canfd_frame *)&cxl);
    else
        handle_cc((can_frame *)&cxl);

    /* ... */
}

No union needed.

> > I say this is a compromise because it adds back the collision between
> > can{fd,xl}_frame::flags and can_frame::__pad.
> >
> > Existing applications are exempted from this risk: the
> > CAN_RAW_XL_FRAMES socket option will prevent the collision from
> > happening. To summarise, the collision will only occur if below
> > criteria are met:
> >
> >    * The user allocates a can_frame without zeroing it (typical use
> > cases are stack declaration or malloc()).
> >    * The user activates the CAN_RAW_XL_FRAMES socket option.
> >    * Garbage value results in can_frame::__pad & CANXL_XLF being set.
> >
> > So if going in that direction, we would have to update the
> > documentation (header files and kernel doc) to point at this pitfall
> > and specify that can_frame::__pad shall always be zeroed for mix
> > usages.
>
> But you would add this recommendation to a *very late point* - namely
> after 14 years of SocketCAN in the mainline kernel.
>
> If you think about the rule "never break user space" I wonder if the
> risk turns out to be higher when people enable CAN_RAW_XL_FRAMES ("as
> seen on Stackoverflow") and not read the kernel doc recommendations to
> review/update their existing code.

In which aspect does this break the user space? It doesn't.
Enabling CAN_RAW_XL_FRAMES marks a clear transition between the 14
years old Classical CAN API and the new use case of mixed CAN(-FD) and
CAN XL frames.
For the issue to occur, developers have to incorrectly modify their
application, I do not call this a break in user space if only the
yet-to-be-created programs are impacted.

The argument that people do not read the kernel doc apply to both
cases: some people will not initialise variables, some people will not
do the "if" checks in the right order.

> With the current layout it can be clearly stated that after enabling
> CAN_RAW_XL_FRAMES you will be able to detect CAN XL frames with
>
> if (can.xl.flags & CANXL_XLF) {}
>
> And if this bit is not set you can check for the old stuff (CAN FD and
> Classical CAN).

What makes you think that people will fully understand this and not misuse it?

> The good thing about having can[fd]_frame::len and canxl_frame::flags at
> the same location is that this field is (and was!) *always* set (==
> initialized) properly. No potential risks with existing implementations
> that probably did not initialize reserved or padding bytes.

Yes, I understand this. One more time, I was the first on the mailing
to point out that the 0x80 flag can be used to discriminate between
CAN XL and CAN(-FD).

> And the fact that CANXL_XLF with its value of 128 intentionally breaks
> the CAN frame length rules for CAN/CANFD can be used too.
>
> E.g. in include/linux/can/skb.h
>
> static inline bool can_is_can_skb(const struct sk_buff *skb)
> {
>          struct can_frame *cf = (struct can_frame *)skb->data;
>
>          /* the CAN specific type of skb is identified by its data length */
>          return (skb->len == CAN_MTU && cf->len <= CAN_MAX_DLEN);
> }
>
> static inline bool can_is_canfd_skb(const struct sk_buff *skb)
> {
>          struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>
>          /* the CAN specific type of skb is identified by its data length */
>          return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
> }
>
> Using this simple and efficient check makes it comparably easy to detect
> CAN/CANFD/CANXL content inside the Linux kernel (and it can also be used
> in user space).

But it will not be exposed in the UAPI.

The point isn't whether or not this works: it does, no need to
convince me on it. The point is how easy it is to understand and how
many people will not get it and thus misuse it by putting the
CANFD_FDF check before the CANXL_XLF check?

Yours sincerely,
Vincent Mailhol

> > Personally, I prefer to have the can{fd,xl}_frame::flags aligned.
>
> Summing up I see much more risks of uninitialized content and potential
> misuse from existing code when the can{fd,xl}_frame::flags were aligned
> according to your suggestion.
>
> I would prefer having can[fd]_frame::len and canxl_frame::flags at the
> same (always initialized) location for the reasons described above.
>
> Best regards,
> Oliver
>
>
> > I foresee that misuses due to bad "if" ordering are more likely to
> > happen. Zeroing your stack variable is a best practice, developers
> > with good hygiene are safe. Requiring the two "if" checks in the
> > correct order is more obscure and more luckily to be misused even with
> > best intentions.
> >
> > So here are two solutions, each of them has their benefits and
> > drawbacks. I vote for aligning the flags. Pick your poison.
> >
> >
> >>   #define CAN_MTU                (sizeof(struct can_frame))
> >>   #define CANFD_MTU      (sizeof(struct canfd_frame))
> >> +#define CANXL_MTU      (sizeof(struct canxl_frame))
> >> +#define CANXL_HDR_SIZE (offsetof(struct canxl_frame, data))
> >> +#define CANXL_MIN_MTU  (CANXL_HDR_SIZE + 64)
> >> +#define CANXL_MAX_MTU  CANXL_MTU
> >>
> >>   /* particular protocols of the protocol family PF_CAN */
> >>   #define CAN_RAW                1 /* RAW sockets */
> >>   #define CAN_BCM                2 /* Broadcast Manager */
> >>   #define CAN_TP16       3 /* VAG Transport Protocol v1.6 */
