Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E933AAED8
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFQIen (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 04:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhFQIem (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 04:34:42 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C081C061574;
        Thu, 17 Jun 2021 01:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623918752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2AkFQA4SyGAsYdIx03Tt+EtMT/C62WlvayQWr70KNQ=;
        b=wZyDCDBYGbiACa2t8fjWJf736rkuAEbRGgaENJLpHdrPgl5n9cYj7MQz02V3zE+APDDMhD
        KYYI3EERZ+qiRigQ/kE8JcWO58Uf6tb+G8CFlOdXCuILI6/GyxIR7NVPFDn/Rb8qxRnhlw
        rC1Qmuc7bXhoXhQQFtnjSgxm5vE7EnI=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id bf22bdfd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Jun 2021 08:32:32 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] can: flexcan: add platform data for ColdFire
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <CAMuHMdXNsPnaP6xwm0=2naydnxPs2k2ivLTNnrE_bGnhORmaBQ@mail.gmail.com>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <21f07ecf-d222-46ef-b75e-28f647587551@kernel-space.org>
Date:   Thu, 17 Jun 2021 10:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXNsPnaP6xwm0=2naydnxPs2k2ivLTNnrE_bGnhORmaBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Geert,

On 17/06/21 10:28 AM, Geert Uytterhoeven wrote:
> Hi Angelo,
> 
> On Thu, Jun 17, 2021 at 1:17 AM Angelo Dureghello
> <angelo@kernel-space.org> wrote:
>> Add platform data object for ColdFire architecture.
>>
>> ---
>> Changes for v2:
>> - move header file in more proper location
>> - remove irq defines
>> - change variable types to match driver types
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/include/linux/can/platform/mcf5441x.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Flexcan options for ColdFire family
>> + *
>> + * Copyright (C) 2021  Angelo Dureghello <angelo@kernel-space.org>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef _PLAT_FLEXCAN_MCF_H
>> +#define _PLAT_FLEXCAN_MCF_H
>> +
>> +struct mcf_flexcan_platform_data {
>> +       u8 clk_src;
>> +       u32 clock_frequency;
>> +       bool big_endian;
> 
> Please sort the members according to decreasing size, to avoid
> holes.

sure, never thought to this, thanks,
> 
>> +};
>> +
>> +#define FLEXCAN_MCF5411X_MB_CNT_MCF    16
>> +
>> +#endif /* _PLAT_FLEXCAN_MCF_H */
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

Regards,
angelo
