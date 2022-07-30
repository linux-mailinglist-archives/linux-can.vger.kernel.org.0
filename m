Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B41585A5D
	for <lists+linux-can@lfdr.de>; Sat, 30 Jul 2022 14:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiG3MGE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 30 Jul 2022 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3MGC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 30 Jul 2022 08:06:02 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F86313CF7
        for <linux-can@vger.kernel.org>; Sat, 30 Jul 2022 05:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1659182758;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lRLy21+LDVEsIcGKL7YRXIMV5g4CpoMMR5uemoUKfyY=;
    b=QkD3doGkGdO8uPma3jHnq3Sv6tJCQQ9EzKWXWA9gxmO2wmQm85b/8iGLQmsxlEnuFi
    VfBukMTA/B1LUGdTYYvDfW+clUtTz4nh4hPIiLftp2v/vzqyBgR+f0ryiLRqNDjApo/U
    1qAv2+e18hJKFyxGquaplRlYFcv5EOQqHTGg35Mz7Ikt8WDI7V0FfKZmHSYVp1NdFjnq
    CSnm2080oO5oboKxG4luCQIkntgP7wYMuVbo/JoHJllL1JOjgoZTp9/AC0dVl2vQPXqW
    1gVDmCrlghVbwATqrMEDKnctzpyL5s+XOJfEYWSGh6CFhtmVu/xLZgi189GZy+BRonaH
    NCsA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y6UC5vDbR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 30 Jul 2022 14:05:57 +0200 (CEST)
Message-ID: <c2bf9e37-3c52-559a-a76c-b1cf99b0d698@hartkopp.net>
Date:   Sat, 30 Jul 2022 14:05:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 4/7] can: canxl: introduce CAN XL data structure
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220729154107.1875-1-socketcan@hartkopp.net>
 <20220729154107.1875-5-socketcan@hartkopp.net>
 <CAMZ6RqKMtoo56OtaYG7Quoky+95hvfQaiFi+nDqez=+hMUMhHg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKMtoo56OtaYG7Quoky+95hvfQaiFi+nDqez=+hMUMhHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 30.07.22 04:13, Vincent Mailhol wrote:
> On Sat. 30 Jul. 2022 at 00:42, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> This patch adds defines for data structures and length information for
>> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
>> byte insinde a single frame.
>         ^^^^^^^
> inside

ok. Thx.

@Marc: Should I send an updated series or would you fix this typo while 
committing the patch?

