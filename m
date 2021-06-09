Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88A3A0ECE
	for <lists+linux-can@lfdr.de>; Wed,  9 Jun 2021 10:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhFIIiL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Jun 2021 04:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhFIIiL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Jun 2021 04:38:11 -0400
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2DC061574;
        Wed,  9 Jun 2021 01:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1623227773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PpNvpQPcu15pxvP7Mmo8VoEZEWW/kOay4d2SYbxNK+Y=;
        b=Ckiwt8lbH/YgtEoFYVlp9bSC/Isjtt1AZ3uv76uWVLzvjT+dq1lziwLwGZx1mch8yJJ6ew
        21ejmVrqqVIJCk+e8b/4OpwXr48CBpXisKz6/QZNZJwiJTL7LSPB4FrpGXS/lHp89bvejc
        MapfF3xYaovVX3qayvgqPzY1V+Y5cHA=
Received: from [192.168.0.2] (host-87-8-57-171.retail.telecomitalia.it [87.8.57.171])
        by ziongate (OpenSMTPD) with ESMTPSA id 24ff77a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Jun 2021 08:36:13 +0000 (UTC)
Subject: Re: [PATCH 5/5] can: flexcan: add mcf5441x support
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc:     "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20210608204542.983925-1-angelo@kernel-space.org>
 <20210608204542.983925-5-angelo@kernel-space.org>
 <DB8PR04MB6795CE1FF40605F69E3A0040E6369@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <7c1151fc-cc28-cbc0-c385-313428b32dd7@kernel-space.org>
Date:   Wed, 9 Jun 2021 10:35:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB6795CE1FF40605F69E3A0040E6369@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Joakim, Geert,

thanks for the feedbacks,

On 09/06/21 4:05 AM, Joakim Zhang wrote:
> 
>> -----Original Message-----
>> From: Angelo Dureghello <angelo@kernel-space.org>
>> Sent: 2021Äê6ÔÂ9ÈÕ 4:46
>> To: gerg@linux-m68k.org; wg@grandegger.com; mkl@pengutronix.de
>> Cc: geert@linux-m68k.org; linux-m68k@vger.kernel.org;
>> linux-can@vger.kernel.org; Joakim Zhang <qiangqing.zhang@nxp.com>;
>> Angelo Dureghello <angelo@kernel-space.org>
>> Subject: [PATCH 5/5] can: flexcan: add mcf5441x support
>>
>> Add flexcan support for NXP ColdFire mcf5441x family.
>>
>> This flexcan module is quite similar to imx6 flexcan module, but with some
>> exceptions:
>>
>> - 3 separate interrupt sources, MB, BOFF and ERR,
>> - implements 16 mb only,
>> - m68k architecture is not supporting devicetrees, so a
>>    platform data check/case has been added,
>> - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
>>    module.
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>> ---
>>   drivers/net/can/flexcan.c | 80 +++++++++++++++++++++++++++++++--------
>>   1 file changed, 65 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c index
>> 57f3635ad8d7..af95273327cd 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/of_device.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/platform_data/flexcan-mcf.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>>   #include <linux/regulator/consumer.h>
>> @@ -205,6 +206,10 @@
>>
>>   #define FLEXCAN_TIMEOUT_US		(250)
>>
>> +#define FLEXCAN_OFFS_INT_BOFF		1
>> +#define FLEXCAN_OFFS_INT_ERR		3
>> +#define FLEXCAN_MB_CNT_MCF		16
> 
> Could you rename the macro, like FLEXCAN_MCF5411X_, then user know this only for mcf5411x? And move this into header file?
> Why not put this also into mcf_flexcan_platform_data? The interrupt offset and the numbers of mailboxes would be various from different SoCs.

ok for me, i can name them as

FLEXCAN_MCF5411X_OFFS_INT_BOF
FLEXCAN_MCF5411X_OFFS_INT_ERR
FLEXCAN_MCF5411X_MB_CNT_MCF

and will move them in platform data header


