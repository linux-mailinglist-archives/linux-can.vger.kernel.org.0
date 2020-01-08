Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA63134DEA
	for <lists+linux-can@lfdr.de>; Wed,  8 Jan 2020 21:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgAHUuu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Jan 2020 15:50:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41642 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgAHUuu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Jan 2020 15:50:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008KoXqv057424;
        Wed, 8 Jan 2020 14:50:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578516633;
        bh=WVEF8Ogfb7hDkqRLDz1gGQX/utwfzc6iXAccVqo75WE=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=s3VHAN+aFmjus1n7UQDbxBB2qr+Jy5RAl5jHSCKjVwu0+J8fV3eQwrAO79GjABVGg
         /l7TRFxtsPI7XO7MjBn/HABJuohG08U5a3SPGRHbEb85uxnR1DTZFBVmHnynJv1SAZ
         jT3dgPLUx+s2WDuIf5cnqrP/Uh5l0syr5NwRlLOs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008KoXjq090522;
        Wed, 8 Jan 2020 14:50:33 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 14:50:32 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 14:50:32 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008KoWoX116524;
        Wed, 8 Jan 2020 14:50:32 -0600
Subject: Re: [PATCH linux-can/testing] can: tcan4x5x: Disable the INH pin
 device-state GPIO is unavailable
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <wg@grandegger.com>, <sriram.dash@samsung.com>
References: <20191212161536.23264-1-dmurphy@ti.com>
 <b0560413-525c-39ba-30ce-816c098e51ab@pengutronix.de>
 <afa5c681-bbd1-a6f6-2b58-4f24c924144e@pengutronix.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <01f16f0f-cfdf-0a3c-48b1-59e0824c83e8@ti.com>
Date:   Wed, 8 Jan 2020 14:47:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <afa5c681-bbd1-a6f6-2b58-4f24c924144e@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Marc

On 12/29/19 10:05 AM, Marc Kleine-Budde wrote:
> On 12/29/19 4:32 PM, Marc Kleine-Budde wrote:
>> On 12/12/19 5:15 PM, Dan Murphy wrote:
>>>   static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>>>   {
>>>   	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
>>> @@ -383,8 +393,10 @@ static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>>>   	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
>>>   							      "device-state",
>>>   							      GPIOD_IN);
>>> -	if (IS_ERR(tcan4x5x->device_state_gpio))
>>> +	if (IS_ERR(tcan4x5x->device_state_gpio)) {
>>>   		tcan4x5x->device_state_gpio = NULL;
>>> +		tcan4x5x_disable_state(cdev);
>>> +	}
>> For some reason, this hunk doesn't apply, due to the additional:
>>
>>>> 	tcan4x5x->power = devm_regulator_get_optional(cdev->dev,
>>>> 						      "vsup");
> ...which was my fault. :) Please have a look at
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/?h=testing
>
> ...if I've collected every m_can related patch.

Is this still relevant or have you pulled this in?

It looks good to me.

Dan


