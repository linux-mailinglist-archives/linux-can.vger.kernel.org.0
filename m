Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6536CB7E4
	for <lists+linux-can@lfdr.de>; Tue, 28 Mar 2023 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjC1HWF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Mar 2023 03:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjC1HWC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Mar 2023 03:22:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7866C3C0A
        for <linux-can@vger.kernel.org>; Tue, 28 Mar 2023 00:22:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h9so11490705ljq.2
        for <linux-can@vger.kernel.org>; Tue, 28 Mar 2023 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1679988120;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6627CT3SbKGwcYm3l44erksg/Zqs3LxPLVQr6+OlQM=;
        b=edpioqGD8gH8KfEpEvdhBBmri0PGPpHvclm3fvkJRAHpSg4a3HslF9gxlWQecF4fto
         VXnG1O2HHJgEIpmttmxTdVeMPXukUccQWM3m3PwIAlYHPHBtdhShaTn5BAo8qhQoTBD1
         Id6C7evulh4DYAAPC0iEHHaJ16wgLnEhQsPG62RIbPSpoGXBU0weSFEM14r/o2Whe3us
         iMJvUK/OCCpDreL5F2++3uISfZAcsBpAUl4pGmcxcJ6CytFru2XCYc3/YvMFvw62g8YZ
         hmpxv4Gvy8UaouyD27whMiVZ+UR7GtY/IlX8Ve2kbB9QJtU++KpaqDs5OyHU+IDAIPua
         zqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988120;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6627CT3SbKGwcYm3l44erksg/Zqs3LxPLVQr6+OlQM=;
        b=zHikzkJj33aMXg67d4Fho5ywVQgYVVf6tONRyPEoXG+1ECKH+7jb5blDlDj8Cs1kWq
         /eaw8aX/MksRV3bnsO+v1TVjvgHkDYaBIMBchUC5sAGrQy9JtOoC9sBbVw6yqABypuxw
         4nHi8HM4ZDotFgq6f+EMww42O5fOPgro9yX5XeNShtRkeJ70af6wkWxdeUSQigU3rUv+
         lJJfaJbUpfFC5DoePlK8wQ3c/jMG7DzXudw714H3Fa1STbR4isYg6VaLywhGzeWh91nb
         5UcLB4iMXSZizwwosoxnW8MdmvrQNGxV4wzhlAS4RJuE6ZnCvc2RcSBrUyxkBAWy1hsb
         kyOA==
X-Gm-Message-State: AAQBX9eliVCiTBmFDdWKzzTmCNbFb/0UBYKPrfO8OcP7n/Pk1GAei5Ay
        gBVJAgyiGphoHbX7Kf9yaRIFS2QvFI1B8+K1Fts=
X-Google-Smtp-Source: AKy350ZuWhYvQHTUL9pcxrJdhUYBRHyT2C0pR73Al9oHrEc5fo8CeRaoFkTmf9ltshKPa0VkLmFMgA==
X-Received: by 2002:a2e:7a05:0:b0:295:b0c6:834c with SMTP id v5-20020a2e7a05000000b00295b0c6834cmr4377025ljc.41.1679988119719;
        Tue, 28 Mar 2023 00:21:59 -0700 (PDT)
Received: from [192.168.16.142] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c1-20020a2e6801000000b002a421ac8629sm1545157lja.49.2023.03.28.00.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:21:59 -0700 (PDT)
Message-ID: <d67784aa-aa21-d7b0-c79a-fa592685110e@kvaser.com>
Date:   Tue, 28 Mar 2023 09:21:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH can-next] kvaser_usb: convert USB IDs to hexadecimal
 values
Content-Language: en-US
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20230327175344.4668-1-socketcan@hartkopp.net>
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20230327175344.4668-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 3/27/23 19:53, Oliver Hartkopp wrote:
> USB IDs are usually represented in 16 bit hexadecimal values.
> To match the common representation in lsusb and for searching USB IDs
> in the internet convert the decimal values to hexadecimal.

Thanks for the patch!

I'm about drop the aligned block indentation, in favour of consistent
one space indentation, for the entire driver. Feel free to update the
patch, or I'll fix it in a separate patch later.

