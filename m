Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784CD6CD54A
	for <lists+linux-can@lfdr.de>; Wed, 29 Mar 2023 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjC2Ixu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 29 Mar 2023 04:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjC2Ixt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 29 Mar 2023 04:53:49 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6240EC
        for <linux-can@vger.kernel.org>; Wed, 29 Mar 2023 01:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680080008; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kqQS/CXb9u747649bPTsWgL3ceQ8D/ewP35WLG4fAoqWscfiX4JKeccgEnjtPbO3HN
    LXnh9DCdbg2pvOcvIxPWHftRVWPMqoB70MXNBD3uvgikzanhR+mRjsV/i2JNQITOXOrK
    GSvs7a6J+u2dx4s1CDIZriAJFTsFLHlZE5q1x64GljsYFeaMONtWhipHGJkcG/MxCT+m
    H34qCgD8JCfyyRuO2Ryj3WpI9ZgEvvVWfGT98dPfEz/c6ZA3tjkQM7Z/t8dOQMHD+7SE
    yd5JtcQbSJFNDMwGSxx+Bva6VAqRLV7c0RawGkbVAVelpPq0t/1pUGwFRXsDRXaOxamJ
    vbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680080008;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HWXXkgvkfhLTWKFG3Z/oZJJjHgqrVcmjRAIWCjaoVgA=;
    b=r+moKyN4n3fqzbcedqjnr8wVJe0Rjfq0+kdTsIt4k4S8pWdydfTfnVG6+LFhZ6ElTx
    n/gbmtjKHnH2TrEf6+bKo5LB8YlKtT2/+8Ay26KkdDplLyndNBRscFQj817okeO6uqZ9
    mNE1sg7rCjTaa7gL2Zt5ygWduQolwaF3yqIQTGgnWsNeYRLIJfe67aTS53DtjFvN2YYb
    iOsJhnmD/a6RKGVP4P5Ddg3koDGVk8MOoXvB44acBJKTNfufm2Fs2Xs+Z+2TbfSvDvGy
    bmthSxS2lEtlKnvHNwod6H2WoArOzuG8mdc2yG9T8ogx865z6s6IN+4M0d73UqD8xfIf
    AhoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680080008;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HWXXkgvkfhLTWKFG3Z/oZJJjHgqrVcmjRAIWCjaoVgA=;
    b=BDXtkwGvZBfOFbHCZBA1/qSfeKG/fRK3WjPn2/TlQSkezan2/IWrjk0m2/XviqwUZ5
    TZIeSnlRwe4hY7wUXL6Hcy+6kkStD9DX27bNWlXBijAevUkX7ZE6qP5A7ICfcHiVfYHp
    4U3sO158O35LohYppQHWOxBeC6osUzjH+K+4Tr/AoWkICbW5Whgs7/7elh5Uq/17PLh6
    mkX8AifuJHdx8J/ItxPV7Ob7Wa6JsZny8vU2pHAgZBp+9ru0Pbw0/gwb62osoqHKIoaT
    WJc7bhl7+Judgx92BCh/xmxFmjJ6tJQ2R504wuvOszCKsuC1bf932ZwezPngLYLKoiwA
    toGA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3jXdVqE32oRVrGn+Gi68g=="
Received: from [100.82.11.2]
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id n9397fz2T8rRbmr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 29 Mar 2023 10:53:27 +0200 (CEST)
Message-ID: <6f479387-81d7-c253-d12c-e1b4577362e0@hartkopp.net>
Date:   Wed, 29 Mar 2023 10:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH can-next] kvaser_usb: convert USB IDs to hexadecimal
 values
To:     Alexander Dahl <ada@thorsis.com>
References: <20230327175344.4668-1-socketcan@hartkopp.net>
 <4178cf9c-acdd-4e59-ab70-34623121936a@thorsis.com>
Content-Language: en-US
Cc:     linux-can@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <4178cf9c-acdd-4e59-ab70-34623121936a@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 28.03.23 10:46, Alexander Dahl wrote:
> Hello Oliver,
> 
> Am Mon, Mar 27, 2023 at 07:53:44PM +0200 schrieb Oliver Hartkopp:
>> USB IDs are usually represented in 16 bit hexadecimal values.
>> To match the common representation in lsusb and for searching USB IDs
>> in the internet convert the decimal values to hexadecimal.
> 
> lsusb representation on my machines is lowercase for the letters a-f.
>  From a quick grep over drivers/usb I can see no clear preference, but
> I'd say more use lowercase.
> 

That's right!

I will send a V2 having the hex values lower case.

