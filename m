Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D157139B
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiGLHzp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiGLHzl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 03:55:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3AB9DEE6
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657612536;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FXdW6uw+cxSVodxUZ2fb6DImdHzwG3X7Au4ml5FueDc=;
    b=sV57H0jZ4nRpfrfYi/QRDSuF6ZphFn7yTPmFnsQ2Xi8MkEQwqJSZ9h/rH2JaK1Tbhk
    YXNar96PYojOMEGzkx1iv3FZQQPizFiYlKJQfWubYus9Qbkudm5gEa9Is0E+1xGklImu
    PqkmaViLo60oBoIYDo5ooj68qYfPBKP8Q9BU4aHlO5XrOoRGTaKDDtlxEHRCO8gYzlBq
    j3pAD6UaBzgYBJjwGh8DOBt2Hpa1LP9k8KCthvb2mubPTtD80Qz0Prw8FDjTOfKOYURg
    35iBzmC0ezv95E+PAMtMlbj0QR23uOk5U2J6HjNY3u9cVU9cN+8KlWizyq8v7nG9kgoE
    a9Mg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id 398cccy6C7taSfW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 12 Jul 2022 09:55:36 +0200 (CEST)
Message-ID: <f00a4c5d-c4e6-06a2-76c0-53105d3465f2@hartkopp.net>
Date:   Tue, 12 Jul 2022 09:55:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/5] can: canxl: introduce CAN XL data structure
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <20220711183426.96446-1-socketcan@hartkopp.net>
 <20220711183426.96446-2-socketcan@hartkopp.net>
 <CAMZ6RqLqDFqdtKsp6jGhnTtWRrf6HC5HiLuJUSCRNkDXqVfCzA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLqDFqdtKsp6jGhnTtWRrf6HC5HiLuJUSCRNkDXqVfCzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 12.07.22 02:36, Vincent Mailhol wrote:
> On Tue. 12 Jul. 2022 at 03:44, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> This patch adds defines for data structures and length information for
>> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
>> byte insinde a single frame.
>>
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
>>   include/uapi/linux/can.h | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
>> index 90801ada2bbe..9f97a5d06f3b 100644
>> --- a/include/uapi/linux/can.h
>> +++ b/include/uapi/linux/can.h
>> @@ -58,10 +58,11 @@
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
>> @@ -71,10 +72,11 @@
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
>> @@ -89,10 +91,18 @@ typedef __u32 can_err_mask_t;
>>
>>   /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
>>   #define CANFD_MAX_DLC 15
>>   #define CANFD_MAX_DLEN 64
>>
>> +/*
>> + * CAN XL payload length and DLC definitions according to ISO 11898-1
>> + * CAN XL DLC ranges from 0 .. 2047 => data length from 1 .. 2048 byte
>> + */
>> +#define CANXL_MAX_DLC 2047
>> +#define CANXL_MAX_DLC_MASK 0x07FF
>> +#define CANXL_MAX_DLEN 2048
>> +
>>   /**
>>    * struct can_frame - Classical CAN frame structure (aka CAN 2.0B)
>>    * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
>>    * @len:      CAN frame payload length in byte (0 .. 8)
>>    * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
>> @@ -141,14 +151,20 @@ struct can_frame {
>>    * When this is done the former differentiation via CAN_MTU / CANFD_MTU gets
>>    * lost. CANFD_FDF allows programmers to mark CAN FD frames in the case of
>>    * using struct canfd_frame for mixed CAN / CAN FD content (dual use).
>>    * N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside of
>>    * struct canfd_frame therefore the CANFD_FDF flag is disregarded by Linux.
>> + * Same applies to the CANXL_XLF bit.
>> + *
>> + * For CAN XL the SEC bit has been added to the flags field which shares the
>> + * same position in struct can[fd|xl]_frame.
>>    */
>>   #define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
>>   #define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
>>   #define CANFD_FDF 0x04 /* mark CAN FD for dual use of struct canfd_frame */
>> +#define CANXL_XLF 0x08 /* mark CAN XL for dual use of struct canfd_frame */
>> +#define CANXL_SEC 0x10 /* Simple Extended Content (security/segmentation) */
>>
>>   /**
>>    * struct canfd_frame - CAN flexible data rate frame structure
>>    * @can_id: CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
>>    * @len:    frame payload length in byte (0 .. CANFD_MAX_DLEN)
>> @@ -164,12 +180,34 @@ struct canfd_frame {
>>          __u8    __res0;  /* reserved / padding */
>>          __u8    __res1;  /* reserved / padding */
>>          __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
>>   };
>>
>> +/**
>> + * struct canxl_frame - CAN with e'X'tended frame 'L'ength frame structure
>> + * @prio:  11 bit arbitration priority with zero'ed CAN_*_FLAG flags
>> + * @sdt:   SDU (service data unit) type
>> + * @flags: additional flags for CAN XL
>> + * @len:   frame payload length in byte (1 .. CANXL_MAX_DLEN)
>> + * @af:    acceptance field
>> + * @data:  CAN XL frame payload (up to CANXL_MAX_DLEN byte)
>> + *
>> + * @prio shares the same position as @can_id from struct canfd_frame.
>> + * Same applies to the relative position and length of @flags.
>> + */
>> +struct canxl_frame {
>> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>> +       __u8    sdt;   /* SDU (service data unit) type */
>> +       __u8    flags; /* additional flags for CAN XL */
>> +       __u16   len;   /* frame payload length in byte */
>> +       __u32   af;    /* acceptance field */
>> +       __u8    data[CANXL_MAX_DLEN];
> 
> __u8 data[];
> 
> 2 kilobytes start to be a significant size. Would it make sense to use
> a flexible array member to minimize the copies? A bit like the TCP/IP
> stack where you do not have to allocate the MTU but just what is
> actually needed for the headers and your payload.
> 
> Of course this is a tradeoff. It will add some complexity. The first
> impact is that the skb's data length might be smaller than the MTU and
> thus any logic using the MTU to differentiate between Classic CAN,
> CAN-FD or CAN XL would have to be adjusted.

Yes, I've thought about that myself but I wanted a simple start for our 
discussion to think about improvements in the team.

I implemented this first:

  /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
  bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
  {
-       const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+       unsigned int len = can_get_data_len(skb);
         struct can_priv *priv = netdev_priv(dev);

         if (skb->protocol == htons(ETH_P_CAN)) {
                 if (unlikely(skb->len != CAN_MTU ||
-                            cfd->len > CAN_MAX_DLEN))
+                            len > CAN_MAX_DLEN))
                         goto inval_skb;
         } else if (skb->protocol == htons(ETH_P_CANFD)) {
                 if (unlikely(skb->len != CANFD_MTU ||
-                            cfd->len > CANFD_MAX_DLEN))
+                            len > CANFD_MAX_DLEN))
+                       goto inval_skb;
+       } else if (skb->protocol == htons(ETH_P_CANXL)) {
+               if (unlikely(skb->len < CANXL_MINTU ||
+                            skb->len > CANXL_MTU ||
+                            len > CANXL_MAX_DLEN || len == 0))
                         goto inval_skb;
         } else {
                 goto inval_skb;
         }

