Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0AF9B8009
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2019 19:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390917AbfISRcR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Sep 2019 13:32:17 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:15037 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbfISRcQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Sep 2019 13:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568914331;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=fjgcfhIKkIHhmIc1K7HZ6UmpIaPw8uQ2R2Hsqe9ZzEQ=;
        b=D/Az5R0HzkW8IPoUw1MSIjIE86EOh9XnRcVhBiXqTZNqdC43fL9WVOKBSJ3Ro/yjzR
        PPR3VyKtIvRyr5iPiYO7VCX5osu096OFMbCFH/lJU9FrpPdlr9UEE/RaDzaIjz4TPxS1
        6PreNVnDe1uCqYaMLFam++/qV0zcM6ZOpcoJxV3LFH0huoHc+HxiJmrvuZtGrAI6o75k
        FuuXwrjYjNOvuxBPYc55RF4oVlIX1W0CqtAH8/IXTh5Zl8OCdCfpd1KiWBHGYhzIhtKc
        3ZSpVqZfTKMl48JRyX1i7vq2fkLC6AwTbkD1BD5J8aRDumniM7o5BpIZq0DPFH/E4ixL
        6E6A==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUsh6k0zX"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id j0667fv8JHW9Cta
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 19 Sep 2019 19:32:09 +0200 (CEST)
Subject: Re: [PATCH] can: don't use deprecated license identifiers
To:     yegorslists@googlemail.com, linux-can@vger.kernel.org
Cc:     mkl@pengutronix.de, wg@grandegger.com
References: <20190919135304.14757-1-yegorslists@googlemail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <20e7b276-3955-d262-b65c-806e99f5ebc2@hartkopp.net>
Date:   Thu, 19 Sep 2019 19:32:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190919135304.14757-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 19/09/2019 15.53, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> GPL-2.0 license identifier changed to GPL-2.0-only in SPDX v3.0.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Yegor!

Best,
Oliver

> ---
>   include/uapi/linux/can/bcm.h     | 2 +-
>   include/uapi/linux/can/error.h   | 2 +-
>   include/uapi/linux/can/gw.h      | 2 +-
>   include/uapi/linux/can/j1939.h   | 2 +-
>   include/uapi/linux/can/netlink.h | 2 +-
>   include/uapi/linux/can/raw.h     | 2 +-
>   include/uapi/linux/can/vxcan.h   | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.h
> index 0fb328d93148..dd2b925b09ac 100644
> --- a/include/uapi/linux/can/bcm.h
> +++ b/include/uapi/linux/can/bcm.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
>   /*
>    * linux/can/bcm.h
>    *
> diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
> index bfc4b5d22a5e..34633283de64 100644
> --- a/include/uapi/linux/can/error.h
> +++ b/include/uapi/linux/can/error.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
>   /*
>    * linux/can/error.h
>    *
> diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
> index 3aea5388c8e4..c2190bbe21d8 100644
> --- a/include/uapi/linux/can/gw.h
> +++ b/include/uapi/linux/can/gw.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
>   /*
>    * linux/can/gw.h
>    *
> diff --git a/include/uapi/linux/can/j1939.h b/include/uapi/linux/can/j1939.h
> index c32325342d30..df6e821075c1 100644
> --- a/include/uapi/linux/can/j1939.h
> +++ b/include/uapi/linux/can/j1939.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>   /*
>    * j1939.h
>    *
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> index 1bc70d3a4d39..6f598b73839e 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>   /*
>    * linux/can/netlink.h
>    *
> diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
> index be3b36e7ff61..6a11d308eb5c 100644
> --- a/include/uapi/linux/can/raw.h
> +++ b/include/uapi/linux/can/raw.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
>   /*
>    * linux/can/raw.h
>    *
> diff --git a/include/uapi/linux/can/vxcan.h b/include/uapi/linux/can/vxcan.h
> index 066812d118a2..4fa9d8777a07 100644
> --- a/include/uapi/linux/can/vxcan.h
> +++ b/include/uapi/linux/can/vxcan.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>   #ifndef _UAPI_CAN_VXCAN_H
>   #define _UAPI_CAN_VXCAN_H
>   
> 