>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Cc: Jimmy Assarsson <extja@kvaser.com>
>> ---
>>   .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 102 +++++++++---------
>>   1 file changed, 51 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>> index d4c5356d5884..d0015f83f924 100644
>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>> @@ -29,67 +29,67 @@
>>   #include <linux/can/netlink.h>
>>   
>>   #include "kvaser_usb.h"
>>   
>>   /* Kvaser USB vendor id. */
>> -#define KVASER_VENDOR_ID			0x0bfd
>> +#define KVASER_VENDOR_ID			0x0BFD
> 
> That would also make this change not needed.
> 

ACK

>>   /* Kvaser Leaf USB devices product ids */
>> -#define USB_LEAF_DEVEL_PRODUCT_ID		10
>> -#define USB_LEAF_LITE_PRODUCT_ID		11
>> -#define USB_LEAF_PRO_PRODUCT_ID			12
>> -#define USB_LEAF_SPRO_PRODUCT_ID		14
>> -#define USB_LEAF_PRO_LS_PRODUCT_ID		15
>> -#define USB_LEAF_PRO_SWC_PRODUCT_ID		16
>> -#define USB_LEAF_PRO_LIN_PRODUCT_ID		17
>> -#define USB_LEAF_SPRO_LS_PRODUCT_ID		18
>> -#define USB_LEAF_SPRO_SWC_PRODUCT_ID		19
>> -#define USB_MEMO2_DEVEL_PRODUCT_ID		22
>> -#define USB_MEMO2_HSHS_PRODUCT_ID		23
>> -#define USB_UPRO_HSHS_PRODUCT_ID		24
>> -#define USB_LEAF_LITE_GI_PRODUCT_ID		25
>> -#define USB_LEAF_PRO_OBDII_PRODUCT_ID		26
>> -#define USB_MEMO2_HSLS_PRODUCT_ID		27
>> -#define USB_LEAF_LITE_CH_PRODUCT_ID		28
>> -#define USB_BLACKBIRD_SPRO_PRODUCT_ID		29
>> -#define USB_OEM_MERCURY_PRODUCT_ID		34
>> -#define USB_OEM_LEAF_PRODUCT_ID			35
>> -#define USB_CAN_R_PRODUCT_ID			39
>> -#define USB_LEAF_LITE_V2_PRODUCT_ID		288
>> -#define USB_MINI_PCIE_HS_PRODUCT_ID		289
>> -#define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID	290
>> -#define USB_USBCAN_LIGHT_2HS_PRODUCT_ID		291
>> -#define USB_MINI_PCIE_2HS_PRODUCT_ID		292
>> -#define USB_USBCAN_R_V2_PRODUCT_ID		294
>> -#define USB_LEAF_LIGHT_R_V2_PRODUCT_ID		295
>> -#define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID	296
>> +#define USB_LEAF_DEVEL_PRODUCT_ID		0x000A
>> +#define USB_LEAF_LITE_PRODUCT_ID		0x000B
>> +#define USB_LEAF_PRO_PRODUCT_ID			0x000C
>> +#define USB_LEAF_SPRO_PRODUCT_ID		0x000E
>> +#define USB_LEAF_PRO_LS_PRODUCT_ID		0x000F
>> +#define USB_LEAF_PRO_SWC_PRODUCT_ID		0x0010
>> +#define USB_LEAF_PRO_LIN_PRODUCT_ID		0x0011
>> +#define USB_LEAF_SPRO_LS_PRODUCT_ID		0x0012
>> +#define USB_LEAF_SPRO_SWC_PRODUCT_ID		0x0013
>> +#define USB_MEMO2_DEVEL_PRODUCT_ID		0x0016
>> +#define USB_MEMO2_HSHS_PRODUCT_ID		0x0017
>> +#define USB_UPRO_HSHS_PRODUCT_ID		0x0018
>> +#define USB_LEAF_LITE_GI_PRODUCT_ID		0x0019
>> +#define USB_LEAF_PRO_OBDII_PRODUCT_ID		0x001A
>> +#define USB_MEMO2_HSLS_PRODUCT_ID		0x001B
>> +#define USB_LEAF_LITE_CH_PRODUCT_ID		0x001C
>> +#define USB_BLACKBIRD_SPRO_PRODUCT_ID		0x001D
>> +#define USB_OEM_MERCURY_PRODUCT_ID		0x0022
>> +#define USB_OEM_LEAF_PRODUCT_ID			0x0023
>> +#define USB_CAN_R_PRODUCT_ID			0x0027
>> +#define USB_LEAF_LITE_V2_PRODUCT_ID		0x0120
>> +#define USB_MINI_PCIE_HS_PRODUCT_ID		0x0121
>> +#define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID	0x0122
>> +#define USB_USBCAN_LIGHT_2HS_PRODUCT_ID		0x0123
>> +#define USB_MINI_PCIE_2HS_PRODUCT_ID		0x0124
>> +#define USB_USBCAN_R_V2_PRODUCT_ID		0x0126
>> +#define USB_LEAF_LIGHT_R_V2_PRODUCT_ID		0x0127
>> +#define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID	0x0128
> 
> Decimal match hex.
> 
>>   /* Kvaser USBCan-II devices product ids */
>> -#define USB_USBCAN_REVB_PRODUCT_ID		2
>> -#define USB_VCI2_PRODUCT_ID			3
>> -#define USB_USBCAN2_PRODUCT_ID			4
>> -#define USB_MEMORATOR_PRODUCT_ID		5
>> +#define USB_USBCAN_REVB_PRODUCT_ID		0x0002
>> +#define USB_VCI2_PRODUCT_ID			0x0003
>> +#define USB_USBCAN2_PRODUCT_ID			0x0004
>> +#define USB_MEMORATOR_PRODUCT_ID		0x0005
> 
> Decimal match hex.
> 
>>   /* Kvaser Minihydra USB devices product ids */
>> -#define USB_BLACKBIRD_V2_PRODUCT_ID		258
>> -#define USB_MEMO_PRO_5HS_PRODUCT_ID		260
>> -#define USB_USBCAN_PRO_5HS_PRODUCT_ID		261
>> -#define USB_USBCAN_LIGHT_4HS_PRODUCT_ID		262
>> -#define USB_LEAF_PRO_HS_V2_PRODUCT_ID		263
>> -#define USB_USBCAN_PRO_2HS_V2_PRODUCT_ID	264
>> -#define USB_MEMO_2HS_PRODUCT_ID			265
>> -#define USB_MEMO_PRO_2HS_V2_PRODUCT_ID		266
>> -#define USB_HYBRID_2CANLIN_PRODUCT_ID		267
>> -#define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID	268
>> -#define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID	269
>> -#define USB_HYBRID_PRO_2CANLIN_PRODUCT_ID	270
>> -#define USB_U100_PRODUCT_ID			273
>> -#define USB_U100P_PRODUCT_ID			274
>> -#define USB_U100S_PRODUCT_ID			275
>> -#define USB_USBCAN_PRO_4HS_PRODUCT_ID		276
>> -#define USB_HYBRID_CANLIN_PRODUCT_ID		277
>> -#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	278
>> +#define USB_BLACKBIRD_V2_PRODUCT_ID		0x0102
>> +#define USB_MEMO_PRO_5HS_PRODUCT_ID		0x0104
>> +#define USB_USBCAN_PRO_5HS_PRODUCT_ID		0x0105
>> +#define USB_USBCAN_LIGHT_4HS_PRODUCT_ID		0x0106
>> +#define USB_LEAF_PRO_HS_V2_PRODUCT_ID		0x0107
>> +#define USB_USBCAN_PRO_2HS_V2_PRODUCT_ID	0x0108
>> +#define USB_MEMO_2HS_PRODUCT_ID			0x0109
>> +#define USB_MEMO_PRO_2HS_V2_PRODUCT_ID		0x010A
>> +#define USB_HYBRID_2CANLIN_PRODUCT_ID		0x010B
>> +#define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID	0x010C
>> +#define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID	0x010D
>> +#define USB_HYBRID_PRO_2CANLIN_PRODUCT_ID	0x010E
>> +#define USB_U100_PRODUCT_ID			0x0111
>> +#define USB_U100P_PRODUCT_ID			0x0112
>> +#define USB_U100S_PRODUCT_ID			0x0113
>> +#define USB_USBCAN_PRO_4HS_PRODUCT_ID		0x0114
>> +#define USB_HYBRID_CANLIN_PRODUCT_ID		0x0115
>> +#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	0x0116
> 
> Decimal match hex.  So for the actual values:

:-D

So how did you test that?

In fact I cut out the values and imported them into LibreOffice Calc to 
use DEC2HEX() ...

Seems to do the job ;-)

> 
> Reviewed-by: Alexander Dahl <ada@thorsis.com>
> 

Thanks,
Oliver


> Greets
> Alex
> 
>>   
>>   static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
>>   	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
>>   	.ops = &kvaser_usb_hydra_dev_ops,
>>   };
>> -- 
>> 2.30.2
>>