> 
>> Notable changes from CAN FD:
>>
>> - the 11 bit arbitration field is now named 'priority' instead of 'can_id'
>>    (there are no 29 bit identifiers nor RTR frames anymore)
>> - the data length needs a uint16 value to cover up to 2048 byte
>>    (the length element position is different to struct can[fd]_frame)
>> - new fields (SDT, AF) and a SEC bit have been introduced
>> - the virtual CAN interface identifier is not part if the CAN XL frame
>>    struct as this VCID value is stored in struct skbuff (analog to vlan id)
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   include/uapi/linux/can.h | 51 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
>> index 7b23eeeb3273..dd645ea72306 100644
>> --- a/include/uapi/linux/can.h
>> +++ b/include/uapi/linux/can.h
>> @@ -46,10 +46,11 @@
>>   #ifndef _UAPI_CAN_H
>>   #define _UAPI_CAN_H
>>
>>   #include <linux/types.h>
>>   #include <linux/socket.h>
>> +#include <linux/stddef.h> /* for offsetof */
>>
>>   /* controller area network (CAN) kernel definitions */
>>
>>   /* special address description flags for the CAN_ID */
>>   #define CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
>> @@ -58,10 +59,11 @@
>>
>>   /* valid bits in CAN ID for frame formats */
>>   #define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
>>   #define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
>>   #define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
>> +#define CANXL_PRIO_MASK CAN_SFF_MASK /* 11 bit priority mask */
>>
>>   /*
>>    * Controller Area Network Identifier structure
>>    *
>>    * bit 0-28    : CAN identifier (11/29 bit)
>> @@ -71,10 +73,11 @@
>>    */
>>   typedef __u32 canid_t;
>>
>>   #define CAN_SFF_ID_BITS                11
>>   #define CAN_EFF_ID_BITS                29
>> +#define CANXL_PRIO_BITS                CAN_SFF_ID_BITS
>>
>>   /*
>>    * Controller Area Network Error Message Frame Mask structure
>>    *
>>    * bit 0-28    : error class mask (see include/uapi/linux/can/error.h)
>> @@ -89,10 +92,20 @@ typedef __u32 can_err_mask_t;
>>
>>   /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
>>   #define CANFD_MAX_DLC 15
>>   #define CANFD_MAX_DLEN 64
>>
>> +/*
>> + * CAN XL payload length and DLC definitions according to ISO 11898-1
>> + * CAN XL DLC ranges from 0 .. 2047 => data length from 1 .. 2048 byte
>> + */
>> +#define CANXL_MIN_DLC 0
>> +#define CANXL_MAX_DLC 2047
>> +#define CANXL_MAX_DLC_MASK 0x07FF
>> +#define CANXL_MIN_DLEN 1
>> +#define CANXL_MAX_DLEN 2048
>> +
>>   /**
>>    * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
>>    * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
>>    * @len:      CAN frame payload length in byte (0 .. 8)
>>    * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
>> @@ -164,12 +177,50 @@ struct canfd_frame {
>>          __u8    __res0;  /* reserved / padding */
>>          __u8    __res1;  /* reserved / padding */
>>          __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
>>   };
>>
>> +/*
>> + * defined bits for canxl_frame.flags
>> + *
>> + * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_SEC
>> + * and shares the relative position of the struct can[fd]_frame.len element.
>> + * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL frame.
>> + * As a side effect setting this bit intentionally breaks the length checks
>> + * for Classical CAN and CAN FD frames.
>> + *
>> + * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
>> + */
>> +#define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
>> +#define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
>> +
>> +/**
>> + * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
>> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
>> + * @flags: additional flags for CAN XL
>> + * @sdt:   SDU (service data unit) type
>> + * @len:   frame payload length in byte (CANXL_MIN_DLEN .. CANXL_MAX_DLEN)
>> + * @af:    acceptance field
>> + * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
>> + *
>> + * @prio shares the same position as @can_id from struct can[fd]_frame.
>> + */
>> +struct canxl_frame {
>> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>> +       __u8    flags; /* additional flags for CAN XL */
>> +       __u8    sdt;   /* SDU (service data unit) type */
>> +       __u16   len;   /* frame payload length in byte */
>> +       __u32   af;    /* acceptance field */
>> +       __u8    data[CANXL_MAX_DLEN];
>> +};
> 
> I read the previous threads from the start and there is one point
> which, I think, did not get enough attention.
> 
> With the current proposal, there is one pitfall on the user side. A
> correct way to differentiate between the Classical CAN, CAN-FD and
> CAN-XL would be, as discussed:
> 
> union {
>           struct can_frame cc;
>           struct canfd_frame fd;
>           struct canxl_frame xl;
> } can;
> 
> nbytes = read(s, &can.xl, sizeof(struct canxl_frame));
> 
> if (can.xl.flags & CANXL_XLF)
>      /* Handle CAN XL frame */
> else if (can.fd.flags & CANFD_FDF) /* or equivalent: if (nbytes == CANFD_MTU) */
>      /* Handle CAN FD frame */
> else
>         /* Handle Classic CAN frame */
> 
> However, it becomes incorrect if the order is changed:
> 
> if (can.fd.flags & CANFD_FDF) /* or equivalent: if (nbytes == CANFD_MTU) */

No. The point is, that you might have a CAN XL frame with a data length 
of 60 which becomes (when adding the CANXL_HDR_SIZE) 72 which is CANFD_MTU.

For that reason the distinction for CAN XL frames (and the 'old' stuff) is

     if (can.xl.flags & CANXL_XLF) {}

in the first place.

>      /* can.fd.flags can collide with can.xl.sdt,  */
>      /* nbytes == CANFD_MTU would also collide if the CAN XL frame
> length is 32 bytes  */
> else if (can.xl.flags & CANXL_XLF)
>      /* Handle CAN XL frame */
> else
>         /* Handle Classic CAN frame */
> 
> I see this as a big pitfall.
> 
> 
> 
> A solution (or rather a compromise) would be to align the flags fields
> between the canfd_frame and canxl_frame.
> 
> #define CANXL_XLF 0x08 /* mandatory CAN XL frame flag (must always be set!) */
> #define CANXL_SEC 0x10 /* Simple Extended Content (security/segmentation) */
> 
> struct canxl_frame {
>         canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>         __u8    sdt;   /* SDU (service data unit) type */
>         __u8    flags; /* flags for CAN FD and CAN XL */
>         __u16   len;   /* frame payload length in byte */
>         __u32   af;    /* acceptance field */
>         __u8    data[CANXL_MAX_DLEN];
> };
> 
> This way, the check between CANFD_FDF and CANXL_XLF can be done in any
> order. A side benefit is that you do not need a union anymore to check
> the frame type.

