Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880226CD5B4
	for <lists+linux-can@lfdr.de>; Wed, 29 Mar 2023 11:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjC2JAW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 29 Mar 2023 05:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjC2JAC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 29 Mar 2023 05:00:02 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB649E8
        for <linux-can@vger.kernel.org>; Wed, 29 Mar 2023 01:59:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680080157; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ov5N4U0rtPuQqzywhxwEISDAONC1o5OD3aNwamqmz4u4IdZxCssuhy7UvUCDDnh/R2
    QphKF33Dkm3e1msQ6sH6ppUGFBe9Ka1ZTGGyYQpCA+CrCT9M9WFyARfvtxT/ku3WQWgb
    p1fKz0XZJeLnkptrLs0wPlvC+qT3h+um2E1711NYTCHNww8ZmisaxcZZrZNM/CauAz9a
    5n5zBKWgH9XunIY0aRIYHqVXmNz92+hbCFTdPrqvaIJHgZnW7qjcwHDRyGNRnVnnicUI
    cuqcYXGk8o6EvKEfVAZTZkm2QXBWSAnrg0mIO85OsXXWUA3kSQ2FjkYcTbL3WEledt9E
    E/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680080157;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=TOIjafr2gdi6d+IIZOmZjdX32l/CgnDdHnYeiSbiexI=;
    b=gOB1GCzPuJSSJiirv9tIOJiagMMZk7hrGXrm8OoXQghUqbRVz3ZC3pZRu558VpxYGp
    vMuHvQ+5dEknEgfgRj4HJtOTU91UqaPBqWXV/6cbIsZUkQDaYiAJjblAkQT1gfXxoTvH
    v71/CEriTntiUp0SG33+VQrrzKg4j3339MxCOSZh8Ok3KTpe9qbYR9zdKlAt8i1XduS4
    FOYykxYFvd6Cjwg9cWJUnOtlxLgVQFih6jwvdX235q+3yUu3gOOmiRHs94u4aEXgVRpU
    6G5RhlmEQwJVEDV6AgK4UJxnRuXVGn8+4VHIcaigkA7kfBkM1sINGy+1+mUceEeOSRAd
    I2qw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680080157;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=TOIjafr2gdi6d+IIZOmZjdX32l/CgnDdHnYeiSbiexI=;
    b=esVUfaPycf99GYPm2mDIMia/aysEnU7LgTSOLnFPfKvDRN/r99zHsKskp1jKZD/ENE
    J8ivPyzm/daEuflDLhzzpbq8ZwLd46wxCqVZhXrYf70AcoRjuEwKL/v8ZaDGQ06yCuiy
    fAFqFRlo4WjpPtpDQ5b1B0q37rDXQW/80hwqCLTqPM3VMe6NUevt5XbLhquhx8QF2beY
    uV7tgDxILS+LMe3J7XOKeCSRUzkhZYCrCzHBD5auGutqZoVQ7HBkjxOSFBq2HsVfYta0
    D4BNbEvrDKzC/K0SIIgzulZUcCli1ty8PjqbgKwxm212Yr3l8Zcu5cmLGJNPSWlOm25s
    k8jQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3jXdVqE32oRVrGn+Gi68g=="
Received: from [100.82.11.2]
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2T8tvbnx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 29 Mar 2023 10:55:57 +0200 (CEST)
Message-ID: <c8837977-c106-ce80-993f-dd17ce9fbb2e@hartkopp.net>
Date:   Wed, 29 Mar 2023 10:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH can-next] kvaser_usb: convert USB IDs to hexadecimal
 values
Content-Language: en-US
To:     Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
References: <20230327175344.4668-1-socketcan@hartkopp.net>
 <d67784aa-aa21-d7b0-c79a-fa592685110e@kvaser.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <d67784aa-aa21-d7b0-c79a-fa592685110e@kvaser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 28.03.23 09:21, Jimmy Assarsson wrote:
> On 3/27/23 19:53, Oliver Hartkopp wrote:
>> USB IDs are usually represented in 16 bit hexadecimal values.
>> To match the common representation in lsusb and for searching USB IDs
>> in the internet convert the decimal values to hexadecimal.
> 
> Thanks for the patch!
> 
> I'm about drop the aligned block indentation, in favour of consistent
> one space indentation, for the entire driver. Feel free to update the
> patch, or I'll fix it in a separate patch later.
> 

As I will send a V2 with lowercase hex letters anyway I can directly 
replace the block indentation with a single space.

