Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7703544FEA9
	for <lists+linux-can@lfdr.de>; Mon, 15 Nov 2021 07:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhKOGfo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 Nov 2021 01:35:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38442 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhKOGfk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Nov 2021 01:35:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AF6VrjL093042;
        Mon, 15 Nov 2021 00:31:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636957913;
        bh=Yp6cJZ8oIsFnm9F73Lzb1xo9cWF3HS71rWFf2uvETQM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tb7mjZbvhX+CsniZ8ypDDVMisBYCCgVpSxpZNYMzxisbRqJW2jJ5DAWGz5becJN55
         60WKLcpd8nNkq9TGJDH/fWXAgeDIDsovEPLfgX2wtGNkrKE39LXARtwJTP8+grxBpH
         UbRraZkSr6uEEAQ+1tOZxWS5srf4bU7qT3a4TspE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AF6Vr1h097679
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Nov 2021 00:31:53 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 15
 Nov 2021 00:31:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 15 Nov 2021 00:31:53 -0600
Received: from [10.250.232.124] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AF6VnnP059580;
        Mon, 15 Nov 2021 00:31:49 -0600
Subject: Re: [PATCH RFC 2/2] phy: phy-can-transceiver: Add support for setting
 mux
To:     Peter Rosin <peda@axentia.se>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211111164313.649-1-a-govindraju@ti.com>
 <20211111164313.649-3-a-govindraju@ti.com>
 <20211112084027.b2t2beqiiodnwjtv@pengutronix.de>
 <085ec3c0-75c6-f3c2-9999-348098fd88f9@ti.com>
 <f933048c-099f-054a-6563-671cf2a2e2af@axentia.se>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <8be2b770-9c4c-ce41-4c49-27fa30b4afee@ti.com>
Date:   Mon, 15 Nov 2021 12:01:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <f933048c-099f-054a-6563-671cf2a2e2af@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Peter,

