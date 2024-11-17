Return-Path: <linux-can+bounces-2081-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F679D04C4
	for <lists+linux-can@lfdr.de>; Sun, 17 Nov 2024 18:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D491F21EF3
	for <lists+linux-can@lfdr.de>; Sun, 17 Nov 2024 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B51DA63C;
	Sun, 17 Nov 2024 17:14:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B113A1CD;
	Sun, 17 Nov 2024 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731863667; cv=none; b=In9AHkg8E1wxhUTpOzPOlWDPPWBskET5IvuD5LuqDx8KIfpa02WtrAA1QpkUJzhr1gnsnUquWGyh8FXbGCcVnXpbB08PreMJY/3MKyGgWnEtBKj+7kvA79W92hesbt05BHRU5wGdkvPSGppjS7+JJu93jBRTReLNhzZwuYGEmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731863667; c=relaxed/simple;
	bh=a8GyKpn0jcOgx76uziTiiFRmYGPv9um3ohgxcewyRkg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=YqiDNXagsl7FfXVvLD7sJ5TJkN9P3jB9ex8H8yEhFZ5swg8GZWTHovAz0dVgQL5QeqMXdaVY4UyPr680Fdcm8DmXJrMpMFsAov0hx64bksy1pDVBmJPB6r9L3E4gstEoCcKgJw0X88Ek5orZRyHVEzNcL4rBc1oVoMfoJvj3UGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.152.88) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 17 Nov
 2024 20:14:12 +0300
Message-ID: <c847e042-cc66-462e-a857-d1d9e500a081@omp.ru>
Date: Sun, 17 Nov 2024 20:14:11 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCHv2 net-next] net: modernize ioremap in probe
To: Rosen Penev <rosenp@gmail.com>, <netdev@vger.kernel.org>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kurt Kanzenbach <kurt@linutronix.de>, Vladimir Oltean
	<olteanv@gmail.com>, Chris Snook <chris.snook@gmail.com>, Marcin Wojtas
	<marcin.s.wojtas@gmail.com>, Russell King <linux@armlinux.org.uk>, Horatiu
 Vultur <horatiu.vultur@microchip.com>, "maintainer:MICROCHIP LAN966X ETHERNET
 DRIVER" <UNGLinuxDriver@microchip.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?=
	<niklas.soderlund@ragnatech.se>, Doug Berger <opendmb@gmail.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>, "open
 list:MCAN MMIO DEVICE DRIVER" <linux-can@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:RENESAS ETHERNET SWITCH DRIVER"
	<linux-renesas-soc@vger.kernel.org>