Acked-by: Jimmy Assarsson <extja@kvaser.com>

Best regards,
jimmy

> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Jimmy Assarsson <extja@kvaser.com>
> ---
>   .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 102 +++++++++---------
>   1 file changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index d4c5356d5884..d0015f83f924 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -29,67 +29,67 @@
>   #include <linux/can/netlink.h>
>   
>   #include "kvaser_usb.h"
>   
>   /* Kvaser USB vendor id. */
> -#define KVASER_VENDOR_ID			0x0bfd
> +#define KVASER_VENDOR_ID			0x0BFD
>   
>   /* Kvaser Leaf USB devices product ids */
> -#define USB_LEAF_DEVEL_PRODUCT_ID		10
> -#define USB_LEAF_LITE_PRODUCT_ID		11
> -#define USB_LEAF_PRO_PRODUCT_ID			12
> -#define USB_LEAF_SPRO_PRODUCT_ID		14
> -#define USB_LEAF_PRO_LS_PRODUCT_ID		15
> -#define USB_LEAF_PRO_SWC_PRODUCT_ID		16
> -#define USB_LEAF_PRO_LIN_PRODUCT_ID		17
> -#define USB_LEAF_SPRO_LS_PRODUCT_ID		18
> -#define USB_LEAF_SPRO_SWC_PRODUCT_ID		19
> -#define USB_MEMO2_DEVEL_PRODUCT_ID		22
> -#define USB_MEMO2_HSHS_PRODUCT_ID		23
> -#define USB_UPRO_HSHS_PRODUCT_ID		24
> -#define USB_LEAF_LITE_GI_PRODUCT_ID		25
> -#define USB_LEAF_PRO_OBDII_PRODUCT_ID		26
> -#define USB_MEMO2_HSLS_PRODUCT_ID		27
> -#define USB_LEAF_LITE_CH_PRODUCT_ID		28
> -#define USB_BLACKBIRD_SPRO_PRODUCT_ID		29
> -#define USB_OEM_MERCURY_PRODUCT_ID		34
> -#define USB_OEM_LEAF_PRODUCT_ID			35
> -#define USB_CAN_R_PRODUCT_ID			39
> -#define USB_LEAF_LITE_V2_PRODUCT_ID		288
> -#define USB_MINI_PCIE_HS_PRODUCT_ID		289
> -#define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID	290
> -#define USB_USBCAN_LIGHT_2HS_PRODUCT_ID		291
> -#define USB_MINI_PCIE_2HS_PRODUCT_ID		292
> -#define USB_USBCAN_R_V2_PRODUCT_ID		294
> -#define USB_LEAF_LIGHT_R_V2_PRODUCT_ID		295
> -#define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID	296
> +#define USB_LEAF_DEVEL_PRODUCT_ID		0x000A
> +#define USB_LEAF_LITE_PRODUCT_ID		0x000B
> +#define USB_LEAF_PRO_PRODUCT_ID			0x000C
> +#define USB_LEAF_SPRO_PRODUCT_ID		0x000E
> +#define USB_LEAF_PRO_LS_PRODUCT_ID		0x000F
> +#define USB_LEAF_PRO_SWC_PRODUCT_ID		0x0010
> +#define USB_LEAF_PRO_LIN_PRODUCT_ID		0x0011
> +#define USB_LEAF_SPRO_LS_PRODUCT_ID		0x0012
> +#define USB_LEAF_SPRO_SWC_PRODUCT_ID		0x0013
> +#define USB_MEMO2_DEVEL_PRODUCT_ID		0x0016
> +#define USB_MEMO2_HSHS_PRODUCT_ID		0x0017
> +#define USB_UPRO_HSHS_PRODUCT_ID		0x0018
> +#define USB_LEAF_LITE_GI_PRODUCT_ID		0x0019
> +#define USB_LEAF_PRO_OBDII_PRODUCT_ID		0x001A
> +#define USB_MEMO2_HSLS_PRODUCT_ID		0x001B
> +#define USB_LEAF_LITE_CH_PRODUCT_ID		0x001C
> +#define USB_BLACKBIRD_SPRO_PRODUCT_ID		0x001D
> +#define USB_OEM_MERCURY_PRODUCT_ID		0x0022
> +#define USB_OEM_LEAF_PRODUCT_ID			0x0023
> +#define USB_CAN_R_PRODUCT_ID			0x0027
> +#define USB_LEAF_LITE_V2_PRODUCT_ID		0x0120
> +#define USB_MINI_PCIE_HS_PRODUCT_ID		0x0121
> +#define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID	0x0122
> +#define USB_USBCAN_LIGHT_2HS_PRODUCT_ID		0x0123
> +#define USB_MINI_PCIE_2HS_PRODUCT_ID		0x0124
> +#define USB_USBCAN_R_V2_PRODUCT_ID		0x0126
> +#define USB_LEAF_LIGHT_R_V2_PRODUCT_ID		0x0127
> +#define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID	0x0128
>   
>   /* Kvaser USBCan-II devices product ids */
> -#define USB_USBCAN_REVB_PRODUCT_ID		2
> -#define USB_VCI2_PRODUCT_ID			3
> -#define USB_USBCAN2_PRODUCT_ID			4
> -#define USB_MEMORATOR_PRODUCT_ID		5
> +#define USB_USBCAN_REVB_PRODUCT_ID		0x0002
> +#define USB_VCI2_PRODUCT_ID			0x0003
> +#define USB_USBCAN2_PRODUCT_ID			0x0004
> +#define USB_MEMORATOR_PRODUCT_ID		0x0005
>   
>   /* Kvaser Minihydra USB devices product ids */
> -#define USB_BLACKBIRD_V2_PRODUCT_ID		258
> -#define USB_MEMO_PRO_5HS_PRODUCT_ID		260
> -#define USB_USBCAN_PRO_5HS_PRODUCT_ID		261
> -#define USB_USBCAN_LIGHT_4HS_PRODUCT_ID		262
> -#define USB_LEAF_PRO_HS_V2_PRODUCT_ID		263
> -#define USB_USBCAN_PRO_2HS_V2_PRODUCT_ID	264
> -#define USB_MEMO_2HS_PRODUCT_ID			265
> -#define USB_MEMO_PRO_2HS_V2_PRODUCT_ID		266
> -#define USB_HYBRID_2CANLIN_PRODUCT_ID		267
> -#define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID	268
> -#define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID	269
> -#define USB_HYBRID_PRO_2CANLIN_PRODUCT_ID	270
> -#define USB_U100_PRODUCT_ID			273
> -#define USB_U100P_PRODUCT_ID			274
> -#define USB_U100S_PRODUCT_ID			275
> -#define USB_USBCAN_PRO_4HS_PRODUCT_ID		276
> -#define USB_HYBRID_CANLIN_PRODUCT_ID		277
> -#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	278
> +#define USB_BLACKBIRD_V2_PRODUCT_ID		0x0102
> +#define USB_MEMO_PRO_5HS_PRODUCT_ID		0x0104
> +#define USB_USBCAN_PRO_5HS_PRODUCT_ID		0x0105
> +#define USB_USBCAN_LIGHT_4HS_PRODUCT_ID		0x0106
> +#define USB_LEAF_PRO_HS_V2_PRODUCT_ID		0x0107
> +#define USB_USBCAN_PRO_2HS_V2_PRODUCT_ID	0x0108
> +#define USB_MEMO_2HS_PRODUCT_ID			0x0109
> +#define USB_MEMO_PRO_2HS_V2_PRODUCT_ID		0x010A
> +#define USB_HYBRID_2CANLIN_PRODUCT_ID		0x010B
> +#define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID	0x010C
> +#define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID	0x010D
> +#define USB_HYBRID_PRO_2CANLIN_PRODUCT_ID	0x010E
> +#define USB_U100_PRODUCT_ID			0x0111
> +#define USB_U100P_PRODUCT_ID			0x0112
> +#define USB_U100S_PRODUCT_ID			0x0113
> +#define USB_USBCAN_PRO_4HS_PRODUCT_ID		0x0114
> +#define USB_HYBRID_CANLIN_PRODUCT_ID		0x0115
> +#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	0x0116
>   
>   static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
>   	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
>   	.ops = &kvaser_usb_hydra_dev_ops,
>   };
