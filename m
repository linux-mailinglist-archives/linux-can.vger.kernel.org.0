Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132F7460E23
	for <lists+linux-can@lfdr.de>; Mon, 29 Nov 2021 05:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbhK2E4v (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 28 Nov 2021 23:56:51 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44872 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhK2Eyu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 28 Nov 2021 23:54:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AT4pGCD029147;
        Sun, 28 Nov 2021 22:51:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638161476;
        bh=jKols7nBDFKxYfjcKeEhtTKbFkUv99+4f3BWJlVrEiQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QDkCQOJRGQUzdYLrhx1aXUolvA0n0lduN0cCx+x4A6hj3j/jJa0KPuxRbR66fNBju
         pZqOLzbGZMDVbPZ0hkI/Gr6gDB0cG5tIXXa+duMZ0/ac4qvdNRO1IGegpa9p0u5M3+
         36BskJkU1NyQ9DHl7wRuBNdvoXdFxXlYermaj3fQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AT4pGgK122427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 28 Nov 2021 22:51:16 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 28
 Nov 2021 22:51:15 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 28 Nov 2021 22:51:15 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AT4pCGm113967;
        Sun, 28 Nov 2021 22:51:12 -0600
Subject: Re: [PATCH RFC v3 4/4] phy: phy-can-transceiver: Add support for
 setting mux
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
 <20211123081222.27979-5-a-govindraju@ti.com>
 <a1d9d0c6-e0df-2e06-d8e8-8770a9eb4b4a@axentia.se>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <cdba9694-8878-5e5f-c16c-db9366bfe2b9@ti.com>
Date:   Mon, 29 Nov 2021 10:21:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a1d9d0c6-e0df-2e06-d8e8-8770a9eb4b4a@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Peter,

On 25/11/21 7:37 pm, Peter Rosin wrote:
> Hi!
> 
> On 2021-11-23 09:12, Aswath Govindraju wrote:
>> On some boards, for routing CAN signals from controller to transceiver,
>> muxes might need to be set. Therefore, add support for setting the mux by
>> reading the mux-controls property from the device tree node.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  drivers/phy/Kconfig               |  1 +
>>  drivers/phy/phy-can-transceiver.c | 22 ++++++++++++++++++++++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index 82b63e60c5a2..300b0f2b5f84 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -64,6 +64,7 @@ config USB_LGM_PHY
>>  config PHY_CAN_TRANSCEIVER
>>  	tristate "CAN transceiver PHY"
>>  	select GENERIC_PHY
>> +	select MULTIPLEXER
>>  	help
>>  	  This option enables support for CAN transceivers as a PHY. This
>>  	  driver provides function for putting the transceivers in various
>> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
>> index 6f3fe37dee0e..6c94e3846410 100644
>> --- a/drivers/phy/phy-can-transceiver.c
>> +++ b/drivers/phy/phy-can-transceiver.c
>> @@ -10,6 +10,7 @@
>>  #include<linux/module.h>
>>  #include<linux/gpio.h>
>>  #include<linux/gpio/consumer.h>
>> +#include <linux/mux/consumer.h>
>>  
>>  struct can_transceiver_data {
>>  	u32 flags;
>> @@ -21,13 +22,22 @@ struct can_transceiver_phy {
>>  	struct phy *generic_phy;
>>  	struct gpio_desc *standby_gpio;
>>  	struct gpio_desc *enable_gpio;
>> +	struct mux_state *mux_state;
>>  };
>>  
>>  /* Power on function */
>>  static int can_transceiver_phy_power_on(struct phy *phy)
>>  {
>> +	int ret;
>>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
>>  
>> +	if (can_transceiver_phy->mux_state) {
>> +		ret = mux_state_select(can_transceiver_phy->mux_state);
>> +		if (ret) {
>> +			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>>  	if (can_transceiver_phy->standby_gpio)
>>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
>>  	if (can_transceiver_phy->enable_gpio)
>> @@ -45,6 +55,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
>>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
>>  	if (can_transceiver_phy->enable_gpio)
>>  		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
>> +	if (can_transceiver_phy->mux_state)
>> +		mux_state_deselect(can_transceiver_phy->mux_state);
> 
> Careful, it is not obvious that you are following the documentation you
> added in patch 3/4
> 
> + * Therefore, make sure to call mux_state_deselect() when the operation is
> + * complete and the mux-control is free for others to use, but do not call
> + * mux_state_deselect() if mux_state_select() fails.
> 
> Or, are you absolutely certain that can_transceiver_phy_power_off cannot,
> in any curcumstance, be called without a successful previous call to can_transceiver_phy_power_on? Or that can_transceiver_phy_power_on will
> never ever be called again without a can_transceiver_phy_power_off in
> between the two on calls?
> 
> If there is any doubt, you need to remember if you have selected/deselected
> the mux. Maybe this should be remebered inside struct mux_state so that it
> is always safe to call mux_state_select/mux_state_deselect? That's one way
> to solve this difficulty.
> 
> But then again, the phy layer might ensure that extra precaution is not
> needed. But it might also be that it for sure is intended that this is solved
> in the phy layer, but that callbacks (or whatever) has been added "after the
> fact" and that an extra "on" or "off" has just been just shrugged at.
> 

Thank you for pointing this out. I did forget to think about this case.
However, as you mentioned the phy layer does indeed only call the
can_transceiver_phy_power_off only if can_transceiver_phy_power_on was
called earlier and this is being done using power_count,

int phy_power_off(struct phy *phy)
{
        int ret;

        if (!phy)
                return 0;

        mutex_lock(&phy->mutex);
        if (phy->power_count == 1 && phy->ops->power_off) {
                ret =  phy->ops->power_off(phy);
                if (ret < 0) {
                        dev_err(&phy->dev, "phy poweroff failed -->
%d\n", ret);
                        mutex_unlock(&phy->mutex);
                        return ret;
                }
        }
        --phy->power_count;
        mutex_unlock(&phy->mutex);
        phy_pm_runtime_put(phy);

        if (phy->pwr)
                regulator_disable(phy->pwr);

        return 0;
}

Thanks,
Aswath

> Cheers,
> Peter
> 
>>  
>>  	return 0;
>>  }
>> @@ -95,6 +107,16 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>>  	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>>  	drvdata = match->data;
>>  
>> +	if (of_property_read_bool(dev->of_node, "mux-controls")) {
>> +		struct mux_state *mux_state;
>> +
>> +		mux_state = devm_mux_state_get(dev, NULL);
>> +		if (IS_ERR(mux_state))
>> +			return dev_err_probe(&pdev->dev, PTR_ERR(mux_state),
>> +					     "failed to get mux\n");
>> +		can_transceiver_phy->mux_state = mux_state;
>> +	}
>> +
>>  	phy = devm_phy_create(dev, dev->of_node,
>>  			      &can_transceiver_phy_ops);
>>  	if (IS_ERR(phy)) {
>>