> 
>>   /* FLEXCAN hardware feature flags
>>    *
>>    * Below is some version info we got:
>> @@ -246,6 +251,8 @@
>>   #define FLEXCAN_QUIRK_SUPPORT_ECC BIT(10)
>>   /* Setup stop mode with SCU firmware to support wakeup */  #define
>> FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW BIT(11)
>> +/* Setup for flexcan module as in mcf, 16 mb, 3 separate interrupts  */
>> +#define FLEXCAN_QUIRK_SETUP_MCF BIT(12)
>>
>>   /* Structure of the message buffer */
>>   struct flexcan_mb {
>> @@ -371,6 +378,12 @@ struct flexcan_priv {
>>   	void (*write)(u32 val, void __iomem *addr);  };
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
>> @@ -637,13 +650,17 @@ static int flexcan_clks_enable(const struct
>> flexcan_priv *priv)  {
>>   	int err;
>>
>> -	err = clk_prepare_enable(priv->clk_ipg);
>> -	if (err)
>> -		return err;
>> +	if (priv->clk_ipg) {
>> +		err = clk_prepare_enable(priv->clk_ipg);
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
> 
> No need do this check, it will be handled in clk_prepare_enable() / clk_disable_unprepare(). So this change is unnecessary.
> 

as Geert pointed out, right now without this protection
(that shouldn't anyway harm), probe fails:

[    1.680000] flexcan: probe of flexcan.0 failed with error -22


>>   	return err;
>>   }
>> @@ -1401,8 +1418,13 @@ static int flexcan_rx_offload_setup(struct
>> net_device *dev)
>>   		priv->mb_size = sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
>>   	else
>>   		priv->mb_size = sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
>> -	priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
>> -			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
>> +
>> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF) {
>> +		priv->mb_count = FLEXCAN_MB_CNT_MCF;
>> +	} else {
>> +		priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
>> +				 (sizeof(priv->regs->mb[1]) / priv->mb_size);
>> +	}
>>
>>   	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
>>   		priv->tx_mb_reserved =
>> @@ -1774,6 +1796,18 @@ static int flexcan_open(struct net_device *dev)
>>   	if (err)
>>   		goto out_can_rx_offload_disable;
>>
>> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_MCF) {
>> +		err = request_irq(dev->irq + FLEXCAN_OFFS_INT_BOFF,
>> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>> +		if (err)
>> +			goto out_can_rx_offload_disable;
>> +
>> +		err = request_irq(dev->irq + FLEXCAN_OFFS_INT_ERR,
>> +				  flexcan_irq, IRQF_SHARED, dev->name, dev);
>> +		if (err)
>> +			goto out_can_rx_offload_disable;
>> +	}
>> +
>>   	flexcan_chip_interrupts_enable(dev);
>>
>>   	can_led_event(dev, CAN_LED_EVENT_OPEN); @@ -2047,7 +2081,9 @@
>> static int flexcan_probe(struct platform_device *pdev)
>>   	struct regulator *reg_xceiver;
>>   	struct clk *clk_ipg = NULL, *clk_per = NULL;
>>   	struct flexcan_regs __iomem *regs;
>> +	struct mcf_flexcan_platform_data *pdata;
>>   	int err, irq;
>> +	bool big_endian_module;
>>   	u8 clk_src = 1;
>>   	u32 clock_freq = 0;
>>
>> @@ -2059,11 +2095,17 @@ static int flexcan_probe(struct platform_device
>> *pdev)
>>   	else if (IS_ERR(reg_xceiver))
>>   		return PTR_ERR(reg_xceiver);
>>
>> -	if (pdev->dev.of_node) {
>> -		of_property_read_u32(pdev->dev.of_node,
>> -				     "clock-frequency", &clock_freq);
>> -		of_property_read_u8(pdev->dev.of_node,
>> -				    "fsl,clk-source", &clk_src);
>> +	pdata = dev_get_platdata(&pdev->dev);
>> +	if (pdata) {
>> +		clock_freq = pdata->clock_frequency;
>> +		clk_src = pdata->clk_src;
>> +	} else {
>> +		if (pdev->dev.of_node) {
>> +			of_property_read_u32(pdev->dev.of_node,
>> +					     "clock-frequency", &clock_freq);
>> +			of_property_read_u8(pdev->dev.of_node,
>> +					    "fsl,clk-source", &clk_src);
>> +		}
>>   	}
>>
>>   	if (!clock_freq) {
>> @@ -2091,6 +2133,11 @@ static int flexcan_probe(struct platform_device
>> *pdev)
>>
>>   	devtype_data = of_device_get_match_data(&pdev->dev);
>>
>> +	if (pdata && !devtype_data) {
>> +		devtype_data =
>> +			(struct flexcan_devtype_data *)&fsl_mcf_devtype_data;
>> +	}
>> +
>>   	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
>>   	    !(devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)) {
>>   		dev_err(&pdev->dev, "CAN-FD mode doesn't work with FIFO
>> mode!\n"); @@ -2110,8 +2157,11 @@ static int flexcan_probe(struct
>> platform_device *pdev)
>>
>>   	priv = netdev_priv(dev);
>>
>> -	if (of_property_read_bool(pdev->dev.of_node, "big-endian") ||
>> -	    devtype_data->quirks & FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN) {
>> +	big_endian_module = pdata ? pdata->big_endian :
>> +		of_property_read_bool(pdev->dev.of_node, "big-endian");
>> +
>> +	if (big_endian_module ||
>> +		(devtype_data->quirks & FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN)) {
>>   		priv->read = flexcan_read_be;
>>   		priv->write = flexcan_write_be;
>>   	} else {
>> --
> 
> Best Regards,
> Joakim Zhang
>> 2.31.1
> 

Best Regards,
-- 
Angelo Dureghello
+++ kernelspace +++
+E: angelo AT kernel-space.org
+W: www.kernel-space.org
