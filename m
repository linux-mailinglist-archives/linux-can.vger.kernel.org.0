Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06215782AD
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 14:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiGRMrv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 08:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiGRMru (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 08:47:50 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB5DE68
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658148466;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cEcY2IyLy3vPpmTYgPELy+O9UKqtLsLSNHV5xUl0aoU=;
    b=dcBhd4cgVOr56e3jGACSqCcm19RZu5KPnpOZp/UW/015BWj1qEkeXNMgNLzJtJfUaH
    aKJka1sdPaH1HNSajoFrC9P3Dd62NimiFW87kPeIVHjuDQ4NRtlIDP6Rgk/gYkwQh/Ut
    K8k1l0iKUHaYMJuessgbxBCoW6HxVlc500ilFiB7yjydQ6A5cYqJI4lqQ575kBcoMr3j
    4w7Hk4YAlkttosAW2d1ZGoqfHJiZL2PfLGKpm0QqfyDs73P/j5W7mXSKH29+jOO59PJW
    ty2qjuAcDy0yk9gndIVE4d5Q1btRM/iSm3e8oPrNylLJR9ffgnxH7KvZkFD8Mq0n1mPQ
    Lrnw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6IClkDkE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 18 Jul 2022 14:47:46 +0200 (CEST)
Message-ID: <6e721b51-82a1-0283-b507-3c4313a3abce@hartkopp.net>
Date:   Mon, 18 Jul 2022 14:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v3 0/5] can: support CAN XL
Content-Language: en-US
To:     Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org
References: <20220717132730.30295-1-socketcan@hartkopp.net>
 <202207181303.38060.pisa@cmp.felk.cvut.cz>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <202207181303.38060.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Pavel,

On 18.07.22 13:03, Pavel Pisa wrote:
> Hello Oliver,
> 
> On Sunday 17 of July 2022 15:27:25 Oliver Hartkopp wrote:
>> V2: Major rework after discussion and feedback on Linux-CAN ML
>>
>> - rework of struct canxl_frame
>> - CANXL_XLF flag is now the switch between CAN XL and CAN/CANFD
>> - variable length in r/w operations for CAN XL frames
>> - write CAN XL frame to raw socket enforces size <-> canxl_frame.len sync
> 
> I generally like the idea but I would like even to extend it to process
> all CAN messages types through same API.
> 
> +struct canxl_frame {
> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
> +       __u8    flags; /* additional flags for CAN XL */
> +       __u8    sdt;   /* SDU (service data unit) type */
> +       __u16   len;   /* frame payload length in byte */
> +       __u32   af;    /* acceptance field */
> +       __u8    data[CANXL_MAX_DLEN];
> +};
> 
> I would suggest to think about possibility to have single structure type
> for processing of all CAN frames types in usersace.

Yes, I would love to do this too.

But the length information in the CAN/CANFD frame is a 8 bit (u8) 
element while we need 16 bit in CAN XL frames which can cover the 2048 
bytes available in CAN XL.

So we can not place canxl_frame.len at the same place as can[fd]_frame.len.

And this leads to 'the trick' that canxl_frame.flags shares its position 
with can[fd]_frame.len.

With CANXL_XLF = 0x80 we switch between CAN XL and CAN/CANFD which would 
lead to can[fd]_frame.len = 128 which is way beyond a valid CAN/CANFD 
length value.

> When you define field
> prio as anonyous union of prio and can_id
> 
>    union {
>      canid_t prio;
>      canid_t can_id;
>    }

The CAN XL specification has no can_id anymore - but canxl_frame.prio 
and can[fd]_frame.can_id share the same position, length and type (canid_t).

This allows us to re-use the CAN-ID filters in af_can.c for the 
canxl_frame.prio.

> then it is possible to define flags such way, that canxl_frame is alternative
> for all other formats

Ah, now I got your point.

But e.g. you don't need 'sdt' and 'af' elements in CAN[FD] frames and 
you would need raw-DLC fields for Classical CAN.

This will break all in-kernel users (bcm, gw, isotp, j1939).

> +#define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
> So CANXL_XLF will be changed to CANXLS_SELECT frame structure selected,
> then rest of bits can be used for CANXLS_XLF, CANXLS_FD, in ideal case even
> RTR, BRS etc.. or RTR can be left as part of ID if that is easier.
> This way only single structure can be used to receive and send all
> frames over single interface when XL option is selected
> by software.
> 
> Yes, there would be redundancy in the kernel handling which has to accept
> two types of encoding of CAN FD and standard messages but actual complexity
> in usespace when you want to support all variants and for example
> forward frames between interfaces or process them inside QEMU etc.
> is really quite high.

IMHO it is very easy for CAN interfaces (as you can see in the vcan 
driver (patch 4/5).

CAN XL is quite different to CAN[FD]. I would name it "Ethernet with CAN 
arbitration" and for that reason I'm currently not thinking of adapting 
the CAN modification features in gw.c for CAN XL.

If you go through the patches 2/5 and 3/5 you can see the current 
infrastructure effort to handle CAN, CAN FD and CAN XL frames in parallel.

When working with a mix of CAN[|FD|XL] frames in user space I would 
simply read into a struct canxl_frame and cast it to CAN[FD] when 
CANXL_XLF is not set (and the sizeof(struct can[fd]_frame) and the len 
value fits.

Don't you think, that is easy enough?

Best regards,
Oliver
