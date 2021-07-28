Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E6B3D895A
	for <lists+linux-can@lfdr.de>; Wed, 28 Jul 2021 10:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhG1IEw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Jul 2021 04:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhG1IEL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Jul 2021 04:04:11 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19204C061757
        for <linux-can@vger.kernel.org>; Wed, 28 Jul 2021 01:04:09 -0700 (PDT)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id 8094cf45;
        Wed, 28 Jul 2021 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=subject
        :to:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=default; bh=0MqK/Hoef
        2+jswt3e5Rkxh7Sihg=; b=X5bT0PrxToBqqpAyMvVpzckw4x1x/H2OzdqTt2IYG
        nuubCMlK/mKgWitjgcwk8E8k5h5qxrxi8/yGURWUOn7J4vgpAWMcllOFW91f+C2F
        Mb1FW5u9qs7WQzwYeVIKq972l6HahrtJ/XvkaWr30zsbGJuc0MC6ArkMc0CDIpsr
        g8=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=subject
        :to:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=default; b=BoR
        snwgS81xktEz9TiUAXRQY96gT8yzzh2NZ31rufAzyknN/6T099DEB1hnA8qazuDL
        LmQQzYHsr+23rVLB1ev6N2hVrMYK9bA4Cm75918q0sm+J3dGW+8kRnWXwQ5sgdbR
        65TJ9vy70yrlJM2QgW6buvH0PdbQ8jpVdjvFBgSc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1627459446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwIgOAj7u41nF2/KCSPpKg5xj8l1kseufBnbfna0x0c=;
        b=l790LO7H+zodWxAdVSTUBwHQGT8d3OhlZN5gwikll+3VWYM5i8lPHEBFh9zeC7bemSWlq0
        1rt8f9U7GVuUA5+GMxlgR4C3fkxLweJDIPp8U8P6d8c+sG4exGJyhLHTFzbQNgqFe1vOwS
        PrHpfnwrla15sKn0xU/4yo8timUerW4=
Received: from [192.168.0.2] (host-87-1-221-161.retail.telecomitalia.it [87.1.221.161])
        by ziongate (OpenSMTPD) with ESMTPSA id 5c35139a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 28 Jul 2021 08:04:06 +0000 (UTC)
Subject: Re: [PATCH] can: flexcan: flexcan_error_irq_disable(): add missing
 variable initialization
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20210728075428.1493568-1-mkl@pengutronix.de>
 <20210728075659.6npegwljokksjtjy@pengutronix.de>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <0df3a8b6-7fa5-c68b-8c4f-10baca48c01b@kernel-space.org>
Date:   Wed, 28 Jul 2021 10:02:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210728075659.6npegwljokksjtjy@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

thanks for the fix,


On 28/07/21 9:56 AM, Marc Kleine-Budde wrote:
> The subject is obviously wrong, fixed to "flexcan_clks_enable()".
> 
> Marc
> 
> On 28.07.2021 09:54:28, Marc Kleine-Budde wrote:
>> This patch adds the missing initialization of the "err" variable in
>> the flexcan_clks_enable() function.
>>
>> Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Angelo Dureghello <angelo@kernel-space.org>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>   drivers/net/can/flexcan.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index 54ffb796a320..7734229aa078 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -649,7 +649,7 @@ static inline void flexcan_error_irq_disable(const struct flexcan_priv *priv)
>>   
>>   static int flexcan_clks_enable(const struct flexcan_priv *priv)
>>   {
>> -	int err;
>> +	int err = 0;
>>   
>>   	if (priv->clk_ipg) {
>>   		err = clk_prepare_enable(priv->clk_ipg);
>> -- 
>> 2.30.2
>>
>>
>>
> 

regards,
-- 
Angelo Dureghello
