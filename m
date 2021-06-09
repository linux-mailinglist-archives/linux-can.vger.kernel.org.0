Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5113A0E33
	for <lists+linux-can@lfdr.de>; Wed,  9 Jun 2021 09:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhFIIAo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Jun 2021 04:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbhFIIAo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Jun 2021 04:00:44 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C20C061574;
        Wed,  9 Jun 2021 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623225526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02VwZyIvMU268Hlo6xoR5zpfL4+9l3U6sVubHZrLxJ8=;
        b=NUXO8u2ist2YaaTlasjLsp8J4I3OzDn0PdLcZ44TXyB00qRO4NTw6+E/dZfta3V/04jCJA
        sF8+rmMqGavfUKzfVmwDHYKT0qUqec7lUhGE5PSrisJzDTH4mh8ooJ6O0SxQZ/+faMvAWU
        HsnusWLO5VvivdsNw56TE9BvxnD2F4w=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 4c6e8472 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Jun 2021 07:58:46 +0000 (UTC)
Subject: Re: [PATCH 1/5] can: flexcan: add platform data for ColdFire
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc:     "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20210608204542.983925-1-angelo@kernel-space.org>
 <DB8PR04MB6795AC38C4A930DFC5DF1A86E6369@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <ce4f4b47-bccb-582e-5c47-e20cbaa0d5c0@kernel-space.org>
Date:   Wed, 9 Jun 2021 09:57:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB6795AC38C4A930DFC5DF1A86E6369@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Joakim,

On 09/06/21 4:05 AM, Joakim Zhang wrote:
> 
>> -----Original Message-----
>> From: Angelo Dureghello <angelo@kernel-space.org>
>> Sent: 2021Äê6ÔÂ9ÈÕ 4:46
>> To: gerg@linux-m68k.org; wg@grandegger.com; mkl@pengutronix.de
>> Cc: geert@linux-m68k.org; linux-m68k@vger.kernel.org;
>> linux-can@vger.kernel.org; Joakim Zhang <qiangqing.zhang@nxp.com>;
>> Angelo Dureghello <angelo@kernel-space.org>
>> Subject: [PATCH 1/5] can: flexcan: add platform data for ColdFire
>>
>> Add platform data object for ColdFire architecture.
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>> ---
>>   include/linux/platform_data/flexcan-mcf.h | 27 +++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>   create mode 100644 include/linux/platform_data/flexcan-mcf.h
>>
>> diff --git a/include/linux/platform_data/flexcan-mcf.h
>> b/include/linux/platform_data/flexcan-mcf.h
>> new file mode 100644
>> index 000000000000..71fe1a9df084
>> --- /dev/null
>> +++ b/include/linux/platform_data/flexcan-mcf.h
> 
> Should locate CAN header file here? include/linux/can/platform/
> 

oh, missed that place, looks like that location is more correct,
sure, can move the file there.

> Best Regards,
> Joakim Zhang
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
>> +	int stop_mode;
>> +	int clk_src;
>> +	int clock_frequency;
>> +	bool big_endian;
>> +};
>> +
>> +#endif /* _PLAT_FLEXCAN_MCF_H */
>> --
>> 2.31.1
> 

Regards
-- 
Angelo Dureghello
+++ kernelspace +++
+E: angelo AT kernel-space.org
+W: www.kernel-space.org