References: <20241111200212.5907-1-rosenp@gmail.com>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <20241111200212.5907-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/17/2024 17:00:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 189220 [Nov 17 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.7
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 41 0.3.41
 623e98d5198769c015c72f45fabbb9f77bdb702b
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.152.88
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/17/2024 17:04:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/17/2024 3:00:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 11/11/24 11:02 PM, Rosen Penev wrote:

> I changed resource acquisition to be performed in a single step. Possible
> because devm is used here.

   Have you tested it? Asking because switching to devm_platform_ioremap_resource_byname()
and devm_platform_get_and_ioremap_resource() seems to add devm_request_mem_region() call
into the picture...
   I'm also not sure the single patch per drivers/net/ would be enough, but that's for the
maintainers to decide...

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
[...]

> diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
> index 283ec5a6e23c..940c4fa6a924 100644
> --- a/drivers/net/dsa/hirschmann/hellcreek.c
> +++ b/drivers/net/dsa/hirschmann/hellcreek.c
[...]
> @@ -1982,23 +1981,12 @@ static int hellcreek_probe(struct platform_device *pdev)
>  
>  	hellcreek->dev = dev;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tsn");
> -	if (!res) {
> -		dev_err(dev, "No memory region provided!\n");
> -		return -ENODEV;
> -	}
> -
> -	hellcreek->base = devm_ioremap_resource(dev, res);
> +	hellcreek->base = devm_platform_ioremap_resource_byname(pdev, "tsn");

   The new code here should behave equivalently to the old, so seems OK.

>  	if (IS_ERR(hellcreek->base))
>  		return PTR_ERR(hellcreek->base);
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ptp");
> -	if (!res) {
> -		dev_err(dev, "No PTP memory region provided!\n");
> -		return -ENODEV;
> -	}
> -
> -	hellcreek->ptp_base = devm_ioremap_resource(dev, res);
> +	hellcreek->ptp_base =
> +		devm_platform_ioremap_resource_byname(pdev, "ptp");

   Here as well...

[...]
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 571631a30320..faf853edc0db 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -7425,21 +7425,17 @@ static int mvpp2_init(struct platform_device *pdev, struct mvpp2 *priv)
>  static int mvpp2_get_sram(struct platform_device *pdev,
>  			  struct mvpp2 *priv)
>  {
> -	struct resource *res;
>  	void __iomem *base;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	if (!res) {
> +	base = devm_platform_ioremap_resource(pdev, 2);
> +	if (IS_ERR(base)) {
>  		if (has_acpi_companion(&pdev->dev))
>  			dev_warn(&pdev->dev, "ACPI is too old, Flow control not supported\n");
>  		else
> -			dev_warn(&pdev->dev, "DT is too old, Flow control not supported\n");
> -		return 0;
> -	}
> -
> -	base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(base))
> +			dev_warn(&pdev->dev,
> +				 "DT is too old, Flow control not supported\n");
>  		return PTR_ERR(base);
> +	}
>  
>  	priv->cm3_base = base;
>  	return 0;

   This change also seems to look sane...

[...]
> diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
> index 8d18dae4d8fb..8ef52fc46a01 100644
> --- a/drivers/net/ethernet/renesas/rswitch.c
> +++ b/drivers/net/ethernet/renesas/rswitch.c
[...]
> @@ -2074,7 +2067,7 @@ static int renesas_eth_sw_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  	priv->pdev = pdev;
> -	priv->addr = devm_ioremap_resource(&pdev->dev, res);
> +	priv->addr = devm_platform_ioremap_resource_byname(pdev, "secure_base");
>  	if (IS_ERR(priv->addr))
>  		return PTR_ERR(priv->addr);
>  

   This one looks OKish too...

> diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
> index 6b3f7fca8d15..bfe08facc707 100644
> --- a/drivers/net/ethernet/renesas/rtsn.c
> +++ b/drivers/net/ethernet/renesas/rtsn.c
> @@ -1297,14 +1297,8 @@ static int rtsn_probe(struct platform_device *pdev)
>  	ndev->netdev_ops = &rtsn_netdev_ops;
>  	ndev->ethtool_ops = &rtsn_ethtool_ops;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gptp");
> -	if (!res) {
> -		dev_err(&pdev->dev, "Can't find gptp resource\n");
> -		ret = -EINVAL;
> -		goto error_free;
> -	}
> -
> -	priv->ptp_priv->addr = devm_ioremap_resource(&pdev->dev, res);
> +	priv->ptp_priv->addr =
> +		devm_platform_ioremap_resource_byname(pdev, "gptp");
>  	if (IS_ERR(priv->ptp_priv->addr)) {
>  		ret = PTR_ERR(priv->ptp_priv->addr);
>  		goto error_free;

   Looks OKish too...

> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index d072f394eecb..07d1f1504a97 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -3351,31 +3351,12 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
>  
>  	if (mdp->cd->tsu) {
>  		int port = pdev->id < 0 ? 0 : pdev->id % 2;
> -		struct resource *rtsu;
>  
> -		rtsu = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -		if (!rtsu) {
> -			dev_err(&pdev->dev, "no TSU resource\n");
> -			ret = -ENODEV;
> -			goto out_release;
> -		}
> -		/* We can only request the  TSU region  for the first port
> -		 * of the two  sharing this TSU for the probe to succeed...
> -		 */
> -		if (port == 0 &&
> -		    !devm_request_mem_region(&pdev->dev, rtsu->start,
> -					     resource_size(rtsu),
> -					     dev_name(&pdev->dev))) {
> -			dev_err(&pdev->dev, "can't request TSU resource.\n");
> -			ret = -EBUSY;
> -			goto out_release;
> -		}
>  		/* ioremap the TSU registers */
> -		mdp->tsu_addr = devm_ioremap(&pdev->dev, rtsu->start,
> -					     resource_size(rtsu));
> -		if (!mdp->tsu_addr) {
> +		mdp->tsu_addr = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(mdp->tsu_addr)) {
>  			dev_err(&pdev->dev, "TSU region ioremap() failed.\n");
> -			ret = -ENOMEM;
> +			ret = PTR_ERR(mdp->tsu_addr);
>  			goto out_release;
>  		}
>  		mdp->port = port;

   No, this one won't fly since you're removing the port == 0 check... :-/
This code looks so strange on purpose... :-)

[...]
> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
> index dd3ed2d6430b..725e5c13d212 100644
> --- a/drivers/net/mdio/mdio-ipq4019.c
> +++ b/drivers/net/mdio/mdio-ipq4019.c
> @@ -256,7 +256,7 @@ static int ipq_mdio_reset(struct mii_bus *bus)
>  	/* To indicate CMN_PLL that ethernet_ldo has been ready if platform resource 1
>  	 * is specified in the device tree.
>  	 */
> -	if (priv->eth_ldo_rdy) {
> +	if (!IS_ERR(priv->eth_ldo_rdy)) {

   What's that? :-/
   Ah, devm_ioremap_resource() returns error ptr too, so this looks like a fix for
the existing code?

>  		val = readl(priv->eth_ldo_rdy);
>  		val |= BIT(0);
>  		writel(val, priv->eth_ldo_rdy);
[...]
> @@ -351,9 +350,7 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>  
>  	/* The platform resource is provided on the chipset IPQ5018 */
>  	/* This resource is optional */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (res)
> -		priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
> +	priv->eth_ldo_rdy = devm_platform_ioremap_resource(pdev, 1);
>  
>  	bus->name = "ipq4019_mdio";
>  	bus->read = ipq4019_mdio_read_c22;

   Other than that looks OKish...

[...]
> diff --git a/drivers/net/mdio/mdio-octeon.c b/drivers/net/mdio/mdio-octeon.c
> index 2beb83154d39..cb53dccbde1a 100644
> --- a/drivers/net/mdio/mdio-octeon.c
> +++ b/drivers/net/mdio/mdio-octeon.c
> @@ -17,37 +17,20 @@ static int octeon_mdiobus_probe(struct platform_device *pdev)
>  {
>  	struct cavium_mdiobus *bus;
>  	struct mii_bus *mii_bus;
> -	struct resource *res_mem;
> -	resource_size_t mdio_phys;
> -	resource_size_t regsize;
>  	union cvmx_smix_en smi_en;
> -	int err = -ENOENT;
> +	int err;
>  
>  	mii_bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*bus));
>  	if (!mii_bus)
>  		return -ENOMEM;
>  
> -	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res_mem == NULL) {
> -		dev_err(&pdev->dev, "found no memory resource\n");
> -		return -ENXIO;
> -	}
> -
>  	bus = mii_bus->priv;
>  	bus->mii_bus = mii_bus;
> -	mdio_phys = res_mem->start;
> -	regsize = resource_size(res_mem);
>  
> -	if (!devm_request_mem_region(&pdev->dev, mdio_phys, regsize,
> -				     res_mem->name)) {
> -		dev_err(&pdev->dev, "request_mem_region failed\n");
> -		return -ENXIO;
> -	}
> -
> -	bus->register_base = devm_ioremap(&pdev->dev, mdio_phys, regsize);
> -	if (!bus->register_base) {
> +	bus->register_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(bus->register_base)) {
>  		dev_err(&pdev->dev, "dev_ioremap failed\n");
> -		return -ENOMEM;
> +		return PTR_ERR(bus->register_base);
>  	}
>  
>  	smi_en.u64 = 0;

   Seems OKish too...

MBR, Sergey