This has no impact on the union. When you write code that is able to 
cope with all three CAN frame types you need this kind of union, right?

> I say this is a compromise because it adds back the collision between
> can{fd,xl}_frame::flags and can_frame::__pad.
> 
> Existing applications are exempted from this risk: the
> CAN_RAW_XL_FRAMES socket option will prevent the collision from
> happening. To summarise, the collision will only occur if below
> criteria are met:
> 
>    * The user allocates a can_frame without zeroing it (typical use
> cases are stack declaration or malloc()).
>    * The user activates the CAN_RAW_XL_FRAMES socket option.
>    * Garbage value results in can_frame::__pad & CANXL_XLF being set.
> 
> So if going in that direction, we would have to update the
> documentation (header files and kernel doc) to point at this pitfall
> and specify that can_frame::__pad shall always be zeroed for mix
> usages.

But you would add this recommendation to a *very late point* - namely 
after 14 years of SocketCAN in the mainline kernel.

If you think about the rule "never break user space" I wonder if the 
risk turns out to be higher when people enable CAN_RAW_XL_FRAMES ("as 
seen on Stackoverflow") and not read the kernel doc recommendations to 
review/update their existing code.

With the current layout it can be clearly stated that after enabling 
CAN_RAW_XL_FRAMES you will be able to detect CAN XL frames with

if (can.xl.flags & CANXL_XLF) {}

And if this bit is not set you can check for the old stuff (CAN FD and 
Classical CAN).

The good thing about having can[fd]_frame::len and canxl_frame::flags at 
the same location is that this field is (and was!) *always* set (== 
initialized) properly. No potential risks with existing implementations 
that probably did not initialize reserved or padding bytes.

And the fact that CANXL_XLF with its value of 128 intentionally breaks 
the CAN frame length rules for CAN/CANFD can be used too.

E.g. in include/linux/can/skb.h

static inline bool can_is_can_skb(const struct sk_buff *skb)
{
         struct can_frame *cf = (struct can_frame *)skb->data;

         /* the CAN specific type of skb is identified by its data length */
         return (skb->len == CAN_MTU && cf->len <= CAN_MAX_DLEN);
}

static inline bool can_is_canfd_skb(const struct sk_buff *skb)
{
         struct canfd_frame *cfd = (struct canfd_frame *)skb->data;

         /* the CAN specific type of skb is identified by its data length */
         return (skb->len == CANFD_MTU && cfd->len <= CANFD_MAX_DLEN);
}

Using this simple and efficient check makes it comparably easy to detect 
CAN/CANFD/CANXL content inside the Linux kernel (and it can also be used 
in user space).

> Personally, I prefer to have the can{fd,xl}_frame::flags aligned.

Summing up I see much more risks of uninitialized content and potential 
misuse from existing code when the can{fd,xl}_frame::flags were aligned 
according to your suggestion.

I would prefer having can[fd]_frame::len and canxl_frame::flags at the 
same (always initialized) location for the reasons described above.

Best regards,
Oliver


> I foresee that misuses due to bad "if" ordering are more likely to
> happen. Zeroing your stack variable is a best practice, developers
> with good hygiene are safe. Requiring the two "if" checks in the
> correct order is more obscure and more luckily to be misused even with
> best intentions.
> 
> So here are two solutions, each of them has their benefits and
> drawbacks. I vote for aligning the flags. Pick your poison.
> 
> 
>>   #define CAN_MTU                (sizeof(struct can_frame))
>>   #define CANFD_MTU      (sizeof(struct canfd_frame))
>> +#define CANXL_MTU      (sizeof(struct canxl_frame))
>> +#define CANXL_HDR_SIZE (offsetof(struct canxl_frame, data))
>> +#define CANXL_MIN_MTU  (CANXL_HDR_SIZE + 64)
>> +#define CANXL_MAX_MTU  CANXL_MTU
>>
>>   /* particular protocols of the protocol family PF_CAN */
>>   #define CAN_RAW                1 /* RAW sockets */
>>   #define CAN_BCM                2 /* Broadcast Manager */
>>   #define CAN_TP16       3 /* VAG Transport Protocol v1.6 */
>> --
>> 2.30.2
>>
