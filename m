Return-Path: <linux-can+bounces-4593-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4926FB505AC
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 20:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C81441DD6
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA79D30215B;
	Tue,  9 Sep 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VdC3/bFk"
X-Original-To: linux-can@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBEC1DC994;
	Tue,  9 Sep 2025 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444288; cv=none; b=KjHlY6OL5vnLJq921tsD3Pdi2BY3PHcUxik0HtLwH1L0bAD1NgAydgpUWxFYYrGZMmcO54lUJ9HRfmqggzPNfYTPiTIiC5zfAQgkcPx/YIOzLKWrP0RK1f91j/X8lwhyqU/1hLAmzG496GJuqZnrVHnn+zx3RQTVcy6iMZsD6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444288; c=relaxed/simple;
	bh=vpCVeBskAneFYTPmHPDRUM94rGrQFjr5iXyund9widk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FwTPPNazfLeIwNxc+BTukha49AqHw8fOHDMopMtZwq46QaHL4ZmkoRfsFLwyvbNizffYm3hv2VWL/pcbTNAGFtepSaIYP6Tfe8ZGanoKAUozAIrT9DzWh/QI9/9/xxYs809gESpO1Fal0Of7lint963GlNp8L6xfPxmUsGd/shw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VdC3/bFk; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589IvuPk402841;
	Tue, 9 Sep 2025 13:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757444276;
	bh=ytWS5Pm3i5Hzdw1rnIsUCp2dtf9prOUQfRQPEmBioM4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VdC3/bFkMDTyMBaCrMGWwRudnc9/B45o8GH7SG+Zc7hm2KazM+RjGNx/LdI2kjBaj
	 ou4sLlRXEWVKtau98/7KCc384Zc4DM3k7PHr/KqYPm8v23iBHMPz481AaGB0WtM4Qi
	 M/aqyo0IlR8zk2E23Ho9ljA2NHlI+q41z2ENsaJ8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589Ivun13355508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 13:57:56 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 13:57:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Sep 2025 13:57:56 -0500
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589IvtR43042598;
	Tue, 9 Sep 2025 13:57:56 -0500
Message-ID: <ad567aed-3b8b-4ed4-bfee-e072a514558f@ti.com>
Date: Tue, 9 Sep 2025 13:57:55 -0500
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] can: m_can: Support pinctrl wakeup state
To: Dhruva Gole <d-gole@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vishal Mahaveer
	<vishalm@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebin Francis
	<sebin.francis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
        Simon Horman
	<horms@kernel.org>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
 <20250820-topic-mcan-wakeup-source-v6-12-v9-4-0ac13f2ddd67@baylibre.com>
 <20250904090523.4zglietnh3fvbhnr@lcpd911>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20250904090523.4zglietnh3fvbhnr@lcpd911>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/4/25 04:05, Dhruva Gole wrote:
