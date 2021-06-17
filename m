Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40A33ABE94
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 00:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhFQWRh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 18:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFQWRh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 18:17:37 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F60C061574;
        Thu, 17 Jun 2021 15:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623968125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMt1TLYEt9dlOXGA+w25phC64EajGIBc119mgltbYKM=;
        b=v+8tcnR3os8fQyC5yc/sWYF/zKPcYUhq3E14Jf7EOtvSHM6Zsh2LXSIqMv4DHt3mMDfCks
        qURLpH2MJrmRWJk6WrkFULx6dCCuzLo1wEDnUXp0kgt8DndAzW8SVaIeZRUQ/j0JNgnTWR
        1qn2u3kK++uM4U2gWKgtKVUJVmSTNSI=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 5fca30a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Jun 2021 22:15:25 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] can: flexcan: add mcf5441x support
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <20210616231652.738027-5-angelo@kernel-space.org>
 <20210617130053.yovl3b3p5mn2srnd@pengutronix.de>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <b6b948f4-dcdb-5f75-9fe8-138de0acf1f7@kernel-space.org>
Date:   Fri, 18 Jun 2021 00:14:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210617130053.yovl3b3p5mn2srnd@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Mark,

On 17/06/21 3:00 PM, Marc Kleine-Budde wrote:
> On 17.06.2021 01:16:52, Angelo Dureghello wrote:
>> Add flexcan support for NXP ColdFire mcf5441x family.
>>
>> This flexcan module is quite similar to imx6 flexcan module, but
>> with some exceptions:
>>
>> - 3 separate interrupt sources, MB, BOFF and ERR,
>> - implements 16 mb only,
>> - m68k architecture is not supporting devicetrees, so a
>>    platform data check/case has been added,
>> - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
>>    module.
> 
> Please add the mcg5441x to the "FLEXCAN hardware feature flags" table in
> the driver, and add a new column for the number of mailboxes.
> 

need a little help here: where can i find IP version and
FlexCAN version ? I am 90% sure mcf5441x is FlexCAN2 (no FD).
No trace of IP version in the datasheets.

>> ---
>> Changes for v2:
>> - re-add platform data handling restarting from 2c0ac9208135
>> - re-add flexcan_id_table, as from 2c0ac9208135
>> - usinig irq resources for ERR and BOFF interrupts
>> - add missing free_irq() for interrupts
>> - minor syntax fixes
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>> ---
>>   drivers/net/can/flexcan.c | 95 ++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 84 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index 57f3635ad8d7..2188dc36a010 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/of_device.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/can/platform/mcf5441x.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>>   #include <linux/regulator/consumer.h>
>> @@ -246,6 +247,8 @@
>>   #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
>>   /* Setup stop mode with SCU firmware to support wakeup */
>>   #define FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
>> +/* Setup for flexcan module as in mcf, 16 mb, 3 separate interrupts  */
>> +#define FLEXCAN_QUIRK_SETUP_MCF BIT(12)
>>   
>>   /* Structure of the message buffer */
>>   struct flexcan_mb {
>> @@ -363,6 +366,9 @@ struct flexcan_priv {
>>   	struct regulator *reg_xceiver;
>>   	struct flexcan_stop_mode stm;
>>   
>> +	int irq_boff;
>> +	int irq_err;
>> +
>>   	/* IPC handle when setup stop mode by System Controller firmware(scfw) */
>>   	struct imx_sc_ipc *sc_ipc_handle;
>>   
>> @@ -371,6 +377,12 @@ struct flexcan_priv {
>>   	void (*write)(u32 val, void __iomem *addr);
>>   };
>>   
>> +static const struct flexcan_devtype_data fsl_mcf_devtype_data = {
>> +	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
>> +		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>> +		FLEXCAN_QUIRK_SETUP_MCF,
>> +};
>> +
>>   static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
>>   	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
>>   		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>> @@ -637,13 +649,17 @@ static int flexcan_clks_enable(const struct flexcan_priv *priv)
>>   {
>>   	int err;
>>   
>> -	err = clk_prepare_enable(priv->clk_ipg);
>> -	if (err)
>> -		return err;
>> +	if (priv->clk_ipg) {
>> +		err = clk_prepare_enable(priv->clk_ipg);
> 
> Does the coldfire clk_disable_unprepare() work with NULL pointers? I'm
> asking for flexcan_clks_disable()...
> 

tested, it's ok with NULL.

>> +		if (err)
>> +			return err;
>> +	}
>>   
>> -	err = clk_prepare_enable(priv->clk_per);
>> -	if (err)
>> -		clk_disable_unprepare(priv->clk_ipg);
>> +	if (priv->clk_per) {
>> +		err = clk_prepare_enable(priv->clk_per);
>> +		if (err)
>> +			clk_disable_unprepare(priv->clk_ipg);
>> +	}
>>   
>>   	return err;
>>   }
>> @@ -1401,8 +1417,12 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
>>   		priv->mb_size = sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
>>   	else
>>   		priv->mb_size = sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
>> -	priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
>> -			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
>> +
>> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF)
>> +		priv->mb_count = FLEXCAN_MCF5411X_MB_CNT_MCF;
>> +	else
>> +		priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
>> +				 (sizeof(priv->regs->mb[1]) / priv->mb_size);
>>   
>>   	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
>>   		priv->tx_mb_reserved =
>> @@ -1774,6 +1794,18 @@ static int flexcan_open(struct net_device *dev)
>>   	if (err)
>>   		goto out_can_rx_offload_disable;
>>   
>> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF) {
>> +		err = request_irq(priv->irq_boff,
>> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>> +		if (err)
>> +			goto out_can_rx_offload_disable;
> 
> Please add proper error handling.

done

> 
>> +
>> +		err = request_irq(priv->irq_err,
>> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>> +		if (err)
>> +			goto out_can_rx_offload_disable;
> 
> Please add proper error handling.

done

> 
>> +	}
>> +
>>   	flexcan_chip_interrupts_enable(dev);
>>   
>>   	can_led_event(dev, CAN_LED_EVENT_OPEN);
>> @@ -1804,6 +1836,12 @@ static int flexcan_close(struct net_device *dev)
>>   	netif_stop_queue(dev);
>>   	flexcan_chip_interrupts_disable(dev);
>>   	free_irq(dev->irq, dev);
>> +
>> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF) {
>> +		free_irq(priv->irq_boff, dev);
>> +		free_irq(priv->irq_err, dev);
>> +	}
> 
> please free in the opposite order of requesting
> 

done

>> +
>>   	can_rx_offload_disable(&priv->offload);
>>   	flexcan_chip_stop_disable_on_error(dev);
>>   
>> @@ -2039,14 +2077,26 @@ static const struct of_device_id flexcan_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, flexcan_of_match);
>>   
>> +static const struct platform_device_id flexcan_id_table[] = {
>> +	{
>> +		.name = "flexcan-mcf",
>> +		.driver_data = (kernel_ulong_t)&fsl_mcf_devtype_data,
>> +	}, {
>> +		/* sentinel */
>> +	},
>> +};
>> +MODULE_DEVICE_TABLE(platform, flexcan_id_table);
>> +
>>   static int flexcan_probe(struct platform_device *pdev)
>>   {
>> +	const struct of_device_id *of_id;
>>   	const struct flexcan_devtype_data *devtype_data;
>>   	struct net_device *dev;
>>   	struct flexcan_priv *priv;
>>   	struct regulator *reg_xceiver;
>>   	struct clk *clk_ipg = NULL, *clk_per = NULL;
>>   	struct flexcan_regs __iomem *regs;
>> +	struct mcf_flexcan_platform_data *pdata;
>>   	int err, irq;
>>   	u8 clk_src = 1;
>>   	u32 clock_freq = 0;
>> @@ -2061,9 +2111,15 @@ static int flexcan_probe(struct platform_device *pdev)
>>   
>>   	if (pdev->dev.of_node) {
>>   		of_property_read_u32(pdev->dev.of_node,
>> -				     "clock-frequency", &clock_freq);
>> +				"clock-frequency", &clock_freq);
> 
> unrelated change

removed

> 
>>   		of_property_read_u8(pdev->dev.of_node,
>> -				    "fsl,clk-source", &clk_src);
>> +				"fsl,clk-source", &clk_src);
> 
> unrelated change

