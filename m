Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E910D459AF7
	for <lists+linux-can@lfdr.de>; Tue, 23 Nov 2021 05:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhKWERe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 23:17:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37424 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhKWERd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 23:17:33 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AN4E8VF105187;
        Mon, 22 Nov 2021 22:14:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637640848;
        bh=yszyn6EHHsQScwXUlQS0fEUJz7kVrrMir8iXqBe1yYY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jb3toupamnRgYJmxeJSxbccFNP98Xu8UFTeAo5TEkoRbdKoVwShrZS2IpZTAAEKbb
         R4hdoy13jt0BOzvVIXYmFPwsAS6jcWQsPqH+SgBrdf8KvMkcNoBY0/wVTpdvOOe4Ii
         eIBO9LD9RuLhmFKOiZJxVlhVoQoRIYcKtddubvW0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AN4E81V059620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 22:14:08 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 22:14:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 22:14:08 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AN4E4mt069078;
        Mon, 22 Nov 2021 22:14:05 -0600
Subject: Re: [PATCH RFC v2 3/4] mux: Add support for reading mux enable state
 from DT
To:     Peter Rosin <peda@axentia.se>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
References: <20211122125624.6431-1-a-govindraju@ti.com>
 <20211122125624.6431-4-a-govindraju@ti.com>
 <69f73f64-6424-4e3f-9068-195e959b9762@axentia.se>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <4a506332-2374-b164-5159-5d097ce667a1@ti.com>
Date:   Tue, 23 Nov 2021 09:44:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <69f73f64-6424-4e3f-9068-195e959b9762@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Peter,

