Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB26CB9F0
	for <lists+linux-can@lfdr.de>; Tue, 28 Mar 2023 10:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjC1I4H (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Mar 2023 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1I4H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Mar 2023 04:56:07 -0400
X-Greylist: delayed 524 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 01:56:02 PDT
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB764C3C
        for <linux-can@vger.kernel.org>; Tue, 28 Mar 2023 01:56:02 -0700 (PDT)
Date:   Tue, 28 Mar 2023 10:46:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
        t=1679993235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
         references:references; bh=If2jsVMA2BX5lfw/5B618J24wOj7kR16E9WbHDnxnIA=;
        b=MsxUy4YTJoqsoE+Hj34hEFS3JQ1tGtxSk8rtBZZuDHvuh7CjyEnmqwBsG7UH/QsfqBSemK
        La5ujuO7bQb22qIDpu+DV7i27PIXzgbVN6ihcdogslDv6XfElXbNP4LyAnxHOJpy7jffgg
        WnA1kTAhV0GM/Gq2ijQA3AudR00qFgPm5FV4Z3JlKnVBfyB/kskMTeG5rQy1kJBM1fp0nL
        eCkBUxBkq07A/5FS2Fu54k91xMCfSqUmclfkeix3bQr4H1tVtxPlMQUWGBJ/YwVG17Ts+S
        ezj8U0gbJm0lmtUwhmpWps9kee9Az4/SlfF6LEb86whQw38yPhBZaYgzYUYjJA==
From:   Alexander Dahl <ada@thorsis.com>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH can-next] kvaser_usb: convert USB IDs to hexadecimal
 values
Message-ID: <4178cf9c-acdd-4e59-ab70-34623121936a@thorsis.com>
Mail-Followup-To: Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>
References: <20230327175344.4668-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327175344.4668-1-socketcan@hartkopp.net>
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver,

Am Mon, Mar 27, 2023 at 07:53:44PM +0200 schrieb Oliver Hartkopp:
> USB IDs are usually represented in 16 bit hexadecimal values.
> To match the common representation in lsusb and for searching USB IDs
> in the internet convert the decimal values to hexadecimal.

lsusb representation on my machines is lowercase for the letters a-f.
From a quick grep over drivers/usb I can see no clear preference, but
I'd say more use lowercase.

> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Jimmy Assarsson <extja@kvaser.com>
> ---
>  .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 102 +++++++++---------
>  1 file changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index d4c5356d5884..d0015f83f924 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -29,67 +29,67 @@
>  #include <linux/can/netlink.h>
>  
>  #include "kvaser_usb.h"
>  
>  /* Kvaser USB vendor id. */
> -#define KVASER_VENDOR_ID			0x0bfd
> +#define KVASER_VENDOR_ID			0x0BFD

That would also make this change not needed.

>  /* Kvaser Leaf USB devices product ids */
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

Decimal match hex.

>  /* Kvaser USBCan-II devices product ids */
> -#define USB_USBCAN_REVB_PRODUCT_ID		2
> -#define USB_VCI2_PRODUCT_ID			3
> -#define USB_USBCAN2_PRODUCT_ID			4
> -#define USB_MEMORATOR_PRODUCT_ID		5
> +#define USB_USBCAN_REVB_PRODUCT_ID		0x0002
> +#define USB_VCI2_PRODUCT_ID			0x0003
> +#define USB_USBCAN2_PRODUCT_ID			0x0004
> +#define USB_MEMORATOR_PRODUCT_ID		0x0005

Decimal match hex.

>  /* Kvaser Minihydra USB devices product ids */
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

Decimal match hex.  So for the actual values:

Reviewed-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

>  
>  static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
>  	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
>  	.ops = &kvaser_usb_hydra_dev_ops,
>  };
> -- 
> 2.30.2
> 
