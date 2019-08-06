Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB9782BE5
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2019 08:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfHFGnn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Aug 2019 02:43:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34503 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfHFGnn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Aug 2019 02:43:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id p17so81316959ljg.1
        for <linux-can@vger.kernel.org>; Mon, 05 Aug 2019 23:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hKyUtqDHtetJkLV3jMIveDdhagNqHGpzvo96Zvqjl28=;
        b=CYCdukrcsKKKgreNJjTSM/mpb+ucHiuFBbevNpKYUBiZs0fGY0tVo0g82uSCCLVTbU
         kpbgsPTPVLd10O+3qRq7b2Vr1JNzX1LIGbuBImeE+Zmbf9v3qbAIovUcsL7ALT567yad
         ciGuw5wsW6qdjBtXV1BPtFO3h7uoO/0HtuQQ6+3+fN585B5aXxzX6h93z5ll3Qi9+jXB
         46jR73Di1XG/jmXhrZvUs4e829xtCN7ZARdEIpJJdbGfl2hy9TfdITrr6uy3goXspiJC
         WUSVHpmlPwMzl7S+uhKuwNgFg24U45pHw+QDO34QT01J6Y4fqrrq64I5s+86GKmakEZW
         Ihtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hKyUtqDHtetJkLV3jMIveDdhagNqHGpzvo96Zvqjl28=;
        b=lM2nehjU3AkuZp+VsGnN3SzfY7A+i/MEIBouI2qFaJ8D1HfZNxFUKI0Vggv/p/j48q
         xPqWNWR+/P98aUtYKS5iQ7y4XMBphD/MxDlZ0DDOy5W3udeb02w+1aptQcOWbIsdIpPD
         Hqvdev9mPhRkKP3h+7O6dSEx5gemDN5Soocjh37JjNcmHrj6OXmcAiZmAx5aXm5iHjWy
         WA/bEcc3iltCaKEqRBdwc8RN6MVpP1ANm8TwOIBAP9l6axtFhMarWjCzZFOmQl3J0cV4
         on8FiXs5uyQg33SWdDERrKwqianbDfAjsr8EzRLlqXLAIA5s1PeeoJCl2AQKleEmmMLS
         U0zQ==
X-Gm-Message-State: APjAAAVSdRIdemyeeLVsKhV4y2H2oG95atPT/qsO3IDkvj+iZ0sYowrg
        Nno7M3BdTjs03LnqNkGtcMlG0NjzD9AcUQ==
X-Google-Smtp-Source: APXvYqy0C/qgCK5G/UP4WQiN5MTcVzVENfczCszLtm5KZ6GA07ZUwwZO+5qHn4xqR+5mqvBgBf086w==
X-Received: by 2002:a2e:720b:: with SMTP id n11mr900649ljc.213.1565073821354;
        Mon, 05 Aug 2019 23:43:41 -0700 (PDT)
Received: from [10.0.3.110] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id q1sm17622475ljb.87.2019.08.05.23.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 23:43:40 -0700 (PDT)
Subject: Re: [PATCH][next] can: kvaser_pciefd: remove redundant negative check
 on trigger
From:   Christer Beskow <chbe@kvaser.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Colin King <colin.king@canonical.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org,
        Henning Colliander <henning.colliander@evidente.se>,
        walter harms <wharms@bfs.de>
References: <20190725112509.1075-1-colin.king@canonical.com>
 <954ea3c6-3a2d-ee4e-c4c8-a49358d569b6@pengutronix.de>
 <34bd981c-0bc1-6eba-9663-f8e8ced2f72e@pengutronix.de>
 <db550f33-fac6-5e2b-c623-3587976e2d51@kvaser.com>
Message-ID: <c45f56e6-9448-7023-8eca-703cb1c5050e@kvaser.com>
Date:   Tue, 6 Aug 2019 08:43:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <db550f33-fac6-5e2b-c623-3587976e2d51@kvaser.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: sv
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Den 2019-08-05 kl. 09:21, skrev Christer Beskow:
> On 2019-08-02 14:12,  Marc Kleine-Budde wrote:
>> On 8/2/19 2:07 PM, Marc Kleine-Budde wrote:
>>> Adding the Author(s) to Cc.
>>>
>>> On 7/25/19 1:25 PM, Colin King wrote:
>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> The check to see if trigger is less than zero is always false, trigger
>>>> is always in the range 0..255.  Hence the check is redundant and can
>>>> be removed.
>>>>
>>>> Addresses-Coverity: ("Logically dead code")
>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>> ---
>>>>   drivers/net/can/kvaser_pciefd.c | 3 ---
>>>>   1 file changed, 3 deletions(-)
>>>>
>>>> diff --git a/drivers/net/can/kvaser_pciefd.c 
>>>> b/drivers/net/can/kvaser_pciefd.c
>>>> index 3af747cbbde4..68e00aad0810 100644
>>>> --- a/drivers/net/can/kvaser_pciefd.c
>>>> +++ b/drivers/net/can/kvaser_pciefd.c
>>>> @@ -652,9 +652,6 @@ static void kvaser_pciefd_pwm_stop(struct 
>>>> kvaser_pciefd_can *can)
>>>>       top = (pwm_ctrl >> KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT) & 0xff;
>>>>         trigger = (100 * top + 50) / 100;
>> As Walter pointed out the above code makes no sense in the first place.
>>
>>>> -    if (trigger < 0)
>>>> -        trigger = 0;
>>>> -
>> Can someone have a deeper look at this code section and decide what to
>> do with this finding.
>
> I will look at this at once and come back with a patch later today.
>
>>>>       pwm_ctrl = trigger & 0xff;
>>>>       pwm_ctrl |= (top & 0xff) << KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT;
>>>>       iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
>>>>
To set the duty cycle to zero (i.e. pwm_stop), the trigger value shall 
be equal to the top value.

This is achieved by reading the value of the top bit field from the pwm 
register and then writing back this value to the trigger and top bit 
fields.

The current code is, as you all pointed out, a bit cumbersome. I will 
send a new patch in a new thread.

regards

Christer

