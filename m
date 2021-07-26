Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75E53D5444
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 09:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhGZGuh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 02:50:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38238 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhGZGug (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 02:50:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16Q7Uw3c078624;
        Mon, 26 Jul 2021 02:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627284658;
        bh=y/+FVT5t96sBmE+P7xtNnrIFkiPnoLV8ATNRUd8CvrA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ScovOr7XhWgCXKSgpkQuYMhV8v3HSz9wTnSKrvUgK/aJ+9uVdvnigCCbIgcWbSYbR
         UeWz8oD/ClUmC+bPN3YH4rb7ZruTTnXjhLtRVJnxTs++uy2/Z2zxuSsn5DAHvhJKNp
         JgVihVeVkfQOcDlZv4BAawopwtOaJxPBiQYNZz+c=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16Q7UwNm020019
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Jul 2021 02:30:58 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Jul 2021 02:30:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Jul 2021 02:30:58 -0500
Received: from [10.250.148.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16Q7UtRX078929;
        Mon, 26 Jul 2021 02:30:56 -0500
Subject: Re: [PATCH v5] can: m_can: Add support for transceiver as phy
To:     Marc Kleine-Budde <mkl@pengutronix.de>, <linux-can@vger.kernel.org>
CC:     Faiz Abbas <faiz_abbas@ti.com>
References: <20210724174001.553047-1-mkl@pengutronix.de>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <0d25c9e4-dcca-a79d-edc6-d638629862ba@ti.com>
Date:   Mon, 26 Jul 2021 13:00:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210724174001.553047-1-mkl@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 24/07/21 11:10 pm, Marc Kleine-Budde wrote:
> From: Faiz Abbas <faiz_abbas@ti.com>
> 
> Add support for implementing transceiver node as phy. The max_bitrate
> is obtained by getting a phy attribute.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>> ---
> Hello,
> 
> picking up Aswath Govindraju's work. This iteration adds missing error
> handling in m_can_open() and m_can_plat_probe().
> 

Thank you for posting the respin.

May I know what is the base branch for this patch ? I tried applying it
on top of linux-next/master but I am getting errors.

Thanks,
Aswath

> regards,
> Marc
> 
> changes since v4:
> - add missing error handling in m_can_open()
> - remove error propagation in m_can_close()
> - add missing error handling in m_can_plat_probe()
> 
>  drivers/net/can/m_can/m_can.c          | 11 ++++++++++-
>  drivers/net/can/m_can/m_can.h          |  2 ++
>  drivers/net/can/m_can/m_can_platform.c | 13 +++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 4a1cd955da14..0cffaad905c2 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -21,6 +21,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/can/dev.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/phy/phy.h>
>  
>  #include "m_can.h"
>  
> @@ -1509,6 +1510,8 @@ static int m_can_close(struct net_device *dev)
>  	close_candev(dev);
>  	can_led_event(dev, CAN_LED_EVENT_STOP);
>  
> +	phy_power_off(cdev->transceiver);
> +
>  	return 0;
>  }
>  
> @@ -1694,10 +1697,14 @@ static int m_can_open(struct net_device *dev)
>  	struct m_can_classdev *cdev = netdev_priv(dev);
>  	int err;
>  
> -	err = m_can_clk_start(cdev);
> +	err = phy_power_on(cdev->transceiver);
>  	if (err)
>  		return err;
>  
> +	err = m_can_clk_start(cdev);
> +	if (err)
> +		goto out_phy_power_off;
> +
>  	/* open the can device */
>  	err = open_candev(dev);
>  	if (err) {
> @@ -1754,6 +1761,8 @@ static int m_can_open(struct net_device *dev)
>  	close_candev(dev);
>  exit_disable_clks:
>  	m_can_clk_stop(cdev);
> +out_phy_power_off:
> +	phy_power_off(cdev->transceiver);
>  	return err;
>  }
>  
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index ea53322d110e..56e994376a7b 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -28,6 +28,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/can/dev.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/phy/phy.h>
>  
>  /* m_can lec values */
>  enum m_can_lec_type {
> @@ -82,6 +83,7 @@ struct m_can_classdev {
>  	struct workqueue_struct *tx_wq;
>  	struct work_struct tx_work;
>  	struct sk_buff *tx_skb;
> +	struct phy *transceiver;
>  
>  	struct m_can_ops *ops;
>  
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index 9f8f69aec993..a28c84aa8fa8 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -6,6 +6,7 @@
>  // Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>  
>  #include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
>  
>  #include "m_can.h"
>  
> @@ -67,6 +68,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	void __iomem *addr;
>  	void __iomem *mram_addr;
> +	struct phy *transceiver;
>  	int irq, ret = 0;
>  
>  	mcan_class = m_can_class_allocate_dev(&pdev->dev,
> @@ -100,6 +102,16 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  		goto probe_fail;
>  	}
>  
> +	transceiver = devm_phy_optional_get(&pdev->dev, NULL);
> +	if (IS_ERR(transceiver)) {
> +		ret = PTR_ERR(transceiver);
> +		dev_err_probe(&pdev->dev, ret, "failed to get phy\n");
> +		goto probe_fail;
> +	}
> +
> +	if (transceiver)
> +		mcan_class->can.bitrate_max = transceiver->attrs.max_link_rate;
> +
>  	priv->base = addr;
>  	priv->mram_base = mram_addr;
>  
> @@ -107,6 +119,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  	mcan_class->pm_clock_support = 1;
>  	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
>  	mcan_class->dev = &pdev->dev;
> +	mcan_class->transceiver = transceiver;
>  
>  	mcan_class->ops = &m_can_plat_ops;
>  
> 