On 13/11/21 12:45 am, Peter Rosin wrote:
> Hi!
> 
> On 2021-11-12 14:48, Aswath Govindraju wrote:
>> Hi Marc,
>>
>> On 12/11/21 2:10 pm, Marc Kleine-Budde wrote:
>>> On 11.11.2021 22:13:12, Aswath Govindraju wrote:
>>>> On some boards, for routing CAN signals from controller to transceiver,
>>>> muxes might need to be set. Therefore, add support for setting the mux by
>>>> reading the mux-controls property from the device tree node.
>>>>
>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>> ---
>>>>  drivers/phy/phy-can-transceiver.c | 21 +++++++++++++++++++++
>>>>  1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
>>>> index 6f3fe37dee0e..3d8da5226e27 100644
>>>> --- a/drivers/phy/phy-can-transceiver.c
>>>> +++ b/drivers/phy/phy-can-transceiver.c
>>>> @@ -10,6 +10,7 @@
>>>>  #include<linux/module.h>
>>>>  #include<linux/gpio.h>
>>>>  #include<linux/gpio/consumer.h>
>>>> +#include <linux/mux/consumer.h>
>>>>  
>>>>  struct can_transceiver_data {
>>>>  	u32 flags;
>>>> @@ -21,13 +22,22 @@ struct can_transceiver_phy {
>>>>  	struct phy *generic_phy;
>>>>  	struct gpio_desc *standby_gpio;
>>>>  	struct gpio_desc *enable_gpio;
>>>> +	struct mux_control *mux_ctrl;
>>>>  };
>>>>  
>>>>  /* Power on function */
>>>>  static int can_transceiver_phy_power_on(struct phy *phy)
>>>>  {
>>>> +	int ret;
>>>>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
>>>>  
>>>> +	if (can_transceiver_phy->mux_ctrl) {
>>>> +		ret = mux_control_select(can_transceiver_phy->mux_ctrl, 1);
>>>
>>> Hard coding the "1" looks wrong here. I have seen some boards where you
>>> can select between a CAN-2.0 and a single wire CAN transceiver with a
>>> mux. So I think we cannot hard code the "1" here.
>>>
>>
>> Yes, as you mentioned it is not ideal to hard code "1". I feel that, it
>> would be much better to read the state of the mux to be set from the
>> mux-controls property. The issue that I see with this approach is that
>> the current implementation in the mux framework only allows for one
>> argument, which is for indicating the line to be toggled in the mux. If
>> more arguments are added then an error is returned from the
>> "mux_control_get". I am not sure why this limitation was added.
> 
> The only current use of the first argument is for mux chips that contain
> more than one mux control. The limit in the mux core is there since no
> mux driver need more than this one argument. The number of mux-control
> property arguments is fixed by the #mux-control-cells property in the
> mux-control node. I don't see any way to and a new optional mux-control
> property argument that specifies a specific state. How would that not
> break all existing users?
> 

My idea was to use the second argument for reading the state of mux to
be set after increasing the #mux-control-cells value to 2. I don't think
this will break the existing mux controller users as the second argument
was not used till now, would be equivalent to adding an additional feature.

One more question that I had is, if the number of arguments match the
#mux-control-cells and if the number of arguments are greater than 1 why
is an error being returned?

> The current mux interface is designed around the idea that you wrap a
> mux control in a mux (lacking better name) application. There are
> several such mux applications in the tree, those for I2C, IIO and SPI
> pops into my head, and that you then tie the end user consumer to this
> muxing application. The mux state comes as a part of how you have tied
> the end user consumer to the mux application and is not really something
> that the mux-control is involved in.
> 
> In other words, a mux-control is not really designed to be used directly
> by a driver that needs only one of the states.
> 
> However, I'm not saying that doing so isn't also a useful model. It
> cetainly sound like it could be. However, the reason it's not done that
> way is that I did not want to add muxing code to *all* drivers. I.e. it
> would not be flexible to have to add boilerplate mux code to each and
> every IIO driver that happen to be connected in a way that a mux has to
> be in a certain state for the signal to reach the ADC (or whatever).
> Instead, new IIO channels are created for the appropriate mux states
> and the IIO mux is connected to the parent IIO channel. When one of the
> muxed channels is accessed the mux is selected as needed, and the ADC
> driver needs to know nothing about it. If two muxes need to be in a
> certain position, you again have no need to "pollute" drivers with
> double builerplate mux code. Instead, you simply add two levels of
> muxing to the muxed IIO channel.
> 
> I think the same is probably true in this case too, and that it would
> perhaps be better to create a mux application for phys? But I don't know
> what the phy structure looks like, so I'm not in a position to say for
> sure if this model fits. But I imagine that phys have providers and
> consumers and that a mux can be jammed in there in some way and
> intercept some api such that the needed mux state can be selected when
> needed.
> 

Yes, I understand that reading the state of the mux in drivers would not
be efficient as it would adding the boiler plate code in each of the
drivers. However, for phys as each of them can be used for a different
interface, I am not sure if a common mux phy wrapper can be introduced.
This is reason why I felt that drivers should be allowed to read the
state of the mux directly, when no mux wrapper application is suitable
for it.

Thanks,
Aswath

> Cheers,
> Peter
> 
>>
>>>> +		if (ret) {
>>>> +			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>>  	if (can_transceiver_phy->standby_gpio)
>>>>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
>>>>  	if (can_transceiver_phy->enable_gpio)
>>>> @@ -45,6 +55,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
>>>>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
>>>>  	if (can_transceiver_phy->enable_gpio)
>>>>  		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
>>>> +	if (can_transceiver_phy->mux_ctrl)
>>>> +		mux_control_deselect(can_transceiver_phy->mux_ctrl);
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -95,6 +107,15 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>>>>  	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>>>>  	drvdata = match->data;
>>>>  
>>>> +	if (of_property_read_bool(dev->of_node, "mux-controls")) {
>>>
>>> Is this the proper way of doing this? Looks like we need a
>>> devm_mux_control_get_optional(), which doesn't return a -ENODEV if the
>>> device doesn't exist.
>>>
>>> Cc'ed Peter Rosin.
>>>
>>>> +		struct mux_control *control;
>>>> +
>>>> +		control = devm_mux_control_get(dev, NULL);
>>>> +		if (IS_ERR(control))
>>>> +			return PTR_ERR(control);
>>>
>>> What about making use of dev_err_probe()?
>>>
>>
>> Sure, I will make this change.
>>
>> Thank you for the comments.
>>
>> Regards,
>> Aswath
>>
>>>> +		can_transceiver_phy->mux_ctrl = control;
>>>> +	}
>>>> +
>>>>  	phy = devm_phy_create(dev, dev->of_node,
>>>>  			      &can_transceiver_phy_ops);
>>>>  	if (IS_ERR(phy)) {
>>>> -- 
>>>> 2.17.1
>>>>
>>>>
>>>
>>> Regards,
>>> Marc
>>>
>>

