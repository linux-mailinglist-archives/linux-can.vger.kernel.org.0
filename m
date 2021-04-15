Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC08360D80
	for <lists+linux-can@lfdr.de>; Thu, 15 Apr 2021 17:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhDOPDK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Apr 2021 11:03:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37698 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbhDOPBE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Apr 2021 11:01:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13FF0WgP101805;
        Thu, 15 Apr 2021 10:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618498832;
        bh=pKl9USW4Lb4q2lT4TkJijaFrzIIfUx2rrVu/7hEAIwg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IpcH/Wot0NJFgpovlSvrAMOg9Odk3OJmWmyBfGoQON3QRTjAuRndajqjOAcqBIa9t
         ko7d9o0ZcL8vL4ULPPKHYFwWKfAMWBhEJMCvWLw77cE7N6e/zK92l+nYaLg7dFHju3
         e1c12kCm/1KgPXQx5HsZPyWv4AzygpmoMr+kZrxc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13FF0W7k105205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Apr 2021 10:00:32 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Apr 2021 10:00:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 15 Apr 2021 10:00:31 -0500
Received: from [10.250.233.30] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13FF0RlR061690;
        Thu, 15 Apr 2021 10:00:28 -0500
Subject: Re: [PATCH v3 2/4] phy: Add API for devm_of_phy_optional_get_by_index
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-can@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20210415144947.4725-1-a-govindraju@ti.com>
 <20210415144947.4725-3-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c3baf0bc-e166-4aee-f4c7-e5915352ec82@ti.com>
Date:   Thu, 15 Apr 2021 20:30:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415144947.4725-3-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Aswath,

On 15/04/21 8:19 pm, Aswath Govindraju wrote:
> Add API for devm_of_phy_optional_get_by_index, to obtain a reference to an
> optional phy by index.

Rob has posted a patch
http://lore.kernel.org/r/20210414135525.3535787-1-robh@kernel.org
that doesn't require consumers to get a phy by using string. Since your
usecase also requires only one PHY, that patch should be sufficient.
$patch could be deferred until a real use case comes.

Thanks
Kishon

> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/phy/phy-core.c  | 26 ++++++++++++++++++++++++++
>  include/linux/phy/phy.h |  2 ++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index ccb575b13777..bf06d4e0ede2 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -839,6 +839,32 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
>  }
>  EXPORT_SYMBOL_GPL(devm_of_phy_get);
>  
> +/**
> + * devm_of_phy_optional_get_by_index() - lookup and obtain a reference to an optional phy by index.
> + * @dev: device that requests this phy
> + * @np: node containing the phy
> + * @index: index of the phy
> + *
> + * Gets the phy using _of_phy_get(), then gets a refcount to it,
> + * and associates a device with it using devres. On driver detach,
> + * release function is invoked on the devres data, then,
> + * devres data is freed. This differs to devm_of_phy_get_by_index() in
> + * that if the phy does not exist, it is not considered an error and
> + * -ENODEV will not be returned. Instead the NULL phy is returned,
> + * which can be passed to all other phy consumer calls.
> + */
> +struct phy *devm_of_phy_optional_get_by_index(struct device *dev, struct device_node *np,
> +					      int index)
> +{
> +	struct phy *phy = devm_of_phy_get_by_index(dev, np, index);
> +
> +	if (PTR_ERR(phy) == -ENODEV)
> +		phy = NULL;
> +
> +	return phy;
> +}
> +EXPORT_SYMBOL_GPL(devm_of_phy_optional_get_by_index);
> +
>  /**
>   * devm_of_phy_get_by_index() - lookup and obtain a reference to a phy by index.
>   * @dev: device that requests this phy
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index f3286f4cd306..c5f32b4fadd6 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -253,6 +253,8 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
>  			    const char *con_id);
>  struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
>  				     int index);
> +struct phy *devm_of_phy_optional_get_by_index(struct device *dev, struct device_node *np,
> +					      int index);
>  void of_phy_put(struct phy *phy);
>  void phy_put(struct device *dev, struct phy *phy);
>  void devm_phy_put(struct device *dev, struct phy *phy);
> 
