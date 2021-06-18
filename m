Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A5C3AC598
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhFRIDH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 04:03:07 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:40022 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhFRIDA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 04:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1624003228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cdx0lnD35FU0zWS7M/aFD/0+udR81CFLOOBC06iW+Bk=;
        b=oUl2+5MOmd5Oc6hfMLVzjEVFGUwnZu/ZwshOV2Z3E677xie1BaNwZXt2k3DmPUWMF0pKaa
        5uVoJ9VWfue2+PIeDG7OMK5wuaY/8G0R3jV/j6RmbB7RmSlhCMB278znuHStjsswaHHHEw
        URNCLya3euKmgoJA40NSJJtEepNJmok=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id ce60978d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Jun 2021 08:00:28 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] can: flexcan: add mcf5441x support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <20210616231652.738027-5-angelo@kernel-space.org>
 <20210617193823.w75gayd33jpmkw4d@pengutronix.de>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <3e47a1a4-c0c5-fd1e-ffa7-b9f217a9a859@kernel-space.org>
Date:   Fri, 18 Jun 2021 09:59:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210617193823.w75gayd33jpmkw4d@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 17/06/21 9:38 PM, Marc Kleine-Budde wrote:
> On 17.06.2021 01:16:52, Angelo Dureghello wrote:
>> Add flexcan support for NXP ColdFire mcf5441x family.
>>
>> This flexcan module is quite similar to imx6 flexcan module, but
>> with some exceptions:
>>
>> - 3 separate interrupt sources, MB, BOFF and ERR,
>> - implements 16 mb only,
>> - m68k architecture is not supporting devicetrees, so a
>>    platform data check/case has been added,
>> - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
>>    module.
>>
>> ---
>> Changes for v2:
>> - re-add platform data handling restarting from 2c0ac9208135
>> - re-add flexcan_id_table, as from 2c0ac9208135
>> - usinig irq resources for ERR and BOFF interrupts
>> - add missing free_irq() for interrupts
>> - minor syntax fixes
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>> ---
>>   drivers/net/can/flexcan.c | 95 ++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 84 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index 57f3635ad8d7..2188dc36a010 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/of_device.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/can/platform/mcf5441x.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>>   #include <linux/regulator/consumer.h>
>> @@ -246,6 +247,8 @@
>>   #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
>>   /* Setup stop mode with SCU firmware to support wakeup */
>>   #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
>> +/* Setup for flexcan module as in mcf, 16 mb, 3 separate interrupts  */
>> +#define FLEXCAN_QUIRK_SETUP_MCF BIT(12)
> 
> Can you split this into QUIRK_NR_IRQ_3 and QUIRK_NR_MB_16.
> 

done

> Marc
> 

-- 
Angelo Dureghello
+++ kernelspace +++
+E: angelo AT kernel-space.org
+W: www.kernel-space.org
