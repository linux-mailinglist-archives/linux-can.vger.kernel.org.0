Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB257D4C4
	for <lists+linux-can@lfdr.de>; Thu, 21 Jul 2022 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiGUU04 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Jul 2022 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGUU04 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Jul 2022 16:26:56 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E24C193FA
        for <linux-can@vger.kernel.org>; Thu, 21 Jul 2022 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658435213;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=IECtOmXVTAydwKbDTSJ6pROmWKhm02lCfFhpj7Icr74=;
    b=tocx+4U8iii28tMNT3IqPGNMhayVADfO+gf6ZjPEAhtRyyuAXNuf5Fzcc2qTtDbQnG
    bPgbKWaA8Hdbld+J/osdSkxMg+APd7yYcOjXQ0/nMjXJQ7QGTytBRD9oRggYy3v2nN74
    Y07P7xAlb1Pq6MK3+nyG1nbOVmpR6RfKQb2sLA96bRZhc4sZ71RLPKsQ7voysreMzQga
    Bkm9/vDYEE41N2YOVdKnXdpCMrfw3K9//9R7vsDUSxNgwvfRpz5gLiQvH6Tjf2qsqN+e
    00ReIb9c9J5c9oPCLniFbLrTrkFPnK8du/X22CwPCb0Lysd1BP7mOjafVbOtEYZrbR9c
    lNOA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id jdcffay6LKQq4bK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 21 Jul 2022 22:26:52 +0200 (CEST)
Message-ID: <cdb2d8cb-a0ab-a4f6-267a-0a574823a8a9@hartkopp.net>
Date:   Thu, 21 Jul 2022 22:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v5 3/5] can: dev: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <20220719112748.3281-1-socketcan@hartkopp.net>
 <20220719112748.3281-4-socketcan@hartkopp.net>
 <CAMZ6RqLb=Q3VQxwG3gXtTyo7YkLsB5f3YonjgcpmeoRzReOXCw@mail.gmail.com>
 <f8ec078d-44c9-9f8c-800f-058e4c735003@hartkopp.net>
 <CAMZ6RqKhW1vGwY1n=k82VmjKk_7MSUAQo4vvR-SGEpA0kD5sXA@mail.gmail.com>
 <e31e06bc-e4ba-92a9-c48a-8d125303d822@hartkopp.net>
 <CAMZ6RqLhah079XwkA6_Sk8LZ9zF8+xtxVW39kW=ZPPc18GNJZQ@mail.gmail.com>
 <CAMZ6RqKex6DwpFrs6pYe5UnSSHhu6TCcGi4xW1WcpKM8F=oS=A@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKex6DwpFrs6pYe5UnSSHhu6TCcGi4xW1WcpKM8F=oS=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 21.07.22 05:13, Vincent Mailhol wrote:
> On Thu. 21 juil. 2022 at 11:37, Vincent Mailhol
> <vincent.mailhol@gmail.com> wrote:
>> On Wed. 21 Jul. 2022 at 01:43, Oliver Hartkopp <socketcan@hartkopp.net> wrote:


>>> And even the user space side to handle a mix of CAN frame types is
>>> pretty simple IMO:
>>>
>>> union {
>>>           struct can_frame cc;
>>>           struct canfd_frame fd;
>>>           struct canxl_frame xl;
>>> } can;
>>
>> Do you want to add this union in the kernel uapi or is it just a
>> userland example?
> 
> More brainstorming. If we want to introduce a generic can structure in
> linux/can.h, we could  do:
> 
> struct canxl_frame {
>          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>          __u8    xl_flags; /* additional flags for CAN XL */
>          __u8    fd_flags; /* CAN(-FD) flags */
>          __u16   len;   /* frame payload length in byte */
>          __u32   af;    /* acceptance field */
>          __u8    sdt;   /* SDU (service data unit) type */
>          __u8    __res0;  /* reserved / padding */
>          __u8    __res1;  /* reserved / padding */
>          __u8    __res2;  /* reserved / padding */
>          __u8    data[CANXL_MAX_DLEN] __attribute__((aligned(8)));
> };
> 
> union can_generic_frame {
>           struct {
>                  union {
>                         canid_t can_id;
>                         canid_t prio;
>                  };
>                  union {
>                          __u16 type;
>                           struct {
>                                  __u8 xl_flags;
>                                  __u8 fd_flags;
>                          } __attribute__((packed));
>                  } __attribute__((packed));
>           };
>           struct can_frame cc;
>           struct canfd_frame fd;
>           struct canxl_frame xl;
> };
> 
> #define CANXL_XLF 0x80 /* apply to canxl_frame::xl_flags */
> 
> #define CAN_TYPE_CC 0
> #ifdef __LITTLE_ENDIAN
> #define CAN_TYPE_FD (CANFD_FDF << 8)
> #define CAN_TYPE_XL (CANXL_XLF)
> #else /* __BIG_ENDIAN */
> #define CAN_TYPE_FD (CANFD_FDF)
> #define CAN_TYPE_XL (CANXL_XLF << 8)
> #endif
> 
> #define CAN_TYPE_MASK (CAN_TYPE_FD | CAN_TYPE_XL)
> 
> Because can_generic_frame::type overlaps with the can(fd)_frame::len,
> it will contain garbage and thus it is necessary to mask it with
> CAN_TYPE_MASK.
> The CANFD_FDF is only set in the rx path. In the tx path it is simply
> ignored. This done, we can use it as below when *receiving* can
> frames:

No problem to set CANFD_FDF in raw_sendmsg() when we process a CAN FD 
frame in the tx path ...

> 
> int foo()
> {
>    union can_generic_frame can;
> 
>    /* receive a frame */
> 
>    switch (can.type & CAN_TYPE_MASK) {
>    case CAN_TYPE_CC:
>      printf("Received classical CAN Frame\n");
>      break;
> 
>    case CAN_TYPE_FD:
>      printf("Received CAN FD Frame\n");
>      break;
> 
>    case CAN_TYPE_XL:
>      printf("Received CAN XL Frame\n");
>      break;
> 
>    default:
>      fprintf(stderr, "Unknown type: %x\n", can.type & CAN_TYPE_MASK);
>    }
> 
>    return EXIT_SUCCESS;
> }
> 

If you just want to get rid of the nbytes checking and we make sure 
CANFD_FDF is properly set in the future we are not far from such an easy 
check - even without moving the sdt element or endian magic:


if (can.xl_flags & CANXL_XLF) {
     printf("Received CAN XL Frame\n");
} else if (can.fd_flags & CANFD_FDF) {
     printf("Received CAN FD Frame\n");
} else {
     printf("Received classical CAN Frame\n");
}

Regards,
Oliver
