Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20EB259E07
	for <lists+linux-can@lfdr.de>; Tue,  1 Sep 2020 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgIASWT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Sep 2020 14:22:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44094 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIASWP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2020 14:22:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081IM5G0130249;
        Tue, 1 Sep 2020 13:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598984525;
        bh=5iiSDwyBAES4fNtRtnaMiUGXfADtjxWW5GGvEMbQZh8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Nj9BA2fJInbnf9cfJQ3KHlmAJrqjUO/s5iLQMnF6SYS5PAFa118cMe7aMX0019moI
         N4QMqVjc/4vE+3xsj3jyRLPIHrOMs/ybWre126XOYqQ2r3xbe1T+xEzdOea/jgeDic
         NrLGM+X8cnxHp0LcNc8+dSJMqVSGML/vQkcgCczk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 081IM4rv078755
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 13:22:05 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 13:22:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 13:22:04 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081IM4mf063959;
        Tue, 1 Sep 2020 13:22:04 -0500
Subject: Re: [PATCH 1/1] NET: mcan: Move runtime PM enable/disable to
 m_can_platform
To:     Patrik Flykt <patrik.flykt@linux.intel.com>,
        <linux-can@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>,
        <sriram.dash@samsung.com>, <jarkko.nikula@intel.com>
References: <20200825101736.158578-1-patrik.flykt@linux.intel.com>
 <20200825101736.158578-2-patrik.flykt@linux.intel.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <fa0a6baa-99b0-8ddd-69cd-07c267419bbb@ti.com>
Date:   Tue, 1 Sep 2020 13:22:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825101736.158578-2-patrik.flykt@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Patrik

On 8/25/20 5:17 AM, Patrik Flykt wrote:
> This is a preparatory patch for upcoming PCI based M_CAN devices.
> The current PM implementation would cause PCI based drivers to
> enable PM twice, once when the pci device is added and a second
> time in m_can_class_register(). This will cause 'Unbalanced
> pm_runtime_enable!' to be logged, and is a situation that should
> be avoided.
>
> Therefore, in anticipation of PCI devices, move PM enabling out
> from M_CAN class registration to its currently only user, the
> m_can_platform driver.
>
>
> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> ---
>   drivers/net/can/m_can/m_can.c          | 6 +-----
>   drivers/net/can/m_can/m_can_platform.c | 3 +++
>   2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 02c5795b7393..2c4d74113443 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1817,7 +1817,6 @@ int m_can_class_register(struct m_can_classdev *m_can_dev)
>   	int ret;
>   
>   	if (m_can_dev->pm_clock_support) {
> -		pm_runtime_enable(m_can_dev->dev);
>   		ret = m_can_clk_start(m_can_dev);
>   		if (ret)
>   			goto pm_runtime_fail;
> @@ -1847,11 +1846,8 @@ int m_can_class_register(struct m_can_classdev *m_can_dev)
>   clk_disable:
>   	m_can_clk_stop(m_can_dev);
>   pm_runtime_fail:
> -	if (ret) {
> -		if (m_can_dev->pm_clock_support)
> -			pm_runtime_disable(m_can_dev->dev);
> +	if (ret)
>   		free_candev(m_can_dev->net);
> -	}
>   
>   	return ret;
>   }
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index 38ea5e600fb8..1260e99b9322 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -111,7 +111,10 @@ static int m_can_plat_probe(struct platform_device *pdev)
>   
>   	m_can_init_ram(mcan_class);
>   
> +	pm_runtime_enable(mcan_class->dev);
>   	ret = m_can_class_register(mcan_class);
> +	if (ret)
> +		pm_runtime_disable(mcan_class->dev);
>   
>   failed_ret:
>   	return ret;
Reviewed-by: Dan Murphy <dmurphy@ti.com>
