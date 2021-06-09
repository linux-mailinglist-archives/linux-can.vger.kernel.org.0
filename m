Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6193A0F27
	for <lists+linux-can@lfdr.de>; Wed,  9 Jun 2021 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhFII7m (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Jun 2021 04:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhFII7l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Jun 2021 04:59:41 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DA8C061574;
        Wed,  9 Jun 2021 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623229064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ts8ARSytOiT03XGj55j5IOi017p9srvtcFTDeZw1aWM=;
        b=PI6/fLRXI6fL23fg8h5uD34H9Yjr0flv9pZ84CVE1nAgtj8XA+e+gGK1VWnjuSa5FanJFt
        PyoavKDZTspizfXDsaG/t1S4ZYOuHW7TIjeQfHzNujLvKlarC1EPsuzuhA5xxl8N+Lnf/f
        DFGEmqhqFSGViQI4i4w1gZmsvNSsIB0=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 104f236b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Jun 2021 08:57:44 +0000 (UTC)
Subject: Re: [PATCH 1/5] can: flexcan: add platform data for ColdFire
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210608204542.983925-1-angelo@kernel-space.org>
 <CAMuHMdUCatwWyoEwLDTfStePduFGFg4BykFdYCskk=ZLTiS0TA@mail.gmail.com>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <be92d6d6-7c8a-88da-3e85-de2d6636d1c1@kernel-space.org>
Date:   Wed, 9 Jun 2021 10:56:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUCatwWyoEwLDTfStePduFGFg4BykFdYCskk=ZLTiS0TA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Geert,

On 09/06/21 10:14 AM, Geert Uytterhoeven wrote:
> Hi Angelo,
> 
> On Tue, Jun 8, 2021 at 10:46 PM Angelo Dureghello
> <angelo@kernel-space.org> wrote:
>> Add platform data object for ColdFire architecture.
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/include/linux/platform_data/flexcan-mcf.h
>> @@ -0,0 +1,27 @@
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
>> +       int stop_mode;
> 
> Unused?

yes, unused for now, removed

> 
>> +       int clk_src;
>> +       int clock_frequency;
> 
> Might be worthwhile to match the types used in the driver
> (i.e. u8 and u32).
> 
done, thanks

>> +       bool big_endian;
>> +};
>> +
>> +#endif /* _PLAT_FLEXCAN_MCF_H */
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

Regards,
-- 
Angelo Dureghello
+++ kernelspace +++
+E: angelo AT kernel-space.org
+W: www.kernel-space.org
