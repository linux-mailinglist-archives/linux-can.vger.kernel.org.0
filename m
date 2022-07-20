Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8421D57BAA4
	for <lists+linux-can@lfdr.de>; Wed, 20 Jul 2022 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbiGTPlf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jul 2022 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiGTPlc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2022 11:41:32 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E77103D
        for <linux-can@vger.kernel.org>; Wed, 20 Jul 2022 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658331689;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+9/hfTJfHjvr9Heogk9JhPcQcOhwLb3OO/ObUROqDyI=;
    b=hgSaGupjw3KiPjxvD37k+Og3KlgkknO5TUONUg2c+jLwCz+ywnXdfiZvLMmiJFRdA1
    7jzx3lRIevFlQBwVE1F7PYpfoMKIw767lIcXO4fNyPcw7xEnW9XqYfWDUSZtsnhpifUk
    gwwDpgn7KWQDhH7QGBTW3LgaiyPmuz4OXVJI90sT2E6XBCRzqzDOoPacNLD4D1eYo3sO
    /g7erjuAqcoogocNL9rYEdBycOTy8wrTxuG3gmAgnxY8C/pXeUALJ3pT+nMH2ltYNIEr
    0ZzD7DC+POgDlkLwtECw1rQ3B2HpmmCmB0RPO52EHeTxe/lnO1TdA2PLlTBnKct8jqaG
    rOBw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id jdcffay6KFfT1KS
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 20 Jul 2022 17:41:29 +0200 (CEST)
Message-ID: <6e3c3167-e892-37c5-5494-4a4643c6bc13@hartkopp.net>
Date:   Wed, 20 Jul 2022 17:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v3 0/5] can: support CAN XL
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc:     linux-can@vger.kernel.org
References: <20220717132730.30295-1-socketcan@hartkopp.net>
 <202207181303.38060.pisa@cmp.felk.cvut.cz>
 <CAMZ6Rq+6mnFP9kPUmx4kdzd7G3=_NUnG10owir8Fg4qPi7P46w@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6Rq+6mnFP9kPUmx4kdzd7G3=_NUnG10owir8Fg4qPi7P46w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 20.07.22 08:49, Vincent Mailhol wrote:
> On Mon. 18 Jul. 2022 at 20:16, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
>> Hello Oliver,
>>
>> On Sunday 17 of July 2022 15:27:25 Oliver Hartkopp wrote:
>>> V2: Major rework after discussion and feedback on Linux-CAN ML
>>>
>>> - rework of struct canxl_frame
>>> - CANXL_XLF flag is now the switch between CAN XL and CAN/CANFD
>>> - variable length in r/w operations for CAN XL frames
>>> - write CAN XL frame to raw socket enforces size <-> canxl_frame.len sync
>>
>> I generally like the idea but I would like even to extend it to process
>> all CAN messages types through same API.
>>
>> +struct canxl_frame {
>> +       canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>> +       __u8    flags; /* additional flags for CAN XL */
>> +       __u8    sdt;   /* SDU (service data unit) type */
>> +       __u16   len;   /* frame payload length in byte */
>> +       __u32   af;    /* acceptance field */
>> +       __u8    data[CANXL_MAX_DLEN];
>> +};
>>
>> I would suggest to think about possibility to have single structure type
>> for processing of all CAN frames types in usersace.
> 
> I thought about it.
> 
> The prio is 11 bits, the XLF and SEC flags are 2 bits together, the
> SDT is 8 bits, the length is 12 bits (1~2048) and finally the af is 32
> bits. The total is thus 11+2+8+12+32 = 65 bits. Arg… one bit short to
> fit in the struct can(fd)_frame!
> However, if we use the DLC instead, the length information can fit on
> 11 bits (0~2047). With this, we have just enough to squeeze in the
> CAN-XL flags.
> 
> And so, let me introduce you the Frankenstein monster version of the
> canxl_frame:
> 
> #include <asm/byteorder.h>
> 
> struct canxl_frame {
>          union {
>                  canid_t can_id; /* CAN(-FD) ID */
>                  __u32 af; /* CAN-XL acceptance field */
>          };
>          union {
>                  struct {
>                          __u8 len; /* CAN(-FD) frame length */
>                          __u8 flags; /* additional flags for CAN FD */
>                          __u8 __res0;  /* reserved / padding */
>                          __u8 len8_dlc; /* optional Classic CAN DLC for
> 8 byte payload length (9 .. 15) */
>                  };
>                  struct {
> #if defined(__LITTLE_ENDIAN_BITFIELD)
>                          __u32 xlf:1; /* is CAN-XL frame? */
> #endif
>                          __u32 sec:1; /* Simple Extended Content
> (security/segmentation) */
>                          __u32 xl_dlc:11; /* CAN-XL data length code (0..2047) */
>                          __u32 prio:11; /* 11 bit priority for arbitration */
>                          __u32 sdt:8; /* SDU (service data unit) type */
> #if defined(__BIG_ENDIAN_BITFIELD)
>                          __u32 xlf:1; /* is CAN-XL frame? */
> #endif
>                  };
>          };
>          __u8 data[] __attribute__((aligned(8)));
> };
> 
> Pretty scary, isn’t it?
> 
> To be honest, I am sharing this for fun. No need to disprove this
> idea, I do *not* support it myself.

But sometimes it is valuable to formulate an idea as code to see that 
this is definitely NOT what you want ;-)

Best regards,
Oliver
