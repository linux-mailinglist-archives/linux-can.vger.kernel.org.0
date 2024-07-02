Return-Path: <linux-can+bounces-945-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D768C924871
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 21:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9CA28A66E
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C212F1CCCDA;
	Tue,  2 Jul 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhRVuTzl"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B016E5ED
	for <linux-can@vger.kernel.org>; Tue,  2 Jul 2024 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949043; cv=none; b=A/dKo36LK+RItCsm/hYK40RafePx9AGcQgDpKFI+QQs+TyProh7c/lboJU1igZDqBVISWsd9CbVsg2U0ToQtBKj4dAcU3f5vOzpt8BlHUuewVlS8cSjHiXorbIw2mtGa3iL98RLyCkdbFGDeFSPaB5oEA+IgvjOKrY6ZiJzob7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949043; c=relaxed/simple;
	bh=SyRR4GocI2hve7hGU/rFRjfaevKAtJ9bpLqr5+r0qS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCRfbvdZ6KEfILAUI1leIOwFd5zF4tSHDCH9feI3xsqyBQhwORcVKt1NtYcfl/r/MPtcmx/UEbEVUksk+mHkU4oKXhND4VJ3r/Gm/cpy8q3Ovg7tflemNQNUT39Rnlo0IUabf5SKVcAADgZBiUJPGF+DMa54xbOkG9y2wtKfcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhRVuTzl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e9380add2so1049261e87.3
        for <linux-can@vger.kernel.org>; Tue, 02 Jul 2024 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719949040; x=1720553840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVU9kPt4ZOYL/HD3K9WK0yJf2QlU/4CnE3YcD3nW7Bg=;
        b=YhRVuTzlEFmDA6ffSrboptiWP5trYNAgh+mAbsX1wol5+ZJ6RgXKUOrKoB3r4OgjUD
         gdmCsLsIY2IBLSzMOhoVwI7Ux8WUCDXxGofcF94g5YhTLQnR7mwsgKSXh8Xnv9xSn/kg
         c9x28Qmzgdqlt7p7rN9OR5wpXbtB8DB8RYW60CvZ7kUH25OQ/nF5zdHF8s2Yz3hRcUgr
         HwKdU2xN1ShCDuB+KQbQ8tRGOfhj+QXgueR85G1w5eVbS2XYaq18JJtaobwDHCRtYTKE
         z6YF49jyFcBMnIFIU+sIgzAf6yWw4Bw2AdGBC0Nc/JxCSiDKyFjIk6ZXxbCC5YTi3MHC
         pLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719949040; x=1720553840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVU9kPt4ZOYL/HD3K9WK0yJf2QlU/4CnE3YcD3nW7Bg=;
        b=nih/2tv0ta1Dj/LUuIo2Q0VqEp4lo0KELV3pEHmStWDckIDeVUsVf+1IaaP4a7PcJ1
         wqpbQdVoYTkMF1B042jbhIMX/gtY817htjeZaPUuu+fxm/Qi4idt0e2OjfDLUw0igoFM
         uzTqb8WfxPOl1CH846HeX6O0rT04EOrBYqwnR/SiBI34jFvvUObG0iZu9iBzpqlFDsae
         zoPtRIk4jOV8xC0lB0Ap9zhOu/XLLhXB2QN6bwK7wWg0XUEVslOk9030Y2GNWSPdeve6
         pqcHSdYcuWT3Wa1YrA0mJScUd/l8FOIC373nW/YU9hvooEtqXfo/niN5AnNxjI6k4vUS
         acLA==
X-Gm-Message-State: AOJu0Yz6eA4t5OtvpuzsDioEjDKsZEkjHAPVydyfTXI+R7BwD4tnI3YG
	xBzrPif0laOnOgKR5o43txwSX/Y8t2uD2cv7T0hqqIWiA8Trza24
X-Google-Smtp-Source: AGHT+IF/Ob8T/1J5+Gm+6ovbVbNWt0rw2atHQmMMY2+mjZVKX3K6zW0bkEhql72xyVAwfCUGWLVxDw==
X-Received: by 2002:a05:6512:124a:b0:529:b718:8d00 with SMTP id 2adb3069b0e04-52e8264b5dfmr8947653e87.8.1719949040032;
        Tue, 02 Jul 2024 12:37:20 -0700 (PDT)
Received: from [192.168.1.94] (78-70-104-208-no600.tbcn.telia.com. [78.70.104.208])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b3d3sm1899518e87.281.2024.07.02.12.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 12:37:19 -0700 (PDT)
Message-ID: <feb71e43-8cb9-439d-a06e-42d6f83c1336@gmail.com>
Date: Tue, 2 Jul 2024 21:37:18 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v2 01/15] can: kvaser_usb: Add helper functions
 to convert device timestamp into ktime
