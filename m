Return-Path: <linux-can+bounces-4591-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D0B5059A
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 20:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5611541180
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ACC302145;
	Tue,  9 Sep 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r44l80wz"
X-Original-To: linux-can@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B8226D1F;
	Tue,  9 Sep 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444024; cv=none; b=J+ZuD9JD7gqcJyCUdSsk8xNRv146vy7WlYUXWC49sc9GH4YYaTa3Y9MlZmuGI3VI5lpR9tjiO76ttyTak9HUcTKU+ReV6ejNQ8ilnJoome5oib7fqx7i0hSPq1iqf52QuMd/5NTssFmhrlJR3D5KFIeM8iHzF7hl5zKSnA9AJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444024; c=relaxed/simple;
	bh=XUop5O5kW11KLry+Z6v1VzLLhJAfNPJ8c2DpXJ+7M40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rkV6DFKIvH+Fd/hHZwTh0GjA6esLG/UkOiR4JIXCzr+571UTKcUGxxf7Ab20XDIeVY+2K4twthLwKhzMm7RPfqt9wk4L8RTj7HGFpKf4GJ1q5bVrMR9W478eyRym4AKhco8vk5rzk+/NTOrx0j/l0xAwnOk11FVHiSUCeJXQgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r44l80wz; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589IrWRK402242;
	Tue, 9 Sep 2025 13:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757444012;
	bh=6i6LfJYnF0mpTj8+0TXNNaKvctcr4H3+FEZf7qooHJU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=r44l80wzheOMrM5GmYrR8X17FYUnf8TPVw0fbVSnWKIL7eYPXy3xXSdNHUFLt4IzC
	 elYF0aQNGzFzFoJ2QYfoCMMrrYmFrnOwlPMNyT4zgFeoiSTQQ/IzB+aBa43ms0ql4E
	 hfQ/0lBuhgq6RXQuGcNKENPpnwKs67CZPNedk17I=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589IrWUh3910492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 13:53:32 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 13:53:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Sep 2025 13:53:31 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589IrVg33326741;
	Tue, 9 Sep 2025 13:53:31 -0500
Message-ID: <6416cc05-ce05-4b6b-ad8d-daa327c87d2a@ti.com>
Date: Tue, 9 Sep 2025 13:53:31 -0500
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] can: m_can: Return ERR_PTR on error in allocation
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
 <20250820-topic-mcan-wakeup-source-v6-12-v9-3-0ac13f2ddd67@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-3-0ac13f2ddd67@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/20/25 07:42, Markus Schneider-Pargmann wrote:
> We have more detailed error values available, return them in the core
> driver and the calling drivers to return proper errors to callers.
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/net/can/m_can/m_can.c          | 6 +++---
>   drivers/net/can/m_can/m_can_pci.c      | 4 ++--
>   drivers/net/can/m_can/m_can_platform.c | 4 ++--
>   drivers/net/can/m_can/tcan4x5x-core.c  | 4 ++--
>   4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index c68c95cc97075ddf72dbd2f177a999a09b8a21ca..e08fae5ddf5efa8345670dd50d50954ec5d52b29 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2392,7 +2392,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>   					     sizeof(mram_config_vals) / 4);
>   	if (ret) {
>   		dev_err(dev, "Could not get Message RAM configuration.");
> -		goto out;
> +		return ERR_PTR(ret);
>   	}
>   
>   	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
> @@ -2407,7 +2407,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>   	net_dev = alloc_candev(sizeof_priv, tx_fifo_size);
>   	if (!net_dev) {
>   		dev_err(dev, "Failed to allocate CAN device");
> -		goto out;
> +		return ERR_PTR(-ENOMEM);
>   	}
>   
>   	class_dev = netdev_priv(net_dev);
> @@ -2417,7 +2417,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>   
>   	m_can_of_parse_mram(class_dev, mram_config_vals);
>   	spin_lock_init(&class_dev->tx_handling_spinlock);
> -out:
> +
>   	return class_dev;
>   }
>   EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
> index 9ad7419f88f83016e93667f4847fe536eca39ad1..eb31ed1f964491ab41c7811be317706a09951390 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -111,8 +111,8 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   
>   	mcan_class = m_can_class_allocate_dev(&pci->dev,
>   					      sizeof(struct m_can_pci_priv));
> -	if (!mcan_class)
> -		return -ENOMEM;
> +	if (IS_ERR(mcan_class))
> +		return PTR_ERR(mcan_class);
>   
>   	priv = cdev_to_priv(mcan_class);
>   
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index b832566efda042929486578fad1879c7ad4a0cff..40bd10f71f0e2fab847c40c5bd5f7d85d3d46712 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -87,8 +87,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
>   
>   	mcan_class = m_can_class_allocate_dev(&pdev->dev,
>   					      sizeof(struct m_can_plat_priv));
> -	if (!mcan_class)
> -		return -ENOMEM;
> +	if (IS_ERR(mcan_class))
> +		return PTR_ERR(mcan_class);
>   
>   	priv = cdev_to_priv(mcan_class);
>   
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index 39b0b5277b11f5cf86137528e7ebea93a6d29c80..31cc9d0abd45360de8700d0a0270af8d3e42967d 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -416,8 +416,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
>   
>   	mcan_class = m_can_class_allocate_dev(&spi->dev,
>   					      sizeof(struct tcan4x5x_priv));
> -	if (!mcan_class)
> -		return -ENOMEM;
> +	if (IS_ERR(mcan_class))
> +		return PTR_ERR(mcan_class);
>   
>   	ret = m_can_check_mram_cfg(mcan_class, TCAN4X5X_MRAM_SIZE);
>   	if (ret)
> 

Reviewed-by: Kendall Willis <k-willis@ti.com>

