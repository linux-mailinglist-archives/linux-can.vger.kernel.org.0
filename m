Return-Path: <linux-can+bounces-4592-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9170EB5059E
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 20:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EF5E1DA7
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D9830215D;
	Tue,  9 Sep 2025 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="inNvIB7D"
X-Original-To: linux-can@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C660226D1F;
	Tue,  9 Sep 2025 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444087; cv=none; b=WMdLd03rA1y0JRY3eNpvgf19W8wlEElB2z6ZkHODYjfE+YGBn4dlvntOQIxuEXpLVNuSSVN4bNfdSsWfInIpnXyOqW1gPdj25p4myDzYCuafh92sYD+RmJw39ITp8Bzw+553s6TV0w8+RxVaiGvS6emuDbeTKYsTDLPlkmUkvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444087; c=relaxed/simple;
	bh=Yh8jgYb8Uj5lQjNFBt61ZfF6fivRA1mYuEllXlc3BrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X6kn8TlIRRbFYjKKHkFQQ8vsHIEmYB3naCbqGhNL8+vL06U58/wfJFgCuE1rzSf9Y5BH5QLrEmHdIU5984BC6AHFeG8YSfapW2VJpT4gSJ/7wFoJcp1s1+Z1yyZUf+eN8ZlCtSz0bTi965/d2odQujUeGZ9NudS/4eSKM2yeTdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=inNvIB7D; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589IsaFZ402373;
	Tue, 9 Sep 2025 13:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757444076;
	bh=n7kuWADmF+exW67gsu6ESvXX9y23xGBLql4xO+XhFGk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=inNvIB7DZ1WpOCys3JrD6PvR0A6nw4tSaGVV16gNXa/NPb3Hn+DVuoxETYxm16tVP
	 +Jcnwi0e0Qa0wzVlgnuKoka4hlXrgTI8JY/6yYzTSgw2OJqbI2WB+O9qmkM0u0qwEJ
	 IqGpS/7RkMdeDD27AgMiRvleVm4TRbIASqRFH/l4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589IsavJ565418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 13:54:36 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 13:54:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Sep 2025 13:54:35 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589IsZHL3031426;
	Tue, 9 Sep 2025 13:54:35 -0500
Message-ID: <8dc09eb8-4118-4220-8993-f2d090b5a254@ti.com>
Date: Tue, 9 Sep 2025 13:54:35 -0500
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] can: m_can: Map WoL to device_set_wakeup_enable
To: Markus Schneider-Pargmann <msp@baylibre.com>,
        Chandrasekar Ramakrishnan
	<rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>,
        Akashdeep
 Kaur <a-kaur@ti.com>, Simon Horman <horms@kernel.org>,
        Vincent MAILHOL
	<mailhol.vincent@wanadoo.fr>,
        <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
 <20250820-topic-mcan-wakeup-source-v6-12-v9-2-0ac13f2ddd67@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-2-0ac13f2ddd67@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/20/25 07:42, Markus Schneider-Pargmann wrote:
> In some devices the pins of the m_can module can act as a wakeup source.
> This patch helps do that by connecting the PHY_WAKE WoL option to
> device_set_wakeup_enable. By marking this device as being wakeup
> enabled, this setting can be used by platform code to decide which
> sleep or poweroff mode to use.
> 
> Also this prepares the driver for the next patch in which the pinctrl
> settings are changed depending on the desired wakeup source.
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index fe74dbd2c9663b7090678ab78318698d50ffb481..c68c95cc97075ddf72dbd2f177a999a09b8a21ca 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2222,6 +2222,36 @@ static int m_can_set_coalesce(struct net_device *dev,
>   	return 0;
>   }
>   
> +static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
> +{
> +	struct m_can_classdev *cdev = netdev_priv(dev);
> +
> +	wol->supported = device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
> +	wol->wolopts = device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
> +}
> +
> +static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
> +{
> +	struct m_can_classdev *cdev = netdev_priv(dev);
> +	bool wol_enable = !!(wol->wolopts & WAKE_PHY);
> +	int ret;
> +
> +	if (wol->wolopts & ~WAKE_PHY)
> +		return -EINVAL;
> +
> +	if (wol_enable == device_may_wakeup(cdev->dev))
> +		return 0;
> +
> +	ret = device_set_wakeup_enable(cdev->dev, wol_enable);
> +	if (ret) {
> +		netdev_err(cdev->net, "Failed to set wakeup enable %pE\n",
> +			   ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
>   	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
>   		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
> @@ -2231,10 +2261,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
>   	.get_ts_info = ethtool_op_get_ts_info,
>   	.get_coalesce = m_can_get_coalesce,
>   	.set_coalesce = m_can_set_coalesce,
> +	.get_wol = m_can_get_wol,
> +	.set_wol = m_can_set_wol,
>   };
>   
>   static const struct ethtool_ops m_can_ethtool_ops = {
>   	.get_ts_info = ethtool_op_get_ts_info,
> +	.get_wol = m_can_get_wol,
> +	.set_wol = m_can_set_wol,
>   };
>   
>   static int register_m_can_dev(struct m_can_classdev *cdev)
> @@ -2361,6 +2395,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>   		goto out;
>   	}
>   
> +	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
> +		device_set_wakeup_capable(dev, true);
> +
>   	/* Get TX FIFO size
>   	 * Defines the total amount of echo buffers for loopback
>   	 */
> 

Reviewed-by: Kendall Willis <k-willis@ti.com>