On 23/11/21 12:29 am, Peter Rosin wrote:
> Hi!
> 
> On 2021-11-22 13:56, Aswath Govindraju wrote:
>> In some cases, we might need to provide the state of the mux to be set for
>> the operation of a given peripheral. Therefore, pass this information using
>> the second argument of the mux-controls property.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>
>> Notes:
>> - The function mux_control_get() always return the mux_control for a single
>>   line. So, control for mutiple lines cannot be represented in the
>>   mux-controls property.
>> - For representing multiple lines of control, multiple entries need to be
>>   used along with mux-names for reading them.
>> - If a device uses both the states of the mux line then #mux-control-cells
>>   can be set to 1 and enable_state will not be set in this case.
>>
>>  drivers/mux/core.c           | 20 ++++++++++++++++++--
>>  include/linux/mux/consumer.h |  1 +
>>  include/linux/mux/driver.h   |  1 +
>>  3 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>> index 22f4709768d1..51140748d2d6 100644
>> --- a/drivers/mux/core.c
>> +++ b/drivers/mux/core.c
>> @@ -294,6 +294,18 @@ unsigned int mux_control_states(struct mux_control *mux)
>>  }
>>  EXPORT_SYMBOL_GPL(mux_control_states);
>>  
>> +/**
>> + * mux_control_enable_state() - Query for the enable state.
>> + * @mux: The mux-control to query.
>> + *
>> + * Return: State to be set in the mux to enable a given device
>> + */
>> +unsigned int mux_control_enable_state(struct mux_control *mux)
>> +{
>> +	return mux->enable_state;
>> +}
>> +EXPORT_SYMBOL_GPL(mux_control_enable_state);
>> +
>>  /*
>>   * The mux->lock must be down when calling this function.
>>   */
>> @@ -481,8 +493,7 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>>  	if (!mux_chip)
>>  		return ERR_PTR(-EPROBE_DEFER);
>>  
>> -	if (args.args_count > 1 ||
>> -	    (!args.args_count && (mux_chip->controllers > 1))) {
>> +	if (!args.args_count && mux_chip->controllers > 1) {
>>  		dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
>>  			np, args.np);
>>  		put_device(&mux_chip->dev);
>> @@ -500,6 +511,11 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>>  		return ERR_PTR(-EINVAL);
>>  	}
>>  
>> +	if (args.args_count == 2) {
>> +		mux_chip->mux[controller].enable_state = args.args[1];
>> +		mux_chip->mux[controller].idle_state = !args.args[1];
> 
> Please leave the idle state alone. The idle state is a property of
> the mux-control itself, and not the business of any particular
> consumer. Consumers can only say what state the mux control should
> have when they have selected the mux-control, and have no say about
> what state the mux-control has when they do not have it selected.
> There is no conflict with having the same idle state as the state the
> mux would normally have. That could even be seen as an optimization,
> since then there might be no need to operate the mux for most
> accesses.
> 

Got it. Will not touch idle_state.

>> +	}
>> +
>>  	return &mux_chip->mux[controller];
>>  }
>>  EXPORT_SYMBOL_GPL(mux_control_get);
>> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
>> index 7a09b040ac39..cb861eab8aad 100644
>> --- a/include/linux/mux/consumer.h
>> +++ b/include/linux/mux/consumer.h
>> @@ -16,6 +16,7 @@ struct device;
>>  struct mux_control;
>>  
>>  unsigned int mux_control_states(struct mux_control *mux);
>> +unsigned int mux_control_enable_state(struct mux_control *mux);
>>  int __must_check mux_control_select_delay(struct mux_control *mux,
>>  					  unsigned int state,
>>  					  unsigned int delay_us);
>> diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
>> index 18824064f8c0..7db378dabdb2 100644
>> --- a/include/linux/mux/driver.h
>> +++ b/include/linux/mux/driver.h
>> @@ -48,6 +48,7 @@ struct mux_control {
>>  	int cached_state;
>>  
>>  	unsigned int states;
>> +	unsigned int enable_state;
> 
> This is the wrong place to store the state you need. The mux_control
> is a shared resource and can have many consumers. Storing the needed
> value for exactly one consumer in the mux control is therefore
> broken. It would get overwritten when consumer #2 (and 3 etc etc)
> wants to use some other state from the same shared mux control.
> 

Sorry, forgot the distinction that multiple consumers can get the mux
and only one can select the mux.

> Doing this properly means that you need a new struct tying together
> a mux-control and a state. With an API looking something like this:
> 
> struct mux_state {
> 	struct mux_control *mux;
> 	unsigned int state;
> };
> 
> struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
> {
> 	struct mux_state *mux_state = kzalloc(sizeof(*mux_state), GFP_KERNEL);
> 
> 	if (!mux_state)
> 		return ERR_PTR(-ENOMEM);
> 
> 	mux_state->mux = ...; /* mux_control_get(...) perhaps? */
> 	/* error checking and recovery, etc etc etc */
> 	mux_state->state = ...;
> 
> 	return mux_state;
> }
> 
> void mux_state_put(struct mux_state *mux_state)
> {
> 	mux_control_put(mux_state->mux);
> 	free(mux_state);
> }
> 
> int mux_state_select_delay(struct mux_state *mux_state,
>  			   unsigned int delay_us)
> {
> 	return mux_control_select_delay(mux_state->mux, mux_state->state,
> 					delay_us);
> }
> 
> int mux_state_select(struct mux_state *mux_state)
> {
> 	return mux_state_select_delay(mux_state, 0);
> }
> 
> int mux_state_try_select_delay(struct mux_state *mux_state)
> 			       unsigned int delay_us);
> {
> 	return mux_control_try_select_delay(mux_state->mux, mux_state->state,
> 					    delay_us);
> }
> 
> int mux_state_try_select(struct mux_state *mux_state)
> {
> 	return mux_state_try_select_delay(mux_state, 0);
> }
> 
> int mux_state_deselect(struct mux_control *mux)
> {
> 	return mux_control_deselect(mux_state->mux);
> }
> 
> (written directly in the mail client, never compiled, here be dragons)
> 
> mux_state_get is obviously the difficult function to write, and
> the above call to mux_control_get is not appropriate as-is. I

I am sorry but I did not understand why mux_control_get is not
appropriate. We should be able to call the function and get the mux right?

> think mux_control_get perhaps needs to be refactored into a
> flexible helper that takes a couple of extra arguments that
> indicate if you want an optional get and/or a particular state.
> And then mux_control_get can just be a wrapper around that helper.
> Adding mux_control_get_optional would be a matter of adding a new
> wrapper. And the mux_state->mux assignment above would need yet
> another wrapper for the flexible helper, one that also make the
> flexible helper return the requested state from the mux-control
> property.
> 

The problem that I see with the optional apis as wrappers around
mux_control_get is the following print in mux_control_get,

dev_err(dev, "%pOF: failed to get mux-control %s(%i)\n",

This gets printed whenever it can't find mux-controls device tree property.


Thank you providing your comments and reference implementation.

Regards,
Aswath

> I realize that this might be a big piece to chew, but you want to
> do something new here, and I think it is best to do it right from
> the start instead of having weird code that only makes it harder
> to do it right later. Ad it's not that complicated.
> 
> Cheers,
> Peter
> 
>>  	int idle_state;
>>  
>>  	ktime_t last_change;
>>

