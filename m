Return-Path: <linux-can+bounces-7237-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G7uDsAiwmnsZgQAu9opvQ
	(envelope-from <linux-can+bounces-7237-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 06:36:00 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8B03024BB
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 06:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B34D303AA8F
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 05:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A00E28751B;
	Tue, 24 Mar 2026 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXaJpoSs"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DE239E7E;
	Tue, 24 Mar 2026 05:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774330557; cv=none; b=EAXm53MpxTGvnZUe8vocHcnWKvi+J3PM17Qe9EuV5P8LVBOFQckStLpFjwxBGSx5UZW7Q2VzGqHLxwJr6Fgthot5w3rdT+14igjKFm1udR/NKTMsoH4/0JjwExRk7HCC2GFaLCvwvujehj4DdARHDZ+L6SsaSFkxEX2y/wNpGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774330557; c=relaxed/simple;
	bh=FTpPg6VqMYGsOflNx1bNpFbE/kW6TknZdoyLgHvfExU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DozKvKPYrhmQRL+td0wETOHDyNdITdZpNM13OBTPTd5DHBSoS8GqJzkmljNaHa8y5SBj6SP9NGlaztn/l7zB+BIxgiIRCwT5IZ8Db7lAowj4QI6TAT4PG2katj/4sP+rBu8A/yJt4NtOmxCDYVhvFa2yF8zesBBJdgTdHgBVlAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXaJpoSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA62C19424;
	Tue, 24 Mar 2026 05:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774330556;
	bh=FTpPg6VqMYGsOflNx1bNpFbE/kW6TknZdoyLgHvfExU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXaJpoSsx5dP06H/YYjIquuOqxKTP5jBgRkct2VvUZKytVQoYViVd/TVDsg/eLQyR
	 CKNIdJn0uAb8B3OFdzKkBw692ed56Zqk9xc2PEjGl4Cm6WyTnVjwAjlU9lFeCz2xhr
	 SH2mSPayi8nJjjhAWR7AEQfr4o7KjxQja8xNcMyV0xPasE4vsqW1doocp5pXs7fC+/
	 rMXkX94GNonF85gbrdGWC0roEi5w1oUeetIxXObb1AEDUZQX9PEVAmKL6ThuI2a9u3
	 afb5WaiceqoY2J2Gnzlj+a1V440r0Jdg2FI8B+mQp5ZLRcXnbF+vNN9Bdgb4REC6wO
	 /jdyJQPIo/jtg==
Date: Tue, 24 Mar 2026 11:05:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v5 phy-next 08/27] PCI: Remove device links to PHY
Message-ID: <y7n3eiqvc5gv3ax7bn6sh3ikrvzpdc6hq7qfvebroqolrzcew6@7t7hs3eya5tm>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-9-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319223241.1351137-9-vladimir.oltean@nxp.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7237-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 8E8B03024BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:32:22AM +0200, Vladimir Oltean wrote:
> This is practically a full revert of commit
> 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> and a partial revert of the device link pieces from commits
> dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP drivers")
> 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
> 
> The trouble with these commits is that they dereference fields inside
> struct phy from a consumer driver, which will become no longer possible.
> 
> Since commit 987351e1ea77 ("phy: core: Add consumer device link
> support") from 2019, the PHY core also adds a device link to order PHY
> provider and consumer suspend/resume operations. All reverted commits
> are from 2017-2018, and what they do should actually be redundant now.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> v3->v5: none
> v2->v3:
> - remove dangling set but unused phy_count local variable in
>   cdns_plat_pcie_probe()
> v1->v2:
> - fully remove struct device link **link from struct cdns_pcie and from
>   cdns_plat_pcie_probe() error path
> - collect tag
> - adjust commit title
> ---
>  .../controller/cadence/pcie-cadence-plat.c    |  4 ---
>  drivers/pci/controller/cadence/pcie-cadence.c | 16 +---------
>  drivers/pci/controller/cadence/pcie-cadence.h |  2 --
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ----------
>  drivers/pci/controller/dwc/pci-keystone.c     | 31 +++----------------
>  5 files changed, 5 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index b067a3296dd3..fc39c01b7964 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  	struct pci_host_bridge *bridge;
>  	struct cdns_pcie_ep *ep;
>  	struct cdns_pcie_rc *rc;
> -	int phy_count;
>  	bool is_rc;
>  	int ret;
>  
> @@ -122,9 +121,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
> -	phy_count = cdns_plat_pcie->pcie->phy_count;
> -	while (phy_count--)
> -		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index a1eada56edba..0ac980249941 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -222,7 +222,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  	struct device_node *np = dev->of_node;
>  	int phy_count;
>  	struct phy **phy;
> -	struct device_link **link;
>  	int i;
>  	int ret;
>  	const char *name;
> @@ -238,10 +237,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  	if (!phy)
>  		return -ENOMEM;
>  
> -	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
> -	if (!link)
> -		return -ENOMEM;
> -
>  	for (i = 0; i < phy_count; i++) {
>  		of_property_read_string_index(np, "phy-names", i, &name);
>  		phy[i] = devm_phy_get(dev, name);
> @@ -249,17 +244,10 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  			ret = PTR_ERR(phy[i]);
>  			goto err_phy;
>  		}
> -		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> -		if (!link[i]) {
> -			devm_phy_put(dev, phy[i]);
> -			ret = -EINVAL;
> -			goto err_phy;
> -		}
>  	}
>  
>  	pcie->phy_count = phy_count;
>  	pcie->phy = phy;
> -	pcie->link = link;
>  
>  	ret =  cdns_pcie_enable_phy(pcie);
>  	if (ret)
> @@ -268,10 +256,8 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  	return 0;
>  
>  err_phy:
> -	while (--i >= 0) {
> -		device_link_del(link[i]);
> +	while (--i >= 0)
>  		devm_phy_put(dev, phy[i]);
> -	}
>  
>  	return ret;
>  }
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 443033c607d7..35b0b33bc6fb 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -82,7 +82,6 @@ struct cdns_plat_pcie_of_data {
>   * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
>   * @phy_count: number of supported PHY devices
>   * @phy: list of pointers to specific PHY control blocks
> - * @link: list of pointers to corresponding device link representations
>   * @ops: Platform-specific ops to control various inputs from Cadence PCIe
>   *       wrapper
>   * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
> @@ -95,7 +94,6 @@ struct cdns_pcie {
>  	bool			             is_rc;
>  	int			             phy_count;
>  	struct phy		             **phy;
> -	struct device_link	             **link;
>  	const  struct cdns_pcie_ops          *ops;
>  	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
>  };
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index d5d26229063f..b91ab37845c9 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -9,7 +9,6 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -683,7 +682,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  	int i;
>  	int phy_count;
>  	struct phy **phy;
> -	struct device_link **link;
>  	void __iomem *base;
>  	struct dw_pcie *pci;
>  	struct dra7xx_pcie *dra7xx;
> @@ -731,10 +729,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  	if (!phy)
>  		return -ENOMEM;
>  
> -	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
> -	if (!link)
> -		return -ENOMEM;
> -
>  	dra7xx->clk = devm_clk_get_optional(dev, NULL);
>  	if (IS_ERR(dra7xx->clk))
>  		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
> @@ -749,12 +743,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  		phy[i] = devm_phy_get(dev, name);
>  		if (IS_ERR(phy[i]))
>  			return PTR_ERR(phy[i]);
> -
> -		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> -		if (!link[i]) {
> -			ret = -EINVAL;
> -			goto err_link;
> -		}
>  	}
>  
>  	dra7xx->base = base;
> @@ -856,10 +844,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  	pm_runtime_disable(dev);
>  	dra7xx_pcie_disable_phy(dra7xx);
>  
> -err_link:
> -	while (--i >= 0)
> -		device_link_del(link[i]);
> -
>  	return ret;
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 642e4c45eefc..07698c645e02 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -130,7 +130,6 @@ struct keystone_pcie {
>  	int			num_lanes;
>  	u32			num_viewport;
>  	struct phy		**phy;
> -	struct device_link	**link;
>  	struct			device_node *msi_intc_np;
>  	struct irq_domain	*intx_irq_domain;
>  	struct device_node	*np;
> @@ -1118,7 +1117,6 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  	enum dw_pcie_device_mode mode;
>  	struct dw_pcie *pci;
>  	struct keystone_pcie *ks_pcie;
> -	struct device_link **link;
>  	struct gpio_desc *gpiod;
>  	struct resource *res;
>  	void __iomem *base;
> @@ -1189,31 +1187,17 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  	if (!phy)
>  		return -ENOMEM;
>  
> -	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
> -	if (!link)
> -		return -ENOMEM;
> -
>  	for (i = 0; i < num_lanes; i++) {
>  		snprintf(name, sizeof(name), "pcie-phy%d", i);
>  		phy[i] = devm_phy_optional_get(dev, name);
>  		if (IS_ERR(phy[i])) {
>  			ret = PTR_ERR(phy[i]);
> -			goto err_link;
> -		}
> -
> -		if (!phy[i])
> -			continue;
> -
> -		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> -		if (!link[i]) {
> -			ret = -EINVAL;
> -			goto err_link;
> +			goto err;
>  		}
>  	}
>  
>  	ks_pcie->np = np;
>  	ks_pcie->pci = pci;
> -	ks_pcie->link = link;
>  	ks_pcie->num_lanes = num_lanes;
>  	ks_pcie->phy = phy;
>  
> @@ -1223,7 +1207,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(gpiod);
>  		if (ret != -EPROBE_DEFER)
>  			dev_err(dev, "Failed to get reset GPIO\n");
> -		goto err_link;
> +		goto err;
>  	}
>  
>  	/* Obtain references to the PHYs */
> @@ -1238,7 +1222,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  
>  	if (ret) {
>  		dev_err(dev, "failed to enable phy\n");
> -		goto err_link;
> +		goto err;
>  	}
>  
>  	platform_set_drvdata(pdev, ks_pcie);
> @@ -1325,25 +1309,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);
>  
> -err_link:
> -	while (--i >= 0 && link[i])
> -		device_link_del(link[i]);
> -
> +err:
>  	return ret;
>  }
>  
>  static void ks_pcie_remove(struct platform_device *pdev)
>  {
>  	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> -	struct device_link **link = ks_pcie->link;
> -	int num_lanes = ks_pcie->num_lanes;
>  	struct device *dev = &pdev->dev;
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);
> -	while (num_lanes--)
> -		device_link_del(link[num_lanes]);
>  }
>  
>  static struct platform_driver ks_pcie_driver = {
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