(..)

+/* truncated CAN XL structs must contain at least 64 data bytes */
+#define CANXL_MINTU    (CANXL_MTU - CANXL_MAX_DLEN + CANFD_MAX_DLEN)

So the idea was to define a CAN XL skb->len which is clearly above 
CANFD_MTU to distinguish it from the other CAN MTUs.

But as the skbuff is zerocopy inside the kernel, it probably makes sense 
to stay with the full CANXL_MTU inside the kernel and allow to crop the 
data structure for CAN_RAW socket interactions from/to user space down 
to CANXL_MINTU ?!?

> Also, are we fine to drop the __attribute__((aligned(8)))? If I
> understand correctly, we moved from a 8 bytes alignment in struct
> can(fd)_frame to a 4 bytes alignment in struct canxl_frame.

Yes. I hassled with the alignment too.

The big cool thing about the 64 bit alignment was the filter and 
modification efficiency in bcm.c and gw.c

I wonder if this is still a relevant use case with CAN XL.

Currently the SDU type SDT=0x03 defines a Classical CAN and CAN FD 
'tunneling' for CAN XL (in CiA 611-1 document).

For this SDT=0x03 the CAN ID (and EFF/RTR/FD flags) are placed in the AF 
element.

And then the first data[0] byte will contain ESI/BRS/DLC and starting 
with data[1] the CAN frame data content will start.

So at least this spec will horribly break and 64 bit access to CAN data 
content.

I've been thinking about creating a 'normal' Classical CAN / CAN FD 
virtual CAN interface that feels for the user like a standard CAN 
interface with struct can[fd]_frame - but inside interacts with CAN XL 
frames with SDT=0x03 ...

Don't know if users really will need such stuff with CAN XL as there are 
other PDU tunneling mechanics already specified.

For that reason I would not take the 64 bit alignment as a strong 
requirement. With the current struct canxl_frame layout the data[] will 
start at a 32 bit boundary.

At the end I would see CAN XL as some Ethernet implementation with a 
cool arbitration concept from CAN that assures CSMA/C[AR] instead of 
CSMA/CD ;-)

Best regards,
Oliver

> 
>>
>> +};
>> +
>>   #define CAN_MTU                (sizeof(struct can_frame))
>>   #define CANFD_MTU      (sizeof(struct canfd_frame))
>> +#define CANXL_MTU      (sizeof(struct canxl_frame))
> 
> #define CANXL_MTU      (sizeof(struct canxl_frame) + CANXL_MAX_DLEN)
> 
>>   /* particular protocols of the protocol family PF_CAN */
>>   #define CAN_RAW                1 /* RAW sockets */
>>   #define CAN_BCM                2 /* Broadcast Manager */
>>   #define CAN_TP16       3 /* VAG Transport Protocol v1.6 */
> 
> 
> Yours sincerely,
> Vincent Mailhol
