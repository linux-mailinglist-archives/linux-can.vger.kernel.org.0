Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA755744E4
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 08:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiGNGLe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jul 2022 02:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiGNGLc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jul 2022 02:11:32 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5326612082
        for <linux-can@vger.kernel.org>; Wed, 13 Jul 2022 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657779089;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=USFvoi8suXAqEJ0VvlXF1g+3ZHMxcq38a3oFZHHy6cs=;
    b=YwdwvHv8H31SPd0d6S1WMbHVuvb0dGLJEl7xA8TeVH9Zvc1FFCNiDvVIGTx6rT7z0S
    JPxRlbYDOCbuwQB7r57VGg/2KUq+2+wHlHAHG3rwEnuChoGi4qONhw1p51w2YeVHQDMi
    qJ7JQIr8SvPjxE0mv5WgyB+Z0WH3eVS21Q+C9ZYXvqDUegJcPGReBLeAtrFQW9Uqx4Rw
    duRZO8tW3UkiGYXh5LTRJwKhKFJzi8zhmDhbrLfBWRAxB6bxQxENp2wHl6uhnMK/9AHL
    5kFZWQrSfIV8ULwoUjIpvmxZ23eEMNnFqP1L5CGHxES4OhBn3OgNeHo75Ly4NivEKoJT
    7Rog==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6E6BT4HI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 14 Jul 2022 08:11:29 +0200 (CEST)
Message-ID: <ae995ec1-8dbd-7484-a250-28d8637eb6ff@hartkopp.net>
Date:   Thu, 14 Jul 2022 08:11:23 +0200
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
 <f00a4c5d-c4e6-06a2-76c0-53105d3465f2@hartkopp.net>
 <CAMZ6RqLVvYCoBF67VtqUSJHAxBHvEmK2-o8NCD7REZj1ywXf7w@mail.gmail.com>
 <521fe0a3-a9ad-60ac-3ec6-30f0da228032@hartkopp.net>
 <CAMZ6RqJhjkVgZgmfk7btYK+bLtqnbvGBYTnssy28ZWqyfyqppw@mail.gmail.com>
 <89f90d61-35a4-59a2-231b-4372d4dca25c@hartkopp.net>
 <CAMZ6Rq+LqfUhLcg6909=239a+Asm6aO-bPqpar2tQ_fs0EmiUQ@mail.gmail.com>
 <b866e05b-a548-132c-4427-7a4d21d12172@hartkopp.net>
 <CAMZ6RqLGWB-afDmZfV+qJU2g=XUycFS1o9j6EwqRVg_dyf4eOw@mail.gmail.com>
 <16457321-6a4f-4830-17aa-d6efd7a39555@hartkopp.net>
 <CAMZ6RqLSHAdB-ocj7=74zJqWbv-EH9x8X5ARPK6Gv+FFiTZ7Lg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLSHAdB-ocj7=74zJqWbv-EH9x8X5ARPK6Gv+FFiTZ7Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 14.07.22 03:23, Vincent Mailhol wrote:
> On Thu. 14 Jul. 2022 at 05:02, Oliver Hartkopp <socketcan@hartkopp.net> wrote:


> If we follow your idea, use __u8 xlsec in order to avoid undefined behaviours.
> 
>> Where we define
>>
>> #define CANXL_TAG 0x7F
> 
> Here, you "burn" all the flags for future usage.
> FYI, this doesn't have to be 0x7F. It could be any of the length
> values not allowed by CAN-FD, namely (in decimal): 9-11, 13-15, 17-19,
> 21-23, 25-31, 33-47, 49-63

Yes, I detected this issue too when waking up this morning ...

>> #define CANXL_SEC 0x80
> 
> I did not get why CANXL_XLF isn't needed anymore.
> 
>> which has to be set in the xlsec element then.
>>
>> With this move we get rid of any flags problems (we only need the SEC
>> bit anyway) and define a clear 'escape value' in the former length element.
> 
> If I try to bounce on your idea, I will propose:
> 
> /*********** begin **********/
> struct canxl_frame {
>          canid_t prio;  /* 11 bit priority for arbitration (canid_t) */
>          __u8    flags; /* additional flags for CAN XL. MSB must be set */
>          __u8    sdt;   /* SDU (service data unit) type */
>          __u16   len;   /* frame payload length in bytes */
>          __u32   af;    /* acceptance field */
>          __u8    data[];
> };

ACK.

> #define CANXL_XLF 0x01 /* mark CAN XL for dual use of struct canfd_frame */

IMO the dual use stuff between CAN FD & CAN XL is not working anymore 
and became obsolete here.

CAN_XLF needs to be a hard switch for CAN XL - no optional thing.

> #define CANXL_SEC 0x02 /* Simple Extended Content (security/segmentation) */
> #define CANXL_DISCRIMINATOR 0x80; /* Mandatory to distinguish between
> CAN(-FD) and XL frames */
> /*********** end ************/
> 
> This has no undefined behaviour and we still have five flags (0x04 to
> 0x40) for future use.
> 

I would suggest the following:

#define CANXL_XLF 0x80 /* mark CAN XL frame (must be set) */
#define CANXL_SEC 0x40 /* Simple Extended Content (security/segmentation) */

And the rest of the bits are reserved (shall be set to zero).

This way the CAN_XLF value would make the former 'len' element 128 - 
which is a proper distinction for CAN XL frames as such length value 
surely bounces on CAN/CANFD frames.

Best regards,
Oliver