removed

> 
>> +	} else {
>> +		pdata = dev_get_platdata(&pdev->dev);
>> +		if (pdata) {
>> +			clock_freq = pdata->clock_frequency;
>> +			clk_src = pdata->clk_src;
>> +		}
>>   	}
>>   
>>   	if (!clock_freq) {
>> @@ -2089,7 +2145,14 @@ static int flexcan_probe(struct platform_device *pdev)
>>   	if (IS_ERR(regs))
>>   		return PTR_ERR(regs);
>>   
>> -	devtype_data = of_device_get_match_data(&pdev->dev);
>> +	of_id = of_match_device(flexcan_of_match, &pdev->dev);
>> +	if (of_id)
>> +		devtype_data = of_id->data;
>> +	else if (platform_get_device_id(pdev)->driver_data)
>> +		devtype_data = (struct flexcan_devtype_data *)
>> +			platform_get_device_id(pdev)->driver_data;
>> +	else
>> +		return -ENODEV;
>>   
>>   	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
>>   	    !(devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)) {
>> @@ -2133,6 +2196,15 @@ static int flexcan_probe(struct platform_device *pdev)
>>   	priv->devtype_data = devtype_data;
>>   	priv->reg_xceiver = reg_xceiver;
>>   
>> +	if (devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF) {
>> +		priv->irq_boff = platform_get_irq(pdev, 1);
>> +		if (priv->irq_boff <= 0)
>> +			return -ENODEV;
> 
> Please add proper error handling.

done

> 
>> +		priv->irq_err = platform_get_irq(pdev, 2);
>> +		if (priv->irq_err <= 0)
>> +			return -ENODEV;
> 
> Please add proper error handling.

done

> 
>> +	}
>> +
>>   	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) {
>>   		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD |
>>   			CAN_CTRLMODE_FD_NON_ISO;
>> @@ -2322,6 +2394,7 @@ static struct platform_driver flexcan_driver = {
>>   	},
>>   	.probe = flexcan_probe,
>>   	.remove = flexcan_remove,
>> +	.id_table = flexcan_id_table,
>>   };
>>   
>>   module_platform_driver(flexcan_driver);
>> -- 
>> 2.31.1
>>
>>
> 
> regards,
> Marc
> 

Regards,
angelo