> Acked-by: Jimmy Assarsson <extja@kvaser.com>

Many thanks,
Oliver

> 
> Best regards,
> jimmy
> 
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Cc: Jimmy Assarsson <extja@kvaser.com>
>> ---
>>   .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 102 +++++++++---------
>>   1 file changed, 51 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c 
>> b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>> index d4c5356d5884..d0015f83f924 100644
>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>> @@ -29,67 +29,67 @@
>>   #include <linux/can/netlink.h>
>>   #include "kvaser_usb.h"
>>   /* Kvaser USB vendor id. */
>> -#define KVASER_VENDOR_ID            0x0bfd
>> +#define KVASER_VENDOR_ID            0x0BFD
>>   /* Kvaser Leaf USB devices product ids */
>> -#define USB_LEAF_DEVEL_PRODUCT_ID        10
>> -#define USB_LEAF_LITE_PRODUCT_ID        11
>> -#define USB_LEAF_PRO_PRODUCT_ID            12
>> -#define USB_LEAF_SPRO_PRODUCT_ID        14
>> -#define USB_LEAF_PRO_LS_PRODUCT_ID        15
>> -#define USB_LEAF_PRO_SWC_PRODUCT_ID        16
>> -#define USB_LEAF_PRO_LIN_PRODUCT_ID        17
>> -#define USB_LEAF_SPRO_LS_PRODUCT_ID        18
>> -#define USB_LEAF_SPRO_SWC_PRODUCT_ID        19
>> -#define USB_MEMO2_DEVEL_PRODUCT_ID        22
>> -#define USB_MEMO2_HSHS_PRODUCT_ID        23
>> -#define USB_UPRO_HSHS_PRODUCT_ID        24
>> -#define USB_LEAF_LITE_GI_PRODUCT_ID        25
>> -#define USB_LEAF_PRO_OBDII_PRODUCT_ID        26
>> -#define USB_MEMO2_HSLS_PRODUCT_ID        27
>> -#define USB_LEAF_LITE_CH_PRODUCT_ID        28
>> -#define USB_BLACKBIRD_SPRO_PRODUCT_ID        29
>> -#define USB_OEM_MERCURY_PRODUCT_ID        34
>> -#define USB_OEM_LEAF_PRODUCT_ID            35
>> -#define USB_CAN_R_PRODUCT_ID            39
>> -#define USB_LEAF_LITE_V2_PRODUCT_ID        288
>> -#define USB_MINI_PCIE_HS_PRODUCT_ID        289
>> -#define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID    290
>> -#define USB_USBCAN_LIGHT_2HS_PRODUCT_ID        291
>> -#define USB_MINI_PCIE_2HS_PRODUCT_ID        292
>> -#define USB_USBCAN_R_V2_PRODUCT_ID        294
>> -#define USB_LEAF_LIGHT_R_V2_PRODUCT_ID        295
>> -#define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID    296
>> +#define USB_LEAF_DEVEL_PRODUCT_ID        0x000A
>> +#define USB_LEAF_LITE_PRODUCT_ID        0x000B
>> +#define USB_LEAF_PRO_PRODUCT_ID            0x000C
>> +#define USB_LEAF_SPRO_PRODUCT_ID        0x000E
>> +#define USB_LEAF_PRO_LS_PRODUCT_ID        0x000F
>> +#define USB_LEAF_PRO_SWC_PRODUCT_ID        0x0010
>> +#define USB_LEAF_PRO_LIN_PRODUCT_ID        0x0011
>> +#define USB_LEAF_SPRO_LS_PRODUCT_ID        0x0012
>> +#define USB_LEAF_SPRO_SWC_PRODUCT_ID        0x0013
>> +#define USB_MEMO2_DEVEL_PRODUCT_ID        0x0016
>> +#define USB_MEMO2_HSHS_PRODUCT_ID        0x0017
>> +#define USB_UPRO_HSHS_PRODUCT_ID        0x0018
>> +#define USB_LEAF_LITE_GI_PRODUCT_ID        0x0019
>> +#define USB_LEAF_PRO_OBDII_PRODUCT_ID        0x001A
>> +#define USB_MEMO2_HSLS_PRODUCT_ID        0x001B
>> +#define USB_LEAF_LITE_CH_PRODUCT_ID        0x001C
>> +#define USB_BLACKBIRD_SPRO_PRODUCT_ID        0x001D
>> +#define USB_OEM_MERCURY_PRODUCT_ID        0x0022
>> +#define USB_OEM_LEAF_PRODUCT_ID            0x0023
>> +#define USB_CAN_R_PRODUCT_ID            0x0027
>> +#define USB_LEAF_LITE_V2_PRODUCT_ID        0x0120
>> +#define USB_MINI_PCIE_HS_PRODUCT_ID        0x0121
>> +#define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID    0x0122
>> +#define USB_USBCAN_LIGHT_2HS_PRODUCT_ID        0x0123
>> +#define USB_MINI_PCIE_2HS_PRODUCT_ID        0x0124
>> +#define USB_USBCAN_R_V2_PRODUCT_ID        0x0126
>> +#define USB_LEAF_LIGHT_R_V2_PRODUCT_ID        0x0127
>> +#define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID    0x0128
>>   /* Kvaser USBCan-II devices product ids */
>> -#define USB_USBCAN_REVB_PRODUCT_ID        2
>> -#define USB_VCI2_PRODUCT_ID            3
>> -#define USB_USBCAN2_PRODUCT_ID            4
>> -#define USB_MEMORATOR_PRODUCT_ID        5
>> +#define USB_USBCAN_REVB_PRODUCT_ID        0x0002
>> +#define USB_VCI2_PRODUCT_ID            0x0003
>> +#define USB_USBCAN2_PRODUCT_ID            0x0004
>> +#define USB_MEMORATOR_PRODUCT_ID        0x0005
>>   /* Kvaser Minihydra USB devices product ids */
>> -#define USB_BLACKBIRD_V2_PRODUCT_ID        258
>> -#define USB_MEMO_PRO_5HS_PRODUCT_ID        260
>> -#define USB_USBCAN_PRO_5HS_PRODUCT_ID        261
>> -#define USB_USBCAN_LIGHT_4HS_PRODUCT_ID        262
>> -#define USB_LEAF_PRO_HS_V2_PRODUCT_ID        263
>> -#define USB_USBCAN_PRO_2HS_V2_PRODUCT_ID    264
>> -#define USB_MEMO_2HS_PRODUCT_ID            265
>> -#define USB_MEMO_PRO_2HS_V2_PRODUCT_ID        266
>> -#define USB_HYBRID_2CANLIN_PRODUCT_ID        267
>> -#define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID    268
>> -#define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID    269
>> -#define USB_HYBRID_PRO_2CANLIN_PRODUCT_ID    270
>> -#define USB_U100_PRODUCT_ID            273
>> -#define USB_U100P_PRODUCT_ID            274
>> -#define USB_U100S_PRODUCT_ID            275
>> -#define USB_USBCAN_PRO_4HS_PRODUCT_ID        276
>> -#define USB_HYBRID_CANLIN_PRODUCT_ID        277
>> -#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID    278
>> +#define USB_BLACKBIRD_V2_PRODUCT_ID        0x0102
>> +#define USB_MEMO_PRO_5HS_PRODUCT_ID        0x0104
>> +#define USB_USBCAN_PRO_5HS_PRODUCT_ID        0x0105
>> +#define USB_USBCAN_LIGHT_4HS_PRODUCT_ID        0x0106
>> +#define USB_LEAF_PRO_HS_V2_PRODUCT_ID        0x0107
>> +#define USB_USBCAN_PRO_2HS_V2_PRODUCT_ID    0x0108
>> +#define USB_MEMO_2HS_PRODUCT_ID            0x0109
>> +#define USB_MEMO_PRO_2HS_V2_PRODUCT_ID        0x010A
>> +#define USB_HYBRID_2CANLIN_PRODUCT_ID        0x010B
>> +#define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID    0x010C
>> +#define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID    0x010D
>> +#define USB_HYBRID_PRO_2CANLIN_PRODUCT_ID    0x010E
>> +#define USB_U100_PRODUCT_ID            0x0111
>> +#define USB_U100P_PRODUCT_ID            0x0112
>> +#define USB_U100S_PRODUCT_ID            0x0113
>> +#define USB_USBCAN_PRO_4HS_PRODUCT_ID        0x0114
>> +#define USB_HYBRID_CANLIN_PRODUCT_ID        0x0115
>> +#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID    0x0116
>>   static const struct kvaser_usb_driver_info 
>> kvaser_usb_driver_info_hydra = {
>>       .quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
>>       .ops = &kvaser_usb_hydra_dev_ops,
>>   };
