Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF7E462C6D
	for <lists+linux-can@lfdr.de>; Tue, 30 Nov 2021 06:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhK3GCI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Nov 2021 01:02:08 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52786 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbhK3GCH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 Nov 2021 01:02:07 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AU5waLk012915;
        Mon, 29 Nov 2021 23:58:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638251916;
        bh=06AH7OacKmkmVXzcwOhpzHW1hNSQrCuxfuYNjbXV8Kg=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=e8BY3vbRf6GcN5EcqcWRkbwmX3WnbAzIu/WDDX/YxoTMWXwBEU0UggUQ/eIe5/EGd
         NYMQnU7rJS+sYlSD6K18jC8/kSDalzlujKbpelUS8yex43VDcdqtgxMVT9orQ/EA+B
         gB6a9pMVOLqUUj6zyKcwwnSzrvjlreaLKhEIgO+U=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AU5wagB038199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Nov 2021 23:58:36 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 29
 Nov 2021 23:58:36 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 29 Nov 2021 23:58:36 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AU5wWtJ038213;
        Mon, 29 Nov 2021 23:58:32 -0600
Subject: Re: [PATCH RFC v3 3/4] mux: Add support for reading mux enable state
 from DT
From:   Aswath Govindraju <a-govindraju@ti.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
References: <20211123081222.27979-1-a-govindraju@ti.com>
 <20211123081222.27979-4-a-govindraju@ti.com>
 <5a530528-27a9-f5c8-abd4-025897a1c197@axentia.se>
 <06126316-53ef-6c32-2fbe-cff68e1ea064@ti.com>
Message-ID: <81e5d8e2-d91a-1832-1854-2eacb60df7d6@ti.com>
Date:   Tue, 30 Nov 2021 11:28:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <06126316-53ef-6c32-2fbe-cff68e1ea064@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Peter,

On 30/11/21 11:14 am, Aswath Govindraju wrote:
> Hi Peter,
> 
> On 25/11/21 7:22 pm, Peter Rosin wrote:
>> Hi!
>>
>> On 2021-11-23 09:12, Aswath Govindraju wrote:
>>> In some cases, we might need to provide the state of the mux to be set for
>>> the operation of a given peripheral. Therefore, pass this information using
>>> the second argument of the mux-controls property.
>>>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>  drivers/mux/core.c           | 146 ++++++++++++++++++++++++++++++++++-
>>>  include/linux/mux/consumer.h |  19 ++++-
>>>  include/linux/mux/driver.h   |  13 ++++
>>>  3 files changed, 173 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>>> index 22f4709768d1..9622b98f9818 100644
>>> --- a/drivers/mux/core.c
>>> +++ b/drivers/mux/core.c
>>> @@ -370,6 +370,29 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
>>>  }
>>>  EXPORT_SYMBOL_GPL(mux_control_select_delay);
>>>  
> 
> [...]
> 
>>>  }
>>>  
>>>  /**
>>> - * mux_control_get() - Get the mux-control for a device.
>>> + * mux_get() - Get the mux-control for a device.
>>>   * @dev: The device that needs a mux-control.
>>>   * @mux_name: The name identifying the mux-control.
>>> + * @enable_state: The variable to store the enable state for the requested device
>>>   *
>>>   * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
>>>   */
>>> -struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>>> +static struct mux_control *mux_get(struct device *dev, const char *mux_name,
>>> +				   unsigned int *enable_state)
>>
>> s/enable_state/state/ (goes for all of the patch).
>>
>>>  {
>>>  	struct device_node *np = dev->of_node;
>>>  	struct of_phandle_args args;
>>> @@ -481,8 +545,7 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>>>  	if (!mux_chip)
>>>  		return ERR_PTR(-EPROBE_DEFER);
>>>  
>>> -	if (args.args_count > 1 ||
>>
>> It is inconsistent to allow more than 2 args, but then only allow
>> digging out the state from the 2nd arg if the count is exactly 2.
>>
>>> -	    (!args.args_count && (mux_chip->controllers > 1))) {
>>> +	if (!args.args_count && mux_chip->controllers > 1) {
>>>  		dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
>>>  			np, args.np);
>>>  		put_device(&mux_chip->dev);
>>> @@ -500,8 +563,25 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>>>  		return ERR_PTR(-EINVAL);
>>>  	}
>>>  
>>> +	if (args.args_count == 2)
>>> +		*enable_state = args.args[1];
>>> +
>>
>> With the suggested binding in my comment for patch 1/4, you'd need to do
>> either
>>
>> 	ret = of_parse_phandle_with_args(np,
>> 					 "mux-controls", "#mux-control-cells",
>> 					 index, &args);
>>
>> or
>>
>> 	ret = of_parse_phandle_with_args(np,
>> 					 "mux-states", "#mux-state-cells",
>> 					 index, &args);
>>
>> depending on if the mux_get helper gets a NULL (enable_)state pointer or a "real"
>> address, and then...
>>
> 
> 
> Sorry, while trying to implement the above method, I came across one
> more question. So, in a given consumer DT node we will be either having
> only mux-states or mux-controls right? How would we take care of the
> condition when we would want to set the state of a given line in the
> controller. Especially when a single mux chip is used by multiple
> consumers each using a different line. Wouldn't we require both
> mux-controls and mux-states in that case? So, shouldn't the
> implementation be such that we need to first read mux-controls and then
> based whether the enable_state is NULL, we read mux-states?
> 
> Just to add more clarity, if we go about this method then we would have
> both mux-controls and mux-states in the consumer DT node when we want to
> specify the state.
> 

I now understood the implementation that you described. mux-states will
be similar to the mux-controls after this patch is applied. mux-states
can have 2 arguments(mux line and state) whereas mux-controls can have
only one argument(mux line).

Sorry, for the inconvenience.

Thanks,
Aswath

> Thanks,
> Aswath
> 
>>>  	return &mux_chip->mux[controller];
>>>  }
>>> +
>>> +/**
>>> + * mux_control_get() - Get the mux-control for a device.
>>> + * @dev: The device that needs a mux-control.
>>> + * @mux_name: The name identifying the mux-control.
>>> + *
>>> + * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
>>> + */
>>> +struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>>> +{
> 
> [...]
> 