Content-Language: en-US
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
 Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20240701154936.92633-1-extja@kvaser.com>
 <20240701154936.92633-2-extja@kvaser.com>
 <CAMZ6RqJFBooOgvrq4XmQDf_dFKMTe1hDnWLRObKEWA2t-U5+uQ@mail.gmail.com>
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <CAMZ6RqJFBooOgvrq4XmQDf_dFKMTe1hDnWLRObKEWA2t-U5+uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 06:47, Vincent MAILHOL wrote:
> On Tue. 2 juil. 2024 at 00:50, Jimmy Assarsson <extja@kvaser.com> wrote:
>> Add helper function kvaser_usb_ticks_to_ktime() that converts from
>> device ticks to ktime.
>> And kvaser_usb_timestamp{48,64}_to_ktime() that converts from device
>> 48-bit or 64-bit timestamp, to ktime.
>>
>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>> ---
>> Changes in v2:
>>    - New in v2. Replaces
>>      can: kvaser_usb: Add function kvaser_usb_ticks_to_ktime()
>>    - Add two more helper functions, kvaser_usb_timestamp{48,64}_to_ktime()
>>      for converting timestamps, suggested by Vincent MAILHOL [2][3]
>> [2] https://lore.kernel.org/linux-can/CAMZ6RqKSa-6KjvgfmN9eL7A=A65gMkYsRrnaF41Azhsc45FA2Q@mail.gmail.com/
>> [3] https://lore.kernel.org/linux-can/CAMZ6Rq+Xd7+th=dKV+vrqzRtS+GY-xq2UziH1CURcQ3HxEXMqQ@mail.gmail.com/
>>
>>   drivers/net/can/usb/kvaser_usb/kvaser_usb.h   | 24 +++++++++++++++++++
>>   .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 10 ++++----
>>   2 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
>> index ff10b3790d84..4256a0caae20 100644
>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
>> @@ -22,6 +22,8 @@
>>    */
>>
>>   #include <linux/completion.h>
>> +#include <linux/ktime.h>
>> +#include <linux/math64.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/types.h>
>>   #include <linux/usb.h>
>> @@ -216,4 +218,26 @@ int kvaser_usb_can_rx_over_error(struct net_device *netdev);
>>
>>   extern const struct can_bittiming_const kvaser_usb_flexc_bittiming_const;
>>
>> +static inline ktime_t kvaser_usb_ticks_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
>> +                                               u64 ticks)
>> +{
>> +       return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
>> +}
>> +
>> +static inline ktime_t kvaser_usb_timestamp48_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
>> +                                                     const __le16 *timestamp)
>> +{
>> +       u64 ticks = le16_to_cpu(timestamp[0]) |
>> +                   (u64)(le16_to_cpu(timestamp[1])) << 16 |
>> +                   (u64)(le16_to_cpu(timestamp[2])) << 32;
>> +
>> +       return kvaser_usb_ticks_to_ktime(cfg, ticks);
>> +}
>> +
>> +static inline ktime_t kvaser_usb_timestamp64_to_ktime(const struct kvaser_usb_dev_cfg *cfg,
>> +                                                     __le64 timestamp)
>> +{
>> +       return kvaser_usb_ticks_to_ktime(cfg, le64_to_cpu(timestamp));
>> +}
>> +
>>   #endif /* KVASER_USB_H */
>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
>> index c7ba768dfe17..ad1c6101a0cd 100644
>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
>> @@ -526,19 +526,17 @@ static ktime_t
>>   kvaser_usb_hydra_ktime_from_rx_cmd(const struct kvaser_usb_dev_cfg *cfg,
>>                                     const struct kvaser_cmd *cmd)
>>   {
>> -       u64 ticks;
>> +       ktime_t hwtstamp = 0;
>>
>>          if (cmd->header.cmd_no == CMD_EXTENDED) {
>>                  struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;
>>
>> -               ticks = le64_to_cpu(cmd_ext->rx_can.timestamp);
>> +               hwtstamp = kvaser_usb_timestamp64_to_ktime(cfg, cmd_ext->rx_can.timestamp);
>>          } else {
>> -               ticks = le16_to_cpu(cmd->rx_can.timestamp[0]);
>> -               ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[1])) << 16;
>> -               ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[2])) << 32;
>> +               hwtstamp = kvaser_usb_timestamp48_to_ktime(cfg, cmd->rx_can.timestamp);
>>          }
>>
>> -       return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
>> +       return hwtstamp;
>>   }
> 
> Nitpick: this can slightly be simplified by dropping the hwtstamp
> local variable:
> 
>    kvaser_usb_hydra_ktime_from_rx_cmd(const struct kvaser_usb_dev_cfg *cfg,
>                                       const struct kvaser_cmd *cmd)
>    {
>           if (cmd->header.cmd_no == CMD_EXTENDED) {
>                   struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;
> 
>                   return kvaser_usb_timestamp64_to_ktime(cfg,
> cmd_ext->rx_can.timestamp);
>           } else {
>                   return kvaser_usb_timestamp48_to_ktime(cfg,
> cmd->rx_can.timestamp);
>           }
>    }

I'll keep it as is. I prefer to have a single return at the end of the function.

Regards,
/jimmy

