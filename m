Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F728130A
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2019 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfHEHVV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Aug 2019 03:21:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37635 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEHVV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Aug 2019 03:21:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so24158657ljn.4
        for <linux-can@vger.kernel.org>; Mon, 05 Aug 2019 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YrYlxFclF9zCvpPF9a4z9W+zUsOnh0jpJGVTWvlV/s0=;
        b=KH8r8PCAY+vuX06YhPkXcuMJaalFDVC2VcGd/AjI7fhavKC37T5knQ40O/s0+CHfn8
         Jl/WmVZzTdTQ7FltPFKDsDfp90QIHxBB7Zs+jf92Wnttee3fSYWEzq1LuIl/b5xFudr5
         oMmqsE4xX7/eoRh/Hu3OzI40dJtEhq/skyf/t/ojQdo1pk1hWrFMx+ly5G8X+0gISyB8
         T34rywQzxt2Jatfqn6R70jUu/nSbTFClp5Xgv2V5Wybri1z1mDpq/6PFF4QhZ+1H36Pe
         ni4v0aJ3t2QfNwFeUB13FjoFER0oZOw6WYrFgjfjfGavreg7+JESVBJLuiZT4kR2ptI9
         wqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YrYlxFclF9zCvpPF9a4z9W+zUsOnh0jpJGVTWvlV/s0=;
        b=YlKIWoVz5TXDuODpnM2EnGI1wZtCz2y4GP4NTCQzidzN8Tp9UanslMg6h3J9XrEKID
         w3ehP1VnbPeVqzSkSR6PFIyuGtTjU7z89Up5XAh79cI0TdCoQT02CI38wWS0Hz4aQICH
         uMCim9FkcKngskAyKGclENQDxXh/ifsI/6D4R56d2BYuPylgLR61E9McRl5YEAklITdG
         QBOIHob7AIxYgtTShhK+6ETOFp2D8be9+Q7p5xxuTj/8TBbjqMkcA6giHE+bRFligsTW
         PhF1z2pe+IAoCHhlsLEjRjcZhdkYL15KRVFm2kICqvyBE/1NsAVZwfDIzD51RGbXOi3m
         oO+Q==
X-Gm-Message-State: APjAAAW6wY/tUh5BBMVdmHdOpAxKGN+clYeZv3ItwYkHReZFA+vDrDa9
        kstdBZfrta548ULMlBt6xoTPFw==
X-Google-Smtp-Source: APXvYqwkzVE728YqMfc5NKI7cJflTFpLUoXKna61g3YO7PEGKO7FyeT1WAffn2iSRHge4nqmvsnljw==
X-Received: by 2002:a2e:6c07:: with SMTP id h7mr10617691ljc.177.1564989678919;
        Mon, 05 Aug 2019 00:21:18 -0700 (PDT)
Received: from [10.0.3.110] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id o3sm14685553lfb.40.2019.08.05.00.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 00:21:18 -0700 (PDT)
Subject: Re: [PATCH][next] can: kvaser_pciefd: remove redundant negative check
 on trigger
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Colin King <colin.king@canonical.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org,
        Henning Colliander <henning.colliander@evidente.se>,
        Jimmy Assarsson <extja@kvaser.com>,
        walter harms <wharms@bfs.de>
References: <20190725112509.1075-1-colin.king@canonical.com>
 <954ea3c6-3a2d-ee4e-c4c8-a49358d569b6@pengutronix.de>
 <34bd981c-0bc1-6eba-9663-f8e8ced2f72e@pengutronix.de>
From:   Christer Beskow <chbe@kvaser.com>
Message-ID: <db550f33-fac6-5e2b-c623-3587976e2d51@kvaser.com>
Date:   Mon, 5 Aug 2019 09:21:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <34bd981c-0bc1-6eba-9663-f8e8ced2f72e@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: sv
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2019-08-02 14:12,  Marc Kleine-Budde wrote:
> On 8/2/19 2:07 PM, Marc Kleine-Budde wrote:
>> Adding the Author(s) to Cc.
>>
>> On 7/25/19 1:25 PM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The check to see if trigger is less than zero is always false, trigger
>>> is always in the range 0..255.  Hence the check is redundant and can
>>> be removed.
>>>
>>> Addresses-Coverity: ("Logically dead code")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>> ---
>>>   drivers/net/can/kvaser_pciefd.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
>>> index 3af747cbbde4..68e00aad0810 100644
>>> --- a/drivers/net/can/kvaser_pciefd.c
>>> +++ b/drivers/net/can/kvaser_pciefd.c
>>> @@ -652,9 +652,6 @@ static void kvaser_pciefd_pwm_stop(struct kvaser_pciefd_can *can)
>>>   	top = (pwm_ctrl >> KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT) & 0xff;
>>>   
>>>   	trigger = (100 * top + 50) / 100;
> As Walter pointed out the above code makes no sense in the first place.
>
>>> -	if (trigger < 0)
>>> -		trigger = 0;
>>> -
> Can someone have a deeper look at this code section and decide what to
> do with this finding.

I will look at this at once and come back with a patch later today.

>>>   	pwm_ctrl = trigger & 0xff;
>>>   	pwm_ctrl |= (top & 0xff) << KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT;
>>>   	iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
>>>
> regards,
> Marc

regards,

Christer Beskow


