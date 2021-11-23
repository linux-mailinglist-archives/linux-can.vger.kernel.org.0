Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3913459D00
	for <lists+linux-can@lfdr.de>; Tue, 23 Nov 2021 08:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhKWHsC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Nov 2021 02:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhKWHsC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Nov 2021 02:48:02 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9A4C061574
        for <linux-can@vger.kernel.org>; Mon, 22 Nov 2021 23:44:53 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id e11so9208506ljo.13
        for <linux-can@vger.kernel.org>; Mon, 22 Nov 2021 23:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ShB++p14c8j5+vg5qZac1I23gQHD4cxLW7Jx/ndA85Q=;
        b=BNtYz/BrWPi3cfMHjt2nTFlH06HIIwlbcWBHcaG2MDoXDYQQOc3+YrfRol3y+k6MR3
         SJF35UFsRkuPTQCTvKOQq3tkTesRdLnBSOOQCHc0xVapk21pcOiy1C/ZfEzWDe+gtYQc
         GiNBjVL8RXzN7pMC5CqcwArxe2EOm55rQfSQt3vlf76AKZJhKf5RpD5ElUBiLwDQlP77
         LdLEL7zm0xMOUXzR0eYDJhAsEhjCZzgpy4O1ffcvDMGU8U7l/er7W+0gQLZsanHTGQhc
         NhI3FotWCRZpnE+LPyAKuz5UF+xQjkyuca6TWBi8DyH8U2bfl4YfpNVklBeSvSB+yXzU
         Ibbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ShB++p14c8j5+vg5qZac1I23gQHD4cxLW7Jx/ndA85Q=;
        b=J/OmjWdtsBBmZuOVnPEi2tOZdRn6QGXL4HXwKlOxpoiwcp93rVymxQSYV4GKbI+pwB
         qWjJDGH2+wGU05ehoB2lUSBbfbvKNRu0yeJ7Cv6NCFatNMJUW4Tdn4698G24vW5a/H3e
         PQQiyMLou/NMojdKHXZuvMGcDCuW8YwLW8Xi1t8cZVhOov98fLaAwaaPyfx12jFrdK/6
         EIUaHWPenY+sfKghCAEgNH2036YFBKkt8iOSgnkd9l95q0iQOCYm6XviB5AWjyRZgYgE
         ohQ4jv2xPzvLNLwQQZsE/NwOHPyrXYalNLul3FqMHMjd8XK6JGRvw/nZHMgN9jdGTKEI
         w7ag==
X-Gm-Message-State: AOAM532mfbAioGa4UgcW56EBrvNT/8kSfk5peY11ILaS9D9olUgempqO
        ROEMweEepaSa6A5NfKhC7gZuGcka30S0FA8x
X-Google-Smtp-Source: ABdhPJzmPuIz6jJG/Tt5usex62U+4ba2J09gMmnzUhml80/LKhNOTcdb1QrfADwlLwAZzF34MOmaNA==
X-Received: by 2002:a2e:a785:: with SMTP id c5mr2856285ljf.384.1637653492092;
        Mon, 22 Nov 2021 23:44:52 -0800 (PST)
Received: from [10.0.6.3] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id f22sm1203590lfm.261.2021.11.22.23.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 23:44:51 -0800 (PST)
Subject: Re: [PATCH v1 1/5] can: kvaser_pciefd: Do not increase
 stats->rx_{packets,bytes} for error frames
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org
Cc:     jimmyassarsson@gmail.com
References: <20211119131915.2033234-2-extja@kvaser.com>
 <20211120030604.217665-1-mailhol.vincent@wanadoo.fr>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <e7bc40c3-e372-48ac-5cc3-d2348caa908f@kvaser.com>
Date:   Tue, 23 Nov 2021 08:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20211120030604.217665-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-11-20 04:06, Vincent Mailhol wrote:
> On Fri. 19 Nov 2021 at 05:20, Jimmy Assarsson <extja@kvaser.com> wrote:
>> Do not increase net_device_stats rx_{packets,bytes} when receiving
>> error frames.
>>
>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>> ---
>>   drivers/net/can/kvaser_pciefd.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
>> index 74d9899fc904..2c98befcf2a0 100644
>> --- a/drivers/net/can/kvaser_pciefd.c
>> +++ b/drivers/net/can/kvaser_pciefd.c
>> @@ -1304,9 +1304,6 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
>>   	cf->data[6] = bec.txerr;
>>   	cf->data[7] = bec.rxerr;
>>   
>> -	stats->rx_packets++;
>> -	stats->rx_bytes += cf->len;
>> -
>>   	netif_rx(skb);
>>   	return 0;
>>   }
> 
> I think that this patch makes sense because the CAN error frames do
> not exists on the wire: only an error flag is transmitted.
> 
> However, the current consensus is that the rx_packets and rx_bytes
> statistics should be incremented for CAN error frames. And I think
> that consistency between the drivers is the first priority.
> 
> I inquired here in the past to ask if it made sense to stop increasing
> the rx stats for CAN error frames:
> 
> https://lore.kernel.org/linux-can/CAMZ6Rq+8YSRqXU7CPrT9FKnWZ1G9xkSr3wt185r2CswmxhXPVg@mail.gmail.com/t/#u
> 
> But the discussion did not raise interest. I am fine to send a tree
> wide cleaning patch, but first, I would like to have people agree on
> this.

Thanks, I've not seen that discussion.
I agree, it doesn't make sense for a user to see the rx_packets and
rx_bytes increase, when in reality they didn't receive any valid frames.

This change started as a request from one of our customers, that got
confused by the increase of rx_packets, when connected to a bus with
wrong bitrate.

I'm in favour of a tree wide patch.

Best regards,
jimmy