> On Aug 20, 2025 at 14:42:28 +0200, Markus Schneider-Pargmann wrote:
>> am62 requires a wakeup flag being set in pinctrl when mcan pins acts as
> 
> Let's call it "TI AM62x SoC" or TI K3 SoCs? This commit goes into a driver so let's not assume
> everyone knows what am62 means ;)
> 
> Also nit: s/"mcan pins acts"/"mcan pins act"/
> 
>> a wakeup source. Add support to select the wakeup state if WOL is
>> enabled.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>   drivers/net/can/m_can/m_can.c | 69 +++++++++++++++++++++++++++++++++++++++++--
>>   drivers/net/can/m_can/m_can.h |  3 ++
>>   2 files changed, 70 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>> index e08fae5ddf5efa8345670dd50d50954ec5d52b29..a1fa4b2f6b6cc94e5e10259cca53bd931ab238c8 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -2249,7 +2249,26 @@ static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>>   		return ret;
>>   	}
>>   
>> +	if (!IS_ERR_OR_NULL(cdev->pinctrl_state_wakeup)) {
>> +		if (wol_enable)
>> +			ret = pinctrl_select_state(cdev->pinctrl, cdev->pinctrl_state_wakeup);
>> +		else
>> +			ret = pinctrl_pm_select_default_state(cdev->dev);
>> +
>> +		if (ret) {
>> +			netdev_err(cdev->net, "Failed to select pinctrl state %pE\n",
>> +				   ERR_PTR(ret));
>> +			goto err_wakeup_enable;
>> +		}
>> +	}
>> +
>>   	return 0;
>> +
>> +err_wakeup_enable:
>> +	/* Revert wakeup enable */
>> +	device_set_wakeup_enable(cdev->dev, !wol_enable);
>> +
>> +	return ret;
>>   }
>>   
>>   static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
>> @@ -2377,6 +2396,42 @@ int m_can_class_get_clocks(struct m_can_classdev *cdev)
>>   }
>>   EXPORT_SYMBOL_GPL(m_can_class_get_clocks);
>>   
>> +static bool m_can_class_wakeup_pinctrl_enabled(struct m_can_classdev *class_dev)
>> +{
>> +	return device_may_wakeup(class_dev->dev) && class_dev->pinctrl_state_wakeup;
>> +}
>> +
>> +static int m_can_class_setup_optional_pinctrl(struct m_can_classdev *class_dev)
>> +{
>> +	struct device *dev = class_dev->dev;
>> +	int ret;
>> +
>> +	class_dev->pinctrl = devm_pinctrl_get(dev);
>> +	if (IS_ERR(class_dev->pinctrl)) {
>> +		ret = PTR_ERR(class_dev->pinctrl);
>> +		class_dev->pinctrl = NULL;
>> +
>> +		if (ret == -ENODEV)
>> +			return 0;
>> +
>> +		return dev_err_probe(dev, ret, "Failed to get pinctrl\n");
>> +	}
>> +
>> +	class_dev->pinctrl_state_wakeup =
>> +		pinctrl_lookup_state(class_dev->pinctrl, "wakeup");
>> +	if (IS_ERR(class_dev->pinctrl_state_wakeup)) {
>> +		ret = PTR_ERR(class_dev->pinctrl_state_wakeup);
>> +		class_dev->pinctrl_state_wakeup = NULL;
>> +
>> +		if (ret == -ENODEV)
>> +			return 0;
>> +
>> +		return dev_err_probe(dev, ret, "Failed to lookup pinctrl wakeup state\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>>   						int sizeof_priv)
>>   {
>> @@ -2418,7 +2473,15 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
>>   	m_can_of_parse_mram(class_dev, mram_config_vals);
>>   	spin_lock_init(&class_dev->tx_handling_spinlock);
>>   
>> +	ret = m_can_class_setup_optional_pinctrl(class_dev);
> 
> optional makes it sound a little confusing IMO, might make sense to call
> it something like m_can_class_configure_pinctrl or m_can_class_setup_wakeup_pinctrl

I agree it should be changed to something different. Maybe you could add 
a comment or add in the commit message denoting that configuring the 
pinctrl is optional?

> 
>> +	if (ret)
>> +		goto err_free_candev;
>> +
>>   	return class_dev;
>> +
>> +err_free_candev:
>> +	free_candev(net_dev);
>> +	return ERR_PTR(ret);
>>   }
>>   EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
>>   
>> @@ -2533,7 +2596,8 @@ int m_can_class_suspend(struct device *dev)
>>   		m_can_clk_stop(cdev);
>>   	}
>>   
>> -	pinctrl_pm_select_sleep_state(dev);
>> +	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
>> +		pinctrl_pm_select_sleep_state(dev);
>>   
>>   	cdev->can.state = CAN_STATE_SLEEPING;
>>   
>> @@ -2547,7 +2611,8 @@ int m_can_class_resume(struct device *dev)
>>   	struct net_device *ndev = cdev->net;
>>   	int ret = 0;
>>   
>> -	pinctrl_pm_select_default_state(dev);
>> +	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
>> +		pinctrl_pm_select_default_state(dev);
>>   
>>   	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
>>   
>> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
>> index bd4746c63af3f0a032910644dfd48a9ebb3a6168..583c7f1d005d61b3fc8587697388522993ff11a8 100644
>> --- a/drivers/net/can/m_can/m_can.h
>> +++ b/drivers/net/can/m_can/m_can.h
>> @@ -128,6 +128,9 @@ struct m_can_classdev {
>>   	struct mram_cfg mcfg[MRAM_CFG_NUM];
>>   
>>   	struct hrtimer hrtimer;
>> +
>> +	struct pinctrl *pinctrl;
>> +	struct pinctrl_state *pinctrl_state_wakeup;
>>   };
>>   
>>   struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
>>
>> -- 
>> 2.50.1
>>
> 


