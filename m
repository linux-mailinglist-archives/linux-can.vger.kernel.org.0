Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942F8458FA5
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 14:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhKVNr7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 08:47:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59490 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhKVNr7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 08:47:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AMDifip101911;
        Mon, 22 Nov 2021 07:44:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637588681;
        bh=4aEDuUEwwhUks1YMR682x5k41bzpSbH1JYgjk2P31Dw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WYnW3qAUdQPcffmBypxU+4/ypn5NPYrEzdwzzecNs75Ba6t4a8+9bYPlcFFgnhtIn
         g0zwwaNJx5dU8HIfPnJzXJ/h+4p0Np4/KDetfuf1f5Z+Kg2HZOlRidBi9gX5ffBOGi
         VW4FF41anIgnK6+kLeRATj4u0yh+AbT5dcgQGN1A=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AMDifb3053455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 07:44:41 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 07:44:41 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 07:44:41 -0600
Received: from [10.250.233.118] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AMDibMa029183;
        Mon, 22 Nov 2021 07:44:37 -0600
Subject: Re: [PATCH RFC v2 4/4] phy: phy-can-transceiver: Add support for
 setting mux
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
References: <20211122125624.6431-1-a-govindraju@ti.com>
 <20211122125624.6431-5-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <cc28796e-2ebc-4aad-ffc2-4fe570b269db@ti.com>
Date:   Mon, 22 Nov 2021 19:14:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211122125624.6431-5-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Aswath,

On 22/11/21 6:26 pm, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceiver,
> muxes might need to be set. Therefore, add support for setting the mux by
> reading the mux-controls property from the device tree node.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index 6f3fe37dee0e..15056b9d68ba 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -10,6 +10,7 @@
>  #include<linux/module.h>
>  #include<linux/gpio.h>
>  #include<linux/gpio/consumer.h>
> +#include <linux/mux/consumer.h>
>  
>  struct can_transceiver_data {
>  	u32 flags;
> @@ -21,13 +22,23 @@ struct can_transceiver_phy {
>  	struct phy *generic_phy;
>  	struct gpio_desc *standby_gpio;
>  	struct gpio_desc *enable_gpio;
> +	struct mux_control *mux_ctrl;
>  };
>  
>  /* Power on function */
>  static int can_transceiver_phy_power_on(struct phy *phy)
>  {
> +	int ret;
>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
>  
> +	if (can_transceiver_phy->mux_ctrl) {
> +		ret = mux_control_select(can_transceiver_phy->mux_ctrl,
> +					 mux_control_enable_state(can_transceiver_phy->mux_ctrl));

Would need 'select MULTIPLEXER' in Kconfig.

Thanks,
Kishon
> +		if (ret) {
> +			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
> +			return ret;
> +		}
> +	}
>  	if (can_transceiver_phy->standby_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
>  	if (can_transceiver_phy->enable_gpio)
> @@ -45,6 +56,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
>  	if (can_transceiver_phy->enable_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
> +	if (can_transceiver_phy->mux_ctrl)
> +		mux_control_deselect(can_transceiver_phy->mux_ctrl);
>  
>  	return 0;
>  }
> @@ -95,6 +108,19 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata = match->data;
>  
> +	if (of_property_read_bool(dev->of_node, "mux-controls")) {
> +		struct mux_control *control;
> +		int ret;
> +
> +		control = devm_mux_control_get(dev, NULL);
> +		if (IS_ERR(control)) {
> +			ret = PTR_ERR(control);
> +			dev_err_probe(&pdev->dev, ret, "failed to get mux\n");
> +			return PTR_ERR(control);
> +		}
> +		can_transceiver_phy->mux_ctrl = control;
> +	}
> +
>  	phy = devm_phy_create(dev, dev->of_node,
>  			      &can_transceiver_phy_ops);
>  	if (IS_ERR(phy)) {
> 
