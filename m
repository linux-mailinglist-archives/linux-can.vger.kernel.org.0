Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CD3AA7FF
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 02:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhFQATW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 20:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhFQATW (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 16 Jun 2021 20:19:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0DFB60E0B;
        Thu, 17 Jun 2021 00:17:13 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] can: flexcan: add platform data for ColdFire
To:     Angelo Dureghello <angelo@kernel-space.org>, wg@grandegger.com,
        mkl@pengutronix.de
Cc:     geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210616231652.738027-1-angelo@kernel-space.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <3f74ce4f-b4c5-d622-7cba-b4ce070fd967@linux-m68k.org>
Date:   Thu, 17 Jun 2021 10:17:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616231652.738027-1-angelo@kernel-space.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Angelo,

On 17/6/21 9:16 am, Angelo Dureghello wrote:
> Add platform data object for ColdFire architecture.
> 
> ---
> Changes for v2:
> - move header file in more proper location
> - remove irq defines
> - change variable types to match driver types
> 
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
>   include/linux/can/platform/mcf5441x.h | 28 +++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>   create mode 100644 include/linux/can/platform/mcf5441x.h
> 
> diff --git a/include/linux/can/platform/mcf5441x.h b/include/linux/can/platform/mcf5441x.h
> new file mode 100644
> index 000000000000..6866f0f60caf
> --- /dev/null
> +++ b/include/linux/can/platform/mcf5441x.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Flexcan options for ColdFire family
> + *
> + * Copyright (C) 2021  Angelo Dureghello <angelo@kernel-space.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _PLAT_FLEXCAN_MCF_H
> +#define _PLAT_FLEXCAN_MCF_H
> +
> +struct mcf_flexcan_platform_data {
> +	u8 clk_src;
> +	u32 clock_frequency;
> +	bool big_endian;
> +};
> +
> +#define FLEXCAN_MCF5411X_MB_CNT_MCF	16
> +
> +#endif /* _PLAT_FLEXCAN_MCF_H */

Is this actually specific to the ColdFire M5411x SoC?
I thought a number of other ColdFire parts also have canbus support.
Are they not all the same underlying hardware block?

So should this be more generic, say flexcan.h or mcf_flexcan.h or something like that?

Regards
Greg

