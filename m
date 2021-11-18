Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B66D4559E5
	for <lists+linux-can@lfdr.de>; Thu, 18 Nov 2021 12:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbhKRLRf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Nov 2021 06:17:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36682 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343911AbhKRLPb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Nov 2021 06:15:31 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AIBC6q7056350;
        Thu, 18 Nov 2021 05:12:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637233926;
        bh=V7yPbnnma5Hb1kIJnwWQfhUbAlN9gFoVmGDPT0oyMbg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=iuwcjZ8hiinhosA151HPSbb/aUkeGKqWRhYsy0OWVrcdCyIoCsynLvnx/z6OE1rQz
         WJAL26ydS4aGgVA+kXBf4OLQqfSppTIdkX1uQ28TbB8B2UW10uOG4ml1j/hVT56RnG
         g+UH4XSCZACYDEU5gOfsavJMoLPetQ7v+mtR55jk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AIBC5e3034846
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Nov 2021 05:12:06 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 18
 Nov 2021 05:12:05 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 18 Nov 2021 05:12:05 -0600
Received: from [10.250.232.124] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AIBC1Zj030631;
        Thu, 18 Nov 2021 05:12:02 -0600
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
 <8be2b770-9c4c-ce41-4c49-27fa30b4afee@ti.com>
 <b8b0c7c4-3006-071b-d68f-8b18d24a1f72@axentia.se>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <f47dc612-adea-4dfb-f2fd-d67b5df6ed50@ti.com>
Date:   Thu, 18 Nov 2021 16:42:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b8b0c7c4-3006-071b-d68f-8b18d24a1f72@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Peter,

