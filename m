Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7425B158D
	for <lists+linux-can@lfdr.de>; Thu,  8 Sep 2022 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIHHYm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 8 Sep 2022 03:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiIHHYl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Sep 2022 03:24:41 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6219413CF3
        for <linux-can@vger.kernel.org>; Thu,  8 Sep 2022 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1662621876;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7egRHhdiwFamty5vds1GKfFME+s8cOivYqFVoZuHVHA=;
    b=iuy/4C0O4XyCpPZ4ArMS85HvFkb/o7ykwUQyj1w7l0OSIbdnd4stvby8C2ZC7NDgX8
    TTl5PZTgm7OKsvBPTvPY21OBfpuNWj+Xz+VgjEJ06TJslSTuGSFMYMUPbrg0Uwcqutf6
    Mu/7ODnh4E/7SxPV5lpo68Ef4wNQv5t9LO620WQBOz+I4gZk9ZOd+hoRWEvX3Gpu3VO0
    RXhGV+FHYdAftV3ZN9few+5QwYE5tzkCU6r98QvjMMMcHmhU+g7cqb174vcwjKu4vqc4
    7Pnxpyb+mjQcBtvtwFGDqm+Kad86nyXmWaD/tpvNtYS9Fgtf/qZKT9L3+V9O8j+NM3He
    FVvg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 48.0.2 AUTH)
    with ESMTPSA id wfa541y887Oa6IA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Sep 2022 09:24:36 +0200 (CEST)
Message-ID: <f79f729c-01eb-2121-e315-a240357d2eb0@hartkopp.net>
Date:   Thu, 8 Sep 2022 09:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v8 4/7] can: canxl: introduce CAN XL data structure
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220801190010.3344-1-socketcan@hartkopp.net>
 <20220801190010.3344-5-socketcan@hartkopp.net>
 <CAMZ6RqKFNY1y9XpsLU6cjs_TmnYBjjDin6LHn5TRpm5m4w2ewg@mail.gmail.com>
 <414e2a33-0091-11fc-70db-a87331addff8@hartkopp.net>
In-Reply-To: <414e2a33-0091-11fc-70db-a87331addff8@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

any update on this or are you fine with the patch set now?

Best regards,
Oliver

