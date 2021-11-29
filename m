Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161AA460E19
	for <lists+linux-can@lfdr.de>; Mon, 29 Nov 2021 05:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhK2EuB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 28 Nov 2021 23:50:01 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45048 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhK2EsA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 28 Nov 2021 23:48:00 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AT4iJCc097343;
        Sun, 28 Nov 2021 22:44:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638161059;
        bh=DkCDXEITL/5Kn16VRZ9ZZVXWoyxw/XrLA12gXtt9lmc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uOWr+q5ydfyVvU9Wj/ttZ8KZicWeK3HyDFc2l0Iapgoe1jLtion+Tx6Zd4gORkczu
         5gxSldSygj+juA3+wFsOixpHTGFYfTT7qLWhQ9MAD8vpCLjqc1km/tSP8RFMAgxnIw
         79Rr+yzSPvip0ikXUWQWiLjhpYIzPD53NKaXTftU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AT4iJti113761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 28 Nov 2021 22:44:19 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 28
 Nov 2021 22:44:19 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 28 Nov 2021 22:44:19 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AT4iFV7086293;
        Sun, 28 Nov 2021 22:44:16 -0600
Subject: Re: [PATCH RFC v3 3/4] mux: Add support for reading mux enable state
 from DT
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
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <48156e28-4ef9-ce3a-bff6-c104a94bb869@ti.com>
Date:   Mon, 29 Nov 2021 10:14:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5a530528-27a9-f5c8-abd4-025897a1c197@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Peter,

On 25/11/21 7:22 pm, Peter Rosin wrote:
> Hi!
> 
> On 2021-11-23 09:12, Aswath Govindraju wrote:
>> In some cases, we might need to provide the state of the mux to be set for
>> the operation of a given peripheral. Therefore, pass this information using
>> the second argument of the mux-controls property.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  drivers/mux/core.c           | 146 ++++++++++++++++++++++++++++++++++-
>>  include/linux/mux/consumer.h |  19 ++++-
>>  include/linux/mux/driver.h   |  13 ++++
>>  3 files changed, 173 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>> index 22f4709768d1..9622b98f9818 100644
>> --- a/drivers/mux/core.c
>> +++ b/drivers/mux/core.c
>> @@ -370,6 +370,29 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
>>  }
>>  EXPORT_SYMBOL_GPL(mux_control_select_delay);
>>  
>> +/**
>> + * mux_state_select_delay() - Select the enable state in mux-state
> 
> The terminology is that you have a "mux" with different "states" that you
> "select". What you are referring to as enabling a mux state, is elsewhere
> referred to as selecting the mux state.
> 

Sorry, for mentioning what I mean by enable state. So, the idea is the
the state that would be mentioned in the DT property would be the state
to which the mux to be set for enabling the given device and hence I am
referring to it as enable state. I feel that referring to it as state
would not convey the above.

>> + * @mux: The mux-state to request a change of state from.
>> + * @delay_us: The time to delay (in microseconds) if the mux state is changed.
>> + *
>> + * On successfully selecting the enable state, it will be locked until
>> + * there is a call to mux_state_deselect(). If the mux-control is already
>> + * selected when mux_state_select() is called, the caller will be blocked
>> + * until mux_state_deselect() is called (by someone else).
>> + *
>> + * Therefore, make sure to call mux_state_deselect() when the operation is
>> + * complete and the mux-control is free for others to use, but do not call
>> + * mux_state_deselect() if mux_state_select() fails.
>> + *
>> + * Return: 0 when the mux-state has the enable state or a negative
>> + * errno on error.
>> + */
>> +int mux_state_select_delay(struct mux_state *mux, unsigned int delay_us)
> 
> I dislike the name "mux" here, that name is consistently referring to
> a struct mux-control in the mux subsystem. If mux_state is too long,
> maybe mstate or something such, just not plain mux. That goes for all
> the struct mux_state variables that follow too. I.e. pick a new name
> for variables of this type and stick to it (unless you need more than
> one such variable in a context, of course).
> 

