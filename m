Return-Path: <linux-can+bounces-4475-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE33B43698
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7F65A097E
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A92D77E7;
	Thu,  4 Sep 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XEFHiV93"
X-Original-To: linux-can@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2AB286D57;
	Thu,  4 Sep 2025 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976745; cv=none; b=QgNRaBepOqRJiM44icT4bLkh/o//kTBT8Ijoh07zfwSzOdTXfSR0Vbf3TUJYy0ZRpPWSFP5Qov3gHOrS04ojzd0RVqUBOWgbmryF39NTUP6Q5ghzxeqxkHAMrKHIuVCdPAtAhWhdJBloRKTqO84CrMNpT3ATKDxBBFmck/Btucw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976745; c=relaxed/simple;
	bh=qpJEbsGUlkK+Dfp4ef8wzkLzFlzAmg1kYILcdgh25nc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESxEote24XVqerhq5PuQzp3gosKmdSpVH5BDLzwk56sfBsSC0NBx9ZdwTyotNbKdDbR4swGl3mfMuHND47jdqHr89ENBIgFrZkBuB+u6i2y/Pq2e9lZVd3zo1Yloq++74VUJ9af2D1kU8ShLE+XGlOzHj0DcSezX9AjVoSkVQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XEFHiV93; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58495QVJ2978623;
	Thu, 4 Sep 2025 04:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756976726;
	bh=gxzy7uwdX7Ek0PQkPPdMgH4YMmHeib9QbVidr/oqQjs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XEFHiV93E26A/sdAT0hiWrNOMYt3uAUFdYMzs2lcK2nJkDzoYghXXxJpUv1/FXzTh
	 vwghCj+4DCwWiG4XMVcQLgI3PQe3oJ7bDEjWYlGEfRRwthxW6zWqIBaqmSBTohAIis
	 WiAcrs1WUH8hKV0ZWz5H6yP0/XylwCNrwEwBtfgg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58495Pgc3699330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 04:05:25 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 04:05:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 04:05:24 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58495Ncv3019525;
	Thu, 4 Sep 2025 04:05:24 -0500
Date: Thu, 4 Sep 2025 14:35:23 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vishal Mahaveer
	<vishalm@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebin Francis
	<sebin.francis@ti.com>,
        Kendall Willis <k-willis@ti.com>, Akashdeep Kaur
	<a-kaur@ti.com>,
        Simon Horman <horms@kernel.org>,
        Vincent MAILHOL
	<mailhol.vincent@wanadoo.fr>,
        <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 4/4] can: m_can: Support pinctrl wakeup state
Message-ID: <20250904090523.4zglietnh3fvbhnr@lcpd911>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
 <20250820-topic-mcan-wakeup-source-v6-12-v9-4-0ac13f2ddd67@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-4-0ac13f2ddd67@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Aug 20, 2025 at 14:42:28 +0200, Markus Schneider-Pargmann wrote:
> am62 requires a wakeup flag being set in pinctrl when mcan pins acts as

Let's call it "TI AM62x SoC" or TI K3 SoCs? This commit goes into a driver so let's not assume
everyone knows what am62 means ;)

Also nit: s/"mcan pins acts"/"mcan pins act"/

> a wakeup source. Add support to select the wakeup state if WOL is
> enabled.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/net/can/m_can/m_can.c | 69 +++++++++++++++++++++++++++++++++++++++++--
>  drivers/net/can/m_can/m_can.h |  3 ++
>  2 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index e08fae5ddf5efa8345670dd50d50954ec5d52b29..a1fa4b2f6b6cc94e5e10259cca53bd931ab238c8 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2249,7 +2249,26 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>  		return ret;
>  	}
>  
> +	if (!IS_ERR_OR_NULL(cdev->pinctrl_state_wakeup)) {
> +		if (wol_enable)
> +			ret = pinctrl_select_state(cdev->pinctrl, cdev->pinctrl_state_wakeup);
> +		else
> +			ret = pinctrl_pm_select_default_state(cdev->dev);
> +
> +		if (ret) {
> +			netdev_err(cdev->net, "Failed to select pinctrl state %pE\n",
> +				   ERR_PTR(ret));
> +			goto err_wakeup_enable;
> +		}
> +	}
> +
>  	return 0;
> +
> +err_wakeup_enable:
> +	/* Revert wakeup enable */
> +	device_set_wakeup_enable(cdev->dev, !wol_enable);
> +
> +	return ret;
>  }
>  
>  static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
> @@ -2377,6 +2396,42 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
>  
> +static bool m_can_class_wakeup_pinctrl_enabled(struct m_can_classdev *class_dev)
> +{
> +	return device_may_wakeup(class_dev->dev) && class_dev->pinctrl_state_wakeup;
> +}
> +
> +static int m_can_class_setup_optional_pinctrl(struct m_can_classdev *class_dev)
> +{
> +	struct device *dev = class_dev->dev;
> +	int ret;
> +
> +	class_dev->pinctrl = devm_pinctrl_get(dev);
> +	if (IS_ERR(class_dev->pinctrl)) {
> +		ret = PTR_ERR(class_dev->pinctrl);
> +		class_dev->pinctrl = NULL;
> +
> +		if (ret == -ENODEV)
> +			return 0;
> +
> +		return dev_err_probe(dev, ret, "Failed to get pinctrl\n");
> +	}
> +
> +	class_dev->pinctrl_state_wakeup =
> +		pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
> +	if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
> +		ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
> +		class_dev->pinctrl_state_wakeup = NULL;
> +
> +		if (ret == -ENODEV)
> +			return 0;
> +
> +		return dev_err_probe(dev, ret, "Failed to lookup pinctrl wakeup state\n");
> +	}
> +
> +	return 0;
> +}
> +
>  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>  						int sizeof_priv)
>  {
> @@ -2418,7 +2473,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>  	m_can_of_parse_mram(class_dev, mram_config_vals);
>  	spin_lock_init(&class_dev->tx_handling_spinlock);
>  
> +	ret = m_can_class_setup_optional_pinctrl(class_dev);

optional makes it sound a little confusing IMO, might make sense to call
it something like m_can_class_configure_pinctrl or m_can_class_setup_wakeup_pinctrl

> +	if (ret)
> +		goto err_free_candev;
> +
>  	return class_dev;
> +
> +err_free_candev:
> +	free_candev(net_dev);
> +	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
>  
> @@ -2533,7 +2596,8 @@ int m_can_class_suspend(struct device *dev)
>  		m_can_clk_stop(cdev);
>  	}
>  
> -	pinctrl_pm_select_sleep_state(dev);
> +	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
> +		pinctrl_pm_select_sleep_state(dev);
>  
>  	cdev->can.state = CAN_STATE_SLEEPING;
>  
> @@ -2547,7 +2611,8 @@ int m_can_class_resume(struct device *dev)
>  	struct net_device *ndev = cdev->net;
>  	int ret = 0;
>  
> -	pinctrl_pm_select_default_state(dev);
> +	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
> +		pinctrl_pm_select_default_state(dev);
>  
>  	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
>  
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index bd4746c63af3f0a032910644dfd48a9ebb3a6168..583c7f1d005d61b3fc8587697388522993ff11a8 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -128,6 +128,9 @@ struct m_can_classdev {
>  	struct mram_cfg mcfg[MRAM_CFG_NUM];
>  
>  	struct hrtimer hrtimer;
> +
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_state_wakeup;
>  };
>  
>  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
> 
> -- 
> 2.50.1
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