On 18/11/21 2:54 am, Peter Rosin wrote:
> Hi!
> 
> On 2021-11-15 07:31, Aswath Govindraju wrote:
>> Hi Peter,
>>
>> On 13/11/21 12:45 am, Peter Rosin wrote:
>>> Hi!
>>>
>>> On 2021-11-12 14:48, Aswath Govindraju wrote:
>>>> Hi Marc,
>>>>
>>>> On 12/11/21 2:10 pm, Marc Kleine-Budde wrote:
>>>>> On 11.11.2021 22:13:12, Aswath Govindraju wrote:
>>>>>> On some boards, for routing CAN signals from controller to transceiver,
>>>>>> muxes might need to be set. Therefore, add support for setting the mux by
>>>>>> reading the mux-controls property from the device tree node.
>>>>>>
>>>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>>>> ---
>>>>>>  drivers/phy/phy-can-transceiver.c | 21 +++++++++++++++++++++
>>>>>>  1 file changed, 21 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
>>>>>> index 6f3fe37dee0e..3d8da5226e27 100644
>>>>>> --- a/drivers/phy/phy-can-transceiver.c
>>>>>> +++ b/drivers/phy/phy-can-transceiver.c
>>>>>> @@ -10,6 +10,7 @@
>>>>>>  #include<linux/module.h>
>>>>>>  #include<linux/gpio.h>
>>>>>>  #include<linux/gpio/consumer.h>
>>>>>> +#include <linux/mux/consumer.h>
>>>>>>  
>>>>>>  struct can_transceiver_data {
>>>>>>  	u32 flags;
>>>>>> @@ -21,13 +22,22 @@ struct can_transceiver_phy {
>>>>>>  	struct phy *generic_phy;
>>>>>>  	struct gpio_desc *standby_gpio;
>>>>>>  	struct gpio_desc *enable_gpio;
>>>>>> +	struct mux_control *mux_ctrl;
>>>>>>  };
>>>>>>  
>>>>>>  /* Power on function */
>>>>>>  static int can_transceiver_phy_power_on(struct phy *phy)
>>>>>>  {
>>>>>> +	int ret;
>>>>>>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
>>>>>>  
>>>>>> +	if (can_transceiver_phy->mux_ctrl) {
>>>>>> +		ret = mux_control_select(can_transceiver_phy->mux_ctrl, 1);
>>>>>
>>>>> Hard coding the "1" looks wrong here. I have seen some boards where you
>>>>> can select between a CAN-2.0 and a single wire CAN transceiver with a
>>>>> mux. So I think we cannot hard code the "1" here.
>>>>>
>>>>
>>>> Yes, as you mentioned it is not ideal to hard code "1". I feel that, it
>>>> would be much better to read the state of the mux to be set from the
>>>> mux-controls property. The issue that I see with this approach is that
>>>> the current implementation in the mux framework only allows for one
>>>> argument, which is for indicating the line to be toggled in the mux. If
>>>> more arguments are added then an error is returned from the
>>>> "mux_control_get". I am not sure why this limitation was added.
>>>
>>> The only current use of the first argument is for mux chips that contain
>>> more than one mux control. The limit in the mux core is there since no
>>> mux driver need more than this one argument. The number of mux-control
>>> property arguments is fixed by the #mux-control-cells property in the
>>> mux-control node. I don't see any way to and a new optional mux-control
>>> property argument that specifies a specific state. How would that not
>>> break all existing users?
>>>
>>
>> My idea was to use the second argument for reading the state of mux to
>> be set after increasing the #mux-control-cells value to 2. I don't think
>> this will break the existing mux controller users as the second argument
>> was not used till now, would be equivalent to adding an additional feature.
> 
> Ok, I see what you mean now, sorry for being dense. If we allow this then
> there is a need to add a special value that means all/many states (such as
> -1 or something such) so that a mux-control can be used simultaneously by
> drivers "pointing at" a specific state like you want to do, and by the
> existing "application" style drivers that wraps the whole mux control.
> 
> I.e. something like this
> 
> 	mux: mux {
> 		compatible = "mux-gpio";
> 		...
> 
> 		#mux-control-cells = <1>; /* one more than previously */
> 	};
> 
> 	phy {
> 		...
> 
> 		mux-control = <&mux 3>; /* point to specific state */
> 	};
> 
> 	i2c-mux {
> 		compatible = "i2c-mux-gpmux";
> 		parent = <&i2c0>
> 		mux-control = <&mux (-1)>; /* many states needed */
> 
> 		...
> 
> 		i2c@1 {
> 			eeprom@50 {
> 				...
> 			};
> 		};
> 
> 		i2c@2 {
> 			...
> 		};
> 	};
> 
> Yes, I realize that accesses to the eeprom cannot happen if the mux is
> constantly selected and locked in state 3 by the phy, and that a mux with
> one channel being a phy and other channels being I2C might not be
> realistic, but the same gpio lines might control several muxes that are
> used for separate signals solving at least the latter "problem" with this
> completely made up example. Anyway, the above is in principle, and HW
> designs are sometimes too weird for words.
> 

This is almost exactly what I was intending to implement except for one
more change. The state of the mux will always be represented using the
second argument(i.e. #mux-control-cells = <2>).

For example,
mux-controls = <&mux 0 1>, <&mux 1 0>;


With this I think we wouldn't need a special value for all or many states.

>> One more question that I had is, if the number of arguments match the
>> #mux-control-cells and if the number of arguments are greater than 1 why
>> is an error being returned?
> 
> Changing that would require a bindings update anyway, so I simply
> disallowed it as an error. Not much thought went into the decision,
> as it couldn't be wrong to do what is being done with the bindings
> that exist. That said, I have no problem lifting this restriction,
> if there's a matching bindings update that makes it all fit.
> 

Sure, I think making a change in

Documentation/devicetree/bindings/mux/gpio-mux.yaml, should be good
enough I assume.


Thank you for the comments. I'll post a respin of this series, with the
above changes.

Thanks,
Aswath

>>> The current mux interface is designed around the idea that you wrap a
>>> mux control in a mux (lacking better name) application. There are
>>> several such mux applications in the tree, those for I2C, IIO and SPI
>>> pops into my head, and that you then tie the end user consumer to this
>>> muxing application. The mux state comes as a part of how you have tied
>>> the end user consumer to the mux application and is not really something
>>> that the mux-control is involved in.
>>>
>>> In other words, a mux-control is not really designed to be used directly
>>> by a driver that needs only one of the states.
>>>
>>> However, I'm not saying that doing so isn't also a useful model. It
>>> cetainly sound like it could be. However, the reason it's not done that
>>> way is that I did not want to add muxing code to *all* drivers. I.e. it
>>> would not be flexible to have to add boilerplate mux code to each and
>>> every IIO driver that happen to be connected in a way that a mux has to
>>> be in a certain state for the signal to reach the ADC (or whatever).
>>> Instead, new IIO channels are created for the appropriate mux states
>>> and the IIO mux is connected to the parent IIO channel. When one of the
>>> muxed channels is accessed the mux is selected as needed, and the ADC
>>> driver needs to know nothing about it. If two muxes need to be in a
>>> certain position, you again have no need to "pollute" drivers with
>>> double builerplate mux code. Instead, you simply add two levels of
>>> muxing to the muxed IIO channel.
>>>
>>> I think the same is probably true in this case too, and that it would
>>> perhaps be better to create a mux application for phys? But I don't know
>>> what the phy structure looks like, so I'm not in a position to say for
>>> sure if this model fits. But I imagine that phys have providers and
>>> consumers and that a mux can be jammed in there in some way and
>>> intercept some api such that the needed mux state can be selected when
>>> needed.
>>>
>>
>> Yes, I understand that reading the state of the mux in drivers would not
>> be efficient as it would adding the boiler plate code in each of the
>> drivers. However, for phys as each of them can be used for a different
>> interface, I am not sure if a common mux phy wrapper can be introduced.
>> This is reason why I felt that drivers should be allowed to read the
>> state of the mux directly, when no mux wrapper application is suitable
>> for it.
> 
> It need not be one grand unifying phy mux, it could be one for each
> kind of phy interface. But again, I don't know much about how phys
> work nor their interfaces, not event roughly how many drivers there
> are etc etc. I have simply never needed to look.
> 
> Hmm, wild idea, maybe there could be a mux "application" for pinctrl?
> I mean such that you could tie pinctrl states to mux states. It doesn't
> sound like too bad of a match to me?
> 
> Cheers,
> Peter
> 