Yes, using mux for mux_state type does seem to be misleading. I'll
change it to the mstate.

Thanks,
Aswath

>> +{
>> +	return mux_control_select_delay(mux->mux, mux->enable_state, delay_us);
>> +}
>> +EXPORT_SYMBOL_GPL(mux_state_select_delay);
> 
> Taking the above into account, I would like to see:
> 
> /**
>  * mux_state_select_delay() - Select the mux-state
>  * @mstate: The mux-state to select.
>  * @delay_us: The time to delay (in microseconds) if the mux-control changes
>  *            state on select.
>  *
>  * On successfully selecting the mux-state, its mux-control will be locked
>  * until there is a call to mux_state_deselect(). If the mux-control is
>  * already selected when mux_state_select() is called, the caller will be
>  * blocked until the mux-control is deselected (by someone else).
>  *
>  * Therefore, make sure to call mux_state_deselect() when the operation is
>  * complete and the mux-control is free for others to use, but do not call
>  * mux_state_deselect() if mux_state_select() fails.
>  *
>  * Return: 0 when the mux-state has been selected or a negative errno on
>  * error.
>  */
> int mux_state_select_delay(struct mux_state *mstate, unsigned int delay_us)
> 
> And then similar changes for the other new mux_state_ functions.
> 
>> +
>>  /**
>>   * mux_control_try_select_delay() - Try to select the given multiplexer state.
>>   * @mux: The mux-control to request a change of state from.
>> @@ -405,6 +428,27 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
>>  }
>>  EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
>>  
>> +/**
>> + * mux_state_try_select_delay() - Try to select the multiplexer enable state.
>> + * @mux: The mux-control to request a change of state from.
>> + * @delay_us: The time to delay (in microseconds) if the mux state is changed.
>> + *
>> + * On successfully selecting the enable state, it will be locked until
>> + * mux_state_deselect() called.
>> + *
>> + * Therefore, make sure to call mux_state_deselect() when the operation is
>> + * complete and the mux-control is free for others to use, but do not call
>> + * mux_state_deselect() if mux_state_try_select() fails.
>> + *
>> + * Return: 0 when the mux-control state has the requested state or a negative
>> + * errno on error. Specifically -EBUSY if the mux-control is contended.
>> + */
>> +int mux_state_try_select_delay(struct mux_state *mux, unsigned int delay_us)
>> +{
>> +	return mux_control_try_select_delay(mux->mux, mux->enable_state, delay_us);
>> +}
>> +EXPORT_SYMBOL_GPL(mux_state_try_select_delay);
>> +
>>  /**
>>   * mux_control_deselect() - Deselect the previously selected multiplexer state.
>>   * @mux: The mux-control to deselect.
>> @@ -431,6 +475,24 @@ int mux_control_deselect(struct mux_control *mux)
>>  }
>>  EXPORT_SYMBOL_GPL(mux_control_deselect);
>>  
>> +/**
>> + * mux_state_deselect() - Deselect the previously selected multiplexer state.
>> + * @mux: The mux-state to deselect.
>> + *
>> + * It is required that a single call is made to mux_state_deselect() for
>> + * each and every successful call made to either of mux_state_select() or
>> + * mux_state_try_select().
>> + *
>> + * Return: 0 on success and a negative errno on error. An error can only
>> + * occur if the mux has an idle state. Note that even if an error occurs, the
>> + * mux-control is unlocked and is thus free for the next access.
>> + */
>> +int mux_state_deselect(struct mux_state *mux)
>> +{
>> +	return mux_control_deselect(mux->mux);
>> +}
>> +EXPORT_SYMBOL_GPL(mux_state_deselect);
>> +
>>  /* Note this function returns a reference to the mux_chip dev. */
>>  static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
>>  {
>> @@ -442,13 +504,15 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
>>  }
>>  
>>  /**
>> - * mux_control_get() - Get the mux-control for a device.
>> + * mux_get() - Get the mux-control for a device.
>>   * @dev: The device that needs a mux-control.
>>   * @mux_name: The name identifying the mux-control.
>> + * @enable_state: The variable to store the enable state for the requested device
>>   *
>>   * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
>>   */
>> -struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>> +static struct mux_control *mux_get(struct device *dev, const char *mux_name,
>> +				   unsigned int *enable_state)
> 
> s/enable_state/state/ (goes for all of the patch).
> 
>>  {
>>  	struct device_node *np = dev->of_node;
>>  	struct of_phandle_args args;
>> @@ -481,8 +545,7 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>>  	if (!mux_chip)
>>  		return ERR_PTR(-EPROBE_DEFER);
>>  
>> -	if (args.args_count > 1 ||
> 
> It is inconsistent to allow more than 2 args, but then only allow
> digging out the state from the 2nd arg if the count is exactly 2.
> 
>> -	    (!args.args_count && (mux_chip->controllers > 1))) {
>> +	if (!args.args_count && mux_chip->controllers > 1) {
>>  		dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
>>  			np, args.np);
>>  		put_device(&mux_chip->dev);
>> @@ -500,8 +563,25 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>> +	if (args.args_count == 2)
>> +		*enable_state = args.args[1];
>> +
> 
> With the suggested binding in my comment for patch 1/4, you'd need to do
> either
> 
> 	ret = of_parse_phandle_with_args(np,
> 					 "mux-controls", "#mux-control-cells",
> 					 index, &args);
> 
> or
> 
> 	ret = of_parse_phandle_with_args(np,
> 					 "mux-states", "#mux-state-cells",
> 					 index, &args);
> 
> depending on if the mux_get helper gets a NULL (enable_)state pointer or a "real"
> address, and then...
> 
>>  	return &mux_chip->mux[controller];
>>  }
>> +
>> +/**
>> + * mux_control_get() - Get the mux-control for a device.
>> + * @dev: The device that needs a mux-control.
>> + * @mux_name: The name identifying the mux-control.
>> + *
>> + * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
>> + */
>> +struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>> +{
>> +	int state;
>> +
>> +	return mux_get(dev, mux_name, &state);
> 
> ...pass NULL as the 3rd arg here.
> 
>> +}
>>  EXPORT_SYMBOL_GPL(mux_control_get);
>>  
>>  /**
>> @@ -523,6 +603,26 @@ static void devm_mux_control_release(struct device *dev, void *res)
>>  	mux_control_put(mux);
>>  }
>>  
>> +/**
>> + * mux_state_put() - Put away the mux-state for good.
>> + * @mux: The mux-state to put away.
>> + *
>> + * mux_control_put() reverses the effects of mux_control_get().
>> + */
>> +void mux_state_put(struct mux_state *mux_state)
>> +{
>> +	mux_control_put(mux_state->mux);
>> +	kfree(mux_state);
>> +}
>> +EXPORT_SYMBOL_GPL(mux_state_put);
>> +
>> +static void devm_mux_state_release(struct device *dev, void *res)
>> +{
>> +	struct mux_state *mux = *(struct mux_state **)res;
>> +
>> +	mux_state_put(mux);
>> +}
>> +
>>  /**
>>   * devm_mux_control_get() - Get the mux-control for a device, with resource
>>   *			    management.
>> @@ -553,6 +653,44 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>>  }
>>  EXPORT_SYMBOL_GPL(devm_mux_control_get);
>>  
>> +/**
>> + * devm_mux_state_get() - Get the mux-state for a device, with resource
>> + *			  management.
>> + * @dev: The device that needs a mux-control.
>> + * @mux_name: The name identifying the mux-control.
>> + *
>> + * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
>> + */
>> +struct mux_state *devm_mux_state_get(struct device *dev,
>> +				     const char *mux_name)
>> +{
>> +	struct mux_state **ptr, *mux_state;
>> +	struct mux_control *mux_ctrl;
>> +	int enable_state;
>> +
>> +	mux_state = devm_kzalloc(dev, sizeof(struct mux_state), GFP_KERNEL);
>> +	if (!mux_state)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
>> +	if (!ptr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mux_ctrl = mux_get(dev, mux_name, &enable_state);
>> +	if (IS_ERR(mux_ctrl)) {
>> +		devres_free(ptr);
>> +		return (struct mux_state *)mux_ctrl;
>> +	}
>> +
>> +	mux_state->mux = mux_ctrl;
>> +	mux_state->enable_state = enable_state;
>> +	*ptr = mux_state;
>> +	devres_add(dev, ptr);
>> +
>> +	return mux_state;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_mux_state_get);
>> +
>>  /*
>>   * Using subsys_initcall instead of module_init here to try to ensure - for
>>   * the non-modular case - that the subsystem is initialized when mux consumers
>> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
>> index 7a09b040ac39..d0f3242e148d 100644
>> --- a/include/linux/mux/consumer.h
>> +++ b/include/linux/mux/consumer.h
>> @@ -14,33 +14,50 @@
>>  
>>  struct device;
>>  struct mux_control;
>> +struct mux_state;
>>  
>>  unsigned int mux_control_states(struct mux_control *mux);
>>  int __must_check mux_control_select_delay(struct mux_control *mux,
>>  					  unsigned int state,
>>  					  unsigned int delay_us);
>> +int __must_check mux_state_select_delay(struct mux_state *mux,
>> +					unsigned int delay_us);
>>  int __must_check mux_control_try_select_delay(struct mux_control *mux,
>>  					      unsigned int state,
>>  					      unsigned int delay_us);
>> -
>> +int __must_check mux_state_try_select_delay(struct mux_state *mux,
>> +					    unsigned int delay_us);
>>  static inline int __must_check mux_control_select(struct mux_control *mux,
>>  						  unsigned int state)
>>  {
>>  	return mux_control_select_delay(mux, state, 0);
>>  }
>>  
>> +static inline int __must_check mux_state_select(struct mux_state *mux)
>> +{
>> +	return mux_state_select_delay(mux, 0);
>> +}
>>  static inline int __must_check mux_control_try_select(struct mux_control *mux,
>>  						      unsigned int state)
>>  {
>>  	return mux_control_try_select_delay(mux, state, 0);
>>  }
>>  
>> +static inline int __must_check mux_state_try_select(struct mux_state *mux)
>> +{
>> +	return mux_state_try_select_delay(mux, 0);
>> +}
>> +
>>  int mux_control_deselect(struct mux_control *mux);
>> +int mux_state_deselect(struct mux_state *mux);
>>  
>>  struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
>>  void mux_control_put(struct mux_control *mux);
>> +void mux_state_put(struct mux_state *mux);
>>  
>>  struct mux_control *devm_mux_control_get(struct device *dev,
>>  					 const char *mux_name);
>> +struct mux_state *devm_mux_state_get(struct device *dev,
>> +				     const char *mux_name);
>>  
>>  #endif /* _LINUX_MUX_CONSUMER_H */
>> diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
>> index 18824064f8c0..c7236f307fbd 100644
>> --- a/include/linux/mux/driver.h
>> +++ b/include/linux/mux/driver.h
>> @@ -53,6 +53,19 @@ struct mux_control {
>>  	ktime_t last_change;
>>  };
>>  
>> +/**
>> + * struct mux_state -	Represents a mux controller specific to a given device
>> + * @mux:		Pointer to a mux controller
>> + * @enable_state	State of the mux to be set for enabling a device
>> + *
>> + * This structure is specific to a device that acquires it and has information
>> + * specific to the device.
>> + */
>> +struct mux_state {
>> +	struct mux_control *mux;
>> +	unsigned int enable_state;
>> +};
>> +
>>  /**
>>   * struct mux_chip -	Represents a chip holding mux controllers.
>>   * @controllers:	Number of mux controllers handled by the chip.
>>
> 
> This struct does not belong in driver.h, as it's purely a consumer thing.
> That said, it need not be in consumer.h either, as there is no need to
> "expose" the struct guts in any header. Just add it directly in core.c
> which is the only file that digs around in the struct.
> 
> Cheers,
> Peter
> 