On 02.09.22 15:56, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 02.09.22 08:19, Vincent Mailhol wrote:
>> Sorry for the late reply, I am back from holidays. My previous review
>> was a best effort review.
> 
> Hope you had good holidays ;-)
> 
>> Since then, I took time to read the CiA’s CAN knowledge pages of CAN XL:
>> https://www.can-cia.org/can-knowledge/can/can-xl/
>> and have a few newer comments.
>>
>> Unfortunately, I still do not have access to the full specification,
>> so please forgive if there are some silly remarks.
> 
> I think the short introduction to CAN XL from the cover letter fits 
> quite good.
> 
> https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/canxl_intro_20210225.pdf 
> 
> 
>> On Tue. 2 Aug 2022 at 04:02, Oliver Hartkopp <socketcan@hartkopp.net> 
>> wrote:
>>> This patch adds defines for data structures and length information for
>>> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
>>> byte inside a single frame.
>>>
>>> Notable changes from CAN FD:
>>>
>>> - the 11 bit arbitration field is now named 'priority' instead of 
>>> 'can_id'
>>>    (there are no 29 bit identifiers nor RTR frames anymore)
>>> - the data length needs a uint16 value to cover up to 2048 byte
>>>    (the length element position is different to struct can[fd]_frame)
>>> - new fields (SDT, AF) and a SEC bit have been introduced
>>> - the virtual CAN interface identifier is not part if the CAN XL frame
>>>    struct as this VCID value is stored in struct skbuff (analog to 
>>> vlan id)
> 
> Did you note this?
> 
> Because you asked about the VCID later.
> 
> There is an existing Kernel API to handle VLAN-like ID stuff. And we 
> should simply use that existing mechanic as it has the same intention 
> and handling for CAN XL.
> 
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>> ---
>>>   include/uapi/linux/can.h | 51 ++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 51 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
>>> index 7b23eeeb3273..dd645ea72306 100644
>>> --- a/include/uapi/linux/can.h
>>> +++ b/include/uapi/linux/can.h
>>> @@ -46,10 +46,11 @@
>>>   #ifndef _UAPI_CAN_H
>>>   #define _UAPI_CAN_H
>>>
>>>   #include <linux/types.h>
>>>   #include <linux/socket.h>
>>> +#include <linux/stddef.h> /* for offsetof */
>>>
>>>   /* controller area network (CAN) kernel definitions */
>>>
>>>   /* special address description flags for the CAN_ID */
>>>   #define CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
>>> @@ -58,10 +59,11 @@
>>>
>>>   /* valid bits in CAN ID for frame formats */
>>>   #define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
>>>   #define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
>>>   #define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
>>> +#define CANXL_PRIO_MASK CAN_SFF_MASK /* 11 bit priority mask */
>>>
>>>   /*
>>>    * Controller Area Network Identifier structure
>>>    *
>>>    * bit 0-28    : CAN identifier (11/29 bit)
>>> @@ -71,10 +73,11 @@
>>>    */
>>>   typedef __u32 canid_t;
>>>
>>>   #define CAN_SFF_ID_BITS                11
>>>   #define CAN_EFF_ID_BITS                29
>>> +#define CANXL_PRIO_BITS                CAN_SFF_ID_BITS
>>>
>>>   /*
>>>    * Controller Area Network Error Message Frame Mask structure
>>>    *
>>>    * bit 0-28    : error class mask (see include/uapi/linux/can/error.h)
>>> @@ -89,10 +92,20 @@ typedef __u32 can_err_mask_t;
>>>
>>>   /* CAN FD payload length and DLC definitions according to ISO 
>>> 11898-7 */
>>>   #define CANFD_MAX_DLC 15
>>>   #define CANFD_MAX_DLEN 64
>>>
>>> +/*
>>> + * CAN XL payload length and DLC definitions according to ISO 11898-1
>>> + * CAN XL DLC ranges from 0 .. 2047 => data length from 1 .. 2048 byte
>>> + */
>>> +#define CANXL_MIN_DLC 0
>>> +#define CANXL_MAX_DLC 2047
>>> +#define CANXL_MAX_DLC_MASK 0x07FF
>>> +#define CANXL_MIN_DLEN 1
>>> +#define CANXL_MAX_DLEN 2048
>>> +
>>>   /**
>>>    * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
>>>    * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t 
>>> definition
>>>    * @len:      CAN frame payload length in byte (0 .. 8)
>>>    * @can_dlc:  deprecated name for CAN frame payload length in byte 
>>> (0 .. 8)
>>> @@ -164,12 +177,50 @@ struct canfd_frame {
>>>          __u8    __res0;  /* reserved / padding */
>>>          __u8    __res1;  /* reserved / padding */
>>>          __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
>>>   };
>>>
>>> +/*
>>> + * defined bits for canxl_frame.flags
>>> + *
>>> + * The canxl_frame.flags element contains two bits CANXL_XLF and 
>>> CANXL_SEC
>>> + * and shares the relative position of the struct can[fd]_frame.len 
>>> element.
>>> + * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN 
>>> XL frame.
>>> + * As a side effect setting this bit intentionally breaks the length 
>>> checks
>>> + * for Classical CAN and CAN FD frames.
>>> + *
>>> + * Undefined bits in canxl_frame.flags are reserved and shall be set 
>>> to zero.
>>> + */
>>> +#define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always 
>>> be set!) */
>>> +#define CANXL_SEC 0x01 /* Simple Extended Content 
>>> (security/segmentation) */
>>
>> Are we sure that no other flags are needed? The CiA can-knowledge
>> mentions a FTYP (frame type) flag. Do you know what it is?
> 
> The LLC frame fields in 
> https://www.can-cia.org/can-knowledge/can/can-xl/ are a mix(!) of 
> Classical CAN, CAN FD and CAN XL content (e.g. ESI is only CAN FD).
> 
> The frame type flags an abstraction of
> (none) -> Classical CAN
> (FDF) -> CAN FD
> (XLF) -> CAN XL
> 
>>> +
>>> +/**
>>> + * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame 
>>> structure
>>> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
>>> + * @flags: additional flags for CAN XL
>>> + * @sdt:   SDU (service data unit) type
>>> + * @len:   frame payload length in byte (CANXL_MIN_DLEN .. 
>>> CANXL_MAX_DLEN)
>>> + * @af:    acceptance field
>>> + * @data:  CAN XL frame payload (CANXL_MIN_DLEN .. CANXL_MAX_DLEN byte)
>>> + *
>>> + * @prio shares the same position as @can_id from struct can[fd]_frame.
>>> + */
>>> +struct canxl_frame {
>>> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>>
>> Does it make sense to keep the canid_t? The addressing is done through
>> both the prio and the af fields. Also, the CAN_EFF_FLAG, CAN_RTR_FLAG
>> and CAN_ERR_FLAG flags do not apply anymore. Finally, the prio is only
>> 11 bits, no need to reserve 32 bits for it.
> 
> The CAN-ID was (due to its arbitration nature) always also a priority 
> field.
> 
> So nothing changed here. There is no RTR and no 29-bit priority anymore 
> now. The RTR flag has already been disabled for CAN FD (see presentation 
> at the end of this mail).
> 
> Therefore it makes sense to handle the SFF 11-bit prio analogue to the 
> former CAN-ID - and also use canid_t to simply keep the entire CAN 
> filter handling in af_can.c !
> 
> The new idea in CAN XL is to split the priority from the content 
> identification which has been named 'acceptance field' (AC).
> 
> The functionality of AC depends on SDT. Don't know how this will work 
> out in the future and if we would provide some AF-specific filtering 
> inside the kernel.
> 
>>
>> Of course, if we declare it as 16 bits, we need to add some padding so
>> that the other flags remain at the same offset.
> 
> Answered above.
> 
>>> +       __u8    flags; /* additional flags for CAN XL */
>>> +       __u8    sdt;   /* SDU (service data unit) type */
>>> +       __u16   len;   /* frame payload length in byte */
>>> +       __u32   af;    /* acceptance field */
>>> +       __u8    data[CANXL_MAX_DLEN];
>>> +};
>>
>> The CiA CAN knowledge also mentions a VCID (virtual CAN network ID).
>> Is this not needed?
> 
> Answered above.
> 
>>> +
>>>   #define CAN_MTU                (sizeof(struct can_frame))
>>>   #define CANFD_MTU      (sizeof(struct canfd_frame))
>>> +#define CANXL_MTU      (sizeof(struct canxl_frame))
>>> +#define CANXL_HDR_SIZE (offsetof(struct canxl_frame, data))
>>> +#define CANXL_MIN_MTU  (CANXL_HDR_SIZE + 64)
>>> +#define CANXL_MAX_MTU  CANXL_MTU
>>>
>>>   /* particular protocols of the protocol family PF_CAN */
>>>   #define CAN_RAW                1 /* RAW sockets */
>>>   #define CAN_BCM                2 /* Broadcast Manager */
>>>   #define CAN_TP16       3 /* VAG Transport Protocol v1.6 */
>>
>> CAN XL has a resXL flag, suggesting that there may be a fourth
>> generation of the CAN protocol. One issue in the initial socket CAN
>> design is that we never reserved a flag for future versions. Here, we
>> are lucky that the bit 0x80 of the length field is never set.
>> Back to CAN XL, I would like to discuss how we will distinguish the
>> CAN GEN4 frames from the CAN XL ones so that we do not find ourselves
>> stuck in a couple of years because no bits are left to differentiate
>> things.
>>
>> One solution would be to set the two most significant bit:
>> #define CAN_GEN4 0xC0
>>
>> and the test would be:
>> if (cf.flags & CAN_GEN4 == CAN_GEN4)
> 
> Please do not mix up (incompatible) extensions that have been 
> implemented in the CAN protocol through the 'wandering' reserved bit 
> (r0, now resXL) with the CAN(FD/XL) data structure.
> 
> The first suggestion for a CAN frame data structure representation in 
> IEEE 1722 contained the entire bitstream definition including the IDE 
> bit. That splitted the 11 and 18 bits of the CAN ID inside the data 
> structure :-D
> 
> I really think, that the journey is ending with CAN XL and when there 
> would be really a new improvement, we will take a look at it. E.g. by 
> extending the CAN XL flags from the top down (as you suggested with 0xC0).
> 
> But who knows how much of the CAN XL frame layout would be re-used by 
> CAN XY ?? ¯\_(ツ)_/¯
> 
> Btw. I uploaded a presentation which shows the way from classical CAN to 
> CAN XL which might depict some relations of the bits in a clearer way:
> 
> https://github.com/linux-can/can-doc/blob/master/presentations/CAN-XL-Intro.pdf 
> 
> 
> Best regards,
> Oliver
> 
